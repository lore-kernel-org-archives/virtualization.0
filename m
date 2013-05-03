From: Asias He <asias@redhat.com>
Subject: [PATCH 0/5] vhost-scsi cleanup
Date: Fri,  3 May 2013 15:35:54 +0800
Message-ID: <1367566559-20431-1-git-send-email-asias@redhat.com>
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

Asias He (5):
  vhost-scsi: Remove unnecessary forward struct vhost_scsi declaration
  vhost-scsi: Rename struct vhost_scsi *s to *vs
  vhost-scsi: Make func indention more consistent
  vhost-scsi: Rename struct tcm_vhost_tpg *tv_tpg to *tpg
  vhost-scsi: Rename struct tcm_vhost_cmd *tv_cmd to *cmd

 drivers/vhost/scsi.c | 469 +++++++++++++++++++++++++++------------------------
 1 file changed, 245 insertions(+), 224 deletions(-)

-- 
1.8.1.4
