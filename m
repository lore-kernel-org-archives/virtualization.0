Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96B9C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 14:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 502EF813C7;
	Tue, 17 May 2022 14:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHZ2bJWMoo7S; Tue, 17 May 2022 14:06:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E23B08148B;
	Tue, 17 May 2022 14:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7F54C0032;
	Tue, 17 May 2022 14:06:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4FAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E383F8148B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tNk1qckMeYRh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:06:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84C74813C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652796412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ljxJQ3hykt5YXIRf2GpWi3TtdIkn+LLg0qCH6t6P8Rg=;
 b=AuHr9eXFnGAGqpDQe1R1avdggePKKaSYP4KxeszxOf5ZBwgB8F28Vid7IVPelQo15wmZm6
 87xD/BvDXsyRZTBQkiIf1Ah0AoY4ONtI6vzUcntcv1YM0yz72n/0T9bczgODcCHBRga4L0
 +W8wa//3BWXm17Lno4vwoNXAscMIbzU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-cC2lI_xCPgy8m-5HH3bhCQ-1; Tue, 17 May 2022 10:06:51 -0400
X-MC-Unique: cC2lI_xCPgy8m-5HH3bhCQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 q36-20020a0c9127000000b00461e3828064so527627qvq.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 07:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ljxJQ3hykt5YXIRf2GpWi3TtdIkn+LLg0qCH6t6P8Rg=;
 b=ZdxjfxQCitizx8lHcW/58TKCkxzwq2q0Y4yg0epS81+FZEJis7kOmxb5pn4p5C3ID4
 HsJwHSmACp3s3PEN3jN11RkmYA0bC+BYDRqctaA0A4YksaWTj2B6zvvpB4qdD3vvKxnF
 s3ZI2mRA3hTXcjH6uvlDAphira9lDjAgaTSwniSAoPBWXeCcuU5lySc53oH45OLJDHzl
 aH96h53T1pZsHSAbIRe7EzWYIThnYNMQNgbZ2m0YXt39O7+PnSRGpd8gvDZENbdWif02
 MZOLp9FnGeExpSBK5c79L6ma2KJBupmdfFK4KzK7AEO/Vo8CahPuMY+DpoDV36XSBOmu
 eULQ==
X-Gm-Message-State: AOAM530fBB7bgD//Ys+Y2U7ALGiKz95JDTVYBLYaGVXgbywqT/5nbeH+
 uAj9JswfPHGqDkLqNV6ksclN9MikhKap8lkkUal4aaLFJWQDhMQOuHAREAUi4aJawbimHLLuIi3
 ger/Cp/uvFio6znU3U7xjrCwGthvbCs6wmeTdYXnG+A==
X-Received: by 2002:ac8:5a52:0:b0:2f3:f407:4641 with SMTP id
 o18-20020ac85a52000000b002f3f4074641mr19728154qta.619.1652796410671; 
 Tue, 17 May 2022 07:06:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAWgkI5FsjwPULaS0j7K7iZOkiYpfnxcIbCf4dTz5rJN6kb3rKlKHMB56zD9g67mqYWW11fw==
X-Received: by 2002:ac8:5a52:0:b0:2f3:f407:4641 with SMTP id
 o18-20020ac85a52000000b002f3f4074641mr19728133qta.619.1652796410431; 
 Tue, 17 May 2022 07:06:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 b16-20020a05620a04f000b0069fd57d435fsm7378905qkh.101.2022.05.17.07.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 07:06:49 -0700 (PDT)
Date: Tue, 17 May 2022 16:06:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V2 3/8] vhost_net: get rid of vhost_net_flush_vq() and
 extra flush calls
Message-ID: <20220517140643.exctzzhaiouoouzs@sgarzare-redhat>
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-4-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220515202922.174066-4-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, arbn@yandex-team.com,
 stefanha@redhat.com, mst@redhat.com
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

On Sun, May 15, 2022 at 03:29:17PM -0500, Mike Christie wrote:
>From: Andrey Ryabinin <arbn@yandex-team.com>
>
>vhost_net_flush_vq() calls vhost_work_dev_flush() twice passing
>vhost_dev pointer obtained via 'n->poll[index].dev' and
>'n->vqs[index].vq.poll.dev'. This is actually the same pointer,
>initialized in vhost_net_open()/vhost_dev_init()/vhost_poll_init()
>
>Remove vhost_net_flush_vq() and call vhost_work_dev_flush() directly.
>Do the flushes only once instead of several flush calls in a row
>which seems rather useless.
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>[drop vhost_dev forward declaration in vhost.h]
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/net.c | 11 ++---------
> 1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
