Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4030DC4332F
	for <virtualization@archiver.kernel.org>; Thu, 17 Nov 2022 06:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFB2D60FF6;
	Thu, 17 Nov 2022 06:12:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFB2D60FF6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZIA8nAWk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QiwuJjAQmFe; Thu, 17 Nov 2022 06:12:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4919160A84;
	Thu, 17 Nov 2022 06:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4919160A84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5CBC0033;
	Thu, 17 Nov 2022 06:12:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD73C0080
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F75C81FB8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:12:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F75C81FB8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZIA8nAWk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hTz9f5SdvP0B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:12:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34A6C81E89
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34A6C81E89
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668665552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mrgurLnci4pohKZh/f0sFRH626YeVSVylr4YFfckaQ=;
 b=ZIA8nAWkCvbTxAaW5l2aOHtz7or4lM+PXiXnyj+oUOXml9daBj9E0wCs353Q1Vm/IITqJ4
 M7tE1jUYHdksONkc/N8+d7i+WoGEMT87N2ITAcgZr5bNdCuwZOR3gNfASvl/OEJ5egmhW5
 4bXwSq/tUR6JTZbA9SI5qs5PPZeN8GQ=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-JHwBDHVmN72t4Z4dKFepAw-1; Thu, 17 Nov 2022 01:12:30 -0500
X-MC-Unique: JHwBDHVmN72t4Z4dKFepAw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13b7af40a31so392384fac.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 22:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mrgurLnci4pohKZh/f0sFRH626YeVSVylr4YFfckaQ=;
 b=5jayoda8/DcQ8eJjKKvcDi38wOXcd1VDgVcEdju622GEYTW/5S9xVn4Tr/cSklX7rZ
 EBxp9P8dXU+IIw4+CLG3pRgio8T47mat/qdw1MD4K/s/xvcho5Hd4luO31CdPT+ZNFmg
 QkVtHr5uxApwSIjrKsj0WzylfrUs1GpK+kgF51tBYye8YWQIWHSqPRdo21sUJoJl09DF
 IV7Myz2CBBTnh9lSPkSKu/u6ZwvDpNLMWp6vJkPZBB6kOGgi/C3H9DG5k1THuLCWMmta
 uv7NemgxrZ4JUf7p+bQxvZrTGyD0MNY9y7BU/xt03282yEFubv+ia9RbK++ru5JJVug/
 RsJA==
X-Gm-Message-State: ANoB5plNFn06agrAJS4ZlVPc12kbpT6YW2WvP4VAecY8CJMxGvvAlfub
 bjPch8FFbyiRHCDm9DKzRZW2HtQYjoKUSI9t3RlU5G5VuWpCR2TD7yev4MiOSeve1UCIMXrpjFx
 1dT+ZTebRW+adeKTURtcemCfSELinT8cr5B09fWYQkM3g89qmQSTOTQP5JQ==
X-Received: by 2002:a05:6870:1e83:b0:132:7b3:29ac with SMTP id
 pb3-20020a0568701e8300b0013207b329acmr3497349oab.35.1668665550182; 
 Wed, 16 Nov 2022 22:12:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6lxZ1D60/llSQbNHsuQw0aBVojhvRWJOfyelzrPQ7ojMGuxA+k1zuAVddFO3m16Pb/Ks4HXaMFFW4JJKxI2Dg=
X-Received: by 2002:a05:6870:1e83:b0:132:7b3:29ac with SMTP id
 pb3-20020a0568701e8300b0013207b329acmr3497342oab.35.1668665550017; Wed, 16
 Nov 2022 22:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20221114070233.248-1-xieyongji@bytedance.com>
 <20221114070233.248-7-xieyongji@bytedance.com>
 <CACGkMEu2t1Y=z4tw439tT7SYBdgcyTP7CRKdZGLASHTc-4gHiw@mail.gmail.com>
 <CACycT3vSbwhsrM6R8Sd23e=AfkYh18rx-4FscnWEVGiWiu4rQQ@mail.gmail.com>
In-Reply-To: <CACycT3vSbwhsrM6R8Sd23e=AfkYh18rx-4FscnWEVGiWiu4rQQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Nov 2022 14:12:19 +0800
Message-ID: <CACGkMEt6zaCF85rCOBA6hz6ai0i63i3QHRFztAEJndu_Y2z88A@mail.gmail.com>
Subject: Re: [PATCH 6/6] vduse: Support specifying bounce buffer size via sysfs
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

On Thu, Nov 17, 2022 at 2:08 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Nov 17, 2022 at 1:26 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > Add sysfs interface to support specifying bounce
> > > buffer size in virtio-vdpa case. This is a performance
> > > tuning parameter for high throughput workloads.
> >
> > I wonder what's the reason for not having this in VDUSE_CREATE_DEV?
> >
>
> This was discussed [1] before.
>
> [1] https://lore.kernel.org/netdev/20210713084656.232-3-xieyongji@bytedance.com/T/#m48ccd5bb514c40345d476bac80a59a99eeb9e9a7
>
> And the device's sysfs interface should be better than module parameters.

Right, so let's document this somewhere (probably the changelog).

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
