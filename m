Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B421C194
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524404; cv=none; b=lEsqS2vM+e3O4u8xxkLL4rCc1xR4IlUFcIE3voVhABQv1/ZJEMvLUvjx+eewmBWOUUxidk22rJe0V3aA2fxUnngQ+FkOpbbgkZlB/DVENPyl2EXt37syhAJS+V7qAXnrcAbqpasqE5WaMsHqovHYc9wdm1qxFHJpVJvfWLGxKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524404; c=relaxed/simple;
	bh=du5R5OUyc41uFNnKmFDZ3ZTR4fBDivNAdBOmdVBBTyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Re6BYGWAleyIgT5eAdWx5EYEbyPhX18RcSUVoG+fowH+xTsN86y9Bwak4y7PMDT7cVt5oMA4B0OgbMuk8zFWM8FJtcHGDVYoXR2bvam7F8ZR/ked2DsSWG418ioVIkM17xtVwGGlKDGGb6crDJF6heLhFMw431dU0LGDIIu20A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLRejC9i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLRejC9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXpaw3tkniDHQJSqE2+DNSZa4uhMaRXAPDQGJoN00q4=;
	b=VLRejC9i13Nm7UoSm6hASP24DcYXjC7ZGF2+3RDY9NOnT1VHZ68wdBBpKemVyDQWlGW5N4
	uKRc1oD3RLoNuqhNeKfhLLcgLd69gay4iVLH+0t/5JLkWzT41D7EhekT2b2ne7mP/KMm/x
	Ac7qxYzpNqTFQwfofFHh7ne5n57Gyac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-2noJ1uDkNe-A75FE1Hb5Bg-1; Fri, 14 Feb 2025 04:13:20 -0500
X-MC-Unique: 2noJ1uDkNe-A75FE1Hb5Bg-1
X-Mimecast-MFC-AGG-ID: 2noJ1uDkNe-A75FE1Hb5Bg_1739524399
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38ddba9814bso1188517f8f.3
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 01:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524399; x=1740129199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXpaw3tkniDHQJSqE2+DNSZa4uhMaRXAPDQGJoN00q4=;
        b=gL/jjAMQ+tcVcDQZChNz1qfHAbH898uCKGoYhOfosX9TyUg4AfgMf8PdShfXiRQlU+
         yoIKnXdaWv2ogbeL/SIo8ZOKHqCdpeZJXnBowkYHt6MKhJfHSHilK3qvxCP0OJcIXdtB
         J0DtkVk6OSpPuKl6niltzd8Ce+rizYYnENJlRmEm0QoVDzXb8TykLFLco0wMlnLR7oQ9
         9/R3yTScXLf8XHJN3Yr1kyylk3s9zeCXb7FrAZ48d70j5j3LWWDxpa5JlYxZvKjiWOKe
         VPHjpWPeidaSYFRdnkaZfyCC/N0HNQHJddAqWu/fyrSOKZS4iOCCvzI+9VjSinTbJRGQ
         2tag==
X-Forwarded-Encrypted: i=1; AJvYcCX4+Q289wgFA2j0S8Vt4kl/wl39dOZiPQajHWk7W58AhCUW6elfKUo19Q1ZTrjZqYEnRg7ewsHpIL0MC0AUGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP4PfHtfEVnYFyd0Jji8d2aY9t8Fe22+USLVyupfM6wEjsjiy4
	RQgZWfDhPTgL37qccfJpyclaksph7ZHP8u6UKDdauam5sAAgbykGI1mwO3TzfWnXdcPopDVZAYY
	wieTWg9sXkDvdJKGSDlGn7/VbaYrJTvA7QVrgP/69UZxkHL4Qv1Jpx7wcOdQsWXjU
