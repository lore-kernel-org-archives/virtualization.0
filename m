Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381063451C1
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808066; cv=pass; b=glYHCddyu6LbygSVgx0KzXaPKa6YWz/VT1At7hdGyGnw1zRSa7IMMlNPM1VmBB3b8yVfn7oZWFmpnyS1ZSvmNd0JsVCqqmk7CTjAuG55bYYZ+hbQhoiuZncNcOAFefebdrynXJEqa5lssdMgJ8zf8bBOji8hwoOgJx5D4N7wYkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808066; c=relaxed/simple;
	bh=4Oxw6LGpu8RTKw5kwejvt9ouUw2sk/BVGFdK0UFFwHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwD0gikfoSRKsfhv5d0GCTQMmCSBT20KMbeEO9A2/IyzzeMnhjcRyKJclobEn54XupC+C1W3iLBry5WHRJRYQVK8SYtDDfWOvRbHuI83cuGRBsgdSna0lS8i/F5YgefP5Yzr7DOxzTbRbzuShCzFi8KYTnHfb+Uw/RmrH2+QS0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIbYLHwY; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIbYLHwY"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d864c23bdso2564281cf.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776808064; cv=none;
        d=google.com; s=arc-20240605;
        b=ctHYB9aSowfnUL3UhoA7X7H5owEZ9221w2DRQfgWM1xX8AYzfx7bfCt/V29g4Z2eAc
         8ywPbvyaxvK19h60Vr3u/JoGr90tlKeKvEcBeLFswKOiOS5L4rTa74Ptte32ZWtZZlsp
         OBJHVABBTZ/7UWlwYIzsh8mkCowrTRhxwEAmrNdJnZlkR5Mluid9b3B4+mmpyhGXaCaG
         Ge+A+epGZ0wYDiQPUxtZww78ijZOVcUPDBjRjU5jDjrKXxcuf1U9sG7zcrvYsUxGOfiw
         0ViQEjVeTw2fafsKGukC0jt4KFvFtMIPbmbGGZesPF1Qb/LGDb/BrFvs3vBRQazv5+1b
         9qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VE4UOSZ7NumAlH9D0q/aqdP2qC2HKhPCfoqZLGG6I/8=;
        fh=3ZOOvx5TT7vbIC17LlyWQZDFLyud6cAofYq4fSPE9OA=;
        b=SOKjA6RAfTNOXM5pX2XXxJ2kobX81aXhHLdyHLDsT+hi7f4L7tSYTBxaOOIppf8Szb
         t45JD7iMx+B83kRcbAy7Koeir+zTRtkaZVIgQXl1FueyDD/qyO3ldM+TbmTsRGi8o90M
         ekT8E7kHfaoElgVGpagvhW9tw6shnmv4Q01qZQYV8XesBp1QUcrz7Sj8AA32f8QybaTf
         ip670LWAIVo5G/Fx6mOd1c25oPF8zK2p5ywVPAKc52Ic1W+q3JbNpBrBEMgEAvh8dA2L
         HiiDsZp2192t2H9eeC+DXLJ8uB/5mwwrbIiLXhZCukehuCd5aUyGXBrFxdcIHCCKMly0
         JHJw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776808064; x=1777412864; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE4UOSZ7NumAlH9D0q/aqdP2qC2HKhPCfoqZLGG6I/8=;
        b=mIbYLHwYXLsQOUaHQ9PlAnfY8l3s0vHQqe+kpPTsnLOlXoR5Tx3qz+YqDiVtUkAH+S
         sJjzjbshlrSICKCq3xRQEtTR/8lT9XrP71mqv+0bom4YUAeYOJDoWKC2rNJHkGcgJJb5
         5yJCMUNdG8bKPcD7eOpj7D3aNkqGJspgNJVklJ4EY0K82G+oWV+SjeNnf+DIuCUwRiY6
         uH6kebNLmFZsmtxDf7DQx5iHGTrQjAgd05o2iqsHJeh9O3kewiw2ZgILKytiT+ehAErC
         wqhao//ct/gKwhLKBi2MEIm9dbhCGGnzUrGgUNAY/HzxB74+zIHw2Ljii4R5CnWsgBs3
         LFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808064; x=1777412864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VE4UOSZ7NumAlH9D0q/aqdP2qC2HKhPCfoqZLGG6I/8=;
        b=MFiMnX5+cdowJ6GmGJb/CsRn438elSL5pPjSAYmSXc+9w5y+S7+enBjo26E3nO+A7L
         JYXkRYOvpPudcnTSLAWftY+7HbNw4qcM2V10IX53I2K/1Tt58sEsufuD4oQ6oe1Ue6Pu
         bcKpfrol9EcHR6G0t2TTy42bwV+JwvSourqdzUcGcNih65YDG5hpzADRksAK1nV6owrf
         DKZebRRZ05Eljr7DKIJr4zhymFE+UxevDRuamMLXrBnnrUxgRPR4VGYKfx/Wloq48hJ5
         GPXYF3dWTlEL5S9Xeb7n8D1QUYuE/DQaydqva4FVSka07eM94Fckcj8mnycSG0VjIsr1
         BH5g==
