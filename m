Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA561552FD
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Feb 2025 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761060; cv=none; b=cfchtoroaSw9nnxmTjUppfUuTiBSDnrBFaVCFPRpdzlRFJnXs173n9zq0tltOYMxtr2ItyqTjKGfsvtUboDciGJs8pD33NXaC4Xb4JWMInwcT4A6r4jgPwmTQvv4HgqbO9Rtpr+BYEDbEYvhuam5ZgYy1PQ6/NwbteOyCPGqKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761060; c=relaxed/simple;
	bh=tK9aQDDzfCQLNRUw+2WbCovmkYY2oxiY2yzy3q3Ip3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/+AtoqXiIYpPQFIXovm+KJ/3aAPA8FCzTE8Mdm4wfs0dI0BWADCoj6ZNwtMCDi3V7azS/mTHQ5aWLTZnw/Y301fIhRV69LKRYfm8c8DtXrCndu1k98BLxxVddbmHSGL2md+ss+0d24PY6X9FByOVrXhb2askbnUGAp7pHpyvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fo7TBtiP; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fo7TBtiP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40E1D40B6E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Feb 2025 02:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7CSmAbuMnj2w for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Feb 2025 02:57:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 98BA840703
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98BA840703
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fo7TBtiP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 98BA840703
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Feb 2025 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739761054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XL1MJI2qQRyDzxhhPjfCSyHWJpUSYQmJdBFY+jqfMOQ=;
	b=Fo7TBtiPYLGGkudalIe1FPy1fSr91vyDsYt6bDgafY+aQDmfFBlWjTQeBXGPfz6R0oWV57
	sHGME8bHRFHv332NF/3cGZEMCkT0/XSsmr3Py+OHlOii73ejfMGau+vB2uJLS//BWtO69G
	f98XtKCP/bcTCa8xT+wC77LkXW0gjlo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-bK4LpWIRNCisGuhvEveqEQ-1; Sun, 16 Feb 2025 21:57:31 -0500
X-MC-Unique: bK4LpWIRNCisGuhvEveqEQ-1
X-Mimecast-MFC-AGG-ID: bK4LpWIRNCisGuhvEveqEQ_1739761050
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so8007027a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 16 Feb 2025 18:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739761050; x=1740365850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL1MJI2qQRyDzxhhPjfCSyHWJpUSYQmJdBFY+jqfMOQ=;
        b=Pn4B8Lz1zFNjTONRXYdRtm9UVHewGYjDZ4bH0b6PoHJdrSg83PQD4BAGSC4Bm/+n0C
         PRxWLqfLoG2S5b1Ym+A89og7QKVkvYmQ99yZfLYAJ3JNoX0CJZFKjiRmTRnCVGe26FgS
         iPB+w1xCypdLKXH3tI6+bi9C4ooasezuXuSy8op0QxZSTxrG/iM0pDcIzwF/li0ucSIL
         JuJaf0Sle24LNjP+YN5MDF6m99z3dZ2np4zBXUYxJ/yrf9M/fxBHjWFBYZs5AsKTTmd7
         qARJBShvWEX22BgYNSRBceGbQEkWSzvpxMPm/7z/23T3hXSfrNBPlMoI60sauUEMuwO3
         ChbA==
X-Forwarded-Encrypted: i=1; AJvYcCUTedCvjbQNuGBsg9nT0KWZiXwdu7jcymxALPslGnYmNF20r+uPlQsWcUB6cURU8r/RxsdYa/xj3R8T1Pk9TA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyZLjoZwijFqtUtR5UqBgVh2JI9quDXGhsy/T1RompnsU0DGrRd
	WuCTMgwF58rEr0TEzAHc4eoHXlGZvfURVWO9gnqnCLO906vGEKinCLp+plYo+8szs61m4WeJ5VG
	4lHbFPXTaD4Cm49YIDqSFijYF4E8n8qiwIyTpIOfrQF06grA56Kq40I1tNwYKPLma3aiwXzanBt
	poPRYvQIyH3JU+uvlXZ+PcCWrJM/qXsLIIGyV7xkcGcXYgL1Kb5ClZJw==
X-Gm-Gg: ASbGncu3I6XgjLdgcxdZC8Gm6mOwzE19//PMObcryNAxWdQNK/AN2WKBFU7dGmChV6A
	rJo1aCCnuLtn/CDnyC8kSIoOUj5R7DloyQL/X/ND6cwsAhzhVO6HppZr7WcoFIM8=
