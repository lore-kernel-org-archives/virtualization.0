Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC4C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:13:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2455601FF
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2455601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 87E6486FFC;
	Tue, 23 Feb 2021 12:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LWtvrqskrYiL; Tue, 23 Feb 2021 12:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 078D886631;
	Tue, 23 Feb 2021 12:13:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDFECC000A;
	Tue, 23 Feb 2021 12:13:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA308C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0A4183880
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:13:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KSrGqQmR0Cma
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:13:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5592483638
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614082380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmkj4RJLqjeImMs31r/2Y0gal61E1mG/vnuon8zBHso=;
 b=SnX+zoKCziHqa08Vi5PDg/3cxVtYVnmXN4AUc7NcAQUvjrlGH/Nd/zmL83j+ftBFVSV3RN
 waE12cNPJLaw54dCw6qb1paaDRn0jT60hte1xvkW/8Wxa8fUOEauGm65140A3ADHn0aMeT
 czCE1mPmCpPK1LX4lrSz9a2ZrmXMIIU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-MOlbQaZLN5Kgiq3dmRa-vQ-1; Tue, 23 Feb 2021 07:12:58 -0500
X-MC-Unique: MOlbQaZLN5Kgiq3dmRa-vQ-1
Received: by mail-wr1-f71.google.com with SMTP id p18so7289776wrt.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xmkj4RJLqjeImMs31r/2Y0gal61E1mG/vnuon8zBHso=;
 b=G2OoMzunHsuIfOMys7Ny2gFRgxTcyIHMvgfZfF7sVP0haKADOhpAlYHiJf65O777AE
 i/zxmrq73YDhpyGdXwfxWFLjc4jJgnr2xLwg7bfk9fAl4D+vcJ14n92mIItEf7ik7X2n
 AwjdeWra2x76Bd4YYG0UCftu5Pk4+4/a9FJ7BZK4RkpWi8PuBVsSP0VzyDEbvxA2f45j
 HXZW69S48MF+SjhkQJJXRE/Xg//lVNyavW3O9v+BaSv1n8X763CB60MhuSk9Mfy7N7lG
 JA4PYxRSZEqL+XMCWKpl6BoYoVDGWfFq2ogJ19MFi8QaQNzyuMOpf9CkO/MmJ39a8Dpa
 PJLQ==
X-Gm-Message-State: AOAM531owKrGTWKWCeVpc12Of21f8cVIJ2XZ/M/WgjdbPb5ALY3HzDUc
 vTe+CkV4vUitapef7UNRUNVWetshfDVAhYvWU6LPoNyA5bmvP9K1aIsunm2AITFCC5/0VBt0tUM
 fjoQP6E2oThe+xpS9sZphO7JdyrADOm/0ZtOaN5eC+g==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr3383359wmt.174.1614082377302; 
 Tue, 23 Feb 2021 04:12:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQriuEv4srgC6HfVwzVOrEyaa0oOOpDCwQJKbYJTWUFJPzXY0QCBQp+AaVmvNE73oAw9fW9A==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr3383351wmt.174.1614082377118; 
 Tue, 23 Feb 2021 04:12:57 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id k81sm2497549wmf.10.2021.02.23.04.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:12:56 -0800 (PST)
Date: Tue, 23 Feb 2021 07:12:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gautam Dawar <gdawar.xilinx@gmail.com>
Subject: Re: [PATCH v2] vhost vdpa: fix the missing
 irq_bypass_unregister_producer() invocation
Message-ID: <20210223071149-mutt-send-email-mst@kernel.org>
References: <CAJ-rMYpFFD0vwERMbj_tMLmeFqECr0Q+s4ct_sO0AAt3rgWG0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ-rMYpFFD0vwERMbj_tMLmeFqECr0Q+s4ct_sO0AAt3rgWG0Q@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 23, 2021 at 03:30:45PM +0530, Gautam Dawar wrote:
> When qemu with vhost-vdpa netdevice is run for the first time, it works w=
ell.
> But after the VM is powered off, the next qemu run causes kernel panic du=
e to a
> NULL pointer dereference in irq_bypass_register_producer().
> =

> When the VM is powered off, vhost_vdpa_clean_irq() misses on calling
> irq_bypass_unregister_producer() for irq 0 because of the existing check.
> =

> This leaves stale producer nodes, which are reset in vhost_vring_call_res=
et()
> when vhost_dev_init() is invoked during the second qemu run.
> =

> As the node member of struct irq_bypass_producer is also initialized
> to zero, traversal on the producers list causes crash due to NULL pointer
> dereference.
> =

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D211711
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>

Could you please repost without HTML? Otherwise git am fails on this patch:

error: corrupt patch at line 6
error: could not build fake ancestor
Patch failed at 0001 vhost vdpa: fix the missing irq_bypass_unregister_prod=
ucer() invocation

Also, which commit introduces the bug? A Fixes: tag would be helpful.

Thanks!

> -----
> changelog:
> v1->v2:
> =A0- Addressed Jason's comment to remove the irq check and use
> =A0 =A0vhost_vdpa_unsetup_vq_irq() to avoid local variable vq
> -----
> =

> =

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 62a9bb0efc55..e00573b87aba 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -844,14 +844,10 @@ static int vhost_vdpa_open(struct inode *inode, str=
uct
> file *filep)
> =

> =A0static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
> =A0{
> - =A0 =A0 =A0 struct vhost_virtqueue *vq;
> =A0 =A0 =A0 =A0 int i;
> =

> - =A0 =A0 =A0 for (i =3D 0; i < v->nvqs; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vq =3D &v->vqs[i];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vq->call_ctx.producer.irq)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_bypass_unregister_produ=
cer(&vq->call_ctx.producer);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 for (i =3D 0; i < v->nvqs; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vhost_vdpa_unsetup_vq_irq(v, i);
> =A0}
> =

> =A0static int vhost_vdpa_release(struct inode *inode, struct file *filep)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
