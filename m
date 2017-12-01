From: wexu@redhat.com
Subject: [PATCH net,stable v3] vhost: fix a few skb leaks
Date: Fri,  1 Dec 2017 00:54:26 -0500
Message-ID: <1512107669-27572-1-git-send-email-wexu__36579.8930674375$1512195553$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.vnet.ibm.com, wexu@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Xu <wexu@redhat.com>

Matthew found a roughly 40% tcp throughput regression with commit
c67df11f(vhost_net: try batch dequing from skb array) as discussed
in the following thread:
https://www.mail-archive.com/netdev@vger.kernel.org/msg187936.html

This is v3.

v3:
- move freeing skb from vhost to tun/tap recvmsg() to not
  confuse the callers.

v2:
- add Matthew as the reporter, thanks matthew.
- moving zero headcount check ahead instead of defer consuming skb
  due to jason and mst's comment.
- add freeing skb in favor of recvmsg() fails.

Wei Xu (3):
  vhost: fix skb leak in handle_rx()
  tun: free skb in early errors
  tap: free skb if flags error

 drivers/net/tap.c   |  6 +++++-
 drivers/net/tun.c   | 14 +++++++++++---
 drivers/vhost/net.c | 20 ++++++++++----------
 3 files changed, 26 insertions(+), 14 deletions(-)

-- 
1.8.3.1