X-Gm-Gg: ASbGncstFH2Nu8oXYCE/P1ZGuIGfhZG+1sq13kVb6G5Xin/W6YJaIALqEdG32BRF1tF
	IVNsEeZDxZ3GCs78DVc9jZT4T8VRABdD0ft+KP+jV9kJ/lsdIsYr8pezG+83Fs/Z3hRrtakNZUl
	99rt9WuXdaVCnMlbOB6kpgbFblLDGrEkPMUkfkR5mlIBmQACxbvWoKUw9NN6oJfLOnz6XTVyloD
	8ggbJu7J0/HasOf8PUWYHiz3KAY4PwAEHqB2kqGlaGNdqkOqjpQDWj7CcFogHNfrXFgVRLc+lQC
	WjHSpca/
X-Received: by 2002:a05:6000:1a85:b0:38d:e3a9:d641 with SMTP id ffacd0b85a97d-38f244dfe03mr9750126f8f.16.1739524398994;
        Fri, 14 Feb 2025 01:13:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFo1+ndYPmLLEUFSzQhsih+LtpLI3CjoSkz/apOU+mMFzHLmZCSQphrtiigXU04yGg9k2Yzw==
X-Received: by 2002:a05:6000:1a85:b0:38d:e3a9:d641 with SMTP id ffacd0b85a97d-38f244dfe03mr9750070f8f.16.1739524398608;
        Fri, 14 Feb 2025 01:13:18 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd2csm4202125f8f.30.2025.02.14.01.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:13:18 -0800 (PST)
Date: Fri, 14 Feb 2025 10:13:16 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, 
	kvm@vger.kernel.org, lei19.wang@samsung.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [Patch net v3] vsock/virtio: fix variables initialization during
 resuming
Message-ID: <yixatl5meez3ijzumebqkhf3sywwmiicwbsuxxsfdyfeeaapw2@dq542v2lclvm>
References: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
 <CGME20250214012219epcas5p2840feb4b4539929f37c171375e2f646b@epcas5p2.samsung.com>
 <20250214012200.1883896-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250214012200.1883896-1-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FvSpZwE5h69ldxvH1HbzCd-cht6SQY7z5dG-pSrMaUE_1739524399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Feb 14, 2025 at 09:22:00AM +0800, Junnan Wu wrote:
>When executing suspend to ram twice in a row,
>the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
>Then after virtqueue_get_buf and `rx_buf_nr` decreased
>in function virtio_transport_rx_work,
>the condition to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) will never be met.
>
>It is because that `rx_buf_nr` and `rx_buf_max_nr`
>are initialized only in virtio_vsock_probe(),
>but they should be reset whenever virtqueues are recreated,
>like after a suspend/resume.
>
>Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
>virtio_vsock_vqs_init(), so we are sure that they are properly
>initialized, every time we initialize the virtqueues, either when we
>load the driver or after a suspend/resume.
>
>To prevent erroneous atomic load operations on the `queued_replies`
>in the virtio_transport_send_pkt_work() function
>which may disrupt the scheduling of vsock->rx_work
>when transmitting reply-required socket packets,
>this atomic variable must undergo synchronized initialization
>alongside the preceding two variables after a suspend/resume.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Link: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/
>Co-developed-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>---
> net/vmw_vsock/virtio_transport.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index b58c3818f284..f0e48e6911fc 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -670,6 +670,13 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	};
> 	int ret;
>
>+	mutex_lock(&vsock->rx_lock);
>+	vsock->rx_buf_nr = 0;
>+	vsock->rx_buf_max_nr = 0;
>+	mutex_unlock(&vsock->rx_lock);
>+
>+	atomic_set(&vsock->queued_replies, 0);
>+
> 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
> 	if (ret < 0)
> 		return ret;
>@@ -779,9 +786,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>
> 	vsock->vdev = vdev;
>
>-	vsock->rx_buf_nr = 0;
>-	vsock->rx_buf_max_nr = 0;
>-	atomic_set(&vsock->queued_replies, 0);
>
> 	mutex_init(&vsock->tx_lock);
> 	mutex_init(&vsock->rx_lock);
>-- 
>2.34.1
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

