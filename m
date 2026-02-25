Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C523624BA
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025685; cv=none; b=EctliW2GUOnvqQny8aGMb0U7l85aNOzRHC8GMPUzOVfKHy+0wzi/OE9EHu3R/reL2mpRhA8nQtY/Fv9XGJcQmLxqr2YgDwa7pI6gSAqUVrZcUZ0iR/xHe+ssyfpma4iJefPPsIiUUVv5Q0oEbKI7I6QIIiVMQ1nq7Se8io3g/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025685; c=relaxed/simple;
	bh=gPd6+PZcmUbTbkDvrJ11b6yWE2uDUvuPbL8XSCOXmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I/oxmr096/S/E8BQyW4r/3AovuX0skcCU0BgiUjOVdW7Ycy481MwGwN2bJgeQLCw/WNu0qp/t7V63aUz4kNd8wcZhatRp36wYtpVIuIf0VEt7Fmdf0b8FSQqMAJA/PLctRCrQmHv7ksvM6X1Z9cD3h8SjL2+1dLsaI3n27qBlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFBCMogU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFBCMogU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772025683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
	b=RFBCMogUMVpq1g0g3KCsQBQ3fDVnpByqUFVUG1MOQsxYLaR9NnESvUYyRHP2zdpzGqgdKo
	XDOESXoHBPpZK9k8xbqfk3nPfwGhHXbQrtEpwlby6LXJiM34oa3bchAejkJcCwVHJWA2LQ
	e3+acIhcwkFGyXfd/z5uuE9PCuORCxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-xaHWJNaTMsWPdJd3ZusqOQ-1; Wed, 25 Feb 2026 08:21:22 -0500
X-MC-Unique: xaHWJNaTMsWPdJd3ZusqOQ-1
X-Mimecast-MFC-AGG-ID: xaHWJNaTMsWPdJd3ZusqOQ_1772025681
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4398e534783so529726f8f.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 05:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772025681; x=1772630481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
        b=UzSeku2mBgMP4Fue6iKfhlQvfPXr7rZ4QemCHZ/PnIRZ7Yhfd2rPaTn91bNK732RKj
         KzKHck7YwBwsE5V4h8iXjb4TCUf6UUuxkEtSLVRpuC0kaEA7NHDXcHezSZ+oesBcUS+a
         91vFnch1idMebd2ATUYKLnNrJW1+Wfa+jlKMCzOsjPCUMjhPTkcc0/eixaJ750A/dUpC
         0hG+rQnHTrgKaz1kr2MAyoRds+MFLXrZhzHetrYqH+dtqAdedlEI5ROV4N5qIInr3vYG
         zVZCac9jj2xDQvBQxiwMmsLT6mHssIRas8lcQlEXmbkDaTO/H6Dip1Di/BKbhm1kvEr4
         Iltg==
X-Forwarded-Encrypted: i=1; AJvYcCUQKndQ/fGOg/mW2SpcU+9CZQ3Eo53VRArwKR4TXiWf6gAfxALxR7luqVnHPtRssgPFgCJJ0WpmXpuEaFEEUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6vUg/uqEo4xlqk3zQ3kMr4AajDVyaOKHSIrom0bUa1KJK6q1f
	ecBhdDChkvzbXWf+Z5atJVZCtJfB3tZzWGDgWmUPOHK0+a7vSWNuM4Br9zMMiMi3tBfA0LIplEr
	0cqsb/sSursaHuDgi8KA+MGpXrvSm2v0zi5y3NSDAGNvxiMfNyJrQRnjcEt26uXFjOOVa
X-Gm-Gg: ATEYQzxlxP0rAws/Efk9EQZWbNMF1Y7v2706eW5x0VHsF8csxq1iZua8m2XvzvPX4gP
	C2fl/tNLJJYNQVq2S87z0037VNt9Q5vWu5iZLGJeieyUp8PsvzBxMmHowp9eVL5xd3VNnwQeXVN
	6YDlEV4WUHuB6wpdsMrepm9RTiuVLNOny2BJyVk1DmfONmrt74Jsx4HZF180AG8cdoAyjDi0iir
	Li4znT0iira8Nak9Og3Ron79TnFmoRyEL+JjDWYwwxz9qZW3syu791KzJrmI3NvYMMabJbtuv8e
	gjS6MWUI1z2o4GHJAz2eLA9BdcJgRwDjdA5aHKI56kLQtdcRj350WXcRiirEFu/Ra3P35Sn3Z/Z
	25c8fzLQXsbprUG60m3YFHBocxc+102rB1UEdbfR8FTDZxQ==
X-Received: by 2002:a05:6000:4009:b0:436:7ab:9290 with SMTP id ffacd0b85a97d-4396f16e345mr29973667f8f.1.1772025681030;
        Wed, 25 Feb 2026 05:21:21 -0800 (PST)
X-Received: by 2002:a05:6000:4009:b0:436:7ab:9290 with SMTP id ffacd0b85a97d-4396f16e345mr29973604f8f.1.1772025680520;
        Wed, 25 Feb 2026 05:21:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fdd0sm33025046f8f.19.2026.02.25.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:21:20 -0800 (PST)
Date: Wed, 25 Feb 2026 08:21:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225081735-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m6om6q-NNXSpJu_FGNSNtphy3BjCVbU_DSzx8DxM--A_1772025681
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 25, 2026 at 12:56:19PM +0000, Srujana Challa wrote:
> > > > > > >
> > > > > > >
> > > > > > > So if device is powerful and supports a very big key size then...
> > > > > > > we disable the feature? how does this make sense?
> > > > > > The intent isn’t to disable the feature on capable devices, but
> > > > > > to ensure the driver never advertises support for RSS key sizes
> > > > > > larger than what the net device can actually handle. Even if a
> > > > > > device reports a very
> > > > > large key size, the driver is constrained by NETDEV_RSS_KEY_LEN,
> > > > > since
> > > > > netdev_rss_key_fill() enforces:
> > > > > > BUG_ON(len > sizeof(netdev_rss_key));
> > > > >
> > > > > so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear the
> > > feature?
> > > > Our device mandates that hash_key_length must be identical to
> > > > rss_max_key_size to guarantee symmetric bidirectional flow hashing.
> > > > If rss_max_key_size is larger than VIRTIO_NET_RSS_MAX_KEY_SIZE,
> > > > clamping
> > > the value is not feasible.
> > >
> > > I don't know what to tell you. rss_max_key_size is just the max device
> > > supports. driver should be free to use a smaller size.
> > My understanding is that this patch prevents the probe from failing by
> > disabling the feature instead.
> > Given the current implementation, the driver becomes unusable when this
> > condition is hit.
> 
> I understand that the driver is allowed to use a smaller RSS key than the device’s advertised rss_max_key_size.
> But, our hardware does not behave correctly in that configuration. For symmetric bidirectional hashing,
> the device requires that the hash_key_length match rss_max_key_size exactly.
> If the driver uses a smaller key, the hardware produces inconsistent hash values for forward vs reverse flows.
> Because of this device requirement, we cannot cap the key to NETDEV_RSS_KEY_LEN when the device advertises
> a larger rss_max_key_size.

Would you not say it's a buggy device then?

-- 
MST

