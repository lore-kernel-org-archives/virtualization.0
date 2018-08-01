From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v7 0/4] net: vhost: improve performance when enable
	busyloop
Date: Tue, 31 Jul 2018 20:00:50 -0700
Message-ID: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
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
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

This patches improve the guest receive performance.
On the handle_tx side, we poll the sock receive queue
at the same time. handle_rx do that in the same way.

For more performance report, see patch 4.

v6->v7:
fix issue and rebase codes:
1. on tx, busypoll will vhost_net_disable/enable_vq rx vq.
[This is suggested by Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>]

2. introduce common helper vhost_net_busy_poll_try_queue().

v5->v6:
rebase the codes.

Tonghao Zhang (4):
  net: vhost: lock the vqs one by one
  net: vhost: replace magic number of lock annotation
  net: vhost: factor out busy polling logic to vhost_net_busy_poll()
  net: vhost: add rx busy polling in tx path

 drivers/vhost/net.c   | 168 +++++++++++++++++++++++++++++++-------------------
 drivers/vhost/vhost.c |  24 +++-----
 2 files changed, 113 insertions(+), 79 deletions(-)

-- 
1.8.3.1
