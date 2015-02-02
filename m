From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH target] vhost/scsi: vhost_skip_iovec_bytes() can be static
Date: Mon, 2 Feb 2015 14:25:21 +0800
Message-ID: <20150202062521.GA18113__29960.7601053596$1422858394$gmane$org@snb>
References: <201502021411.KBLYtCzS%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201502021411.KBLYtCzS%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kbuild-all@01.org
List-Id: virtualization@lists.linuxfoundation.org

drivers/vhost/scsi.c:1081:5: sparse: symbol 'vhost_skip_iovec_bytes' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d888bd9..8ac003f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1078,7 +1078,7 @@ vhost_scsi_send_bad_target(struct vhost_scsi *vs,
 		pr_err("Faulted on virtio_scsi_cmd_resp\n");
 }
 
-int vhost_skip_iovec_bytes(size_t bytes, int max_niov,
+static int vhost_skip_iovec_bytes(size_t bytes, int max_niov,
 			   struct iovec *iov_in, size_t off_in,
 			   struct iovec **iov_out, size_t *off_out)
 {
