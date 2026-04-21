Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F42D23B9
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808213; cv=none; b=luXk15ZxvX79B8uW1+Co8POWaT0cmK45HMFVhrpCeWlNZ1MmhesBiicDLZVItIExLzi2UDpoXiPQLvJOgsUo6O/m2jZf/JhmdQmCkI4I+AvAvf2ZBCin+fn0M9kCFDrHVnkLCEdLtTlWM6fOIoXxnPZTPJVUsc8bHw9CVUKkMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808213; c=relaxed/simple;
	bh=0nUUR8I2aImDiVliu8mh26Afgb7OT3eAV4nQeOJ9X20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A6HJLN0id7Te9d0tlJ5MZssPToOVRbEp1bh9RyZL3QiNRhlqOI1KXwsN2G2VCczKaipiJ3Nn2lZSAIM/uyR4hF2o0G/pDE6Br3zOVSBj1t0D4GiSxt/qP3DNQDAwjF+lrP7uabbDPVjUehy295Wu4fmQ5O31xsMFIMfJUMi1xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YucPg08l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YucPg08l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkT6yxz2rU1VLImTOoGRlih0ZljZA1XkvvTLYlYGezA=;
	b=YucPg08lB0OxH2rOe9SESPn+/t0axguJXYwBakizrjlplPLpTFQZDaiwRn5ly9GIfL49zS
	D6applWXGQJJrWBhRMg7FTEW/QSjTGwSXzLzGxduncq916W5OktcpZ/2N1kW/AWewpiTMd
	SqpMoadCvCaWayT35ExPd+xOauwedzE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-f19E3KnrM7aKp0qctftYlA-1; Tue, 21 Apr 2026 17:50:09 -0400
X-MC-Unique: f19E3KnrM7aKp0qctftYlA-1
X-Mimecast-MFC-AGG-ID: f19E3KnrM7aKp0qctftYlA_1776808208
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a2ff53aso1459621f8f.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808208; x=1777413008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkT6yxz2rU1VLImTOoGRlih0ZljZA1XkvvTLYlYGezA=;
        b=W2OStECpWxdV7Y/o9P4JveH/xH5UEEV199ApvnVbC8rR1Bt1NAtmM4NFjGDrP/z7cw
         J6CVgchqvBW4CsmHs1XeM2OhO48ifiO0c942GkeQH/Z9zWZS36uiIEauxFOarzTeVJH1
         A+m2DZTym4W6ojBt46wr1GJslA1c7+LIunDS3A4ctX9nqoKGLwGHarVkcQXpynFGk2ps
         X1VwxgGAAlqzGUIn0hsJjbZC/l+YnClTxpOs0rnDjDj3FrPJb/YmYdWj3PmJ8VEQFxu1
         N6aaZJ82lvqfWjNhFBbFojsomudlDRRlw9bmLVrTvNXOJuqxzuayZ3yhda4WRNJpXO0a
         NLwg==
X-Forwarded-Encrypted: i=1; AFNElJ/D7cRZF1ubPhi0y6XPAdtxNbbVNbgBGcG6xRC35023rjgM4voJpBcNbWwAlYVbO5ko5/P9KMesS7mHU4j5yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzmkCTnOsVv6f9uy8cMjKGGWNrSy2hqqyvzUr0IEs5eQBREFRK
	pSVE6MNIo6IvgpG54ZWB+vfxU4iyHoDmNnX/HoVf1NHBGduCRsU4RcC1YWqsnuyHWIsHl0m9AGG
	1uJ+6FQDjEWiqn3uRuWvzt/4t7L3kGH+kXpK6vzFNDtAVifTzt1RF/71CvWQ833XntuZF
