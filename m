From: Amit Shah <amit.shah@redhat.com>
Subject: Update virtio spec with new virtio console ABI information
Date: Fri, 16 Apr 2010 12:44:48 +0530
Message-ID: <20100416071448.GC21268@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

This patch updates the virtio spec (0.8.6) with the new ABI information
for virtio-console.

Please apply.


--- virtio-spec-0.8.6.lyx	2010-04-16 12:06:13.416075709 +0530
+++ virtio-spec-0.8.6-virtio-console.lyx	2010-04-16 12:41:54.656201703 +0530
@@ -36,7 +36,7 @@
 \paperpagestyle default
 \tracking_changes true
 \output_changes false
-\author "" 
+\author "Amit Shah" 
 \author "" 
 \end_header
 
@@ -4676,7 +4676,20 @@
  The control virtqueues are used to communicate information between the
  device and the driver about ports being opened and closed on either side
  of the connection, indication from the host about whether a particular
- port is a console port, port hotunplug, etc.
+ port is a console port, 
+\change_inserted 0 1271399891
+adding new ports, 
+\change_unchanged
+port hot
+\change_inserted 0 1271399887
+-plug/
+\change_unchanged
+unplug, etc.
+\change_inserted 0 1271399946
+, and indication from the guest about whether a port or a device was successfull
+y added, port open/close, etc..
+
+\change_unchanged
  For data IO, one or more empty buffers are placed in the receive queue
  for incoming data and outgoing characters are placed in the transmit queue.
 \end_layout
@@ -4739,8 +4752,11 @@
 layout The size of the console is supplied in the configuration space if
  the VIRTIO_CONSOLE_F_SIZE feature is set.
  Furthermore, if the VIRTIO_CONSOLE_F_MULTIPORT feature is set, the maximum
- number of ports supported by the device and the number of ports currently
- active can be fetched.
+ number of ports supported by the device
+\change_deleted 0 1271400029
+ and the number of ports currently active
+\change_unchanged
+ can be fetched.
 \begin_inset listings
 inline false
 status open
@@ -4767,11 +4783,17 @@
 \begin_layout Plain Layout
 
 	u32 max_nr_ports;
+\change_deleted 0 1271399998
+
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 0 1271399993
+
 	u32 nr_ports;
+\change_unchanged
+
 \end_layout
 
 \begin_layout Plain Layout
@@ -4797,12 +4819,30 @@
 If the VIRTIO_CONSOLE_F_MULTIPORT feature is negotiated, the driver can
  spawn multiple ports, not all of which may be attached to a console.
  Some could be generic ports.
- In this case, the control virtqueues are enabled and according to the nr_ports
- configuration-space value, the appropriate number of ports and corresponding
- virtqueues are spawned.
- After creating and initializing each port, a VIRTIO_CONSOLE_PORT_READY
- control message is sent to the host for that port so the host can let us
- know of any additional configuration options set for that port.
+ In this case, the control virtqueues are enabled and according to the 
+\change_inserted 0 1271400055
+max_
+\change_unchanged
+nr_ports configuration-space value, the appropriate number of 
+\change_deleted 0 1271400070
+ports and corresponding 
+\change_unchanged
+virtqueues are 
+\change_deleted 0 1271400075
+spawned
+\change_inserted 0 1271400076
+created
+\change_unchanged
+.
+ 
+\change_inserted 0 1271400112
+A control message indicating the driver is ready is sent to the host.
+ The host can then send control messages for adding new ports to the device.
+ 
+\change_unchanged
+After creating and initializing each port, a VIRTIO_CONSOLE_PORT_READY control
+ message is sent to the host for that port so the host can let us know of
+ any additional configuration options set for that port.
 \end_layout
 
 \begin_layout Enumerate
@@ -4822,6 +4862,13 @@
 Because this is high importance and low bandwidth, the current Linux implementat
 ion polls for the buffer to be used, rather than waiting for an interrupt,
  simplifying the implementation significantly.
+
+\change_inserted 0 1271400345
+ However, for generic serial ports with the O_NONBLOCK flag set, the polling
+ limitation is relaxed and the consumed buffers are freed upon the next
+ write or poll call or when a port is closed or hot-unplugged.
+\change_unchanged
+
 \end_layout
 
 \end_inset
@@ -4839,12 +4886,32 @@
 If the driver negotiated the VIRTIO_CONSOLE_F_SIZE feature, a configuration
  change interrupt may occur.
  The updated size can be read from the configuration fields.
-\end_layout
-
-\begin_layout Enumerate
+\change_deleted 0 1271400359
 If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT feature, a configuration
  change interrupt may occur that bumps up the value of nr_ports.
  In this case, ports are hot-added.
+\change_inserted 0 1271400879
+
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1271401808
+If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT feature, active
+ ports are announced by the host using the VIRTIO_CONSOLE_PORT_ADD control
+ message.
+ The same message is used for port hot-plug as well.
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1271401905
+If the host specified a port 'name', a sysfs attribute is created with the
+ name filled in, so that udev rules can be written that can create a symlink
+ from the port's name to the char device for port discovery by applications
+ in the guest.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Enumerate
@@ -4892,32 +4959,102 @@
 
 \begin_layout Plain Layout
 
+\change_deleted 0 1271400377
+
 #define VIRTIO_CONSOLE_PORT_READY       0
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 0 1271400377
+
 #define VIRTIO_CONSOLE_CONSOLE_PORT     1
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 0 1271400377
+
 #define VIRTIO_CONSOLE_RESIZE           2
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 0 1271400377
+
 #define VIRTIO_CONSOLE_PORT_OPEN        3
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 0 1271400377
+
 #define VIRTIO_CONSOLE_PORT_NAME        4
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 0 1271400377
+
 #define VIRTIO_CONSOLE_PORT_REMOVE      5
+\change_inserted 0 1271400378
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400814
+
+#define VIRTIO_CONSOLE_DEVICE_READY     0
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400820
+
+#define VIRTIO_CONSOLE_PORT_ADD         1
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400823
+
+#define VIRTIO_CONSOLE_PORT_REMOVE      2
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400827
+
+#define VIRTIO_CONSOLE_PORT_READY       3
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400830
+
+#define VIRTIO_CONSOLE_CONSOLE_PORT     4
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400835
+
+#define VIRTIO_CONSOLE_RESIZE           5
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400839
+
+#define VIRTIO_CONSOLE_PORT_OPEN        6
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1271400842
+
+#define VIRTIO_CONSOLE_PORT_NAME        7
 \end_layout
 
 \end_inset
