Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48234322F6
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694324; cv=none; b=EKiL39cqOKp8CibexjE8klkfmaGMpvuKa0ea+zvBqaAyNGUb7PTIHyzqTOfwAadjp+nI5kGueLXxYo8nNy1nDepooUm/JzW1t+Lnjtwj9kGrS1mRqKmS0NEn7WaI5Dd/1gzxyFfsEBDZaEJupGI3C3kR1BaOVR0vnsRDj8cztUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694324; c=relaxed/simple;
	bh=8Kg+ScAaOCNrKwZS1J2hG59QX910+I//yXlSdISGGjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M+nxh7FjTwGlD240MpoL68YTLdYTwTKjeAh8vO5afz2ToLb2k/1Ml78TPwp4/UjJ3Qn4uAOIwWFWLrDSdOUPb4J9Z4Fqbcxx1a7PICYHQP7b4imoGjvfybYRuZuYZ4RAMTyjLN0aL3858zSMkaZL136De77tkc7Hs0zxP2G/23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CITQ+/LE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CITQ+/LE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
	b=CITQ+/LEct1PzXXmNVsJ0HBA8cpk7ln4yvGkPi8Mj/2guZHieprhJFVbwKLLFSx6Mp7i2U
	JZZR2j4BEcPtWsNH4ie5MG12KkSkJ+PQscyAPbPfMn5G500hovcL+7oHGJryuaBkAwEVaf
	UPAH48UvI3d1KbDiPvx1VBZ/bDdbXiY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Od4lw-5rO16NXnfJfvjXMQ-1; Fri, 14 Aug 2026 03:58:35 -0400
X-MC-Unique: Od4lw-5rO16NXnfJfvjXMQ-1
X-Mimecast-MFC-AGG-ID: Od4lw-5rO16NXnfJfvjXMQ_1786694315
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso6287965e9.1
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 00:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694314; x=1787299114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
        b=nnnUnPWvlB2qKJBKCm/YzxxLNW4yS+x8/RIPZ4iAl1wqDqdOYRC5uJSO5W3Mv2EYph
         G6nK+v3fyhIBb3Zkto5J+Wp5Q5d72RYFJhVU4tqV6HUeki7Xa54+OaMTQtgwgnpAA7MS
         waTIDoZUee0RNVOM95tflQvA6kWfCKSZvgfnmV8i7zrPJ9iRtk1vIZlnuS5F7gJqXxN8
         +t3wYMTTpA8kFLsAe3TDk8nUpsAO4dHKd3aA+caKthwxCq0XtXJeXAe8VCA5qihgtaDw
         MPC/oCfypQ+2znOFz+poWfG/ChAPzgzCdqTw8LymLdjN4cMWBNlB3fyWxT5UF4Re9MnO
         Ddaw==
X-Forwarded-Encrypted: i=1; AHgh+RpwYB1RfZGs8ZNAL1AtY63xykk1hvz01+knHS7sG7ZTsWOmMDdFdx2iJ4xgVrXGHVrdSdOn0NH/tu0VdC+9RA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnEfZ2qVVCRWDrn14J8ySV4AgsF75fOvd/8cy7mW0gdbNsJHb+
	5nUYnCyREzQL+2ztvoWamCBfLyInTFCGy6ljWQLmM7b2qud39vsCqC+/rG8ld52H+AsZkDJQHvK
	fnKsB9tghPagVSWZnErNuVtgs7s6WZtzB6JUP4K8Zl4tJWoTH/46fcameJFAfk7wShzed
X-Gm-Gg: AR+sD11vH60R4+N6BziUth1y8umXKBE7cwlHkVFlJfr5LHZjJKotnEE14+dcdxUpAyr
	R6Z2OLrw9cyb+Qpj3bDCyRoXZ/NWAlwY91so2OCTncStftTap7x7zZjKbonEivkMflmjCJJ3GUW
	Q0nW5N/P/8dFni0ScbsZboa6SQME6QWRQMAsFiWk/KEZfi/gLiKpnFfS8NtXC0kT58qh6ULbPPA
	jgaDjcYcSIfUc3cTu3NqCk5h31gXGQaT1jliA4ya5iL0Ymy9Sl4KkvnE10YVBFMfDy4CiZ7+ich
	/XbuHTh7URy/oV8ww2vInNMGlmBkkqFhjj5H5/gM3hOXFvlmHLqwDaZeNFIDKZzjlT3KjA9GZg3
	C1wOfEJa9Qwd+i0qdJdnXO8RRk91mZxEK9KMbQQqCgEEvDDzkxdu7
X-Received: by 2002:a05:600c:8b02:b0:499:88b0:1726 with SMTP id 5b1f17b1804b1-49989e37a3bmr8118235e9.2.1786694314565;
        Fri, 14 Aug 2026 00:58:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8b02:b0:499:88b0:1726 with SMTP id 5b1f17b1804b1-49989e37a3bmr8117435e9.2.1786694314130;
        Fri, 14 Aug 2026 00:58:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899afa63sm9164715e9.1.2026.08.14.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:58:33 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:58:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
Message-ID: <an7KGaKyX_I4B3uQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260814072903.124991-2-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9V4Evn0notew_pf_9uYey0HqA3ilOy_F5qTVmsAUMds_1786694315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 14, 2026 at 03:29:01PM +0800, Jia Jia wrote:
>The device IOTLB is shared by vhost backends, but clearing it requires
>dropping each virtqueue's IOTLB pointer and metadata cache before the
>old table is freed. Add a common helper for this teardown sequence so
>backend-specific feature code only needs to decide when the table must
>be cleared.
>
>The caller must hold the device mutex. The helper does not update
>acked_features; backends continue to update that state in their own
>virtqueue loops.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 25 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 269efad90369..7eaa61d9ceeb 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2283,6 +2283,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)
>+{
>+	struct vhost_iotlb *iotlb;
>+	int i;

Should we move the check of `d->iotlb` here? so the callers doesn't need 
to access to an internal details.

Stefano

>+
>+	iotlb = d->iotlb;
>+	d->iotlb = NULL;
>+
>+	for (i = 0; i < d->nvqs; ++i) {
>+		struct vhost_virtqueue *vq = d->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vq->iotlb = NULL;
>+		__vhost_vq_meta_reset(vq);
>+		mutex_unlock(&vq->mutex);
>+	}
>+
>+	vhost_clear_msg(d);
>+	vhost_iotlb_free(iotlb);
>+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
>+}
>+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
>+
> int vhost_init_device_iotlb(struct vhost_dev *d)
> {
> 	struct vhost_iotlb *niotlb, *oiotlb;
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 0192ade6e749..3c75e8089373 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> 			    int noblock);
> ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> 			     struct iov_iter *from);
>+void vhost_clear_device_iotlb(struct vhost_dev *d);
> int vhost_init_device_iotlb(struct vhost_dev *d);
>
> void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>-- 
>2.34.1
>

