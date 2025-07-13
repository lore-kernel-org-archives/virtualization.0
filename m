Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E081E
	for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752395800; cv=none; b=gb+HRCiww/N40VD23aXXLQCUN7upO54vVUPKdA/TbCDpQwrDFa/mqRdf9puas+uuo+99yzZn7mvkrCb2kbxj2GJ7Pyq4ampZugaWbuydqIMPfFvXXcj/qClSPPhqGssNLY0mJsUC96HeBw+IckzGt+VOM8o0GG18p2mDFjiqMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752395800; c=relaxed/simple;
	bh=N5h/OWb46/7OnUZp4r1lRig+zepm1M8w/tvdyl/mtwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qHjYW2oaUXOZJovGl1rn5ztHYHt1Wvc8yc370aqtcCqxhN/OBPSHOAoYipniDH0KVzyF+s/XvOWoRWF9fAdbCqBAzgAH25ZX6/zs5CGjXe8kdzEQUJR0D6AGcuraScGDuwkSQCQuA+NiyToXaITwaKVQ13Vcn5MikJlmWU+sHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=exNSFDqx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exNSFDqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752395797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEbnvjMKsKec1xZ0ba7ujf/hnfeY8sQWkRfbWbCXG/I=;
	b=exNSFDqxFRssnmASGkvSbwPBw5vt3njAUVFw/zyVEDjF4HXPApsjWp4RqnNvsF6QCdskWV
	Z/bzwb9FNYFLeqi28zDch5MytbXgfXBKQknTNAiIgrfw9/cYEjg1A+dhEEIMotM5QEP1li
	7MTQoLkRK5Hw4swj0gsnq429m22N/6w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-bJ2aU6XNPRKauCwe8HpqoQ-1; Sun, 13 Jul 2025 04:36:35 -0400
X-MC-Unique: bJ2aU6XNPRKauCwe8HpqoQ-1
X-Mimecast-MFC-AGG-ID: bJ2aU6XNPRKauCwe8HpqoQ_1752395795
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso17944015e9.0
        for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 01:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752395795; x=1753000595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEbnvjMKsKec1xZ0ba7ujf/hnfeY8sQWkRfbWbCXG/I=;
        b=jc4qLDB20H3TnQjvx+aaAlj+mwBLyrf9qTKR4bectwVIFAxVBgMLgPVzk9eG/UvidX
         MxKjGGLbXaZJYVO95FgQbxgnAzI1pQaZcj0sefeI74IoSTzNLOhXxNcXkBoAfYxLaAfS
         uucA6pO4dZCBaa1V0/jP/hhM3foD48+hlwk2F/E8zm1PYj6PvjECoQOmvv5P9dnm7ftt
         lEXkv3H2wy1g7KTe1iyHFNV80Q1/pZKW/7J0XLWZilwzyYf/aPue5fJdHB5wlltM+vVP
         h95iS+nbtsjotOtwzyvASozEJdgKqgQu2L41sDUiUfeW6DQMtZCLTe80czWI9IZTeawd
         nCbA==
X-Forwarded-Encrypted: i=1; AJvYcCWvWqoV6nnoNHRmTpCVhVLD6iAlCpXrdTtZXQELDj+0UJ5WWvQrrijLmRsWVU8aMtuzEJyBBCSXI9buA5zneQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3sJIFCId0GUZsRkm2LM5uXmm0t00V1wzYkNYmMjEi0mHailss
	FcNa2y6lOS3Yke4hzqaypDBZvCs/DEo6yqacu/ivl99CYXLDFkRa/LN7UMywp5HMgED61yX09Eb
	OAvIwBlG/b6VxJKHR7EG5AOmhHA0kfQWI2tFnwX1x1WMq4om8t7Dj3j4iQLYWmSId00HZ
X-Gm-Gg: ASbGncvNotrT3bxorxSmeDVHcQBsC7IKunGeIz8x5TTVPjOc1vuQWWV3hVSM7eR4hvq
	CqxY2yg822mWNBJNeaweHRbg1V5kfklvoMZbh+/Y4kWEuyT5choWZrs7fVO01HBLFIS8AIbTQ7h
	naQFokfH6IXyXRvZhWY87dKW6zZjiS9ENS/ZMiL+cx5r5w/4Mif8zhKybP6U7QKNPqDuvnJQnP9
	v8wbhdIW/Gmqe6EqasZcqGcr+bA/XUxrSI14brptEroMgRRuH2vk983aMSvYYqSq6MOIsKFolGg
	h28ksNstASU9boxtOu+yIzoTiKhPLe3D
