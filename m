Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277F6C433EF
	for <virtualization@archiver.kernel.org>; Wed,  5 Jan 2022 06:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A55EC41605;
	Wed,  5 Jan 2022 06:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vgzejTZGH9em; Wed,  5 Jan 2022 06:28:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4524341506;
	Wed,  5 Jan 2022 06:28:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19BB1C0030;
	Wed,  5 Jan 2022 06:28:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44E02C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D24CB82B93
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 39IQR5vkxkM4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:28:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE68C82B8C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641364094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Juh0lQxvHdzGy8syaSKjBdJxMOMwy5WHDH5yWK0tuKk=;
 b=YekxKhkaB5EuVmKjqUl5UHhcBVQ7H4YjmZR06AVVzB600o52wNuGNwK+Z4YwkkjjA8Qlhq
 DZkftS2xGQlWt+A/s1YG62sMVLXeZ1oRtm8vE9SRnrzlVZrZSku7Ba0M2gK2o290ujxVGb
 DIbroxV2/yDmW1yXLrcFHhlvbYiSZJg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-ULOX4BDnPk-2GNZCf-0fEA-1; Wed, 05 Jan 2022 01:28:11 -0500
X-MC-Unique: ULOX4BDnPk-2GNZCf-0fEA-1
Received: by mail-lf1-f72.google.com with SMTP id
 g40-20020a0565123ba800b00426216a233fso9008262lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jan 2022 22:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Juh0lQxvHdzGy8syaSKjBdJxMOMwy5WHDH5yWK0tuKk=;
 b=F+vW/YgclXMa1aFBlP8kzUrr5LiK3DMIAc2cFFUP3wyRkccFupZNdkr6OxRo5ppyuT
 PHMRhMgqpQXgHeTX+ZZhi7g3eDqUkg1kTNfv/XQVaFxROfpnvVZ6NxtfBPean3dqIUEW
 3JuW1o1gfsVJyjtx2zGkCHgTPdabqAIVPnCsXY2tf8p+j39yVpy6fBxS3swU9uI/TXdw
 5erxTgzD1QtNIYzXclNiBitlCXDS/Z1DyU6goXS9dwDG35aJU/fOhNImoR/Tou4oIjS1
 wbXKm2WG7sccMFSaK+bVR7t9UMXlUAaTxgeoqnda7sgSygqcW1IOsSYSkOHcCbMgw0xa
 cjMg==
X-Gm-Message-State: AOAM532YyeOgvkQj1j/07DCRe5Pm4CqSvUQnRHs/HRrlJ2vvrIVSr8r8
 OwL+ADzAWPGx0zGGN6SeC6D4DiSjO1ymFrQGWQlKXIwf9sxFxxLhie30fQKngIQO0RY0M9iX+xS
 dqOpvd7m+QBAC+JpeHWFxzyqARlFWiBKldv12/bRvwbSl+6S6/FtbmmIgNw==
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr48047739lfe.84.1641364089636; 
 Tue, 04 Jan 2022 22:28:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhSIYZ8ZTwL7CfaJYq/6gFgojM+1qcmMPKMwyalxLZ/oSQ4rOMD2lz9y7IS5d3mcFM9Cw7+JF7dlbPHpD7/lI=
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr48047730lfe.84.1641364089394; 
 Tue, 04 Jan 2022 22:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20211229092443.GA10533@L-PF27918B-1352.localdomain>
 <CACGkMEtYV7ANSYaA3d4dYC2P93nOc2qh_FxFTYabw_+Rrq4G=w@mail.gmail.com>
In-Reply-To: <CACGkMEtYV7ANSYaA3d4dYC2P93nOc2qh_FxFTYabw_+Rrq4G=w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jan 2022 14:27:58 +0800
Message-ID: <CACGkMEuFDFDB2ZADkMi-SBnBzxZncKONFm=KZyyAh2oxR-j8ZQ@mail.gmail.com>
Subject: Re:
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Jan 5, 2022 at 2:05 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Dec 29, 2021 at 5:31 PM Wu Zongyong
> <wuzongyong@linux.alibaba.com> wrote:
> >
> > linux-kernel@vger.kernel.org
> > Bcc:
> > Subject: Should we call vdpa_config_ops->get_vq_num_{max,min} with a
> >  virtqueue index?
> > Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
> >
> > Hi jason,
> >
> > AFAIK, a virtio device may have multiple virtqueues of diffrent sizes.
> > It is okay for modern devices with the vdpa_config_ops->get_vq_num_max
> > implementation with a static number currently since modern devices can
> > reset the queue size. But for legacy-virtio based devices, we cannot
> > allocate correct sizes for these virtqueues since it is not supported to
> > negotiate the queue size with harware.
> >
> > So as the title said, I wonder is it neccessary to add a new parameter
> > `index` to vdpa_config_ops->get_vq_num_{max,min} to help us get the size
> > of a dedicated virtqueue.
>
> I've posted something like this in the past here:
>
> https://lore.kernel.org/lkml/CACycT3tMd750PQ0mgqCjHnxM4RmMcx2+Eo=2RBs2E2W3qPJang@mail.gmail.com/
>
> >
> > Or we can introduce a new callback like get_config_vq_num?
> >
> > What do you think?
>
> If you wish, you can carry on my work. We can start by reusing the
> current ops, if it doesn't work, we can use new.

Just to clarify, I meant, we probably need to introduce a new uAPI on
top of the above version.

Thanks

>
> Thanks
>
> >
> > Thanks
> >
> >
> >
> >
> >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