X-Received: by 2002:a05:6a00:198c:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-732618c1cf1mr11783603b3a.17.1739761049863;
        Sun, 16 Feb 2025 18:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVQWLmp+QSkutFPeteGs2zCw24E66CumblkrzQWDUWooZ2u41pKGG968ScoLFCi/Lnb1NyBTA6Z6e9dHmLbEA=
X-Received: by 2002:a05:6a00:198c:b0:732:2484:e0ce with SMTP id
 d2e1a72fcca58-732618c1cf1mr11783572b3a.17.1739761049201; Sun, 16 Feb 2025
 18:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
 <20250213020702-mutt-send-email-mst@kernel.org> <0fa16c0e-8002-4320-b7d3-d3d36f80008c@daynix.com>
 <20250213103636-mutt-send-email-mst@kernel.org> <33369e7d-4c43-407a-92fd-373a8a7b2160@daynix.com>
In-Reply-To: <33369e7d-4c43-407a-92fd-373a8a7b2160@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Feb 2025 10:57:17 +0800
X-Gm-Features: AWEUYZmrHEftswhiFfbnVsQcr0_qVHSX-ifAC11RiQWuyoYd9I2p8DCAZlwdITA
Message-ID: <CACGkMEtFK-UO8vJbNTogvTpiP2XFDBrB6B2frFJrUfqgjzApyA@mail.gmail.com>
Subject: Re: [PATCH net-next] tun: Pad virtio headers
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iAam9cBd2C3HxSyyvo9gj7BNqntLUtEerZiLfFeNNsY_1739761050
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 1:25=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/02/14 0:43, Michael S. Tsirkin wrote:
> > On Thu, Feb 13, 2025 at 06:23:55PM +0900, Akihiko Odaki wrote:
> >> On 2025/02/13 16:18, Michael S. Tsirkin wrote:
> >>>
> >>> Commit log needs some work.
> >>>
> >>> So my understanding is, this patch does not do much functionally,
> >>> but makes adding the hash feature easier. OK.
> >>>
> >>> On Thu, Feb 13, 2025 at 03:54:06PM +0900, Akihiko Odaki wrote:
> >>>> tun used to simply advance iov_iter when it needs to pad virtio head=
er,
> >>>> which leaves the garbage in the buffer as is. This is especially
> >>>> problematic
> >>>
> >>> I think you mean "this will become especially problematic"
> >>>
> >>>> when tun starts to allow enabling the hash reporting
> >>>> feature; even if the feature is enabled, the packet may lack a hash
> >>>> value and may contain a hole in the virtio header because the packet
> >>>> arrived before the feature gets enabled or does not contain the
> >>>> header fields to be hashed. If the hole is not filled with zero, it =
is
> >>>> impossible to tell if the packet lacks a hash value.
> >>>>
> >>>> In theory, a user of tun can fill the buffer with zero before callin=
g
> >>>> read() to avoid such a problem, but leaving the garbage in the buffe=
r is
> >>>> awkward anyway so fill the buffer in tun.
> >>>
> >>>
> >>> What is missing here is description of what the patch does.
> >>> I think it is
> >>> "Replace advancing the iterator with writing zeros".
> >>>
> >>> There could be performance cost to the dirtying extra cache lines, th=
ough.
> >>> Could you try checking that please?
> >>
> >> It will not dirty extra cache lines; an explanation follows later. Bec=
ause
> >> of that, any benchmark are likely to show only noises, but if you have=
 an
> >> idea of workloads that should be tested, please tell me.
> >
> > pktgen usually
>
> I tried it but it didn't give meaningful results so I may be doing
> wrong. It didn't show an obvious performance regression at least. I ran
> the following procedure:
>
> 1. create a veth pair
> 2. connect it to macvtap
> 3. run Fedora 41 on QEMU with vhost=3Don
> 4. run samples/pktgen/pktgen_sample01_simple.sh for the other end of veth
> 5. observe the rx packet rate of macvtap with ifstat for 60 seconds
>
> ifstat showed that it received:
> 532K packets / 60 seconds without this patch
> 578K packets / 60 seconds with this patch

The pps seems to be too poor.

If you want to test, I would suggest to use:

pktgen on the host with DPDK testpmd + virtio user:

https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html

Thanks

