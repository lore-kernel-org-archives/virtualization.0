Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A7C433E0
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:57:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFA920771
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFA920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0581D864CF;
	Tue, 19 Jan 2021 09:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a93oJI31u2sR; Tue, 19 Jan 2021 09:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74707863FD;
	Tue, 19 Jan 2021 09:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53250C088B;
	Tue, 19 Jan 2021 09:57:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6A6FC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 923D185F9B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ZO6c8FR9yVP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3913885F8E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611050226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNRyaZttxpEG7FVOt6WsLq1WRbO39WhYVs3QVq8r02I=;
 b=YXQOAT1Wnl5jp60sqzAdwr/GQYjfFIewzeuTOgzftiz8VTOT8+ap5c0mpmFFSSYfKYQUX7
 h6AmmDXrrRgVkthEBMFQPUvkSWd+2Gr+XaOcoGeWp6nEaElj7lGwb0hEXOJeH1Uz1NilZf
 Ul/9CDPazlz0y0sr6TXjbnA8GgelORk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-vkUFmZXiM9ibuL63y_doGw-1; Tue, 19 Jan 2021 04:57:04 -0500
X-MC-Unique: vkUFmZXiM9ibuL63y_doGw-1
Received: by mail-wr1-f70.google.com with SMTP id l10so9247409wry.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 01:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bNRyaZttxpEG7FVOt6WsLq1WRbO39WhYVs3QVq8r02I=;
 b=jjY8KPUuGOVDqTBfySdvFgczNtbpM3FkS2jdWFXPpFbOABouvIRHPw88a9XMCcLNJT
 ln9KGn9c38ukpXx7k8UvcGxMrattR+wtoUf/4xZbdoxRmP6iuMywkytyBGjPza+rsx+1
 PmCSswJZQMaE9rfExkzOPtctZiPey+FY8BrR2Fr7MOFj5vl7pmjWkDwfW9SDRtyKjsUu
 Xl898cMi4/Ud9AKYg8hYmlEbUbhFpWMWSHj6y59FJKwlH5mgG2dB/ZCZTnN/tr6C1MTH
 6aErPc4zKWbGADb260mn86mKzl2XIiF5bocdqAZ7xU9utpc/RYWP8accDCxFOySIeqwZ
 FLOw==
X-Gm-Message-State: AOAM530CWC80Dod/YpeTI+yEJIHZHDRzUhJcFkYkFE966+GgyEl9UwH8
 5qMfQcdlRc0XP7IdStvtUhiuUWJfIOjefO/fmAndeIRadCXWOgzs6eUQBB2FlK+zLE78J2HwmaR
 ZJSjVwqZAKmJqpwUhP41OkW/dCptrGVTJ8D0QPUF8lQ==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr3227476wme.101.1611050223183; 
 Tue, 19 Jan 2021 01:57:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzljllNLi4pZd/bZsm2jwBEfi1V9esgxcyPjjC987+7SFdyACV8fewUuKTnkYXx3B7S3wBZVw==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr3227459wme.101.1611050223061; 
 Tue, 19 Jan 2021 01:57:03 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id q7sm2918408wrx.18.2021.01.19.01.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 01:57:02 -0800 (PST)
Date: Tue, 19 Jan 2021 04:56:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v7] vhost_net: avoid tx queue stuck when sendmsg
 fails
Message-ID: <20210119045607-mutt-send-email-mst@kernel.org>
References: <1610685980-38608-1-git-send-email-wangyunjian@huawei.com>
 <20210118143329.08cc14a6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20210118143329.08cc14a6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 wangyunjian <wangyunjian@huawei.com>, jerry.lilijun@huawei.com,
 virtualization@lists.linux-foundation.org, xudingke@huawei.com,
 brian.huangbin@huawei.com, chenchanghu@huawei.com
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

On Mon, Jan 18, 2021 at 02:33:29PM -0800, Jakub Kicinski wrote:
> On Fri, 15 Jan 2021 12:46:20 +0800 wangyunjian wrote:
> > From: Yunjian Wang <wangyunjian@huawei.com>
> > 
> > Currently the driver doesn't drop a packet which can't be sent by tun
> > (e.g bad packet). In this case, the driver will always process the
> > same packet lead to the tx queue stuck.
> > 
> > To fix this issue:
> > 1. in the case of persistent failure (e.g bad packet), the driver
> >    can skip this descriptor by ignoring the error.
> > 2. in the case of transient failure (e.g -ENOBUFS, -EAGAIN and -ENOMEM),
> >    the driver schedules the worker to try again.
> > 
> > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> 
> Michael, LMK if you want to have a closer look otherwise I'll apply
> tomorrow.

Thanks for the reminder. Acked.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
