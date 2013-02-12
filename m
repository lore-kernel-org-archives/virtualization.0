From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/9] virtio: add functions for piecewise addition of
	buffers
Date: Tue, 12 Feb 2013 17:43:38 +0200
Message-ID: <20130212154338.GA4083@redhat.com>
References: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
	<1360671815-2135-2-git-send-email-pbonzini@redhat.com>
	<20130212145620.GA3392@redhat.com> <511A608B.5080007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <511A608B.5080007@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 12, 2013 at 04:32:27PM +0100, Paolo Bonzini wrote:
> Il 12/02/2013 15:56, Michael S. Tsirkin ha scritto:
> >> > +/**
> >> > + * virtqueue_start_buf - start building buffer for the other end
> >> > + * @vq: the struct virtqueue we're talking about.
> >> > + * @data: the token identifying the buffer.
> >> > + * @nents: the number of buffers that will be added
> > This function starts building one buffer, number of buffers
> > is a bit weird here.
> 
> Ok.
> 
> >> > + * @nsg: the number of sg lists that will be added
> > This means number of calls to add_sg ? Not sure why this matters.
> > How about we pass in in_num/out_num - that is total # of sg,
> > same as add_buf?
> 
> It is used to choose between direct and indirect.

total number of in and out should be enough for this, no?

> >> > +/**
> >> > + * virtqueue_add_sg - add sglist to buffer being built
> >> > + * @_vq: the virtqueue for which the buffer is being built
> >> > + * @sgl: the description of the buffer(s).
> >> > + * @nents: the number of items to process in sgl
> >> > + * @dir: whether the sgl is read or written (DMA_TO_DEVICE/DMA_FROM_DEVICE only)
> >> > + *
> >> > + * Note that, unlike virtqueue_add_buf, this function follows chained
> >> > + * scatterlists, and stops before the @nents-th item if a scatterlist item
> >> > + * has a marker.
> >> > + *
> >> > + * Caller must ensure we don't call this with other virtqueue operations
> >> > + * at the same time (except where noted).
> > Hmm so if you want to add in and out, need separate calls?
> > in_num/out_num would be nicer?
> 
> If you want to add in and out just use virtqueue_add_buf...
> 
> Paolo

I thought the point of this one is maximum flexibility.
