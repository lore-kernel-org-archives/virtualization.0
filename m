From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio-spec trivial fixes
Date: Tue, 5 Oct 2010 19:20:01 +0530
Message-ID: <20101005135001.GE8207@amit-laptop.redhat.com>
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
To: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

A few trivial fixes on top of virtio-spec-0.8.9 (patch -p0):

- grammatical errors
- mark '-' in 'avail->flags' as non-breakable hyphen
- add a footnote for console device to indicate queues 2 onwards are
  avl. if a feature was negotiated

		Amit


--- virtio-spec-0.8.9.lyx	2010-10-05 17:26:11.318836266 +0530
+++ virtio-spec-0.8.9-mod.lyx	2010-10-05 19:00:12.829710205 +0530
@@ -1,4 +1,4 @@
-#LyX 1.6.5 created this file. For more info see http://www.lyx.org/
+#LyX 1.6.7 created this file. For more info see http://www.lyx.org/
 \lyxformat 345
 \begin_document
 \begin_header
@@ -36,7 +36,8 @@
 \paperpagestyle default
 \tracking_changes true
 \output_changes true
-\author "Rusty Russell,,," 
+\author "" 
+\author "" 
 \author "" 
 \end_header
 
@@ -1784,6 +1785,9 @@
 \begin_layout Standard
 The number of descriptors in the table is specified by the Queue Size field
  for this virtqueue.
+\end_layout
+
+\begin_layout Subsection
 \begin_inset CommandInset label
 LatexCommand label
 name "sub:Indirect-Descriptors"
@@ -2076,8 +2080,8 @@
  and processing used buffers from the device.
  As an example, the virtio network device has two virtqueues: the transmit
  virtqueue and the receive virtqueue.
- The driver adds outgoing (read-only) packets are added to the transmit
- virtqueue, and then frees them after they are used.
+ The driver adds outgoing (read-only) packets to the transmit virtqueue,
+ and then frees them after they are used.
  Similarly, incoming (write-only) buffers are added to the receive virtqueue,
  and processed after they are used.
 \end_layout
@@ -2405,7 +2409,8 @@
 \end_layout
 
 \begin_layout Enumerate
-If the VRING_AVAIL_F_NO_INTERRUPT flag is not set in avail->flags:
+If the VRING_AVAIL_F_NO_INTERRUPT flag is not set in avail\SpecialChar \nobreakdash-
+>flags:
 \end_layout
 
 \begin_deeper
@@ -2639,7 +2644,7 @@
 
 \begin_layout Standard
 Any change to configuration space, or new virtqueues, or behavioural changes,
- should be indicated be negotiation of a new feature bit.
+ should be indicated by negotiation of a new feature bit.
  This establishes clarity
 \begin_inset Foot
 status open
@@ -4870,12 +4875,8 @@
 \emph on
 type
 \emph default
- of the request is either a read (VIRTIO_BLK_T_IN),
-\change_deleted 0 1285634492
- 
-\change_unchanged
- a write (VIRTIO_BLK_T_OUT), a scsi packet command (VIRTIO_BLK_T_SCSI_CMD
- or VIRTIO_BLK_T_SCSI_CMD_OUT
+ of the request is either a read (VIRTIO_BLK_T_IN), a write (VIRTIO_BLK_T_OUT),
+ a scsi packet command (VIRTIO_BLK_T_SCSI_CMD or VIRTIO_BLK_T_SCSI_CMD_OUT
 \begin_inset Foot
 status open
 
@@ -4993,11 +4994,7 @@
 \emph on
 data
 \emph default
- field is either read-only or write-only, depending on
-\change_deleted 0 1285634492
- 
-\change_unchanged
- the request.
+ field is either read-only or write-only, depending on the request.
  The size of the read or write can be derived from the total size of the
  request buffers.
 \end_layout
@@ -5169,8 +5166,17 @@
 
 \begin_layout Description
 Virtqueues 0:receiveq(port0).
- 1:transmitq(port0), 2:control receiveq, 3:control transmitq, 4:receiveq(port1),
- 5:transmitq(port1), ...
+ 1:transmitq(port0), 2:control receiveq
+\begin_inset Foot
+status open
+
+\begin_layout Plain Layout
+Ports 2 onwards only if VIRTIO_CONSOLE_F_MULTIPORT is set
+\end_layout
+
+\end_inset
+
+, 3:control transmitq, 4:receiveq(port1), 5:transmitq(port1), ...
 \end_layout
 
 \begin_layout Description
@@ -5318,7 +5324,7 @@
 \end_layout
 
 \begin_layout Enumerate
-If the host specified a port 'name', a sysfs attribute is created with the
+If the host specified a port `name', a sysfs attribute is created with the
  name filled in, so that udev rules can be written that can create a symlink
  from the port's name to the char device for port discovery by applications
  in the guest.
