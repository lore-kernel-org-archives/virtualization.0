From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2] virtio: use smp_XX barriers on SMP
Date: Fri, 29 Jan 2010 15:48:17 +0200
Message-ID: <20100129134817.GA4256@redhat.com>
References: <20100127224222.GA31545@redhat.com>
	<201001281001.09999.rusty@rustcorp.com.au>
	<20100128133708.GA3776@redhat.com>
	<201001290744.59324.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001290744.59324.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 29, 2010 at 07:44:59AM +1030, Rusty Russell wrote:
> On Fri, 29 Jan 2010 12:07:08 am Michael S. Tsirkin wrote:
> > On Thu, Jan 28, 2010 at 10:01:09AM +1030, Rusty Russell wrote:
> > > On Thu, 28 Jan 2010 09:12:23 am Michael S. Tsirkin wrote:
> > > > Where possible, we should use SMP barriers which are more lightweight than
> > > > mandatory barriers, because mandatory barriers also control MMIO effects on
> > > > accesses through relaxed memory I/O windows (which virtio does not use)
> > > > (compare specifically smp_rmb and rmb on x86_64).
> > > 
> > > Xen had a similar issue, in that UP guests running on SMP hosts need to issue
> > > SMP barriers.  Is this not also a requirement for virtio?
> > 
> > Of course it is. That's why I have ifdef CONFIG_SMP and use
> > mandatory barriers on UP.
> 
> Sorry, this was an off-the-cuff comment.  I was concerned that UP barriers
> might be insufficient on some archs.  But I can't find any such archs when
> I actually look (at least, x86, s390 and powerpc).

I see. Yes, smp barriers seem in practice to be a subset of mandatory
barriers.  Maybe a documentation patch specifying this is in order.

> I've applied your patch, minus the first two substitutions:
> 
> @@ -36,10 +54,10 @@
>                         panic("%s:in_use = %i\n",               \
>                               (_vq)->vq.name, (_vq)->in_use);   \
>                 (_vq)->in_use = __LINE__;                       \
> -               mb();                                           \
> +               virtio_mb();                                            \
>         } while (0)
>  #define END_USE(_vq) \
> -       do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; mb(); } while(0)
> +       do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; virtio_mb(); } while(0)
>  #else
>  #define BAD_RING(_vq, fmt, args...)                            \
>         do {                                                    \
> 
> These barriers are actually trying to make sure in_use is set in a timely
> manner (this is debug code).  They're bogus AFAICT: if you don't have any
> other synchronization then you're in danger of nesting and you want to know.
> And barriers might change timing too much when DEBUG is defined.
> 
> Thanks!
> Rusty.
