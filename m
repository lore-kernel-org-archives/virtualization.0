From: Asias He <asias@redhat.com>
Subject: [PATCH V2 0/3] tcm_vhost pending requests flush
Date: Fri, 22 Mar 2013 14:55:26 +0800
Message-ID: <1363935329-11796-1-git-send-email-asias@redhat.com>
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

Changes in v2:
- Increase/Decrease inflight requests in
  vhost_scsi_{allocate,free}_cmd and tcm_vhost_{allocate,free}_evt

Asias He (3):
  tcm_vhost: Wait for pending requests in vhost_scsi_flush()
  tcm_vhost: Wait for pending requests in vhost_scsi_clear_endpoint()
  tcm_vhost: Fix tv_cmd leak in vhost_scsi_handle_vq

 drivers/vhost/tcm_vhost.c | 131 ++++++++++++++++++++++++++++++++++++++--------
 drivers/vhost/tcm_vhost.h |   4 ++
 2 files changed, 112 insertions(+), 23 deletions(-)

-- 
1.8.1.4
