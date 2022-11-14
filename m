Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E205C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 08:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1761A40477;
	Mon, 14 Nov 2022 08:55:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1761A40477
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOhpWGfy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uytUcjMb2iJJ; Mon, 14 Nov 2022 08:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F77340137;
	Mon, 14 Nov 2022 08:55:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F77340137
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEACC0033;
	Mon, 14 Nov 2022 08:55:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFBE5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E1EB60D7B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:55:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E1EB60D7B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOhpWGfy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJ8dzYHBifvm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:55:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFE9B60AFC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFE9B60AFC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668416124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FEwrNo/JFW5QD6BQxCTaJ7p3JbBTuhUbP3f7m+47MvU=;
 b=fOhpWGfyyJBAhVY/fLXp6Zt06ARN70qrXefJ5QyE/FG2PKRE1zQw2p23tzx8XYFO2TYI+u
 JYop5LKxy1dwxMcBXFjgt/iiCoN0p/ACCtjG9MooLFlz/y0/EJbVZkKiNyawCyYDnMv0LQ
 4Uz6gWX00f3ZckXXEBK9WIF5Ig9P8kI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-j2aPxf9LNlOlO48bavrYbQ-1; Mon, 14 Nov 2022 03:55:23 -0500
X-MC-Unique: j2aPxf9LNlOlO48bavrYbQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 bj30-20020a056808199e00b0035a0734664bso2991480oib.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 00:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FEwrNo/JFW5QD6BQxCTaJ7p3JbBTuhUbP3f7m+47MvU=;
 b=0tHU4HCC6Srrx/isYOrxJirUdCnmj4A2JG7Nzs/5UEdLQblPmeedEObCdKS42TSJ0m
 nuQDaY/6yRZbAKpFbxWhZq02dqy1vPY1Nx1qPF15L4UQQ9CPZ/QRlPEyLugZ5ke9G8Em
 bzn3sqXzSDf0cgdw07wgZ8QR4+gPvBzYauU4Qgo0c4gNUj/5oB1+gNE6P1I+6bqBxWOy
 eUEoF4eNrIr2PWcCyRymNmQZ2Pg6F6F1Jw1R8ijp2Ln0K3cKGLby/iXpbcD2g0bfA9e1
 Mtq7Hc02JAtydj0eCSEBxbqu+SqF333h3+nm5U/eM9qzzNMruywKq2HDdwKIjTfkPUhK
 4tjQ==
X-Gm-Message-State: ANoB5pmdA1gZw+0LVGzoDUGY09E86UxM9kydC97Ehk4psyN8s7qDjYD3
 CdNuDTAYtQFth2OyqwBQHzqKf/so4nOX1lbrwwuqJtmahq6y4wvvcGNeazQb6rcLZz3Eq0ICrgr
 +mnd/gF+FeNMCK1jcMDYbz5MD/+Op1uQVa7LHTKiWHCRLtBMIAGrkQTm0+w==
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5279732oip.35.1668416122445; 
 Mon, 14 Nov 2022 00:55:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7evsCpnEXbAJyPQsLLGsw0eSbKpJfKLWxXp5EG0cKpBdX2ifUufLop6LLB+7P/lQ7GJDKXYnwdTf8lkqq3R40=
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5279727oip.35.1668416122279; Mon, 14 Nov
 2022 00:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20221114070233.248-1-xieyongji@bytedance.com>
 <20221114070233.248-4-xieyongji@bytedance.com>
 <CACGkMEsbScqRtZeJ51ySiYdR_DrHwVAEGg_n0TR2mA2nK9e7sQ@mail.gmail.com>
 <CACycT3s8CbO1YD3AAzN-iXEkf6MKM7ihK+=NFik+33HDjanBJQ@mail.gmail.com>
In-Reply-To: <CACycT3s8CbO1YD3AAzN-iXEkf6MKM7ihK+=NFik+33HDjanBJQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 16:55:11 +0800
Message-ID: <CACGkMEvOYqBrFz5Fp2fL=QBU0fLBAZXLtXtX2OhMg+DuJPSUmQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add sysfs interface for irq affinity setup
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Nov 14, 2022 at 4:20 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Mon, Nov 14, 2022 at 3:58 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > Add sysfs interface for each vduse virtqueue to setup
> > > irq affinity. This would be useful for performance
> > > tuning, e.g., mitigate the virtqueue lock contention
> > > in virtio block driver.
> >
> > Do we have any perforamnce numbers for this?
> >
>
> Almost 50% improvement (600k iops -> 900k iops) in the high iops
> workloads. I have mentioned it in the cover-letter.

For some reason, I miss that.

I also wonder if we can do this automatically, then there's no need to
play with sysfs which is kind of a burden for the management layer.

Thanks

>
> > Btw, I wonder if irq is the best for the name since we actually don't
> > use IRQ at all. I guess using "callback" might be better?
> >
>
> Looks good to me.
>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
