Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C809C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 14:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE63281301;
	Mon, 25 Apr 2022 14:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ButgjTEN3OlS; Mon, 25 Apr 2022 14:00:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C21A81762;
	Mon, 25 Apr 2022 14:00:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2451CC0039;
	Mon, 25 Apr 2022 14:00:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A111C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70E49605EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3okxD796cWuQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:00:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1FF1605B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650895205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCRBXICKlc3ggtUyIrchkbmub7vl/ize3vbtxq1kFlQ=;
 b=MQ3086G3QCZWSDJVYMXzoywbNKlcGpEchNFLxXgIdzyaTZdfiYNoh8EA9IvTx6uIyy0kfQ
 JYCJQD/U4Eskq7nhz8QB9Ccmwi4CWbqQ9h+KnYIDvkKu3/q3ZVFDLrRJA3eqIwtSTo7gfN
 7NQTqHlOy1eIe8fNSahLKAGWaUXUpC4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-7CYGWJM0N7GRgjuAK_m0jg-1; Mon, 25 Apr 2022 10:00:01 -0400
X-MC-Unique: 7CYGWJM0N7GRgjuAK_m0jg-1
Received: by mail-wm1-f70.google.com with SMTP id
 i131-20020a1c3b89000000b00392b57fbdaaso6810194wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 07:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LCRBXICKlc3ggtUyIrchkbmub7vl/ize3vbtxq1kFlQ=;
 b=N85Vv+WD8Z6DKtw02qIQ+UCTlBRHzU6zEQdEAgNCxsZ5zyuIVW3CHX2RNd4wWUeqgN
 Abs+I06sWOQaMwAshBEytloFxvRkqcWi1tdFbcOM6iu1MJ7cZfqW+K4b8BVk2eUoKn3V
 Smjyi1nnucnWUjsUqKZDy1kIh4UWNIG611INp3nzidER/ZEwsmFDZZe7J6MCjKaLXNL+
 +pP71aWA+pyULXDMU0TcxOLxxUX3Vf8n90Q7OvsHAAGsDI/RrhI9cuPJHQuGiUH9ktZ2
 qA67LUA4fSH2RYyaJQ3J74+auqkl2JPIeXJ8mckBPGmjJAzZlzvDbTDotpctg/NVdWHD
 XrsA==
X-Gm-Message-State: AOAM530Pk+ZO6w8NGCKM2jU+kqhF9BtU2U8IBmGaqoLA0R8z9Lf1OTop
 JabYPIe+1eTBLvjRH7X9V7Ki4VwywOwbevTPoeOFZKIhGFvR6SbEDiLZbA+2r+P1268BkhbiaVr
 cPgse/jA+6nJ78Q3ryN8w3tm6nuSJsniM6vkkqaZpuQ==
X-Received: by 2002:a5d:53c1:0:b0:20a:db5d:2590 with SMTP id
 a1-20020a5d53c1000000b0020adb5d2590mr4313872wrw.411.1650895200453; 
 Mon, 25 Apr 2022 07:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4bxERd0FIVUxXcZBmcfh1BwLDZLpCr0yUyxle6hvnT6hbY5zk1PQnWmI1tP1BOBTSqRDMWQ==
X-Received: by 2002:a5d:53c1:0:b0:20a:db5d:2590 with SMTP id
 a1-20020a5d53c1000000b0020adb5d2590mr4313858wrw.411.1650895200199; 
 Mon, 25 Apr 2022 07:00:00 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 a2-20020a056000188200b0020aa2581c7fsm10015485wri.104.2022.04.25.06.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 06:59:59 -0700 (PDT)
Date: Mon, 25 Apr 2022 09:59:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425095742-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87a6c98rwf.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eperezma@redhat.com, tglx@linutronix.de
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

On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> >> This patch tries to implement the synchronize_cbs() for ccw. For the
> >> vring_interrupt() that is called via virtio_airq_handler(), the
> >> synchronization is simply done via the airq_info's lock. For the
> >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> >> device spinlock for irq is introduced ans used in the synchronization
> >> method.
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Halil Pasic <pasic@linux.ibm.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > This is the only one that is giving me pause. Halil, Cornelia,
> > should we be concerned about the performance impact here?
> > Any chance it can be tested?
> 
> We can have a bunch of devices using the same airq structure, and the
> sync cb creates a choke point, same as registering/unregistering.

BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
this patch serializes them on a spinlock.

> If
> invoking the sync cb is a rare operation (same as (un)registering), it
> should not affect interrupt processing for other devices too much, but
> it really should be rare.
> 
> For testing, you would probably want to use a setup with many devices
> that share the same airq area (you can fit a lot of devices if they have
> few queues), generate traffic on the queues, and then do something that
> triggers the callback (adding/removing a new device in a loop?)
> 
> I currently don't have such a setup handy; Halil, would you be able to
> test that?
> 
> >
> >> ---
> >>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >> 
> >> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> >> index d35e7a3f7067..c19f07a82d62 100644
> >> --- a/drivers/s390/virtio/virtio_ccw.c
> >> +++ b/drivers/s390/virtio/virtio_ccw.c
> >> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >>  	unsigned int revision; /* Transport revision */
> >>  	wait_queue_head_t wait_q;
> >>  	spinlock_t lock;
> >> +	spinlock_t irq_lock;
> >>  	struct mutex io_lock; /* Serializes I/O requests */
> >>  	struct list_head virtqueues;
> >>  	bool is_thinint;
> >> @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
> >>  	return dev_name(&vcdev->cdev->dev);
> >>  }
> >>  
> >> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> >> +	struct airq_info *info = vcdev->airq_info;
> >> +
> >> +	/*
> >> +	 * Synchronize with the vring_interrupt() called by
> >> +	 * virtio_ccw_int_handler().
> >> +	 */
> >> +	spin_lock(&vcdev->irq_lock);
> >> +	spin_unlock(&vcdev->irq_lock);
> >> +
> >> +	if (info) {
> >> +		/*
> >> +		 * Synchronize with the vring_interrupt() with airq indicator
> >> +		 */
> >> +		write_lock(&info->lock);
> >> +		write_unlock(&info->lock);
> >> +	}
> 
> I think we can make this an either/or operation (devices will either use
> classic interrupts or adapter interrupts)?
> 
> >> +}
> >> +
> >>  static const struct virtio_config_ops virtio_ccw_config_ops = {
> >>  	.get_features = virtio_ccw_get_features,
> >>  	.finalize_features = virtio_ccw_finalize_features,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
