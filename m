Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C871F4CA9
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585344; cv=none; b=uHaLmkrJqxeJpFVo8KJks6UTtmY/42ckJ8Mrx+1J3Dsd3Ku/TG/64nOC1C6iSwMtqlwgRwk6IwuNPVwuCo9AnlNRaX1bnG2XAx2v4WhC6pjM6lBfRxNbuDQ/2FfFceugPfzjcAa677FX49yv4TSpri/LVbHZVcd7Ta8OwHhCgf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585344; c=relaxed/simple;
	bh=54Zn1p3F0ox83fggN9VwNFXZbBprOdRfEuY9sqrLpHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t2wdLYA7wi/V6lYCchlHDQJ0KmFtRsBUUScjB2/nId8IdrluDsN6m3SltIZ5db8FjR8qvLJnTWtYs0pSaidtv6hx8Hzu/zd8AWcdqSq7Ct5VRLRqOwXgAsWl1ij0SnK2BVUUcNOg7oKkdJaLo5Gme+RMBaVd8D25fT1ey07uIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feyVNtzS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feyVNtzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775585341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uA9nz2mAv4ZvmjDLfYPuOq6DpBYUGnnvQafhwzvBDjc=;
	b=feyVNtzSFkq48Kyulh3ZYzxB6I5LB3XDVrQ+dbAHn00BbfhAO90S/x+fAuHz50ZNsYsaQw
	pCITvdZsq0JVDzuuuCgvjrzv0INBDOveXdZJjWHBMQ8MhdEaMaFC8eoLrgUx574I3h1wlC
	8WSWWTw3RFPcFGZq6VTz92VJIq8EvGw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-nZtw52YZO5iSaFQiXxy29Q-1; Tue, 07 Apr 2026 14:08:56 -0400
X-MC-Unique: nZtw52YZO5iSaFQiXxy29Q-1
X-Mimecast-MFC-AGG-ID: nZtw52YZO5iSaFQiXxy29Q_1775585336
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8d57516c889so804508485a.2
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 11:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775585336; x=1776190136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uA9nz2mAv4ZvmjDLfYPuOq6DpBYUGnnvQafhwzvBDjc=;
        b=SWv0uIdzeY/errjHCd2XOfCPlX97TRNDdwtBELYdQwlMnpSF32/qTNlXnLVaysUQzg
         1V1M4CBC+XvgGeGKlGCNiAR6eXI8YaAhDmSyEjtMyCouFBLNKPYjtUzvrxX8pCtQTaH3
         Uub+sl6U8+5SJnnLoQS7l4l1uOrH2Zio6WV240FPnifrWcS2yAl2kEc1BJV6aFiTE7Kh
         WuQ1e9SynhcLOKVGaS9ewk5v0PhNftGqVZRkk1YVNmcZ/MwUGVini3VHrxUN6lrvUP/9
         GxEz7LtSYJE1W1GIRztmyLtgwq1rkz+3ZpuqkNcZS2cJFLbesv2+S9zH5zVKAFLV1VAj
         BmDg==
X-Forwarded-Encrypted: i=1; AJvYcCVo47fFHCpyxYhK8ERtbKmbNYWmodtq6DrfrQXmWp0VWANFH7eHQMz4N01Ofde6LGKTRh4DvXGNucvzosZtAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDHf/uR0ztbgG68LU37OOh4ZkY7c7o9ebHdxfeGp1bOf/q63bI
	ZlidWrJYyGLf5cKwQlcsvBxbcgmWWEsbD6MuFLysKlIhDrDkW4hyrfv9VX8lLcw0FSu26x1uLjw
	dIsfBlMYHaWblRJhVgBHKBEqyGUeiwmfe3HQAMzC8XpcwOpEOTQ6jfy4Evs0bvZxuNyXN
