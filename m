Return-Path: <SRS0=bMq5=D5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A9C388F7
	for <virtualization@archiver.kernel.org>; Thu, 22 Oct 2020 11:39:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C368B2225F
	for <virtualization@archiver.kernel.org>; Thu, 22 Oct 2020 11:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnmHD+fV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368B2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DEE018770F;
	Thu, 22 Oct 2020 11:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p++otudR0NfL; Thu, 22 Oct 2020 11:39:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 381E7876EA;
	Thu, 22 Oct 2020 11:39:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F302EC08A1;
	Thu, 22 Oct 2020 11:39:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 494DCC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 11:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2CB1D86FC3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 11:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pC6wqFOJ5A81
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 11:39:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6646586FB4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 11:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603366786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZRAzvWGnqOcu84OUW1zyrA59z2EZvx932OzAy2Eq8g=;
 b=RnmHD+fVz2yLbj7ZdO0v67K0r7bggqrg2m3D4qe5WR6TN/H9WF9GbwJwVj4cWYqeZYGsKp
 ltUOkTdPRxN2y0Igu4EskMZSextKmSapMYQgpch3rcO750vwAK1L419Olaq428htFPuudl
 1DuRSDf2PXguAQNSm1a90XqI0/wd2Eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-bjaigFZkOayCvBA3P2EFRA-1; Thu, 22 Oct 2020 07:39:44 -0400
X-MC-Unique: bjaigFZkOayCvBA3P2EFRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C0791006C9F;
 Thu, 22 Oct 2020 11:39:43 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B45F5B4A8;
 Thu, 22 Oct 2020 11:39:41 +0000 (UTC)
Date: Thu, 22 Oct 2020 07:39:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Hofmann <sebastian@kaemmelot.de>
Subject: Re: [PATCH] virtio_ring: use DMA when memory encryption is active
Message-ID: <20201022073716-mutt-send-email-mst@kernel.org>
References: <1075010014.50900.1603293266000@office.mailbox.org>
MIME-Version: 1.0
In-Reply-To: <1075010014.50900.1603293266000@office.mailbox.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Wed, Oct 21, 2020 at 05:14:25PM +0200, Sebastian Hofmann wrote:
> virtio_ring does not work with active memory encryption because the host cannot read it. Fix this by enforcing the use of DMA which uses shared (unencrypted) memory pages.
> 
> Signed-off-by: Sebastian Hofmann <sebastian@kaemmelot.de>


Sorry, no.
host which can not access all of driver memory must set VIRTIO_F_ACCESS_PLATFORM.

Not worth it to work around broken hosts.

Xen is an exception we carry around since it predates the
introduction of VIRTIO_F_ACCESS_PLATFORM.


> ---
>  drivers/virtio/virtio_ring.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index becc77697960..8c68c475ec21 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -12,6 +12,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
>  #include <xen/xen.h>
> +#include <linux/mem_encrypt.h>
>  
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
> @@ -255,6 +256,10 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	if (xen_domain())
>  		return true;
>  
> +	/* Memory encryption requires DMA */
> +	if (mem_encrypt_active())
> +		return true;
> +
>  	return false;
>  }
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
