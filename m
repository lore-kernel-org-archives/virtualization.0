Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B66C77B7D
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 03:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0EA6841E4;
	Wed, 17 May 2023 03:46:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0EA6841E4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TRCo8C67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b6NNxuenIF0m; Wed, 17 May 2023 03:46:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F68981FF3;
	Wed, 17 May 2023 03:46:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F68981FF3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F43DC0037;
	Wed, 17 May 2023 03:46:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77381C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49BB741F67
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:46:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49BB741F67
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TRCo8C67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IokBb2ht8zLT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:46:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDE7041EED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDE7041EED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684295167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfcASjmldT4E+gvNyOZHYqWUJmOEKNVL/zpmvGD5wLo=;
 b=TRCo8C67FMVx1HdwG7HCKovVOWQlkKjUQ2V9/9k4/z58Z1VVFlswWUtVtgTFgutJDNebY3
 tX/uFO7nT2sgUOKX1yXvw21t8fOYyf9maRlb3dv5vWLTBCU8S/IW0aHdUnP+N/atUd1Y7b
 lPli3wvtyRd7oynPYX0I/EVVWA3gZf0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-HAshkSERMSuktw5eImZjWQ-1; Tue, 16 May 2023 23:46:06 -0400
X-MC-Unique: HAshkSERMSuktw5eImZjWQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so886555e9.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684295165; x=1686887165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfcASjmldT4E+gvNyOZHYqWUJmOEKNVL/zpmvGD5wLo=;
 b=Igu0kcEWyovG4k1cSJ+XfscEXG5TWOWijnn7O1DcwgdM2/6zNIMSxiMlr4UnWZYXIR
 fTgT7tgWuAmPrQLiug6B9uhS0x11w22uuIcUd876uVN2lXIELGpRhmh8hjSERmImH+96
 k1bdE7HuPzkes9QanRHWPMQocAPWJNi8q3V6IcFucEP243AYLJt+kgdDPW3gsksgdjbm
 a3XRG71dNIQxFxA6Tw/1riU/2hl/lbeyNZLYhdui5fowWhzhuvGfYYEoxGnU889D0EVv
 /+tV+xdk0Y1s+PDxiKYxbxaSAfB0QRtBegSMul5dQAbgTC/ORHdNlAs2DF82aONmhoGa
 gb3w==
X-Gm-Message-State: AC+VfDyS2ETZIsxaH76zsz3QVVVgWCC47S9FJ84/ajc+3ms7KIwQbaAo
 OCwBbE5bhd3c9Hd2LooaTBAw9wSa1Pn2HVm4/XubqvcDzRaiOpJC6zH43ao3GGIE9md2/3+TNUq
 PrWL4RaFYTtxbeCRGd7SGn4+WLfSJBJpJtDvxk4MCHQ==
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:289b with SMTP id
 10-20020a05600c22ca00b003f42158289bmr25772119wmg.18.1684295165227; 
 Tue, 16 May 2023 20:46:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qlXUDjUO4xvBFP3SbQJ9yKaFG+4DO3tMYcx+WnWhMF/m0M3HpvgIQwljf5Tf7Ysq0EWC19A==
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:289b with SMTP id
 10-20020a05600c22ca00b003f42158289bmr25772106wmg.18.1684295164935; 
 Tue, 16 May 2023 20:46:04 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b003f423a04016sm786764wmo.18.2023.05.16.20.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 20:46:04 -0700 (PDT)
Date: Tue, 16 May 2023 23:46:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Message-ID: <20230516234444-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230517025424.601141-1-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
> v1 -> v2:
> - Suggested by MST, use fast path for vring based performance
> sensitive API.
> - Reduce changes in tools/virtio.
> 
> Add test result(no obvious change):
> Before:
> time ./vringh_test --parallel
> Using CPUS 0 and 191
> Guest: notified 10036893, pinged 68278
> Host: notified 68278, pinged 3093532
> 
> real	0m14.463s
> user	0m6.437s
> sys	0m8.010s
> 
> After:
> time ./vringh_test --parallel
> Using CPUS 0 and 191
> Guest: notified 10036709, pinged 68347
> Host: notified 68347, pinged 3085292
> 
> real	0m14.196s
> user	0m6.289s
> sys	0m7.885s
> 
> v1:
> Hi,
> 
> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> 
> Jason and Stefan pointed out that a non-vring based virtqueue has a
> chance to overwrite virtqueue instead of using vring virtqueue.
> 
> Then I try to abstract virtqueue related methods in this series, the
> details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
> 
> Something is still remained:
> - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
>   virtio core, I'd like to rename them to vring_virtqueue_break
>   /vring_virtqueue_unbreak. Is this reasonable?

Why? These just set a flag?

> - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
>   /virtqueue_get_vring is vring specific, I'd like to rename them like
>   vring_virtqueue_get_desc_addr. Is this reasonable?
> - there are still some functions in virtio_ring.c with prefix *virtqueue*,
>   for example 'virtqueue_add_split', just keep it or rename it to
>   'vring_virtqueue_add_split'?
> zhenwei pi (2):
>   virtio: abstract virtqueue related methods
>   tools/virtio: implement virtqueue in test
> 
>  drivers/virtio/virtio_ring.c | 285 +++++-----------------
>  include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
>  include/linux/virtio_ring.h  |  26 +++
>  tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
>  4 files changed, 807 insertions(+), 300 deletions(-)
> 
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
