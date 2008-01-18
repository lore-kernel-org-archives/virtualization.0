From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sat, 19 Jan 2008 09:17:38 +1100
Message-ID: <200801190917.39349.rusty__38913.3354685784$1200694806$gmane$org@rustcorp.com.au>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801190727.36567.rusty@rustcorp.com.au>
	<47910FF5.20206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47910FF5.20206@pobox.com>
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
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 19 January 2008 07:45:41 Jeff Garzik wrote:
> Rusty Russell wrote:
> > -static irqreturn_t lguest_interrupt(int irq, void *_vq)
> > +static irqreturn_t lguest_interrupt(int irq, struct virtqueue *vq)
> >  {
> > -	struct virtqueue *vq = _vq;
> >  	struct lguest_device_desc *desc = to_lgdev(vq->vdev)->desc;
>
> Ugh.
>
> This will be a compatibility nightmare.  I don't see how void* is so
> evil for this, or timers.

The compiler checks types, and we should use it (though note that when I 
typesafed the kthread code I didn't find any bugs, so safety arguments must 
be muted).  The gratuitous casts back and forth are annoying and silly.

The compatibility nightmare is one reason for the previous patch (which you  
didn't understand, I hope it's now clear).

> It's not like there's a huge cost associated with a pointer alias.

True, but this is not about performance.  It's about making code simpler and 
compiler-checkable.

Rusty.
