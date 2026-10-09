Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C432BF5A
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511187; cv=pass; b=r7pue0pbmRYiqqB2+T4qoapBtVTz2dEucN7lFJ5fGx30YjNx8DVwF6PuzvPCTTsNUP488YIdkrhAyL3Taj9QtW81oEzbyXQ7IpIRAuDk3lKMleiOrnXrLSBQGXJcQu+FvIDfjusfUAtI5n0dVEkg0W1TfxDhZ13bBVdudx1jV5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511187; c=relaxed/simple;
	bh=yqtnp6B6FTM3QTJaiUbEanQouvPTHeGKm4iP1qF+XcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jANu2+k5ovSCial+4D011SzjX5lSGAzLgoIDx8T/s0v53Ad5Y1mniFhGfyG4XHYGeAh9wOFOC6sAW4Z8RGjfVWUTjORUs9oog5Ngte9iFypRYIWJz4O7aTeejR45zu81XzAVpmX7xpGheWzqZQREDiWr5Rz2ut5c6KzIsPtkxA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLU0yK6J; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLU0yK6J"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535179e995bso39614101cf.0
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 18:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791511185; cv=none;
        d=google.com; s=arc-20260327;
        b=KeR9oXdS+xsHM5cF4CWQTWQ5DmEiNolWFmWR+Gp4K3CJNNI0IHguaYTnKpGbm+dHfN
         mhL15MixbS53FwI3H8yDOGeSYgt6aEa7e3Ruyv1+C6/G4SYz/3rWq+59aiXMYZTHa6X0
         Ha8UamDxdIRs2Ip3B+TlXeJa0m1j2aHkvNUofY1OsLm+KMF6Yr/u0e4NHtODqh72xEcS
         WhldS4yCfh+9Al/nhJGuYIbCS6Cq1Qp2AttW5jUYWk1VApi1YUMoU3FnuKP7uzoj8vpP
         zokoqCcCSeAJIIrELMVCu36EadkQzXX8f5ae24kbqKOHuyTcdpNFFOIynhPG8ouYpg/7
         lPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        fh=8j4Xtgr4da8nHRF2XMwiHcqUdSGUctgibgVeJqra77c=;
        b=LePUTPkGgzg/TsoOC621FVubftLzsC97Gx9OsDUzPdseUs+MxeXHMDS02W0e5mQ4nm
         EEDkwgPB8k8lDh3ZdJ/TxLu9P7nTUun3OQD+50FCFO1TDtptgexQ4HZHj5UUL+I/Ovz3
         wvbpUn1+z+mTgr36alW0Lmhc2lqKg04F3YqizVBVoSHZmsMrEaNjxpC72ySyJ0m4N8og
         s8nKspWGJqHiRS8V5+VzGLddj+JcxVh5IL92LViyw9ofiVFIPVlQI8sleZPd9ezQ1F2A
         OPZY0INR/5IXlS7YQNhRQCqYO7h3UdLNOPqaWtYVNS/TruJ1d648RjiovMuhVac+0fE2
         J1rg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511185; x=1792115985; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        b=lLU0yK6Jwp27SAvLFpOZyxrNAcq+6pl1mKAu4T7R3bID9OZj3g9EL/Fy43x8ets3aT
         VNlf/F/CmUAoYZJz7y/EfpNwUNdXHVA4+9hWwsfkAjFq0EG9w5eVBQWGjs+AGzmz1ga1
         Ah3eUaM4qBWTc5iQpBY7lpog31bgs5Ve06IA56k5PXzKaHz2Uroo5uc7tzBJJqXtjE51
         RbGs1r47HMjW6xWO6Cn1mDHOQJY0QN8v0LkzFF2+Q8SKOfIvv7m7KTT/w4RfzUIMpzIN
         MB1NuG5M2UiWppv5+4eoPyelJo4RQxUQQyVjizeRJzimjtlYsGTpYqDn81MdPsMnWo1G
         uy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511185; x=1792115985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        b=jTwi8owPV5Y05YVzAs3FUOEOs+I1Y9drdgoUquCJfT5zM74suCDI4hb8tnDxvh6iqK
         G/Gsheo0WMlwrjCCa9O20hv+JG3ENOyo1ih14hu9oLxBn01uBO9UhNKpQkoB7XchtTpM
         dEVQe9AOq1oAchnRbDnwip4HIqa1xlWqdUvtIUVoZP3zXU7vl6hrpBNv+gjGbkTCgxpg
         FD7vfENM22XHg0a/A9vJedE0h+8ZH+wfxtg0QZk/dH84c91iIYo9F3+SP90X+VgA/M1I
         ye67jHBujjMsObIr3rQutwG7Cwu6XPL+ixBe01Y8FNTt1AnhC17AfetGaNz/LgvStXz8
         Mpeg==
