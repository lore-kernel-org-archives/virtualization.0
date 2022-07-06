Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45119C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 09:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB1EA83E01;
	Wed,  6 Jul 2022 09:30:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB1EA83E01
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bkfKoBfR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kce5y8m5Xl78; Wed,  6 Jul 2022 09:30:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57554833DB;
	Wed,  6 Jul 2022 09:30:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57554833DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 384B4C0035;
	Wed,  6 Jul 2022 09:30:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCE65C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 979E441706
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:30:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 979E441706
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bkfKoBfR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BijC3ap2Mn_w
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:30:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38A92416F1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38A92416F1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657099849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8BzlNPid17ZYuPXy7wyRvGnmNT9ou7kXgjhlij1C/I=;
 b=bkfKoBfRdKX0XI0LjukPw+8+J1ylQvQUuRzdAM7zAwNd7NzBDkRsahXrXaufHJU0sdPSAr
 x1Sqx1djIdeWjRnmRJqefTx34VH1ojr7KQDkbZB2oF/pkkPBFfz8sfsgdwBagdaASXs0l9
 oOjzYby5iI4KcOZp0BWKPPnAX8mDzqg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-ufisG7fcO76VmfFm771JKg-1; Wed, 06 Jul 2022 05:30:42 -0400
X-MC-Unique: ufisG7fcO76VmfFm771JKg-1
Received: by mail-lf1-f70.google.com with SMTP id
 e8-20020ac24e08000000b0047fad5770d2so4943696lfr.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 02:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y8BzlNPid17ZYuPXy7wyRvGnmNT9ou7kXgjhlij1C/I=;
 b=aLAxfJnwqXHujBEU8ycLMN0h1+2dNhCiQYyEzk+FlMrcPXKXPubafaVwOLqSGemwor
 1mFZRNw2n8jVjGBKJ8h+wEpYkKxaZwPspDPXEknyYqvVrDMDNiuzRI35E/j+qd/jnHDW
 wIX7qGFcON66gkreN7hYvEXBUzrB3DnFBJlmaZylyrCzYqq/cx3RkJqXrT5AxtGLBADN
 jUYJXMh7j4cjW9hAoeSTcp/pPrlC1BFMbEelBTMuKEPOKh5i8J36LANFmnXFKoRlC91D
 tXsrGZYLCvXIfoMWTdgplxeBLXLTpUA9xPlrParz8l/NLXGZmgqy5S5bcKejAlVToHoM
 JrQQ==
X-Gm-Message-State: AJIora8nATuaLdUQBBALvUQo+LRWJsrFl0VCAuIvlsbkgKLTjTgj5UI/
 uxA7EyDqvlfhAg2zwJeWcLmI0CVh9jMQJZAHHqoDBrmVZiJvOHJ7VIVQ5snqIhW8MuOl2SZx5u3
 OKtVVmyZjKwAuWISSQKvnP5Qq46NcNUGxl3y2vqLb6hELnrR8Mbdt8GSQJg==
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr23082267ljo.487.1657099840602; 
 Wed, 06 Jul 2022 02:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tn0VU/qJOnX+Quc4LHX2cHJ7O69wBObrlpOxDCHrDTbs96CxnRYeB35+e+oNw3fz0M5H2a3q0J32a2k7fi8g0=
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr23082245ljo.487.1657099840240; Wed, 06
 Jul 2022 02:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com>
In-Reply-To: <20220706050503.171-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Jul 2022 17:30:29 +0800
Message-ID: <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Hi all,
>
> This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> registering and de-registering userspace memory for IOTLB
> as bounce buffer in virtio-vdpa case.
>
> The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> information such as bounce buffer size. Then user can use
> those information on VDUSE_IOTLB_REG_UMEM and
> VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> userspace memory for IOTLB.
>
> During registering and de-registering, the DMA data in use
> would be copied from kernel bounce pages to userspace bounce
> pages and back.
>
> With this feature, some existing application such as SPDK
> and DPDK can leverage the datapath of VDUSE directly and
> efficiently as discussed before [1][2]. They can register
> some preallocated hugepages to VDUSE to avoid an extra
> memcpy from bounce-buffer to hugepages.

This is really interesting.

But a small concern on uAPI is that this seems to expose the VDUSE
internal implementation (bounce buffer) to userspace. We tried hard to
hide it via the GET_FD before. Anyway can we keep it?

Thanks

>
> The kernel and userspace codes could be found in github:
>
> https://github.com/bytedance/linux/tree/vduse-umem
> https://github.com/bytedance/qemu/tree/vduse-umem
>
> To test it with qemu-storage-daemon:
>
> $ qemu-storage-daemon \
>     --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server=on,wait=off \
>     --monitor chardev=charmonitor \
>     --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
>     --export type=vduse-blk,id=vduse-test,name=vduse-test,node-name=disk0,writable=on
>
> [1] https://lkml.org/lkml/2021/6/27/318
> [2] https://lkml.org/lkml/2022/7/4/246
>
> Please review, thanks!
>
> V1 to V2:
> - Drop the patch that updating API version [MST]
> - Replace unpin_user_pages() with unpin_user_pages_dirty_lock() [MST]
> - Use __vmalloc(__GFP_ACCOUNT) for memory accounting [MST]
>
> Xie Yongji (5):
>   vduse: Remove unnecessary spin lock protection
>   vduse: Use memcpy_{to,from}_page() in do_bounce()
>   vduse: Support using userspace pages as bounce buffer
>   vduse: Support querying IOLTB information
>   vduse: Support registering userspace memory for IOTLB
>
>  drivers/vdpa/vdpa_user/iova_domain.c | 134 ++++++++++++++++++++---
>  drivers/vdpa/vdpa_user/iova_domain.h |   9 ++
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 152 +++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h           |  45 ++++++++
>  4 files changed, 327 insertions(+), 13 deletions(-)
>
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
