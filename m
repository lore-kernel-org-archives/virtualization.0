Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396C19AD93
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461401; cv=none; b=EcFN/O6TEPg6RJklkBXkc+50yILCDeE1o41GB72MmxNNYsQ8xXeneQ0vqyPmZgFiBiGomv+XseOUoC8zKupmmLGeuv/XgPObTUWmDwN66k4muigpL8NCvgWy0mXjimoiJC3yKZXtyAmEMo0B2CmKk4Puyr229dXejDTdE3RFTpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461401; c=relaxed/simple;
	bh=uLiZ1rCqYfK/j8eSgyeV2MyQP8gfHxF6rrcTwqcvaaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GCbQlOLnfsca/aWpbK1DGopEhtGpi/Hps1T+TTJTMjRR12dbti7Rk4nepSTYbpvuDfvvZ4FjDQWYdf8tPYjVyrk7kFC6F/SOw5AOz/tCyNC1MuC2pHm04i22U4c74Si0JrovVDVcRcehyVZv86OKRM9TR+/aL4Y+a7s5ZRI28j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2Ly/3Ov; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2Ly/3Ov"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4DA640CE2
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 15:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFgMIF_TRSjg for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Feb 2025 15:43:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4F52040C64
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F52040C64
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g2Ly/3Ov
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4F52040C64
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzI2r5nmEeXgT2ts1VutUTn2sHSIfm7BIbhjPpBpcIA=;
	b=g2Ly/3OvR6mtGYXlVfLToj0OYk3cMlr9GTC/GXMZUO9jtSJFoVp8uRZjpymLRfs8yPUZqj
	bY4dfTlxXY0e5Yc/WmFyArx+0UG2ZNuMHOikJ7gbGtp7nV3/fV1r4rtTXlNoxef5hCKhIT
	NSuNFf0QN2svZVLLqSZ7UBHgclMMDZw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-gz6BtmjZPxK0zsrtSJ6gXQ-1; Thu, 13 Feb 2025 10:43:15 -0500
X-MC-Unique: gz6BtmjZPxK0zsrtSJ6gXQ-1
X-Mimecast-MFC-AGG-ID: gz6BtmjZPxK0zsrtSJ6gXQ_1739461394
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab7d2d60e88so96129166b.1
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 07:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461394; x=1740066194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzI2r5nmEeXgT2ts1VutUTn2sHSIfm7BIbhjPpBpcIA=;
        b=Jw21W6hDUPx7oqb3t9vDb4BX8r475jyaHQ1eTlZGuyPDX+nIrlO6OoUjakrSMOQf7T
         0N53Sn3mmB/3ES0ixA8vdoNIiko9AKz4rdnTNcdNEU/Bg8kb/Ikn7hq3Bn75iIgzqxcs
         hiwXRDluOzkZWUHQ8CTzHtCXY0f3BUI45rkJAFK4lBgA22drqVsFvZlQHPGGvPJg/IGu
         ahkIB6SqjtMN6G3oFyZgfyxXvRU+L2usHOmp6ryFwAnnoQxQ5i+1pyJMRIPyQgAK/1wP
         u8KI0sfByMcZh9onckOcIiRP3erP5ieoIKKrYNAHaI1OO9+pV1h1Nom45uv17RWLSZo/
         +g4g==
X-Forwarded-Encrypted: i=1; AJvYcCVv/iQXXNu84fZdwIDhvWNB1uEBaAgOchOv2r6lF8lJwTElE9I2YgCxlvIOy5g8q33r3jbpFtaLsOx2iZjIbg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxNHXHLZaznp3bPlrMxn+9zUk/lFxadTQGZB2xNQlCznC4FikpZ
	MAfRf54A4/UE8P4Gjo9EC9ZbahhOS052KxnYs3LeocVeQT4Jj3/zw/uahf8cjttkrY77p/u+fsJ
	IylfC5793ZwnN0YjOhO+dyvrbjmxPcDTH2EmdvKoYsP7vGvbqpujls1XucABPOrDlyORTS2f8V5
	hEXOE=
X-Gm-Gg: ASbGncu8zXYbQlR6t/Rx6edt0aosI3huEQKx0ViIiXbOng+nsDvIQHvzIAh1+Fo78un
	i7AKyatp22g0GUiDmGIvRKYgGZlpZEGV4NmfTxTTtMJYzm5vxapkwQZhS1S4LWEQAVMQymY+/py
	ayu74Q7weGHSa9MFStgjXzswjHaqOV4J/K1YHG8xh0yCWWb8NmtrVg7ay7egvvT1dU2pEArKXhD
	bhMjkIDn8yHpAxsThl6oTfDVTbe1JmEhInh8Fd2bn/as60Y2eVada91LPw9Lcdk32FH1HJKAA==
X-Received: by 2002:a17:907:96ac:b0:ab7:cd83:98b6 with SMTP id a640c23a62f3a-ab7f336d4dcmr727681566b.6.1739461393909;
        Thu, 13 Feb 2025 07:43:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMjEK63T1Hvw2DRYuMNZ0QhIbCttTcpsK+feVhTHyAb3Qwlg1NW7Q7NJFwB80xOR6TDebhgw==
