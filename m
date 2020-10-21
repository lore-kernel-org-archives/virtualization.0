Return-Path: <SRS0=2FsC=D4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAFCC4363A
	for <virtualization@archiver.kernel.org>; Wed, 21 Oct 2020 20:14:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384862098B
	for <virtualization@archiver.kernel.org>; Wed, 21 Oct 2020 20:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQdCROdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384862098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A2C9087347;
	Wed, 21 Oct 2020 20:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SlCk-JbO8+ab; Wed, 21 Oct 2020 20:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2113D872E1;
	Wed, 21 Oct 2020 20:14:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3F4FC08A1;
	Wed, 21 Oct 2020 20:14:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6673FC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 20:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 499192F2A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 20:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jWeBOCPcyjcR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 20:14:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C53542EC46
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603291557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaMXT/y4BrbebVGe8E7alCrveFoprjBwvt8pmethQp0=;
 b=RQdCROdnAUJh+sPQFbvIOVQPoJDg5RI3t2AAfsOU0mSm96/tATUQCzqbEXh3kDoURcM3CT
 wPFHa2rd+xib+w/gwrQNMOXn50XjzZNce8Eb0Dz4tR+olzPNEEvHbfwepPYFIbpPVJ1GJI
 K5QnG9wZ2LcT+/ATB+9VzahBz3V2LnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-QbOWxe5gOm6-jglYJVbKgA-1; Wed, 21 Oct 2020 10:45:55 -0400
X-MC-Unique: QbOWxe5gOm6-jglYJVbKgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC7464162;
 Wed, 21 Oct 2020 14:45:53 +0000 (UTC)
Received: from redhat.com (ovpn-115-38.ams2.redhat.com [10.36.115.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C5F719930;
 Wed, 21 Oct 2020 14:45:47 +0000 (UTC)
Date: Wed, 21 Oct 2020 10:45:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/4] vDPA: API for reporting IOVA range
Message-ID: <20201021104508-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200617032947.6371-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

On Wed, Jun 17, 2020 at 11:29:43AM +0800, Jason Wang wrote:
> Hi All:
> 
> This series introduces API for reporing IOVA range. This is a must for
> userspace to work correclty:
> 
> - for the process that uses vhost-vDPA directly to properly allocate
>   IOVA
> - for VM(qemu), when vIOMMU is not enabled, fail early if GPA is out
>   of range
> - for VM(qemu), when vIOMMU is enabled, determine a valid guest
>   address width
> 
> Please review.
> 
> Thanks

OK so what is the plan here? Change begin-end->first-last and repost?

> Jason Wang (4):
>   vdpa: introduce config op to get valid iova range
>   vdpa_sim: implement get_iova_range bus operation
>   vdpa: get_iova_range() is mandatory for device specific DMA
>     translation
>   vhost: vdpa: report iova range
> 
>  drivers/vdpa/vdpa.c              |  4 ++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 +++++++++++
>  drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
>  include/linux/vdpa.h             | 14 ++++++++++++++
>  include/uapi/linux/vhost.h       |  4 ++++
>  include/uapi/linux/vhost_types.h |  5 +++++
>  6 files changed, 65 insertions(+)
> 
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
