Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405419;
	b=UXstFW41FPL9B4/6GgwLReUyRCuPXRwsKnp3DLm5Vj/0+KNLxarOFzSXCscpSfIzG9VK
	 tyw+hcsAjymX+La6hzQRCPb62bOUtYtMzDsvLakbOgdtxGPumgFTAHbpu4g0edbzFMiLY
	 JryM5RhrJ65i92dRbvNwR9Tyh5h/5b4QTaZ1hmLxHnMknH3TQDcDsEeFYCufbo9OvtQfN
	 KN1MlOXS7jF+yN4HFZadvWDnQi9UHlxpPxxAvQCP+jj7poLCH4aagBH0xxdWWXmtSLH2E
	 oq5rvZuD/cKaKGaDxRshIzpFqNm38EU2KykdBBW6CmLuKZ+V/U+qIGXVRzyfhC9NILQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=PJ1xEi5CxmTAxZTzTlcHf5/WoU5B2o1tQpmBqrfLjrtvvgbayuFwU9HtrhwxTwB5Jerf
	 xXoQORj+FiSOZ+jhr8NMKK5Z/F+vJfQVYlsWo+P3Ol2n/XdNstf3LV5mMkma7LVwuyjoM
	 C3eXifNPSehA3/wswWafdIyj6eNU7FhGpOfXwwuBDlTHZQI/dqjuYk5lYOtxDJvzdNv8F
	 IvCQXfQP6dIXF1gelUFtnXQqyTuXvM0ZgbnpgNbAsuo+Igr8t2KftqZ/ooeMJCReIGRws
	 VTIH/Ev1KVDkmcH3MrBB7wWHCL6zY/+fIlW5QosE2Luo8zJheD+r8nHyCHe7dwNWCSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT3L0yyo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38547606A324;
	Wed, 11 Nov 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT3L0yyo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0AE1F00A0C;
	Wed, 11 Nov 2026 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405418;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XT3L0yyoPtIu3cfLH/k+LTL8V7cZekjOMriLR+CRGYWUCb/jpCRxQAwnKjhhn1Nns
	 06jxZtlXg5LBVnKoN/jM4mE+P6g0RQh1vY8CT9VBseQBwVBvrjS2VvQZIePcoxfYnp
	 lcv2oORx9ucKM82gG04iPUSCUtT4hDfFv9yuB0jV4T237Q1OonKjB/MRjyNtiKvngy
	 UHSRq/Mmf+/3pvizaaoaiU7vddX2ieWE8jDexb4VbDTyfya0iQHOA5d7+xiAPZOa1v
	 A0LczXfn9IHr7tj3oS9O0Sr7uYfSpWS46U7m8F6ODyJJsIzkXKIXuRoMa94icBZ3tq
	 Cz1ezn7bX6IfA==
From: netdev-bot+sinfo@kernel.org
To: Congjie Zhou <zcjie0802@qq.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: napi: add completion with an ordered IRQ
 mask callback
Date: Wed, 11 Nov 2026 13:56:57 +0000
Message-ID: <179440541756.2168702.17991706426089713368@kernel.org>
In-Reply-To: <tencent_74EA7A2E8BF5758E9C5EF18C9B1CED401D06@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <tencent_74EA7A2E8BF5758E9C5EF18C9B1CED401D06@qq.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
