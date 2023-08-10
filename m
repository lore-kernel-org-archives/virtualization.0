Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18292C001E0
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 19:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8938741E00;
	Thu, 10 Aug 2023 19:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8938741E00
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=esB5CoWp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ardxoBg8Doko; Thu, 10 Aug 2023 19:02:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35CCB41DFC;
	Thu, 10 Aug 2023 19:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35CCB41DFC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5A6AC0072;
	Thu, 10 Aug 2023 19:02:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEFCEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B456D6132F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B456D6132F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=esB5CoWp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 51mGu8wsV9mJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:02:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 082666132B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 082666132B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691694172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwKZd9kJdARYjGG+RNfCj3MbPwhouNi+dlJfp58+jtI=;
 b=esB5CoWpHAWgvtP+4prvps4Nl/uTpeiKf6IhHrGHZmy4U7j+rLZNFKL7bzlRxWZ8uRBpiX
 4ahjxWONK56RHJ1x8TbshpYcgISYJf398Dcx9CygH5Jd8mp9M97YXEgQQnHH2CgdlHred1
 cO7tphe+9n/I+lEeFwiGU0uVRAuKGFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-aE18sSoUNJSwMyTT1xZkrQ-1; Thu, 10 Aug 2023 15:02:51 -0400
X-MC-Unique: aE18sSoUNJSwMyTT1xZkrQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe45e71db3so8236755e9.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691694170; x=1692298970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwKZd9kJdARYjGG+RNfCj3MbPwhouNi+dlJfp58+jtI=;
 b=mFCjKoJ/pIDJcj21qaLYV2FKi4LagygZoZoHtjSy+sm24PnEJvJ3tiYkjzi3oj+4er
 I43eRYFq7+M0yr9TEx8pB+8uQ5MsMGYO479Omt05SdVm6hEZ3IkZJunTtRv7gFdF4kLA
 dRYXyh2C2zmRvRKRpeqC9k+ljmUMhXJQvZWKiCWDkH4IkDeh3Ov//ye8tIUtXqxLAooe
 ZY+lxxoYyjkKmOVX+iGYC/wiQWcwfmWyUyYzLAiAIFr/QAy3kPcfivGi0aLXtiIpLWvl
 8cpoxLAltsvWYHKjEXEHXWTyaA4+Qzd0HCVunJLcMyJ10p36vJmbeR/SInK+vlruMCsy
 FUrQ==
X-Gm-Message-State: AOJu0Yz9yQbmFwJGbnfRw2evwM9uoIGxdsRrGrZr7BFdvBQpwZ+2j7WT
 WzvCP1eVITMaKybsZEjgRexQneG9uuafUHk0s1l2d+zilnldfzvdEXDcwfFEa6EzLf7IRGBlRSW
 0nNgyRM74LNd2kRHhKWYeKWqaX7JCxmM4DNnMBiRRHg==
X-Received: by 2002:a1c:7314:0:b0:3fa:973e:2995 with SMTP id
 d20-20020a1c7314000000b003fa973e2995mr2547797wmb.12.1691694169961; 
 Thu, 10 Aug 2023 12:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZ6F49Kczr81tfxKe4/wLYJAobKnso77Sg3Wp4JvIX7WMl/+GBlExXHBVr9v5j92CbJJyyw==
X-Received: by 2002:a1c:7314:0:b0:3fa:973e:2995 with SMTP id
 d20-20020a1c7314000000b003fa973e2995mr2547777wmb.12.1691694169592; 
 Thu, 10 Aug 2023 12:02:49 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 y1-20020a05600c364100b003fbb06af219sm2911778wmq.32.2023.08.10.12.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 12:02:48 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:02:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230810145938-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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

On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably.
> 
> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> 
> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)

So I can put this in next, the issue I think is
that of security: currently selinux can if necessary block
access to creating virtio block devices.
But if we have more than one type we need a way for selinux to
block specific types. Can be a patch on top but pls work to
address.

Another question is that with this userspace can inject
packets directly into net stack. Should we check CAP_NET_ADMIN
or such?


> Maxime Coquelin (2):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
