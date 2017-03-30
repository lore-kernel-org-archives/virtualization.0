From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/6] virtio: allow extra context per descriptor
Date: Thu, 30 Mar 2017 17:34:17 +0300
Message-ID: <20170330173243-mutt-send-email-mst@kernel.org>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
	<1490820507-8005-4-git-send-email-mst@redhat.com>
	<20170330092316.2a25e4f1.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170330092316.2a25e4f1.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 30, 2017 at 09:23:16AM +0200, Cornelia Huck wrote:
> On Wed, 29 Mar 2017 23:48:53 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Allow extra context per descriptor. To avoid slow down for data path,
> > this disables use of indirect descriptors for this vq.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++++++++++--------
> >  include/linux/virtio.h       |  9 ++++++
> >  2 files changed, 66 insertions(+), 13 deletions(-)
> > 
> 
> >  /**
> > + * virtqueue_add_inbuf_ctx - expose input buffers to other end
> > + * @vq: the struct virtqueue we're talking about.
> > + * @sg: scatterlist (must be well-formed and terminated!)
> > + * @num: the number of entries in @sg writable by other side
> > + * @data: the token identifying the buffer.
> > + * @ctx: extra context for the token
> 
> I think that needs do that ctx != NULL collides with indirect
> descriptors.

At the API level what happens is that ctx needs to be enabled
at find_vqs time. Doing that will disable indirect descriptors
but this is not visible in the API.

> > + * @gfp: how to do memory allocations (if necessary).
> > + *
> > + * Caller must ensure we don't call this with other virtqueue operations
> > + * at the same time (except where noted).
> > + *
> > + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> > + */
> > +int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
> > +			struct scatterlist *sg, unsigned int num,
> > +			void *data,
> > +			void *ctx,
> > +			gfp_t gfp)
> > +{
> > +	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
