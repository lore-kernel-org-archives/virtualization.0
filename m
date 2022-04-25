Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61471C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 14:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6671408BB;
	Mon, 25 Apr 2022 14:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 72C0WqI-MuKz; Mon, 25 Apr 2022 14:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 10D6C40866;
	Mon, 25 Apr 2022 14:05:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6905C0039;
	Mon, 25 Apr 2022 14:05:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D579CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9FC3605EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K5qGdKljkNeE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:05:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA364600C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650895505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=auigtvJ39UZ3RGxjn70hyOBkPz9Npiberg9KFWHx8Ck=;
 b=GejIUA5loAFX+HYYEW8uYv00GPT7tNJWO81u+kYne62U9KK2MNgFyFaWrEHzH8YLWeLtQb
 wECR3XzLPUYCATFc0EAUjhnZ+wsXAa5yEndFlBmriZ72eV3QmdOaMK8YsZ7QCl6Y1DYROS
 sHHzUXIKVQ1+kpzy2TstSsGyO/WsZSA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-_vNh202cNA6nZOby1fHK8w-1; Mon, 25 Apr 2022 10:05:02 -0400
X-MC-Unique: _vNh202cNA6nZOby1fHK8w-1
Received: by mail-wr1-f72.google.com with SMTP id
 l7-20020adfbd87000000b0020ac0a4d23dso2730991wrh.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 07:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=auigtvJ39UZ3RGxjn70hyOBkPz9Npiberg9KFWHx8Ck=;
 b=D4yM+uBph+yPjw4w7ih22qfyeQy3Bo0M7YhFLtCFCFDPYTk9rTOpcuVKKzyX5J9BSH
 OkoGCIDROYaSIOQdDcf5hw6B6e5LHfMZgi5V6J0ZguA5C7rkdm/k/3Nvet/biOKfBdvl
 9ku7BNi5tjNYUZwIKh4odgzA42mYCRQFbzUN9kwAdltoEfzpxaDlayPImJXYZQwhLOn+
 qHL6S9rzuqMuAQFkK5HtiYLaPIXT1yz37udpdVgeGLJwqG0+XbxnetDrDVmduWqMnYe6
 V5nUhBzACcYjU5mJliHoytl8olJfcgMzk2oILQKcusJF7DYF03pn8q6RJEyuEaLAeAiu
 UQdA==
X-Gm-Message-State: AOAM532fDNfEaYbX/qdiQthRe0zVYDeG3uA9fwsF1RIHH0R7sJWQHnSY
 XeMt0i1ikJoIGFmaXRnNR0RblUE5H4OKd+cias1QsOUE1zn1luKsXMDoEbrCDbE2Oqi0IllhvCK
 rGNdEggYEZCiIXTmfjFdgCRrRdgLIEpVBpOQgfK0p4w==
X-Received: by 2002:adf:d0d2:0:b0:20a:d81e:cb23 with SMTP id
 z18-20020adfd0d2000000b0020ad81ecb23mr6437477wrh.656.1650895500265; 
 Mon, 25 Apr 2022 07:05:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCz6CuikbFY26Mxyu8mBeQpSoKK4hfaQ9gqfvZaQNnpB1KRqoz4PAURcjtNTMbj2rWbOH+jw==
X-Received: by 2002:adf:d0d2:0:b0:20a:d81e:cb23 with SMTP id
 z18-20020adfd0d2000000b0020ad81ecb23mr6437447wrh.656.1650895500002; 
 Mon, 25 Apr 2022 07:05:00 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 k63-20020a1ca142000000b0038ff2c38e85sm8886223wme.39.2022.04.25.07.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 07:04:59 -0700 (PDT)
Date: Mon, 25 Apr 2022 10:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 7/9] virtio: allow to unbreak virtqueue
Message-ID: <20220425100349-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-8-jasowang@redhat.com>
 <87v8ux72p5.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87v8ux72p5.fsf@redhat.com>
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

