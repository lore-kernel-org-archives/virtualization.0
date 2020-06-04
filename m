From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 07/13] vhost: format-independent API for used buffers
Date: Thu, 4 Jun 2020 06:17:33 -0400
Message-ID: <20200604060732-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-8-mst@redhat.com>
 <6d98f2cc-2084-cde0-c938-4ca01692adf9@redhat.com>
 <20200604050135-mutt-send-email-mst@kernel.org>
 <b39e6fb8-a59a-2b3f-a1eb-1ccea2fe1b86@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b39e6fb8-a59a-2b3f-a1eb-1ccea2fe1b86@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 04, 2020 at 05:18:00PM +0800, Jason Wang wrote:
> 
> On 2020/6/4 下午5:03, Michael S. Tsirkin wrote:
> > > >    static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> > > >    {
> > > >    	__u16 old, new;
> > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > index a67bda9792ec..6c10e99ff334 100644
> > > > --- a/drivers/vhost/vhost.h
> > > > +++ b/drivers/vhost/vhost.h
> > > > @@ -67,6 +67,13 @@ struct vhost_desc {
> > > >    	u16 id;
> > > >    };
> > > > +struct vhost_buf {
> > > > +	u32 out_len;
> > > > +	u32 in_len;
> > > > +	u16 descs;
> > > > +	u16 id;
> > > > +};
> > > So it looks to me the struct vhost_buf can work for both split ring and
> > > packed ring.
> > > 
> > > If this is true, we'd better make struct vhost_desc work for both.
> > > 
> > > Thanks
> > Both vhost_desc and vhost_buf can work for split and packed.
> > 
> > Do you mean we should add packed ring support based on this?
> > For sure, this is one of the motivators for the patchset.
> > 
> 
> Somehow. But the reason I ask is that I see "split" suffix is used in patch
> 1 as:
> 
> peek_split_desc()
> pop_split_desc()
> push_split_desc()
> 
> But that suffix is not used for the new used ring API invented in this
> patch.
> 
> Thanks
> 

And that is intentional: split is *not* part of API. The whole idea is
that ring APIs are format agnostic using "buffer" terminology from spec.
The split things are all static within vhost.c

OK so where I had to add a bunch of new format specific code, that was
tagged as "split" to make it easier to spot that they only support a
specific format.  At the same time, I did not rename existing code
adding "split" in the name. I agree it's a useful additional step for
packed ring format support, and it's fairly easy. I just didn't want
to do it automatically.



-- 
MST
