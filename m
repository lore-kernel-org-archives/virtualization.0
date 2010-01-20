From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio-spec: Update the spec for recent virtio-console changes
Date: Wed, 20 Jan 2010 19:31:13 +0530
Message-ID: <20100120140113.GH27165@amit-x200.redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The virtio-console device has recently been updated to support multiple
devices and multiple ports. These ports can also function as generic
serial ports. Reflect these changes in the spec.

Signed-off-by: Amit Shah <amit.shah@redhat.com>


--- virtio-spec/virtio-spec-0.8.3.lyx.orig	2010-01-20 19:21:02.239131766 +0530
+++ virtio-spec/virtio-spec-0.8.3.lyx	2010-01-20 19:21:02.228131971 +0530
@@ -1,4 +1,4 @@
-#LyX 1.6.4 created this file. For more info see http://www.lyx.org/
+#LyX 1.6.5 created this file. For more info see http://www.lyx.org/
 \lyxformat 345
 \begin_document
 \begin_header
@@ -36,7 +36,7 @@
 \paperpagestyle default
 \tracking_changes true
 \output_changes true
-\author "" 
+\author "Amit Shah" 
 \author "" 
 \end_header
 
@@ -4371,9 +4371,33 @@
 \end_layout
 
 \begin_layout Standard
-The virtio console device is a simple device for text input and output.
- One or more empty buffers are placed in the receive queue for incoming
- keystrokes, and outgoing characters are placed in the transmit queue.
+The virtio console device is a simple device for 
+\change_inserted 0 1262777844
+data
+\change_deleted 0 1262777844
+text
+\change_unchanged
+ input and output.
+ 
+\change_inserted 0 1263990903
+A device may have one or more ports.
+ Each port has a pair of input and output virtqueues.
+ Moreover, a device has a pair of control IO virtqueues.
+ The control virtqueues are used to communicate information between the
+ device and the driver about ports being opened and closed on either side
+ of the connection, indication from the host about whether a particular
+ port is a console port, port hotunplug, etc.
+ For data IO, o
+\change_deleted 0 1263990904
+O
+\change_unchanged
+ne or more empty buffers are placed in the receive queue for incoming 
+\change_inserted 0 1263965568
+data
+\change_deleted 0 1263990911
+keystrokes,
+\change_unchanged
+ and outgoing characters are placed in the transmit queue.
 \end_layout
 
 \begin_layout Section*
@@ -4393,8 +4417,19 @@
 \end_layout
 
 \begin_layout Description
-Virtqueues 0:receiveq.
- 1:transmitq.
+Virtqueues 0:receiveq
+\change_inserted 0 1263965615
+(port0)
+\change_unchanged
+.
+ 1:transmitq
+\change_inserted 0 1263965633
+(port0), 2:control receiveq, 3:control transmitq, 4:receiveq(port1), 5:transmitq
+(port1), ...
+\change_deleted 0 1263965580
+.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Description
@@ -4412,6 +4447,18 @@
 \end_inset
 
 (0) Configuration cols and rows fields are valid.
+\change_inserted 0 1263965646
+
+\end_layout
+
+\begin_layout Description
+
+\change_inserted 0 1263990941
+VIRTIO_CONSOLE_F_MULTIPORT(1) Device has support for multiple ports; configurati
+on fields nr_ports and max_nr_ports are valid and control virtqueues will
+ be used.
+\change_unchanged
+
 \end_layout
 
 \end_deeper
@@ -4425,7 +4472,16 @@
 \end_inset
 
 layout The size of the console is supplied in the configuration space if
- the VIRTIO_CONSOLE_F_SIZE feature is set:
+ the VIRTIO_CONSOLE_F_SIZE feature is set
+\change_inserted 0 1263965899
+.
+ Furthermore, if the VIRTIO_CONSOLE_F_MULTIPORT feature is set, the maximum
+ number of ports supported by the device and the number of ports currently
+ active can be fetched.
+\change_deleted 0 1263965839
+:
+\change_unchanged
+
 \begin_inset listings
 inline false
 status open
