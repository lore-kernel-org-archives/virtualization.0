From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] virtio_net tx performance fix
Date: Mon, 28 Jan 2008 10:11:39 -0600
Message-ID: <479DFEBB.8010500__19851.9762642265$1201536810$gmane$org@us.ibm.com>
References: <1201479224.3047.37.camel@localhost.localdomain>
	<479DF5A8.8050103@us.ibm.com>
	<1201535954.2457.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1201535954.2457.11.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
> On Mon, 2008-01-28 at 09:32 -0600, Anthony Liguori wrote:
>   
>> Hi Dor,
>>
>> How are you measuring performance?  The numbers I've gotten with netperf 
>> before and after your patch are:
>>
>> tx - 647.27mbit
>> rx - 89.22
>>
>> tx - 27.82
>> rx - 79.93
>>
>>     
>
> I've been testing with iperf (patched with Ingo's fix).
> I also tested tcp/udp (udp tx is only 550Mbps with the patch, w/o it's
> only 220Mbps)
>   

I can try iperf, but I think we should also try a pretty simple dd test 
to see if there's a real impact.

>> So this patch is pretty much killing performance for netperf.
>>
>>     
>
> Did you have hrtimer configured on the host?
>   

Yup.

> Here is start_xmit function:
>
> again:
> 	/* Free up any pending old buffers before queueing new ones. */
> 	free_old_xmit_skbs(vi);
> 	err = vi->svq->vq_ops->add_buf(vi->svq, sg, num, 0, skb);
>
> <<< here add_buf might fail since the ring is full.
> <<< once it fails, the original code called notify which triggered the
> <<< host to send all the pending tx so all descriptors are used.
>   

Notify, with KVM at least, will drain the TX ring.  So now, the TX ring 
should be empty.  The notification is disabled but notification should 
always happen when the queue is drained so an interrupt should occur 
which should cause the guest to immediately try again..

> 	if (err) {
> 		vi->stats.sendq_full++;
>
> 		pr_debug("%s: virtio not prepared to send\n",dev->name);
> 		netif_stop_queue(dev);
>
> 		/* Activate callback for using skbs: if this fails it
> 		 * means some were used in the meantime. */
> 		vi->stats.sendq_enabled++;
> 		if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {
>   

Even when this returns false and we don't immediately reschedule.  At 
least, that's what I'm expecting to happen.

Regards,

Anthony Liguori

> <<< Since before the patch enable_cb returned true, thus the goto below
> <<< was not called.
> <<< The patch moves the notify to enable_cb above.
>
> 			printk("Unlikely: restart svq failed\n");
> 			vi->stats.sendq_enable_failed++;
> 			netif_start_queue(dev);
> 			goto again;
> 		}
> 		__skb_unlink(skb, &vi->send);
>
> 		return NETDEV_TX_BUSY;
> 	}
>
>
>   
>> Regards,
>>
>> Anthony Liguori
>>
>>
>>     
>
>   
