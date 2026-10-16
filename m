Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CE44CAC6;
	Fri, 16 Oct 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143877; cv=none; b=IPXxOn9F3uT56bg+GZAGYnqyzelfNJITJXmh/OUCRcOGELci5Hz3OtIXbEXB84TZMjpAzbxxc6kJ9a3ErOZF72Q47lHfSoGyzzoHtN50qlaJh8VceMm6zAkoxWQZIGFTKPBWJ7F500BDpE9mCk7kubmrXrDqhY6zrM8PDXuXH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143877; c=relaxed/simple;
	bh=zDWNr4AnOOv1lhYK2bkBkb9CY9qN2RBP5lbHwr3KTJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ph1CyXBbTQMeMg0tf/hlW53ZJuCzYhowoje7QdQBfju36osZ2onFHxstP3PVloy5oN6FzR8xDfDbqErlcuzcHsCNe29RZZE6g5ZNDUVWCKc4+xvgJAJXWq6+A0FHsu9175Nz1rMyRZDuV3iwrJjJTOsDlGvPnM45w4a4KudFNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YiMl1guw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YiMl1guw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f/uMLjCIp2jROhfmRYKxJtNgmOf39cw4XgLVOb0p/jw=;
	t=1792143875; x=1793353475; b=YiMl1guw4CORM986w1ZLKmMOJJy8BezznRuXpSX0cME+760
	OtoMXfkdFcztNjIjoLkCTi6iOT2JZZGS0Pqb6q7+Qne5y+tqLjCRcwcjwwTb2PhzCwUBiV3zG7Lrl
	2FRHVPkDY4PI3d/XNi0seHrtqNsYdzQBqvVaa2+I7eEc1EnbEkSU0tsBmYW7ciBoq0pXs6sLPX0d8
	ByBnBH1UgyhpDCHgzgspBXDfx0dGBlY88Lt6kUrEHAAbyZHY+WEpTmkYR+xrSlu1FoFWrVSyR6h+h
	BrKzNZj7Nphp++c9gayFiak6+Rp+/8oXbk85cfHcGScD+K+NdnRgtHchf+cSAaVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHeU5-00000005eqa-3gLI;
	Fri, 16 Oct 2026 11:44:18 +0200
Message-ID: <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn	
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
 Eugenio =?ISO-8859-1?Q?P=E9rez?=	 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,  Rusty Russell
 <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Fri, 16 Oct 2026 11:44:16 +0200
In-Reply-To: <20261016054142-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
	 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
	 <20261015085119-mutt-send-email-mst@kernel.org>
	 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
	 <20261016054142-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-10-16 at 05:43 -0400, Michael S. Tsirkin wrote:
>=20
> > > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_end=
ian());
> > > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > > +		return -1;
> > > > >  	return 0;
> > > > >=20
> > > >=20
> > > > Seems it'd be simpler to just
> > > >=20
> > > > 	return virtio_net_hdr_to_skb(...);
> > > >=20
> > > > As far as I can tell, the function only returns -EINVAL or 0 (never=
 a
> > > > positive value), and the caller only cares about negative (error) o=
r
> > > > positive (no checksum needed), so that'd be equivalent?
> > > >=20
> > > > johannes
> > >=20
> > > if raw_verify_header can safely return any errno - i did not want to
> > > audit it.
> >=20
> > You already used an LLM and still didn't want to? ;-)
> >=20
> > I checked briefly (by hand) and it seems fine, it's assigned to the
> > function pointer, which only has two callers on the _kern.c side.
> >=20
> > johannes
>=20
>=20
>                                header_check =3D vp->verify_header(
>                                         mmsg_vector->msg_hdr.msg_iov->iov=
_base,
>                                         skb,
>                                         vp
>                                 );
>                                 if (header_check < 0) {
>                                 /* Overlay header failed to verify - disc=
ard.
>                                  * We can actually keep this skb and reus=
e it,
>                                  * but that will make the prep logic too
>                                  * complex.
>                                  */
>                                         dev_kfree_skb_irq(skb);
>                                         vp->estats.rx_encaps_errors++;
>                                         (*skbuff_vector) =3D NULL;
>                                         mmsg_vector++;
>                                         skbuff_vector++;
>                                         continue;
>                                 }
>                                 if (header_check > 0) {
>                                         vp->estats.rx_csum_offload_good++=
;
>                                         skb->ip_summed =3D CHECKSUM_UNNEC=
ESSARY;
>                                 }
>=20
>=20
>=20
> so any negative is fine, but if we return 1 then it will force to CHECKSU=
M_UNNECESSARY
> which I am not sure is what was intended?
>=20
Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
and -ERROR on failure?

johannes
