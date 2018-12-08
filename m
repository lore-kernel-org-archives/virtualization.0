From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [RFC 3/3] virtio_ring: use new vring flags
Date: Sat, 8 Dec 2018 21:47:29 +0800
Message-ID: <20181208134728.GC29772@dpdk-tbie>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
	<20181207084842.13133-4-tiwei.bie@intel.com>
	<20181207130822-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181207130822-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 07, 2018 at 01:10:48PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 04:48:42PM +0800, Tiwei Bie wrote:
> > Switch to using the _SPLIT_ and _PACKED_ variants of vring flags
> > in split ring and packed ring respectively.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> > @@ -502,7 +505,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  		}
> >  	}
> >  	/* Last one doesn't continue. */
> > -	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > +	desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
> > +				(u16)~BIT(VRING_SPLIT_DESC_F_NEXT));
> >  
> >  	if (indirect) {
> >  		/* Now that the indirect table is filled in, map it. */
> 
> I kind of dislike it that this forces use of a cast here.
> Kind of makes it more fragile. Let's use a temporary instead?

I tried something like this:

u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);

And it will still cause the warning:

warning: large integer implicitly truncated to unsigned type [-Woverflow]
  u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);

If the cast isn't wanted, maybe use ~(1 << VRING_SPLIT_DESC_F_NEXT)
directly?

> 
> > -- 
> > 2.17.1
