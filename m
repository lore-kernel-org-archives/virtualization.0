Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30F6C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 08:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BD4360B5D;
	Wed, 22 Jun 2022 08:32:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BD4360B5D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NxbF1xGA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EoJWrDRLSPLx; Wed, 22 Jun 2022 08:32:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9E6660BB4;
	Wed, 22 Jun 2022 08:32:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9E6660BB4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC748C0039;
	Wed, 22 Jun 2022 08:32:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7563AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 577D760BB4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:32:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 577D760BB4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gazKbNTILPDf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:32:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DCDC60B5D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DCDC60B5D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655886763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kbGRJbqhqaDpYURUd1iIYFpog7R3QIPoGbLyON7y9kw=;
 b=NxbF1xGA74jrkn6kNR3sV3M8u+EmpVZUrKaIxrXs8tDpmNdGwq+legna7k6HhnNyrATm9Z
 H/mVEujZxp9k49ZW9SdKU12+BLMD76CjS5b/V/SlhMJSYjGF3Zo+iZYRTr3+4MTWnXxQzr
 Qw3gKRoc2yviJgDE47aRNgcLObYEXts=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-iNEYmxvyPGeSc7eIoTibxA-1; Wed, 22 Jun 2022 04:32:29 -0400
X-MC-Unique: iNEYmxvyPGeSc7eIoTibxA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54B5F1C04B49;
 Wed, 22 Jun 2022 08:32:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC7EA40C5BF;
 Wed, 22 Jun 2022 08:32:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, pasic@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
 agordeev@linux.ibm.com, mst@redhat.com, jasowang@redhat.com,
 linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
In-Reply-To: <20220622012940.21441-1-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220622012940.21441-1-jasowang@redhat.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date: Wed, 22 Jun 2022 10:32:26 +0200
Message-ID: <87h74d85et.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: ben@decadent.org.uk
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

On Wed, Jun 22 2022, Jason Wang <jasowang@redhat.com> wrote:

> We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> harden vring IRQ"). It works with the assumption that the driver or
> core can properly call virtio_device_ready() at the right
> place. Unfortunately, this seems to be not true and uncover various
> bugs of the existing drivers, mainly the issue of using
> virtio_device_ready() incorrectly.
>
> So let's having a Kconfig option and disable it by default. It gives

s/having/have/

> us a breath to fix the drivers and then we can consider to enable it
> by default.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V2:
> - Tweak the Kconfig help
> - Add comment for the read_lock() pairing in virtio_ccw
> ---
>  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
>  drivers/virtio/Kconfig           | 13 +++++++++++++
>  drivers/virtio/virtio.c          |  2 ++
>  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
>  include/linux/virtio_config.h    |  2 ++
>  5 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 97e51c34e6cf..1f6a358f65f0 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  			vcdev->err = -EIO;
>  	}
>  	virtio_ccw_check_activity(vcdev, activity);
> -	/* Interrupts are disabled here */
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> +	/*
> +	 * Paried with virtio_ccw_synchronize_cbs() and interrupts are

s/Paried/Paired/

> +	 * disabled here.
> +	 */
>  	read_lock(&vcdev->irq_lock);
> +#endif
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */
> @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	read_unlock(&vcdev->irq_lock);
> +#endif
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));


Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
