Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB915C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 08:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25FC741CB8;
	Thu, 23 Mar 2023 08:35:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25FC741CB8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R2H3ksIE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id duXuV2FtSOWM; Thu, 23 Mar 2023 08:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 827D741CB3;
	Thu, 23 Mar 2023 08:35:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 827D741CB3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B04DC0035;
	Thu, 23 Mar 2023 08:35:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 599E6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 08:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B0D941DB8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 08:35:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B0D941DB8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R2H3ksIE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GBlIkfkHHWKh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 08:35:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 363DD41B9B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 363DD41B9B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679560535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2h2VoBtpKVUit8eaQH7nfWe6R/baAp4jt1GjEBXDY0=;
 b=R2H3ksIEiRbc2/07aCrRAJDR4KkJPpLpCazz0pDchHF8QEMDRchnugiqvnw3hi47V//t85
 fBPzu4WUQpZLc5XqYAINS35TCO3nxXTEsktVDyrqdqc9BKjasCSYrfwgijrmo1ZDrfhNoC
 1ao39RCnGdtXbgbfeOMZuJKhhic1xkw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-t5kCwdknN7W9q3Mfy8JJEg-1; Thu, 23 Mar 2023 04:35:34 -0400
X-MC-Unique: t5kCwdknN7W9q3Mfy8JJEg-1
Received: by mail-ed1-f71.google.com with SMTP id
 t26-20020a50d71a000000b005003c5087caso29524804edi.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679560533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2h2VoBtpKVUit8eaQH7nfWe6R/baAp4jt1GjEBXDY0=;
 b=IQx1CXJFouVOsCUTFoMtVcbiffnnCMyX/ex/0TnmNaxffmse64egfJxHxZyGd57rlP
 wyJB0pis/IT7xYjUrEG+iytVDKCcLn80Isi9jBDA5KMdCovOY33lC+a4opJ6iwKABY5e
 TUH2FB21rFxLeQ/BVz6fhp4B5crsZftr84mUHeSQNYQ/m6oAA5BYrnIe5DxJky340yux
 513akobqTTW8fNGrrOc4LcfgEWHfDadKkaE+2lhgXqYeZh/HvWJ7B6tAi/b4Pk80zo/C
 fiFwaH0EfnDQvOltLKbdcezrU4I5P5uS8tlGQDMiQd6+SW6yx3FupocxHHVytCaLzqn4
 cKKQ==
X-Gm-Message-State: AO0yUKXAfNIVWnsSIZun3spLXbRlM4TesbVo6x3gLQYFqHr0KTSD6a9f
 ZD/NJJKlWmKhvrNomCy2sajACJDPaYksSQW5Ooqdla62R9+qH09HhZWEkOXHF3Oe5zemy0n3Icw
 yrcA0UnSI6GsvBhCoSfEeQ7RQiu0W8iZ73cfh55bWSg==
X-Received: by 2002:a17:907:8a1a:b0:920:7827:302 with SMTP id
 sc26-20020a1709078a1a00b0092078270302mr5999935ejc.18.1679560533395; 
 Thu, 23 Mar 2023 01:35:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set/p1OILgt7zsTiuJiRZ7Ij2OcC72M1xyP4ZUGnat8eDmsjI/i5k0yeLe/IK3B+iTBt07ZITsg==
X-Received: by 2002:a17:907:8a1a:b0:920:7827:302 with SMTP id
 sc26-20020a1709078a1a00b0092078270302mr5999917ejc.18.1679560533151; 
 Thu, 23 Mar 2023 01:35:33 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 jj19-20020a170907985300b008c327bef167sm8324109ejc.7.2023.03.23.01.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 01:35:32 -0700 (PDT)
Date: Thu, 23 Mar 2023 09:35:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323083530.6clofhwkixfkmvgw@sgarzare-redhat>
References: <20230322185605.1307-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230322185605.1307-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, mst@redhat.com,
 syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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

On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
>vhost_task_create is supposed to return the vhost_task or NULL on
>failure. This fixes it to return the correct value when the allocation
>of the struct fails.
>
>Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
>Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> kernel/vhost_task.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
>index 4b8aff160640..b7cbd66f889e 100644
>--- a/kernel/vhost_task.c
>+++ b/kernel/vhost_task.c
>@@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>
> 	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
> 	if (!vtsk)
>-		return ERR_PTR(-ENOMEM);
>+		return NULL;
> 	init_completion(&vtsk->exited);
> 	vtsk->data = arg;
> 	vtsk->fn = fn;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
