Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3608433D6
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862733; cv=none; b=X++N4PNhS/ZJrb7XpC/slAQ55D5iR/L52r6QrpBmuxHtofTrlurukiu9x7I5eLtzafBteEtH6HS7+8gqvEsemJPxN7wOpfEOxd3dsfxr2bm0uh8tJwkZEhWVf+yhHR+qA7iAqSbUIhfyjwwdAsixZ2IqbR0H+c9x7Jwp7WEs024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862733; c=relaxed/simple;
	bh=88gTpqB5Ftz6F6woFWb8LTvWrxcCnYccA8e3KlmMLjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UDX55dRe2I2L2ZOEybWosuoKhgU9ArCUnKi3y0gms3ABEE4ePkCwZ7SxmsO0P+D96KO9PVCVx0sSykAB1FUUMOHiGj8lmKOAc7xAcZOSkhfl+w2R0kizBLenmKCpWitIse+oXIkCWvbhOLhbdSfMhFPUcgg/tzVeP/ksAN0TsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6b3W+hz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6b3W+hz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715862729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhHbQMjCYZe2tVGaOVo8jm6NxFMaMenPci+l9CbDFR8=;
	b=A6b3W+hzZZldRF590amPkcynebrl5pr0M026fcj17wGFhPnmwBDWnvjhZOBrG0EbPFClAS
	3j0zx+Ui3TDWXvpLZ4h00s+SOeKzNIBb5+kEDTE3YquTxhRPwtUvfW5IgJwOX8emWQK/em
	Hpe5wnuAe416XYdr0zEKc0iIyO99/Aw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-3AbA6ymUNHyOxGeKTpur_A-1; Thu, 16 May 2024 08:32:08 -0400
X-MC-Unique: 3AbA6ymUNHyOxGeKTpur_A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-574ebea4810so2724224a12.0
        for <virtualization@lists.linux.dev>; Thu, 16 May 2024 05:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715862726; x=1716467526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhHbQMjCYZe2tVGaOVo8jm6NxFMaMenPci+l9CbDFR8=;
        b=HB7Zya3Qc3vRg9EWKSeNFhmggSXSDcdzSpY4U9QbAQ1KSRmqzuU/DNpRwR4cp6GRXO
         Gm6plifAmWffTnCpXzx9dn5RnAyJIXZgPEI3FzCoyVmQOsYPGFuZfn94hKB0IhXtYjCx
         Amx3ddQn6foK0RJFg7KalEK+epGiPfbtGRGFI8MfOZYBW0RLPC5k1RJ63vVIkQvdDseu
         e9hRcLeiL/zGr7k5u5DfCN3OZJQD9WiCdNO+IyFMY/FbQ8+9CanIKJ14g9ZZB4sj1H+w
         r0gcazC/rqBNgd1EyIss9GuUZg6siUa6CBaS3QQEPN+S4N4JdGZnxwTYeAVo56R2Cx7s
         Ifmw==
X-Forwarded-Encrypted: i=1; AJvYcCXSGiE4cYKPL+7DYD021lnmW5J5yWoB8wQEjOTncYdCkNnhhh5fnS8wBE6sMbc+7DW9L85S25rreLRtD8UZcyZqj/6HUf4b+By0gI0XY6M=
X-Gm-Message-State: AOJu0YxBDiJhe60xYhCMoNOtTOjGV17uaWLQKy7so6gMOY4Cd/o+gWQE
	TcV2CzeoVVSB7nZdn5YF3zfecIOiDju5f/0Yz16ESDwRXupQRrgysylneK/1w5sV3ENdZA55oKM
	76dKG7zbUZ1NKUyF9POWyl97cYtO6/KHY4Q1uxWVK2oKBgfmQrVFm66UjmIMnx7+C
X-Received: by 2002:a50:9fa7:0:b0:572:a172:be71 with SMTP id 4fb4d7f45d1cf-5734d6f2765mr17566234a12.14.1715862726533;
        Thu, 16 May 2024 05:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFImWIsxwOBVoe62bfajvu5GwknXbPVawtJ1C+lr8xulQduklxf5v3r+XFuu3k3muscwMPhoQ==
