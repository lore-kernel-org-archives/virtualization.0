Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7597BC433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 15:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13E74418DE;
	Wed,  6 Apr 2022 15:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TIOhL0PbUHid; Wed,  6 Apr 2022 15:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 592134004F;
	Wed,  6 Apr 2022 15:31:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC37C001D;
	Wed,  6 Apr 2022 15:31:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FFACC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 15:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F18B40183
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 15:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dxzyfGqL2moJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 15:31:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2D8A4004F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649259086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXqsmr5lOmq1DC0O01EgBHNJ75YfihYQ9afQo8lccGQ=;
 b=TZq4ajl5Qj9CFq1SOFgMmgLLV2hlFvybOXtVkgh+q4r0y+xruxvNgNy+5zQhyzexPyT8iu
 3WFlZnjdw6zHGhYBKVsVpMVFVYbSTlaLOCHhknhca6iiDD9P7PjKkfyAt56D86KZujEXnV
 1I/megxU+RCHn3q4MOt4pTqV+qz40NI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-MTyg56JpPL-zElOIDGYHBg-1; Wed, 06 Apr 2022 11:31:25 -0400
X-MC-Unique: MTyg56JpPL-zElOIDGYHBg-1
Received: by mail-wm1-f70.google.com with SMTP id
 v191-20020a1cacc8000000b0038ce818d2efso764420wme.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SXqsmr5lOmq1DC0O01EgBHNJ75YfihYQ9afQo8lccGQ=;
 b=HFkgtLa54YAQVHwzIDuBDGIVvrMIsdcs4/x4+xL/MfIlim7z1T2rg5hKLlfU9QNDl1
 4K1DD7hVhLHHQtb83fCXEQVc/CVLDUwh4jomfdc/IYs1miAUDPH79+kGr/d2x6rIoUCC
 EjbGR32yuRXyoA5kue9CF1dI7jC87x4auCSD+PWu11FpHbO5LLbU3sJHNKUsIOQS41RJ
 Z7pW/+Ide5kSu/NGusE4ajhMuMoQGk9x5l5g2qEgnWb2eLuChXXNCCt+yMK7s0Wd/3zz
 FGqqapLuIjAxT0kOV7/iFICAutdP1n+gatnAvKXMETEq5GxUUxAn5Fea88WVO4MDA/Ue
 iIkw==
X-Gm-Message-State: AOAM531AGiLoHLstqEVD1yIUva2WOB4c/VMs1rKIgMxi5KA145HIpbk1
 a0sxNtYcYFGbddxEIeQ83q+Aw7iOFn4SgkvL+Joha39wibAfPs+8Oqp5f32N9zCC6aAxxrQG4O7
 n3E0yaByuBiUhtAk43Xkz1oQo+Kx/8/ZkynNMwerydQ==
X-Received: by 2002:a05:600c:3511:b0:38c:d035:cddb with SMTP id
 h17-20020a05600c351100b0038cd035cddbmr8039414wmq.74.1649259084177; 
 Wed, 06 Apr 2022 08:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMJUIuOfCAWCV1KjhYntMj29VSsQUoSZ2t6duktlX1OxSHrnPzc0hHgltLl0oDc5ne7fB2BQ==
X-Received: by 2002:a05:600c:3511:b0:38c:d035:cddb with SMTP id
 h17-20020a05600c351100b0038cd035cddbmr8039392wmq.74.1649259083924; 
 Wed, 06 Apr 2022 08:31:23 -0700 (PDT)
Received: from redhat.com ([2.55.156.253]) by smtp.gmail.com with ESMTPSA id
 14-20020a056000154e00b00203f8adde0csm18525600wry.32.2022.04.06.08.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 08:31:22 -0700 (PDT)
Date: Wed, 6 Apr 2022 11:31:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220406112858-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87wng2e527.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 tglx@linutronix.de
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

On Wed, Apr 06, 2022 at 03:04:32PM +0200, Cornelia Huck wrote:
> On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> >> This patch implements PCI version of synchronize_vqs().
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Please add implementations at least for ccw and mmio.
> 
> I'm not sure what (if anything) can/should be done for ccw...
> 
> >
> >> ---
> >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> >>  drivers/virtio/virtio_pci_common.h |  2 ++
> >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> >>  4 files changed, 19 insertions(+)
> >> 
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index d724f676608b..b78c8bc93a97 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>  }
> >>  
> >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> +	int i;
> >> +
> >> +	if (vp_dev->intx_enabled) {
> >> +		synchronize_irq(vp_dev->pci_dev->irq);
> >> +		return;
> >> +	}
> >> +
> >> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> >> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >> +}
> >> +
> 
> ...given that this seems to synchronize threaded interrupt handlers?

No, any handlers at all. The point is to make sure any memory changes
made prior to this op are visible to callbacks.

Jason, maybe add that to the documentation?

> Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> 'irq' for channel devices anyway, and the handler just calls the
> relevant callbacks directly.)

Then you need to synchronize with that.

> >>  /* the notify function used when creating a virt queue */
> >>  bool vp_notify(struct virtqueue *vq)
> >>  {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
