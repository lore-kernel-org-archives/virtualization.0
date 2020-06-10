From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v7 03/14] vhost: use batched get_vq_desc version
Date: Wed, 10 Jun 2020 11:13:36 -0400
Message-ID: <20200610111147-mutt-send-email-mst@kernel.org>
References: <20200610113515.1497099-1-mst@redhat.com>
 <20200610113515.1497099-4-mst@redhat.com>
 <CAJaqyWdGKh5gSTndGuVPyJSgt3jfjfW4xNCrJ2tQ9f+mD8=sMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJaqyWdGKh5gSTndGuVPyJSgt3jfjfW4xNCrJ2tQ9f+mD8=sMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2020 at 02:37:50PM +0200, Eugenio Perez Martin wrote:
> > +/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
> > + * A negative code is returned on error. */
> > +static int fetch_descs(struct vhost_virtqueue *vq)
> > +{
> > +       int ret;
> > +
> > +       if (unlikely(vq->first_desc >= vq->ndescs)) {
> > +               vq->first_desc = 0;
> > +               vq->ndescs = 0;
> > +       }
> > +
> > +       if (vq->ndescs)
> > +               return 1;
> > +
> > +       for (ret = 1;
> > +            ret > 0 && vq->ndescs <= vhost_vq_num_batch_descs(vq);
> > +            ret = fetch_buf(vq))
> > +               ;
> 
> (Expanding comment in V6):
> 
> We get an infinite loop this way:
> * vq->ndescs == 0, so we call fetch_buf() here
> * fetch_buf gets less than vhost_vq_num_batch_descs(vq); descriptors. ret = 1
> * This loop calls again fetch_buf, but vq->ndescs > 0 (and avail_vq ==
> last_avail_vq), so it just return 1

That's what
	 [PATCH RFC v7 08/14] fixup! vhost: use batched get_vq_desc version
is supposed to fix.

-- 
MST
