From: Asias He <asias@redhat.com>
Subject: [PATCH 2/2] virtio-scsi: Pack struct virtio_scsi_{req_cmd,resp_cmd}
Date: Fri, 15 Mar 2013 09:45:16 +0800
Message-ID: <1363311916-23121-3-git-send-email-asias@redhat.com>
References: <1363311916-23121-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363311916-23121-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: seabios@seabios.org
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Kevin O'Connor <kevin@koconnor.net>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Device needs the exact size of these data structure. Prevent padding.

This fixes guest hang when booting seabios + tcm_vhost.

Signed-off-by: Asias He <asias@redhat.com>
---
 src/virtio-scsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/virtio-scsi.h b/src/virtio-scsi.h
index bbfbf30..96c3701 100644
--- a/src/virtio-scsi.h
+++ b/src/virtio-scsi.h
@@ -26,7 +26,7 @@ struct virtio_scsi_req_cmd {
     u8 prio;
     u8 crn;
     char cdb[VIRTIO_SCSI_CDB_SIZE];
-};
+} __attribute__((packed));
 
 /* This is the first element of the "in" scatter-gather list. */
 struct virtio_scsi_resp_cmd {
@@ -36,7 +36,7 @@ struct virtio_scsi_resp_cmd {
     u8 status;
     u8 response;
     u8 sense[VIRTIO_SCSI_SENSE_SIZE];
-};
+} __attribute__((packed));
 
 #define VIRTIO_SCSI_S_OK            0
 
-- 
1.8.1.4
