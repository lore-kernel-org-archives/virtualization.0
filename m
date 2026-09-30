Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D71DF74F;
	Wed, 30 Sep 2026 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743793; cv=none; b=AkDXA1Hm+868l7VgIT5Vknvfh3MJrg9sSXEvk3dZp8AfX6nZnp3/BGTW8KFIAbLtdh+BfVMafD2nO6OXppGI6X02okoLcsKxM19foTkgCCjuyeMBMtwipeKM4s5519gQO9jhb2Mmssh/KMq4BzchGfINBRA6ODF+cbrqGrEY8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743793; c=relaxed/simple;
	bh=MU4ensMjNKh+l73lxZnM7CqGZ4Z01+mtugEUfP23tAM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZnwoJmfmTSEvJJyfmwShYWEwjUq7pVSWzddgYatMUidbqNrJrDnHcbaHkdTY2CTwggT2Z+OrOogo8zNaO4SFkYUgV79NFCml2fwlsZvY/K9RqgbKIHQo4gL1RqSqLkrqF/nyGCXHr+UalA9ZEpuHRNdCyluq2Cw9wEU1anrEEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP9ThLFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP9ThLFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED0F1F000FF;
	Wed, 30 Sep 2026 04:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743792;
	bh=NQGmfD/A6yf35VDVy9GkqnY9NVCb9gygS1h1ssnqxjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eP9ThLFnYIEr9afJanN0biCKK9Ne7Mr7mBwlVjyETXU120taSNoL4OYs5lyaBsTFD
	 qJP58pWjVtcVpoK1fz08jx2bDakRTlbE4aMHeUmPYpjX999vM3RJJ0Ds22BELFBA4l
	 0Nu7x+Pd72uk6/12HBysMSA7DENf8X6iX22uC6zqlORfDG6CTwgBW7PjbmICRvfFUA
	 75sTOX+oJ+mCp6VIrPX7sgIJ1lcWgzGWJT7lkiAcMkgdeJHSKcoNIvMJZx0ced2Fvg
	 VhzDFJDSp+DqKe91gMWjEsc79s7q1tZSNLkd0EJFduQTH9MlyhF1btY5qmiD/O1X5p
	 pAngeMSN5U3Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260930044147.3818241-1-4ncienth@gmail.com>
References: <20260930044147.3818241-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:49:51 +0000
Message-Id: <20260930044951.EED0F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vhost_vsock_alloc_skb() sizes its skb from the total guest descriptor
> length, while virtio_vsock_hdr.len independently declares the payload
> length.  Since commit ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs
> for handling large receive buffers"), large descriptors use skb fragments.
>=20
> virtio_vsock_skb_put() currently changes only skb->len for a nonlinear
> skb, leaving skb->data_len and all fragments attached.  The zero-payload
> fast path skips the helper entirely.  A guest can therefore retain the
> full descriptor allocation while receive credit accounts no payload.
>=20
> On Linux v7.2, 455 zero-payload skbs retained 30,255,680 bytes on a
> 256 KiB receive buffer while rx_bytes and buf_used remained zero.  A
> full-payload control retained 265,984 bytes in four skbs.  The existing
> SKB_TRUESIZE(0) queue budget caps skb count but does not account for these
> descriptor-sized fragments.
> [ ... ]
>=20
> Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling l=
arge receive buffers")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930044147.3818=
241-1-4ncienth@gmail.com?part=3D1

