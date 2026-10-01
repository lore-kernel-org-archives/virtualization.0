Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00243F08C;
	Thu,  1 Oct 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868498; cv=none; b=OR3TlgUsLCRqlSvG9a/A9NsbmJJk8SxoZ6XCF9pVDOlE+NNzkLlz5agJbNjxgx/L7V33brjbs/N8ljlXCmcizjQ6pQKvo9NF/8LBTI/RVH2cyOGIWvvOp/wpNM22fsF9Mn00eB4cvpj9suQBY1JaerqzGhkF0scjPmAbvV6AE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868498; c=relaxed/simple;
	bh=WIrKOpXAEoJS8S9VcJYW+SpcNwD2iFzhSQ8M+f3G09A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbhPUyGEBcHTfVI/uvxrMQE0dlPADTxduttUtJfYeu6PUtPOAJgFIRjjoiux3snpL6qaChcpM6DM73oDQKG4RK8pdVkhlUxhqAJk/EANtqUAGehOXsJ8ch5jLZPlEtXDKRDHKQ60bC38hczDC3i8Joh9RykxtdBOhhUTwgg6T7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQO54bqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQO54bqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A881F000FF;
	Thu,  1 Oct 2026 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868496;
	bh=hb/O+Vc354TnfKOOQf26jmNQGtbeDU8hSXD+peL5HCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQO54bqKjpKLysfex70JNfvPckHkUoOcqsAYhPX4oH+/aMyqX1Nwxe19h5Z/TxkWa
	 4shVeAvIdgNlTwJVMPA9D+hC8xCILwzMIBs/xkj/rhVi0B/PM+qqEgoGnAyYMvDtTf
	 FLZ8rK6pQk4phVEqm/7VMSmmb32BwvIdaoGNo61aCzOX4tESkHOkDQ6++q8sFijgqz
	 rIgDtUZ2lfpZFmYZDEHvjvsRUfU6+l1Jqb8yRjZBATtu28laW+l5rbPnrrH1kXttC6
	 FVUyrLvOsqbMOt3XBgoPEC7ph9Eu4U3D7vBQnV44EFw+kAvb0bDMqUp1+Fk7BBd8Uw
	 ZaAWJlJ0/OKXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: account only unread bytes in
 read_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, bpf@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261001151310.4101006-1-4ncienth@gmail.com>
References: <20261001151310.4101006-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:28:15 +0000
Message-Id: <20261001152816.48A881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> After a partial stream receive, rx_bytes tracks the unread suffix while
> buf_used and peer credit still cover the whole packet.
> virtio_transport_read_skb() dequeues that packet but passes pkt_len for
> both counters, underflowing rx_bytes.
>=20
> On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
> from a 100-byte packet made SIOCINQ report -40, an empty recv return
> ELOOP, and poll report the empty socket readable.  After verdict detach,
> receiving 40 bytes wrapped the counter to zero and hid those queued bytes
> until one more byte arrived.  The fixed run kept the counter balanced
> and exposed all queued data immediately.
>=20
> This was found during an LLM-assisted manual source audit of VSOCK
> receive accounting while re-evaluating virtio_transport_read_skb() after
> CVE-2024-50169.
>=20
> Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
> full packet length for buf_used and peer credit.
>=20
> Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream =
sockets")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001151310.4101=
006-1-4ncienth@gmail.com?part=3D1

