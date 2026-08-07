Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0719046E
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063092; cv=pass; b=PVIzY7mE9x97kZWAE2wDZhiF9owSXYAiqk0fpbi0FQMA7v4VvycdN5AkwNS42nBomMckVy0vcwqZd56VSHd4xsf/jhcmAKpNgMsAJvksyUR87kUjTVUuMTQgr6quqOsA3bqzR9L3zz/VXvORC5nuBOh+VrA3130GCaB0efFS9NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063092; c=relaxed/simple;
	bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhQ7zNmUBSuWuYLut2Z5LxW21D+SAkvxOa97FKUrFj4J1RPfP0FGEE9iDmE79Vyx6iGJ79LPA4ixWo4cUZ9eFc8F5j67zQcQCC5MG1Vwuecx17BFa1Uzf8skT+KqqU02LO7wiQfdIKXGgmVwhb/gXGs/gydvTmkvf+HZ8+qHQro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3oCtzqv; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3oCtzqv"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c10ed63c0so71331cf.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 17:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786063090; cv=none;
        d=google.com; s=arc-20260327;
        b=iD58TNBhOuk/FdivjJMasLZ9rj3EI4TBYuyAZ8VJ9HrpadfvZ9AlNLaCAXWQRJcPQF
         WZ5jSX8fO7aByHvqs+oe4lSaDA61y3tDJ+U3LqPF7oB9JQmY/qpC3HBXMFxChnT2iATQ
         aq10LupLOZx2f8jH16oNve1RDfp5iTbBZ5dBtNxfrIsjUvv4+eVPC+M87dS+95I6HMbP
         qocGWo6AlDFRkFIvvEejmcmTjmwhquF6yqV/YmoC2Q2CGX7TWL0/4zemLb+gKL9eIWYC
         p0XuJmRPfrvkzv5TvGJ573BzoCcThHhnPf1107zdb6xJjZLkqPfVX6AnRP7Gl4MsaP8w
         3leQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
        fh=Fqm/qK64mztjP7Owbubtpad0Swm2deHj02oAZYyfm/Y=;
        b=jgmmCCap37y+ImzaozhAWgYaYsKbMFout7eUpjGDU3LTfhCsikukuyN9WCQmEY95ar
         ibNKd/1EWUVOCq3sNlywCk0iuOA36fEeMTH1XZDyN9VMCTE1JmwHZIKywX/VGkDW1dYL
         0no08O30bW3VL7SjGrY6pG/6C1HVMblQr7LxerRPu50LxjJGXruJzTPGA5mrAxOhZbB6
         ptUIW83lq0caNawCn9zwp9kmbikN/bHkhPijyBUTaHynZ54+7/umziDSZ++6aVDgGCH2
         dbN/z6VLvu29TQU/YlX+3Rnprxm2U6GitoXU6cSXNrvnPje1/RD+wilhQiLcQ3C8rqIb
         2bxA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786063090; x=1786667890; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
        b=m3oCtzqv2hlodjaA1GfrnRuYSNkx26f+GGDY21BcYK2QrLPSmEF1txeHYlvGTZJRWB
         ew/UGmD4WSthubWo4Amg868RQ23dY8WvSd4CDOoIH99f6TUnYB14Jr6UNarWv/gd9ofS
         4n6OzNSgdwB97B33prwjfxTnX1N8yK+aPVx0n5ElMrp7/t2dQ7Yvpe6EjsE/ViGci5nI
         YJKinCgVtGw2TXYRTlipp0MXiT4x9WgkhcBJSLiaz2VFCk6NL2XKFt9BQa5k3rUG5XaJ
         MgMMFsichZuD7VJLNuF29esfRHRuwQYmhbIHwsioWSSh/d2ULHUzsMe2lHuclSVPDZXu
         2eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063090; x=1786667890;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRJZIG7PpGC8GI3G9OdkHZpvyVmLP1ZrEzMgLyM7g80=;
        b=G6nSnmMkY6RHXQta83jXEH459XPr+lzI/l6xKqGyolsj1Y0ELGORIpSfF4+iQOtjA4
         sJ+NwDAeCZpW2Hs55NPquJ06cL9H4zAFbijgbEN9IkETujRR37qLj3ZcufsrLJC6ZO5v
         jg7GBj6JAadsw4Z37erUlp2lYAOBBIU5wJy150Uq9sQzg8DGwS9Tesn5SnEGRDoUNeih
         rnYXU5Q6jcGXA6vrbLikWlkVqD5fgclA9Leba1oIgB222DeNaSe75CDmCQRN4jlh+ZDK
         pUFwbQWvvJEnNmRaMcbftTNdFP+aTgJYwBcltHtx3AmDTxmIpSHd26RgQLomASsuZQBP
         hkKA==