X-Forwarded-Encrypted: i=1; AFNElJ/U4i2+iR9z75AR9OvwxAJmsVc/NF6kLiiyTlAt7ssxcSddH5G/zOEv3ESDvgWkuk38VWSYpDj5arzkH5CjSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGN9OZhQ25yk+lyfnqLTko6SY9LPg4r0VnNIJ7xzKgCp4fvRMl
	Va9M8eQha1arndi9WlA0CJ39dWbyN6rHtHhxI5urjkhSWiGOGhz2SK5XBZCjvkcx8BL63d3hpWf
	WwcYDIEv/pftvTrVUBUV2/lCnn4LiEKfFlAA8r6wy
X-Gm-Gg: AeBDieveDgPFM42jHEvnwgjuqwRYIuxyyitxiFPoi2DlP2KYtitl88t6OtuJXhcfSnw
	jkMUHWpt8nYUAzXEtmAk2+q0OgccHw8Uk64VSI4z397vkcwpfgG4JhAAph8UvtlPSATQwxhPG1m
	QFVIa+jM2wWp3L1oAE5F606ksqtg3KnaloFK1F22kof2+NDmWG5IaTk4YcOyjDpJ9T/PGoISHdV
	AX32VAUFIfD9etKz17QZA06qTuF+SKP1N2cH4oVmQoOsJKS8OHLRAo+OOE80yHaPX/TjkPKvPLa
	ScaNkCo9sonyztmWx/QiyaTq38nCJ8r0UI2s6aPXirKtqyx71CIlBak=
X-Received: by 2002:a05:622a:1f17:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-50e5ebad291mr7256901cf.2.1776808063721; Tue, 21 Apr 2026
 14:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260407212521.934620-1-linkl@google.com> <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
In-Reply-To: <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
From: Link Lin <linkl@google.com>
Date: Tue, 21 Apr 2026 14:47:32 -0700
X-Gm-Features: AQROBzA_v1mfepZVcCvM1JWvyJKoqHaIIdFG8hC-KslNeutAp7qSyJfJAJPI-nQ
Message-ID: <CALUx4KTPcRCGvyvJfHSU_t61UJOuTBaAGxJ6nhUuaghE0_ZfUg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] virtio_pci: only store successfully populated virtio_pci_vq_info
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: eperezma@redhat.com, jiaqiyan@google.com, rientjes@google.com, 
	weixugc@google.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Friendly ping. Apologies if you are getting this the second time - my
last ping wasn't in plain text mode and got rejected by some mailing
lists.

Please let me know if anyone has had a chance to look at this RFC
patch, or if any changes are needed.

Thanks,
Link

