From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 4/8] s390/airq: use DMA memory for adapter interrupts
Date: Tue, 11 Jun 2019 16:27:21 +0200
Message-ID: <20190611162721.67ca8932.pasic@linux.ibm.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
	<20190606115127.55519-5-pasic@linux.ibm.com>
	<20190611121721.61bf09b4.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190611121721.61bf09b4.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 11 Jun 2019 12:17:21 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu,  6 Jun 2019 13:51:23 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Protected virtualization guests have to use shared pages for airq
> > notifier bit vectors, because hypervisor needs to write these bits.
> > 
> > Let us make sure we allocate DMA memory for the notifier bit vectors by
> > replacing the kmem_cache with a dma_cache and kalloc() with
> > cio_dma_zalloc().
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/airq.h |  2 ++
> >  drivers/s390/cio/airq.c      | 32 ++++++++++++++++++++------------
> >  drivers/s390/cio/cio.h       |  2 ++
> >  drivers/s390/cio/css.c       |  1 +
> >  4 files changed, 25 insertions(+), 12 deletions(-)
> > 
> 
> (...)
> 
> > @@ -295,12 +303,12 @@ unsigned long airq_iv_scan(struct airq_iv *iv, unsigned long start,
> >  }
> >  EXPORT_SYMBOL(airq_iv_scan);
> >  
> > -static int __init airq_init(void)
> > +int __init airq_init(void)
> >  {
> > -	airq_iv_cache = ) "airq_iv_cache", cache_line_size(),
> > -					  cache_line_size(), 0, NULL);
> > +	airq_iv_cache = dma_pool_create("airq_iv_cache", cio_get_dma_css_dev(),
> > +					cache_line_size(),
> > +					cache_line_size(), PAGE_SIZE);
> >  	if (!airq_iv_cache)
> >  		return -ENOMEM;
> 
> Sorry about not noticing that in the last iteration; but you may return
> an error here if airq_iv_cache could not be allocated...
> 
> >  	return 0;
> >  }
> > -subsys_initcall(airq_init);
> 
> (...)
> 
> > diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> > index 6fc91d534af1..7901c8ed3597 100644
> > --- a/drivers/s390/cio/css.c
> > +++ b/drivers/s390/cio/css.c
> > @@ -1182,6 +1182,7 @@ static int __init css_bus_init(void)
> >  	ret = cio_dma_pool_init();
> >  	if (ret)
> >  		goto out_unregister_pmn;
> > +	airq_init();
> 
> ...but don't check the return code here. Probably a pathological case,
> but shouldn't you handle that error as well?
> 

Tricky business... The problem is that the airq stuff ain't 'private' to
the CIO subsystem (e.g. zPCI). I'm afraid failing to init css won't
really prevent all usages.

My first thought was, that this is more or less analogous to what we
had before. Namely kmem_cache_create() and dma_pool_create() should fail
under similar circumstances, and the return value of airq_init() was
ignored in do_initcall_level(). So I was like ignoring it seems to be
consistent with previous state.

But, ouch, there is a big difference! While kmem_cache_zalloc() seems
to tolerate the first argument (pointer to kmem_cache) being NULL the
dma_pool_zalloc() does not.

IMHO the cleanest thing to do at this stage is to check if the
airq_iv_cache is NULL and fail the allocation if it is (to preserve
previous behavior).

I would prefer having a separate discussion on eventually changing
the behavior (e.g. fail css initialization).

Connie, would that work with you? Thanks for spotting this!

Regards,
Halil

> >  	css_init_done = 1;
> >  
> >  	/* Enable default isc for I/O subchannels. */
> 
