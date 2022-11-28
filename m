Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FF5C433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 20:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AFF860B92;
	Mon, 28 Nov 2022 20:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AFF860B92
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKyEZ0Id
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oko7HgyVJ7sT; Mon, 28 Nov 2022 20:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E986E60BF2;
	Mon, 28 Nov 2022 20:03:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E986E60BF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98461C0032;
	Mon, 28 Nov 2022 20:03:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2E82C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 20:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DB97403C5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 20:03:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DB97403C5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKyEZ0Id
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYyKnsKjM3v3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 20:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3F0F403B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3F0F403B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669665784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cpAfATKQcF7prgT4McYcaxamNaRzl9Ip93dJGajnAyE=;
 b=dKyEZ0Idbpuox7YgaECCGD9Bqv52zxbOfIjJCKcY+4mi6E1w0eovHy/uFV1GJOCcv35yoZ
 xA2PkRQOFADcQRNIBT2IM4OcxOgmxh9tW+aN755eB7DWovwlUvFTBzKs2GIRERz27nC1Pk
 bLVK6Dmnls0n5VjKLN6Pkh34WokqT4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-hNN8UnfXPkC38vdyod6Ikg-1; Mon, 28 Nov 2022 15:03:02 -0500
X-MC-Unique: hNN8UnfXPkC38vdyod6Ikg-1
Received: by mail-wm1-f72.google.com with SMTP id
 c126-20020a1c3584000000b003cfffcf7c1aso9056089wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 12:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpAfATKQcF7prgT4McYcaxamNaRzl9Ip93dJGajnAyE=;
 b=eq5Y0IoG9qoGP0IRGVihFUkuRqw6RBopsgFlxcwnRC7s2KFhhoKFpz8xV1X1miSDQC
 zuhqCHNwxiYCAJrSEQw0L86I2jfGyY+07UjQ8s5KI0kmMTi7RnLBcFH0VhJqS7USySqI
 Twv+KtCfxzlqq1Ml+KN7ue8XScvL+oVLxaJDw+8kXEjrRAdptzDuRFXKlV9biXQS9MWn
 QFHSBR+8WAlO0HEBUYe5mYel2t+S/dZCWT21567JNuvRIb723hDr2LQlX+PS63Wbe++4
 KXfsbOpr5++ZkMCfMafxDCqLocgGQcesxjrD85yQwwxGny3AFU5aseb1UhxGoqRxK/3E
 bw9g==
X-Gm-Message-State: ANoB5pkoZ1AST+678IytTvlFEeuTCr/tawb15xI60o8rdCETfcmMlVdv
 MBjtuUA6fS1F5u0USSzNgIqiKZX6yIhE6xqydSlliFWeNBmnaUg9hKMbG1al/NOvv2Dxaic3fVy
 ILvHQOAIlh8cLniXH/1xN/aNEWyFg9TwmB6UicS+oww==
X-Received: by 2002:a5d:4fd0:0:b0:241:fdb9:c7b9 with SMTP id
 h16-20020a5d4fd0000000b00241fdb9c7b9mr13794026wrw.46.1669665781727; 
 Mon, 28 Nov 2022 12:03:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7xLwdb834vf8iNZ6YkC2AmSK+6+PJWJr26TKA30eIz9nkIK3QqbU50fAssUNzpYpwxnIRq5A==
X-Received: by 2002:a5d:4fd0:0:b0:241:fdb9:c7b9 with SMTP id
 h16-20020a5d4fd0000000b00241fdb9c7b9mr13794007wrw.46.1669665781394; 
 Mon, 28 Nov 2022 12:03:01 -0800 (PST)
Received: from redhat.com ([2.52.149.178]) by smtp.gmail.com with ESMTPSA id
 r6-20020adfdc86000000b0022efc4322a9sm11635804wrj.10.2022.11.28.12.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 12:03:00 -0800 (PST)
Date: Mon, 28 Nov 2022 15:02:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221128145949-mutt-send-email-mst@kernel.org>
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
 <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Fri, Nov 25, 2022 at 12:09:45AM +0200, Alvaro Karsz wrote:
> > I suggest defining a separate UAPI struct for this ioctl.
> 
> Sounds fine to me.
> I could use the following struct
> 
> struct virtio_blk_lifetime_ioctl {
>         u16 pre_eol_info;
>         u16 device_lifetime_est_typ_a;
>         u16 device_lifetime_est_typ_b;
>         u16 padding;
> };

OK. What makes it virtio specific though? Don't any other block
devices report lifetime? And shouldn't they share the same
ioctl then? Maybe this belongs to a generic lifetime.h ?
Comments documenting meaning of the fields would also be good.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
