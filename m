Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C608172BB1
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796335; cv=none; b=p35ff2AHhseFsAmrTbvJG6Du5W8A57FxCR+rREEEFaXzj3DAo93lCoXrtDL4IQ+ZMLW2Cf1bLup6HsWMSB+9rwfqhvC9TwKngHSYdeKDTwSguXWEoWcmdZzvD7qp+JU3Y8sqY530BS5naMVlCkZr2mexnsKzuJJ0qESUc0D4PXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796335; c=relaxed/simple;
	bh=M0fdYPs04XFI4MSEL3cVB60IKS2hZVnJ4hxKRPFY7Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P86eNU17omEhogWVZE2LFt9U3LktzhO4Vs3BhWxS3kCoP/6BIxLnRO8vvuh1brcoSlVOe3rT2sos9OizGMHDkvyTHaORv26MQhjHTmkBBbUkMAs7mJk4sGZG1YFNj8c883BRqoZZXpbEpmbo4jYZn4qctJXf7QP4Mxuz59Wy7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77bf336171so369969766b.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 07:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796333; x=1721401133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOROqOLL+ICKvSM0IWop1tHiRymkbqTwAK7mSurQUfQ=;
        b=UszA5a69LZ0ELF7ewlBaC9EJiiG8W0pOrwx/jVWj30IKHgi2rsM/RJPGcvuFmSIITM
         F+Z+NoKX8VPDWtuTgyxEJKsVfTWr31N/r0XLIOgPzf4T/6Y3+j3js+/NexiHFl5Fc3WW
         AcmKBt9yPcE8v9oeODBWgj1qD0qq6yxd8o0OYORtsjIkgPPpwcLc6IRWZfjRg+GMv8iR
         Dw6zKcENsZS/QxdUc0a0i7h2Y+jh3yBt1vaH1F5n1NiiaNNqGTE2mor66ZLgY4Nj4qOD
         zb4PQPloPEDqR0wNjtVpwEhStq3g2a9h2wyR+1uKE7Gf++IoP5SshOujzp0zLSI3q8KS
         k93w==
X-Forwarded-Encrypted: i=1; AJvYcCX4nbKayzjdv4rV+VYGqIk14BOm5ObH983W0SJUINWcHvtKCpXITHpKXvQDbkxxNT1vzMvacGBi25IyFagNieahJetBQToTRHXup84UumQ=
X-Gm-Message-State: AOJu0YzGBZpuujcSLiPZCwRd67OhmZ39vgIuPa7zxXfgTnLBnhuJVNsL
	in6kpjmXX1Hw2IDcAr8NUeNwEdcl9t/+776Q+pmvvfS+BgWNyjoQ
X-Google-Smtp-Source: AGHT+IGdKQn3Gzt2+l/urCVxX8FiOJWgFC28dwbx3rOWY/5MmxMdbQp+jutRVTdORLMXHS7jdj6eVg==
X-Received: by 2002:a17:907:948b:b0:a72:afd9:6109 with SMTP id a640c23a62f3a-a799cc6abb2mr241330966b.16.1720796332394;
        Fri, 12 Jul 2024 07:58:52 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc85dsm353984166b.41.2024.07.12.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:58:52 -0700 (PDT)
Date: Fri, 12 Jul 2024 07:58:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com, horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <ZpFEqbibtxoK0Xcn@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org>
 <20240712075432.7918767a@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712075432.7918767a@kernel.org>

Hello Jakub,

On Fri, Jul 12, 2024 at 07:54:32AM -0700, Jakub Kicinski wrote:
> On Fri, 12 Jul 2024 04:53:25 -0700 Breno Leitao wrote:
> > Subject: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
> 
> [PATCH net] for fixes so that the bot knows what to test against :)
> No need to repost (this time).

I didn't send to `net` since this WARNING is only "showing" in net-next,
due to commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") being only in net-next.

But you have a good point, this is a fix and it should go through `net`.
sorry about it.

--breno
