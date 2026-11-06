Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957224;
	b=id4h7EpfDiMZ8P0PiBys1b00t3BLgG4yXPynNio/0X2kWZX8+MuaOTO4Q87H0twQBp1V
	 2xyK+ba4rH7oEwCSQ+sf/hjY1F1FetAnEZXq7/5Q2lnyXWHzzBmdLSqF0t4TIKWMlaP2d
	 DGSsrQ9aKr5aO98NagsmHasc1osYPoMKLhMAbaFxRZY/3nIXm3bK+kVQHTznUPlMJBjlC
	 38sga+Vft7G+63+1oNW1B2XXWVLYe5nGOM3OfQnH6DSvdN8P/3EzzzNxqb14lVP9G5xAR
	 gmV52re31LozXwloZARGcgMiz5Ubur3Vfzb4YfePDMzHulCAGqBT0hc4gYZtv5t4eWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hLqKl4DHf1/3oE13SQ+fGSWLoGkn3xwzGKOEnxMd+2c=;
	b=bqr9y0j4DVAs1Febt769kxDyiIvknNN9dzyj6E+ud9J2RMnpocBA3FbySniCOwBAnray
	 f14ys9s+qP5KrgJjPTJHuGpHi8ZbAmwVxxIGaXya4PhKh+E3XVLX5mY5Livu5eePFBYYg
	 xBxPMVZhJ58Ljwuxpqb0sjKkub/GmroCBVy/EEqtM52scvulUTUkNOR+xvCQaH4yQ/7Up
	 B9WJWQL+HTulNEo3YNehI5UmZD7eeLc148hgxudQqx+sW7kYMdKVKgQFkq4a0Eiosv1qU
	 qCFfxw4h2zW7XA7agkGeH2KfKbs/etieX4INbIMo90S0J1q2DQ/mbeM8MU/2K0e/26Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hVCye5Gj;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066BA606A328
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 09:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 066BA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hVCye5Gj
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4697404c2bso48489966b.2
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793957222; x=1794562022; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hLqKl4DHf1/3oE13SQ+fGSWLoGkn3xwzGKOEnxMd+2c=;
        b=hVCye5Gj2F60LlxEXXFtlUSUhqAs7/FJ60OhUdroSEzPAKF90jqE78wMZx+5v2xANf
         m1z23Rc3ZLK2BH1n7lXw7du3V7OBUOhdVDBzWED0EL1DeJiZOgJED+Q2SQK+9dsCqV4F
         84GFCVIcbYHRBV+5gSDkt74eMwlvuUMkd+f3w44D1M5gj+Fxe1yS/MjeakmFq+SGnBgi
         bFtyzSVUhMkQQ8/5NxumZYhsetU+tAPo/RDdF1701zEUV4n5s+jAFwD6kDsNUhqzF4IL
         krIm7oEigk5sDKffOPGietdWGZqROhmj6tD2BJmcy3PUHqctyLIm12h6ca+nTmriPr7g
         OBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957222; x=1794562022;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLqKl4DHf1/3oE13SQ+fGSWLoGkn3xwzGKOEnxMd+2c=;
        b=UqFyziywpDGLtBNjfwf5FW2j8p6kEYgXDga+70CjDqDVngEMmHL3+TzPcNNyTRZkoM
         YBr2NBY5Lct8YRy13k6iJMrvqt5em/hErb/FJ+zMHs5ytxqwo3fj4kYbnNdklvNolOr1
         c4NxzDypZ2amzevpCyKOILPgvSz5b8vJenI1ZB3BgbM9Eh8Yh/KaeS2CMLkpBg79iJx0
         d8q+bfuyNTv86XcOj5nK5Y3IcNpufc+ib4sBTragWKQKR/NnhcQ2MOEDhgCi63jdQjEA
         jHka8pwCDZIvCjjyCHBYPiqafPMTFjUM/LnZYwo8bhj7peNCLqBrzIQjv2Zojg/4rMCs
         uwbA==
X-Forwarded-Encrypted: i=1; AKwUvBz4hJAife7Z4RtQkNfTrmny8FradLQ+fo6zbauNRpFLZU47eDjcbAqAcHfJqvOIOoiRIyOWLubqzVplHwccag==@lists.linux.dev
X-Gm-Message-State: APuU4Z/OGwHs0FlwVl07riy/nbIzsTI/o6X4ni/coeR8nbUi8piw6478
	GHAF/g8O03vipRT8nKWZ6RSZW3zSs4/xB0EG0pAvamdzTL2bWq3vtarV9DkvR0lUDC4=
X-Gm-Gg: AYBFou1JPQW9ShRU7KzsZN2EOOvsdKRdfVejYRrg8YGRvD/F9VsxYFYv04g4vG1reUH
	sy1RLv3eaFAsYyDm3TZVN4hzru+UpyK6pu8Vm4NiRe44jkM4t03LTRhsm/qywCBSHlS6/s3rGHh
	uiTZYukCcgTnncm9jwmVnA3VXKqQUCpG3XnqO5gG+wgvADlldg+tf1x6NV3lmPWUMbOiQYsufgD
	pNlhAM+6wR+nIxmbZxSBxF6K1UqShk/wl9JEcE6DAkYGC9nOHjlOLoNBibQ84IUYpVwFhamPGUX
	0pbgBOEBx/FPwI0epTxNfMLvEgWy1csl0a0ez+s6ohVn5k1mjYtLa5iykWdRNfe4ix2Q0l6txTp
	DUUtpd/+Qg5F3Quk+pzqmaE3ZdQ2ssr+5i+U+xLChlgTbeGsS2JZg5VQPP1czwAACHJ71fXpZAJ
	nhtWJQfpj0+LPTvJHmw7pJptAhh54wLpO1diICTTxpBvtG9444D9WxrwGOJwJ+6WvUf2TQmBXgb
	3X0QYLDNFtz8Zi3K0nkRnhSJ1C5vWdLJ4Nkr9VwsGtFHBmqhTVES20TSE9YhrYi/xpbBdoNQAF4
	Mzg9YPAWhylt9MwJVYtGifJr+t6Y95bHWeLOXzoouH41JkcUS21HiYLDdIwGoa1UErienRe4DSp
	wXDl1RDR8RlZuNLTD5xXZOV3oQYJsravD4U5o
X-Received: by 2002:a17:906:7316:b0:c4d:a05:a2e4 with SMTP id a640c23a62f3a-c4d34b9e16dmr162861466b.20.1793957221759;
        Fri, 06 Nov 2026 01:27:01 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c1ee1sm63006166b.64.2026.11.06.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:27:01 -0800 (PST)
Date: Fri, 6 Nov 2026 10:26:59 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Stefano
 Garzarella <sgarzare@redhat.com>, <virtualization@lists.linux.dev>, Bobby
 Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC iproute2-next 2/2] ip: add "ip vsock" to move the
 guest vsock device to a netns
Message-ID: <20261106102659.77f8ba56@stephen-xps.local>
In-Reply-To: <20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
	<20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 11:30:36 -0800
Bobby Eshleman <bobbyeshleman@meta.com> wrote:

> + * The guest's vsock device is not a netdev, so rtnetlink cannot move it.
> + * The "vsock" generic netlink family moves it with VSOCK_CMD_DEV_NETNS_SET
> + * and reports where it is with VSOCK_CMD_DEV_NETNS_GET. There is nothing to
> + * name in a request: the kernel serves it in the namespace of the socket it
> + * arrived on, so the destination is chosen by sending it from there, and the
> + * reported namespace is an nsid relative to the sender.
> + */

Please be more concise in comments, AI seems to think it gets paid by word.
