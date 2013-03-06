From: Asias He <asias@redhat.com>
Subject: [PATCH 0/5] tcm_vhost hotplug/hotunplug support and locking fix
Date: Wed,  6 Mar 2013 14:16:25 +0800
Message-ID: <1362550590-3534-1-git-send-email-asias@redhat.com>
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

Asias He (5):
  tcm_vhost: Add missed lock in vhost_scsi_clear_endpoint()
  tcm_vhost: Introduce tcm_vhost_check_feature()
  tcm_vhost: Introduce tcm_vhost_check_endpoint()
  tcm_vhost: Fix vs->vs_endpoint checking in vhost_scsi_handle_vq()
  tcm_vhost: Add hotplug/hotunplug support

 drivers/vhost/tcm_vhost.c | 238 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/vhost/tcm_vhost.h |  10 ++
 2 files changed, 242 insertions(+), 6 deletions(-)

-- 
1.8.1.4