On Mon, Apr 25, 2022 at 02:44:06PM +0200, Cornelia Huck wrote:
> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
> 
> > This patch allows the virtio_break_device() to accept a boolean value
> > then we can unbreak the virtqueue.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/char/virtio_console.c              | 2 +-
> >  drivers/crypto/virtio/virtio_crypto_core.c | 2 +-
> >  drivers/s390/virtio/virtio_ccw.c           | 4 ++--
> >  drivers/virtio/virtio_pci_common.c         | 2 +-
> >  drivers/virtio/virtio_ring.c               | 4 ++--
> >  include/linux/virtio.h                     | 2 +-
> >  6 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index e3c430539a17..afede977f7b3 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1958,7 +1958,7 @@ static void virtcons_remove(struct virtio_device *vdev)
> >  	spin_unlock_irq(&pdrvdata_lock);
> >  
> >  	/* Device is going away, exit any polling for buffers */
> > -	virtio_break_device(vdev);
> > +	virtio_break_device(vdev, true);
> >  	if (use_multiport(portdev))
> >  		flush_work(&portdev->control_work);
> >  	else
> > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> > index c6f482db0bc0..fd17f3f2e958 100644
> > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > @@ -215,7 +215,7 @@ static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
> >  		dev_warn(&vcrypto->vdev->dev,
> >  				"Unknown status bits: 0x%x\n", status);
> >  
> > -		virtio_break_device(vcrypto->vdev);
> > +		virtio_break_device(vcrypto->vdev, true);
> >  		return -EPERM;
> >  	}
> >  
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index c19f07a82d62..9a963f5af5b5 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1211,7 +1211,7 @@ static void virtio_ccw_remove(struct ccw_device *cdev)
> >  
> >  	if (vcdev && cdev->online) {
> >  		if (vcdev->device_lost)
> > -			virtio_break_device(&vcdev->vdev);
> > +			virtio_break_device(&vcdev->vdev, true);
> >  		unregister_virtio_device(&vcdev->vdev);
> >  		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> >  		dev_set_drvdata(&cdev->dev, NULL);
> > @@ -1228,7 +1228,7 @@ static int virtio_ccw_offline(struct ccw_device *cdev)
> >  	if (!vcdev)
> >  		return 0;
> >  	if (vcdev->device_lost)
> > -		virtio_break_device(&vcdev->vdev);
> > +		virtio_break_device(&vcdev->vdev, true);
> >  	unregister_virtio_device(&vcdev->vdev);
> >  	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> >  	dev_set_drvdata(&cdev->dev, NULL);
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index d724f676608b..39a711ddff30 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -583,7 +583,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
> >  	 * layers can abort any ongoing operation.
> >  	 */
> >  	if (!pci_device_is_present(pci_dev))
> > -		virtio_break_device(&vp_dev->vdev);
> > +		virtio_break_device(&vp_dev->vdev, true);
> >  
> >  	pci_disable_sriov(pci_dev);
> >  
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cfb028ca238e..6da13495a70c 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2382,7 +2382,7 @@ EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> >   * This should prevent the device from being used, allowing drivers to
> >   * recover.  You may need to grab appropriate locks to flush.
> >   */
> > -void virtio_break_device(struct virtio_device *dev)
> > +void virtio_break_device(struct virtio_device *dev, bool broken)
> 
> I think we need to be careful to say when it is safe to unset 'broken'.
> 
> The current callers set all queues to broken in case of surprise removal
> (ccw, pci), removal (console), or the device behaving badly
> (crypto). There's also code setting individual queues to broken. We do
> not want to undo any of these, unless the device has gone through a
> reset in the meanwhile. Maybe add:
> 
> "It is only safe to call this function to *remove* the broken flag for a
> device that is (re)transitioning to becoming usable; calling it that way
> during normal usage may have unpredictable consequences."
> 
> (Not sure how to word this; especially if we consider future usage of
> queue reset.)


Right. I would prefer __virtio_unbreak_device or something similar
with a bit comment explaining it's only safe to call during probe.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
