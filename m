From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 0/2] vhost-scsi: Check for tcm_vhost ABI version
Date: Tue, 24 Jul 2012 01:30:08 +0000
Message-ID: <1343093410-5843-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

Hi Anthony,

Here are the two patches against Zhi's vhost-scsi tree to check for
a supported version (VHOST_SCSI_ABI_VERSION=1) that's now exposed via
the tcm_vhost ioctl.

Please have a look and let me know if this is what you had in mind.

Thanks!

Nicholas Bellinger (2):
  vhost-scsi: Rename vhost_vring_target -> vhost_scsi_target
  vhost-scsi: Add support for VHOST_SCSI_GET_ABI_VERSION ioctl

 hw/vhost-scsi.c |   21 +++++++++++++++++++--
 hw/vhost-scsi.h |   17 ++++++++++++++---
 2 files changed, 33 insertions(+), 5 deletions(-)

-- 
1.7.2.5
