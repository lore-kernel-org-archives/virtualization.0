From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 00/10] Fixes for metadata accelreation
Date: Wed,  7 Aug 2019 02:54:39 -0400
Message-ID: <20190807065449.23373-1-jasowang__38730.2895587467$1565160910$gmane$org@redhat.com>
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
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

This series try to fix several issues introduced by meta data
accelreation series. Please review.

Changes from V2:
- use seqlck helper to synchronize MMU notifier with vhost worker

Changes from V1:

- try not use RCU to syncrhonize MMU notifier with vhost worker
- set dirty pages after no readers
- return -EAGAIN only when we find the range is overlapped with
  metadata

Jason Wang (9):
  vhost: don't set uaddr for invalid address
  vhost: validate MMU notifier registration
  vhost: fix vhost map leak
  vhost: reset invalidate_count in vhost_set_vring_num_addr()
  vhost: mark dirty pages during map uninit
  vhost: don't do synchronize_rcu() in vhost_uninit_vq_maps()
  vhost: do not use RCU to synchronize MMU notifier with worker
  vhost: correctly set dirty pages in MMU notifiers callback
  vhost: do not return -EAGAIN for non blocking invalidation too early

Michael S. Tsirkin (1):
  vhost: disable metadata prefetch optimization

 drivers/vhost/vhost.c | 228 +++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  10 +-
 2 files changed, 151 insertions(+), 87 deletions(-)

-- 
2.18.1
