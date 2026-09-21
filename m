Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E072C21F7
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951679; cv=none; b=JyjHDJDM90625+3KtIKeyA0S8Ln6iQcm+uLfcnGGdDBnq9UE96LCah7HE3Qt7SFRfAJVteEV9OUEV5Mxw+p/Maxw3q6Ffj7Q02UnbHKeKXnrbsIbSwmCKCidaXgqV6+H+ymLlLjsyH+Zzr5PHbER9lua6JkqnzLuj8sGFwIq9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951679; c=relaxed/simple;
	bh=8Np2atyJ5Pty3iSaZ8OyeBApEFr+OT+xsUs9NsS4uCg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sCERSRubkcgC2PD8hKkPCcVw0eh/JeAFv7zAsVFzYecKjvyBceQajvKPREVBpc689g9KI9RDGvzme8DAhIPwlV069qeqp1NMyg3Tq+nNYblRfTfDVQTxUz4I4QYPdcvvqCCqDb2KILnZk0hz0Ije9tjW5LnSy1odrqFcA1ih/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0VAyJi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0VAyJi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71CB1F00893;
	Mon, 21 Sep 2026 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789951675;
	bh=Sg/I8c2ci3YjtlNMPUIwHULsz4R1dmjgtu7mRYa8lMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0VAyJi6alREWwG8fgQzMKdOmfu84JWiNYglFXPm4OZK4v54iYtdrjLiNAR/Qb87K
	 LLrLIZ/jtu0OCjlBgv1I5am2hibnf0coD2vVUcOOc131PVulMYjjxX8gVbH5YrUrNR
	 6rzg9Hm7lKiuKbd1uVlWypSJt/Gfq5Wb4o/THAYzPUPcHcQgpYDtSDWAD0fqxR6Oba
	 XwVwIye5FypyU7Hr/7pSuKwavpicurYkRwjie7QVNA0Vyt4c6sNiEI7PK4e4BTQuDn
	 7Rv2wCiJ2rKZTr8xmk4KwtVxsum1r9NMQqmE7bLv03q73KLohvCFTutT0bJ2jqSGE3
	 o26wFcxhZvPzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/2] ipv4: reject partial checksums covering the
 IP header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paulos Yibelo" <habte.yibelo@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260920004733.6473-3-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260920004733.6473-3-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 00:47:55 +0000
Message-Id: <20260921004755.A71CB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ipv4: signed-to-unsigned conversion bypasses checksum offset val=
idation
--

commit 35b578df884cddd68694d6e6f060c95a3382e235
Author: Paulos Yibelo <habte.yibelo@gmail.com>

ipv4: reject partial checksums covering the IP header

ip_do_fragment() completes a CHECKSUM_PARTIAL skb before reading the IPv4
header length. A virtualization interface can supply a checksum start that
still points inside the IPv4 header after link-layer removal.

> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index a24cc8ee11d3e..ff902a2dd0ade 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -770,16 +770,28 @@ int ip_do_fragment(struct net *net, struct sock *sk=
, struct sk_buff *skb,

[ ... ]

> +	/* Complete offloaded checksums only after the validated IP header. */
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +		if (unlikely(skb_checksum_start_offset(skb) < hlen)) {

[Severity: Medium]
Will this comparison correctly catch negative checksum offsets?

If a TUN/TAP device supplies a packet with a csum_start that points before
the linear data, skb_checksum_start_offset(skb) will return a negative int.

Since hlen is an unsigned int, this negative offset will be promoted to a
large unsigned value during the comparison, bypassing the validation check.

This could allow an invalid packet to proceed to skb_checksum_help(), which
safely aborts the operation but triggers a WARN_ONCE that can cause a panic
if panic_on_warn is enabled.

> +			err =3D -EINVAL;
> +			goto fail;
> +		}
> +		err =3D skb_checksum_help(skb);
> +		if (err)
> +			goto fail;
> +		iph =3D ip_hdr(skb);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920004733.6473=
-1-habte.yibelo@gmail.com?part=3D2
