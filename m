Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D342AC43217
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 11:38:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852666108D
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 11:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 852666108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43E5780DA5;
	Mon,  8 Nov 2021 11:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UkG1pOmulYKj; Mon,  8 Nov 2021 11:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 038AC80DA7;
	Mon,  8 Nov 2021 11:38:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D048BC0012;
	Mon,  8 Nov 2021 11:38:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 683B5C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48490606A7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:38:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7I33Ik7jxpM0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87BF1606A0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636371479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlpIDeohuxGJKr6/NQGxf0qdewWP/HeI2X9Zoct4WLo=;
 b=L9mv7Wzvbe42e1CbAnv05oCbj8xcueiPsoDNZRRpzHHeNz90zepp44MFDAB5Ig2c3VuFh2
 V2iePOr5/bQ6OyJrUh0fzeYi+Etn+LUBaymtZQoSoCcSWpeEqNfppdpXhuPnSceCrC7PJw
 FQX5XIZh1khAGao2jfLbVc3uYq60Ma8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-IyaxOE3TNfe5S6_h3rlumg-1; Mon, 08 Nov 2021 06:37:58 -0500
X-MC-Unique: IyaxOE3TNfe5S6_h3rlumg-1
Received: by mail-ed1-f71.google.com with SMTP id
 d11-20020a50cd4b000000b003da63711a8aso14541581edj.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 03:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=zlpIDeohuxGJKr6/NQGxf0qdewWP/HeI2X9Zoct4WLo=;
 b=AkdTmFoKd8MFmUGJHMvR1ilP1sbHSqL8ODif8JnYESj/KTTLihlV8bXrxtO4H4npxz
 ZjK/eqQbetZ2ZRsC3EduGo+E9OQVZ9w3OepMtGgtf0jEOUJOjbFNwsQ18d1DvlcLFtKF
 RYLJIxcgyQnNbLOOr3q50vaLz9sVtnUa9EVWuVyRSGKOEoG0tqJR1Yln9AfdaE3Ik0Gk
 Gx6AhptKrUqFCRCKlDc15scTcB1H/nHS8Q9mcq5mEfNuq7BJyqOpKrMekWg9bpueUxSP
 YM5D2uyQKHwOkapfPEUkzEJgbn7ZfWyQnTDC4pRokaNEqyIZRwKEWxS5Uru/McjYGfbQ
 H4fg==
X-Gm-Message-State: AOAM5331loe1V9pEaiR1nmzcLVBz5UBSgenOFjo65Nzeg+Nib3lcPsE6
 xSi7tYs93bhil+q4eM/PbHpJ/DyMCZSHh2vjE5+hobMvurMR360vplOIJc4Mb4+Eq3uNljDCmu+
 FTjz0Pqm7KJxRhcL+Q4LZ9fyVVlOEq4Q5q4aGbtnM6Q==
X-Received: by 2002:a17:906:4f05:: with SMTP id
 t5mr46252207eju.68.1636371476540; 
 Mon, 08 Nov 2021 03:37:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFiBzrZYCTp/6+feubjnw4qbO6blKuJwK/JkZdYQJiGLP3YCP6pZpAzE0LqjpvxSH/rwvvHQ==
X-Received: by 2002:a17:906:4f05:: with SMTP id
 t5mr46252121eju.68.1636371476180; 
 Mon, 08 Nov 2021 03:37:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
 by smtp.gmail.com with ESMTPSA id b19sm7799881ejc.107.2021.11.08.03.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 03:37:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
 id 2E6B718026D; Mon,  8 Nov 2021 12:37:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <alexandr.lobakin@intel.com>, Saeed Mahameed
 <saeed@kernel.org>
Subject: Re: [PATCH net-next 03/21] ethtool, stats: introduce standard XDP
 statistics
In-Reply-To: <20211105164453.29102-1-alexandr.lobakin@intel.com>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
 <20210803163641.3743-4-alexandr.lobakin@intel.com>
 <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <ec0aefbc987575d1979f9102d331bd3e8f809824.camel@kernel.org>
 <20211026092323.165-1-alexandr.lobakin@intel.com>
 <20211105164453.29102-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Nov 2021 12:37:54 +0100
Message-ID: <87v912ri7h.fsf@toke.dk>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=toke@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Michal Kubecek <mkubecek@suse.cz>, Andrew Lunn <andrew@lunn.ch>,
 Song Liu <songliubraving@fb.com>, Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
 Sameeh Jubran <sameehj@amazon.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Zheng Yongjun <zhengyongjun3@huawei.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Petr Vorel <petr.vorel@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jian Shen <shenjian15@huawei.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Michal Kubiak <michal.kubiak@intel.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 virtualization@lists.linux-foundation.org, Guy Tzalik <gtzalik@amazon.com>,
 YueHaibing <yuehaibing@huawei.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ido Schimmel <idosch@nvidia.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>,
 KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Dan Murphy <dmurphy@ti.com>,
 Jakub Kicinski <kuba@kernel.org>, Shay Agroskin <shayagr@amazon.com>,
 Marcin Wojtas <mw@semihalf.com>, Johannes Berg <johannes@sipsolutions.net>,
 Danielle Ratson <danieller@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Netanel Belgazal <netanel@amazon.com>, Marcin Kubiak <marcin.kubiak@intel.com>,
 Yangbo Lu <yangbo.lu@nxp.com>, Saeed Bishara <saeedb@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 26 Oct 2021 11:23:23 +0200
>
>> From: Saeed Mahameed <saeed@kernel.org>
>> Date: Tue, 03 Aug 2021 16:57:22 -0700
>> 
>> [ snip ]
>> 
>> > XDP is going to always be eBPF based ! why not just report such stats
>> > to a special BPF_MAP ? BPF stack can collect the stats from the driver
>> > and report them to this special MAP upon user request.
>> 
>> I really dig this idea now. How do you see it?
>> <ifindex:channel:stat_id> as a key and its value as a value or ...?
>
> Ideas, suggestions, anyone?

I don't like the idea of putting statistics in a map instead of the
regular statistics counters. Sure, for bespoke things people want to put
into their XDP programs, use a map, but for regular packet/byte
counters, update the regular counters so XDP isn't "invisible".

As Jesper pointed out, batching the updates so the global counters are
only updated once per NAPI cycle is the way to avoid a huge performance
overhead of this...

-Toke

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
