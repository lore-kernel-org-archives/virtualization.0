Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BE378D78
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166492; cv=none; b=Z+AnhDgeldG7sZpJGdCxUBeOXp+u4e/Bh24RSPN3QlHZSN09D8UMY+jvkjvgcBFR8sZS97IFKw0lXkrKW6ZF8ElQzSnSt7JSK/nQXWfxEh8cMauhVyE0CcpQAVzeEW4K95BZjTzlY9UTKc0MxQ3gmw/Tdmn2oozJc6PeySs06/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166492; c=relaxed/simple;
	bh=rKmUIYcqB8L2Ay6obih3SxSR+kj4AtD1Nc4NV19elSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+ukSR54BoZe2lSq0cw2GMlWFw6dSN9W9sphJkq3+Gn0ipERVbcXx1GHdNAWtQPGKPnAKi3Fh7MUxhGLSOofOf1LzqFdaK2u8G8bZiBPRrzBaM0QwLBo6WJgCCqX74+95kbQLr+H0DDE7EZ/wyis7RIe+QJJo7G+lVdsRI/cIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9MkMFvF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9MkMFvF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso5265561a91.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781166491; x=1781771291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKmUIYcqB8L2Ay6obih3SxSR+kj4AtD1Nc4NV19elSI=;
        b=n9MkMFvFpQ2tspXitMN/6YPzYdbMbfiU2kRFfILIJ2iv4fIPf5oZVlEiw6dg9GMAjn
         c2r9QqTJc8z6ukmIid3ryLkTRp6oxOAiwdctbIWDmhbwxBb9xPvOPxtZ7k7k66vs2zEU
         22JckPg0JwzCtGEzeA+wMlFmFI0zIfzN7n2LpUXD21RK7gor0pWq8AXxF55vE2cNwa8z
         gbW3e2dSOzsQAUggDcCaq6f73IHFIeGAT+yvKvyU0rV4FWWwLJQysJTC938gJv89rU4m
         2lkR84qqxpD2NJJq0jT/09/285fJj1CmW2+/y+0CpOz0RuVzgv33OExlOx+UX8RSlnKH
         JmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166491; x=1781771291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rKmUIYcqB8L2Ay6obih3SxSR+kj4AtD1Nc4NV19elSI=;
        b=fMjhsmSpoftUaJgS79VtWZPvf0p/uvLcIqGR+teeMLlgYh37uXJMQxcgnd8RImklNQ
         4AP9SYUvN30FEUXvsnyiZwYNBsUfESmCYS6jGmL/CVWAOfANWzrmQgNZLd76JuVGAdi1
         p7evErE73QCG18Z/gw6gOledhD3Keinn92LpV9ra8LXlX3qwUHuMlr+Tgr/B2tGCVimb
         NJdBIYEjBTRY2GruEwekDxBQw118glKpPyU8txCQg6DPbo4rFCvz3lwLa/9gy8WbOHmH
         p1jHzFxTayFgqim5ITx6aKh3lguoe0LXevPKPv7YNooc4vRPhgS2aTRIoLFTCnspvt9H
         ATsw==
X-Forwarded-Encrypted: i=1; AFNElJ9La0D5OgLfGQZAMoKW9hLomfzHwV4zfqY4tVUIJsHgiPc6vblFkH2R9jbzNdS5pPbclKLhDSvueX3KMZXB+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzagmiuM9nydai94au/GJ5V1f9jBSFtaO2yLmi/Dc3SVnQ5WIT2
	Rh91O/YRPlr8SahMNkY3wWYjJ2ipmaWOGSg5GYQshsLRdebO5tq7KOzjNTVs95l8yA==
X-Gm-Gg: Acq92OEat3+/GqOUjHD2k4GFqRIoNhe4NUoyzTV4w00T55bdyp47tWV0kf+THV3GGAE
	frTlqu3wCwz4aybvyMqmaVOOoYeyzWebMyAqKECLSBfd4w9DOuC2qSKFj4ozClv/pCjfzYMfcjO
	vcTGufdX8cMUysgXt7thswHepWISPzvYq36uG/dVPBHAWkBByzqli5+fVz7WjZjSxSK0uY41u1H
	mntJV2e7UyYeOsa3CO+Lut+iGWJfggwTnyTrjrGAThRpIm83OchgqU4qIn3EqIZorKfWUgU/cfT
	Dsi0IAvWgDzcrchV8RICsi8j+cOKjxOmsrX2huCZgX+3AWn92ecDLkWfissC39y0koY4VddHvU5
	Dw/rs/AN47bkesEvci9rxwQTQziDA8pmPNyPe0xrL/0izrkKiJCaMJbCp6FSTK4Rtv5J6JErSK9
	nP5BAlCkKUArIIun8AkbrZpJQT6LMruypvOJdMI17mn6dO+Wp5gNjy9pFhkMR+QmrjsKGsOJ2tN
	34Cgw==
X-Received: by 2002:a17:90b:2f06:b0:36b:9835:cf96 with SMTP id 98e67ed59e1d1-3779cb26174mr2267291a91.2.1781166490819;
        Thu, 11 Jun 2026 01:28:10 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bd0a19sm1341323b3a.21.2026.06.11.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:28:10 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: leonardi@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Date: Thu, 11 Jun 2026 08:27:58 +0000
Message-ID: <20260611082758.580135-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aippcmlliXpO0BXM@leonardi-redhat>
References: <aippcmlliXpO0BXM@leonardi-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 07:58AM, Luigi Leonardi wrote:
> this blank line should be dropped
>
> note: according to patchwork [1] you forgot to CC some maintainers,
> please be more careful next time :)
>
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks for the review! Fixed the blank line and will add the missing
maintainers (horms, edumazet, kuba) in v2. Will send after the 24h
window. Also tried get_maintainer.pl but it kept refusing to recognize
the sparse checkout as a kernel tree -- lesson learned to check
patchwork next time.

Raf
