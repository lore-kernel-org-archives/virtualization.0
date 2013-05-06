From: Asias He <asias@redhat.com>
Subject: [PATCH v2 00/11] vhost cleanups
Date: Mon,  6 May 2013 16:38:18 +0800
Message-ID: <1367829509-5371-1-git-send-email-asias@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

MST, This is on top of [PATCH 0/2] vhost-net fix ubuf.

Asias He (11):
  vhost: Remove vhost_enable_zcopy in vhost.h
  vhost: Move VHOST_NET_FEATURES to net.c
  vhost: Make vhost a separate module
  vhost: Remove comments for hdr in vhost.h
  vhost: Simplify dev->vqs[i] access
  vhost-net: Cleanup vhost_ubuf and vhost_zcopy
  vhost-scsi: Remove unnecessary forward struct vhost_scsi declaration
  vhost-scsi: Rename struct vhost_scsi *s to *vs
  vhost-scsi: Make func indention more consistent
  vhost-scsi: Rename struct tcm_vhost_tpg *tv_tpg to *tpg
  vhost-scsi: Rename struct tcm_vhost_cmd *tv_cmd to *cmd

 drivers/vhost/Kconfig  |   8 +
 drivers/vhost/Makefile |   3 +-
 drivers/vhost/net.c    |  64 ++++---
 drivers/vhost/scsi.c   | 470 ++++++++++++++++++++++++++-----------------------
 drivers/vhost/vhost.c  |  86 +++++++--
 drivers/vhost/vhost.h  |  11 +-
 6 files changed, 361 insertions(+), 281 deletions(-)

-- 
1.8.1.4
