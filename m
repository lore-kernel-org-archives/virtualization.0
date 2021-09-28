Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C3DC433FE
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 02:17:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E546124B
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 02:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7E546124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FFFA406D4;
	Tue, 28 Sep 2021 02:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrRQ701qpo0m; Tue, 28 Sep 2021 02:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3C58E406D8;
	Tue, 28 Sep 2021 02:17:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1851DC000F;
	Tue, 28 Sep 2021 02:17:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5C7C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 02:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E707760ACF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 02:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XGA1TQqQ9QX1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 02:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0846160ACB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632795437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjDH+v8vXfFpUX6MvlCaFytflSzUw6jy65GgeDUX/wA=;
 b=BjXoNzr4HAmBw+YJCvioy3dOa4+246FY1zV6SSxtgnSbxtdRYa6JcWdIRrvkT1I0NrBhwI
 df3UTvshoIHcMTFZ0lyIArlogwalyKruH9iOKvIy+irIR6+bXuGZSNTw2wyBr+ijj8zAVT
 ktbu5dTfTYhEYsPJAmQW17uaRoJvQpA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-LaZbUn8eOpSl_JSXqoaCUA-1; Mon, 27 Sep 2021 22:17:16 -0400
X-MC-Unique: LaZbUn8eOpSl_JSXqoaCUA-1
Received: by mail-lf1-f69.google.com with SMTP id
 s8-20020ac25c48000000b003faf62e104eso17689466lfp.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 19:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jjDH+v8vXfFpUX6MvlCaFytflSzUw6jy65GgeDUX/wA=;
 b=erT9bTNeSO17CQ2IYQKs0VZl8HpcfoogK041Q40wTf+Z5bt46k6mXSGGxE9jBfucWc
 81U+sCMyyiuPTqOjMvqGAZ5Ql7KYwL4Ba030fKTttbg6DP2bKffva7DuPZNUWSTCppOJ
 8iyscJqN8O/VpIgnOYf6kqtL668VO+b3Ry1oJ0D0QHgw0WESMTY6DRnydlVvQjSJFByX
 S09joSr+FLag/e+M9X22dmetgIZ3jxTIU9wEW1L5fNrKTAwJBbaLtsXSvr6Attq5sJTn
 QBMi4UlUcUwHQB9Veziv6nhCjaJlVTd5eC/X6xp0Lt11tMlQk1ZN8lMx/uYOu9tDzqF9
 z8hg==
X-Gm-Message-State: AOAM531G/FQehhoDlUXhwAAAlrLlVmTMam9waeFki9FynolL8+uswJEs
 LVlZfa1C8GLVp1UUBxm/wCyM5jO1JponUY6mJvkdfU8I/FkEv8Fc6jJH4IQN2BjanfImF2Z6tdR
 mr4/vzEc94W052hEM86x3+PqNeWuTZjiFS+VfwZezsGkBNEu/H8TOHfuDNA==
X-Received: by 2002:a05:6512:118a:: with SMTP id
 g10mr3023659lfr.580.1632795435026; 
 Mon, 27 Sep 2021 19:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9tp6c4VDNDZmHayadbTG+vvHo5VUHS5CIyS5CDuzclWyj25CxSSe/riXLL8VnAe2i7A0xZ1VmyXTPZc6+qTo=
X-Received: by 2002:a05:6512:118a:: with SMTP id
 g10mr3023650lfr.580.1632795434860; 
 Mon, 27 Sep 2021 19:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
 <CACGkMEt5rQv8DFdsYuJ6SF2YOsh_3YP_yzSsdL3X_n3Mfz3Gag@mail.gmail.com>
 <20210926032434.GA32570@L-PF27918B-1352.localdomain>
 <CACGkMEtrGtbzNrf96uz9zwZ7ohNg1-dUoMLfL4HWoZwv8Zejdw@mail.gmail.com>
 <20210927063000-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210927063000-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Sep 2021 10:17:04 +0800
Message-ID: <CACGkMEs+s1ArZqgPqwJ2VLMxO9GWqfZNPeLv9BFoHvn6TFHndQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Sep 27, 2021 at 6:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Sep 26, 2021 at 12:18:26PM +0800, Jason Wang wrote:
> > > > I wonder if the following can work with ENI:
> > > >
> > > > -device virtio-net-pci,mrg_rxbuf=off
> > > >
> > > > ?
> > >
> > > ENI didn't work.
> > > I will remove F_MRG_RXBUF when get_features.
> >
> > I think we need to fail FEATURE_OK if F_MRG_RXBUF is not negotiated.
> > Since VERSION_1 requires a fixed header length even if F_MRG_RXBUF is
> > not negotiated.
> >
> > But this trick doesn't come for free. If some driver doesn't support
> > mrg_rxbuf, it won't work.
> >
> > Thanks
>
> Yea. Ugh. Down the road I think we'll add legacy support to vdpa on
> strongly ordered systems.

I don't see the connection, can you explain why?

> Doing it in userspace is just too messy imho.
> But yes, this kind of hack is probably ok for weakly ordered systems.
> BTW we need to set VIRTIO_F_ORDER_PLATFORM, right?

Right.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
