Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89866C433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 21:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05EBD4011D;
	Thu,  3 Mar 2022 21:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cn_CEihMNbXa; Thu,  3 Mar 2022 21:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E5A740127;
	Thu,  3 Mar 2022 21:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32A5AC001D;
	Thu,  3 Mar 2022 21:01:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46D03C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 21:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2203340127
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 21:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bj5XPPCArqVS
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 21:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE3354011D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646341274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8b61j3jDxeMLMcRITP39wLh0mrGAS4obX7IDIQWgUAI=;
 b=YNnh1OhdM1oUSjBFEm/v4BTuq2F6Ygfg1rbQVNPuSeShj115l2nQG3XwN6A4EgBf4vnJ0D
 s9SAqvNnM0cCL7ak8pt95pzyfu2Pyc3SLhIz+TYCdJFhQX5KFtGvlIQXSL6ixGiXckuWXy
 abu7lNGbt4gBPN0rsqCgRlfcAZQst+0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-Vo3P18UnNVGuAC3PmGVCGw-1; Thu, 03 Mar 2022 16:01:13 -0500
X-MC-Unique: Vo3P18UnNVGuAC3PmGVCGw-1
Received: by mail-wm1-f72.google.com with SMTP id
 f13-20020a05600c154d00b003818123caf9so1907212wmg.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 13:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8b61j3jDxeMLMcRITP39wLh0mrGAS4obX7IDIQWgUAI=;
 b=w94zKE42USK7+0E8kv4fVIwJWPcU7G6KXSbZLBkAvf+MY4h6Xb6iYJ9vs/Zn5bbBYq
 475QVtoO0KSkhzcQwXYpzyr84ZZmSZEg5JBcnsb3pFXBIB7/WE2AWRkatXUb15rPtmCz
 zmUUAVsIzL7yqE2RNyK5dmVmCrNF983m9nGXa7Ub5V0NgBxdfH67EOOy5hNXhXVDXjpm
 XC9cGAAh1zFOss6oiGNejEH+PTgNdUGhNxRt/pFkPQrPp1q8Q2KldjH7k9EULtbqmJ1B
 YTG9W4vBaNXCvYZkg/okDhKa3PAUTxyoKFGcIUgn+RL18vkn4jheqwzIURNCj5BPuhV8
 Ws2A==
X-Gm-Message-State: AOAM533hWdvzhF3b4DWk7m/tQNezJB8SuBO9SG4NW4KXnd2cD05Danx6
 woKgWsvvcrIvo9Rdfu8bGHy6LL+8TEG8SCgUvtB5PWjV5K/KuS7WyVT56/ZnNnF2aaAnOoO2iGT
 m5Z8N4G3JtYPV6/h6LQqgqvA7CQj1/FcXDvmtLJT7PQ==
X-Received: by 2002:a05:600c:4f8f:b0:383:d0b:3706 with SMTP id
 n15-20020a05600c4f8f00b003830d0b3706mr5231470wmq.117.1646341271847; 
 Thu, 03 Mar 2022 13:01:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKK9jWjBGTEf4CQ2VVlOjCLLsVb5H0JIMs+Muv46FA+kUpNhvpttoraxVDN8+XxYn68U3LdA==
X-Received: by 2002:a05:600c:4f8f:b0:383:d0b:3706 with SMTP id
 n15-20020a05600c4f8f00b003830d0b3706mr5231451wmq.117.1646341271510; 
 Thu, 03 Mar 2022 13:01:11 -0800 (PST)
Received: from redhat.com ([2.55.143.133]) by smtp.gmail.com with ESMTPSA id
 t14-20020a5d460e000000b001edc107e4f7sm4365551wrq.81.2022.03.03.13.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 13:01:10 -0800 (PST)
Date: Thu, 3 Mar 2022 16:01:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <20220303155645-mutt-send-email-mst@kernel.org>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
 <YiETnIcfZCLb63oB@unreal>
MIME-Version: 1.0
In-Reply-To: <YiETnIcfZCLb63oB@unreal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>
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

On Thu, Mar 03, 2022 at 09:14:36PM +0200, Leon Romanovsky wrote:
> On Thu, Mar 03, 2022 at 03:19:29PM +0000, Lee Jones wrote:
> > All workers/users should be halted before any clean-up should take place.
> > 
> > Suggested-by:  Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/vhost/vhost.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index bbaff6a5e21b8..d935d2506963f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -693,6 +693,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> >  	int i;
> >  
> >  	for (i = 0; i < dev->nvqs; ++i) {
> > +		/* Ideally all workers should be stopped prior to clean-up */
> > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > +
> >  		mutex_lock(&dev->vqs[i]->mutex);
> 
> I know nothing about vhost, but this construction and patch looks
> strange to me.
> 
> If all workers were stopped, you won't need mutex_lock(). The mutex_lock
> here suggests to me that workers can still run here.
> 
> Thanks


"Ideally" here is misleading, we need a bigger detailed comment
along the lines of:

/* 
 * By design, no workers can run here. But if there's a bug and the
 * driver did not flush all work properly then they might, and we
 * encountered such bugs in the past.  With no proper flush guest won't
 * work correctly but avoiding host memory corruption in this case
 * sounds like a good idea.
 */

> >  		if (dev->vqs[i]->error_ctx)
> >  			eventfd_ctx_put(dev->vqs[i]->error_ctx);
> > -- 
> > 2.35.1.574.g5d30c73bfb-goog
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
