Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C854C433EF
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 16:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8677813AB;
	Mon, 21 Feb 2022 16:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0W7YpUMGutT2; Mon, 21 Feb 2022 16:39:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9628281342;
	Mon, 21 Feb 2022 16:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E0C2C0021;
	Mon, 21 Feb 2022 16:39:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 287EBC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23369402A3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ArE8TBlAZsax
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:39:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 325EB401BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645461558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoyoRMJ/nAu1Wuy1hoTYHjBEoixwT5p2+nHN8seM7W0=;
 b=ioUPg4F6n/Kn2JYXxEcpss2iybZB8SV7BicR7QMmgJ216dhvyZqe2A64ybJIFljwIrM6LQ
 6We4gq8tTZH9bUaX0tD8UbUBWTprIGjbUXQvFVIk3dKX2rjaMUP8Azl+iZr78rKOzm/+PX
 i72oLkIU4rNwTzcYDbUx8IcN5B1yq8g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-9Ofdb4-YMRSHFLnQij-AsQ-1; Mon, 21 Feb 2022 11:39:17 -0500
X-MC-Unique: 9Ofdb4-YMRSHFLnQij-AsQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 l82-20020a37a255000000b0060dd39f5d87so13359752qke.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 08:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SoyoRMJ/nAu1Wuy1hoTYHjBEoixwT5p2+nHN8seM7W0=;
 b=fjfiMWXCcsVclCQyAdX3YvYqpTm40f+rW+F2MTp4ixq2xqCJN5jRrIUNUF+78DSbdM
 Wp/OSyoU5YQQ4Xe56e/kiYexy2Q1w4BAG1GmQU+oT4Wb4cTJb3Lt0WAMb47Ke/YD0Idg
 1JMidFYTW7uFX/iZP237Oa5ZE+iqo0wikZATJDTGhU5wthqwjSUZkBZzOAy1FCc1hy8B
 IH9fvPEKJeugmg5kIfd5CY1lb7pENrISJZgpj2mMXUjJJsDja5T49T1D7i6It/LN6lti
 A5e3opFvIK3gQWAy7Pmj9f7oCkUuu5R2LluHDC1wCtvUKA0ovU+qZel1v7Zlri6NjTra
 q8QQ==
X-Gm-Message-State: AOAM530GF05d30V3Ku6koz7bGE8jML/afLi2Ub68ptdoPv2D1PxpB5zI
 OqCX8C+e5aPDLQA5mc4OGr8qA3o9Ps8nqJylevXG8KnpzYHpPdWu5y6rgYnJAcns/x5oALzBph2
 Il44spQV7LdM7qAIjO+rOP9oTMVgTujGUuAYWDADqcQ==
X-Received: by 2002:a05:6214:19ed:b0:42c:289b:860e with SMTP id
 q13-20020a05621419ed00b0042c289b860emr15949411qvc.73.1645461557328; 
 Mon, 21 Feb 2022 08:39:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9nKNisYnQkAL2AwPf/8jKoIFZMeIDLW9aeCMNDkG4GM65TKhRDd3JisZSgS51F0AT0t1yNg==
X-Received: by 2002:a05:6214:19ed:b0:42c:289b:860e with SMTP id
 q13-20020a05621419ed00b0042c289b860emr15949399qvc.73.1645461557115; 
 Mon, 21 Feb 2022 08:39:17 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id s5sm7471966qtn.35.2022.02.21.08.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 08:39:16 -0800 (PST)
Date: Mon, 21 Feb 2022 17:39:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anirudh Rayabharam <mail@anirudhrb.com>
Subject: Re: [syzbot] INFO: task hung in vhost_work_dev_flush
Message-ID: <20220221163909.xfrgt6slp3ksqr2w@sgarzare-redhat>
References: <00000000000057702a05d8532b18@google.com>
 <CAGxU2F4nGWxG0wymrDZzd8Hwhm2=8syuEB3fLMd+t7bbN7qWrQ@mail.gmail.com>
 <YhO1YL0A6OjtXmIy@anirudhrb.com>
MIME-Version: 1.0
In-Reply-To: <YhO1YL0A6OjtXmIy@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 syzbot <syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com>
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

On Mon, Feb 21, 2022 at 09:23:04PM +0530, Anirudh Rayabharam wrote:
>On Mon, Feb 21, 2022 at 03:12:33PM +0100, Stefano Garzarella wrote:
>> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>> f71077a4d84b
>>
>> Patch sent upstream:
>> https://lore.kernel.org/virtualization/20220221114916.107045-1-sgarzare@redhat.com/T/#u
>
>I don't see how your patch fixes this issue. It looks unrelated. It is
>surprising that syzbot is happy with it.
>
>I have sent a patch for this issue here:
>https://lore.kernel.org/lkml/20220221072852.31820-1-mail@anirudhrb.com/

It is related because the worker thread is accessing the iotlb that is 
going to be freed, so it could be corrupted/invalid.

Your patch seems right, but simply prevents iotlb from being set for the 
the specific test case, so it remains NULL and iotlb_access_ok() exits 
immediately.

Anyway, currently if nregions is 0 vhost_set_memory() sets an iotlb with 
no regions (the for loop is not executed), so I'm not sure 
iotlb_access_ok() cycles infinitely.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