X-Gm-Gg: AeBDievu6RJitqvrfjJJK6D41bAKbO/jd1urhzkGeo1RUQyKRf/iI+E3EQFbOOBzRJI
	ahH7HJmq1wLy5hDM+0p2ubRvIgfcN9JJ5CSb/SrNl3OLVojDaHzWaySsNHIlGJPLP6ZwOS4jSLG
	/AeHu0MO0Jge0MQRPL6JzVbsWUCv8b4I9H+frEZimD3eih5bbAdRxx+R0diCac2O2GqHdglFK/h
	dI7UITMvVm90LIy2o8uHWSB/BVv+w3bNqdwMbSy/aGzShJC3Wj6Ac1NaXiqLdiFqTha3wHi6iRI
	6MMSWLxMz9cS2a4BcLrlyfIKHGPrSsvWKi6DJgCBKNZtK7USkLJxMg0t0kXlZwRjFiU1+viQ81Y
	pGSyFZWOGSZmOUIjDuW4WAsUz4SqlDnIz7K8Z1npw1PZcT1u1Y5WXKw==
X-Received: by 2002:a05:6000:2887:b0:43f:ea91:63ff with SMTP id ffacd0b85a97d-43fea916442mr23873621f8f.10.1776808208000;
        Tue, 21 Apr 2026 14:50:08 -0700 (PDT)
X-Received: by 2002:a05:6000:2887:b0:43f:ea91:63ff with SMTP id ffacd0b85a97d-43fea916442mr23873587f8f.10.1776808207506;
        Tue, 21 Apr 2026 14:50:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm44523269f8f.30.2026.04.21.14.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:50:07 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:50:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	jiaqiyan@google.com, rientjes@google.com, weixugc@google.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] virtio_pci: only store successfully populated
 virtio_pci_vq_info
Message-ID: <20260421174945-mutt-send-email-mst@kernel.org>
References: <20260407212521.934620-1-linkl@google.com>
 <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7S5dpxvo5Qni9brlzFYD0hHCPdb-7BW9NWDgJ6lcTNA_1776808208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 21, 2026 at 02:24:16PM -0700, Link Lin wrote:
