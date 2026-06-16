Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2ED32D0FC
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617773; cv=none; b=I+ExVibNjQ+hHNosve8f+xO98gFIuc1AjiBp81nRUNSoDpxYl4/u/INw5Mkn0dyspFFltMb8K+Cm8UookFGizR0RGUzSTspYSp5rWsOsWUcmyWhmJctZ3M9zE5Z3Grk4AjQgI9sL5/6prz12Zvhpa9f/lB3t6gQPgY5ihnMTFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617773; c=relaxed/simple;
	bh=qqXuoXoNvjp4qDCvrGTDj7/LLZWDQAWHA8I4Imc6j+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRpyXaeZ9DdbrWn6jCeYozbfFaRyjKhjL3Cc4DyYNLCEMMdvZiCEBs7iVgLkmcQP8dK6740aQfqbHHmXjCxmJXlg9UYxK0dgfk9/QwrpM64qEjrzYmKgPvVBJtBAiIdjHTwhvza4gb2oORbk0Oz/EVHY6I1rGwlhIE0McjP7+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WSvfWgew; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WSvfWgew"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51778077b28so50943841cf.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781617771; x=1782222571; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsshTlVmdyNb6wSnpo8oIqSGy6qOuJMEcgLTNFP6fPI=;
        b=WSvfWgewi4qMWVKzCTgnEV0oB/FVuGXaAo78Y7q9V0wP3TuEb/5iyHz+0cqlv66BxJ
         Yu4BAhPAJvhKNWcXY4AAz5TlbzLz+ZWOmPBDerXWzqDiQs9JBE/V0s+6pxZOnR2+ljdD
         Q1qTVrk1FVOMTMJtSBULvwUcKwBBuTWYYRzMivJatHI0C+2BaRiKLl7Qc83ti6iQutRH
         bYUGP6V7p1mhVI3sxrjfo3IQV0aJciC7pZYjNV758wMtmEs0AyfEHPnEjnj6+aDm67LX
         nb22g528LxHzxiCQN+34/mZpPvch+VurxFQfzNfFumVngwhgYrlyUwIEjT9shRgA9bHI
         G7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617771; x=1782222571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsshTlVmdyNb6wSnpo8oIqSGy6qOuJMEcgLTNFP6fPI=;
        b=RlVLYbCa1QNK5Ih+Nv0goEd9VKYb0CE3a3xFoSVif4zaYxG3Q4ik8lCLy8t+NdVwyK
         9LcLSgQZ4RvVGbPS7Cr/9f2yLz7rJEnPTfUUFi6UkmNA2R3wpKbKVIAt98MrGXFCuDeQ
         wPdHNiEN54NC7Q8NxhRshcW/K7ITBVwKZRelhCOz21jQqo6CfkvVW3Fz1Ld/cBpHRduz
         JukB22y6Gy32BIAnECXkFE47ikZPrfVLafEmzNfKEEqg0vDDwB7PViUYVW3X8rAmaJ49
         TeQus3jjXifTU/U1KxWRG7SxnbNpm0Awem1W3OpKchDuuvLqxV9c/c2q4fMeO4/NqHnV
         gQ3A==
X-Gm-Message-State: AOJu0Yz1aVLA47f0bGdg2nqR+ZM9HB2dVv3a2gQ1FShkk9adsJ2QhjMa
	5wGgN/sufdNEnSba1ua6QJULCPT5hxuGtXQVSJF9ckdDgIljOW5Q/QLnP+Ru5xd4VeI=
X-Gm-Gg: Acq92OH4gM0GpnhvKLGLUAcg6MkDCJCU5m2DeNuxOpkyNKjv8W+sfuSAjRZIMooSRkr
	z+EuaGhH65Scb58DnW8pPqLN+ZWYCJlGLxJjTqFJz57e3a2xLLIbR/KiwGqHPunlCNQ6biMqy3Z
	e/E42+miw/bBRDbqaeWUnDLTkJmej8dVOF6tzT+I6AqqcmqM1t8ZAZ+O1/TysannZ044rQwsJXV
	aNBIOAe+CyWpRvZxKEAXNw4f9Y6RFZsyAMXgabACNMZFDmkuRLhgnMnsLHpZqSy0ALbh5Sv9kwW
	xGRvP3y2IFNJSwRSqgEXBJUvfp4JezuNW4ZmphP1ry/S5swCmKYVm+PDKq/FrOD/aa2hdLCtPBr
	3U4lSrjpIb5fuK0vJCfkRdPqyeIPYpiRspeEJmzIat4ZYeBD6FAruKEyAbaOGZ675bt0j0p6knZ
	int+syMAVQFbZTzl55h9k436b4if96u4E=
X-Received: by 2002:ac8:7d89:0:b0:517:5f7e:a30c with SMTP id d75a77b69052e-519916ae9d9mr49617441cf.4.1781617771128;
        Tue, 16 Jun 2026 06:49:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:437e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a00desm151217661cf.19.2026.06.16.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:49:30 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:49:28 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, hannes@cmpxchg.org,
	surenb@google.com, peterz@infradead.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com
Subject: Re: [RFC PATCH 1/2] virtio-balloon: extend stats with memory
 composition and pressure data
Message-ID: <ajFUaDX8U40X2oLx@gourry-fedora-PF4VCD3F>
References: <20260513165006.2790857-1-gourry@gourry.net>
 <20260513165006.2790857-2-gourry@gourry.net>
 <8e766803-e68d-4efd-a69e-cec5b2492988@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e766803-e68d-4efd-a69e-cec5b2492988@kernel.org>

On Tue, Jun 16, 2026 at 02:30:34PM +0200, David Hildenbrand (Arm) wrote:
> 
> Nothing too crazy here, however, the question is which of these values we
> actually want to guarantee that we will provide them with unchanged semantics in
> the future ... I guess anything we already expose to user space is alright
> (because it effectively already must remain mostly unchanged I assume).
>

I suppose a risk of them going away entirely?  I suppose that's
fixable but unlikely.

~Gregory
