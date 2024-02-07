Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F04208AD
	for <virtualization@lists.linux.dev>; Wed,  7 Feb 2024 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295173; cv=none; b=jzj0R5XSaajHfbcF6bqMBNo3EixkNDPYUrNdsE0Wg4HCsZ1pSP1QndIM2ULGLyf3l3jEGYf5t0NKwfGVq22ZoAcophYuZ7bNqNIyhoEHM2f058UY74Z0i4wQwlJADHXTFGUpiLjLruiERgQEzVo1ssxEnNr8HkuXt9PiOJg0ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295173; c=relaxed/simple;
	bh=ac9WGCOPPgNEkiYYzCiJVtWgr45GmwAPXfRv3awco68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dxe4BQMUqjYV1hfKaYzVseS8CooAwhGf+4G3WCpBcyv698t5jCaJX5seaL2JuMbe8vwYTgWIePPhKXAYp2+sJ7+gYzUCzINIte0vrz9DCJzvxaQC4HGCGqX9AaTukaiv40AhN60DLUCWMZ0JTzZOtr9Iv9QuDmuZdxzWFgyenFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4e1Ky6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4e1Ky6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707295170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAXzbRx8bTrXW8mIoidP0h+87BdFw4xKcLSssnrU6kI=;
	b=L4e1Ky6jhp3jBT29f84WPeXIe22+kt5BaQBFJGITZpxJRMIsM4zdpZ9vsKdkD9hW/qz+lC
	IeQ4qDL6F465pAQ9cyvlVGSOKlq1jwaZsQUAx7/RIOM8Te8O6LV9MARs/eaA0cAaJfSUj0
	kRaysZzk3TULt8sG9wRcro3VLX+gdyU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-06ZHRS91NEi2FCA0e8TYPw-1; Wed, 07 Feb 2024 03:39:29 -0500
X-MC-Unique: 06ZHRS91NEi2FCA0e8TYPw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5601e5ed21aso155895a12.1
        for <virtualization@lists.linux.dev>; Wed, 07 Feb 2024 00:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295168; x=1707899968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAXzbRx8bTrXW8mIoidP0h+87BdFw4xKcLSssnrU6kI=;
        b=UB/MWVjZuTYxgDVJ/+uPgKtBaMkmQFcTCOg4FcIcVqrSuGtn2Mdp7fHw9E9lUi2oIT
         GFMyivkTMY9fQgQXf8/PeD4bRxdZWYrzPp52AfkDZFdCkuHterCeiU7iIcUqqBHy4NCe
         bNv3CtPBUMxMAhuFNiiVxG18txwor1zrR1NLYc2D1PYGca2lHJiH4jVYOTRDrAU9UnmA
         Mweo/lntahDnPTixu6n+idi/Rtm0ZhMoisnO55DxvU2/61CqWes83XTxr2gv3Xcnhbh0
         pKDC8oQmkXtxt86SzRzKaOcMb/YUhxB91hbaQxpdKvFYVzPbS7Hea5b/6rXBUEBnNGri
         xCNg==
X-Gm-Message-State: AOJu0YytmdMYNt8JeW/lz3cv7QXHpWahQ3vjWrxGh1I7hwLxXsClUBGh
	mJm+0VdkyVmBtyzdNTEmNMWUOLM2Xyxjw5pRWkc/GymGRT9YChxa+ZvU32kpWiA291UQZnRJy8o
	3SsEOPhDvvi/VvqqILaXrnp4EE5c0iStoRGj5cS6lRGMM0tU815ws5Gr8hV+IOjh+
X-Received: by 2002:a05:6402:5154:b0:560:5fbb:a148 with SMTP id n20-20020a056402515400b005605fbba148mr3754143edd.39.1707295168127;
        Wed, 07 Feb 2024 00:39:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2NsvT4sc6tbDBunK98s9BxDYPuRaNGFxjLy/cDFmkZ9+vFiimAUV20Le1jH9Jq916ADH4gw==
