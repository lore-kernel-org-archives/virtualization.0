Return-Path: <SRS0=2X6m=EE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF645C4741F
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 21:48:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4637420809
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 21:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBSzUGTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4637420809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9430686AF7;
	Thu, 29 Oct 2020 21:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y73U3aFB-3dt; Thu, 29 Oct 2020 21:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7BF886CAC;
	Thu, 29 Oct 2020 21:48:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F147C088B;
	Thu, 29 Oct 2020 21:48:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2048C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9FDFD86BDC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RRnfVmUUkQjA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DB5B486AF7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604008085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8IJKdjzJP+Bzd+JavwFMGhO/rLMWGB7CifWdQeTL5s=;
 b=OBSzUGTj+a7KMAYspxtrZQmos0EbK8J15kgo0RCn+TCqBgTa+eQvwOV6ycUwvGDqp54vU6
 aX/9PLb+6gRPsBLLQAegAQM9MorBYjNbKmmv6hLlkhQC6F2zN0zOCxLhcvQkw20xDBTSCV
 2LRCTFf8JCXb30PG2gSdlBGQ9damKYE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-AV9_-xKAMxCDqgsy6KeFrg-1; Thu, 29 Oct 2020 17:48:03 -0400
X-MC-Unique: AV9_-xKAMxCDqgsy6KeFrg-1
Received: by mail-wr1-f72.google.com with SMTP id n14so1819117wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 14:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C8IJKdjzJP+Bzd+JavwFMGhO/rLMWGB7CifWdQeTL5s=;
 b=EGUbv/o51dh+TKtfA4XoycH3LuugWjRyh0JqEiCL89dgDoot+AJNpab70qXAalaxfF
 pjVnNO66aUh0AoMNf5bOXGfQ2EzUqo8X9XzmRltsByF2LH7Zueh0q73yeI2PT4vdqFOR
 mXe6ge76dfxFwTbMIt8G+JPi8ZZdNdq2FhOxINbIIDXPm+abr+zumMPzJDHjwaEzQ/+y
 dlJ9WpU1CTELmaPdlNvYk4sBsUQ6L+Tsv7bN9CdhD2GEm9s3zrxktRoQKQfND5azFqoD
 q54QIhlg/9qVPNTB4uI60IdeWM3GJl9D4EYhVUPcoNVp5/256OQYPxKzhMe5XlzkAkzo
 PqEg==
X-Gm-Message-State: AOAM533fRCoBT3SaP6YYD3ER1FHFPOa+CFhYw8QphfPuid0cQKGfIMws
 GcnUtkmpLmfx47lzKj6cMfS5pDkUFdA2u1nwZX0rwVTOoxRA3+33IlukXI2XJuaq833ljfuaLDT
 RbW59SYUB7BKugTOXHZwCm7m4FziaxPCJrQ5E2cn00g==
X-Received: by 2002:a05:600c:2942:: with SMTP id
 n2mr1314934wmd.101.1604008082647; 
 Thu, 29 Oct 2020 14:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmu0E08+0xXvcCyh4rjZmuCm6ekREYSNVbN7A50ZEg8itLvFMCN+GkjqSlqVDyY3ajxG1dzg==
X-Received: by 2002:a05:600c:2942:: with SMTP id
 n2mr1314921wmd.101.1604008082448; 
 Thu, 29 Oct 2020 14:48:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id v67sm2001236wma.17.2020.10.29.14.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 14:48:01 -0700 (PDT)
Date: Thu, 29 Oct 2020 17:47:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 00/17 V3] vhost: fix scsi cmd handling and cgroup support
Message-ID: <20201029174719-mutt-send-email-mst@kernel.org>
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Wed, Oct 21, 2020 at 07:34:46PM -0500, Mike Christie wrote:
> In-Reply-To: 
> 
> The following patches were made over Michael's vhost branch here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=vhost
> 
> They fix a couple issues with vhost-scsi when we hit the 256 cmd limit
> that result in the guest getting IO errors, add LUN reset support so
> devices are not offlined during transient errors, allow us to manage
> vhost scsi IO with cgroups, and imrpove IOPs up to 2X.
> 
> The following patches are a follow up to this post:
> https://patchwork.kernel.org/project/target-devel/cover/1600712588-9514-1-git-send-email-michael.christie@oracle.com/
> which originally was fixing how vhost-scsi handled cmds so we would
> not get IO errors when sending more than 256 cmds.
> 
> In that patchset I needed to detect if a vq was in use and for this
> patch:
> https://patchwork.kernel.org/project/target-devel/patch/1600712588-9514-3-git-send-email-michael.christie@oracle.com/
> It was suggested to add support for VHOST_RING_ENABLE. While doing
> that though I hit a couple problems:
> 
> 1. The patches moved how vhost-scsi allocated cmds from per lio
> session to per vhost vq. To support both VHOST_RING_ENABLE and
> where userspace didn't support it, I would have to keep around the
> old per session/device cmd allocator/completion and then also maintain
> the new code. Or, I would still have to use this patch
> patchwork.kernel.org/cover/11790763/ for the compat case so there
> adding the new ioctl would not help much.
> 
> 2. For vhost-scsi I also wanted to prevent where we allocate iovecs
> for 128 vqs even though we normally use a couple. To do this, I needed
> something similar to #1, but the problem is that the VHOST_RING_ENABLE
> call would come too late.
> 
> To try and balance #1 and #2, these patches just allow vhost-scsi
> to setup a vq when userspace starts to config it. This allows the
> driver to only fully setup (we still waste some memory to support older
> setups but do not have to preallocate everything like before) what
> is used plus I do not need to maintain 2 code paths.


OK, so could we get a patchset with just bugfixes for this release
please?
And features should go into next one ...

> V3:
> - fix compile errors
> - fix possible crash where cmd could be freed while adding it to
> completion list
> - fix issue where we added the worker thread to the blk cgroup but
> the blk IO was submitted by a driver workqueue.
> 
> V2:
> - fix use before set cpu var errors
> - drop vhost_vq_is_setup
> - include patches to do a worker thread per scsi IO vq
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
