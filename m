From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 07/11] tuntap: move XDP flushing out of tun_do_xdp()
Date: Thu,  6 Sep 2018 12:05:22 +0800
Message-ID: <20180906040526.22518-8-jasowang__44900.4493923441$1536207003$gmane$org@redhat.com>
References: <20180906040526.22518-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180906040526.22518-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This will allow adding batch flushing on top.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 21b125020b3b..ff1cbf3ebd50 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1646,7 +1646,6 @@ static u32 tun_do_xdp(struct tun_struct *tun,
 	switch (act) {
 	case XDP_REDIRECT:
 		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
-		xdp_do_flush_map();
 		if (*err)
 			break;
 		goto out;
@@ -1735,6 +1734,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
 		if (err)
 			goto err_xdp;
+
+		if (act == XDP_REDIRECT)
+			xdp_do_flush_map();
 		if (act != XDP_PASS)
 			goto out;
 
-- 
2.17.1
