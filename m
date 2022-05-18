Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF5EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 07:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9F4060BB1;
	Wed, 18 May 2022 07:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 76yL6AmsTdYv; Wed, 18 May 2022 07:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 59C3A60A8B;
	Wed, 18 May 2022 07:28:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C9D9C0032;
	Wed, 18 May 2022 07:28:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 758A5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 07:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B40B40B55
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 07:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-CIMtPH7VTH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 07:28:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9A8D40223
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652858887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UU3nsC4wCVlgBltc8JVt9fGu2yt9pg3kiIuP7maAvp4=;
 b=hJRs9bU1M9hZhkixoQUMF50rJHcPCF69StpYoe1DuBED/W5CtisMAukjw50YURfwYzR4MA
 Yj4IS9o9uuWU2PyvhfRJNAZvSVvg0pP4XM+ftNlCmPEBkrlR5NS0R9ugfFS0s1sKd8ldIm
 3YuQDhFJebT1PQXmDrzQihTELmM0CLo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-7nHySzSYPx-MvmdmajJh9g-1; Wed, 18 May 2022 03:28:05 -0400
X-MC-Unique: 7nHySzSYPx-MvmdmajJh9g-1
Received: by mail-wr1-f71.google.com with SMTP id
 u11-20020a056000038b00b0020c9ea8b64fso283970wrf.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 00:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UU3nsC4wCVlgBltc8JVt9fGu2yt9pg3kiIuP7maAvp4=;
 b=UPp+YitFGQ8zBJWOuaR+RgHzIH9H5LjeUM4YS2x3XFzw/W+Y9l3GOB63hPOOieo3+S
 IpefniBNH71OBmLE4m0xgFbLc+xPXe737qN7yEUQ5yghXumgr/jxGPnReshhxKP8thN/
 Oh5dDJ/bJPNeLsiF8OkQbYEf4TrM6oaziJkeZ1U4GJ6GpKy2tsm2F0QmDcacE99GM+K4
 7Rpb20Hxu5WUK+SNQOPOI2mNQTYJ2gkcI9j7rNpchtVkKQkF9U8VlJQonHqiJscyh5s5
 0Z+OCT9oZdiED32iglgk453psnBwsPP1hMheAGhqUJm3NQfSYImDVRgOq/YGpu5GP6Na
 LDwA==
X-Gm-Message-State: AOAM53377M6fZ+853C2kO5fphs8yNrzKhyGp0sH5gk2vEpzwKJunrvWO
 W9gdzdE2OZrRWodYXe8ayn2vtuw5OOVF4WZ5onPT1aKI7+tC+fVYbwtZvx6MyRkfvCW4w8XUzC5
 +BinL1mHtEL7wK19TVlYuKnl4xwVhGOorZE30HKdFvQ==
X-Received: by 2002:adf:ebc6:0:b0:20d:e8e:4df5 with SMTP id
 v6-20020adfebc6000000b0020d0e8e4df5mr5439174wrn.117.1652858884642; 
 Wed, 18 May 2022 00:28:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9o0kLRyXQV5w6k9x5R6EPY0mzyDPBE+yTMNQPL9uuIr9b4/rhLWXtpIYcNvb3hMAQvEksAA==
X-Received: by 2002:adf:ebc6:0:b0:20d:e8e:4df5 with SMTP id
 v6-20020adfebc6000000b0020d0e8e4df5mr5439161wrn.117.1652858884421; 
 Wed, 18 May 2022 00:28:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 r2-20020adfa142000000b0020d0c37b350sm1365272wrr.27.2022.05.18.00.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 00:28:03 -0700 (PDT)
Date: Wed, 18 May 2022 09:27:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V3 4/8] vhost_test: remove vhost_test_flush_vq()
Message-ID: <20220518072757.es24wxh6tiacdoaw@sgarzare-redhat>
References: <20220517180850.198915-1-michael.christie@oracle.com>
 <20220517180850.198915-5-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220517180850.198915-5-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, arbn@yandex-team.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Tue, May 17, 2022 at 01:08:46PM -0500, Mike Christie wrote:
>From: Andrey Ryabinin <arbn@yandex-team.com>
>
>vhost_test_flush_vq() just a simple wrapper around vhost_work_dev_flush()
>which seems have no value. It's just easier to call vhost_work_dev_flush()
>directly. Besides there is no point in obtaining vhost_dev pointer
>via 'n->vqs[index].poll.dev' while we can just use &n->dev.
>It's the same pointers, see vhost_test_open()/vhost_dev_init().
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vhost/test.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
