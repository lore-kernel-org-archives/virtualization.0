From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 RFC 3/4] virtio_net: limit xmit polling
Date: Tue, 7 Jun 2011 18:59:15 +0300
Message-ID: <20110607155915.GA17581__40261.3074555576$1307462470$gmane$org@redhat.com>
References: <cover.1307029008.git.mst@redhat.com>
	<a80199422de16ae355e56ee1b2abc9b2bf91a7f6.1307029009.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a80199422de16ae355e56ee1b2abc9b2bf91a7f6.1307029009.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 02, 2011 at 06:43:17PM +0300, Michael S. Tsirkin wrote:
> Current code might introduce a lot of latency variation
> if there are many pending bufs at the time we
> attempt to transmit a new one. This is bad for
> real-time applications and can't be good for TCP either.
> 
> Free up just enough to both clean up all buffers
> eventually and to be able to xmit the next packet.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


I've been testing this patch and it seems to work fine
so far. The following fixups are needed to make it
build though:


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b25db1c..77cdf34 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -529,11 +529,8 @@ static bool free_old_xmit_skb(struct virtnet_info *vi)
  * virtqueue_add_buf will succeed. */
 static bool free_xmit_capacity(struct virtnet_info *vi)
 {
-	struct sk_buff *skb;
-	unsigned int len;
-
 	while (virtqueue_min_capacity(vi->svq) < MAX_SKB_FRAGS + 2)
-		if (unlikely(!free_old_xmit_skb))
+		if (unlikely(!free_old_xmit_skb(vi)))
 			return false;
 	return true;
 }
@@ -628,7 +625,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * Doing this after kick means there's a chance we'll free
 	 * the skb we have just sent, which is hot in cache. */
 	for (i = 0; i < 2; i++)
-		free_old_xmit_skb(v);
+		free_old_xmit_skb(vi);
 
 	if (likely(free_xmit_capacity(vi)))
 		return NETDEV_TX_OK;
