From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFCv2 04/12] virtio-ring: Refactor out the functions accessing
	user memory
Date: Thu, 6 Dec 2012 13:15:40 +0200
Message-ID: <20121206111540.GJ10837@redhat.com>
References: <871ug75vp1.fsf@rustcorp.com.au>
	<1354718230-4486-1-git-send-email-sjur@brendeland.net>
	<1354718230-4486-5-git-send-email-sjur@brendeland.net>
	<20121206095237.GE10837@redhat.com>
	<81C3A93C17462B4BBD7E272753C105792457512701@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <81C3A93C17462B4BBD7E272753C105792457512701@EXDCVYMBSTM005.EQ1STM.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Cc: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur@brendeland.net>, Linus Walleij <linus.walleij@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 06, 2012 at 12:03:43PM +0100, Sjur BRENDELAND wrote:
> Hi Michael,
> 
> > > -struct vring_used_elem *vring_add_used_user(struct vring_host *vh,
> > > -				     unsigned int head, int len)
> > > +
> > > +static inline struct vring_used_elem *_vring_add_used(struct vring_host
> > *vh,
> > > +						      u32 head, u32 len,
> > > +						      bool (*cpy)(void *dst,
> > > +								  void *src,
> > > +								  size_t s),
> > > +						      void (*wbarrier)(void))
> > >  {
> > >  	struct vring_used_elem  *used;
> > > +	u16 last_used;
> > >
> > >  	/* The virtqueue contains a ring of used buffers.  Get a pointer to the
> > >  	 * next entry in that used ring. */
> > > -	used = &vh->vr.used->ring[vh->last_used_idx % vh->vr.num];
> > > -	if (__put_user(head, &used->id)) {
> > > -		pr_debug("Failed to write used id");
> > > +	used = &vh->vr.used->ring[vh->last_used_idx & (vh->vr.num - 1)];
> > > +	if (!cpy(&used->id, &head, sizeof(used->id)) ||
> > > +	    !cpy(&used->len, &len, sizeof(used->len)))
> > >  		return NULL;
> > > -	}
> > > -	if (__put_user(len, &used->len)) {
> > > -		pr_debug("Failed to write used len");
> > > +	wbarrier();
> > > +	last_used = vh->last_used_idx + 1;
> > > +	if (!cpy(&vh->vr.used->idx, &last_used, sizeof(vh->vr.used->idx)))
> > >  		return NULL;
> > 
> > I think this is broken: we need a 16 bit access, this is
> > doing a memcpy which is byte by byte.
> 
> I have played around with gcc and -O2 option, and it seems to me
> that GCC is smart enough to optimize the use of sizeof and memcpy
> into MOV operations. But my assembly knowledge is very rusty,
> so a second opinion on this would be good.

Yes but I don't think we should rely on this: this API is not guaranteed
to do the right thing and no one will bother telling us if it's
rewritten or something.

> > > -	}
> > > -	/* Make sure buffer is written before we update index. */
> > > -	smp_wmb();
> > > -	if (__put_user(vh->last_used_idx + 1, &vh->vr.used->idx)) {
> > > -		pr_debug("Failed to increment used idx");
> > > -		return NULL;
> > > -	}
> > > -	vh->last_used_idx++;
> > > +	vh->last_used_idx = last_used;
> > >  	return used;
> > >  }
> > > -EXPORT_SYMBOL(vring_add_used_user);
> 
> Thanks,
> Sjur
