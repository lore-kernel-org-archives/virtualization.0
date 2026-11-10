Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326804;
	b=GIa+Hm9PkRNyzCJNBDuzGiDu453IRVveDNvIGz5GkyDzo3peJOjY6kmP4J7tysBMyq10
	 GnnDrY+Ii77gQlYtXbuY7eYmpGaUKBugj28E+I34mEpfZW9yTwidwdIV1PPxPeWz5NYHU
	 pTe+gB795/hLyUHmjDkDYmm99r0O71CkSQu8p2HVzRKnuiRu24/l0zih3pILhKTvwecWI
	 fFwAYQgOHvi1ApJtpjA+h/pb1osnMRCCfWR/r5R6GjBMED4K+HlcV5LsE2TT25n5pa3QG
	 SPeFbnm1fiscVXBDQvgLO7LVaISXsRAhv4gzif0AI6Wv4qof/1a/7yF+EhXQ0IRXjCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
	b=4fHKjLcaia0bueOkWteL48zPiNCMLPzNbcucBE0jWNZMho56O/5tOFFInqDjN7ha+o3J
	 j7ufhloYXXSCTDlfkqavpt9TPwRZc11Xvto9A536R3wFiFUxSiHuuvj7dBMU61abpDveK
	 0ub6dilL4DLDfXvvChFbrgNYBalzvDUObEPCFfNJgORgiXJTpvT/iOhyX9Y7/svAjwynw
	 QOw47UEYNIDC0wYDVOwneausQGQdHh46wUiDB/DqY14ylyAfSYx5JSt+OdvHFrWIY22Yr
	 hckFMBzwF+uO2FCbDKyncFojH2aqLZQntw1HhjfExrifmAqjqyZ6AQUq8qOPYB/dSkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=CFn6U3oo;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF0606A32D
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFFF0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=CFn6U3oo
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c5059958d61so106788466b.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 08:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794326801; x=1794931601; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
        b=CFn6U3ooKnrvFzp7X6pNKT1vDMuE2hQs/pf4kjLtKh61IyV6FqZjoWC+2+tr2Ce0jQ
         nkb6oii1Q+GioK6M7YNKcyzIDTRBzYOvsu88gQvNtleSeCY5oFnB8lnF5oHKT8/qd1K0
         X810F++Aa1YhjgUhYVQiwdZP5YS+x+ZxfjI/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326801; x=1794931601;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
        b=u0KfqYEGS+OHM+BDwasq2+nSWY01ILeSBWvE7zguSUekn8ArUlWtZp+yaeTZk4CFyk
         MdjmYC4Yum4OvgDbdz6W8R8XRGLvW6p/T2w6qJ90vjO/EsJm6hzsMxkmOTeikcu9ZWOC
         YNgZsoUkWqHQXhZinrObYriH08kqobbd29AFjaGXaVZjKM2AuPdIzFiHEYmzJHCcy4Lk
         U+UGjbyEcGn8wViqC3LF5eFtWvnA78soC8oy6J5b/yMCj/Ovmmcu58uCJSNMsPVR/can
         oZ1bwrSD29HX8H/t7AmtFV1Xl5/wSMyShfdaFCb/iszPE3OvOhRpulY5weiaJIvsZ4Le
         WrZg==
X-Forwarded-Encrypted: i=1; AL+hErE9DLuLQXpRGOJ/cIWYKdzg6zrWrhIDNduH4otaS0FuewwWmZIsiGxPpaJNIAcwZ6mgveXLnZKGE1wiYG+hcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9j2T/OFn9Wp7LgGK3qDzVCmbhBcPYmBq5TzI7cWw4MEanopElO
	6bmilXrhFsVLnvJGOtZzxOPr7IYZ6RH8NP94+DDRj2VJett2Hhpz+Lq56yBMWy2W1y6279y6fC4
	KSJx0EAbTrg==
X-Gm-Gg: AYBFou21kfCv9m/cwdfEcMdKpmsamJdGsFsQadqc9oUZ0yJ056Oczag1f/IaRgYUZa/
	i9ig3JN9OY/FuzOjPlR+BRHUVpNHApMKBzO8MF/B9Wyneybg5bK2YuxP9MunBtxQXSwbEo4OvuU
	i3DDRiajL5jj5bAHAt+P2mYnptvCRHegRvHgvO6/J/ZzwqtUc5jiXapVSiUwWGeWlrMLzRdThtJ
	tj1703bsq4jSCrAOaPAXcxfOlTjQEk+tFYpqp3ztbxRBkVaUZ5RSja0K3Y5fp2VHoIKRssOTrWf
	a0Yyr1Kim3SesrF26Uo6qEgOvxPSrPoUyK/s34rxorlLLCSMfkLDlIEA/1E4eUbEyuXjNomTmHO
	yCK7cRwdrJMfyeAedd2ZHL4dOj/W8TGvv7m73PdXkWo0iAR5Q823cKwsxh9SjyXmtfM/CTJrgJb
	K0HS2ENoPb6PlspxVvmcChzGTv1riBsklpnWuqUII+9NV4Lhn29Tg7uXpOFJHtIR3AABkefTiUZ
	h6cUqwdr9Mf8rXgjbyS9ZoKiGRgUuzpgZyho+mV7ciOhliRqZ0J/FdI3qrfDDO2v6iWRCOOLycm
	nzJ1s3lGvYKcvi2nF/PYxucdhoVU5y5gb5qY4h7Q0e4QXRceavyXOIJxD2UGs32AEhVC2B36php
	3/WQ=
X-Received: by 2002:a17:907:1688:b0:c41:4512:560d with SMTP id a640c23a62f3a-c50631d9dafmr5548566b.16.1794326800967;
        Tue, 10 Nov 2026 08:06:40 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5913f3sm125570066b.33.2026.11.10.08.06.40
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:06:40 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c169ae1cb26so344278666b.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 08:06:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFBdUn/0f5lppHwJfEEPLjot0MyeQCWiPKMPCecv4Yn8pRJ86jY60abE9olM0+tNg78yq1S5kaj1SMaU0//DA==@lists.linux.dev
X-Received: by 2002:a17:907:1b16:b0:c49:b6db:1 with SMTP id
 a640c23a62f3a-c50633ba346mr907966b.12.1794326403910; Tue, 10 Nov 2026
 08:00:03 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org>
In-Reply-To: <20261110145241.536019-1-kas@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Nov 2026 07:59:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>
X-Gm-Features: AclHuK-OUBoi1ZcEDjO00AEWOGxItrkKuC6wgZXx5y_lLM7MJshUB6roN-XGzXI
Message-ID: <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] splice: remove pipe buffer stealing
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 06:52, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
>
>  11 files changed, 26 insertions(+), 360 deletions(-)

Ack. Lovely. I'm considering just taking this as-is now, rather than
delaying it. Comments?

               Linus