X-Received: by 2002:a50:9fa7:0:b0:572:a172:be71 with SMTP id 4fb4d7f45d1cf-5734d6f2765mr17566196a12.14.1715862725867;
        Thu, 16 May 2024 05:32:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb57asm10381581a12.26.2024.05.16.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:32:05 -0700 (PDT)
Date: Thu, 16 May 2024 08:31:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240516083100-mutt-send-email-mst@kernel.org>
References: <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
 <ZkXmAjlm-A50m4dx@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZkXmAjlm-A50m4dx@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 16, 2024 at 12:54:58PM +0200, Jiri Pirko wrote:
> Thu, May 16, 2024 at 06:48:38AM CEST, jasowang@redhat.com wrote:
> >On Wed, May 15, 2024 at 8:54 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >>
> >> Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
> >> >Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
> >> >>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
> >> >>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
> >> >>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
> >> >>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
> >> >>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> >> >>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >> >>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >> >>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >> >>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> >>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >>> >> >> >> >>
> >> >>> >> >> >> >> Add support for Byte Queue Limits (BQL).
> >> >>> >> >> >> >>
> >> >>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >>> >> >> >> >
> >> >>> >> >> >> >Can we get more detail on the benefits you observe etc?
> >> >>> >> >> >> >Thanks!
> >> >>> >> >> >>
> >> >>> >> >> >> More info about the BQL in general is here:
> >> >>> >> >> >> https://lwn.net/Articles/469652/
> >> >>> >> >> >
> >> >>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
> >> >>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
> >> >>> >> >> >benefit virtio.
> >> >>> >> >>
> >> >>> >> >> Do you have some link to that, or is it this thread:
> >> >>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> >> >>> >> >
> >> >>> >> >
> >> >>> >> >A quick search on lore turned up this, for example:
> >> >>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
> >> >>> >>
> >> >>> >> Says:
> >> >>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
> >> >>> >>  overhead."
> >> >>> >>
> >> >>> >> But virtio can have one tx queue, I guess that could be quite common
> >> >>> >> configuration in lot of deployments.
> >> >>> >
> >> >>> >Not sure we should worry about performance for these though.
> >> >>> >What I am saying is this should come with some benchmarking
> >> >>> >results.
> >> >>>
> >> >>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
> >> >>> queue pair:
> >> >>>
> >> >>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
> >> >>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
> >> >>>
> >> >>> RR result with no bql:
> >> >>> 29.95
> >> >>> 32.74
> >> >>> 28.77
> >> >>>
> >> >>> RR result with bql:
> >> >>> 222.98
> >> >>> 159.81
> >> >>> 197.88
> >> >>>
> >> >>
> >> >>Okay. And on the other hand, any measureable degradation with
> >> >>multiqueue and when testing throughput?
> >> >
> >> >With multiqueue it depends if the flows hits the same queue or not. If
> >> >they do, the same results will likely be shown.
> >>
> >> RR 1q, w/o bql:
> >> 29.95
> >> 32.74
> >> 28.77
> >>
> >> RR 1q, with bql:
> >> 222.98
> >> 159.81
> >> 197.88
> >>
> >> RR 4q, w/o bql:
> >> 355.82
> >> 364.58
> >> 233.47
> >>
> >> RR 4q, with bql:
> >> 371.19
> >> 255.93
> >> 337.77
> >>
> >> So answer to your question is: "no measurable degradation with 4
> >> queues".
> >
> >Thanks but I think we also need benchmarks in cases other than vDPA.
> >For example, a simple virtualization setup.
> 
> For virtualization setup, I get this:
> 
> VIRT RR 1q, w/0 bql:
> 49.18
> 49.75
> 50.07
> 
> VIRT RR 1q, with bql:
> 51.33
> 47.88
> 40.40
> 
> No measurable/significant difference.

Seems the results became much noisier? Also
I'd expect a regression if any to be in a streaming benchmark.

-- 
MST

