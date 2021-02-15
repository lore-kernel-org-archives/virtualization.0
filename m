Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E60CC433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:47:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141EB64DE0
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141EB64DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC5926F571
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vCFxeIPjwgHF for <virtualization@archiver.kernel.org>;
	Mon, 15 Feb 2021 11:47:18 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 5275A6F527; Mon, 15 Feb 2021 11:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 272E96F499;
	Mon, 15 Feb 2021 11:47:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 012D4C0174;
	Mon, 15 Feb 2021 11:47:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51C48C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 318286F499
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bIkePvOm27_c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:47:12 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 40DBA6F509; Mon, 15 Feb 2021 11:47:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C877B6F499
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613389629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D22s3OuQqHDBBIq03XJttdJ4KRGjRR6pC+JhDOVlOkU=;
 b=TDGsJ949jBseFKP6fQWYQ4ItTPjlLEjEIGJDLqcu0Cz2Slrwe3v6VgGGLttz1c9tgzXtPd
 z3tvnrSpcne4eKhEVvGOWuNQUz4VZ4/bgzHrbYTQUt0CNgkTXHyYa2I6PLlX8a6fRhUP6n
 NttjlsewznBQrxxnc7C/M8PNlcbpvMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-sJoUwJx-PS2WINi8H1HfSw-1; Mon, 15 Feb 2021 06:47:07 -0500
X-MC-Unique: sJoUwJx-PS2WINi8H1HfSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44288100CCC1;
 Mon, 15 Feb 2021 11:47:06 +0000 (UTC)
Received: from gondolin (ovpn-113-55.ams2.redhat.com [10.36.113.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDBD75C3F8;
 Mon, 15 Feb 2021 11:47:04 +0000 (UTC)
Date: Mon, 15 Feb 2021 12:47:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio/s390: implement virtio-ccw revision 2 correctly
Message-ID: <20210215124702.23a093b8.cohuck@redhat.com>
In-Reply-To: <20210212170411.992217-1-cohuck@redhat.com>
References: <20210212170411.992217-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 Pierre Morel <pmorel@linux.ibm.com>, virtualization@lists.linux-foundation.org
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

On Fri, 12 Feb 2021 18:04:11 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> CCW_CMD_READ_STATUS was introduced with revision 2 of virtio-ccw,
> and drivers should only rely on it being implemented when they
> negotiated at least that revision with the device.
> 
> However, virtio_ccw_get_status() issued READ_STATUS for any
> device operating at least at revision 1. If the device accepts
> READ_STATUS regardless of the negotiated revision (which it is
> free to do),

So, looking at the standard again, the device is actually required to
reject the READ_STATUS if only rev 1 had been negotiated... regardless
of that, I don't think we should change QEMU's behaviour, as it would
affect existing guests (they would lose access to the status bits as
observed by the device, including DEVICE_NEEDS_RESET.)

> everything works as intended; a device rejecting the
> command should also be handled gracefully. For correctness, we
> should really limit the command to revision 2 or higher, though.
> 
> We also negotiated the revision to at most 1, as we never bumped
> the maximum revision; let's do that now.
> 
> Fixes: 7d3ce5ab9430 ("virtio/s390: support READ_STATUS command for virtio-ccw")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> QEMU does not fence off READ_STATUS for revisions < 2, which is probably
> why we never noticed this. I'm not aware of other hypervisors that do
> fence it off, nor any that cannot deal properly with an unknown command.
> 
> Not sure whether this is stable worthy?

Maybe it is, given the MUST reject clause in the standard?

> 
> ---
>  drivers/s390/virtio/virtio_ccw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 5730572b52cd..54e686dca6de 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -117,7 +117,7 @@ struct virtio_rev_info {
>  };
>  
>  /* the highest virtio-ccw revision we support */
> -#define VIRTIO_CCW_REV_MAX 1
> +#define VIRTIO_CCW_REV_MAX 2
>  
>  struct virtio_ccw_vq_info {
>  	struct virtqueue *vq;
> @@ -952,7 +952,7 @@ static u8 virtio_ccw_get_status(struct virtio_device *vdev)
>  	u8 old_status = vcdev->dma_area->status;
>  	struct ccw1 *ccw;
>  
> -	if (vcdev->revision < 1)
> +	if (vcdev->revision < 2)
>  		return vcdev->dma_area->status;
>  
>  	ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