X-Received: by 2002:a17:907:96ac:b0:ab7:cd83:98b6 with SMTP id a640c23a62f3a-ab7f336d4dcmr727676966b.6.1739461393478;
        Thu, 13 Feb 2025 07:43:13 -0800 (PST)
Received: from redhat.com ([2a02:14f:171:92b6:64de:62a8:325e:4f1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376abbsm153403066b.93.2025.02.13.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:43:12 -0800 (PST)
Date: Thu, 13 Feb 2025 10:43:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH net-next] tun: Pad virtio headers
Message-ID: <20250213103636-mutt-send-email-mst@kernel.org>
References: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
 <20250213020702-mutt-send-email-mst@kernel.org>
 <0fa16c0e-8002-4320-b7d3-d3d36f80008c@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0fa16c0e-8002-4320-b7d3-d3d36f80008c@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I-6FJiW4hlLNjQwG-Evpv17dQU7nOM-LP2DKXdvXC-0_1739461394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2025 at 06:23:55PM +0900, Akihiko Odaki wrote:
> On 2025/02/13 16:18, Michael S. Tsirkin wrote:
> > 
> > Commit log needs some work.
> > 
> > So my understanding is, this patch does not do much functionally,
> > but makes adding the hash feature easier. OK.
> > 
> > On Thu, Feb 13, 2025 at 03:54:06PM +0900, Akihiko Odaki wrote:
> > > tun used to simply advance iov_iter when it needs to pad virtio header,
> > > which leaves the garbage in the buffer as is. This is especially
> > > problematic
> > 
> > I think you mean "this will become especially problematic"
> > 
> > > when tun starts to allow enabling the hash reporting
> > > feature; even if the feature is enabled, the packet may lack a hash
> > > value and may contain a hole in the virtio header because the packet
> > > arrived before the feature gets enabled or does not contain the
> > > header fields to be hashed. If the hole is not filled with zero, it is
> > > impossible to tell if the packet lacks a hash value.
> > > 
> > > In theory, a user of tun can fill the buffer with zero before calling
> > > read() to avoid such a problem, but leaving the garbage in the buffer is
> > > awkward anyway so fill the buffer in tun.
> > 
> > 
> > What is missing here is description of what the patch does.
> > I think it is
> > "Replace advancing the iterator with writing zeros".
> > 
> > There could be performance cost to the dirtying extra cache lines, though.
> > Could you try checking that please?
> 
> It will not dirty extra cache lines; an explanation follows later. Because
> of that, any benchmark are likely to show only noises, but if you have an
> idea of workloads that should be tested, please tell me.

pktgen usually



> > 
> > I think we should mention the risks of the patch, too.
> > Maybe:
> > 
> > 	Also in theory, a user might have initialized the buffer
> > 	to some non-zero value, expecting tun to skip writing it.
> > 	As this was never a documented feature, this seems unlikely.
> > >
> > > 
> > > The specification also says the device MUST set num_buffers to 1 when
> > > the field is present so set it when the specified header size is big
> > > enough to contain the field.
> > 
> > This part I dislike. tun has no idea what the number of buffers is.
> > Why 1 specifically?
> 
> That's a valid point. I rewrote the commit log to clarify, but perhaps we
> can drop the code to set the num_buffers as "[PATCH] vhost/net: Set
> num_buffers for virtio 1.0" already landed.


I think I'd prefer that second option. it allows userspace
to reliably detect the new behaviour, by setting the value
to != 0.


> 
> Below is the rewritten commit log, which incorporates your suggestions and
> is extended to cover the performance implication and reason the num_buffers
> initialization:
> 
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so replace advancing the iterator with writing zeros.
> 
> A user might have initialized the buffer to some non-zero value,
> expecting tun to skip writing it. As this was never a documented
> feature, this seems unlikely. Neither is there a non-zero value that can
> be determined and set before receiving the packet; the only exception
> is the num_buffers field, which is expected to be 1 for version 1 when
> VIRTIO_NET_F_HASH_REPORT is not negotiated.

you need mergeable buffers instead i presume.

> This field is specifically
> set to 1 instead of 0.
> 
> The overhead of filling the hole in the header is negligible as the
> entire header is already placed on the cache when a header size defined


what does this mean?

> in the current specification is used even if the cache line is small
> (16 bytes for example).
> 
> Below are the header sizes possible with the current specification:
> a) 10 bytes if the legacy interface is used
> b) 12 bytes if the modern interface is used
> c) 20 bytes if VIRTIO_NET_F_HASH_REPORT is negotiated
> 
> a) and b) obviously fit in a cache line. c) uses one extra cache line,
> but the cache line also contains the first 12 bytes of the packet so
> it is always placed on the cache.


Hmm. But it could be clean so shared. write makes it dirty and so
not shared.

-- 
MST

