Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B686FC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 01:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50A66606F9;
	Thu,  9 Dec 2021 01:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1NNAnAorkLuE; Thu,  9 Dec 2021 01:35:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFDEB6069D;
	Thu,  9 Dec 2021 01:35:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0774C0030;
	Thu,  9 Dec 2021 01:35:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDCEC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CE5760649
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_6fJauoImjf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:35:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00E2E6069D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639013731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=taLsr6fO/b7Rc0RnBuLY7aJzAZILfwkPOs7gjAn2N7s=;
 b=Jm8iFtmTZwkTyL9Hv39oR1TuyZ78KmOz6xD2NJFSUMqFuM264uqX3hZrjZ9lIGxNEqO8cZ
 +JgophBWFaDBE7N49GqbdqeWcBjKXI5rzw39ieTVGBlpaybBeuFIM55xBFZNdsXv+eQgAO
 6X8qDXnj4dVvF8lvvh5Chek8hnt/M7A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-v68Cm7cUP86aEvfh5r1okw-1; Wed, 08 Dec 2021 20:35:27 -0500
X-MC-Unique: v68Cm7cUP86aEvfh5r1okw-1
Received: by mail-lf1-f71.google.com with SMTP id
 k32-20020a0565123da000b0041643c6a467so1904074lfv.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 17:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=taLsr6fO/b7Rc0RnBuLY7aJzAZILfwkPOs7gjAn2N7s=;
 b=RXunzQAuB69wgiTCebg6qAKV3iR47AaYCkof7a6OrAz6qmF+L8WDWlJqta4fBNN+W6
 y0O63kpRfHMyXMs7JZwsFbMb3UecmNS8+kqZuicpadpZtHcdZrOUFLURu3miK4kJQMrR
 pCl+bT+nAPgaf4/tUv+OdY42r3OSMmFdPxnx0bf1BUrUmiL5NA7S4NBkYVsAHU7FCYK4
 KGFBV/bGnz6382X0vYDdLmSuFvh69KzFsnXBuIprB3jJDI7G2XOYjQ3wC76OUw0hpEz7
 QBY+3CAKrvL9MDzKS+NZFP75wqFIeznRgPsuPU4NtNenoeLAr3sChyxUVKVNNPDIU1Am
 Y/Ug==
X-Gm-Message-State: AOAM533bFrtZAULu5NDOlMlOqpi1dxvz+2DAmOAPnp952x4/j5espluI
 TNsE6NUljZsO92SOX3K596Lwm4iy2ogyAxl/Wuz9wbvQumrViVFZU0oWN14xSEuPhcxa0EH6W+6
 7heHQ47IeOvy78FLO2ZYIBCMyeBKqldcmGg84I+EFHg5pU5fWEXRXEX7UEQ==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr3008658lfi.498.1639013726210; 
 Wed, 08 Dec 2021 17:35:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY9akOQhW4ssd9sAvc3Qxcr0Vx9o1aqV2KvSjIFRnMDVo1+Rr55t1tNde+8JKmATWSznqtDZPb48hVY0j8oJU=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr3008642lfi.498.1639013726019; 
 Wed, 08 Dec 2021 17:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-7-michael.christie@oracle.com>
 <CACGkMEtsMauWPP5zQQg0Z09A-jDVPcsoHTEAksy94aYbpZ0huA@mail.gmail.com>
 <e739499f-dbb1-f249-4c36-969dd810eb5c@oracle.com>
In-Reply-To: <e739499f-dbb1-f249-4c36-969dd810eb5c@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 09:35:15 +0800
Message-ID: <CACGkMEsfML6Pytn_QaZ7nt6f=DsMoe55eb++XgqBE3P7q-0dcg@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 12:45 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 12/7/21 10:07 PM, Jason Wang wrote:
> > On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> The flush after vhost_dev_cleanup is not needed because:
> >>
> >> 1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
> >> so the flush call will just return since the worker has not device.
> >>
> >> 2. It's not needed for the re-queue case. vhost_scsi_evt_handle_kick grabs
> >> the mutex and if the backend is NULL will return without queueing a work.
> >> vhost_scsi_clear_endpoint will set the backend to NULL under the vq->mutex
> >> then drops the mutex and does a flush. So we know when
> >> vhost_scsi_clear_endpoint has dropped the mutex after clearing the backend
> >> no evt related work will be able to requeue. The flush would then make sure
> >> any queued evts are run and return.
> >
> > What happens if a kick after vhost_scsi_clear_endpoint() but before
> > vhost_dev_stop()?
>
> vhost_dev_stop also does a flush, so:
>
> 1. The kick handler would see the backend is null and return immediately.
> 2. The flush in vhost_dev_stop would wait for those kicks in #1 to complete.

You are right.

So

Acked-by: Jason Wang <jasowang@redhat.com>

>
>
> >
> > Is this safe or the kthread_stop() in vhost_dev_cleanup() makes us safe?
> >
> > Thanks
> >
> >>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >> ---
> >>  drivers/vhost/scsi.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> >> index 532e204f2b1b..94535c813ef7 100644
> >> --- a/drivers/vhost/scsi.c
> >> +++ b/drivers/vhost/scsi.c
> >> @@ -1827,8 +1827,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
> >>         vhost_scsi_clear_endpoint(vs, &t);
> >>         vhost_dev_stop(&vs->dev);
> >>         vhost_dev_cleanup(&vs->dev);
> >> -       /* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
> >> -       vhost_scsi_flush(vs);
> >>         kfree(vs->dev.vqs);
> >>         kvfree(vs);
> >>         return 0;
> >> --
> >> 2.25.1
> >>
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
