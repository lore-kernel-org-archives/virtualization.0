Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0063BFAFC
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440401; cv=none; b=G9hg6dAKyMEPtZfQl5OkxJF83s2oaOTNVlwPlEE3GPJZ/p1BLulJPQdA3WIfH+XmlcyZTWqdzekBxNRRq+lLZRsUb8hrt4H/pt5cC2EA/4W6WufNA1OpDAODTLdKLBduVafvZMEGpQYg4rEuiW7E0Ua3dASpZNpSveJeJ6K+yRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440401; c=relaxed/simple;
	bh=qKch0A7LR2mW5ZDryjBYCTZAVH9u7xn3vXfwOUlcVCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DHXz0thkP57MvM1Q0ELGB7Lpje6Muo9y0w9/14HkvQ3oHxOkpo9eNDCXNEc0BRcRX8YAlzIQw7REqD1HVS9rkq7NQvy0RFMz59YdBCP2JaW795j0PE+00rhI+WN5eD8LJyVAc1Fg4VOnUkoPwlAtAiiMdxw/eYh8/KGDNq27wKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lvk7tbP1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lvk7tbP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791440397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBkvNqNk+kq9xlFcI/2YnHiKYK3/wLihDPOcRkcC1+Q=;
	b=Lvk7tbP14vPMAn+SfI83uerUrvg3xwIoZtmcING7QNzhBNjSbgTNtMfyuunbiLL4mEva3t
	e61YlNMtOWUWurmQ6uV9Zh+m5x/BepZddmHMCQlfLowwOttqVjXNHtYxj5CEcxtnqAZpuQ
	anShcSoPcxHc8o+fCcxSn82858nf3NU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-JyT3aTwoMrih-VrpkpO6rQ-1; Thu, 08 Oct 2026 02:19:55 -0400
X-MC-Unique: JyT3aTwoMrih-VrpkpO6rQ-1
X-Mimecast-MFC-AGG-ID: JyT3aTwoMrih-VrpkpO6rQ_1791440394
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso2222915e9.1
        for <virtualization@lists.linux.dev>; Wed, 07 Oct 2026 23:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791440394; x=1792045194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBkvNqNk+kq9xlFcI/2YnHiKYK3/wLihDPOcRkcC1+Q=;
        b=TO3HDiusB6EDeG3Fc4+K31vxHFUdlBvfTJCqxApbhEuRaAkRvyWmxePHKGE3+tKiH2
         iPdvzdTCFx6LwWp3KKjqlT3woKshYx/zYiKDYKZU4ZF1qDhzjq6Cat3cYJYcSiXQW/AC
         q05Py5iRlcKunbbLew4AUynkRPep0g7lYEQZ/mQ5T4uWkrw1uGjU47pU3+WFp3co3Y8a
         gm/DjFbb8M95rSq079bE1Y3p6EJcjrwS/d2iPf7sWxAuStE6XjWp1GSmaw/rg54AtBSZ
         EvE8L1My/FOzx/xAqQ+gPSSOILMvq1N5++Q5urmzob1sgq2YHEK0nleaq3IUC2isSLH1
         eBeQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4YUuPl/AJt8r6AQtqQoBZIuopJFgAhPBKdmMtqHwHgx/hmiFW9RtQid8AgMweA8dnEFfOArJLpY3iQnDwPA==@lists.linux.dev
X-Gm-Message-State: AFuF++kk7yOCaWdjQlY/kj3FkXo0TCIXXso+V7Cbxch+b5psGalrHguS
	TiFwpF+evUGiKHR+zSEEfvNcF3mzdiq3nLO4d/CVgJGGF0f1ZSvKinlS7fqdkHa8TqrfE0oSd2q
	MASXCHg9bHojggA/nuAoCejDglhlzhIoZMSjt2XugYZfTigqkad96D7A+DGiiU2MC06kwbUpiuu
	6q
X-Gm-Gg: AYBFou0+eyhm6334lXK8uRM3yK4JsvRlhlKbNIxCUpdR8Zxuo8nMZSCNVh0F6m1ehmz
	Qg4Ws4uzzwbSUrHLzeC2lnkS8ZlC8PCXzuXgueyUD5P7KKuCCIGiG+JoNFEEjPSYLPlHSvZeihH
	5mvg7vD02EOGHAs8wkl8KSDa9ykII9zkOyJzb4/ETOk8xd3/aREtbwGrhmCgwLmYFX3L+DGHUlH
	LgMgUrkDTN+0SsIH7FF1kMkDoFd8DYEnbiDc1E687PzeTvC1y+dL/KH4675d9XSiQnD6MMufzjh
	gd7d/J49/3RQFXdMpTGkPiPd9Qv4ACjQCjWdufMZu7YBcU8DUqPH2jMXlDNU2SNpkqjVXIw=
X-Received: by 2002:a05:600c:1553:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1851c05admr26726885e9.14.1791440393450;
        Wed, 07 Oct 2026 23:19:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1553:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1851c05admr26725845e9.14.1791440392494;
        Wed, 07 Oct 2026 23:19:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71b786d8sm9384557f8f.0.2026.10.07.23.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:19:50 -0700 (PDT)
Date: Thu, 8 Oct 2026 02:19:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: sungbyeongchan <tjdqudcks0424@naver.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2] virtio_ring: use shadow flags when detaching split
 descriptors
Message-ID: <20261008021938-mutt-send-email-mst@kernel.org>
References: <20261006102112.847280-1-tjdqudcks0424@naver.com>
 <1791422498.2257345-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1791422498.2257345-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2d4gOsPfIsKcKrLAuYkyQTRd_C7bsPI_iV56onlOyic_1791440394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2026 at 09:21:38AM +0800, Xuan Zhuo wrote:
> On Tue,  6 Oct 2026 19:21:12 +0900, sungbyeongchan <tjdqudcks0424@naver.com> wrote:
> > Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: LLM
> > Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> > ---
> > Changes in v2:
> > - Drop the commit message paragraphs as requested by Michael S. Tsirkin.
> 
> You misunderstood him.
> 
> We can not accept a commit without commit message.


Indeed.
> 
> > - Add Michael's Acked-by.
> >
> >  drivers/virtio/virtio_ring.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index db678f5a80e03..b4cb433df1dec 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -905,7 +905,6 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> >  {
> >  	struct vring_desc_extra *extra;
> >  	unsigned int i;
> > -	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> >
> >  	/* Clear data ptr. */
> >  	vq->split.desc_state[head].data = NULL;
> > @@ -915,7 +914,7 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> >  	/* Put back on free list: unmap first-level descriptors and find end */
> >  	i = head;
> >
> > -	while (vq->split.vring.desc[i].flags & nextflag) {
> > +	while (extra[i].flags & VRING_DESC_F_NEXT) {
> >  		i = vring_unmap_one_split(vq, &extra[i]);
> >  		vq->vq.num_free++;
> >  	}
> > --
> > 2.43.0
> >

