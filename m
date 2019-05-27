From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 5/8] virtio/s390: use cacheline aligned airq bit vectors
Date: Mon, 27 May 2019 14:03:17 +0200
Message-ID: <20190527140317.5953850d.pasic@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
	<20190523162209.9543-6-mimu@linux.ibm.com>
	<20190527125531.20038f59.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190527125531.20038f59.cohuck@redhat.com>
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
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 27 May 2019 12:55:31 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 23 May 2019 18:22:06 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > 
> > The flag AIRQ_IV_CACHELINE was recently added to airq_iv_create(). Let
> > us use it! We actually wanted the vector to span a cacheline all along.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index f995798bb025..1da7430f94c8 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -216,7 +216,8 @@ static struct airq_info *new_airq_info(void)
> >  	if (!info)
> >  		return NULL;
> >  	rwlock_init(&info->lock);
> > -	info->aiv = airq_iv_create(VIRTIO_IV_BITS, AIRQ_IV_ALLOC | AIRQ_IV_PTR);
> > +	info->aiv = airq_iv_create(VIRTIO_IV_BITS, AIRQ_IV_ALLOC | AIRQ_IV_PTR
> > +				   | AIRQ_IV_CACHELINE);
> >  	if (!info->aiv) {
> >  		kfree(info);
> >  		return NULL;
> 
> This patch looks to be independent of the previous patches?
> 

It ain't a clear cut. It could have been a part of the series that
introduced AIRQ_IV_CACHELINE. OTOH I'm not sure it buys us anything
without patch 4. (I'm no expert on slab allocator so I can't tell much
about the probability of getting chacheline aligned memory if we ask for
a chacheline sized chunk of memory from kmalloc()).

Regards,
Halil
