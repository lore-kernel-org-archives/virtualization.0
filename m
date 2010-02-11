From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-spec: document MSI-X
Date: Thu, 11 Feb 2010 19:22:36 +0200
Message-ID: <20100211172236.GA20357__18613.3255054758$1265909308$gmane$org@redhat.com>
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
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
Cc: markmc@redhat.com, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This documents MSI-X support in virtio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---
 virtio-spec.lyx |  358 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 332 insertions(+), 26 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 49ed612..d16104a 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -1,4 +1,4 @@
-#LyX 1.6.4 created this file. For more info see http://www.lyx.org/
+#LyX 1.6.5 created this file. For more info see http://www.lyx.org/
 \lyxformat 345
 \begin_document
 \begin_header
@@ -35,9 +35,8 @@
 \papersides 1
 \paperpagestyle default
 \tracking_changes true
-\output_changes true
-\author "" 
-\author "" 
+\output_changes false
+\author "Michael S. Tsirkin" 
 \author "" 
 \end_header
 
@@ -72,7 +71,11 @@ FIXME: virtio block scsi passthrough section
 \end_layout
 
 \begin_layout Standard
+
+\change_deleted 0 1265908736
 FIXME: MSI-X documentation
+\change_unchanged
+
 \end_layout
 
 \begin_layout Chapter
@@ -590,8 +593,11 @@ The DRIVER status bit is set: we know how to drive the device.
 
 \begin_layout Enumerate
 Device-specific setup, including reading the Device Feature Bits, discovery
- of virtqueues for the device, and reading and possibly writing the virtio
- configuration space.
+ of virtqueues for the device, 
+\change_inserted 0 1265905891
+optional MSI-X setup, 
+\change_unchanged
+and reading and possibly writing the virtio configuration space.
 \end_layout
 
 \begin_layout Enumerate
@@ -636,7 +642,7 @@ Virtio Header
 
 \begin_layout Standard
 \begin_inset Tabular
-<lyxtabular version="3" rows="4" columns="10">
+<lyxtabular version="3" rows="4" columns="12">
 <features>
 <column alignment="left" valignment="top" width="0">
 <column alignment="left" valignment="top" width="0">
@@ -648,6 +654,8 @@ Virtio Header
 <column alignment="left" valignment="top" width="0">
 <column alignment="left" valignment="top" width="0">
 <column alignment="left" valignment="top" width="0">
+<column alignment="left" valignment="top" width="0">
+<column alignment="left" valignment="top" width="0">
 <row>
 <cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">
 \begin_inset Text
@@ -730,6 +738,28 @@ Bits
 
 \end_inset
 </cell>
+<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895519
+16 (optional)
+\end_layout
+
+\end_inset
+</cell>
+<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895525
+16 (optional)
+\end_layout
+
+\end_inset
+</cell>
 <cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">
 \begin_inset Text
 
@@ -822,6 +852,28 @@ R
 
 \end_inset
 </cell>
+<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895422
+R+W
+\end_layout
+
+\end_inset
+</cell>
+<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895531
+R+W
+\end_layout
+
+\end_inset
+</cell>
 <cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">
 \begin_inset Text
 
@@ -930,6 +982,28 @@ ISR
 
 \end_inset
 </cell>
+<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895579
+Configuration
+\end_layout
+
+\end_inset
+</cell>
+<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895618
+Queue
+\end_layout
+
+\end_inset
+</cell>
 <cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">
 \begin_inset Text
 
@@ -1040,6 +1114,28 @@ Status
 
 \end_inset
 </cell>
+<cell alignment="center" valignment="top" bottomline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895695
+Vector
+\end_layout
+
+\end_inset
+</cell>
+<cell alignment="center" valignment="top" bottomline="true" leftline="true" usebox="none">
+\begin_inset Text
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265895623
+Vector
+\end_layout
+
+\end_inset
+</cell>
 <cell alignment="center" valignment="top" bottomline="true" leftline="true" rightline="true" usebox="none">
 \begin_inset Text
 
@@ -1181,6 +1277,88 @@ This allows for forwards and backwards compatibility: if the device is enhanced
  support, it will not see that feature bit in the Device Features field
  and can go into backwards compatibility mode (or, for poor implementations,
  set the FAILED Device Status bit).
