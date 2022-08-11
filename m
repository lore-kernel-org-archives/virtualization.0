Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D8AC19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 18:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCC5560B91;
	Thu, 11 Aug 2022 18:50:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CCC5560B91
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPcy44jQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMfUTeDknrXI; Thu, 11 Aug 2022 18:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14F3E60864;
	Thu, 11 Aug 2022 18:50:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14F3E60864
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3C11C0033;
	Thu, 11 Aug 2022 18:50:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C33A8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95250408DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95250408DC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPcy44jQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id paIPFBtZiOsE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF67640929
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF67640929
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660243817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZCkYKX+YocCFfhSB40Lllh1ri1NcE9eoUatp18CalQU=;
 b=hPcy44jQlNf8ncXtzwgVh2Q1vpNLxF8zDAQVhwbv3/BR9cU8BtKyG142TJyZgSCpyHNNiE
 YPBGPjh6Fgy4YwXO9HO318thMulyYdUgfCe8bZ3E97tzj+WXFg6GlNz27kr9jbecYQZ0PM
 cZKPEAZjELHlMrkHOEOagaSKpkRBsdE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-Atv6Je3wOkOpywitn92ulQ-1; Thu, 11 Aug 2022 14:50:16 -0400
X-MC-Unique: Atv6Je3wOkOpywitn92ulQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 p19-20020a05600c1d9300b003a5c3141365so476078wms.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 11:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=ZCkYKX+YocCFfhSB40Lllh1ri1NcE9eoUatp18CalQU=;
 b=aoWH7eCXcXZLv0RbU6FWwRdycdthkpww76yorUQeJJfMA1Cjkbu6f1C/tZ5bdOfPY6
 F9Axl87QFSNNk4890W51zuwKVxBch2LdPNNA1MlpC2FGo9dnVdXWDQHXRKTn1821rMQP
 HFcylUe9VDkjPvHAWjRfleKY7yKxt2CTZLCw30fBKz6o61wGqd3kRATtuuVNfdgZzO1n
 RcHqq50v6lF37CPz2ImxnEkhvYSExaysmtz4N9VuCs8FKuUeBW+zjHAwuuj05OZjUdB8
 uFAN9vnLH8xFUftX+9f0+yGGZbfGp5fk7iRZQrLfUVJG/+45Cn0EWwe9/fAkX0JNcjAn
 3/SQ==
X-Gm-Message-State: ACgBeo13JyszldBdLlXa+egEOXVq5E0/9vcrssXJXtV/ZQGyfYX8JrDt
 IsBXdDqNscqD9JQvlAcU6H3PFOSRG7t8BFh2abQyIeC/3hKMWJAldYVJ2tWjqZHCO4cyH7xddfj
 XxkdZ28DyWEW8l7QZZQbmEDh/JkObIRiuanBFMbR2XQ==
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id
 f7-20020a0560001a8700b002222c852f5bmr195951wry.654.1660243815347; 
 Thu, 11 Aug 2022 11:50:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6LBiM5dQ9y7fRQHZ7uhmIZyZmCby6c7ic+mJTmauceGDSlYOfL1ZVjf7Fmwgdj57rpPaPTwQ==
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id
 f7-20020a0560001a8700b002222c852f5bmr195948wry.654.1660243815164; 
 Thu, 11 Aug 2022 11:50:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 189-20020a1c02c6000000b003a545ff43c5sm172878wmc.45.2022.08.11.11.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 11:50:14 -0700 (PDT)
Date: Thu, 11 Aug 2022 20:50:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: build failure of next-20220811 due to d79b32c2e4a4
 ("vdpa_sim_blk: add support for discard and write-zeroes")
Message-ID: <20220811185008.jiqcv4ovv4sglsap@sgarzare-redhat>
References: <YvU67iF4z5gB4ZYk@debian> <YvVK+ZqO75QAYYnB@dev-arch.thelio-3990X>
MIME-Version: 1.0
In-Reply-To: <YvVK+ZqO75QAYYnB@dev-arch.thelio-3990X>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 clang-built-linux <llvm@lists.linux.dev>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org,
 "Sudip Mukherjee \(Codethink\)" <sudipm.mukherjee@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Aug 11, 2022 at 11:31:21AM -0700, Nathan Chancellor wrote:
>On Thu, Aug 11, 2022 at 06:22:54PM +0100, Sudip Mukherjee (Codethink) wrote:
>> Hi All,
>>
>> Not sure if it has been reported, builds of arm64 with clang failed to
>> build next-20220811 with the error:
>>
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:201:3: error: expected expression
>>                 struct virtio_blk_discard_write_zeroes range;
>>                 ^
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:204:25: error: use of undeclared identifier 'range'
>>                 if (to_pull != sizeof(range)) {
>>                                       ^
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:207:21: error: use of undeclared identifier 'range'
>>                                 to_pull, sizeof(range));
>>                                                 ^
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:212:60: error: use of undeclared identifier 'range'
>>                 bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
>>                                                                          ^
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:222:38: error: use of undeclared identifier 'range'
>>                 sector = vdpasim64_to_cpu(vdpasim, range.sector);
>>                                                    ^
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:224:43: error: use of undeclared identifier 'range'
>>                 num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
>>                                                         ^
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:225:37: error: use of undeclared identifier 'range'
>>                 flags = vdpasim32_to_cpu(vdpasim, range.flags);
>>                                                   ^
>> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:202:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
>>                 u32 num_sectors, flags;
>>                     ^
>> 8 errors generated.
>>
>>
>> git bisect pointed to d79b32c2e4a4 ("vdpa_sim_blk: add support for discard and write-zeroes").
>> And, reverting that commit has fixed the build failure.
>>
>> I will be happy to test any patch or provide any extra log if needed.
>
>I am very surprised GCC does not error out in the same way, since as far
>as I understand it, labeled statements have to be followed by a
>statement and a declaration is not a statement in C so braces are
>needed. In fact, it seems like something changed (regressed?) between
>GCC 10.x and 11.x?
>
>https://godbolt.org/z/EYaGa1eE3

Interesting, I confirm that also gcc 12 does not warns/error.
This is my version:

     $ gcc --version
     gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1)

>
>I am going to bisect GCC to find out whether or not that was
>intentional. At any rate, isn't this the proper fix? I can send it as a
>formal patch if desired.

Yep, that was the fix and I already re-sent a new series with the patch
fixed:
https://lore.kernel.org/virtualization/20220811083632.77525-1-sgarzare@redhat.com/T/#t

Michael already queued the new version in his tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
