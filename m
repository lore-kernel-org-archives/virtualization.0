Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655C3F076C
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101415; cv=none; b=h7A5gTjz/1PKusjipR6MkIzcLkHv8Jb173pk5sFA5BCyZSHKWCenAw9ffGH9fJGZyxtbtZja4jtfC6xHpZMQ/6S0fbHE5RqvdZSS+mX4icszCS8byFGHDqcoVH/QEFi1/NVSWTEkxN1Qfq2XyGYkzfrAmz9vgwto3RpmLVduqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101415; c=relaxed/simple;
	bh=8IWef6KURFlqgq+HSF/YD/B45xhcgkrBrCAFBIQTx+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4o3tBR4FBZNvWcjRDuhpXsOHozGbx81Q4YlB0cM3vvOpqstJvU1iQooixJZTykctjyg15/hld28MwXGKuHroVy8XVdW6LtIMuAGFrsNmTSlKLUTq5PteWlAGypsEXFqGAHSntF/sOFTYU/yQcB8iZo1RKLA4uZ3d2xAUhmFR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxJ8cGTg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxJ8cGTg"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45d96d21e82so1169971f8f.0
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101407; x=1779706207; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uhQRDXyO9k5Y79/nx1MWTmxBb/gg+LShBDbppKe1X0=;
        b=ZxJ8cGTgmqyYmajcf4bqoZBiY68qM4Std9C1hmt9kqCqMT8rPLV2LzxG07vWSBgkGh
         SWWHNTzKgC+St5y32brpZnK8pGayIsQtS+FRhZ9sFq67YibPxdKGErL3L5lt2wVEe3Ta
         CtPV+8IV9K5yvkkk5MNlNQzgtenT60AjXy3ZXnNU5hXYwoQvk5+bXOsRFAxo303kHWqJ
         RdoQyzmzS5JffZ2VoDRi/bPU5TGzQjKjkS6KhfVKmjcUXti659AVQ8nZcsna23MjSXv/
         usYLajppgSV2UUX6OauFmUaxLxvDUJnC6Tu+DbejYRe6oUkPVIocnpCuoeD1pTImsfdJ
         4Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101407; x=1779706207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uhQRDXyO9k5Y79/nx1MWTmxBb/gg+LShBDbppKe1X0=;
        b=OlPruymaF2zKraVlD1/uke32KD5FXLl/F54GhpqaIkHmL8w9A1GDFR+YJFmLjGi0uY
         4oULIASRy2NRDCB5PZorTgxSeqtXMcYCXUWmf5P2/AEY8Q4G7ana7jRhOq95nsiTourl
         mczao/ZrJByhcrbmKGHh80v5Gk4KZ3upifJTnAXbsnpi9ykPCK6Mws03ecIrg0NEjLa3
         4Wx2h3iiAdzwDL0NDb5EkFueJbxU4Bjl71lNb7jR4jQLjBZcQJ7JhX04xmz+eHxvluWb
         GiLOziRk2cltZ3n9sbRNF+OsDK4piYrZEe/XwOjuDlSDo4QHEPGJRTYxzyYlx3N9k0oe
         dp9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9q47/1OMRPMDy+E+atR17SBZINGTLoEGeDUX6V2xMRWjADgw5ITEowBbHjSOjnGXB4hPbd3X0B71wG6A0xMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrlBR1Z7JBc0bF5UFCGuBlaWkhUVYYRLwO5ljYRqdbu7PnW2iG
	HRa3oVAlq2bOwI+n9TPwb5cjxXYii06FeOt2IJEvOHepSYHL8/2hfi3I
X-Gm-Gg: Acq92OEj3rAojJe9jq1U0LtF70gFjD3gC5nbB6fZGBVFEz+xTRkJqSPjteuOvhm7br/
	FCMDy0wovIt6HpMB663qVifFoilfpzk7djV3EFD0tNlEM/u+De10cs1zZt0iyJVL9Qnjk+1r+7x
	VgYL7sLBnfqdMuVi4CuG8E9xpGAkr7WA6SNtdIAYSYywz+CDBBcPJkRIhp4yZrC7CFfpCcXGQKU
	in0HFKBcY8E6+gr4FIxUjtwKL31Oa4xVN5vrCWLsRWCwDUVlZZ+b7Emu8LDp00zBB5mcA0tpbka
	U93q6sAD00ezr2LwxdsTyoqVOBAg/FQ6jGstrRSbins1Q+wpZEubQSP+RsUCOx5cTbps2L0EKh2
	ucBamZNctYQTpj6FdbBslWjMpBEHmvyclDAaTf1xXDzGpfpo4tupRONz9r/5BfgGTZasMJRNhoO
	8VnDT5dt90NQ0qMKQ/Gx4oZJZsu6LeT7jXPDraTrAGIwm3snFPj14OqnrTuSx2RcwgV+XIQ3h89
	r4=
