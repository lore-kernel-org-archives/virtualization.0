From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] lguest: two net bugfixes
Date: Tue, 08 May 2007 21:22:53 +1000
Message-ID: <1178623374.7286.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

1) Bridging via host is broken: we need to set "promisc" bit in MAC
   address published by the host so the guest sends us everything.
   Thanks James Morris for the report (I don't use bridging).

2) Lguest network device uses 0 to mean "noone at this slot".  It used to
   use 0xFF, and one spot was missed.  Minor: it just means we'll have a
   useless extra transmit for broadcast packets.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |    2 ++
 drivers/net/lguest_net.c      |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -r 999a9058a151 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Tue May 08 19:49:33 2007 +1000
+++ b/Documentation/lguest/lguest.c	Tue May 08 21:04:51 2007 +1000
@@ -860,6 +860,10 @@ static void setup_tun_net(const char *ar
 
 	/* We are peer 0, ie. first slot. */
 	configure_device(ipfd, ifr.ifr_name, ip, dev->mem);
+
+	/* Set "promisc" bit: we want every single packet. */
+	*((u8 *)dev->mem) |= 0x1;
+
 	close(ipfd);
 
 	verbose("device %p: tun net %u.%u.%u.%u\n",
diff -r 999a9058a151 drivers/net/lguest_net.c
--- a/drivers/net/lguest_net.c	Tue May 08 19:49:33 2007 +1000
+++ b/drivers/net/lguest_net.c	Tue May 08 21:03:47 2007 +1000
@@ -249,7 +249,7 @@ static int lguestnet_close(struct net_de
 	struct lguestnet_info *info = dev->priv;
 
 	/* Clear all trace: others might deliver packets, we'll ignore it. */
-	memset(&info->peer[info->me], 0xFF, sizeof(info->peer[info->me]));
+	memset(&info->peer[info->me], 0, sizeof(info->peer[info->me]));
 
 	/* Deregister sg lists. */
 	hcall(LHCALL_BIND_DMA, peer_key(info, info->me), __pa(info->dma), 0);
