Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB82EB64D9
	for <virtualization@archiver.kernel.org>; Sat, 17 Jun 2023 07:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA73440383;
	Sat, 17 Jun 2023 07:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA73440383
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JbGFaoPQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ro4kzhdhqBez; Sat, 17 Jun 2023 07:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CCE0400C5;
	Sat, 17 Jun 2023 07:45:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CCE0400C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21590C007A;
	Sat, 17 Jun 2023 07:45:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C792C0029
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jun 2023 07:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D76B583C5F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jun 2023 07:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D76B583C5F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JbGFaoPQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3OslQX24VoL
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jun 2023 07:45:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 872B983B14
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 872B983B14
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jun 2023 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686987902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QSqZn9QpuYGjBKZIP5tPfM6PUFXTeXl41pLP2tW5TZM=;
 b=JbGFaoPQ/w6rAVQA/AYELbOcYToSvLWamDwTe/sQhnk5rV6YRdtR42GxQIBZ+0OofeQT9o
 cI0j/WuIPjkMGtVbapG9njxwZSNhvrzxX/AxUXaowkbDtotqyf3BSaCKr4bJIxis5Dume4
 k+1C0pN2luvdRM4tpMpk1au1l2BD2Gc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-JadKnH2pNwmqZEWnHUvngQ-1; Sat, 17 Jun 2023 03:45:00 -0400
X-MC-Unique: JadKnH2pNwmqZEWnHUvngQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso7607815e9.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jun 2023 00:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686987899; x=1689579899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSqZn9QpuYGjBKZIP5tPfM6PUFXTeXl41pLP2tW5TZM=;
 b=Te/2cjYlYm9UOKIrAAKXyI6LnrhJ4oMgsPOIYiK3eUFN05DhzwF3Dreol02Mtk/tFt
 9KnfqDCa9hMqkjHcjDB5J4b8ujv73WCXkJFE2Kt7guFS3vvB2dZLMlPyWBSy8qFwjnP9
 7mDvcKtCWgnYQdRl2eKZxEHD2IKe2wtrmcE5mbU9gckbCWPGMMq7WxLbbqvKfdMJONBt
 ankL4LYsGizx8P0BKLyfBoiSQyzQPWTDoMlpPZcGp5FDJ6VtEjfqfrgoJFoAM0Gos8xp
 zMQiDAyxSWM1VUFDI96CKUBJyQEL8SOq5v7o4ADt2gNNacEym+x3nR3N7inO1SrJZPY3
 PS9Q==
X-Gm-Message-State: AC+VfDxY/Ito4pXs4mPLI0qR3V+3onsbklwayRtCr9pMSbEkIDuAsf9r
 w/+u+r+b0xlj2+IVdukwuIluA4YjBcYsu2R+LQVStoKGTz1uWwB3Ln7hRo6Id6rLCEUuTptD/oH
 FyOMJsKzvVenLN8N3iz/w7kYY9ytNSk55WIW0jq1+HA==
X-Received: by 2002:a7b:c419:0:b0:3f8:575:4a9b with SMTP id
 k25-20020a7bc419000000b003f805754a9bmr3605853wmi.30.1686987899598; 
 Sat, 17 Jun 2023 00:44:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74ufbuUC360emgyQVJbIbar3zy9bMaJtCH9tng2Qd93aLJgFUFNSlVu+3Budf5dG/gRmpAeA==
X-Received: by 2002:a7b:c419:0:b0:3f8:575:4a9b with SMTP id
 k25-20020a7bc419000000b003f805754a9bmr3605842wmi.30.1686987899341; 
 Sat, 17 Jun 2023 00:44:59 -0700 (PDT)
Received: from redhat.com (46-223-98.internethome.cytanet.com.cy.
 [46.199.223.98]) by smtp.gmail.com with ESMTPSA id
 x4-20020a05600c21c400b003f42a75ac2asm4183876wmj.23.2023.06.17.00.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jun 2023 00:44:58 -0700 (PDT)
Date: Sat, 17 Jun 2023 03:44:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RFC PATCH net 0/3] virtio-net: allow usage of small vrings
Message-ID: <20230617034425-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Sun, Apr 30, 2023 at 04:15:15PM +0300, Alvaro Karsz wrote:
> At the moment, if a virtio network device uses vrings with less than
> MAX_SKB_FRAGS + 2 entries, the device won't be functional.
> 
> The following condition vq->num_free >= 2 + MAX_SKB_FRAGS will always
> evaluate to false, leading to TX timeouts.
> 
> This patchset attempts this fix this bug, and to allow small rings down
> to 4 entries.
> 
> The first patch introduces a new mechanism in virtio core - it allows to
> block features in probe time.
> 
> If a virtio drivers blocks features and fails probe, virtio core will
> reset the device, re-negotiate the features and probe again.
> 
> This is needed since some virtio net features are not supported with
> small rings.
> 
> This patchset follows a discussion in the mailing list [1].
> 
> This fixes only part of the bug, rings with less than 4 entries won't
> work.
> My intention is to split the effort and fix the RING_SIZE < 4 case in a
> follow up patchset.
> 
> Maybe we should fail probe if RING_SIZE < 4 until the follow up patchset?
> 
> I tested the patchset with SNET DPU (drivers/vdpa/solidrun), with packed
> and split VQs, with rings down to 4 entries, with and without
> VIRTIO_NET_F_MRG_RXBUF, with big MTUs.
> 
> I would appreciate more testing.
> Xuan: I wasn't able to test XDP with my setup, maybe you can help with
> that?
> 
> [1] https://lore.kernel.org/lkml/20230416074607.292616-1-alvaro.karsz@solid-run.com/

the work is orphaned for now. Jason do you want to pick this up?
Related to all the hardening I guess ...

> Alvaro Karsz (3):
>   virtio: re-negotiate features if probe fails and features are blocked
>   virtio-net: allow usage of vrings smaller than MAX_SKB_FRAGS + 2
>   virtio-net: block ethtool from converting a ring to a small ring
> 
>  drivers/net/virtio_net.c | 161 +++++++++++++++++++++++++++++++++++++--
>  drivers/virtio/virtio.c  |  73 +++++++++++++-----
>  include/linux/virtio.h   |   3 +
>  3 files changed, 212 insertions(+), 25 deletions(-)
> 
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
