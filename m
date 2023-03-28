Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91145C76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 07:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E22B94188C;
	Tue, 28 Mar 2023 07:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E22B94188C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZKxLQ0U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4pzu234Q7Z81; Tue, 28 Mar 2023 07:50:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B63C41878;
	Tue, 28 Mar 2023 07:50:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B63C41878
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 068F6C0037;
	Tue, 28 Mar 2023 07:50:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B433EC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 838AF41028
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:50:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 838AF41028
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZKxLQ0U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zlpz3CRhUQob
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:49:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 605A640CA4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 605A640CA4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679989798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8slMBXaX5tKJuNxDkb5aHuL3vFrJ6coZs8pJFAMGiK0=;
 b=CZKxLQ0UOQ+zd6oVcTJaHksbyvmgXVug3foS2+060CdLXjlYiIIQFTibcI/s89gDmsJyXj
 SLfOw46tzHFJnL6CTMq43larOmxWDleUp9ruhexQYKYRTePi/asBU01pe+YjvrJYaQlm8w
 r3ZOoxeHb2qE4ax7FRr8vLXnmlFle7A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-CvUdqsQJOIWUFMiNkzhg7g-1; Tue, 28 Mar 2023 03:49:16 -0400
X-MC-Unique: CvUdqsQJOIWUFMiNkzhg7g-1
Received: by mail-qt1-f197.google.com with SMTP id
 h6-20020a05622a170600b003e22c6de617so7646832qtk.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 00:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679989756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8slMBXaX5tKJuNxDkb5aHuL3vFrJ6coZs8pJFAMGiK0=;
 b=DanGKyR8opmlG4OKpAJAGhKUEaE6aDyonXs0wI8bszKG4HWbGN4RiiQThisP5SuXxD
 g6ayQznhuqWfnvTbvl1bjHbgUIrI65WdKXdUojfQaQZRIMbYYj3MkofJBvw1/U33EzmH
 uJV2KKcaE+bxeiBD5LGKeDhVKzgcuZMo0j2zMAy1MuQtBritSVLys/KDXpJIA7KRQfYF
 x7ZTOHkj2AAF6aOw8A53RveVDTJ2wlnxsw1ve7cs4spHmcZ97W4QwBNLC0ZzmL9aUwld
 nx66BTevCuSXhxcz2HjigQJFJH8UyWH/tvT8X6WZl5k1AsNM1Wp54FbwiVez6eNzmuOt
 hATg==
X-Gm-Message-State: AAQBX9dqyquEvt420NKC+8/3HQSy+G3XDFzzMFjxKn40Gk+bgn7gKpws
 m2vL4ZhNkj/K0Mi5pr4lQzJkFQLoLNoopDIFtACVr57dD9B0HMJUiql9Wn+U7bp7uQXT78Clbhz
 ZlJqMq5L77mHXm6OstM8+S1N6frMwOJS1aoQWjCG+tA==
X-Received: by 2002:a05:622a:2c1:b0:3e4:e8be:c3a4 with SMTP id
 a1-20020a05622a02c100b003e4e8bec3a4mr11464852qtx.56.1679989756322; 
 Tue, 28 Mar 2023 00:49:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350ail0lTX7WFSmqdfltJySh8ck2FEvfITqls1VGpUAH8boD39DgywjVABQBk7ihF++gBl2ur+A==
X-Received: by 2002:a05:622a:2c1:b0:3e4:e8be:c3a4 with SMTP id
 a1-20020a05622a02c100b003e4e8bec3a4mr11464840qtx.56.1679989756097; 
 Tue, 28 Mar 2023 00:49:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 x6-20020ac86b46000000b003e4e7e89828sm1491267qts.20.2023.03.28.00.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 00:49:15 -0700 (PDT)
Date: Tue, 28 Mar 2023 09:49:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next] testing/vsock: add vsock_perf to gitignore
Message-ID: <w5lm46kj3wfxzscga6333b6bw26lgzqmlkb675px6ya23ysym4@mqt33kghsp7z>
References: <20230327-vsock-add-vsock-perf-to-ignore-v1-1-f28a84f3606b@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230327-vsock-add-vsock-perf-to-ignore-v1-1-f28a84f3606b@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Mar 27, 2023 at 10:16:06PM +0000, Bobby Eshleman wrote:
>This adds the vsock_perf binary to the gitignore file.
>
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> tools/testing/vsock/.gitignore | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/.gitignore b/tools/testing/vsock/.gitignore
>index 87ca2731cff9..a8adcfdc292b 100644
>--- a/tools/testing/vsock/.gitignore
>+++ b/tools/testing/vsock/.gitignore
>@@ -2,3 +2,4 @@
> *.d
> vsock_test
> vsock_diag_test
>+vsock_perf
>
>---
>base-commit: e5b42483ccce50d5b957f474fd332afd4ef0c27b
>change-id: 20230327-vsock-add-vsock-perf-to-ignore-82b46b1f3f6f
>
>Best regards,
>-- 
>Bobby Eshleman <bobby.eshleman@bytedance.com>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
