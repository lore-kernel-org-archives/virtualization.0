Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A21194ACB
	for <virtualization@lists.linux.dev>; Thu,  5 Sep 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527011; cv=none; b=KrT5hDNoIQk3dlVoibguaAw3RaGJjSFas82rS7YBeZmg5rJdP4E48UdDSoG7raqdabyoZufz4FsIr8JS8n2lnVWedW9LS9WqpjX3zseX46jjYLSlNKlx9kQJM4rnvfeoelG5nzwB0nYio74tfIMnZDS5R16Ur6j8NqLMU0LbWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527011; c=relaxed/simple;
	bh=h5agUITKl/cgeeW4DQgsZL5oeRnclrtv/Skmb+M64no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odi6kdbVRM5/S6L6DUwSH0LO5aWO34a1g7GEIkGf9y3clhj6T2p5wubxIvOoGAwm9P4H5iIACPcKjxUTqi7dNW4WvSFHrpQUyjA9knZoa64Jtq67/jgIB9+2UDRNCMnefxPS2TJJzctqiEY2EI7N8WgZPUb4OK4qn8XrW1DZmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso270114a12.0
        for <virtualization@lists.linux.dev>; Thu, 05 Sep 2024 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527008; x=1726131808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aILp+FUNY89ZcVUn5gP5CXyAWZIDPOfD7aHJXZkQOc=;
        b=PfwiUf1rerFABagdnPF/wOm5TvRVgIOI0q8TibRPprPBjeI3SZJYuH6LncvuuYgsuA
         ZGgXDk5PKmgPa7wmqViDDBi4z+6KQTLc4gzxSIl5NFvtLhA2L6adcfbchyv6qZfmm+jQ
         jifTmz+z51zN4UZ0iv/S77b4vUUisXxbVA/Jq2j2WxWceuHbuNE3fT73YSkeTHTt6Oy0
         9iwbQXNemb+1sH0PGt0hUKwJowB9QxAgKM47dMey3ik9cf3NcdAFljsaOb1XN0gf9aNA
         O9+MDM7ewYY7dx4kBTQAHpxM/GyxDDoa7epz+n+e+EB4ToZXBFwTwn9wuo0qrYo/20os
         oa2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAkt0sl8ZADc9xsncjfUqaJJs28kx/rJtdTthsb4Iw9FQ19wWAsXSiSjHrce97jUWGJBNpjntVcI6rNzLL/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6LMrdXjVaWZQ5BFeiVbhebMth7/LfmcF4bc0OSeEJ91ZnCM2d
	G7tFSjPZx555QuTKF4cmPvmuxg68x1WTOQVNR4tGB14DusdEv5VU
X-Google-Smtp-Source: AGHT+IEtWO6srusMymzDIGFokmJ8brm6cWt1HRzsrksU5NF9IzLD4bD5OMrwEbqRdmyo0ze0Ti7teQ==
X-Received: by 2002:a05:6402:26d1:b0:5c2:5f0a:4a45 with SMTP id 4fb4d7f45d1cf-5c25f0a4c3emr7211261a12.31.1725527007435;
        Thu, 05 Sep 2024 02:03:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc529241sm960676a12.11.2024.09.05.02.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:03:26 -0700 (PDT)
Date: Thu, 5 Sep 2024 02:03:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com, horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <20240905-sassy-aboriginal-crocodile-cfadde@devvm32600>
References: <20240712115325.54175-1-leitao@debian.org>
 <20240714033803-mutt-send-email-mst@kernel.org>
 <ZpUHEszCj16rNoGy@gmail.com>
 <Ztc5QllkqaKZsaoN@LeoBras>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztc5QllkqaKZsaoN@LeoBras>

Hello Leonardo, good to see you here,

On Tue, Sep 03, 2024 at 01:28:50PM -0300, Leonardo Bras wrote:
> Please help me check if the following is correct:
> ###
> Any tree which includes df133f3f9625 ("virtio_net: bulk free tx skbs") 
> should also include your patch, since it fixes stuff in there.
> 
> The fact that the warning was only made visible in 
> bdacf3e34945 ("net: Use nested-BH locking for napi_alloc_cache.")
> does not change the fact that it was already present before.
> 
> Also, having bdacf3e34945 is not necessary for the backport, since
> it only made the bug visible.
> ###
> 
> Are above statements right?

That is exactly correct.

The bug was introduced by df133f3f9625 ("virtio_net: bulk free tx
skbs"), but it was not visible until bdacf3e34945 ("net: Use nested-BH
locking for napi_alloc_cache.") landed.

You don't need bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") patch backported if you don't want to.

I hope it helps,
--breno