X-Received: by 2002:a05:6000:2489:b0:43f:e2b7:7160 with SMTP id ffacd0b85a97d-45e5c58fe72mr21734038f8f.4.1779101407360;
        Mon, 18 May 2026 03:50:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm35542656f8f.9.2026.05.18.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:50:06 -0700 (PDT)
Date: Mon, 18 May 2026 11:50:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 linux-kernel@vger.kernel.org, Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <20260518115005.5f13bd2b@pumpkin>
In-Reply-To: <agrg1GVzoJWtNuSd@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
	<20260516125329.7b699c6f@pumpkin>
	<agrXvCtNRlySlwgx@sgarzare-redhat>
	<20260518053223-mutt-send-email-mst@kernel.org>
	<agrg1GVzoJWtNuSd@sgarzare-redhat>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 11:54:19 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Mon, May 18, 2026 at 05:33:08AM -0400, Michael S. Tsirkin wrote:
> >On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote: =20
> >> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote: =20
> >> > On Thu, 14 May 2026 11:29:48 +0200
> >> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> > =20
> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> >> > >
> >> > > When a large message is fragmented into multiple skbs, the zerocopy
> >> > > uarg is only allocated and attached to the last skb in the loop.
> >> > > Non-final skbs carry pinned user pages with no completion tracking,
> >> > > so the kernel has no way to notify userspace when those pages are =
safe
> >> > > to reuse. If the loop breaks early the uarg is never allocated at =
all,
> >> > > leaking pinned pages with no completion notification.
> >> > >
> >> > > Fix this by following the approach used by TCP: allocate the zeroc=
opy
> >> > > uarg (if not provided by the caller) before the send loop and atta=
ch
> >> > > it to every skb via skb_zcopy_set(), which takes a reference per s=
kb.
> >> > > Each skb's completion properly decrements the refcount, and the
> >> > > notification only fires after the last skb is freed.
> >> > > On failure, if no data was sent, the uarg is cleanly aborted via
> >> > > net_zcopy_put_abort().
> >> > >
> >> > > This issue was initially discovered by sashiko while reviewing com=
mit
> >> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages account=
ing")
> >> > > but was pre-existing.
> >> > >
> >> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> >> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sga=
rzare%40redhat.com
> >> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > > ---
> >> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++----------=
-----
> >> > >  1 file changed, 34 insertions(+), 49 deletions(-)
> >> > >
> >> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vso=
ck/virtio_transport_common.c
> >> > > index 989cc252d3d3..1e3409d28164 100644
> >> > > --- a/net/vmw_vsock/virtio_transport_common.c
> >> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> >> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const st=
ruct virtio_transport *t_ops,
> >> > >  	return true;
> >> > >  }
> >> > >
> >> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> >> > > -					   struct sk_buff *skb,
> >> > > -					   struct msghdr *msg,
> >> > > -					   size_t pkt_len,
> >> > > -					   bool zerocopy)
> >> > > -{
> >> > > -	struct ubuf_info *uarg;
> >> > > -
> >> > > -	if (msg->msg_ubuf) {
> >> > > -		uarg =3D msg->msg_ubuf;
> >> > > -		net_zcopy_get(uarg);
> >> > > -	} else {
> >> > > -		struct ubuf_info_msgzc *uarg_zc;
> >> > > -
> >> > > -		uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
> >> > > -					    pkt_len, NULL, false);
> >> > > -		if (!uarg)
> >> > > -			return -1;
> >> > > -
> >> > > -		uarg_zc =3D uarg_to_msgzc(uarg);
> >> > > -		uarg_zc->zerocopy =3D zerocopy ? 1 : 0;
> >> > > -	}
> >> > > -
> >> > > -	skb_zcopy_init(skb, uarg);
> >> > > -
> >> > > -	return 0;
> >> > > -}
> >> > > -
> >> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
> >> > >  				     struct virtio_vsock_pkt_info *info,
> >> > >  				     size_t len,
> >> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(str=
uct vsock_sock *vsk,
> >> > >  	u32 src_cid, src_port, dst_cid, dst_port;
> >> > >  	const struct virtio_transport *t_ops;
> >> > >  	struct virtio_vsock_sock *vvs;
> >> > > +	struct ubuf_info *uarg =3D NULL;
> >> > >  	u32 pkt_len =3D info->pkt_len;
> >> > >  	bool can_zcopy =3D false;
> >> > > +	bool have_uref =3D false;
> >> > >  	u32 rest_len;
> >> > >  	int ret;
> >> > >
> >> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(str=
uct vsock_sock *vsk,
> >> > >  		if (can_zcopy)
> >> > >  			max_skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> >> > >  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> >> > > +
> >> > > +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> >> > > +		    info->op =3D=3D VIRTIO_VSOCK_OP_RW) {
> >> > > +			uarg =3D info->msg->msg_ubuf;
> >> > > +
> >> > > +			if (!uarg) {
> >> > > +				uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
> >> > > +							    pkt_len, NULL, false);
> >> > > +				if (!uarg) {
> >> > > +					virtio_transport_put_credit(vvs, pkt_len);
> >> > > +					return -ENOMEM;
> >> > > +				}
> >> > > +
> >> > > +				if (!can_zcopy)
> >> > > +					uarg_to_msgzc(uarg)->zerocopy =3D 0;
> >> > > +
> >> > > +				have_uref =3D true;
> >> > > +			}
> >> > > +		} =20
> >> >
> >> > Surely that block should only be done if can_zcopy is true?
> >> > And shouldn't something unset it if info->op !=3D VIRTIO_VSOCK_OP_RW=
 ?