On Tue, Apr 21, 2026 at 2:24=E2=80=AFPM Link Lin <linkl@google.com> wrote:
>
> Hi everyone,
>
> Friendly ping on this RFC patch. Please let me know if anyone has had a c=
hance to look at this, or if any changes are needed.
>
> Thanks,
> Link
>
> On Tue, Apr 7, 2026 at 2:25=E2=80=AFPM Link Lin <linkl@google.com> wrote:
>>
>> In environments where free page reporting is disabled, a kernel
>> panic is triggered when tearing down the virtio_balloon module:
>>
>>   [12261.808190] Call trace:
>>   [12261.808471]  __list_del_entry_valid_or_report+0x18/0xe0
>>   [12261.809064]  vp_del_vqs+0x12c/0x270
>>   [12261.809462]  remove_common+0x80/0x98 [virtio_balloon]
>>   [12261.810034]  virtballoon_remove+0xfc/0x158 [virtio_balloon]
>>   [12261.810663]  virtio_dev_remove+0x68/0xf8
>>   [12261.811108]  device_release_driver_internal+0x17c/0x278
>>   [12261.811701]  driver_detach+0xd4/0x138
>>   [12261.812117]  bus_remove_driver+0x90/0xd0
>>   [12261.812562]  driver_unregister+0x40/0x70
>>   [12261.813006]  unregister_virtio_driver+0x20/0x38
>>   [12261.813518]  cleanup_module+0x20/0x7a8 [virtio_balloon]
>>   [12261.814109]  __arm64_sys_delete_module+0x278/0x3d0
>>   [12261.814654]  invoke_syscall+0x5c/0x120
>>   [12261.815086]  el0_svc_common+0x90/0xf8
>>   [12261.815506]  do_el0_svc+0x2c/0x48
>>   [12261.815883]  el0_svc+0x3c/0xa8
>>   [12261.816235]  el0t_64_sync_handler+0x8c/0x108
>>   [12261.816724]  el0t_64_sync+0x198/0x1a0
>>
>> The issue originates in vp_find_vqs_intx(). It kzalloc_objs() based
>> on the nvqs count provided by the caller, virtio_balloon::init_vqs().
>> However, it is not always the case that all nvqs number of
>> virtio_pci_vq_info objects will be properly populated.
>>
>> For example, when VIRTIO_BALLOON_F_FREE_PAGE_HINT is absent, the
>> VIRTIO_BALLOON_VQ_FREE_PAGE-th item in the vp_dev->vqs array is
>> actually never populated, and is still a zeroe-initialized
>> virtio_pci_vq_info object, which is eventually going to trigger
>> a __list_del_entry_valid_or_report() crash.
>>
>> Tested by applying this patch to a guest VM kernel with the
>> VIRTIO_BALLOON_F_REPORTING feature enabled and the
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT feature disabled.
>> Without this patch, unloading the virtio_balloon module triggers a panic=
.
>> With this patch, no panic is observed.
>>
>> The fix is to use queue_idx to handle the case that vp_find_vqs_intx()
>> skips vp_setup_vq() when caller provided null vqs_info[i].name, when
>> the caller doesn't populate all nvqs number of virtqueue_info objects.
>> Invariantly queue_idx is the correct index to store a successfully
>> created and populated virtio_pci_vq_info object. As a result, now
>> a virtio_pci_device object only stores queue_idx number of valid
>> virtio_pci_vq_info objects in its vqs array when the for-loop over
>> nvqs finishes (of course, without goto out_del_vqs).
>>
>> vp_find_vqs_msix() has similar issue, so fix it in the same way.
>>
>> This patch is marked as RFC because we are uncertain if any virtio-pci
>> code implicitly requires virtio_pci_device's vqs array to always
>> contain nvqs number of virtio_pci_vq_info objects, and to store
>> zero-initialized virtio_pci_vq_info objects. We have not observed
>> any issues in our testing, but insights or alternatives are welcome!
>>
>> Signed-off-by: Link Lin <linkl@google.com>
>> Co-developed-by: Jiaqi Yan <jiaqiyan@google.com>
>> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>> ---
>>  drivers/virtio/virtio_pci_common.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_=
pci_common.c
>> index da97b6a988de..9b32301529e5 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -423,14 +423,15 @@ static int vp_find_vqs_msix(struct virtio_device *=
vdev, unsigned int nvqs,
>>                         vqs[i] =3D NULL;
>>                         continue;
>>                 }
>> -               vqs[i] =3D vp_find_one_vq_msix(vdev, queue_idx++, vqi->c=
allback,
>> +               vqs[i] =3D vp_find_one_vq_msix(vdev, queue_idx, vqi->cal=
lback,
>>                                              vqi->name, vqi->ctx, false,
>>                                              &allocated_vectors, vector_=
policy,
>> -                                            &vp_dev->vqs[i]);
>> +                                            &vp_dev->vqs[queue_idx]);
>>                 if (IS_ERR(vqs[i])) {
>>                         err =3D PTR_ERR(vqs[i]);
>>                         goto error_find;
>>                 }
>> +               ++queue_idx;
>>         }
>>
>>         if (!avq_num)
>> @@ -485,13 +486,14 @@ static int vp_find_vqs_intx(struct virtio_device *=
vdev, unsigned int nvqs,
>>                         vqs[i] =3D NULL;
>>                         continue;
>>                 }
>> -               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callback,
>> +               vqs[i] =3D vp_setup_vq(vdev, queue_idx, vqi->callback,
>>                                      vqi->name, vqi->ctx,
>> -                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[=
i]);
>> +                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[=
queue_idx]);
>>                 if (IS_ERR(vqs[i])) {
>>                         err =3D PTR_ERR(vqs[i]);
>>                         goto out_del_vqs;
>>                 }
>> +               ++queue_idx;
>>         }
>>
>>         if (!avq_num)
>> --
>> 2.53.0.1213.gd9a14994de-goog
