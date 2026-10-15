Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DD3EDACD
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050690; cv=none; b=ccvC/E6Ktcv/HTz4W2QLI37G/V2C2QPEH1lXagdeE+daEICIvAsBFwgxGrLop7ZdckXfYFyv7bE3FJQUg2th1PM5/BlGGGmKeKVXcXmpUe/qdaoj5ZMVKepeslvnNApdI/vhPymtqQT35gM2kBqX5GGiSVQN8qVRDtF+0qfT2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050690; c=relaxed/simple;
	bh=HIqwnY3nTL3Cd1I0HsGxndf5y0apu4DDF5jZ467L4pA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UDaiFZAfdw1nWHu+COAL4W1hjoQQUl8UlBvFrX2pjldd/SQMmXUDYA8lmGkWxQDOwkZnj1XpnNmrFb8UmXVmrblJXpOU/lDq0lzP95/nzGF6srovugKLwT1P6cPiIvgllbHpy3V6/XwOjIFCrUmydnZb5kiULpWd5oOfGNOHzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUqjf02z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUqjf02z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7EF1F000C4;
	Thu, 15 Oct 2026 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792050689;
	bh=HIqwnY3nTL3Cd1I0HsGxndf5y0apu4DDF5jZ467L4pA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZUqjf02zhF2o72efmFuNPDlei2cCl5uKkO1H2EU2r4Ufp89dJarP0pMGDgWMp8W3L
	 x1k5QGoAlbQFNnc4O96p/5HIPd4NEtS6yjQ5ncaikc9rRPEbJT/VCgD0gjmejRul0y
	 mo6PMBOwQlhNPjiCtRzNLI4N7Fau8sqpsg8HqxSNts1iYvSHlQ81GQILbsG8v1ytrZ
	 JexTwKm4hDBBleQeXuaD+/fBzg3XTAmHLVIKbjevAgCSr5g6MEwG2GG32BSchJjRvA
	 vaR40dooJS8a0Ptbe8cqjCE/ghIyd/Hgvv1iEJU7cHZYEPKVPhYND5rJh1thQbDX7q
	 N5dYI0rG1JKCw==
Message-ID: <sashiko-outbox-172436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH nf v8 3/3] netfilter: nf_dup: prevent TTL and hop-limit
 underflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <3db2db978957de74be13ba48cc16c5e0829003e3.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <3db2db978957de74be13ba48cc16c5e0829003e3.1792048855.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:51:28 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The IPv4 and IPv6 duplication helpers decrement TTL or hop limit for
> copies processed at PRE_ROUTING or LOCAL_IN. Stop duplicating when the
> value is at or below one, before a subsequent decrement can wrap.
>=20
> Fixes: e281b19897dc ("netfilter: xtables: inclusion of xt_TEE")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792048855.gi=
t.zihanx@nebusec.ai?part=3D3

