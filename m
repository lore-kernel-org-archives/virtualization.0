From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: switch to dma_XX barriers for rpmsg
Date: Thu, 19 Apr 2018 20:46:17 +0300
Message-ID: <20180419204017-mutt-send-email-mst__8133.15963973782$1524159876$gmane$org@kernel.org>
References: <1524159181-351878-1-git-send-email-mst@redhat.com>
	<5047d08c-9f9e-2902-d425-1fac849ce5b4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5047d08c-9f9e-2902-d425-1fac849ce5b4@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 19, 2018 at 07:39:21PM +0200, Paolo Bonzini wrote:
> On 19/04/2018 19:35, Michael S. Tsirkin wrote:
> > virtio is using barriers to order memory accesses, thus
> > dma_wmb/rmb is a good match.
> > 
> > Build-tested on x86: Before
> > 
> > [mst@tuck linux]$ size drivers/virtio/virtio_ring.o
> >    text    data     bss     dec     hex filename
> >   11392     820       0   12212    2fb4 drivers/virtio/virtio_ring.o
> > 
> > After
> > mst@tuck linux]$ size drivers/virtio/virtio_ring.o
> >    text    data     bss     dec     hex filename
> >   11284     820       0   12104    2f48 drivers/virtio/virtio_ring.o
> > 
> > Cc: Ohad Ben-Cohen <ohad@wizery.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: linux-remoteproc@vger.kernel.org
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > It's good in theory, but could one of RPMSG maintainers please review
> > and ack this patch? Or even better test it?
> > 
> > All these barriers are useless on Intel anyway ...
> 
> This should be okay, but I wonder if there should be a virtio_wmb(...)
> or an "if (weak_barriers) wmb()" before the "writel" in vm_notify
> (drivers/virtio/virtio_mmio.c).
> 
> Thanks,
> 
> Paolo

That one uses weak barriers AFAIK.

IIUC you mean rproc_virtio_notify.

I suspect it works because specific kick callbacks have a barrier internally.


> > 
> >  include/linux/virtio_ring.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > index bbf3252..fab0213 100644
> > --- a/include/linux/virtio_ring.h
> > +++ b/include/linux/virtio_ring.h
> > @@ -35,7 +35,7 @@ static inline void virtio_rmb(bool weak_barriers)
> >  	if (weak_barriers)
> >  		virt_rmb();
> >  	else
> > -		rmb();
> > +		dma_rmb();
> >  }
> >  
> >  static inline void virtio_wmb(bool weak_barriers)
> > @@ -43,7 +43,7 @@ static inline void virtio_wmb(bool weak_barriers)
> >  	if (weak_barriers)
> >  		virt_wmb();
> >  	else
> > -		wmb();
> > +		dma_wmb();
> >  }
> >  
> >  static inline void virtio_store_mb(bool weak_barriers,
> > 