> Hi everyone,
> 
> Friendly ping on this RFC patch. Please let me know if anyone has had a chance
> to look at this, or if any changes are needed.
> 
> Thanks,
> Link
> 
> On Tue, Apr 7, 2026 at 2:25 PM Link Lin <linkl@google.com> wrote:
> 
>     In environments where free page reporting is disabled, a kernel
>     panic is triggered when tearing down the virtio_balloon module:
> 
>       [12261.808190] Call trace:
>       [12261.808471]  __list_del_entry_valid_or_report+0x18/0xe0
>       [12261.809064]  vp_del_vqs+0x12c/0x270
>       [12261.809462]  remove_common+0x80/0x98 [virtio_balloon]
>       [12261.810034]  virtballoon_remove+0xfc/0x158 [virtio_balloon]
>       [12261.810663]  virtio_dev_remove+0x68/0xf8
>       [12261.811108]  device_release_driver_internal+0x17c/0x278
>       [12261.811701]  driver_detach+0xd4/0x138
>       [12261.812117]  bus_remove_driver+0x90/0xd0
>       [12261.812562]  driver_unregister+0x40/0x70
>       [12261.813006]  unregister_virtio_driver+0x20/0x38
>       [12261.813518]  cleanup_module+0x20/0x7a8 [virtio_balloon]
>       [12261.814109]  __arm64_sys_delete_module+0x278/0x3d0
>       [12261.814654]  invoke_syscall+0x5c/0x120
>       [12261.815086]  el0_svc_common+0x90/0xf8
>       [12261.815506]  do_el0_svc+0x2c/0x48
>       [12261.815883]  el0_svc+0x3c/0xa8
>       [12261.816235]  el0t_64_sync_handler+0x8c/0x108
>       [12261.816724]  el0t_64_sync+0x198/0x1a0
> 
>     The issue originates in vp_find_vqs_intx(). It kzalloc_objs() based
>     on the nvqs count provided by the caller, virtio_balloon::init_vqs().
>     However, it is not always the case that all nvqs number of
>     virtio_pci_vq_info objects will be properly populated.
> 
>     For example, when VIRTIO_BALLOON_F_FREE_PAGE_HINT is absent, the
>     VIRTIO_BALLOON_VQ_FREE_PAGE-th item in the vp_dev->vqs array is
>     actually never populated, and is still a zeroe-initialized
>     virtio_pci_vq_info object, which is eventually going to trigger
>     a __list_del_entry_valid_or_report() crash.
> 
>     Tested by applying this patch to a guest VM kernel with the
>     VIRTIO_BALLOON_F_REPORTING feature enabled and the
>     VIRTIO_BALLOON_F_FREE_PAGE_HINT feature disabled.
>     Without this patch, unloading the virtio_balloon module triggers a panic.
>     With this patch, no panic is observed.
> 
>     The fix is to use queue_idx to handle the case that vp_find_vqs_intx()
>     skips vp_setup_vq() when caller provided null vqs_info[i].name, when
>     the caller doesn't populate all nvqs number of virtqueue_info objects.
>     Invariantly queue_idx is the correct index to store a successfully
>     created and populated virtio_pci_vq_info object. As a result, now
>     a virtio_pci_device object only stores queue_idx number of valid
>     virtio_pci_vq_info objects in its vqs array when the for-loop over
>     nvqs finishes (of course, without goto out_del_vqs).
> 
>     vp_find_vqs_msix() has similar issue, so fix it in the same way.
> 
>     This patch is marked as RFC because we are uncertain if any virtio-pci
>     code implicitly requires virtio_pci_device's vqs array to always
>     contain nvqs number of virtio_pci_vq_info objects, and to store
>     zero-initialized virtio_pci_vq_info objects. We have not observed
>     any issues in our testing, but insights or alternatives are welcome!
> 
>     Signed-off-by: Link Lin <linkl@google.com>
>     Co-developed-by: Jiaqi Yan <jiaqiyan@google.com>
>     Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>     ---
>      drivers/virtio/virtio_pci_common.c | 10 ++++++----
>      1 file changed, 6 insertions(+), 4 deletions(-)
> 
>     diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/
>     virtio_pci_common.c
>     index da97b6a988de..9b32301529e5 100644
>     --- a/drivers/virtio/virtio_pci_common.c
>     +++ b/drivers/virtio/virtio_pci_common.c
>     @@ -423,14 +423,15 @@ static int vp_find_vqs_msix(struct virtio_device
>     *vdev, unsigned int nvqs,
>                             vqs[i] = NULL;
>                             continue;
>                     }
>     -               vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->
>     callback,
>     +               vqs[i] = vp_find_one_vq_msix(vdev, queue_idx, vqi->
>     callback,
>                                                  vqi->name, vqi->ctx, false,
>                                                  &allocated_vectors,
>     vector_policy,
>     -                                            &vp_dev->vqs[i]);
>     +                                            &vp_dev->vqs[queue_idx]);
>                     if (IS_ERR(vqs[i])) {
>                             err = PTR_ERR(vqs[i]);
>                             goto error_find;
>                     }
>     +               ++queue_idx;
>             }
> 
>             if (!avq_num)
>     @@ -485,13 +486,14 @@ static int vp_find_vqs_intx(struct virtio_device
>     *vdev, unsigned int nvqs,
>                             vqs[i] = NULL;
>                             continue;
>                     }
>     -               vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
>     +               vqs[i] = vp_setup_vq(vdev, queue_idx, vqi->callback,
>                                          vqi->name, vqi->ctx,
>     -                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs
>     [i]);
>     +                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs
>     [queue_idx]);
>                     if (IS_ERR(vqs[i])) {
>                             err = PTR_ERR(vqs[i]);
>                             goto out_del_vqs;
>                     }
>     +               ++queue_idx;
>             }
> 
>             if (!avq_num)
>     --
>     2.53.0.1213.gd9a14994de-goog
> 

I have this in my tree:

https://lore.kernel.org/all/20260315141808.547081-1-ammarfaizi2@openresty.com/


same?

-- 
MST

