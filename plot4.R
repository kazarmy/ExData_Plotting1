# Copyright (C) 2015 Khairul Azhar Kasmiran. All rights reserved.
#
# Standard disclaimer applies:
#
# THIS CODE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS CODE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# This code was produced using the facilities of Universiti Putra Malaysia,
# Malaysia.

# ------------------------------------------------------------------------------

###
# Generates plot4.png (the foursome) from household_power_consumption.txt.
###

# Load the needed data i.e. 1 Feb 2007 and 2 Feb 2007 only. Assumes that the
# whole dataset has been unzipped to household_power_consumption.txt in the
# working directory. Number of lines to read and skip have been determined by
# eyeballing line numbers in the Vim editor.
data <- read.table("household_power_consumption.txt", sep=";", na.strings="?",
                   header=FALSE, skip=66637, nrows=69517-66637,
                   col.names=c("Date", "Time", "Global_active_power",
                               "Global_reactive_power", "Voltage",
                               "Global_intensity", "Sub_metering_1",
                               "Sub_metering_2", "Sub_metering_3"))

# Convert the Date and Time variables to the POSIXlt R Date/Time class.
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Generate the plot.
png(file="plot4.png", width=480, height=480)
par(mfrow = c(2, 2))   # Fill row-by-row.
with(data, {
     # Upper-left subplot.
     plot(datetime, Global_active_power, type="l", xlab="",
                ylab="Global Active Power")

     # Upper-right subplot.
     plot(datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")

     # Lower-left subplot.
     plot(datetime, Sub_metering_1, type="l", col="black", xlab="",
          ylab="Energy sub metering")
     lines(datetime, Sub_metering_2, col="red")
     lines(datetime, Sub_metering_3, col="blue")
     legend("topright", col=c("black", "red", "blue"), lwd=1, bty="n", cex=0.9,
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

     # Lower-right subplot.
     plot(datetime, Global_reactive_power, type="l", xlab="datetime",
          ylab="Global_reactive_power")
})
dev.off()