X-Forwarded-Encrypted: i=1; AHgh+RpXOID0Y5ytuWhHn2haKfq6oOXz6fqSY4nyHRtBmTTm0rQrrjJYWLeXrhOUHsHkBGIcV8CkEH0ZS4C+ETP9EA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi7+Fqis6tLpATv8jmSSTGnLvssOgHfbTpKwvJzxnIZQUFbL8X
	W7OW7zV6yHLZP/IF3KJViHSrT4tgbASWGvC5f//OFIC2OHGCgV302N5KerJFeIMMAd7gMDUg9ZK
	i/3NEPBi57POXKrZzAPhU4+yQ7OVSchLdReh8xZQP
X-Gm-Gg: AR+sD10Snh05tbKWmgeqaD2+pydK7O0WbMz7yF7JjDW/Nn5xb7uNObUEiY1UznT7gg/
	6dgcaSwqWVxk+ywZp+C52ce09to8LXMPZao8Z7TrRjwyLU8U9OssC+1qw1F1RxVh/L00HWHpeqK
	5jbHfz8UlCeXLO2q7hKzmoxEgk6xFftQ4rgUjygixU/O9NTgzuwEDm4U2cfRUPfH3mtRv3j1oQN
	RejM70Z8VXBOLlZ9iWDrMnMHAmo/WDEuXG7nwSlLlg9qk92Bj3D6Xsg8zGkBtgLqL3It8bng+DH
	cnmP0InM7rcnTSudMsSpgeHxJB8qNdnAgWLocaddsi8qnqyUJdgRcBZ30xaFZw9OK3sAgrYqp62
	+CSpU91IQ+N8=
X-Received: by 2002:ac8:5893:0:b0:51c:104c:100c with SMTP id
 d75a77b69052e-52d106def12mr7006611cf.2.1786063089410; Thu, 06 Aug 2026
 17:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724014605.3377283-1-linkl@google.com> <20260806185414-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260806185414-mutt-send-email-mst@kernel.org>
From: Link Lin <linkl@google.com>
Date: Thu, 6 Aug 2026 17:37:56 -0700
X-Gm-Features: AUfX_mzsCL5eLjoVeX8KOZ2z_HBCF8ziBwe-qf9RCI-8JSE_RZaQA3PJ8CCVsKw
Message-ID: <CALUx4KSGtvswSARWZ9L8rbWsPmSorHaonaSWMT5UvQX9SQSqFA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio_balloon: add VIRTIO_BALLOON_F_REPORTING_PM_SAFE
 feature bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>, 
	Taylor Scanlon <tayy@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 6, 2026 at 4:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This makes no sense to me. So there's a bug in the guest and it crashes.
> Patch the guest.
>
> There's just no chance we'll add flags every time some guest drivers
> on some OSes have a UAF.
>
> What makes this specific bug special?
>
> Trust me when I say UAF issues e.g. around hotplug are a dime a dozen.
> Now what, let's add another one around hotplug? And so on.

Hi Michael,

Thanks for the candid feedback. I completely agree that adding feature
bits to the virtio specification to paper over guest OS bugs sets a bad
precedent, and we will drop this RFC.

To answer your question on why this felt special from our side: in public
cloud fleets with unmanaged customer images (BYOS), we cannot patch the
guest kernel. If the hypervisor turns on VIRTIO_BALLOON_F_REPORTING globally
for memory reclamation, unpatched guest kernels negotiate it blindly and
subsequently crash upon PM suspend. That makes a host-side feature rollout
act as a latent crash trigger for older guests.

We understand your point that the spec is not the place for driver bug
workarounds. We will handle this compatibility gating out-of-band in the
hypervisor / management layer instead.

Thanks for your time and review.

Sincerely,
Link
