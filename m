Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9E0C433FE
	for <virtualization@archiver.kernel.org>; Fri,  7 Oct 2022 13:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB037418F0;
	Fri,  7 Oct 2022 13:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB037418F0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQoUrmJt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYzsrcrl8jmy; Fri,  7 Oct 2022 13:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ACCF941886;
	Fri,  7 Oct 2022 13:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACCF941886
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9296FC0032;
	Fri,  7 Oct 2022 13:12:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1897EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E765860BCB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E765860BCB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQoUrmJt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gNjlEdpABkAY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:12:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC6586117A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC6586117A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665148326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OMp8QWZyKPHqRcWXtbzSw2k75xpA2sVqehAcrmZZUGI=;
 b=iQoUrmJtlOqJoe3O5aEHi09vGdjbojs6yr/GMTN3gD2Wl4XfBMB4qWRC/zP1jgGn6QqDoL
 lbCzJvTgkfu6ETNiaCxI6rlhvbzhjcQCP/+e9xE4EmaEbwNlxPycIFYDLVCqE3/vAkFyeE
 zWNd01koVDcGxoSQ/Ft+hPY5KflZcgI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3-lFDYyiOGNg-NDhfcLVNn9g-1; Fri, 07 Oct 2022 09:12:05 -0400
X-MC-Unique: lFDYyiOGNg-NDhfcLVNn9g-1
Received: by mail-wm1-f72.google.com with SMTP id
 18-20020a05600c229200b003c1cb5820bbso1358112wmf.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Oct 2022 06:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMp8QWZyKPHqRcWXtbzSw2k75xpA2sVqehAcrmZZUGI=;
 b=j/aGAZWF8V8O6iZDjVB/CkY9dHk0muUv77yNFMXhEwNbtOFywJHc1gHu4GTkGm9DX0
 ofpcr2pTwQKiCz8ILAjbLo3rPi8GjAYYqFgTFx5eHYQN0m2Cfm+o576NivUyH5N8As7M
 CczvDY5X6SkX8VLe0GXJJunNvi9kZGmXUB8FdvdzLiHh1FzvC94RCNy90qVfGAD+ZqCT
 /4VXkbv/50vT2/iPmXKvpkSdb2D1f7UlnD82p6SbPfDDpH7uVa2fz639sD40L0oQT1je
 9vHo3QpVbQmV2D31X8Oduxw3hyqbEEbq9Guz7NEXY0T7g6MuANi7YFLp7ZDVJNBxbXLl
 4r7Q==
X-Gm-Message-State: ACrzQf3V1puj3zghhdX4eXW4hi5Kz78XmbT7BWQiV9llrXrt6NeKrpH/
 9h5+PtIqi5pHgfrSdxA4yLsDzEP85+g5Gfx8RFjIz/Qi70DeF3YIx0Ai4LxBNJzDxFij9864Psa
 f9bpR2JwOfZNYf2gDC+2iFRtpIGFH1GlmPfErMMtjmQ==
X-Received: by 2002:adf:ff8b:0:b0:22e:3608:d9f4 with SMTP id
 j11-20020adfff8b000000b0022e3608d9f4mr3077057wrr.221.1665148324638; 
 Fri, 07 Oct 2022 06:12:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Yfa5wAQsaamQRvNKx4BV8zJ6k1//dXNpRd3fj6FxVwep7gsFPPrJgH21ImFza54L+T6N21w==
X-Received: by 2002:adf:ff8b:0:b0:22e:3608:d9f4 with SMTP id
 j11-20020adfff8b000000b0022e3608d9f4mr3077042wrr.221.1665148324435; 
 Fri, 07 Oct 2022 06:12:04 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 k4-20020adff5c4000000b00228dff8d975sm1923896wrp.109.2022.10.07.06.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Oct 2022 06:12:03 -0700 (PDT)
Date: Fri, 7 Oct 2022 09:12:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
Message-ID: <20221007091127-mutt-send-email-mst@kernel.org>
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
 <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
 <20220928091512-mutt-send-email-mst@kernel.org>
 <CAJs=3_CmKjhS=Y3JHujws9y5KmN-AbSRXTnt1aZOhDzMuK7g3Q@mail.gmail.com>
 <20220929032021-mutt-send-email-mst@kernel.org>
 <CAJs=3_AgfyZkWhwK3pycSs49=k-q+9mpD3pyjG0us+ke60RqmQ@mail.gmail.com>
 <20220929033858-mutt-send-email-mst@kernel.org>
 <CAJs=3_AD_KLZHwo1gxejYRUJ6ucdCxv=3RnpOQXs+KiBEV=K5A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_AD_KLZHwo1gxejYRUJ6ucdCxv=3RnpOQXs+KiBEV=K5A@mail.gmail.com>
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

On Thu, Sep 29, 2022 at 11:51:22AM +0300, Alvaro Karsz wrote:
> > However, this means that even if host exposes VIRTIO_BLK_F_SECURE_ERASE
> > the host can not be sure guest will use secure erase.
> > Is this or can be a security problem?
> > If yes let's be strict and fail probe as current code does.
> > If not let's be flexible and ensure forward compatibility.
> 
> 
> I can't think of any security problems.
> Stefan, what do you think?
> Are you ok with clearing the feature?

I applied as is for now, using validate callback can be done on top.

-- 
MSR

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
