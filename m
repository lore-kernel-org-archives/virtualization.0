Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AF35F180
	for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777129853; cv=none; b=QDdVoavol4mpSqEebPQ8/JZay1Y5JvkfS/nIyVsQFUXngWFCxbsOr4/eHQiHyGJi7L5wuNb3KIeqQNyBv2SLCA0HZIpoKxjjn6S8p5s1qFEz4agI+whfOQ5EI13iuZ3masgJ0F/RtzSOV+GFaM543AX+X1QmEiQ4A9OOY8KiBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777129853; c=relaxed/simple;
	bh=7OmRKB5lte2dq7kRW48MLu51Z2dEntMVGgXISah2S/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R+QZmAx4m5AL+RuBg9cJpT9A7UITJoMl8vwhklGgKQUxbNiGwKqadZVhhDk3VKgxciYYwtvzIEQfcSMZOcOFSM2pJErew0aZS7arozJTp5rqKxx+PnEEmKJ9tLqTlGfgmpct3xDL7qahaLcZ6zD4VeEds8yo9klwJ6nyNbZ5rGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOZFgIfV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOZFgIfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777129849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ferbHEmpI+lNfISIiYNW9cZesuyd3hPcOYBw4/4sikc=;
	b=cOZFgIfV5KwUs7gwF0P9LfaTA20yjWanjhkgXurKvqnzO20xnYEnxonQBKwLJVfE+HOn2d
	8QcMcMy7BPVoKRi6IsCaVMqper/vxmiU9DLW81pwv7b023j4cx0ky0kcfoGHAqjy52XSku
	Pf/j8C9A4isrFTLevS1HfPY4nu57HP8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-qPDLz-daPvyRC9BM84YUJQ-1; Sat, 25 Apr 2026 11:10:48 -0400
X-MC-Unique: qPDLz-daPvyRC9BM84YUJQ-1
X-Mimecast-MFC-AGG-ID: qPDLz-daPvyRC9BM84YUJQ_1777129847
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso72358465e9.3
        for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 08:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777129847; x=1777734647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ferbHEmpI+lNfISIiYNW9cZesuyd3hPcOYBw4/4sikc=;
        b=hI+Xboj6QyEilbl/41Q6P7HWIDlw8M1iVLdtsZEU+0vTfMOyfA+znDmMbsX5RuR4uq
         x5KRImo9rV38+hgnm3MpftMoT0QP4sIHKNPwNCzjvj64BTaUzA46VsdURS/+RY08x63U
         bIlmg/k9sAbxLg8dGvHlHy07USYt48l8+e9pjNAjOLQNxyTOSspI3NVS1lOKjHD7AoLD
         yggi3SfR6OXQg4UGJemaJVJSZXAaqpzEQMBGnIXFKajF60l3p76kzxBl/UdFsIcdjGmY
         KA1cU0iyAuST1KGgZZc0rWHeVYSpgladnj9Z4qC0GRHnyL6VJwiOWDEHpvmpV6tUv5+v
         0/Mg==
X-Forwarded-Encrypted: i=1; AFNElJ/uMSezbefGoCPPZ+11FXOb9OepE6XWg6TTUQNlUJlZfrPZ2d9s3rZhl/Ww9bXZIvLd2KXTbnoYcMfjjJ/msQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS3Hze+CEvGnWxL2d9mr91QhpKSlux7CqNZSabtTJbWPSktk7b
	xiZXptXssJsdLOrt9L4KwYTCfJnlm1CtyvWUq8Vt2S2NdbpnM176f1oPI1rcR8bshdpIueWBK3E
	EYV8oVx7WseA8Q0W5fG6fHrgekaK7IS3iFKR6Jl82mLspOccljUj8283wY437qKLXA1Hw
X-Gm-Gg: AeBDiesEXyglB8ghMdfPBMtXPbu+KYuWgQdUvek2NIaT1VtbKF1MaUuUY/cpA8nLu9f
	ekQZQIZCruzVrp5AcAxwCgPXonjHfSIIqtzagUW4AduM2v1r4QtPMLAUbQlUtxemqd3do6LnMf1
	8/gh8VodX9XUnsC+vG/4QHpVuAW4vRpAjxqzQY6W0QIiXvFFHNq0ku7kAmUdg1QWbpd9M/JC28Z
	793L9J5X0R2tWFu4IOLBcjhgRTdrnlTeRzE8uSOxVFPZR+S/vl9N4Q0eIx/y7x1/dV88KFHBaH9
	mdfLyX0RXpu9+eNjYbrApdJCT14hL60jwh+FtGwaQvJesJdH3rVoj2GlLkOJao28GDVFMGfask5
	5B1MC+WEtXKTD25bk1c67mEpn
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr375230885e9.11.1777129847297;
        Sat, 25 Apr 2026 08:10:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr375230665e9.11.1777129846820;
        Sat, 25 Apr 2026 08:10:46 -0700 (PDT)
