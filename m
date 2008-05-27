From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio_net: another race with virtio_net and enable_cb
Date: Tue, 27 May 2008 12:36:00 +1000
Message-ID: <200805271236.00439.rusty__39639.1564085663$1211855897$gmane$org@rustcorp.com.au>
References: <200805261129.27718.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805261129.27718.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 26 May 2008 19:29:27 Christian Borntraeger wrote:
> Hello Rusty,

Hi Christian,

    As always, you post an interesting bug!

>         /* Out of packets? */
>         if (received < budget) {
>                 netif_rx_complete(vi->dev, napi);
>                 if (unlikely(!vi->rvq->vq_ops->enable_cb(vi->rvq))
>                     && napi_schedule_prep(napi)) {
>                         vi->rvq->vq_ops->disable_cb(vi->rvq);
>                         __netif_rx_schedule(vi->dev, napi);
>                         goto again;
>                 }
>         }

Yes, clearly if napi_schedule_prep() fails (ie. another poll is scheduled), we 
don't disable callbacks, and another poll will be run with callbacks enabled, 
triggering this bug.  It can only happen if the enable_cb succeeds (no new 
work) then a new packet arrives before napi_schedule_prep().

You should be able to verify that you are hitting this window by putting a 
printk in the !enable_cb && !napi_schedule_prep case.

Now, we can't do an unconditional disable_cb(), as it won't prevent this race, 
and would make it worse if it ran after the other poll's enable_cb() and left 
us without a callback to wake us up.  We could do a disable_cb() at the top 
of virtnet_poll, but I certainly don't want to write the comment explaining 
why.

So your fix is correct and sensible.  Applied.

Thanks!
Rusty.