X-Forwarded-Encrypted: i=1; AKwUvBw5psQUemLSFEt2qXArZDQ3yGPv1Ra+Llxojt0PT1ETRC8TJA5VAAyIUOuaVWv19NnIdl49xhx36hZ5aFkv2w==@lists.linux.dev
X-Gm-Message-State: AFuF++ky4OlBFk8dyZl4669Z9OXJJHKIvObbiYb+/8HOevpm2wjFeJqs
	8H3lr/s3UT8h9M7e4J+9s/p6Rdpd1ino37gJFVJsy94ppr4occ9e2cranFebo1wSDmCyGl+iTOb
	U2iYCgnrERRNpJOtpJBGDCg38Uc4u/24=
X-Gm-Gg: AYBFou3HRCpXGgTeADrQrXg/Uk3VP1mU0va8ObLPGc5nboWhKpkLa9z3nzz16oIztsN
	4AL47lGBlJMsvg9eNgGsTQSAiRKOtx8TrnIx94gs/JX1kKZBXNgYKC128n32YMOgqeQsxreHyTS
	JZR+1Xnh6bs0o2B1STnCk2cvqff+5gbMnL+7+y5lCNGB17kRSoaz6nSQ9AX2AVxI3hbyr/bLiYT
	CSab6pjtsLUZOUwQCwzNFIaHO99abu5LHG2lsdgSfyEBQ0piUEPIAcPf0wcD9lcH9PxxXVawzV/
	3rCqvL5iExJbYlyYfNkz1VjBOiSOSPrVeyl7WXilyi9KgqUsmbHG9Cc=
X-Received: by 2002:a05:620a:2796:b0:939:6c31:2318 with SMTP id
 af79cd13be357-93ebd25082amr66385785a.34.1791511184421; Thu, 08 Oct 2026
 18:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002074551.318789-2-physicalmtea@gmail.com>
 <20261008100352.706042b7@kernel.org> <20261008100424.4c65ed9c@kernel.org>
In-Reply-To: <20261008100424.4c65ed9c@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 9 Oct 2026 09:59:08 +0800
X-Gm-Features: AclHuK-M9H-4p3UtOJsHP4i-PkRC8HxqoHrUrMNCxQPZMxSFCUBi2fgLcuQpjSc
Message-ID: <CAJwVaMJihVPQmQNXNojB3KSMCyZkK=1tBTZoxffLmkW9LoZHJw@mail.gmail.com>
Subject: Re: [PATCH 1/5] vsock: split socket lookup from locked RX processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, 8 Oct 2026 10:03:52 -0700 Jakub Kicinski wrote:
> > On Fri,  2 Oct 2026 07:45:47 +0000 physicalmtea@gmail.com wrote:
> > > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > > receive state machine that runs under the socket lock.
> >
> > Please add a cover letter to the series and repost correctly threaded.
>
> Ugh, I see the cover letter now, just thread things correctly when you
> repost, please.


Thanks for the note. I will thread v2 correctly.

I am still debugging a conflict with eBPF sockmap and rerunning the
performance tests. I will send v2 after that.