> >> > If the msg_zerocopy_realloc() fails then can't you just set can_zcop=
y to false.
> >> >
> >> > It info->msg->msg_buf is already set then I think you have to disabl=
e zero-copy.
> >> > The caller has already requested a callback - and you can't add anot=
her.
> >> >
> >> > In any case by the end of this can_zcopy and have_uref are really th=
e same flag. =20
> >>
> >> I kept the same approach we had before, trying to make as few changes =
as
> >> possible.
> >>
> >> All these potential issues seem to be pre-existing and should be event=
ually
> >> addressed in other patches IMHO. This patch one only resolves the main=
 issue
> >> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc=
. =20
> >
> >the patch is upstream now, right? So pretty much have to be patches on
> >top. =20
>=20
> If those are actual issues, then yes. TBH, I didn=E2=80=99t look into tha=
t=20
> aspect and left it as it was before. We should take a closer look at how=
=20
> MSG_ZEROCOPY is handled.
>=20
> David, if you think it needs fixing and you have time, feel free to send=
=20
> patches on top.

I'm not fully sure how it all works.
Especially the paths where msg->msg_ubuf is non-NULL, I suspect it should
be added to all the skb even if the ZEROCOPY flag isn't set.
I was just reading the one function.
But there did look like some very dodgy conditionals.

-- David

>=20
> Thanks,
> Stefano
>=20
> > =20
> >> @Arseniy can you help on this?
> >> =20
> >> > =20
> >> > >  	}
> >> > >
> >> > >  	rest_len =3D pkt_len;
> >> > > @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(str=
uct vsock_sock *vsk,
> >> > >  			break;
> >> > >  		}
> >> > >
> >> > > -		/* We process buffer part by part, allocating skb on
> >> > > -		 * each iteration. If this is last skb for this buffer
> >> > > -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> >> > > -		 * completion for the current syscall.
> >> > > -		 *
> >> > > -		 * Pass pkt_len because msg iter is already consumed
> >> > > -		 * by virtio_transport_fill_skb(), so iter->count
> >> > > -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> >> > > -		 * accounting done by msg_zerocopy_realloc().
> >> > > -		 */
> >> > > -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> >> > > -		    skb_len =3D=3D rest_len && info->op =3D=3D VIRTIO_VSOCK_OP_=
RW) {
> >> > > -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> >> > > -							    info->msg,
> >> > > -							    pkt_len,
> >> > > -							    can_zcopy)) {
> >> > > -				kfree_skb(skb);
> >> > > -				ret =3D -ENOMEM;
> >> > > -				break;
> >> > > -			}
> >> > > -		}
> >> > > +		skb_zcopy_set(skb, uarg, NULL);
> >> > >
> >> > >  		virtio_transport_inc_tx_pkt(vvs, skb);
> >> > >
> >> > > @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(str=
uct vsock_sock *vsk,
> >> > >
> >> > >  	virtio_transport_put_credit(vvs, rest_len);
> >> > >
> >> > > +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> >> > > +	 * skb_zcopy_set() increases it for each skb, so we can drop tha=
t =20
> >> >                                                            ^ must
> >> > =20
> >> > > +	 * initial reference to keep it balanced.
> >> > > +	 */
> >> > > +	if (have_uref) {
> >> > > +		if (rest_len =3D=3D pkt_len)
> >> > > +			/* No data sent, abort the notification. */
> >> > > +			net_zcopy_put_abort(uarg, true); =20
> >> >
> >> > Is it worth optimising for the 'nothing sent' case ? =20
> >>
> >> What do you suggest doing?
> >>
> >> I followed what TCP does.
> >>
> >> Thanks,
> >> Stefano
> >> =20
> >> >
> >> > -- David
> >> > =20
> >> > > +		else
> >> > > +			net_zcopy_put(uarg);
> >> > > +	}
> >> > > +
> >> > >  	/* Return number of bytes, if any data has been sent. */
> >> > >  	if (rest_len !=3D pkt_len)
> >> > >  		ret =3D pkt_len - rest_len; =20
> >> > =20
> > =20
>=20

