Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C273A8D6
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921182; cv=none; b=jqWrqcQHreZHdeM0gAPKX8aD9BnAiIYe6aZcgVkcZBDk8G9Uer23x6LEmA53RmXRo+S8hfTMeT0TSCiqhymjBr2vKZxgZsRX++Tp5qBe4UdhVi532jKGUMfCtMBiU9qB65I3BtWDnbHy9p40u46hwVccMKPTW9WncUTlk+NAr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921182; c=relaxed/simple;
	bh=H8+0oGmT1ftop5dzo+lYC9GZSMNQe7I0qgI7wewaGEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bkQBx3OX8urHKKZUBJeKTRcnrMw6/13ymHMimfrVCwKaf2LM223EQfOm+6EfBZtZu5UK00ml5I62MAYZZQLiLmERqK+QLw1W1VI1mbmWS6u3tkeroB/MRw61WvsioaM+AgG6bQiKB4yun0qvFZjMPVCz6ywgjQLpUrLsWorIy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLtYIdOX; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLtYIdOX"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69E3E4160B
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69E3E4160B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NLtYIdOX
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Opdhljnq0y1q
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 10:59:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB522409EB
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:59:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB522409EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705921177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+Tgm+6aEKjbLWAfLwkUUYO3Q2T3Jk0qphDX8va9Dlw=;
	b=NLtYIdOX8i1N80DKh0CJN+UfEVJURMKhNt5ZIKGvJxnJf+MT9fPDvf2vqiLD51vSDklkZE
	NYtQY7PSE/Qt0t/iyV7+7CHCk68kIYD5APZqyqgqplJUbehbpHDsCJcmDn1AwT+81MNt/D
	NHHfRdVs7S6ONV4v9ynrnluQDdazEL8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-4AyRkF28O2uTWsrVjJmyfQ-1; Mon, 22 Jan 2024 05:59:36 -0500
X-MC-Unique: 4AyRkF28O2uTWsrVjJmyfQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6805a03aeaeso57971686d6.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 02:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921175; x=1706525975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+Tgm+6aEKjbLWAfLwkUUYO3Q2T3Jk0qphDX8va9Dlw=;
        b=WAEoNgVomvEk7B7T0IgxuDtmxmXZ+Nvk4+nZIv1bAL9SYFTwEt54BL6xtnLNKUg4sa
         9zsJ8Ss/hKFZFgI5H4IEzhFRumK2H7JtwXmJRZ3ddBNfZKO7V70qp5GytYGlVULa5MMQ
         UQoSMbpcB9gUSkR7tKCNbTSAxLFz4p5w9+KvKgm/01NXFqwJ+RC9ilYavmMAXcPXrGMI
         4WZJu8jAZkXxTh9TdbQRwm81rdqzkeiNcndV3g15QB8aUmw0u1x6Omm1h7MkJmYVTTU5
         B3R/osaYUpVZf8ojHV/5wR//eJfKy41GKRpZsyqjPOVQHrBVxxaZbQ92K95xWaJBqKtw
         1OZQ==
X-Gm-Message-State: AOJu0Yzl+i3ynhhUkNwqG1i83N3hsbbpgBgGEeRXtvRu9pT50FRohfVh
	58xKngVdqmrUGMCumsspy8brhlQibyZo1WVHqckUHJCI+oY6xFPn4//wowz6jhwyJrUEQXOWEt0
	Ue/g0pyGcNUXcIG+Y5CtpPQETbCkXBHsyZcFAdmJExBtwmNzQDlTcKC2LGhZfzFxc1133GAgAP2
	9ik14=
X-Received: by 2002:a0c:ca04:0:b0:685:d875:53ec with SMTP id c4-20020a0cca04000000b00685d87553ecmr3829488qvk.37.1705921175681;
        Mon, 22 Jan 2024 02:59:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQcdIroMe5Yc7Wgv1xTWcJhJLG24bKFVRn4maOUP+8QsosKBW1phA6nNLXjDSDlDYtS+9BMA==
X-Received: by 2002:a0c:ca04:0:b0:685:d875:53ec with SMTP id c4-20020a0cca04000000b00685d87553ecmr3829475qvk.37.1705921175397;
        Mon, 22 Jan 2024 02:59:35 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-71.business.telecomitalia.it. [87.12.25.71])
        by smtp.gmail.com with ESMTPSA id lb25-20020a056214319900b00685ba831e4bsm2035991qvb.118.2024.01.22.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:59:35 -0800 (PST)
Date: Mon, 22 Jan 2024 11:59:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: Re: [PATCH V1] vdpa_sim: reset must not run
Message-ID: <ouq2ntygn4i7gtld5utumipzggcakbqhu2hc5lbznoddhvezkk@jstz4h3vovej>
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
 <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
 <CAJaqyWcLj7Y0rm3_jdfP8KgS4gkE9ns286XJywBGE0iijMireQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcLj7Y0rm3_jdfP8KgS4gkE9ns286XJywBGE0iijMireQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 22, 2024 at 11:47:22AM +0100, Eugenio Perez Martin wrote:
>On Mon, Jan 22, 2024 at 11:22 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jan 17, 2024 at 11:23:23AM -0800, Steve Sistare wrote:
>> >vdpasim_do_reset sets running to true, which is wrong, as it allows
>> >vdpasim_kick_vq to post work requests before the device has been
>> >configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
>> >is set.
>> >
>> >Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
>> >Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> >Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>> >---
>> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>> > 1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >index be2925d0d283..6304cb0b4770 100644
>> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
>> >               }
>> >       }
>> >
>> >-      vdpasim->running = true;
>> >+      vdpasim->running = false;
>> >       spin_unlock(&vdpasim->iommu_lock);
>> >
>> >       vdpasim->features = 0;
>> >@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>> >
>> >       mutex_lock(&vdpasim->mutex);
>> >       vdpasim->status = status;
>> >+      vdpasim->running = (status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
>> >       mutex_unlock(&vdpasim->mutex);
>>
>> Should we do something similar also in vdpasim_resume() ?
>>
>> I mean something like this:
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index be2925d0d283..55e4633d5442 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -520,7 +520,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>>          int i;
>>
>>          mutex_lock(&vdpasim->mutex);
>> -       vdpasim->running = true;
>> +       vdpasim->running = (vdpasim->status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
>>
>>          if (vdpasim->pending_kick) {
>>                  /* Process pending descriptors */
>>
>> Thanks,
>> Stefano
>>
>
>The suspend and resume operation should not be called before
>DRIVER_OK, so maybe we should add that protection at
>drivers/vhost/vdpa.c actually?

Yeah, I think so!

Anyway, IMHO we should at least return an error in vdpa_sim if 
vdpasim_suspend/resume are called before DRIVER_OK (in another patch of 
course).

Stefano

