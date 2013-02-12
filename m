From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/9] virtio: add functions for piecewise addition of
	buffers
Date: Tue, 12 Feb 2013 20:23:55 +0200
Message-ID: <20130212182355.GA5642@redhat.com>
References: <20130212145620.GA3392@redhat.com> <511A608B.5080007@redhat.com>
	<20130212154338.GA4083@redhat.com> <511A6457.80609@redhat.com>
	<20130212161326.GB4373@redhat.com> <511A6B2B.50700@redhat.com>
	<20130212163524.GB4555@redhat.com> <511A7493.50901@redhat.com>
	<20130212173454.GA5028@redhat.com> <511A842B.1030101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <511A842B.1030101@redhat.com>
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

On Tue, Feb 12, 2013 at 07:04:27PM +0100, Paolo Bonzini wrote:
> >> Perhaps, but 3 or 4 arguments (in/out/nsg or in/out/nsg_in/nsg_out) just
> >> for this are definitely too many and make the API harder to use.
> >>
> >> You have to find a balance.  Having actually used the API, the
> >> possibility of mixing in/out buffers by mistake never even occurred to
> >> me, much less happened in practice, so I didn't consider it a problem.
> >> Mixing in/out buffers in a single call wasn't a necessity, either.
> > 
> > It is useful for virtqueue_add_buf implementation.
> 
>         ret = virtqueue_start_buf(vq, data, out + in, !!out + !!in,
> 				  gfp);
>         if (ret < 0)
>                 return ret;
> 
>         if (out)
>                 virtqueue_add_sg(vq, sg, out, DMA_TO_DEVICE);
>         if (in)
>                 virtqueue_add_sg(vq, sg + out, in, DMA_FROM_DEVICE);
> 
>         virtqueue_end_buf(vq);
> 	return 0;
> 
> How can it be simpler and easier to understand than that?

Like this:

         ret = virtqueue_start_buf(vq, data, in, out, gfp);
         if (ret < 0)
                 return ret;
 
         virtqueue_add_sg(vq, sg, in, out);
 
         virtqueue_end_buf(vq);


> > Basically the more consistent the interface is with virtqueue_add_buf,
> > the better.
> 
> The interface is consistent with virtqueue_add_buf_single, where out/in
> clearly doesn't make sense.

Hmm, we could make virtqueue_add_buf_single consistent by giving it 'bool in'.

> virtqueue_add_buf and virtqueue_add_sg are very different, despite the
> similar name.

True. The similarity is between _start and _add_buf.
And this is confusing too. Maybe this means
_start and _add_sg should be renamed.

> > I'm not against changing virtqueue_add_buf if you like but let's keep
> > it all consistent.
> 
> How can you change virtqueue_add_buf?

Donnu.

-- 
MST
