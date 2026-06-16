Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0F46AF15
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625507; cv=none; b=U2mylQOdJP3/efZggLzM37N6WJ4hdB9SpH++r9xuIExgVKQFu80z3jo6lVWibGH4WZIqcEBU3wa+loLLpWkNKYJjFVW4PHUZI+VR7dD512z0qP2BPupWuJ+pwreFIBO4zDA/XPkWjxbBtSeIRz5T9U9ncNCOWGL07TeE7GhVCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625507; c=relaxed/simple;
	bh=OxGw8gIPrZI6zYpv5MGh3fefGE/GJF3a2SBplDqwZHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plNKXwBLDQ+vu2OaU0eZGpIyhhA9bdYCahNUY9aTdy47kB0XBxSspyTx4ldTYxmKvMBQ3nG3odiSzGNYlpNbZCz0HFCp52wnxXyXz93CRM1zL+26/mowy8/RWFoo8FPhwmB+28MdAHVGVBTiKE/JiLRMjENBK8l5bcmMBHRw3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KZbiy0Uy; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KZbiy0Uy"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5175b6c4e19so47161171cf.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781625505; x=1782230305; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnjgbRc5DwJL8N3kiFE/KwxjrcYUQVl99Jg8VCVVxEQ=;
        b=KZbiy0UyNiquHv8M4FKl25rDOgqBYLg3WYwBHFa3frETVFmluRGOuZJj0+0sgrNFwW
         iA+fRVZsyd79gU2qecqILS97FDoxEaK30TI2xKT6l0RXq8IyB2B/oZvf0SJbsu7d1/PK
         smBTg93JZHv3g7oH53YLBn1tlkGNDs3fmXpAtF0jm28WCTIW83r3F72zSwgko56AcR55
         3PcE8+4zS/Esdh+0VtfIkWe5uiTzjvD2A7pTq1loak0wNQMXRCgQepFqI34ZYYi6pjvV
         bk2Krmh6ErCmwgYUzlbiW9DerE4+a03BMBOV02YpmtUJRXHUegZodxzl0sAw7qaLJQT2
         qoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625505; x=1782230305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnjgbRc5DwJL8N3kiFE/KwxjrcYUQVl99Jg8VCVVxEQ=;
        b=AlSWjuYTqNj3Zs5EJG8JQlJbCjnbU8OEfwF/YTUdTRtq/0wsVPuBDRPr1oUdg4fFew
         Z494NVgwh76sDi84apOAXJf/1XFZq4zn70K10UBYbnTjn4pQfO23HwsmxkYqhEhrQovE
         LWlSsmp4IQJ+NujTTD5kM/v6tEx9mKS/dY3YH/PyPVtCFWJZsuudpdzPs6ygkjJpeIKI
         l2inKPV3HAGeenC2pHA4vvyjWQCOR8J31Bm+hKcjUCpTi0txZeQX/inh+sL54uHhwHIA
         jOf0Y9rky/KogjXH6BDWh0u20V4bocdVQ4M1nvG23Ko0W+G+bly2iB1rr/+uQmhUPpCF
         kM0A==
X-Gm-Message-State: AOJu0YyLGmTar7RiW5JTLbksWYHO+sEyuoLrogFf1+a7UhcShBjVJ4YN
	hk06DCRlhT+JSGQ4kEmqP4xohcp6gVm43g/lBWRkHiU/TTLG9VbjbOxC0iZfxQJjm8U=
X-Gm-Gg: Acq92OEShyboSeLiK0RF9C3O1fuZGN2biT9bMq3XuSIKRWnjCsVPHfEljUaVMDB2pyV
	/OgDkm93pcQD/peT4TFDuudCYh1AhroG5wcdXngrenbEjxUzGZgbZpYK04PvHJetwZR2M35qeLK
	eQqKtwOk1HIU+uR9j74WbKQ+7TmXSwjjGeCuAobkP7M5k9MFO+WIgNz1TOmlYESdQIuX35jGInN
	ABfEkm25H2MXaw7+PkMQfLPYW3MD0Cx2ad6HFvdnukPPRbRkg0HESs6RtyqYG5MFjCoZcgWGvco
	zY0Xa3ur1A+FNstzIis1sgLgV4WWy17d+tqyZ+rUNfEI2M6+tq0CGshiDYvv+KbNPzhNsy28+5O
	jkAYpcsM21/KMdxSiJTjXge0Nu3+zE/PhxsfjfzheHzCDcrHmlZsmiPLfo4rMjhiZ2/Y8ANwghb
	qCQw+3/YKNK6mGB6/Z2xA8
X-Received: by 2002:a05:622a:998:b0:517:58f6:29c3 with SMTP id d75a77b69052e-519a8fa678cmr1215241cf.32.1781625505045;
        Tue, 16 Jun 2026 08:58:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:a3aa])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a2227sm142134741cf.16.2026.06.16.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:58:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:58:22 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, hannes@cmpxchg.org,
	surenb@google.com, peterz@infradead.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com
Subject: Re: [RFC PATCH 2/2] virtio-balloon: add stats push mode
Message-ID: <ajFynjvnntxVy2m7@gourry-fedora-PF4VCD3F>
References: <20260513165006.2790857-1-gourry@gourry.net>
 <20260513165006.2790857-3-gourry@gourry.net>
 <feee7831-aa82-4f02-b5e4-cffe7818dc65@kernel.org>
 <ajFWRhSNsOBoUfb5@gourry-fedora-PF4VCD3F>
 <4d8ddf50-e032-44a9-84d4-ddf2cd0c5bf6@kernel.org>
 <ajFhOa5kEkPfqPVD@gourry-fedora-PF4VCD3F>
 <3e7d2d74-ceb2-4064-928f-921401fea75e@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7d2d74-ceb2-4064-928f-921401fea75e@kernel.org>

On Tue, Jun 16, 2026 at 05:52:29PM +0200, David Hildenbrand (Arm) wrote:
> On 6/16/26 16:44, Gregory Price wrote:
> > That makes sense, although don't you just push the blocking operation
> > into yet another thread on the host?
> 
> I think timers are run from the QEMU main thread, so no separate thread just for
> the timer.
> 
> And IIRC, there will be no blocking. At least if I understand your concern
> correctly.
> 
> balloon_stats_poll_cb() will do a virtqueue_push()+virtio_notify(), which will
> notify the device. The main thread will continue afterwards doing what a main
> thread usually does.
> 
> A VCPU will process the request in the VM and send it back + notify the device.
>

Entirely possible I just bungled the interaction then and/or CH's
interfaces introduce a blocking op that shouldn't.

Thanks for the feedback, we can probably drop this patch.  Unless
there's any particular pushback for 1/2, should i leave as-is or
resubmit separately w/o RFC?

~Gregory