+\change_inserted 0 1265896046
+
+\end_layout
+
+\begin_layout Subsubsection
+
+\change_inserted 0 1265896301
+Configuration/Queue Vectors
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265908336
+When MSI-X capability is present and enabled in the device (through standard
+ PCI configuration space) 4 bytes at byte offset 20 are used to map configuratio
+n change and queue interrupts to MSI-X vectors.
+ In this case, the ISR Status field is unused, and device specific configuration
+ starts at byte offset 24 in virtio header structure.
+ When MSI-X capability is not enabled, device specific configuration starts
+ at byte offset 20 in virtio header.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265907969
+Writing a valid MSI-X Table entry number, 0 to 0x7FF, to one of Configuration/Qu
+eue Vector registers, 
+\emph on
+maps
+\emph default
+ interrupts triggered by the configuration change/selected queue events
+ respectively to the corresponding MSI-X vector.
+ To disable interrupts for a specific event type, unmap it by writing a
+ special NO_VECTOR value:
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265902253
+\begin_inset listings
+inline false
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265902147
+
+/* Vector value used to disable MSI for queue */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265902136
+
+#define VIRTIO_MSI_NO_VECTOR            0xffff 
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265905829
+Reading these registers returns vector mapped to a given event, or NO_VECTOR
+ if unmapped.
+ All queue and configuration change events are unmapped by default.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265907870
+Note that mapping an event to vector might require allocating internal device
+ resources, and might fail.
+ Devices report such failures by returning NO_VECTOR value when the relevant
+ Vector field is read.
+ After mapping an event to vector, driver must verify success by reading
+ the Vector field valueon success, previously written value is returned;
+ on failure, NO_VECTOR value is returned.
+ If mapping failure is detected, driver can retry mapping with less vectors,
+ or disable MSI-X.
 \end_layout
 
 \begin_layout Section
@@ -1224,6 +1402,19 @@ The 4096 is based on the x86 page size, but it's also large enough to ensure
 \end_inset
 
 
+\change_inserted 0 1265902802
+
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1265907664
+Optionally, if MSI-X capability is present and enabled on the device, select
+ a vector to use to request interrupts triggered by virtqueue events.
+ Write the MSI-X Table entry number corresponding to this vector in Queue
+ Vector field.
+ Read the Queue Vector field: on success, previously written value is returned;
+ on failure, NO_VECTOR value is returned.
 \end_layout
 
 \begin_layout Standard
@@ -2107,6 +2298,17 @@ Update the used ring idx.
 
 \begin_layout Enumerate
 If the VRING_AVAIL_F_NO_INTERRUPT flag is not set in avail->flags:
+\change_inserted 0 1265903387
+
+\end_layout
+
+\begin_deeper
+\begin_layout Enumerate
+
+\change_inserted 0 1265903435
+If MSI-X capability is disabled:
+\change_unchanged
+
 \end_layout
 
 \begin_deeper
@@ -2116,16 +2318,66 @@ Set the lower bit of the ISR Status field for the device.
 
 \begin_layout Enumerate
 Send the appropriate PCI interrupt for the device.
+\change_inserted 0 1265904154
+
 \end_layout
 
 \end_deeper
+\begin_layout Enumerate
+
+\change_inserted 0 1265903452
+If MSI-X capability is enabled:
+\end_layout
+
+\begin_deeper
+\begin_layout Enumerate
+
+\change_inserted 0 1265907522
+Request the appropriate MSI-X interrupt message for the device, Queue Vector
+ field sets the MSI-X Table entry number.
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1265907541
+If Queue Vector field value is NO_VECTOR, no interrupt message is requested
+ for this event.
+\change_unchanged
+
+\end_layout
+
+\end_deeper
+\end_deeper
 \begin_layout Standard
-The guest interrupt handler should read the ISR Status field, which will
- reset it to zero.
+The guest interrupt handler should
+\change_inserted 0 1265904434
+:
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1265904449
+If MSI-X capability is disabled: 
+\change_deleted 0 1265904425
+ 
+\change_unchanged
+read the ISR Status field, which will reset it to zero.
  If the lower bit is zero, the interrupt was not for this device.
  Otherwise, the guest driver should look through the used rings of each
  virtqueue for the device, to see if any progress has been made by the device
  which requires servicing.
+\change_inserted 0 1265904489
+
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1265904546
+If MSI-X capability is enabled: look through the used rings of each virtqueue
+ mapped to the specific MSI-X vector for the device, to see if any progress
+ has been made by the device which requires servicing.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Standard
@@ -2170,12 +2422,23 @@ Dealing With Configuration Changes
 \begin_layout Standard
 Some virtio PCI devices can change the device configuration state, as reflected
  in the virtio header in the PCI configuration space.
- In this case, an interrupt is delivered and the second highest bit is set
- in the ISR Status field to indicate that the driver should re-examine the
- configuration space.
+ In this case
+\change_inserted 0 1265904732
+:
 \end_layout
 
-\begin_layout Standard
+\begin_layout Enumerate
+
+\change_inserted 0 1265904810
+If MSI-X capability is disabled:
+\change_deleted 0 1265904811
+,
+\change_unchanged
+ an interrupt is delivered and the second highest bit is set in the ISR
+ Status field to indicate that the driver should re-examine the configuration
+ space.
+\change_deleted 0 1265905023
+
 \begin_inset listings
 inline false
 status open
@@ -2188,12 +2451,31 @@ status open
 \end_inset
 
 
