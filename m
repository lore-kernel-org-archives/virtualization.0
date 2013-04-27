From: Asias He <asias@redhat.com>
Subject: [PATCH v6 0/2] tcm_vhost flush
Date: Sat, 27 Apr 2013 11:16:47 +0800
Message-ID: <1367032609-30511-1-git-send-email-asias@redhat.com>
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

Changes in v6:
- Allow device specific fields per vq
- Track cmd per vq
- Do not track evt
- Switch to static array for inflight allocation, completely get rid of the
  pain to handle inflight allocation failure.

Asias He (2):
  vhost: Allow device specific fields per vq
  tcm_vhost: Wait for pending requests in vhost_scsi_flush()

 drivers/vhost/net.c       |  60 +++++++++++--------
 drivers/vhost/tcm_vhost.c | 145 ++++++++++++++++++++++++++++++++++++++++------
 drivers/vhost/tcm_vhost.h |   3 +
 drivers/vhost/vhost.c     |  88 ++++++++++++++--------------
 drivers/vhost/vhost.h     |   4 +-
 5 files changed, 212 insertions(+), 88 deletions(-)

-- 
1.8.1.4
