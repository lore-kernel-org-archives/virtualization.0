Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B051812D;
	Thu, 15 Oct 2026 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068436; cv=none; b=aWx5dlfAXKGllvezlIa1tDGNyWj87qGV1vgjmZxRVNkrhq1QLE5YTrhvdL4qmesjuFjWTM9fDRAXkgMqPSTvku+QpsNJkKtkqauAGIEsHDV2TH5xxvzRXJdIkiH8reVInkiAXzY6JMs77ihCPgJMKF3ZMJU29hsODq06YsHvRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068436; c=relaxed/simple;
	bh=2GjxL018+S0bBWJ3yt4EvK7GDpzkncbRDHcSopY91xA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfhOZ2LVFSZWGEHdDE9xSVdNKo4iSwot4emihlErebkh9KJ53FYECUDRtpaafLFXmwOkJb2DUwOlKNMkGfYgPLNOWZNf8szsHpdSYQbVqBFz5U3fftpPqCFroDRsK6g8zzlz/00vblG6wti8o2iXFmadmKkSa4Jqap7SsaVr24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TDpuDTk9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TDpuDTk9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5t7ujz0LRKmYSDnSpxRV4FUu+VgcIx5vzGaUrJmUsOs=;
	t=1792068434; x=1793278034; b=TDpuDTk9Qeh0C8t/h1N/f5hzpRDVJIpwmb8hqpEzi9jZ2aP
	B96gjIXsc91vmuMw4VBkpdrMa0hbyK6Ju/KZdgt84UeE1dq0FysXcR+mXxhPsGgL6F1a0MwLG/yZc
	cg4ki63X7P5A9CKC5DJy2xRvLOakkg9VMI5vs+FnCrB/mN/U+yYss1U5DlpIB0Zhjb3TlXQ6rri5M
	4YQ5+PnlrPQXhIkpsraOPv20+pRSnZs45avKBGjag3ZHqZ2TbiNqeUD55Fo5BqNk/hbPMGlTyIhZs
	w75t2TGikbKQWTPjmNBgQC4jj+Fe5hVOzgkTpKjiM+vLAv7rTPiz1tDSRHd3AB1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHKrO-00000003auM-2yCv;
	Thu, 15 Oct 2026 14:47:03 +0200
Message-ID: <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang	
 <jasowangio@gmail.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>,  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Rusty Russell <rusty@rustcorp.com.au>, Max
 Krasnyansky <maxk@qualcomm.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Thu, 15 Oct 2026 14:47:01 +0200
In-Reply-To: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
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

On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
>=20
> Propagate the failure.
>=20
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector=
_transports.c
> index e1fb2a76fdff..8b7548458663 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
> =20
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;
>  	return 0;
>=20

Seems it'd be simpler to just

	return virtio_net_hdr_to_skb(...);

As far as I can tell, the function only returns -EINVAL or 0 (never a
positive value), and the caller only cares about negative (error) or
positive (no checksum needed), so that'd be equivalent?

johannes