+\change_inserted 0 1265905350
+Note that a single interrupt can indicate both that one or more virtqueue
+ has been used and that the configuration space has changed: even if the
+ config bit is set, virtqueues must be scanned.
+\end_layout
+
+\begin_layout Enumerate
+
+\change_inserted 0 1265907476
+If MSI-X capability is enabled: an interrupt message is requested.
+ The Configuration Vector field sets the MSI-X Table entry number to use.
+ If Configuration Vector field value is NO_VECTOR, no interrupt message
+ is requested for this event.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Standard
+
+\change_deleted 0 1265905342
 Note that a single interrupt can indicate both that one or more virtqueue
  has been used and that the configuration space has changed: even if the
  config bit is set, virtqueues must be scanned.
+\change_inserted 0 1265905057
+
 \end_layout
 
 \begin_layout Chapter
@@ -2259,6 +2541,30 @@ Meanwhile for experimental drivers, use 65535 and work backwards.
 \end_layout
 
 \begin_layout Section*
+
+\change_inserted 0 1265906688
+How many MSI-X vectors?
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265907268
+Using the optional MSI-X capability devices can speed up interrupt processing
+ by removing the need to read ISR Status register by guest driver (which
+ might be an expensive operation), reducing interrupt sharing between devices
+ and queues within the device, and handling interrupts from multiple CPUs.
+ However, some systems impose a limit (which might be as low as 256) on
+ the total number of MSI-X vectors that can be allocated to all devices.
+ Devices and/or device drivers should take this into account, limiting the
+ number of vectors used unless the device is expected to cause a high volume
+ of interrupts.
+ Devices can control the number of vectors used by limiting the MSI-X Table
+ Size or not presenting MSI-X capability in PCI configuration space.
+ Drivers can control this by mapping events to as small number of vectors
+ as possible, or disabling MSI-X capability altogether.
+\end_layout
+
+\begin_layout Section*
 Message Framing
 \end_layout
 
@@ -2276,7 +2582,7 @@ The descriptors used for a buffer should not effect the semantics of the
 In particular, no implementation should use the descriptor boundaries to
  determine the size of any header in a request.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 The current qemu device implementations mistakenly insist that the first
@@ -2298,7 +2604,7 @@ Any change to configuration space, or new virtqueues, or behavioural changes,
  should be indicated be negotiation of a new feature bit.
  This establishes clarity
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 Even if it does mean documenting design or implementation mistakes!
@@ -3092,7 +3398,7 @@ Virtqueues 0:receiveq.
  1:transmitq.
  2:controlq
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 Only if VIRTIO_NET_F_CTRL_VQ set
@@ -3143,7 +3449,7 @@ VIRTIO_NET_F_GSO
 
 (6) (Deprecated) device handles packets with any GSO type.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 It was supposed to indicate segmentation offload support, but upon further
@@ -3412,7 +3718,7 @@ This is a common restriction in real, older network cards.
 The converse features are also available: a driver can save the virtual
  device some work by negotiating these features.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 For example, a network packet transported between two guests on the same
@@ -3576,7 +3882,7 @@ csum_start is set to the offset within the packet to begin checksumming,
 csum_offset indicates how many bytes after the csum_start the new (16 bit
  ones' complement) checksum should be placed.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 For example, consider a partially checksummed TCP (IPv4) packet.
@@ -3653,7 +3959,7 @@ gso_type
 
  as well, indicating that the TCP packet has the ECN bit set.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 This case is not handled by some older hardware, so is called out specifically
@@ -3682,7 +3988,7 @@ reference "sub:Notifying-The-Device"
 
 ).
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 Note that the header will be two bytes longer for the VIRTIO_NET_F_MRG_RXBUF
@@ -4070,7 +4376,7 @@ struct virtio_net_ctrl_mac {
 The device can filter incoming packets by any number of destination MAC
  addresses.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 Since there are no guarentees, it can use a hash filter orsilently switch
@@ -4633,7 +4939,7 @@ Device Operation
 \begin_layout Enumerate
 For output, a buffer containing the characters is placed in the port's transmitq.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 Because this is high importance and low bandwidth, the current Linux implementat
@@ -4843,7 +5149,7 @@ Virtqueues 0:inflateq.
  1:deflateq.
  2:statsq.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 Only if VIRTIO_BALLON_F_STATS_VQ set
@@ -5001,7 +5307,7 @@ To supply memory to the balloon (aka.
 The driver constructs an array of addresses of unused memory pages.
  These addresses are divided by 4096
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 This is historical, and independent of the guest page size
@@ -5062,7 +5368,7 @@ actual
  field of the configuration should be updated to reflect the new number
  of pages in the balloon.
 \begin_inset Foot
-status collapsed
+status open
 
 \begin_layout Plain Layout
 As updates to configuration space are not atomic, this field isn't particularly
-- 
1.6.6.144.g5c3af