>
> This is 8.6 % uplift, not degradation. I guess it's just a noise.
>
> Below are actual commands I ran:
>
> The commands I set up the veth pair and macvtap is as follows:
>
> ip link add veth_host type veth peer name veth_guest
> ip link set veth_host up
> ip link set veth_guest up
> ip link add link macvtap0 link veth_guest type macvtap
> ip link set macvtap0 address 02:00:00:01:00:00 mtu 1486 up
> ip address add 10.0.2.0 dev veth_host
> ip route add 10.0.2.1 dev veth_host
>
> The command for the pktgen is:
> samples/pktgen/pktgen_sample01_simple.sh -i veth_host -d 10.0.2.1 -m
> 02:00:00:01:00:00 -n 0
>
> After I started pktgen, I ran: ifstat -d 60 macvtap0
> I waited 60 seconds, and observed the rx rate with: ifstat -as macvtap0
>
> >
> >
> >
> >>>
> >>> I think we should mention the risks of the patch, too.
> >>> Maybe:
> >>>
> >>>     Also in theory, a user might have initialized the buffer
> >>>     to some non-zero value, expecting tun to skip writing it.
> >>>     As this was never a documented feature, this seems unlikely.
> >>>>
> >>>>
> >>>> The specification also says the device MUST set num_buffers to 1 whe=
n
> >>>> the field is present so set it when the specified header size is big
> >>>> enough to contain the field.
> >>>
> >>> This part I dislike. tun has no idea what the number of buffers is.
> >>> Why 1 specifically?
> >>
> >> That's a valid point. I rewrote the commit log to clarify, but perhaps=
 we
> >> can drop the code to set the num_buffers as "[PATCH] vhost/net: Set
> >> num_buffers for virtio 1.0" already landed.
> >
> >
> > I think I'd prefer that second option. it allows userspace
> > to reliably detect the new behaviour, by setting the value
> > to !=3D 0.
>
> I'll leave num_buffers zero in the next version.
>
> >
> >
> >>
> >> Below is the rewritten commit log, which incorporates your suggestions=
 and
> >> is extended to cover the performance implication and reason the num_bu=
ffers
> >> initialization:
> >>
> >> tun simply advances iov_iter when it needs to pad virtio header,
> >> which leaves the garbage in the buffer as is. This will become
> >> especially problematic when tun starts to allow enabling the hash
> >> reporting feature; even if the feature is enabled, the packet may lack=
 a
> >> hash value and may contain a hole in the virtio header because the
> >> packet arrived before the feature gets enabled or does not contain the
> >> header fields to be hashed. If the hole is not filled with zero, it is
> >> impossible to tell if the packet lacks a hash value.
> >>
> >> In theory, a user of tun can fill the buffer with zero before calling
> >> read() to avoid such a problem, but leaving the garbage in the buffer =
is
> >> awkward anyway so replace advancing the iterator with writing zeros.
> >>
> >> A user might have initialized the buffer to some non-zero value,
> >> expecting tun to skip writing it. As this was never a documented
> >> feature, this seems unlikely. Neither is there a non-zero value that c=
an
> >> be determined and set before receiving the packet; the only exception
> >> is the num_buffers field, which is expected to be 1 for version 1 when
> >> VIRTIO_NET_F_HASH_REPORT is not negotiated.
> >
> > you need mergeable buffers instead i presume.
> >
> >> This field is specifically
> >> set to 1 instead of 0.
> >>
> >> The overhead of filling the hole in the header is negligible as the
> >> entire header is already placed on the cache when a header size define=
d
> >
> >
> > what does this mean?
>
> The current specification says the header size is 20 bytes or less. tun
> already makes all cache lines where the header will be written dirty for
> such a header size so we are not making another cache line dirty.
>
> >
> >> in the current specification is used even if the cache line is small
> >> (16 bytes for example).
> >>
> >> Below are the header sizes possible with the current specification:
> >> a) 10 bytes if the legacy interface is used
> >> b) 12 bytes if the modern interface is used
> >> c) 20 bytes if VIRTIO_NET_F_HASH_REPORT is negotiated
> >>
> >> a) and b) obviously fit in a cache line. c) uses one extra cache line,
> >> but the cache line also contains the first 12 bytes of the packet so
> >> it is always placed on the cache.
> >
> >
> > Hmm. But it could be clean so shared. write makes it dirty and so
> > not shared.
>
> The packet is not just located after the header in the buffer but tun
> writes the packet there. It makes the cache line dirty even without this
> change.
>
> >
>

