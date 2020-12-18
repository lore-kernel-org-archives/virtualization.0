Return-Path: <SRS0=st/B=FW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D4C4361B
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 07:57:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E04423A1E
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 07:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E04423A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10DDB879D7;
	Fri, 18 Dec 2020 07:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FTdcc4CTh3Gy; Fri, 18 Dec 2020 07:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 24BAC86F92;
	Fri, 18 Dec 2020 07:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD3EC1786;
	Fri, 18 Dec 2020 07:57:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 432CBC0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 07:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 329F786F92
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 07:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NUUUnjxmppb3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 07:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 05D9D8707F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 07:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608278225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3uqE9M30CbyZz7Al0ttuF7vbymURHAmKiPU9njynek=;
 b=XGjnKEsBRTw7FYgpvoM1ERZZB2XEKRnLotOZ/S1dAH6bHHtHxGqtY2XLVbY6R01zhy8ZtM
 rfK+kSAwfTTxCq1f7ScqWyQqJJoomi8HINNXguSyzoEe1vQJUjrdW0i8KjYWKCBcNzWFaH
 DyLhOapSYtbQXIA6RhG4aI0S0L97X4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-DXzDNakUO3ysMOMKd5400Q-1; Fri, 18 Dec 2020 02:57:03 -0500
X-MC-Unique: DXzDNakUO3ysMOMKd5400Q-1
Received: by mail-wm1-f70.google.com with SMTP id s130so439703wme.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 23:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e3uqE9M30CbyZz7Al0ttuF7vbymURHAmKiPU9njynek=;
 b=kr+NGReLg6D2dlDKU909o4zD5uFMInEjafb9lfu9o0HThdgTcw6ItTItw4SOgiQ6UO
 vgPrPH4sowmjmfniPOL2dGXODfB2QONcdRyKAlZnLN6xF6DDQje9suUnMXgk/4e1Jywc
 i5IDOubfopBYcApgfaSuVaCMuPrfBFRGLeo5ljUfm4slqH05YbsiGBhtJQrgu5rJYMlp
 3eC4AULbv1Z/jGmbxPHlAjEh+dMwbnp5enWE/u2GUl1WdLs2bvkVMBDzlUXuKc3mkK/1
 drA6TzqGsxF/SFo6GCnouwyAES2eiw0qBf+WnH9G34/1SOi2ohmdFV0RO3+9X75d/7UE
 LX0w==
X-Gm-Message-State: AOAM532C5GpaK15yhvhVg/hbNvpljosJRUG3PGWIwfJjKpeZiXlLIKSv
 3plwimMynuil3ii0aKH/ou5ljtv4JaIHkUhpT7JTZLBecxLa06wkHuSV3TaQLkKLiWwUdb6nnTG
 lhVO095OOFVhIKQf/yTS9vHMXjcmYhq2IbnfOMkHeFA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2979125wml.155.1608278222394; 
 Thu, 17 Dec 2020 23:57:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyz7342iA1Eqkl5G56cSsoK9yPrUy+f4KaNGvgeqTyJrNoyAJ8oxkVW15SUsDhqyoYqS0l4Cg==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2979112wml.155.1608278222237; 
 Thu, 17 Dec 2020 23:57:02 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it.
 [79.13.204.15])
 by smtp.gmail.com with ESMTPSA id r20sm13239858wrg.66.2020.12.17.23.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Dec 2020 23:57:01 -0800 (PST)
Date: Fri, 18 Dec 2020 08:56:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zou Wei <zou_wei@huawei.com>
Subject: Re: [PATCH -next] vdpa: Mark macaddr_buf with static keyword
Message-ID: <20201218075659.zjts2fiwp2jkh2ei@steredhat>
References: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 18, 2020 at 09:51:35AM +0800, Zou Wei wrote:
>Fix the following sparse warning:
>
>drivers/vdpa/vdpa_sim/vdpa_sim_net.c:36:4: warning: symbol 'macaddr_buf' was not declared. Should it be static?
>
>Reported-by: Hulk Robot <hulkci@huawei.com>
>Signed-off-by: Zou Wei <zou_wei@huawei.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I built with W=1 but I didn't have this warning.

Thanks for fixing,
Stefano

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index c10b698..f048242 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -33,7 +33,7 @@ static char *macaddr;
> module_param(macaddr, charp, 0);
> MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>
>-u8 macaddr_buf[ETH_ALEN];
>+static u8 macaddr_buf[ETH_ALEN];
>
> static struct vdpasim *vdpasim_net_dev;
>
>-- 
>2.6.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
