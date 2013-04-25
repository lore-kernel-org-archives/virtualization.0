From: Asias He <asias@redhat.com>
Subject: [PATCH v11 0/4] tcm_vhost hotplug
Date: Thu, 25 Apr 2013 15:35:19 +0800
Message-ID: <1366875323-17639-1-git-send-email-asias@redhat.com>
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
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Changes in v11
- Drop change log histroy in commit log

Changes in v10
- Drop comments about lun
- Add Enable VIRTIO_SCSI_F_HOTPLUG to this series

Changes in v9
- Drop tcm_vhost_check_feature
- Add Refactor the lock nesting rule to this sereis

Asias He (4):
  tcm_vhost: Refactor the lock nesting rule
  tcm_vhost: Add hotplug/hotunplug support
  tcm_vhost: Add ioctl to get and set events missed flag
  tcm_vhost: Enable VIRTIO_SCSI_F_HOTPLUG

 drivers/vhost/tcm_vhost.c | 262 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/vhost/tcm_vhost.h |  13 +++
 2 files changed, 259 insertions(+), 16 deletions(-)

-- 
1.8.1.4