X-Gm-Gg: AeBDiesRX2CbrQWRj934wnOO3EoNW/fcaN03KjObjr6BOJjltapbiremCrUOLW2z44f
	SWJvJK98zog/lC8AOLv2cvAayoLmw7axWYSG7CzYi163CW/dr/RTmgbfqtz01wTcySTqaInQ/FQ
	JOMhKXXmuCzHyiEbi72CSW0/w56kG4t+MZ1wvR192z2NUk1BzDjbdbzW7Wa824HC2BeEIRScplf
	1Pnmh3cPXU5UPWE8pzVXdEEmPjukg5rOY3s3OfNtAHts19Uig/WiqouqzzaGMM0/Pir1RTa3+PF
	/1rKjNpastzvT1c/2grpsqmxK0kEdp5Lddrg7iA7rOD3P4xV9uF7r07S5e7I7nk/8+7Pl7SqplK
	MEyUrJBEv9R3n
X-Received: by 2002:a05:620a:25d2:b0:8cb:5233:8f8a with SMTP id af79cd13be357-8d41bbd64f7mr2420039185a.11.1775585335882;
        Tue, 07 Apr 2026 11:08:55 -0700 (PDT)
X-Received: by 2002:a05:620a:25d2:b0:8cb:5233:8f8a with SMTP id af79cd13be357-8d41bbd64f7mr2420031485a.11.1775585335240;
        Tue, 07 Apr 2026 11:08:55 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5ce92c4d3sm849354885a.44.2026.04.07.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:08:54 -0700 (PDT)
Date: Tue, 7 Apr 2026 14:08:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 2/4] virtio-pci: use avq->vq_index for admin VQ in INTx
 path
Message-ID: <20260407140841-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-3-astellman@stellman-greene.com>
 <20260407122608-mutt-send-email-mst@kernel.org>
 <CAChPuV9OuQw_F5dsna4meVxV6Hicxe4+674xoSx+KEev6JEEQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAChPuV9OuQw_F5dsna4meVxV6Hicxe4+674xoSx+KEev6JEEQw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZS1BqsHQk7apr1UUS9IhhqrRz6eBgwec45tyPzfqO_0_1775585336
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 07, 2026 at 01:34:23PM -0400, Andrew Stellman wrote:
> Fixes: af22bbe1f4a5 ("virtio: create admin queues alongside other virtqueues")


and how was this tested?

> 
> On Tue, Apr 7, 2026 at 12:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Tue, Apr 07, 2026 at 08:39:02AM -0400, Andrew Stellman wrote:
>     > vp_find_vqs_intx() sets up the admin virtqueue using queue_idx++
>     > (a sequential counter) instead of avq->vq_index (the actual transport
>     > queue index). The MSI-X path in vp_find_vqs_msix() correctly uses
>     > avq->vq_index. When the admin VQ index does not equal the next
>     > sequential queue_idx value, the INTx path binds the admin VQ to the
>     > wrong transport queue.
>     >
>     > Use avq->vq_index to match the MSI-X path.
>     >
>     > Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> 
> 
>     Cc Jiri. fixes tag?
> 
>     > ---
>     >  drivers/virtio/virtio_pci_common.c | 2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/
>     virtio_pci_common.c
>     > index da97b6a..0b9d66b 100644
>     > --- a/drivers/virtio/virtio_pci_common.c
>     > +++ b/drivers/virtio/virtio_pci_common.c
>     > @@ -497,7 +497,7 @@ static int vp_find_vqs_intx(struct virtio_device
>     *vdev, unsigned int nvqs,
>     >       if (!avq_num)
>     >               return 0;
>     >       sprintf(avq->name, "avq.%u", avq->vq_index);
>     > -     vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
>     > +     vq = vp_setup_vq(vdev, avq->vq_index, vp_modern_avq_done, avq->
>     name,
>     >                        false, VIRTIO_MSI_NO_VECTOR,
>     >                        &vp_dev->admin_vq.info);
>     >       if (IS_ERR(vq)) {
>     > --
>     > 2.34.1
> 
> 

