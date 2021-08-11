Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D717C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:51:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AF5601FD
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40AF5601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FB9340533;
	Wed, 11 Aug 2021 12:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmroT3oz2yeW; Wed, 11 Aug 2021 12:51:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 910B34055F;
	Wed, 11 Aug 2021 12:51:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC54C001A;
	Wed, 11 Aug 2021 12:51:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11271C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7BB4608F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RaCn5o8TCuc9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:51:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B501F608E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628686296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AFUJ80vHH0ueLbj+Xk0/xSh/x4vF3GriBR4GbgjbOHs=;
 b=HmtefRcnE1vF4UyaxuEG1o3ZybgCfgJnLBOZf/Pw8FZBq87so0zjEkhjzhsnVbE26Tw+zo
 gHclnlnSPFyPqKfbqUO9CASnHh9Z9f7AGEKNJrBC6UzrjWk/dIwZivu78S0h04uApJ+/M1
 rys7joGCw9wtW7XuHq9G31mtJkhLRds=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-T57cAvIPMrWtsWmo7vArcA-1; Wed, 11 Aug 2021 08:51:35 -0400
X-MC-Unique: T57cAvIPMrWtsWmo7vArcA-1
Received: by mail-lj1-f198.google.com with SMTP id
 m25-20020a2e91190000b02901b56d9a95dfso736874ljg.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AFUJ80vHH0ueLbj+Xk0/xSh/x4vF3GriBR4GbgjbOHs=;
 b=hcoYi679URtJ27X9wRxKU5hAqsK/UFqqJPBMhA2+qtSRgDwJacNO5c0ud0Igfe+Vy/
 ZyvYnlkvm6nYY2tXsOVlcjbthqFzrqQVS3wZ/Tab+9wRRbY10N75IreoR/jj29o5bBrz
 dgxPi3ZuLPyHoo5suxDQC9fRseTFGvuIJ2RKE2opzKOA+AlWqQedMBRfe/H96PBsPWOn
 Xiys7dZHVVIXzeJOOCMnIAfuip1zOw381huwq9qXElnD/CRnW551Rs8O2WEeneXToYzG
 lE6bWeM1p8dnAIksQu+PTiN2o/X/U+DLIw9nTy7aIG88s4OxyKxPp8uQR+sEkNF3QPyP
 GfUg==
X-Gm-Message-State: AOAM53116S8n0DIdfPHuqVa8XRC40L887WPezhZ3CkHDjhNtZlXEglLk
 J3IlalyEqxeUNqa++Ekiq9mxB4oLJJNe/bJ91x/dAZSs8VxDGcdiDdknkPML3cN5UIm913HWjPg
 52dgqcsnD5ObdpukRwE4ldtHwKwXDKj8u/Z7hB/s3rrG300IRtIwguQyzbQ==
X-Received: by 2002:a05:651c:84:: with SMTP id
 4mr22725173ljq.261.1628686293890; 
 Wed, 11 Aug 2021 05:51:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdf/glx6YoUy93A99cGHM0K9HFEQwnha1zM25SgOf9QMbDftiNVX1zgFpk95KZ+cTNuHSZMtrVy+eZM2cgTRo=
X-Received: by 2002:a05:651c:84:: with SMTP id
 4mr22725165ljq.261.1628686293717; 
 Wed, 11 Aug 2021 05:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210811121344.GA14245@kili>
In-Reply-To: <20210811121344.GA14245@kili>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Aug 2021 20:51:22 +0800
Message-ID: <CACGkMEtuoTA20jtHQotF0G4h4EqUuQoiWdSq=URDb3mPPyc+TA@mail.gmail.com>
Subject: Re: [bug report] vhost_net: basic polling support
To: Dan Carpenter <dan.carpenter@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

Hi Dan:

On Wed, Aug 11, 2021 at 8:14 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Jason Wang,
>
> The patch 030881372460: "vhost_net: basic polling support" from Mar
> 4, 2016, leads to the following
> Smatch static checker warning:
>
>         drivers/vhost/vhost.c:2565 vhost_new_msg()
>         warn: sleeping in atomic context
>
> vers/vhost/net.c
>    509  static void vhost_net_busy_poll(struct vhost_net *net,
>    510                                  struct vhost_virtqueue *rvq,
>    511                                  struct vhost_virtqueue *tvq,
>    512                                  bool *busyloop_intr,
>    513                                  bool poll_rx)
>    514  {
>    515          unsigned long busyloop_timeout;
>    516          unsigned long endtime;
>    517          struct socket *sock;
>    518          struct vhost_virtqueue *vq = poll_rx ? tvq : rvq;
>    519
>    520          /* Try to hold the vq mutex of the paired virtqueue. We can't
>    521           * use mutex_lock() here since we could not guarantee a
>    522           * consistenet lock ordering.
>    523           */
>    524          if (!mutex_trylock(&vq->mutex))
>    525                  return;
>    526
>    527          vhost_disable_notify(&net->dev, vq);
>    528          sock = vhost_vq_get_backend(rvq);
>    529
>    530          busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
>    531                                       tvq->busyloop_timeout;
>    532
>    533          preempt_disable();
>                 ^^^^^^^^^^^^^^^^^
> This bumps the preemp_count.
>
> I guess this is to disable page faults?

No, it's intended since we will use busy_clock() which uses the per
cpu variable.

>
>    534          endtime = busy_clock() + busyloop_timeout;
>    535
>    536          while (vhost_can_busy_poll(endtime)) {
>    537                  if (vhost_has_work(&net->dev)) {
>    538                          *busyloop_intr = true;
>    539                          break;
>    540                  }
>    541
>    542                  if ((sock_has_rx_data(sock) &&
>    543                       !vhost_vq_avail_empty(&net->dev, rvq)) ||
>
> The call tree from here to the GFP_KERNEL is very long...
>
> vhost_vq_avail_empty()
> -> vhost_get_avail_idx()
>    -> __vhost_get_user()
>       -> __vhost_get_user_slow()
>          -> translate_desc()
>             -> vhost_iotlb_miss vhost_new_msg()  <-- GFP_KERNEL

This won't happen in reality since:

We will make sure the IOTLB contains the translation for avail idx.
See vq_meta_prefetch() that will be called at the begining of
handle_tx() and handle_rx().

So it looks like a false positive to me.

Thanks

>
>    544                      !vhost_vq_avail_empty(&net->dev, tvq))
>    545                          break;
>    546
>    547                  cpu_relax();
>    548          }
>    549
>    550          preempt_enable();
>    551
>    552          if (poll_rx || sock_has_rx_data(sock))
>    553                  vhost_net_busy_poll_try_queue(net, vq);
>
> regards,
> dan carpenter
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
