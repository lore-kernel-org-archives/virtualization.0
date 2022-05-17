Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31CAC433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 14:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A27CE60E13;
	Tue, 17 May 2022 14:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cHffpjurJa22; Tue, 17 May 2022 14:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FC9460E3C;
	Tue, 17 May 2022 14:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20562C0039;
	Tue, 17 May 2022 14:19:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14B40C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E97DB84019
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P6R4yaxPCOnu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:19:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5561884018
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652797145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngT7mHEibRvvPyWPaDz0kqUAkveW1ht+5G7xDSipDI8=;
 b=Mj0xhWGnnuv3rubkn3jTHg5H6z8CinAmGG30UrtypakMi2CPsqF5D4BYBfPIqpmxzMXHXK
 XpXzFeu9WrzqfQCuOHm9BgCCjy3eCvaXITDfsMbNjH0Gkf7dltKbCWELJXkZzKleWk4WIT
 EsDBe0fw+ENDvD/evVZiVOn40T7B3YQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-t3u-LCXQNwONv-QdvlEu6w-1; Tue, 17 May 2022 10:19:04 -0400
X-MC-Unique: t3u-LCXQNwONv-QdvlEu6w-1
Received: by mail-wr1-f72.google.com with SMTP id
 p10-20020adfaa0a000000b0020c4829af5fso4725343wrd.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 07:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ngT7mHEibRvvPyWPaDz0kqUAkveW1ht+5G7xDSipDI8=;
 b=lYFEppVqFlMFuqMpu5OSbhMiLF3l/fcFeaYwN/mtzpRqS4lo3Vzt8S/MCtU+eTcrzd
 ckm6WQrFUiVo0hvQ3L1lM4UgQ/DQGXafWtmeX1GgSdxVZmdJnbvdNAZL+CTeevEOR/nr
 pcNOzLJrBQKUazUQbMz9u4YI32LSYRU9uFR1B9QA19pXnXAmjqxbpmzWTJpIAlOMfoUA
 OEtlTr6xY1gduK5rfwmUIAV3QTO5WgC2na5XDpDlJQCobpzXyH621t76uCDaEh92zH2k
 uK+iXkMwbVUhIB8vy0cTMe+vhnZmdgeRvBVOF7LhR7Z+U/7aqSRx0qoTVvx7Z2ba1UJl
 EGUg==
X-Gm-Message-State: AOAM530DlVbMUBIlGlfWWfOqt5CuW0ZPmofhUxq48vbwgu93YMO4GZdx
 tN6t8dwsnhiuSObgOi5H84diebT/SM3kHzAGSTt4WVjTXmFWmDqR/D5cMuKLv3NxL8NhVY6yaQf
 mVb5SsIUZqEQspQHp3V/FVP1Uh5qAv7XPMv/ouFE3Zw==
X-Received: by 2002:a7b:c202:0:b0:394:1e7d:af44 with SMTP id
 x2-20020a7bc202000000b003941e7daf44mr21656875wmi.139.1652797143319; 
 Tue, 17 May 2022 07:19:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkZsZYN3bEiNhtHDMdW2H3MZGKAEcphGXVi5pqPGRsUEbA3e4DnlNJ5BNWJOg7TeeUUJulNQ==
X-Received: by 2002:a7b:c202:0:b0:394:1e7d:af44 with SMTP id
 x2-20020a7bc202000000b003941e7daf44mr21656858wmi.139.1652797143129; 
 Tue, 17 May 2022 07:19:03 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 e9-20020adfc849000000b0020c5253d926sm12927027wrh.114.2022.05.17.07.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 07:19:02 -0700 (PDT)
Date: Tue, 17 May 2022 16:18:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V2 8/8] vhost: rename vhost_work_dev_flush
Message-ID: <20220517141859.yv4pswknmo2r2kfc@sgarzare-redhat>
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-9-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220515202922.174066-9-michael.christie@oracle.com>
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

On Sun, May 15, 2022 at 03:29:22PM -0500, Mike Christie wrote:
>This patch renames vhost_work_dev_flush to just vhost_dev_flush to
>relfect that it flushes everything on the device and that drivers
>don't know/care that polls are based on vhost_works. Drivers just
>flush the entire device and polls, and works for vhost-scsi
>management TMFs and IO net virtqueues, etc all are flushed.
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/net.c   |  4 ++--
> drivers/vhost/scsi.c  |  2 +-
> drivers/vhost/test.c  |  2 +-
> drivers/vhost/vhost.c | 10 +++++-----
> drivers/vhost/vhost.h |  2 +-
> drivers/vhost/vsock.c |  2 +-
> 6 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
