Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F33C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 10:36:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF7B61052
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 10:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADF7B61052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72B03606FA;
	Mon, 27 Sep 2021 10:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8JEK4NtlEpln; Mon, 27 Sep 2021 10:36:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2EE70605AB;
	Mon, 27 Sep 2021 10:36:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0458AC000F;
	Mon, 27 Sep 2021 10:36:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69D44C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 10:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60DCF4064F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 10:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W2CnmZreHSQS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 10:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9D5E4064C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632739001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPcoSfISBwgrMcGuhcb0aAcLEaKSf2xroV1zxbFfhaI=;
 b=XgZQklLp7wgOirqD8eySU7W36P+l1zPRXF0733tkwjfvzGRs5KTJjvxmU3TQ9QC5/L7QBt
 T/vkdPb/vtQyvLBWR/2iY2dRoIiW6PvYnliYRUeFVoB7VcsPcavux4pNZL3mk6vQnC71R3
 s/bEDLMlKQxGUC5BCz6VKe+KVFDJqaM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-2mjnKKGGMxqqZnKCzrK00w-1; Mon, 27 Sep 2021 06:36:40 -0400
X-MC-Unique: 2mjnKKGGMxqqZnKCzrK00w-1
Received: by mail-wm1-f72.google.com with SMTP id
 z137-20020a1c7e8f000000b0030cd1800d86so21041wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hPcoSfISBwgrMcGuhcb0aAcLEaKSf2xroV1zxbFfhaI=;
 b=AEJegMAA9E3hG1uhb8eKZgVRu2/nN2EqgeAjR2Nr04EkTmIZlIXoYkoywctLFkAglv
 4DEoNMwxcUzp5lEncigWEyL0wsUZ8/3H23O3sz7NCsmyR06tT7ye9njgvFm/hEmJQyZt
 qRC004pJRxJwnxwzbAT7xocOJaGqOB87m5CL1GFectV+NeM0nxoo7SBQstdoXd6B29SN
 9pnODvYxS2o0tSrUJo1pYK8SDc/AZnazF2oSbNk4kjJzHzJ4n1mlSkBWP4nJ7spxt+wd
 8rXIVAXXQNAejXOFmcjFJfCleF8QRbt3KieDe9UwD4FAdmCL8c7Uwmr1W4BiT5yvuoQ8
 H6Ug==
X-Gm-Message-State: AOAM533Ig0SfX9t3LDRim59O6SI0rIUfmlkWK/olN0HsHCotilOWV4dj
 rGRrFWnJyhyrbHhwY6SMBhdGDlebOd01b5LWb9UERYocpCBMoWSYH32zRUyHUVBCXfXO8XIp3AT
 FUNO8tHat55vl9qEJ84fhjF91bt9GuypYQdCA4ewgIA==
X-Received: by 2002:a5d:4eca:: with SMTP id s10mr27305634wrv.255.1632738999483; 
 Mon, 27 Sep 2021 03:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZIvmWUAOTtPoqPTquH6vQYxZL6UjiYrw4VN8L1y6fYbJCmFAWd/xqPQ26IOsO48cQQ6fDrA==
X-Received: by 2002:a5d:4eca:: with SMTP id s10mr27305617wrv.255.1632738999277; 
 Mon, 27 Sep 2021 03:36:39 -0700 (PDT)
Received: from redhat.com ([2.55.16.138])
 by smtp.gmail.com with ESMTPSA id r9sm16003737wru.2.2021.09.27.03.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 03:36:38 -0700 (PDT)
Date: Mon, 27 Sep 2021 06:36:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
Message-ID: <20210927063000-mutt-send-email-mst@kernel.org>
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
 <CACGkMEt5rQv8DFdsYuJ6SF2YOsh_3YP_yzSsdL3X_n3Mfz3Gag@mail.gmail.com>
 <20210926032434.GA32570@L-PF27918B-1352.localdomain>
 <CACGkMEtrGtbzNrf96uz9zwZ7ohNg1-dUoMLfL4HWoZwv8Zejdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtrGtbzNrf96uz9zwZ7ohNg1-dUoMLfL4HWoZwv8Zejdw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Sun, Sep 26, 2021 at 12:18:26PM +0800, Jason Wang wrote:
> > > I wonder if the following can work with ENI:
> > >
> > > -device virtio-net-pci,mrg_rxbuf=off
> > >
> > > ?
> >
> > ENI didn't work.
> > I will remove F_MRG_RXBUF when get_features.
> 
> I think we need to fail FEATURE_OK if F_MRG_RXBUF is not negotiated.
> Since VERSION_1 requires a fixed header length even if F_MRG_RXBUF is
> not negotiated.
> 
> But this trick doesn't come for free. If some driver doesn't support
> mrg_rxbuf, it won't work.
> 
> Thanks

Yea. Ugh. Down the road I think we'll add legacy support to vdpa on
strongly ordered systems.  Doing it in userspace is just too messy imho.
But yes, this kind of hack is probably ok for weakly ordered systems.
BTW we need to set VIRTIO_F_ORDER_PLATFORM, right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
