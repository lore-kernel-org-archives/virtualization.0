From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio: decrement avail idx with buffer detach
	for packed ring
Date: Mon, 12 Aug 2019 01:05:31 -0400 (EDT)
Message-ID: <904809366.7828013.1565586331773.JavaMail.zimbra__46033.5319208511$1565586343$gmane$org@redhat.com>
References: <20190809064847.28918-1-pagupta@redhat.com>
	<20190809064847.28918-3-pagupta@redhat.com>
	<20190810141213-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190810141213-mutt-send-email-mst@kernel.org>
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
Cc: arnd@arndb.de, amit@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xiaohli@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


> On Fri, Aug 09, 2019 at 12:18:47PM +0530, Pankaj Gupta wrote:
> > This patch decrements 'next_avail_idx' count when detaching a buffer
> > from vq for packed ring code. Split ring code already does this in
> > virtqueue_detach_unused_buf_split function. This updates the
> > 'next_avail_idx' to the previous correct index after an unused buffer
> > is detatched from the vq.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> I would make this patch 1, not patch 2, otherwise
> patch 1 corrupts the ring.

Sure. Will post this patch as patch 1 in next version.

Thanks,
Pankaj 

> 
> 
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c8be1c4f5b55..7c69181113e2 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1537,6 +1537,12 @@ static void
> > *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> >  		/* detach_buf clears data, so grab it now. */
> >  		buf = vq->packed.desc_state[i].data;
> >  		detach_buf_packed(vq, i, NULL);
> > +		vq->packed.next_avail_idx--;
> > +		if (vq->packed.next_avail_idx < 0) {
> > +			vq->packed.next_avail_idx = vq->packed.vring.num - 1;
> > +			vq->packed.avail_wrap_counter ^= 1;
> > +		}
> > +
> >  		END_USE(vq);
> >  		return buf;
> >  	}
> > --
> > 2.20.1
> 
