Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016F5C4363A
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:46:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D4D221F9
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6Q2K2y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D4D221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A9CF873F2;
	Fri, 23 Oct 2020 15:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fx4ekFdZ47Jb; Fri, 23 Oct 2020 15:46:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 236AC873E4;
	Fri, 23 Oct 2020 15:46:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4122C088B;
	Fri, 23 Oct 2020 15:46:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0268C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8DE262107D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hanWlgfTX9S5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:46:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id F30722036E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pg4PolbChlXgMcboLrdK2mDe5zthtIw6r01+hUXbyGQ=;
 b=U6Q2K2y30BItcJ6xIKDa/vjJXtMeQvmm2eBznMxZAtS0L9blVPAefHpaxjHvjw0ftTVykX
 6IZWb17EtUTXqT31uC0srTrjZhyzd0RhCaSmlUyQkK8Jom7cMV8aA1ef3UMOJVktH/wtaE
 jdtadiz5TaMi/yBZsY6uULEVjmNc3Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-yIHxag6FPu-p4AJKr68Zsg-1; Fri, 23 Oct 2020 11:46:18 -0400
X-MC-Unique: yIHxag6FPu-p4AJKr68Zsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F40C1891E82;
 Fri, 23 Oct 2020 15:46:17 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C51C45D9CC;
 Fri, 23 Oct 2020 15:46:11 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:46:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 00/16 V2] vhost: fix scsi cmd handling and IOPs
Message-ID: <20201023114539-mutt-send-email-mst@kernel.org>
References: <1602104101-5592-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1602104101-5592-1-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Wed, Oct 07, 2020 at 03:54:45PM -0500, Mike Christie wrote:
> The following patches were made over Michael's vhost branch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=vhost
>  
> The patches also apply to Linus's or Martin's trees if you apply
> https://patchwork.kernel.org/patch/11790681/
> which was merged into mst's tree already.
> 
> The following patches are a follow up to this post:
> https://patchwork.kernel.org/cover/11790763/
> which originally was fixing how vhost-scsi handled cmds so we would
> not get IO errors when sending more than 256 cmds.
> 
> In that patchset I needed to detect if a vq was in use and for this
> patch:
> https://patchwork.kernel.org/patch/11790685/
> it was suggested to add support for VHOST_RING_ENABLE. While doing
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
> 
> Note that in this posting I am also including additional patches
> that create multiple vhost worker threads, because I wanted to see
> if people felt that maybe to support that and for this enablement
> issue we want a completely a new ioctl.
> 
> 
> V2:
> - fix use before set cpu var errors
> - drop vhost_vq_is_setup
> - include patches to do a worker thread per scsi IO vq

Stefan, Paolo, Jason any input?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
