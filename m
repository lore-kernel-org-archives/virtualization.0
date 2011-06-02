From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 RFC 0/4] virtio and vhost-net capacity handling
Date: Thu, 2 Jun 2011 20:17:21 +0300
Message-ID: <20110602171721.GA13215__15366.4603749805$1307035135$gmane$org@redhat.com>
References: <cover.1307029008.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1307029008.git.mst@redhat.com>
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

On Thu, Jun 02, 2011 at 06:42:35PM +0300, Michael S. Tsirkin wrote:
> OK, here's a new attempt to use the new capacity api.  I also added more
> comments to clarify the logic.  Hope this is more readable.  Let me know
> pls.
> 
> This is on top of the patches applied by Rusty.
> 
> Warning: untested. Posting now to give people chance to
> comment on the API.
> 
> Changes from v1:
> - fix comment in patch 2 to correct confusion noted by Rusty
> - rewrite patch 3 along the lines suggested by Rusty
>   note: it's not exactly the same but I hope it's close
>   enough, the main difference is that mine does limited
>   polling even in the unlikely xmit failure case.
> - added a patch to not return capacity from add_buf
>   it always looked like a weird hack
> 
> Michael S. Tsirkin (4):
>   virtio_ring: add capacity check API
>   virtio_net: fix tx capacity checks using new API
>   virtio_net: limit xmit polling
>   Revert "virtio: make add_buf return capacity remaining:
> 
>  drivers/net/virtio_net.c     |  111 ++++++++++++++++++++++++++----------------
>  drivers/virtio/virtio_ring.c |   10 +++-
>  include/linux/virtio.h       |    7 ++-
>  3 files changed, 84 insertions(+), 44 deletions(-)
> 
> -- 
> 1.7.5.53.gc233e


And just FYI, here's a patch (on top) that I considered but
decided against. This does a single get_buf before
xmit. I thought it's not really needed as the capacity
check in add_buf is relatively cheap, and we removed
the kick in xmit_skb. But the point is that the loop
will now be easy to move around if someone manages
to show this benefits speed (which I doubt).

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b25db1c..75af5be 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -590,6 +590,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int ret, i;
 
+	/* Try to pop an skb, to increase the chance we can add this one. */
+	free_old_xmit_skb(v);
+
 	/* We normally do have space in the ring, so try to queue the skb as
 	 * fast as possible. */
 	ret = xmit_skb(vi, skb);
@@ -627,8 +630,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * This is so that we don't hog the skb memory unnecessarily. *
 	 * Doing this after kick means there's a chance we'll free
 	 * the skb we have just sent, which is hot in cache. */
-	for (i = 0; i < 2; i++)
-		free_old_xmit_skb(v);
+	free_old_xmit_skb(v);
 
 	if (likely(free_xmit_capacity(vi)))
 		return NETDEV_TX_OK;
