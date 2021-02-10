Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5061EC433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 12:28:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98CF64E3B
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 12:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98CF64E3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BD06871EE;
	Wed, 10 Feb 2021 12:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pWwVbLIa8Ivw; Wed, 10 Feb 2021 12:28:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9757B86DD3;
	Wed, 10 Feb 2021 12:28:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D01DC0174;
	Wed, 10 Feb 2021 12:28:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDC63C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ABA408715D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MYafRuaDUSWT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:28:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C39A86DD3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612960132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i5wXyy1sPUgnnMqVauVL41jvRX6eG8p4VtBbB9PGUS8=;
 b=GJN9Ms8JS3P8FihrakgZoDJ5qI+SHgzHKJv4e8Q5+mrUAhRZ1nhaqBT+80nCVTBM8+RkjM
 ioDpHeD5UhxpqLbmVD8QNeCpVNHP/bC+iVrHG7Dr7e2QQRpBNNIu5L5RJVMJWMjP1NeujM
 as+7uePvBfZS8O/EXZV3wfcxVrCJ348=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-denf_n7nPcOnJ10wBWTT0w-1; Wed, 10 Feb 2021 07:28:51 -0500
X-MC-Unique: denf_n7nPcOnJ10wBWTT0w-1
Received: by mail-wm1-f69.google.com with SMTP id y84so906479wmg.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i5wXyy1sPUgnnMqVauVL41jvRX6eG8p4VtBbB9PGUS8=;
 b=Wrx/qXL+cEzO4p4rax8TPErvzSoftxcbG3vL5DQxkagoEevvaPVX/VNCig6h1IWde2
 hsbnaTP+kXCoHMIR7aPvL3pA/RVR6pbG7+Uz9rWFR4XFI5+Mlb1y4pEcwOijCmfLJqNM
 +Urv+CdAepLDPUk4pM1U6GeIFyJoKC/1t6jXg0DxNzWFh3oDl+9g52Qc/0mNI1Vw+b0d
 VQR0WqROh9CIjZRm7s1qSTRcKw96lPkxOEPytH/iNZs07icyxZZszzqABIqCmVsvz3ej
 tmZ9x+MeTwGD51vTHc4Y+zL0cIRd+trDnO4ezjr9RAgHergivurTlTc4d63JIXKRa+1V
 eGMg==
X-Gm-Message-State: AOAM530luSZftMoxWiKX2gb65N0QlsFvbXUIPfsw/el/jgnZyX0OPwHn
 KrbYJI8PNxfKmIiOt79FP7gRBMVgP+I8dWPB6y1rDmYz1LQ92QcmVCBxQuUVUkHnj1jTiB72ouK
 GgstEwDxGLPpsW5KSkuw1GJizsm2FE3mxw+dTlWIeUQ==
X-Received: by 2002:adf:b611:: with SMTP id f17mr3364771wre.8.1612960129954;
 Wed, 10 Feb 2021 04:28:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9+xzSxdXFmowIk42Rj2TTfAS5qUcbZY08lcAl1KI09s/LaYklsKwABS3n8zQbgdh+YNgXxg==
X-Received: by 2002:adf:b611:: with SMTP id f17mr3364759wre.8.1612960129805;
 Wed, 10 Feb 2021 04:28:49 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id i10sm3116755wrp.0.2021.02.10.04.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 04:28:49 -0800 (PST)
Date: Wed, 10 Feb 2021 07:28:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 2/3] mlx5_vdpa: fix feature negotiation across device reset
Message-ID: <20210210072758-mutt-send-email-mst@kernel.org>
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
 <1612614564-4220-2-git-send-email-si-wei.liu@oracle.com>
 <20210208053500.GA137517@mtl-vdi-166.wap.labs.mlnx>
 <061486d5-6235-731b-d036-f5d5e9fac22e@oracle.com>
MIME-Version: 1.0
In-Reply-To: <061486d5-6235-731b-d036-f5d5e9fac22e@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 08, 2021 at 05:20:11PM -0800, Si-Wei Liu wrote:
> 
> 
> On 2/7/2021 9:35 PM, Eli Cohen wrote:
> > On Sat, Feb 06, 2021 at 04:29:23AM -0800, Si-Wei Liu wrote:
> > > The mlx_features denotes the capability for which
> > > set of virtio features is supported by device. In
> > > principle, this field needs not be cleared during
> > > virtio device reset, as this capability is static
> > > and does not change across reset.
> > > 
> > > In fact, the current code may have the assumption
> > > that mlx_features can be reloaded from firmware
> > > via the .get_features ops after device is reset
> > > (via the .set_status ops), which is unfortunately
> > > not true. The userspace VMM might save a copy
> > > of backend capable features and won't call into
> > > kernel again to get it on reset. This causes all
> > > virtio features getting disabled on newly created
> > > virtqs after device reset, while guest would hold
> > > mismatched view of available features. For e.g.,
> > > the guest may still assume tx checksum offload
> > > is available after reset and feature negotiation,
> > > causing frames with bogus (incomplete) checksum
> > > transmitted on the wire.
> > > 
> > > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index b8416c4..aa6f8cd 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1788,7 +1788,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> > >   		clear_virtqueues(ndev);
> > >   		mlx5_vdpa_destroy_mr(&ndev->mvdev);
> > >   		ndev->mvdev.status = 0;
> > > -		ndev->mvdev.mlx_features = 0;
> > >   		++mvdev->generation;
> > >   		return;
> > >   	}
> > Since we assume that device capabilities don't change, I think I would
> > get the features through a call done in mlx5v_probe after the netdev
> > object is created and change mlx5_vdpa_get_features() to just return
> > ndev->mvdev.mlx_features.
> Yep, it makes sense. Will post a revised patch.

So I'm waiting for v2 of this patchset. Please make sure to post a cover letter
with an overall description.

> If vdpa tool allows
> reconfiguration post probing, the code has to be reconciled then.
> 
> > 
> > Did you actually see this issue in action? If you did, can you share
> > with us how you trigerred this?
> Issue is indeed seen in action. The mismatched tx-checksum offload as
> described in the commit message was one of such examples. You would need a
> guest reboot though (triggering device reset via the .set_status ops and
> zero'ed mlx_features was loaded to deduce new actual_features for creating
> the h/w virtq object) for repro.
> 
> -Siwei
> > 
> > > -- 
> > > 1.8.3.1
> > > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
