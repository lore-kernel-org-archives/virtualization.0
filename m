From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2 07/11] tuntap: move XDP flushing out of
	tun_do_xdp()
Date: Wed, 12 Sep 2018 11:17:05 +0800
Message-ID: <20180912031709.14112-8-jasowang__4976.70629197291$1536722490$gmane$org@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
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
 drivers/net/tun.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 14fe94098180..3ae539374f6b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1660,7 +1660,6 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 	switch (act) {
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
-		xdp_do_flush_map();
 		if (err)
 			return err;
 		break;
@@ -1749,6 +1748,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
 		if (err < 0)
 			goto err_xdp;
+		if (err == XDP_REDIRECT)
+			xdp_do_flush_map();
 		if (err != XDP_PASS)
 			goto out;
 
-- 
2.17.1
