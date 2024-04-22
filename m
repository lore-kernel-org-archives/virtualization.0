Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD518042
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817991; cv=none; b=CsLREFNhX0jXQBSAvvlUy3BZVNteJW4/6BjmskvUIYTJYLZV3+IsT+gOAG1GERjLabvzwnMi+BEAGq6woY6xZVKDxI+USDZvU3g95XUriU79MgGyvn16DdiotEh05As+oSn0sNkm7e76FOWX85uAe1G0nEc4AhxgJNw+LN7YtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817991; c=relaxed/simple;
	bh=KqhvRyISK1EHaG9zl8kIq3kWh+TdLSJYaYopZ3MG8gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SL30Qsq8L5lKHJaLUPWremNfum3vTpl72egfCTerH+fGY55JgaP53ouGIq0iwiX6HvnSbQSbHblPq8jdIa6MrTQmNKepM4FBU0RixHIBIhedYZ0KwSqZ4wgJfJSXTJidmD/X1BTRAZwu7S/Kmi4DNORYW03l8t1olnek6ReXJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWOKWPLL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWOKWPLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713817988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeyR+70OptlQkVxKAvnuj7vbjWDT7scfNFidnBSfS2Y=;
	b=DWOKWPLLkJ/PKrcnQ2ao6QKHB8tAJbi2V+5NTIjSHB83cDBZU3tiTgJKqVsA0nZFBy9yLa
	ciM1Wr7ZTjpOrwAZxSw4uHduT0c/7MX+RtbCUpM96I9eQgD2lDFUzDumKKQ5kruCbheAmi
	/F7fDK2EHdpb+Vo/nyc7L1UWocV9Gxw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-BwxVFY3vPHWd4pkDKwYBNw-1; Mon, 22 Apr 2024 16:33:07 -0400
X-MC-Unique: BwxVFY3vPHWd4pkDKwYBNw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41a3369659eso7368825e9.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 13:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817986; x=1714422786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeyR+70OptlQkVxKAvnuj7vbjWDT7scfNFidnBSfS2Y=;
        b=agT83SxP2Li56VJaBOs6Tq/PibT20kuoPOTYoJqz0podgGnM4tgiE3ddcFvCvWOQQ2
         xP0602cvoTiAKj3WVN3W6GO0ncQw0/sCJv0AesJ16cTqG1Yl+0bPllDIm2/+uwMWnYrM
         ztWVL+SwFX+S9G0H3nfVE7me4JLAW0pSjkG3ukTwa5RtzmY7VWBk79bcOqLU6ITz5TOD
         uabyFXYMCe3vROXQYZfjR/FImoyT3KeV3SiG6xXkrIVPGXgo6lQnkjNB6Vf9RUEiu/2q
         B+fDGmVmhiWXpyQaXOAqTtQ5L73zKavvNTjMphqrQZQ6dCa4xonPZdxZ0w1zAped1N6e
         boHw==
X-Forwarded-Encrypted: i=1; AJvYcCWXUTkrtGdGHpnmUVszrDGIDUfiHaLd24AOVa4J1/4GB28eNkjp23uvXD50GIOsXHlpNPBjeR3Uo0sgJVS6/1u1NBZv7ZLL7B3DxbPO4+s=
X-Gm-Message-State: AOJu0Yz6ZF7u/pEZVqqjR0UgC8PYjMt/A4QbcIZ5ySkWzqguWdyDB1+w
	Qh5dZf8KWLHgLlgCs7+lpDFviVaNrV3ivbwSUItoYdD9z9hu2xdEQZeyBmvWcpKKRAJ0Gt4qHIW
	+ThPXNCbYuNWz+3ODS/ffbNiBfAtUMaWy+zF7oFcC7fBU6XfRJ59R6NobjJ8WDNYx
X-Received: by 2002:a5d:6943:0:b0:34a:6fac:6dab with SMTP id r3-20020a5d6943000000b0034a6fac6dabmr476174wrw.12.1713817986164;
        Mon, 22 Apr 2024 13:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmzrgS1Q5fYLISgd6tnTSj92DeDd/SrzJRUtL+0gJCJre6GoMQFEDaR+tJbaeWCrcYkPRbDg==
X-Received: by 2002:a5d:6943:0:b0:34a:6fac:6dab with SMTP id r3-20020a5d6943000000b0034a6fac6dabmr476147wrw.12.1713817985564;
        Mon, 22 Apr 2024 13:33:05 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id ju12-20020a05600c56cc00b0041a68d4fe61sm52531wmb.0.2024.04.22.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:33:04 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:33:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <20240422163231-mutt-send-email-mst@kernel.org>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 07:05:53PM +0800, Xuan Zhuo wrote:
> As the spec:
> 
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> The virtio net supports to get device stats.
> 
> Please review.

series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I think you can now repost for net-next.


> Thanks.
> 
> v5:
>     1. Fix some small problems in last version
>     2. Not report stats that will be reported by netlink
>     3. remove "_queue" from  ethtool -S
> 
> v4:
>     1. Support per-queue statistics API
>     2. Fix some small problems in last version
> 
> v3:
>     1. rebase net-next
> 
> v2:
>     1. fix the usage of the leXX_to_cpu()
>     2. add comment to the structure virtnet_stats_map
> 
> v1:
>     1. fix some definitions of the marco and the struct
> 
> 
> 
> 
> 
> 
> Xuan Zhuo (9):
>   virtio_net: introduce device stats feature and structures
>   virtio_net: virtnet_send_command supports command-specific-result
>   virtio_net: remove "_queue" from ethtool -S
>   virtio_net: support device stats
>   virtio_net: stats map include driver stats
>   virtio_net: add the total stats field
>   virtio_net: rename stat tx_timeout to timeout
>   netdev: add queue stats
>   virtio-net: support queue stat
> 
>  Documentation/netlink/specs/netdev.yaml | 104 ++++
>  drivers/net/virtio_net.c                | 755 +++++++++++++++++++++---
>  include/net/netdev_queues.h             |  27 +
>  include/uapi/linux/netdev.h             |  19 +
>  include/uapi/linux/virtio_net.h         | 143 +++++
>  net/core/netdev-genl.c                  |  23 +-
>  tools/include/uapi/linux/netdev.h       |  19 +
>  7 files changed, 1013 insertions(+), 77 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

