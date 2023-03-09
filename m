Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AABBC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 09:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9918881FC2;
	Thu,  9 Mar 2023 09:09:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9918881FC2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OAZemMJm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D_D2LLbeynjZ; Thu,  9 Mar 2023 09:09:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39AEA81FAA;
	Thu,  9 Mar 2023 09:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39AEA81FAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15348C0035;
	Thu,  9 Mar 2023 09:09:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD9ACC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A913740363
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A913740363
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OAZemMJm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Sfgd5IChwWn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:09:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4EFB40360
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4EFB40360
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678352969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8yCelNSr6rYm3fdnqKstdG6udl5yNcoRzMcScSgtxcE=;
 b=OAZemMJmynxvvSLf+Yvk6x4EgOiM6wPP/IZcnby3e6HB6nJKGyn/V0Uh3Fi2QWirvRwT/4
 PccqmVsjar4zoNidAdM4A00j2RZNEYY0fJSQ0EaNY8GKVknLrirt3RFUwALupU5GoQOGtd
 LcaKCmbaZhvoTz7XUr/1jeL6/ywjolE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209--QPVqPZKMuyWE_B3OTD7zw-1; Thu, 09 Mar 2023 04:09:28 -0500
X-MC-Unique: -QPVqPZKMuyWE_B3OTD7zw-1
Received: by mail-qt1-f197.google.com with SMTP id
 x4-20020ac85384000000b003bfbb485e2dso731365qtp.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 01:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678352967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8yCelNSr6rYm3fdnqKstdG6udl5yNcoRzMcScSgtxcE=;
 b=O7wqhdO7hgXjZqonzJhHXOuy0npC+iKrKwqpYWpKIXqcRqz/D+aCnFNM4w03iqj/7W
 PBARySg7GL21nae1LVq7LBn416pSHk1muaQssoBzvpi65tl7ibu0QauwqNuHb0e1YuRK
 kut5dJ7mHNRQCpQhOKiL+KLtgWBBBQiSktX//tVf/1gQJ49qFYVdymxYmO3JiERj6uQg
 +cd1eFCEwhsOWhtdapvA+cLnuurMppUb5sdssUOpgUxc/ZKGsKwcr/cQEyjEOchFUGeC
 Ajnc+Gp2+DZwFM12WFmLVKfNaszPxaLqTn3x1z8J2Vus4JZZqIh5+us9iErFfeXs5wcL
 wwBQ==
X-Gm-Message-State: AO0yUKWNiyL2O7hKhW5IBq8VVyaLPiyKcUbnSpbXgRh3rEUI6vofwZ3y
 Qo+g3CwZdgPypI1beDGskgCXu/xqnLEMQGhoWArGaaTpASMD+I6RQ68AkrmFSw1Z+YTfI7w/qTt
 s87VZISuA/0oh9dbWTsK40draJTjEqC4Nw52NcvrXYA==
X-Received: by 2002:ac8:5814:0:b0:3b8:6a92:c8d6 with SMTP id
 g20-20020ac85814000000b003b86a92c8d6mr36025122qtg.60.1678352967333; 
 Thu, 09 Mar 2023 01:09:27 -0800 (PST)
X-Google-Smtp-Source: AK7set8EXeeyXyOTcJY3FuYwwfRSxMsmppbkCjawIYdYGgFETMM+mfT4kboxe+Ntrnrw0IwlKRWzFg==
X-Received: by 2002:ac8:5814:0:b0:3b8:6a92:c8d6 with SMTP id
 g20-20020ac85814000000b003b86a92c8d6mr36025101qtg.60.1678352967091; 
 Thu, 09 Mar 2023 01:09:27 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 h13-20020ac8514d000000b003bfc335f124sm13095041qtn.79.2023.03.09.01.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 01:09:26 -0800 (PST)
Date: Thu, 9 Mar 2023 10:09:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH v2] tools/virtio: virtio_test -h,--help should return
 directly
Message-ID: <20230309090923.dq72s6ovjo5lsyxq@sgarzare-redhat>
References: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Mar 09, 2023 at 04:42:50PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. Move the exit() directly into the help() function and
>remove it from case '?'.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
>v2: help(): exit with a value different from 0 (e.g. 2).
>v1: https://lore.kernel.org/lkml/tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com/
>---
> tools/virtio/virtio_test.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
