From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] virtio-scsi spec: add configuration change event
Date: Mon, 16 Jul 2012 16:24:37 +0200
Message-ID: <1342448677-7453-3-git-send-email-pbonzini__26263.0003890537$1342448711$gmane$org@redhat.com>
References: <1342448677-7453-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342448677-7453-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, rusty@rustcorp.com.au
Cc: qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

This adds an event for changes to LUN parameters, for example capacity.  These
are reported in virtio-blk via configuration changes, and we want a similar
functionality in virtio-scsi too.

There is no list of supported parameter changes, instead we just refer to
the list of sense codes in the SCSI specification.

This event will usually be serviced in one of three ways: 1) call an OS
service to revalidate the disk, either always or only for some specific
sense codes; 2) somehow pass the sense directly to the upper-level driver;
3) inject a TEST UNIT READY command into the upper-level device, so that
the OS will see the unit attention code and react.  Of course a mix of
the three is also possible, depending on how the driver writer prefers
to have his layering violations served.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virtio-spec.lyx |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index f8b214b..8d2ac9a 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -6995,6 +6995,21 @@ VIRTIO_SCSI_F_HOTPLUG
 
 (1) The host should enable hot-plug/hot-unplug of new LUNs and targets on
  the SCSI bus.
+\change_inserted 1531152142 1342440342
+
+\end_layout
+
+\begin_layout Description
+
+\change_inserted 1531152142 1342440768
+VIRTIO_SCSI_F_CHANGE
+\begin_inset space ~
+\end_inset
+
+(2) The host will report changes to LUN parameters via a VIRTIO_SCSI_T_PARAM_CHA
+NGE event.
+\change_unchanged
+
 \end_layout
 
 \end_deeper
@@ -8673,6 +8688,86 @@ reason
 \begin_layout Standard
 When dropped events are reported, the driver should poll for asynchronous
  events manually using SCSI commands.
+\change_inserted 1531152142 1342439104
+
+\end_layout
+
+\end_deeper
+\begin_layout Description
+
+\change_inserted 1531152142 1342440778
+LUN
+\begin_inset space ~
+\end_inset
+
+parameter
+\begin_inset space ~
+\end_inset
+
+change 
+\begin_inset space ~
+\end_inset
+
+
+\begin_inset Newline newline
+\end_inset
+
+
+\begin_inset listings
+inline false
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1342440783
+
+#define VIRTIO_SCSI_T_PARAM_CHANGE  3
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_deeper
+\begin_layout Standard
+
+\change_inserted 1531152142 1342440882
+By sending this event, the device signals that the configuration parameters
+ (for example the capacity) of a logical unit have changed.
+ The 
+\series bold
+event
+\series default
+ field is set to VIRTIO_SCSI_T_PARAM_CHANGE.
+ The 
+\series bold
+lun
+\series default
+ field addresses a logical unit in the SCSI host.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1342440916
+The same event is also reported as a unit attention condition.
+ The 
+\series bold
+reason
+\series default
+ field contains the additional sense code and additional sense code qualifier,
+ respectively in bits 0..7 and 8..15.
+ For example, a change in capacity will be reported as asc 0x2a, ascq 0x09
+ (CAPACITY DATA HAS CHANGED).
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1342442803
+For MMC devices (inquiry type 5) there would be some overlap between this
+ event and the asynchronous notification event.
+ For simplicity, as of this version of the specification the host must
+ never report this event for MMC devices.
 \end_layout
 
 \end_deeper
-- 
1.7.10.4
