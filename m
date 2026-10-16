Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A73B635A
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154532; cv=none; b=Gwrh9Q9GszfLbqzylBmXu9nOeWWxeAVsb2OW5reTh1mIWHQsJdfzD7nTn9ft46yuU6h1/3ggpnG/oHHE3uzorXU7HY9qNSvok7yTSGpHM/4Jk4iAyyT/jGo1RixpQrweXge/Br8m1Xee3XfhT7NQvpkLKtp2XChNLCYF7zjZ+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154532; c=relaxed/simple;
	bh=9IsxibH8H1fu13YTsw4omQGlYTH4IxVrnR/QaVesdNU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HsgZ3r8DUJ3pNk4LP3F5RIbDxbUqu13eHFV/vbK8XOkJt5Lj+Qhlom/Ki/X6/t4K89TzudN+yB/Ov4LlDiDi31N9IZFWpH1WvhtKCSr2aALuan/cBicvdNfd+N3rkl/A9Tpm9qcfNIczdrmJK9ueJZ4jQuVYkiF8mRo+RRU9v3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asKL8fXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asKL8fXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8711F000C5;
	Fri, 16 Oct 2026 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154531;
	bh=mATJsOlsJJlUsOnuI7xG8IEPgpjFZXu/v+szBuLdQt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=asKL8fXLW8Bt0yNVgoJPVVzkx85n4So/bE3VfDrp16SIgRYUlPqyT+ezimzs7IVTB
	 pjQNmWWPjbcN9wbFfUKpz4KHktF/riqbJScz0/W+5n68iMfoUsl8plppPP3G7l9/Er
	 tNs/3i1zynlOTxHL4a/Nklt8SbmWEqlSxN04tQkrOUKf5ue6y9miqQ5742blAJfS2q
	 h8n4Ryo4EKKJBYrwHK/7SQ9ekQLUwQGg6eaHqqcZ0r9ymCvsGGF8WOZIpuR/FPYTe6
	 j8qxvnFfwRrcO/2riV9Z9EUrb9u/XESrc6TCIcL2bWTd8yikSB6/CrLmfxAmtFFhI1
	 lMGEfW6V9DesQ==
Message-ID: <sashiko-outbox-174317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:42:10 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] um: vector: GSO metadata lost for packets with VIRTIO_NET_HDR_F_DA=
TA_VALID
--

commit 7c2ce8bab142738766afdbfe57333f1e8eb84738
Author: Michael S. Tsirkin <mst@redhat.com>

    um: vector: honor virtio net hdr conversion failures
   =20
    virtio_net_hdr_to_skb() refuses packets whose checksum metadata
    it cannot make sense of, but the vector raw transport ignored
    its return value: rejected packets went on into the stack with
    their metadata unvalidated.
   =20
    Propagate the failure.

> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector=
_transports.c
> index e1fb2a76fdff5..8b75484586635 100644
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

[Severity: High]
Does the early return above this block cause GSO packets to lose metadata?

Looking at raw_verify_header(), if VIRTIO_NET_HDR_F_DATA_VALID is set in
the virtio network header, the function returns 1 early:

	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
		return 1;

This skips the call to virtio_net_hdr_to_skb(), which is responsible for
parsing and populating GSO metadata like gso_size and gso_type.

For large GSO packets that happen to have VIRTIO_NET_HDR_F_DATA_VALID set
(such as fully checksummed GSO frames from host TAP devices), would skipping
this setup cause the SKB to be passed up to the network stack as an
unsegmented giant packet?

The network stack would likely drop these oversized packets since they exce=
ed
the device MTU and lack GSO segmentation metadata, causing silent data loss
and breaking TCP/UDP connectivity for these specific offloaded flows.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792067836.gi=
t.mst@redhat.com?part=3D2
