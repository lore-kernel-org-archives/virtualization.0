Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F1281525
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131252; cv=none; b=UYnG2p31f+q7+SQfyo/BWqt22ToYfpZKI6NffSwEPIFXPyWED/ZCWKn6JLEVLqUE1lpyoqFW2fSBxfRRgMrcQMm27EfEL2VzZgVnU/WlyhPbgL2v2IbkcnSpNqgGdteBNV+Nebya8z5jOGJVHEUAmV7/g1UgKvhN5ncF7KQ0NO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131252; c=relaxed/simple;
	bh=4j+00HlElQLUoISmCOPJXqeurRhtEPbVpFjE5IFbxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFtzhgMo/9G57ZXnvQRtRG416bjPL7x1j4nwbLeE+2Vz2bgVcCwKQs4eY/o5UKISKNUNONPhesJMnm1nDey+FHLGwkXADAkQPa3gSgtPaxh1xdoK42gTOt5Q1AJkqyLQ9Yb3GeTBSYvzd58gtG3blCkUIR1TMiNMk/ee1WgKxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qNoKMFCJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qNoKMFCJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782131248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6E5HMCsv8V1TPYr18y2WYeLDGDrIQonKulSBFvWahE=;
	b=qNoKMFCJnFR4CvkeRtR1vTwxlLckCqkvtCcuFiGtfAqIwNWFb9aq9lQmIpydzevkV+OeDb
	0kMMHupSXevfA8IMgrpMaTgCZJY98iYHldvQXt2y7CpqYz77imAP3AyytLFIMQArjyyvX+
	7tI6SUIUVr1FRFSRNSSavnMiRZvUIdQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Mon, 22 Jun 2026 20:27:12 +0800
Message-ID: <BMgCMK8nRYC94QK7N1SXpQ@linux.dev>
In-Reply-To: <20260621182119-mutt-send-email-mst@kernel.org>
References:
 <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <20260621182119-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/22 06:31 Michael S. Tsirkin <mst@redhat.com> write:
> On Tue, Jun 16, 2026 at 07:59:12PM +0800, Menglong Dong wrote:
[...]
> > =20
> > +	vring_size =3D virtqueue_get_vring_size(sq->vq);
> > +	need_wakeup =3D xsk_uses_need_wakeup(pool);
> > +
> > +	if (need_wakeup && vring_size =3D=3D sq->vq->num_free)
> > +		xsk_set_tx_need_wakeup(pool);
> > +
>=20
> why are we doing this here?
> the check after virtnet_xsk_xmit_batch not enough?
> I vaguely think it's some kind of race we are closing?
> Pls add a comment to explain.

Hi, Michael. Thanks for your review.

Yeah, it's for a race condition between user space and kernel
space. I added a comment in V2, which is too confusing, and
I removed it =F0=9F=98=A2. I'll make it more clear and add it in the V4. The
origin comment is:

 * If the sq->vq is empty, and the tx ring is empty, and the user
 * submit an entry to the tx ring after virtnet_xsk_xmit_batch() and
 * before xsk_set_tx_need_wakeup(), we will lose the chance to wake
 * up the tx napi, so we have to set the need_wakeup flag here.

And the logic is like this:

Kernel: tx NAPI is waked up from skb_xmit_done() ->
Kernel: sq->vq and xsk->tx_ring are both empty ->
Kernel: call virtnet_xsk_xmit_batch()

    User: submit a entry to the xsk->tx_ring
    User: check the wakeup flag
    User: wakeup flag is not set, skip send()

Kernel: call xsk_set_tx_need_wakeup(), because sq->vq is empty

If we don't send more data, the data in the xsk->tx_ring will
not be sent forever.

>=20
> >  	sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > =20
> > +	if (need_wakeup) {
> > +		if (vring_size =3D=3D sq->vq->num_free)
> > +			/* we can't wake up by ourself, and it should be done
> > +			 * by the user.
> > +			 */
> > +			xsk_set_tx_need_wakeup(pool);
> > +		else
> > +			/* we can wake up from skb_xmit_done() */
> > +			xsk_clear_tx_need_wakeup(pool);
>=20
> But what if we don't have get tx napi so no wakeup in skb_xmit_done?

Sorry that I'm not sure what "get tx napi" means here ;(

There are entry in sq->vq, so skb_xmit_done() will be called after
the entries in the ring is consumed by the HOST, right?
Then, the corresponding sq->napi will be scheduled, as we ensure
that tx napi is always enabled, which means napi->weight is not
zero, in this commit:
1df5116a41a8 ("virtio_net: xsk: prevent disable tx napi")

Right?

Thanks!
Menglong Dong

>=20
>=20
> > +	}
> > +
> >  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> >  		check_sq_full_and_disable(vi, vi->dev, sq);
> > =20
> > @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *s=
q, struct xsk_buff_pool *pool,
> >  	u64_stats_add(&sq->stats.xdp_tx,  sent);
> >  	u64_stats_update_end(&sq->stats.syncp);
> > =20
> > -	if (xsk_uses_need_wakeup(pool))
> > -		xsk_set_tx_need_wakeup(pool);
> > -
> >  	return sent;
> >  }
> > =20
> > --=20
> > 2.54.0
>=20
>=20
>=20




