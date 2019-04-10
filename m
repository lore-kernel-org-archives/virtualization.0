From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 10/12] virtio/s390: consolidate DMA allocations
Date: Wed, 10 Apr 2019 18:36:43 +0200
Message-ID: <20190410183643.694ccb85.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
	<20190404231622.52531-11-pasic@linux.ibm.com>
	<20190410104649.12cdbcba.cohuck@redhat.com>
	<20190410171254.71206015@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410171254.71206015@oc2783563651>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 10 Apr 2019 17:12:54 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 10 Apr 2019 10:46:49 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri,  5 Apr 2019 01:16:20 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > index aa45a6a027ae..7268149f2ee8 100644
> > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > @@ -49,12 +49,12 @@ struct vq_config_block {
> > >  struct vcdev_dma_area {
> > >  	unsigned long indicators;
> > >  	unsigned long indicators2;
> > > +	struct vq_config_block config_block;
> > > +	__u8 status; /* TODO check __aligned(8); */  
> > 
> > ...I think that needs attention.  
> 
> Yes I wanted to discuss this with you. I could not find anything
> in the virtio spec that would put requirements on how this
> status field needs to be aligned. But I did not look to hard.
> 
> The ccw.cda can hold an arbitrary data address AFAIR (for indirect,
> of course we do have alignment requirements).

I think it needs to be doubleword aligned.

> 
> Apparently status used to be a normal field, and became a pointer with
> 73fa21ea4fc6 "KVM: s390: Dynamic allocation of virtio-ccw I/O
> data." (Cornelia Huck, 2013-01-07). I could not quite figure out why.

In the beginning, the code used a below-2G-area for all commands.
Rather than adding locking to avoid races there, that commit switches
to allocating the needed structures individually. The status field
needed to be below 2G, so it needed to be allocated separately.

> 
> So maybe dropping the TODO comment will do just fine. What do you think?