X-Received: by 2002:a05:6402:5154:b0:560:5fbb:a148 with SMTP id n20-20020a056402515400b005605fbba148mr3754124edd.39.1707295167716;
        Wed, 07 Feb 2024 00:39:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmXD5gssWICrqVD4rXZExDudFbZYFR2RZeq+rMKAk4PNSqGJyVYi6dsTVcI41S1tFy7j/DSDMaVpAcS9U7JjFFrFdzxKjDIdVHlAXE6d4jIuNlpUNS+z/cs4AWYEg6ZJg9Zu+TQlheXCLTqcQkGgHV16qh2Thea3iaajmeXxbjQPhbXP68udVDcEOvSjb3S+jS6lJYMv6Uef0o/GdexErkRX7VNSNlJ9v8KyxR1BgFmBCJYoHi7E38rkAbeqhN7wHPNwm8f4vmtyF+G+2TrI7oBd8KtDmTS+ITz7MV45g6hA==
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it. [87.12.25.87])
        by smtp.gmail.com with ESMTPSA id 15-20020a0564021f4f00b00560622cd10fsm424307edz.68.2024.02.07.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:39:27 -0800 (PST)
Date: Wed, 7 Feb 2024 09:39:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, 
	Shannon Nelson <shannon.nelson@amd.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain
 conditions
Message-ID: <wixps4w7rnbd67t5is6wtqvuw7e3waat4no3embl3vnjimtxvz@pemiyojtmunz>
References: <20240206145154.118044-1-sgarzare@redhat.com>
 <CACGkMEs-FAz7Xv7j6k3grq97q9qO18Em2bLDS4qBaCDZS7+gbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs-FAz7Xv7j6k3grq97q9qO18Em2bLDS4qBaCDZS7+gbQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 07, 2024 at 11:27:14AM +0800, Jason Wang wrote:
>On Tue, Feb 6, 2024 at 10:52 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
>> the driver to enable virtqueue before setting DRIVER_OK. If the driver
>> tries anyway, better to fail right away as soon as we get the ioctl.
>> Let's also update the documentation to make it clearer.
>>
>> We had a problem in QEMU for not meeting this requirement, see
>> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/
>
>Maybe it's better to only enable cvq when the backend supports
>VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK. Eugenio, any comment on this?
>
>>
>> Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
>> Cc: eperezma@redhat.com
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/uapi/linux/vhost_types.h | 3 ++-
>>  drivers/vhost/vdpa.c             | 4 ++++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>> index d7656908f730..5df49b6021a7 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
>>  /* Device can be resumed */
>>  #define VHOST_BACKEND_F_RESUME  0x5
>>  /* Device supports the driver enabling virtqueues both before and after
>> - * DRIVER_OK
>> + * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
>> + * enabled before setting DRIVER_OK.
>>   */
>>  #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
>>  /* Device may expose the virtqueue's descriptor area, driver area and
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index bc4a51e4638b..1fba305ba8c1 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>>         case VHOST_VDPA_SET_VRING_ENABLE:
>>                 if (copy_from_user(&s, argp, sizeof(s)))
>>                         return -EFAULT;
>> +               if (!vhost_backend_has_feature(vq,
>> +                       VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
>> +                   (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +                       return -EINVAL;
>
>As discussed, without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we don't
>know if parents can do vq_ready after driver_ok.
>
>So maybe we need to keep this behaviour to unbreak some "legacy" userspace?

I'm not sure it's a good idea, since "legacy" userspace are currently 
broken if used with VDUSE device. So we need to fix userspace in any 
case, and IMHO is better if we start to return an error, so the user 
understands what went wrong, because the problem in QEMU took us quite 
some time to figure out that we couldn't enable vq after DRIVER_OK.

Since userspace is unable to understand if a vhost-vdpa device is VDUSE 
or not, I think we have only 2 options either merge this patch or fix 
VDUSE somehow. But the last one I think is more complicated/intrusive.

Thanks,
Stefano

>
>For example ifcvf did:
>
>static void ifcvf_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev,
>                                    u16 qid, bool ready)
>{
>  struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>
>        ifcvf_set_vq_ready(vf, qid, ready);
>}
>
>And it did:
>
>void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready)
>{
>        struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
>
>        vp_iowrite16(qid, &cfg->queue_select);
>        vp_iowrite16(ready, &cfg->queue_enable);
>}
>
>Though it didn't advertise VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK?
>
>Adding LingShan for more thought.
>
>Thanks
>
>>                 ops->set_vq_ready(vdpa, idx, s.num);
>>                 return 0;
>>         case VHOST_VDPA_GET_VRING_GROUP:
>> --
>> 2.43.0
>>
>

