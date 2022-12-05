Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E3DC4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 20:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 540AB40484;
	Mon,  5 Dec 2022 20:36:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 540AB40484
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NNvVrw/S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCN-uAbHpVRq; Mon,  5 Dec 2022 20:36:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D6E6540104;
	Mon,  5 Dec 2022 20:36:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6E6540104
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B12A5C0033;
	Mon,  5 Dec 2022 20:36:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39315C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0715140199
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:36:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0715140199
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3sFAnYRlotl7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:36:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3C6F40104
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3C6F40104
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:36:27 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id 130so12534456pfu.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 12:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mFukHabHzU9nHDP00BQaLwWH/W2xDMgDd01lQ3KmF6E=;
 b=NNvVrw/SaRYNVz6zgzonsBqZmmjEaeLgCOfnluncK7lzNAVOaG9ygyyaqPstFoAppn
 ll73AaC1B2DojbiNRyG8S34lhlKyLga47dapY6NwA4R0CVK+5iRJ9KsjScR+uU6gHBXB
 kK/C5gW0vge2xRULkPNa7XOit6YT2deDSv+2MoWWiOAutgACnhRwJt/ZacGDYQksDFdn
 e6bFx5w829JDx+mh3Mn2wrgMdUrXugkNinks5ArlUQMzQkoZo6lw+cx1EIWTABoY2BdG
 9CnOabSYUa10FgbiVx4xn18wRASpo/Ip0ufc9djgDTe9LwMjf57JsMkE42j40ZFlkQuS
 xvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFukHabHzU9nHDP00BQaLwWH/W2xDMgDd01lQ3KmF6E=;
 b=27cm640GzaMfC9ajaZ7kcf/I3x1UdgJKqYpL8MX/sL1+cFHOxJDa4TufpHlE7ATSP1
 0T2AWknp5ZNP+ayF5X+yV1DnQafEwtFy39K+IZh3bEDujsT4QiZ8TKxBNV3l7zIBa4v8
 M+VMfnFy4lbZMRW/hm/OZtvSUzFA3qMDlxfhnyvhvfgZVqMHQBE+ryIhnbO69QVW4ap4
 e5rSJLO1hhjeIMg7frarkY1iPg47hV9fsQReUjdy9RfwpwSrmfupyhTUL+q5LItyTZth
 DaubJjhkCd4Rms3wXJ3VVlkezARlRrvT046kxCNFsc1PjzjaVIQziSWuJyQB4Rvu4rAE
 Bj5g==
X-Gm-Message-State: ANoB5pl+oXLrl6Pl++pFU8zV+AAsFgVLEFAM5tLOSs3gNk2TYxHDM3x7
 fkFUkPRDycNIvA0DhIuujc0lZ5F5f2RabrUA9Wg=
X-Google-Smtp-Source: AA0mqf6f+5SrZjNmKrcYL9Lk5NtIaRvWLquHrmzDMU6yHBU3IEsPNFkTv5vSl/5woSgdox3nRtaQvw==
X-Received: by 2002:a63:191d:0:b0:46f:1cbd:261f with SMTP id
 z29-20020a63191d000000b0046f1cbd261fmr58570124pgl.329.1670272587255; 
 Mon, 05 Dec 2022 12:36:27 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 d24-20020a631d18000000b00478dad38eacsm183557pgd.38.2022.12.05.12.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Dec 2022 12:36:26 -0800 (PST)
Message-ID: <c062d9cb-e8c6-543a-88be-016973058d43@kernel.dk>
Date: Mon, 5 Dec 2022 13:36:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
 <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
 <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
 <20221205152708-mutt-send-email-mst@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205152708-mutt-send-email-mst@kernel.org>
Cc: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Enrico Granata <egranata@google.com>
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

On 12/5/22 1:29?PM, Michael S. Tsirkin wrote:
> On Mon, Dec 05, 2022 at 11:53:51AM -0700, Jens Axboe wrote:
>> On 12/5/22 11:36?AM, Alvaro Karsz wrote:
>>> Hi,
>>>
>>>> Is this based on some spec? Because it looks pretty odd to me. There
>>>> can be a pretty wide range of two/three/etc level cells with wildly
>>>> different ranges of durability. And there's really not a lot of slc
>>>> for generic devices these days, if any.
>>>
>>> Yes, this is based on the virtio spec
>>> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
>>> section  5.2.6
>>
>> And where did this come from?
> 
> 
> Here's the commit log from the spec:
> 	In many embedded systems, virtio-blk implementations are
> 	backed by eMMC or UFS storage devices, which are subject to
> 	predictable and measurable wear over time due to repeated write
> 	cycles.
> 
> 	For such systems, it can be important to be able to track
> 	accurately the amount of wear imposed on the storage over
> 	time and surface it to applications. In a native deployments
> 	this is generally handled by the physical block device driver
> 	but no such provision is made in virtio-blk to expose these
> 	metrics for devices where it makes sense to do so.
> 
> 	This patch adds support to virtio-blk for lifetime and wear
> 	metrics to be exposed to the guest when a deployment of
> 	virtio-blk is done over compatible eMMC or UFS storage.
> 
> 	Signed-off-by: Enrico Granata <egranata@google.com>
> 
> Cc Enrico Granata as well.

Alvaro sent me this one privately too. To be honest, I don't like this
patch very much, but that's mostly because the spec for this caters to a
narrow use case of embedded flash. It's not a generic storage thing,
it's just for mmc/ufs and the embedded space. That's a missed
opportunity. And either it'll become mostly unused, or it'll actually be
used and then extended at some point.

While I'm not a fan at all, if you guys are willing to take it in
virtio-blk, then I won't stand in your way. I would rename it though to
more specifically detail what it deals with.

-- 
Jens Axboe
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
