# Knowledge check

## Part 1

1. In the view below, what informs the connection is optimized?

2. In the view below, what informs the connection is encrypted over the WAN?

3. Calculate the approximate speed for the SMB file transfers, cold and warm. How do they compare to the previous non optimized transfer? Take some time to experiment

![lab1-image](/assets/lab1-image.png)

> Hint: hovering icons in your Current Connections screen can answer both Parts...

---

## Part 2

![lab1-image3](/assets/lab1-image3.png)

1. What was the peak LAN throughput in your timescale for HTTPS traffic?

2. What was it for HTTP and SMB?

3. Why would the optimization effects differ on a "cold pass" of one type of data/traffic versus another?

---

## Part 3

![lab1-image2](/assets/lab1-image2.png)

Note the scale on the Y axis of the chart is automatically adjusted to suit. Hover the mouse over the plot area to display the Data Reduction for various points on the timeline. Note that the LAN Throughput should be greater than WAN Throughput to imply optimization occurring and reducing the amount of throughput on the WAN.

1. What was the peak LAN throughput?

2. When did it happen?

3. What protocol was it?

4. What was the total amount of data that was removed from the WAN during your time period?

---

You have successfully created optimized traffic in an in-path deployment, and should understand the nature of cold and warm file transfers. Ideally you noticed significant improvement in transfer times, even with file modifications.

Useful add-on: SDR is protocol agnostic, so the warm transfer of a byte stream in one application will be equally optimized should that byte stream occur in a different applications. As an example, downloading a file from the datacenter via a file share, then sending the file via email; your local and datacenter SteelHeads will see the file 'cold' when downloading, then 'warm' when that same file is attached to an email.

Finally, you verified various optimization statistics in different Reports. Good to note that bandwidth reduction/optimization is enabled by default for all TCP ports not explicitly passed through. Once your SteelHead appliance is plugged in and configured with the initial network settings, you can begin optimizing traffic and notice significant performance increase, with accompanying WAN data reduction.
