From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v9 0/6] net: vhost: improve performance when enable
	busyloop
Date: Sun,  9 Sep 2018 04:51:21 -0700
Message-ID: <1536493887-2637-1-git-send-email-xiangxia.m.yue__46977.9102052145$1536493847$gmane$org@gmail.com>
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
To: jasowang@redhat.com, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

This patches improve the guest receive performance.
On the handle_tx side, we poll the sock receive queue
at the same time. handle_rx do that in the same way.

For more performance report, see patch 4, 5, 6

Tonghao Zhang (6):
  net: vhost: lock the vqs one by one
  net: vhost: replace magic number of lock annotation
  net: vhost: factor out busy polling logic to vhost_net_busy_poll()
  net: vhost: add rx busy polling in tx path
  net: vhost: disable rx wakeup during tx busypoll
  net: vhost: make busyloop_intr more accurate

 drivers/vhost/net.c   | 163 +++++++++++++++++++++++++++++++-------------------
 drivers/vhost/vhost.c |  24 +++-----
 2 files changed, 108 insertions(+), 79 deletions(-)

-- 
1.8.3.1