@@ -4443,6 +4499,30 @@
 \begin_layout Plain Layout
 
 	u16 rows;
+\change_inserted 0 1263965922
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263965904
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263965912
+
+	u32 max_nr_ports;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263965914
+
+	u32 nr_ports;
+\change_unchanged
+
 \end_layout
 
 \begin_layout Plain Layout
@@ -4462,10 +4542,32 @@
 \begin_layout Enumerate
 If the VIRTIO_CONSOLE_F_SIZE feature is negotiated, the driver can read
  the console dimensions from the configuration fields.
+\change_inserted 0 1263965931
+
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1263991285
+If the VIRTIO_CONSOLE_F_MULTIPORT feature is negotiated, the driver can
+ spawn multiple ports, not all of which may be attached to a console.
+ Some could be generic ports.
+ In this case, the control virtqueues are enabled and according to the nr_ports
+ configuration-space value, the appropriate number of ports and corresponding
+ virtqueues are spawned.
+ After creating and initializing each port, a VIRTIO_CONSOLE_PORT_READY
+ control message is sent to the host for that port so the host can let us
+ know of any additional configuration options set for that port.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Enumerate
-The receiveq is populated with one or more receive buffers.
+The receiveq 
+\change_inserted 0 1263966035
+for each port 
+\change_unchanged
+is populated with one or more receive buffers.
 \end_layout
 
 \begin_layout Section*
@@ -4473,8 +4575,15 @@
 \end_layout
 
 \begin_layout Enumerate
-For console output, a buffer containing the characters is placed in the
- transmitq.
+For 
+\change_deleted 0 1263966990
+console 
+\change_unchanged
+output, a buffer containing the characters is placed in the 
+\change_inserted 0 1263966995
+port's 
+\change_unchanged
+transmitq.
 \begin_inset Foot
 status collapsed
 
@@ -4490,14 +4599,141 @@
 \end_layout
 
 \begin_layout Enumerate
-When a buffer is used in the receiveq, the contents is the input to the
- console.
+When a buffer is used in the receiveq
+\change_inserted 0 1263967036
+ (signalled by an interrupt)
+\change_unchanged
+, the contents is the input to the 
+\change_deleted 0 1263967042
+console.
+\change_inserted 0 1263967164
+port associated with the virtqueue for which the notification was received.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Enumerate
 If the driver negotiated the VIRTIO_CONSOLE_F_SIZE feature, a configuration
  change interrupt may occur.
  The updated size can be read from the configuration fields.
+\change_inserted 0 1263966908
+
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1263967171
+If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT feature, a configuration
+ change interrupt may occur that bumps up the value of nr_ports.
+ In this case, ports are hot-added.
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1263991858
+Changes to ports' state are effected by control messages.
+ Appropriate action is taken on the port indicated in the control message.
+ The layout of the structure of the control buffer and the events associated
+ are:
+\begin_inset listings
+inline false
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+struct virtio_console_control {
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991937
+
+	uint32_t id;    /* Port number */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991940
+
+	uint16_t event; /* The kind of control event */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991943
+
+	uint16_t value; /* Extra information for the event */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+};
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+/* Some events for the internal messages (control packets) */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+#define VIRTIO_CONSOLE_PORT_READY       0
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+#define VIRTIO_CONSOLE_CONSOLE_PORT     1
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+#define VIRTIO_CONSOLE_RESIZE           2
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+#define VIRTIO_CONSOLE_PORT_OPEN        3
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+#define VIRTIO_CONSOLE_PORT_NAME        4
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1263991870
+
+#define VIRTIO_CONSOLE_PORT_REMOVE      5
+\change_unchanged
+
+\end_layout
+
+\end_inset
+
+
 \end_layout
 
 \begin_layout Chapter*
