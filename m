Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03512C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 16:42:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A61E64FE9
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 16:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A61E64FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D53358410F;
	Thu, 11 Mar 2021 16:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78fbJx3BeDds; Thu, 11 Mar 2021 16:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ADC883B67;
	Thu, 11 Mar 2021 16:42:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8251C000C;
	Thu, 11 Mar 2021 16:42:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 868F6C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 16:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C99C83D35
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 16:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fIYg9nfZ0ff3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 16:42:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7104F83B67
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615480964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Va1ZOtanAw2n/6dRqr+9ZkAc2XTPpNeFM2MzXmR/KFc=;
 b=jPi7sidgC2l9zhoYFVD9ZaW84WNIqDQonyIBBhyFbY9zX4/s67FYyiig8cfiHG9IP5YJsD
 pxcUCIiQAohyk/BmYDXE9GriiIAbKgey3VWyQzkeYU0I8Pvp5XYtvBNIJ2pCvuH2moP1rZ
 bfFPXOSUp5PQ2MPrUltTsrep/n2fRbY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-PaoDX6kdPVynOP6XhHhHuw-1; Thu, 11 Mar 2021 11:42:41 -0500
X-MC-Unique: PaoDX6kdPVynOP6XhHhHuw-1
Received: by mail-wr1-f69.google.com with SMTP id m9so9785254wrx.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 08:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Va1ZOtanAw2n/6dRqr+9ZkAc2XTPpNeFM2MzXmR/KFc=;
 b=iUXk7m3UYo6wD5kVp84S4mRhe5Cwar3hwkcE2lUrcJXzUaOpzOyholiRT3SNyW2zaN
 a6fzxz7r/Mskyj6AuV2sJDD46EQosF47tTMptcu58Qzsly7EMsyxvEG6iSnHZFH/f1bA
 yFoFNaC3lyLYB7wlEGdO34BQg24LS5R+xHKLmkpfCS2QcnncVIa2o9jNdf5FSU/Uxns/
 kk/22QK5F826yqZ26ulqs+1O9K/VU8tlTLRpe6bAVnwg5vO6I0B37eE0b193otmJf/zJ
 B580PwohGscy/4PObR9P9xaAuVzyIs4EA/45C7EX8VAs5AfeDzGKjUyNzGRXNlAukqew
 qIlA==
X-Gm-Message-State: AOAM533LL/+NCBSEoHjvRxgF71b5TNoWSled9mWa/5OT6s0iCF0x60Hc
 8BSujlplZvXsjdBmp2FRQltn8ImqCUedHEjVCBpBJl3AnEvtZH0OyaIl/xtMrJjRHYHtjxFTM5M
 VFW+RbuN02sAidPwRxgNJgil40o8upesGeTQxw0jKHw==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr9125889wmc.74.1615480960100; 
 Thu, 11 Mar 2021 08:42:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQzxGktgJgEENYc14fEDmcQqXqPEFE3sW2SOPsGR0u/IFDM4kuQ4raenTl/7wrfSpgSACISg==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr9125870wmc.74.1615480959923; 
 Thu, 11 Mar 2021 08:42:39 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id z25sm4897002wmi.23.2021.03.11.08.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 08:42:39 -0800 (PST)
Date: Thu, 11 Mar 2021 11:42:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/2] vhost-vdpa: fix issues around v->config_ctx handling
Message-ID: <20210311114217-mutt-send-email-mst@kernel.org>
References: <20210311135257.109460-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210311135257.109460-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Thu, Mar 11, 2021 at 02:52:55PM +0100, Stefano Garzarella wrote:
> While writing a test for a Rust library [1] to handle vhost-vdpa devices,
> I experienced the 'use-after-free' issue fixed in patch 1, then I
> discovered the potential issue when eventfd_ctx_fdget() fails fixed in
> patch 2.
> 
> Do you think it might be useful to write a vdpa test suite, perhaps using
> this Rust library [2] ?
> Could we put it in the kernel tree in tool/testing?

I can add tools/vdpa, no problem ...

> Thanks,
> Stefano
> 
> [1] https://github.com/stefano-garzarella/vhost/tree/vdpa
> [2] https://github.com/rust-vmm/vhost
> 
> Stefano Garzarella (2):
>   vhost-vdpa: fix use-after-free of v->config_ctx
>   vhost-vdpa: set v->config_ctx to NULL if eventfd_ctx_fdget() fails
> 
>  drivers/vhost/vdpa.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
