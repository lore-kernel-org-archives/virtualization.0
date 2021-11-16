Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5AC433EF
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:35:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9B861C12
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA9B861C12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76EA8401B2;
	Tue, 16 Nov 2021 14:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQ0kPnZmNFRO; Tue, 16 Nov 2021 14:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0160B40189;
	Tue, 16 Nov 2021 14:35:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB934C002E;
	Tue, 16 Nov 2021 14:35:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5870CC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40A686059F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L_emYm9g_4Rw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:35:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9641F6002E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637073319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rDz1YUR0AgNW1PyJTJkx0fL4NDM6le7gN2iBvKWyYhY=;
 b=F461NkN5XJy0TyHWHh++eUOeXHbreq2b16hQfVk5nW/axYSZw/gLPE2oKHiX9KDD3v+HLX
 IuovUxyT+HPAbPcYvG6++Pjvy14ZqtRhsAOd/u5KBUcQ5jHH0NNMPtqbjfBHSLB42OeKn9
 U/zel0LZZ/erT3hMlEaFlyz2SlAJf3M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-vo5LdQ7uNje9UYx6kb9Bcg-1; Tue, 16 Nov 2021 09:35:18 -0500
X-MC-Unique: vo5LdQ7uNje9UYx6kb9Bcg-1
Received: by mail-wr1-f72.google.com with SMTP id
 h13-20020adfa4cd000000b001883fd029e8so4560619wrb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 06:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rDz1YUR0AgNW1PyJTJkx0fL4NDM6le7gN2iBvKWyYhY=;
 b=zWmz+QbnyzjOeGhBrYmeUhfurJDzyvAvd3ZbjNTT4pgm6me2OXjUtwIKa5kVd5dMXT
 3Kp4z4bghO9APcic2Pz99aWWg5mZTXV4ploziM+u8JBxPu8k3/mgeFtPVsgu/avuqY9z
 oCCXN0Dm5eBlNUNCWxxBcqHs47E5rfDjMxzzA2EvqaeyPbWxQHq1K2JIKm+fHyqTZkue
 6LIThc4TBX6hLS86TB8ZB+t4XSbWEmoUzUVj1XGMxg/ACdvGcGVkxzP9CYYDrsOiLntj
 rNddQuqQK2wkPNhh4BzmCINXlkMY+D1tCsh79FI82eFr4x/HsP1yA3FU0nVq+E/Vpue3
 8HPg==
X-Gm-Message-State: AOAM530Yw60n6igo6Qj537cU7rJmGKygEL9LCDPCsmMyDiPfFPk4eVwo
 SR7eHO6NfkEbLjvps2A5+EUcrUa/8ToJrlyqf7MVK00C7nnW8Rc1rxGJne/svzCNbjF+rM0npax
 2tDhDHuAGP6IcqDf1ZWADNXn8lTCxYru/CwFPLyMrXA==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr10045250wrn.335.1637073317268; 
 Tue, 16 Nov 2021 06:35:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTqQ6byTlaJB2mMvVBJPVz/03fWQs2QX2Z7ktgMC1OpQia0Z85aodMjtpJrgMPy+iqkkZfiQ==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr10045215wrn.335.1637073317064; 
 Tue, 16 Nov 2021 06:35:17 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id s8sm4988581wra.9.2021.11.16.06.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 06:35:16 -0800 (PST)
Date: Tue, 16 Nov 2021 15:35:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH 4/6] vhost_vsock: simplify vhost_vsock_flush()
Message-ID: <20211116143514.2jvemtjrds4453me@steredhat>
References: <20211115153003.9140-1-arbn@yandex-team.com>
 <20211115153003.9140-4-arbn@yandex-team.com>
MIME-Version: 1.0
In-Reply-To: <20211115153003.9140-4-arbn@yandex-team.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Nov 15, 2021 at 06:30:01PM +0300, Andrey Ryabinin wrote:
>vhost_vsock_flush() calls vhost_work_dev_flush(vsock->vqs[i].poll.dev)
>before vhost_work_dev_flush(&vsock->dev). This seems pointless
>as vsock->vqs[i].poll.dev is the same as &vsock->dev and several flushes
>in a row doesn't do anything useful, one is just enough.
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>---
> drivers/vhost/vsock.c | 5 -----
> 1 file changed, 5 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b0361ebbd695..b4dcefbb7e60 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -707,11 +707,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
> static void vhost_vsock_flush(struct vhost_vsock *vsock)
> {
>-	int i;
>-
>-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
>-		if (vsock->vqs[i].handle_kick)
>-			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
> 	vhost_work_dev_flush(&vsock->dev);
> }
>
>-- 
>2.32.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