Received: from redhat.com ([147.235.221.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm242530465e9.22.2026.04.25.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 08:10:46 -0700 (PDT)
Date: Sat, 25 Apr 2026 11:10:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: physicalmtea <physicalmtea@gmail.com>
Cc: Peter Hilber <peter.hilber@oss.qualcomm.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio: rtc: tear down old virtqueues before restore
Message-ID: <20260425110857-mutt-send-email-mst@kernel.org>
References: <d2gtdzjz3bfs47rmeslo46dkwmjqpv2qjcxmpgbkcbxjrqbf6m@bkeeynnavvy3>
 <20260425070840.488634-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260425070840.488634-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7HhUPmWeCI8RLHOFpzvo-ZmFB3GS3wNPDabkBP5riKk_1777129847
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 25, 2026 at 03:08:40PM +0800, physicalmtea wrote:
> From: JiaJia <physicalmtea@gmail.com>
> 
> virtio_device_restore() resets the device and restores the negotiated
> features before calling ->restore(). viortc_freeze() intentionally
> leaves the existing virtqueues in place so the alarm queue can still
> wake the system, but viortc_restore() immediately calls
> viortc_init_vqs() without first deleting those old queues.
> 
> If virtqueue reinitialization fails on virtio-pci, the transport error
> path can run vp_del_vqs() against a newly allocated vp_dev->vqs array
> while vdev->vqs still contains the old virtqueues. vp_del_vqs() then
> looks up queue state through the new array and can dereference a NULL
> info pointer in vp_del_vq(), crashing the guest kernel during restore.
> 
> This can also happen during a non-faulty reinitialization, when one of
> the vp_find_vqs_msix() attempts is unsuccessful before a later attempt
> would succeed.
> 
> Delete the stale virtqueues before rebuilding them. If restore fails
> before virtio_device_ready(), reuse the remove path to stop the device.
> Once the device is ready, return errors directly instead of deleting the
> virtqueues again.
> 
> Fixes: 0623c7592768 ("virtio_rtc: Add module and driver core")
> Signed-off-by: JiaJia <physicalmtea@gmail.com>

Sorry is this just the 1st name or the 1st and the last name?
I think it's preferred to have the full name here.


> Reviewed-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
> ---
> v3:
>   - Add Fixes tag.
>   - Add Peter's Reviewed-by tag.
>   - Clarify commit message regarding reinitialization scenarios.
> 
> Apologies for missing the Fixes tag, and thanks for catching that! 
> I've also updated the commit message to include the scenario you 
> mentioned.
> 
>  drivers/virtio/virtio_rtc_driver.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
> index a57d5e06e..4419735b0 100644
> --- a/drivers/virtio/virtio_rtc_driver.c
> +++ b/drivers/virtio/virtio_rtc_driver.c
> @@ -1257,6 +1257,15 @@ static int viortc_init_vqs(struct viortc_dev *viortc)
>  	return 0;
>  }
>  
> +static void __viortc_remove(struct viortc_dev *viortc)
> +{
> +	struct virtio_device *vdev = viortc->vdev;
> +
> +	viortc_clocks_deinit(viortc);
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> +}
> +
>  /**
>   * viortc_probe() - probe a virtio_rtc virtio device
>   * @vdev: virtio device
> @@ -1282,7 +1291,7 @@ static int viortc_probe(struct virtio_device *vdev)
>  
>  	ret = viortc_init_vqs(viortc);
>  	if (ret)
> -		return ret;
> +		goto err_reset_vdev;
>  
>  	virtio_device_ready(vdev);
>  
> @@ -1329,10 +1338,7 @@ static void viortc_remove(struct virtio_device *vdev)
>  {
>  	struct viortc_dev *viortc = vdev->priv;
>  
> -	viortc_clocks_deinit(viortc);
> -
> -	virtio_reset_device(vdev);
> -	vdev->config->del_vqs(vdev);
> +	__viortc_remove(viortc);
>  }
>  
>  static int viortc_freeze(struct virtio_device *dev)
> @@ -1353,9 +1359,11 @@ static int viortc_restore(struct virtio_device *dev)
>  	bool notify = false;
>  	int ret;
>  
> +	dev->config->del_vqs(dev);
> +
>  	ret = viortc_init_vqs(viortc);
>  	if (ret)
> -		return ret;
> +		goto err_remove;
>  
>  	alarm_viortc_vq = &viortc->vqs[VIORTC_ALARMQ];
>  	alarm_vq = alarm_viortc_vq->vq;
> @@ -1364,7 +1372,7 @@ static int viortc_restore(struct virtio_device *dev)
>  		ret = viortc_populate_vq(viortc, alarm_viortc_vq,
>  					 VIORTC_ALARMQ_BUF_CAP, false);
>  		if (ret)
> -			return ret;
> +			goto err_remove;
>  
>  		notify = virtqueue_kick_prepare(alarm_vq);
>  	}
> @@ -1372,8 +1380,12 @@ static int viortc_restore(struct virtio_device *dev)
>  	virtio_device_ready(dev);
>  
>  	if (notify && !virtqueue_notify(alarm_vq))
> -		ret = -EIO;
> +		return -EIO;
> +
> +	return 0;
>  
> +err_remove:
> +	__viortc_remove(viortc);
>  	return ret;
>  }
>  
> -- 
> 2.34.1

