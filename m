From: Greg KH <gregkh@suse.de>
Subject: [patch 05/15] virtio_net: Fix skb->csum_start computation
Date: Thu, 19 Jun 2008 14:29:50 -0700
Message-ID: <20080619212950.GF20267__14819.7982031435$1213911503$gmane$org@suse.de>
References: <20080619211313.834170620@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename="virtio_net-fix-skb-csum_start-computation.patch"
In-Reply-To: <20080619212621.GA20267@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Mark McLoughlin <markmc@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, virtualization@lists.linux-foundation.org, Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk, Chuck Ebbert <cebbert@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org


2.6.25-stable review patch.  If anyone has any objections, please let us
know.

------------------
From: Mark McLoughlin <markmc@redhat.com>

commit 23cde76d801246a702e7a84c3fe3d655b35c89a1 upstream.

hdr->csum_start is the offset from the start of the ethernet
header to the transport layer checksum field. skb->csum_start
is the offset from skb->head.

skb_partial_csum_set() assumes that skb->data points to the
ethernet header - i.e. it computes skb->csum_start by adding
the headroom to hdr->csum_start.

Since eth_type_trans() skb_pull()s the ethernet header,
skb_partial_csum_set() should be called before
eth_type_trans().

(Without this patch, GSO packets from a guest to the world outside the
host are corrupted).

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/virtio_net.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -83,9 +83,7 @@ static void receive_skb(struct net_devic
 	BUG_ON(len > MAX_PACKET_LEN);
 
 	skb_trim(skb, len);
-	skb->protocol = eth_type_trans(skb, dev);
-	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
-		 ntohs(skb->protocol), skb->len, skb->pkt_type);
+
 	dev->stats.rx_bytes += skb->len;
 	dev->stats.rx_packets++;
 
@@ -95,6 +93,10 @@ static void receive_skb(struct net_devic
 			goto frame_err;
 	}
 
+	skb->protocol = eth_type_trans(skb, dev);
+	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
+		 ntohs(skb->protocol), skb->len, skb->pkt_type);
+
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		pr_debug("GSO!\n");
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

-- 
