Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11148C04A95
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 13:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8757B4171A;
	Wed, 28 Sep 2022 13:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8757B4171A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHqiw8yJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1BJsmaUktPq; Wed, 28 Sep 2022 13:15:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89752409EB;
	Wed, 28 Sep 2022 13:15:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89752409EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58774C0033;
	Wed, 28 Sep 2022 13:15:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97F60C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 13:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 615A260648
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 13:15:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 615A260648
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHqiw8yJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uIzUXv-5z9oq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 13:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1155605A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1155605A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664370940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ScTNj9tqOpuw6kPMl1J7cAQWzFLU/jH90dwtnZ/vITw=;
 b=MHqiw8yJuKQDJTa/Yr1VlAPJ0hWFYB7Bbuxyyf/BRNxmfVzXRJp6VBlKW7U5xzDdekH/vF
 ejntCcG3VOC+s4ngQaMpC93rrKPltxbHA0l3aNtJuGQ5Ins+C7je6CI0ds6PMvaDwgMTQw
 CmcVA3V6y2YZf3aKr/8sErBfP4LqXP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-83-JMxJnnf1Ol66p6P94z13Ug-1; Wed, 28 Sep 2022 09:15:38 -0400
X-MC-Unique: JMxJnnf1Ol66p6P94z13Ug-1
Received: by mail-wm1-f70.google.com with SMTP id
 y20-20020a05600c365400b003b4d4ae666fso553527wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 06:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=ScTNj9tqOpuw6kPMl1J7cAQWzFLU/jH90dwtnZ/vITw=;
 b=vIyfQIEeVgFZ6BE0/5CHrti7aj2SvNsIlMWTqtICPVPBcNiRTmo6Wz+WSMh+QMU0/Z
 WA3kQ+g7cmhLDguU6PBZ3ohNBqrl/Ll2NEBkSfqVSARcc53pgaI5oMdlKauLa5yHT//I
 VDsZ8t+6m2rA6bs7vqi48fkI2cOqmKXpHlcherMEaA3JDLjQGHsQbG17qli7iNHSSaE5
 rAhk4TvkVg6DmgywsnmKFd0fHpG6iWE8iApXf7V8G9tfw5kr72ojUgVt2ol8KCp1mLjN
 JAPeofR+KBtn2Tx7ApbC/aLLSDiTI3tKVpuvXM8Eki6szdPEoCt2slN9GbqEXyhvRdEA
 tkbg==
X-Gm-Message-State: ACrzQf0SXdEAh2mV11jA9Da6lZ6TeF45/4pmzXubpA/iWzH3Z6qMI2Tu
 wpvMrwh95bDcVG4ovlz0LrqNIJOWMRrlagyUIbuaHERiR8TQSeCNNjszDtPrndtqxgUnQnhp62u
 vlLj7arCWLdsxBYM21u3AXqC51BHBE563Ozp/Q/sYNg==
X-Received: by 2002:a05:6000:15c6:b0:22b:1ffd:a67a with SMTP id
 y6-20020a05600015c600b0022b1ffda67amr21916602wry.538.1664370937653; 
 Wed, 28 Sep 2022 06:15:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5tNIdLvAcfBJwEP7AFvcAUmlnHNQhphRgfuGAJUPsSukdqwj84LwVaUZuSMB4Te8uavgvWGQ==
X-Received: by 2002:a05:6000:15c6:b0:22b:1ffd:a67a with SMTP id
 y6-20020a05600015c600b0022b1ffda67amr21916582wry.538.1664370937448; 
 Wed, 28 Sep 2022 06:15:37 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 k3-20020a05600c1c8300b003b497138093sm1583911wms.47.2022.09.28.06.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Sep 2022 06:15:36 -0700 (PDT)
Date: Wed, 28 Sep 2022 09:15:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
Message-ID: <20220928091512-mutt-send-email-mst@kernel.org>
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
 <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Wed, Sep 28, 2022 at 01:48:43PM +0300, Alvaro Karsz wrote:
> > What I worry about is that down the road we might want to add
> > special meaning to currently unused values.
> > If doing that just clears VIRTIO_BLK_F_SECURE_ERASE then
> > we have forward compatibility. If it fails probe then we
> > won't be able to do use these values.
> 
> 
> They are not exactly unused, we are using them to calculate the
> "discard sector alignment" and the "max discard sectors" values.
> The values are even used directly if VIRTIO_BLK_F_DISCARD is not negotiated.

Could you explain this last part? Why are they used without
VIRTIO_BLK_F_DISCARD?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
