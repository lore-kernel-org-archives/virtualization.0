Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1844C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 04:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7226060EFE;
	Wed,  8 Dec 2021 04:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBud7gju1yGk; Wed,  8 Dec 2021 04:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F81960E90;
	Wed,  8 Dec 2021 04:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA1A6C001E;
	Wed,  8 Dec 2021 04:07:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A396CC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EAD440144
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Qyzq3HfuLZl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:07:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 811C9400C7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638936441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVVjJ8KJR/5BZviOjMg13l5QAFsXChx2ODTpklOg9gQ=;
 b=MM/cWR5ksJ7M/wXs/0D2Dc649r1PgpSS2F1QyWeRUxHSB5sYAjFJ/Cm8AEHRptspWU/7dw
 y+I85FWdQMBL0uOd1k8qxK8FmZtgNpLop+x9aMpwpVbQyAzqva8c2hrKYaI0eyqNz09suG
 24h/bhC7atg2GkQVHIACBaCA4HXHS4M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-j1B508XJM3OMRqWzcsedqw-1; Tue, 07 Dec 2021 23:07:20 -0500
X-MC-Unique: j1B508XJM3OMRqWzcsedqw-1
Received: by mail-lf1-f71.google.com with SMTP id
 h40-20020a0565123ca800b00402514d959fso531328lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 20:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cVVjJ8KJR/5BZviOjMg13l5QAFsXChx2ODTpklOg9gQ=;
 b=JszUVxMIAprptOr7eMyrxZJpyJ9IzVAncqK6wk0L/ddnhamG4d7vERGX+thV6K2aUI
 bUvV8SUaOSLCtQX4I86i1mklt3jvAiijUl45GPugD1DBaPaX1ZDmX3IhdgGGBcZYOwlf
 PhhgcekKKFct4RHJeGf3MdVFhSr6TgVT7bGA7aVN9rXLgLaS8WlHi+nH4BmT3vl3lmF+
 Z3C+6FjjyaJ4FK4WZglssOcSg1ZNVxKootPPuUfNAagzAcY87+UbmrZ4GjR9hsU60gc1
 0o/uhL90DEnefE0nvHNef1rD5Q0LRpJdQMdkz7y6eprHZvIDb+a6uKfjewaYulRPlb/r
 vqkA==
X-Gm-Message-State: AOAM530INHn2s3kP6ZojGdGXO01wIK6EAHsqsaNK13F+tYBtre2I1vZP
 S8Fla3X6F9mOXSWyRCEpt0EDnA1p50hCFCeJzz0mJdVhVVAXTpa0ZBrBcWbAgK8bvtgPriYA3qI
 nT5lTsLpwaJPc6KoCSb7bMDg0KQQCo+P5doi2OfMuFRWLeSJQkHOnwdHxLA==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr45052598lfi.498.1638936438891; 
 Tue, 07 Dec 2021 20:07:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzskCVamgSm/2DDwTmJAd5TWNmojQDKsrvRVmB+0Rk3z4VTOJ7/odVD8M6ToF5aqgAm5xzPYkCrnAmoRmCAmU=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr45052582lfi.498.1638936438719; 
 Tue, 07 Dec 2021 20:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-7-michael.christie@oracle.com>
In-Reply-To: <20211207024510.23292-7-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 12:07:08 +0800
Message-ID: <CACGkMEtsMauWPP5zQQg0Z09A-jDVPcsoHTEAksy94aYbpZ0huA@mail.gmail.com>
Subject: Re: [PATCH 6/7] vhost-scsi: drop flush after vhost_dev_cleanup
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> The flush after vhost_dev_cleanup is not needed because:
>
> 1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
> so the flush call will just return since the worker has not device.
>
> 2. It's not needed for the re-queue case. vhost_scsi_evt_handle_kick grabs
> the mutex and if the backend is NULL will return without queueing a work.
> vhost_scsi_clear_endpoint will set the backend to NULL under the vq->mutex
> then drops the mutex and does a flush. So we know when
> vhost_scsi_clear_endpoint has dropped the mutex after clearing the backend
> no evt related work will be able to requeue. The flush would then make sure
> any queued evts are run and return.

What happens if a kick after vhost_scsi_clear_endpoint() but before
vhost_dev_stop()?

Is this safe or the kthread_stop() in vhost_dev_cleanup() makes us safe?

Thanks

>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 532e204f2b1b..94535c813ef7 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1827,8 +1827,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
>         vhost_scsi_clear_endpoint(vs, &t);
>         vhost_dev_stop(&vs->dev);
>         vhost_dev_cleanup(&vs->dev);
> -       /* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
> -       vhost_scsi_flush(vs);
>         kfree(vs->dev.vqs);
>         kvfree(vs);
>         return 0;
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
