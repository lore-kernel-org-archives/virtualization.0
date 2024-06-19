Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7B73455
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782431; cv=none; b=EeeUMMjNyuC/J74zzm8l/rzTYulRLKtlxhLiHI6qNLPyG5Yt8e0GGVP/NHJ1ApYKE0NbV7WoYMTort2ms98nhy1pNNY8jOYGsNjLZa/Yh7Clj+STUCGmhJTQF4p0MvToFCxneLKuyysK+LWYfPU0UU56yRLFlyPXYJt+fiCKec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782431; c=relaxed/simple;
	bh=W2cDg518e581hDz31yGUvF8ihm6FBKBrxwwd3eGl5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LF4xuYQOF5iri8R2BAFPwfWOBafe0BsONOURn7r3Cc78fhZFhY7cv+HPIuwRIrqaSh79v72jTNAWZPpfBcE0Nbxq0LvMGA5MzpED/05jQ3moRfNU+80AseBp8zuhruvGXiAW5RZzrc+v/4v/YRAT0zfpep4W8ydxAFZi8AVg9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeB+EX7o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeB+EX7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718782429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Md0vF9O8pNOYQj1jtiBKod/l0YrOJ08HFOMaLCALqPs=;
	b=PeB+EX7oDTSUHHq2ZAQO5FR6nJJ6l0zQWCEhInUNMGL76psdRgE5l4T0jCddeNBbG3HJji
	HqUXs5JCBcHYFqgCIezEQm6zsT3d5TK/f7Zpow1UeJpqX2Itn0Il4GHH+T+fcfyRYOzjdY
	V44tZGSs/fz+/Oy/5rZdBwJtniW/bLo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-qLatJlOGPheLuppRxVM6uA-1; Wed, 19 Jun 2024 03:33:47 -0400
X-MC-Unique: qLatJlOGPheLuppRxVM6uA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42181c64596so37826245e9.1
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 00:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782426; x=1719387226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md0vF9O8pNOYQj1jtiBKod/l0YrOJ08HFOMaLCALqPs=;
        b=KykHcD5/tXH48dZ+E2vcCmgtJag0qlsOAr9Jns3HP6OhfJ1ED3/P3brKlj3d3Gs1/G
         H/t8RVTKNxDsx7/meG6aQ5w3xJI6JvWlLzLf8Fs5RL1ooZ7/sRS9xfZE3BpuIH4q4DNR
         0F4WgJbQTx/qyrL4bvVQvL/narBVytQMOnW7x6aBo/TE5BwUFn8CXgvsBCtZbntpnoWY
         TctgBoBkFw7lDF4tpJzrDWck9yqT+y1SCnnThLdtDZNA29shTsobom9lSt+ujjuuFIIN
         vfLD7LhGpyD3Ucc+f0AGeTHafNS8GhYyQSiQijohslMhywOBDEBwrc3muIP2aonT+m53
         OUiA==
X-Forwarded-Encrypted: i=1; AJvYcCWReznGi1MCdNcI9MWjh2HTatimm6Iw2yiU8aEWRsiNxRu0Q4XE1F2jxSrTCCUnrKX4HCo4e6Bm975NojDLnxNgHYUMByfB7vUtNMgZ65M=
X-Gm-Message-State: AOJu0Yz+txCZlG0krSgWLH+4sSsJd0xzagbK3wEku+6uarHRIwQDMF3p
	UGJqN2YgXB5dEv18fso+icsFXeMdoWaZ2svTmNZBYWjXUl0mqdFpsY4j5Fb4FzP9tppxAcm8LHq
	shjeDVC0Jk+52L2NH72EVnvA60prT8Sr0SY1odvH6TkChioxa2ogU4sCONP3YM1H4
X-Received: by 2002:a05:600c:acc:b0:421:eed3:5991 with SMTP id 5b1f17b1804b1-42475297adbmr12917665e9.32.1718782425934;
        Wed, 19 Jun 2024 00:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH95+9/uesfMPZ+wBYc42ZsWDmjmPRPB1E6KfsSijszF8A7JFQ9ubrUHEH+YtOrZ/WGhoODjg==
X-Received: by 2002:a05:600c:acc:b0:421:eed3:5991 with SMTP id 5b1f17b1804b1-42475297adbmr12917505e9.32.1718782425447;
        Wed, 19 Jun 2024 00:33:45 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3632d8562a1sm1731803f8f.2.2024.06.19.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:33:44 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:33:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, matttbe@kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shuah@kernel.org, petrm@nvidia.com,
	pabeni@redhat.com, linux-kselftest@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net] selftests: virtio_net: add forgotten config options
Message-ID: <20240619033332-mutt-send-email-mst@kernel.org>
References: <20240619061748.1869404-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240619061748.1869404-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 08:17:48AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> One may use tools/testing/selftests/drivers/net/virtio_net/config
> for example for vng build command like this one:
> $ vng -v -b -f tools/testing/selftests/drivers/net/virtio_net/config
> 
> In that case, the needed kernel config options are not turned on.
> Add the missed kernel config options.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240617072614.75fe79e7@kernel.org/
> Reported-by: Matthieu Baerts <matttbe@kernel.org>
> Closes: https://lore.kernel.org/netdev/1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org/
> Fixes: ccfaed04db5e ("selftests: virtio_net: add initial tests")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/selftests/drivers/net/virtio_net/config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
> index f35de0542b60..040b600d52f1 100644
> --- a/tools/testing/selftests/drivers/net/virtio_net/config
> +++ b/tools/testing/selftests/drivers/net/virtio_net/config
> @@ -1,2 +1,8 @@
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_DEBUG=y
> +CONFIG_NET_L3_MASTER_DEV=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_VRF=m
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_IPV6=y
> -- 
> 2.45.1

