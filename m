From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v3 0/4] net: vhost: improve performance when enable
	busyloop
Date: Fri, 29 Jun 2018 23:33:54 -0700
Message-ID: <1530340438-3039-1-git-send-email-xiangxia.m.yue__7202.06367918781$1530340320$gmane$org@gmail.com>
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

This patches improve the guest receive and transmit performance.
On the handle_tx side, we poll the sock receive queue at the same time.
handle_rx do that in the same way.

This patches are splited from previous big patch:
http://patchwork.ozlabs.org/patch/934673/

For more performance report, see patch 4.

Tonghao Zhang (4):
  net: vhost: lock the vqs one by one
  net: vhost: replace magic number of lock annotation
  net: vhost: factor out busy polling logic to vhost_net_busy_poll()
  net: vhost: add rx busy polling in tx path

 drivers/vhost/net.c   | 106 +++++++++++++++++++++++++++-----------------------
 drivers/vhost/vhost.c |  24 ++++--------
 2 files changed, 65 insertions(+), 65 deletions(-)

-- 
1.8.3.1