X-Received: by 2002:a05:600c:4746:b0:453:7713:476c with SMTP id 5b1f17b1804b1-455bd8e63aemr68498635e9.2.1752395794593;
        Sun, 13 Jul 2025 01:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPrWLnULgul3Q+Y4evIyqXEPldQf1FNu4SNAActRUadJ7iXmDgD3pC51gB/u+zBvOhscQi4g==
X-Received: by 2002:a05:600c:4746:b0:453:7713:476c with SMTP id 5b1f17b1804b1-455bd8e63aemr68498345e9.2.1752395794093;
        Sun, 13 Jul 2025 01:36:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600722780sm1613280f8f.23.2025.07.13.01.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:36:33 -0700 (PDT)
Date: Sun, 13 Jul 2025 04:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: yin31149@gmail.com, odaki@rsg.ci.i.u-tokyo.ac.jp, eperezma@redhat.com,
	jasowang@redhat.com, virtualization@lists.linux.dev
Subject: Re: virtio_net: Incorrect VLAN filter configuration on boot
Message-ID: <20250713043606-mutt-send-email-mst@kernel.org>
References: <2be77146-dcbe-4370-b5e3-dfec9f4cf335@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2be77146-dcbe-4370-b5e3-dfec9f4cf335@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5wsQz_RJ8I-qWxPqhZ1_pgrwoKqR7wOiL1_RytFkWJc_1752395795
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2025 at 11:11:21AM -0500, Konstantin Shkolnyy wrote:
> Symptom:
> On boot, if VIRTIO_NET_F_CTRL_VLAN is negotiated, QEMU adds all 4096 VLANs
> to the VLAN filter table. But, according to the virtio spec, the table
> should be empty in this case. (Observed when using VDPA.)

I think you want to repost this to the QEMU ML:
qemu-devel@nongnu.org

> Investigation:
> ------------
> commit 06b636a1e2ad12ab130edcbb0ccf995118440706
> Author: Hawkins Jiawei <yin31149@gmail.com>
> Date:   Sun Jul 23 20:09:11 2023 +0800
> 
>     virtio-net: do not reset vlan filtering at set_features
> 
>     This function is called after virtio_load, so all vlan configuration is
>     lost in migration case.
> 
>     Just allow all the vlan-tagged packets if vlan is not configured, and
>     trust device reset to clear all filtered vlans.
> 
> @@ -1029,9 +1029,7 @@ static void virtio_net_set_features(VirtIODevice
> *vdev, uint64_t features)
> 
> -    if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> -        memset(n->vlans, 0, MAX_VLAN >> 3);
> -    } else {
> +    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
>          memset(n->vlans, 0xff, MAX_VLAN >> 3);
>      }
> ------------
> After the above commit, virtio_net_set_features() can only set all bits in
> vlans[], but never clear them.
> It expects virtio_net_reset() to clear the bits. I guess, this worked at the
> time because "set features" and "reset" were called in a favorable order.
> However, then this changed:
> ------------
> commit 0caed25cd171c611781589b5402161d27d57229c
> Author: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Date:   Mon Apr 21 21:17:20 2025 +0900
> 
>     virtio: Call set_features during reset
> 
>     virtio-net expects set_features() will be called when the feature set
>     used by the guest changes to update the number of virtqueues but it is
>     not called during reset, which will clear all features, leaving the
>     queues added for VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS. Not only these
>     extra queues are visible to the guest, they will cause segmentation
>     fault during migration.
> 
>     Call set_features() during reset to remove those queues for virtio-net
>     as we call set_status(). It will also prevent similar bugs for
>     virtio-net and other devices in the future.
> 
> @@ -2350,7 +2352,7 @@ void virtio_reset(void *opaque)
>      vdev->broken = false;
> -    vdev->guest_features = 0;
> +    virtio_set_features_nocheck(vdev, 0);
>      vdev->queue_sel = 0;
> ------------
> Now virtio_reset() first clears all bits in vlans[], and then calls
> virtio_net_set_features(0) which sets all bits in vlans[]. And that causes
> all VLANs to be added to the filter table on boot.
> 
> I'm not sure how to fix this correctly. The QEMU boot is complex - the
> "clear vlans[], set vlans[]" sequence is repeated 5 times during the boot...

