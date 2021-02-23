Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC8EC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:50:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF4264E60
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF4264E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 284F7605FA;
	Tue, 23 Feb 2021 12:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7b9Lr6BT1Uez; Tue, 23 Feb 2021 12:50:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0364600C7;
	Tue, 23 Feb 2021 12:50:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71AF5C000A;
	Tue, 23 Feb 2021 12:50:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68920C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4F4628702B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPn1rM-cT1pd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 928258700C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614084602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Loh6bAHnqllI5I4rAimLDv+dTcXoDLCeXaJNMPggIQ=;
 b=Pp435fdxn602YnWUGBXHk0YPHKMC36M4g4/iOf1xgmQzpjiG+7oMNKopyGzBmlKVTmok3a
 8AUs4aA1FDWmNY5V+YQu5RkL30itl1m3fEt1c0C8GQ4sGVSkW0N4orl9Fuw2UrydPoVT4I
 u5Po1w55dqaIv5XW4QzAHSPZOI7c+Ec=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-DS7c0TLDMlKSbIBAcMTnzg-1; Tue, 23 Feb 2021 07:50:00 -0500
X-MC-Unique: DS7c0TLDMlKSbIBAcMTnzg-1
Received: by mail-wr1-f71.google.com with SMTP id x14so6656523wrr.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3Loh6bAHnqllI5I4rAimLDv+dTcXoDLCeXaJNMPggIQ=;
 b=aV6DK1PI6nTust1Un6WCquUN1hn9qZU2cqevn/h8h5TuWqtmquqVOnPmysd3lUhnYL
 hmepoT+WZZD5/3ksVYo/GOb8OMKKqr9qfOXCTJIBxiGz8gsxg4a7+pSOODZfSN6mt88K
 RC1Sx9eTLw+UWVgXukj4BAU8kQ7xBrcihnehsYpYAzURfgQxMKseu52iDX2YmZZaOZbF
 6wNi7xdAIlRJ4N9TfBVQiwHZCptBW+jQaqyNTnKeWPj93OD0FeqbJ6Dj6PU9DctiMIu5
 OdERtTeLg207NXJoZ5gbQNiDLRr1jk3MJ76HDZ6wy71fRGZZzBxnHrTBLFQbI6UI6fee
 eUUw==
X-Gm-Message-State: AOAM533J6iJfFk9/JHA+FdMcOxpB3goBvz/533rvxuoxpq3zfKRMlUFV
 siILyGCnzlvp5eZ7v8LXnsjSza7sOTElPxOPRwbVnhng6B2EqkIIY9PULXfBfx6kbinu0XHcXkP
 ehNmTfsMbFCAt6mnA4NxV9y1HoFTXI687D0EXK0Mp0w==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr22752563wmc.90.1614084599320; 
 Tue, 23 Feb 2021 04:49:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybofQaRshFMTgFCUWNLQh/aOhh9k0fvKfMs7IvYKStDiRNjcA5o/Nh29MKVzIqR9BcOJzWVA==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr22752551wmc.90.1614084599172; 
 Tue, 23 Feb 2021 04:49:59 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id w11sm9646073wru.3.2021.02.23.04.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:49:58 -0800 (PST)
Date: Tue, 23 Feb 2021 07:49:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gautam Dawar <gdawar.xilinx@gmail.com>
Subject: Re: [PATCH v3] vhost_vdpa: fix the missing
 irq_bypass_unregister_producer() invocation
Message-ID: <20210223074934-mutt-send-email-mst@kernel.org>
References: <CAJ-rMYrst2Xrg5a6dDTufMacqjy_Ccg2FM8XpAt4p2J9Yk_u7g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ-rMYrst2Xrg5a6dDTufMacqjy_Ccg2FM8XpAt4p2J9Yk_u7g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: martinh@xilinx.com, hanand@xilinx.com, gdawar@xilinx.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 23, 2021 at 06:15:07PM +0530, Gautam Dawar wrote:
> When qemu with vhost-vdpa netdevice is run for the first time, it works well.
> But after the VM is powered off, the next qemu run causes kernel panic due to a
> NULL pointer dereference in irq_bypass_register_producer().
> 
> When the VM is powered off, vhost_vdpa_clean_irq() misses on calling
> irq_bypass_unregister_producer() for irq 0 because of the existing check.
> 
> This leaves stale producer nodes, which are reset in vhost_vring_call_reset()
> when vhost_dev_init() is invoked during the second qemu run.
> 
> As the node member of struct irq_bypass_producer is also initialized
> to zero, traversal on the producers list causes crash due to NULL pointer
> dereference.
> 
> Fixes: 2cf1ba9a4d15c ("vhost_vdpa: implement IRQ offloading in vhost_vdpa")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211711
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>


A bit better but still:
Applying: vhost_vdpa: fix the missing irq_bypass_unregister_producer() invocation
error: corrupt patch at line 6
error: could not build fake ancestor
Patch failed at 0001 vhost_vdpa: fix the missing irq_bypass_unregister_producer() invocation
hint: Use 'git am --show-current-patch=diff' to see the failed patch


you also want to include acks you got on the previous versions.

> -----
> changelog:
> v2->v3:
>  - Re-submitting the patch in plain text format as suggested by Michael
>  - Added the fixes tag
> 
> v1->v2:
>  - Addressed Jason's comment to remove the irq check and use
>    vhost_vdpa_unsetup_vq_irq() to avoid local variable vq
> -----
> 
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 62a9bb0efc55..e00573b87aba 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -844,14 +844,10 @@ static int vhost_vdpa_open(struct inode *inode,
> struct file *filep)
> 
>  static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
>  {
> -       struct vhost_virtqueue *vq;
>         int i;
> 
> -       for (i = 0; i < v->nvqs; i++) {
> -               vq = &v->vqs[i];
> -               if (vq->call_ctx.producer.irq)
> -                       irq_bypass_unregister_producer(&vq->call_ctx.producer);
> -       }
> +       for (i = 0; i < v->nvqs; i++)
> +               vhost_vdpa_unsetup_vq_irq(v, i);
>  }
> 
>  static int vhost_vdpa_release(struct inode *inode, struct file *filep)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
