Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571E2FC003
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933760; cv=none; b=ggdELwHL1iXB89SINU7Dzs9dRVA7pWUTUMJxyAlnLwbH5Sp6L55I2YbqwiLCzXlY3kRs0fAoBCjcPMzpXFgz4qEb4BHhbM7yTpsXQnDraR3WaRvWQx7il5JcZmd7hTixQMMe3aHdY1Z8dD2IeVT7P6wAG0hh9X36iZiRs/MKxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933760; c=relaxed/simple;
	bh=GEJSgsO5Z2xGs50BWLMifrD/+7zn62SbW5k2WUWfB+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=notkpXmPGa6wVCjWbB3gn5KKlwNSgrM+WKyu6iahNGmMG/M3vdjsh907aZHrV/4EyvMdB9PkSIj/K2PAZ+3mhiNaFHm1AdRBZYD4pd+6xWtxalipr9LhA/vekoFr9qP2g/WjBKJQM2KZr5RF5ZWasrUkE2ey/NoxdALsX+NsN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f125e5303so2377957a12.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933757; x=1758538557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojo6oKzvqX8/j4uhWlFtqoPQT5IbRZtxXM8tJo4BfVE=;
        b=mYTtXblQqlXxMCLq9Ju74Nrjf4qUnH0ZGjmWwFG0RqvhMBIepliVWov2y2VQVGGq4a
         Je3nmIr2FN0FJw6R+YZzsMC5AZsMYJT9t8iuNgIe7lbnD144x182ZLDRNr4G/AJu/cbP
         rPaYmE5BBrvNy/UZJv43UTXeGHiGxiGpw5UXFAhU/wDDilPoYvoXjrOTgociLeqDhgj1
         +Y6aYk63k2ywCD61yVPfoEOdcyGYbIMJLckzIvedqxkXVclWFcHNw2j5zf6YoMD0fDRU
         m22kXJxk6edAhFf4cdRfI8+aSrAg8n3vUeQzT4HJNHQcS1rpEm35I9HcAB0pperMJt18
         g1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZWPIB1m4YotN182jBdPAZqflN5yGGXdxV4Nhzbu+YbETeeDfm0VsVpQY/nJgU6c+e32jgayUwq6bzmiYy1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy36tfMXzY+G2kUMedEsywyuDa2e5vf+5kMS87PmJJfpmN3mGgf
	SjBQi/YMC+Qmc6aW9i5Fy9lmyeRyWLi+R/du5tVwHFaFgZYNlqxmQKqa
X-Gm-Gg: ASbGncsB40cS8eTBtWbCqmfUi2rHnGqIRnZ04x7mWvs4FU3CelwrlYOnDTjvJW7Ax/P
	V4bOoGFPlKTXINJ4UFGZRLGSBzW64zBWYF+3zX6lEygl0ZicGdhyvHwpZtrLesMpIsTghKr6/Ni
	nNYctDvueRMtHiZEnDKny1YG/qfjjBPfsbwdEfi3++j/xzuIjA5nnM6On1vfH5U9rJ+GHP4ty+d
	532hdOOC1x02YrZasxhSQAtLM5ZIFOhTtreLrZqC8eDSbTSwF8pU5p0I1UjpplD/4IYlpwZsI67
	rILB3tSg1s6eNi8mUg6qRQvtAJvbaDl8W1WtRBhdPe8Au6OLM/c88XFTMLgosB7/zoa6XQdPbXv
	2+rrmBHc6CISjMD6CKIFCU8M=
X-Google-Smtp-Source: AGHT+IF8ft3JrAFd5dlXi0U7soWJ7mf7bjTrn94XFIguC2L7TjKvuFQf7Q0Ve+zesz+ofCw1EhAFPQ==
X-Received: by 2002:a17:907:8689:b0:b04:84db:c83 with SMTP id a640c23a62f3a-b07c35ccf80mr1242336566b.27.1757933756489;
        Mon, 15 Sep 2025 03:55:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd601sm917014366b.60.2025.09.15.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:55:55 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:55:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Message-ID: <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>

Hello Lei,

On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> Hi Breno
> 
> This series of patches introduced a kernel panic bug. The tests are
> based on the linux-next commit [1]. I tried it a few times and found
> that if I didn't apply the current patch, the issue wouldn't be
> triggered. After applying the current patch, the probability of
> triggering the issue was 3/3.
> 
> Reproduced steps:
> 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 2. applied this series of patches
> 3. compile and install
> 4. reboot server(A kernel panic occurs at this step)

Thanks for the report. Let me try to reproduce it on my side.

Is this a physical machine, or, are you using a VM with the virtio change?

Thanks,
--breno
