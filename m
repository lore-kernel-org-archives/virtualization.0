From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [PATCH] virtio_net tx performance fix
Date: Mon, 28 Jan 2008 17:59:14 +0200
Message-ID: <1201535954.2457.11.camel__11270.3182771385$1201536139$gmane$org@localhost.localdomain>
References: <1201479224.3047.37.camel@localhost.localdomain>
	<479DF5A8.8050103@us.ibm.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479DF5A8.8050103@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


On Mon, 2008-01-28 at 09:32 -0600, Anthony Liguori wrote:
> Hi Dor,
> 
> How are you measuring performance?  The numbers I've gotten with netperf 
> before and after your patch are:
> 
> tx - 647.27mbit
> rx - 89.22
> 
> tx - 27.82
> rx - 79.93
> 

I've been testing with iperf (patched with Ingo's fix).
I also tested tcp/udp (udp tx is only 550Mbps with the patch, w/o it's
only 220Mbps)

> So this patch is pretty much killing performance for netperf.
> 

Did you have hrtimer configured on the host?

> Dor Laor wrote:
> > There was a problem with the location of the notify call in
> > add_buff function:
> > When VRING_USED_F_NO_NOTIFY is set, the host does not kick the
> > guest when packets were transmitted, as a result the guest runs
> > out of tx buffers sometimes.
> 
> But even if F_NO_NOTIFY is set, if the tx buffer is full, we notify the 
> guest, so this prevents that from happening.
> 
> >  This is fine but the problem lies
> > when add_buf fails, it called notify and the host sends all the
> > pending tx pkts. When enable_cb was called, more_used(vq) returned
> > false so eventually the skb was dropped.
> >   
> 
> I'm having a tough time following this part.  If add_buf fails, we 
> notify unconditionally (which is, I think what we want).  I'm not sure 
> how that relates to a packet getting dropped though.
> 

Here is start_xmit function:

again:
	/* Free up any pending old buffers before queueing new ones. */
	free_old_xmit_skbs(vi);
	err = vi->svq->vq_ops->add_buf(vi->svq, sg, num, 0, skb);

<<< here add_buf might fail since the ring is full.
<<< once it fails, the original code called notify which triggered the
<<< host to send all the pending tx so all descriptors are used.

	if (err) {
		vi->stats.sendq_full++;

		pr_debug("%s: virtio not prepared to send\n",dev->name);
		netif_stop_queue(dev);

		/* Activate callback for using skbs: if this fails it
		 * means some were used in the meantime. */
		vi->stats.sendq_enabled++;
		if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {

<<< Since before the patch enable_cb returned true, thus the goto below
<<< was not called.
<<< The patch moves the notify to enable_cb above.

			printk("Unlikely: restart svq failed\n");
			vi->stats.sendq_enable_failed++;
			netif_start_queue(dev);
			goto again;
		}
		__skb_unlink(skb, &vi->send);

		return NETDEV_TX_BUSY;
	}


> Regards,
> 
> Anthony Liguori
> 
> 
