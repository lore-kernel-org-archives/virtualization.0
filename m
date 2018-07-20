From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 0/9] TX used ring batched updating for vhost
Date: Fri, 20 Jul 2018 08:15:12 +0800
Message-ID: <1532045721-4958-1-git-send-email-jasowang__47761.1678572886$1532045607$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi:

This series implement batch updating of used ring for TX. This help to
reduce the cache contention on used ring. The idea is first split
datacopy path from zerocopy, and do only batching for datacopy. This
is because zercopy had already supported its own batching.

TX PPS was increased 25.8% and Netperf TCP does not show obvious
differences.

The split of datapath will also be helpful for future implementation
like in order completion.

Please review.

Thanks

Jason Wang (9):
  vhost_net: drop unnecessary parameter
  vhost_net: introduce helper to initialize tx iov iter
  vhost_net: introduce vhost_exceeds_weight()
  vhost_net: introduce get_tx_bufs()
  vhost_net: introduce tx_can_batch()
  vhost_net: split out datacopy logic
  vhost_net: rename vhost_rx_signal_used() to vhost_net_signal_used()
  vhost_net: rename VHOST_RX_BATCH to VHOST_NET_BATCH
  vhost_net: batch update used ring for datacopy TX

 drivers/vhost/net.c | 249 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 179 insertions(+), 70 deletions(-)

-- 
2.7.4
