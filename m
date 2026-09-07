Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B2346AFD
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817577; cv=none; b=h0Zdr3gjROvFknhGgrHTeTcnSzhHB74EJTPz7/0Ni7ZqDgaC1IWTC71sqq86dezSufqMlK4YkV8EMlC0N14cl8KRzVtDcTMU069LcivC+VatEoMRfi9OhLdZwXy45bY5UI8g6VNV6pQ9e0v/IuDg0PP9MM1+FPXX5vEp0ppctM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817577; c=relaxed/simple;
	bh=BjK9vT7j+uUDxOu31cZD0dg87r12JRq28IJVMhS7if4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XnxZ9WuYpHVp7gC+V1X46qnjsuwbcQQWAuJhShSn9BWNbu0HuXCqO1h7DLB6z73GkTFpsYJkt42viNXbZTkUs/5HFsKMYNeqXsbEJ47t3mHNrRNsJXgd/mGED5V5K6H1aKzXnTDrw8UUSxjyxlkb7YrdzleuWUxmMWAYZ+tln7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xmnjynj5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xmnjynj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GC0WWsmiiFckjnXpIAV44INGlQO0KgKkCU7zQg2E+YY=;
	b=Xmnjynj5fg/5gXnDjlfIjgjFv4oMylMnmUaxGuSIFNjrrsHmYSJLTuQLdrY6KPW6PdJOLU
	EUnfp/pvRpFqmJC3IXnqo+4AJI6YYtl4TSdjfo3u24olUwWr2iFnsLv96csrKnMR036u1r
	xJ23tXTudbEQGM1GtBmEEBIp/yeHtWQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-JxvLNTd8Msy7ZmmMn0M2fw-1; Mon, 07 Sep 2026 17:46:14 -0400
X-MC-Unique: JxvLNTd8Msy7ZmmMn0M2fw-1
X-Mimecast-MFC-AGG-ID: JxvLNTd8Msy7ZmmMn0M2fw_1788817573
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-499b99a8a10so35310735e9.0
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 14:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817573; x=1789422373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GC0WWsmiiFckjnXpIAV44INGlQO0KgKkCU7zQg2E+YY=;
        b=jN6/f/3R8rK8JrEl/m8r4ZvV5otxwhHzb9LfbwhqclSIp+q/j8dPxbR2lgdfIqpJAg
         JMDgx/17Wo9Sq9yLTkcZnfId2cRh/RGSA35pBDYncQOi91WoILVs/oFYdGlY1A5bKGuw
         quwji0TKY7OzbE/wqUipe4ow1fhuJQ3jCIIOEyhbWF1hxWLIXVXFNMgELeSpGv7Eps/t
         yMnu7xoUdGkVZAwkQQObd1pNIQecTWpXuzKLPKuZ9VO8ZiKxxZ/xds1sF4cdtrLuZmOq
         wy3TLXrNNgB8G3C8Q2qd2CFZeeJN+pwXSglq3oryMBrivkwO5c0N5THD0hTpMfFlZNqe
         qxOA==
X-Forwarded-Encrypted: i=1; AKwUvBx3TSaOhNGAr1JfTOglrqhFcBd9Tq36NLxbANsNyBVXfz9h95oof6AtOkDvRA882kJrXnwR79NpK0KJqjvzXA==@lists.linux.dev
X-Gm-Message-State: AFuF++lo9o5ibjA87AnuluWihDXjA8ruct01LutbuVtnA66Jn+qC+XRb
	3HkVHXZftXJ08DU9bKFkugY3tiloIOYlSHOOU1/atSX3bjEshh4nQdoVXex/RqSL1MmhxN9Gr60
	3tRlQ+GSDNQ7w+qFcx2eXsqo7L73AGf3RqxOEmDx2P44xu4IOjqfAITdNG276Ve1xsWc6
X-Gm-Gg: AYBFou300xsGVu25S0dgVTdYqTAieFWLBPE1L2MtRJoEAvto+k3OHhKn1WwoYbVwAST
	2S+pvvLJc/rm0qPc99daqvOXXzUcKSH8Gom0pK1Pl6XF0cllgMvVaWmgjnyzCIxeWvebNYlxFQy
	ojgMmZd+I383/nqBj6OXAZBxDHlJ93ut0CZRYos3S+/6ePsJXJ5vwjhjOqVkrfR9HdU9WXZ4IGu
	WWKs31dPgyPfMhdkVpeNK3Y6dVP8t2q16x8moakUfmksmt7edjk/S9cadv57X63rTdDAKbfrm6B
	yh7sQOjDyisfmchtDqlXa3Q+ZJA0HkRFpnhm5W/XQdIVxeZcLY6CDm+0BrAtpGpe5MxWEpdVh/X
	zJJdVNoZ4sPrseyhik/Pkvq4=
X-Received: by 2002:a05:600c:3145:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49d1757294bmr35387415e9.9.1788817572613;
        Mon, 07 Sep 2026 14:46:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49d1757294bmr35386945e9.9.1788817572138;
        Mon, 07 Sep 2026 14:46:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm194010325e9.8.2026.09.07.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:46:11 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:46:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <20260907174559-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-3-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _uk2ReXVUXeMugiI39hRcJCdS6yRPw1d959xpDYek-Y_1788817573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 05, 2026 at 05:20:58PM +0200, Karl Mehltretter wrote:
> virtinput_remove() unregisters the input device before resetting the
> virtio device. virtinput_recv_events() drops vi->lock around input_event(),
> so clearing vi->ready does not stop a callback that passed the entry check.
> It can still use vi->idev, requeue buffers and kick the queue.
> 
> Reset first, as virtinput_freeze() already does. With the preceding core
> change, reset waits for callbacks before input_unregister_device() can
> free vi->idev. Recheck vi->ready after taking the lock again: keep draining
> completed events so an input packet is not truncated, but stop requeueing
> buffers and kicking the queue.
> 
> With evdev attached, input_unregister_handle() currently waits for an RCU
> grace period, which also waits out IRQ callbacks. This masks the lifetime
> bug on PCI and MMIO, but does not protect sleepable callbacks on other
> transports.
> 
> Fixes: 271c865161c5 ("Add virtio-input driver.")
> Assisted-by: LLM

which llm and which agent?

> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/virtio/virtio_input.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e682..7b654af0a42c 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
>  				    le16_to_cpu(event->code),
>  				    le32_to_cpu(event->value));
>  			spin_lock_irqsave(&vi->lock, flags);
> +			if (!vi->ready)
> +				continue;
>  			virtinput_queue_evtbuf(vi, event);
>  		}
> -		virtqueue_kick(vq);
> +		if (vi->ready)
> +			virtqueue_kick(vq);
>  	}
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  }
> @@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
>  	vi->ready = false;
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  
> -	input_unregister_device(vi->idev);
> +	/* Callbacks use vi->idev. */
>  	virtio_reset_device(vdev);
> +	input_unregister_device(vi->idev);
>  	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
>  		kfree(buf);
>  	vdev->config->del_vqs(vdev);
> -- 
> 2.39.5 (Apple Git-154)

