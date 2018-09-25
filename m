From: xiangxia.m.yue@gmail.com
Subject: [REBASE PATCH net-next v9 0/4] net: vhost: improve performance when
	enable busyloop
Date: Tue, 25 Sep 2018 05:36:48 -0700
Message-ID: <1537879012-20859-1-git-send-email-xiangxia.m.yue__41129.1467644789$1537878902$gmane$org@gmail.com>
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
To: jasowang@redhat.com, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp, davem@davemloft.net
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

This patches improve the guest receive performance.
On the handle_tx side, we poll the sock receive queue
at the same time. handle_rx do that in the same way.

For more performance report, see patch 4

Tonghao Zhang (4):
  net: vhost: lock the vqs one by one
  net: vhost: replace magic number of lock annotation
  net: vhost: factor out busy polling logic to vhost_net_busy_poll()
  net: vhost: add rx busy polling in tx path

 drivers/vhost/net.c   | 147 +++++++++++++++++++++++++++++---------------------
 drivers/vhost/vhost.c |  24 +++------
 2 files changed, 92 insertions(+), 79 deletions(-)

-- 
1.8.3.1
