Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888B3E9F7D
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995602; cv=none; b=iI8Y3bUAU5130ItO4BIJIrLaVVoHJcmyLXwRM1pazuqIgXs3FqXhG1PoCwCBidcwgNkPpiIk2SisrSLo6Tdm2YYAKLXc3rNaQvS0mgCpoVnYy+OFIw8YN8epk0szsKfabk/qnpXkmXGNxbsq8LrUACL7+x7Oxt38++7IXdAu0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995602; c=relaxed/simple;
	bh=qmoNhyK9yyPC9k0+enrnkbihLoAqiBYIdxfL8zbSx2o=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=d2+SXXvNmhwI0AQziiJXGbtWIuFkxy9Wi9uhQJbd8x1CKud8scRnmnqsnbie258zdwzDKlOraxNVWcXBC2IyJATNRYP/CfYZ8yJP+4eh9/NSAvAUh54kgi4RiSWU5Qzt3LI9zkQ0xijxFeDClN4ybKb0Hbj6GJWHvypWd4TLEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzOhtoQ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzOhtoQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780995600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=+QgjNina6+iDumd0ZqzH0GRicPNFxNM+RIpD2R+Oo3E=;
	b=QzOhtoQ3Kkq9J+BZ9VXcZtTaytQZnyHW07Gukyzr0bdNG5D4ULMG23UcB/6wU6IaARQVPr
	ZKbr7sY6NawdK9fiCCjnGLWs9uEOOOOF9+klMZqBlxfVB4pMKQXzeeu6VgOPTiMIjtUxCq
	L3oX6Sm1qs4ECrDYl1b9/MaTztQ4Mh8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-zthBisuOPOqARJVb3OzsMg-1; Tue, 09 Jun 2026 04:59:57 -0400
X-MC-Unique: zthBisuOPOqARJVb3OzsMg-1
X-Mimecast-MFC-AGG-ID: zthBisuOPOqARJVb3OzsMg_1780995597
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so5933116a91.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995596; x=1781600396;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QA3zW7XVHGpx2witYnUAq2WhOCFAbuZqYNTeCXGJ/sI=;
        b=UnHpVj5c2gnqyHe5qcR+o5s1vB4RcG8v+WReZhDSq4YnLGMp2Vn/aoSpefmIvbwKIz
         zLQpvIiz+MS528bpXlX1ENYk0bd13nW+PvGQvSP54FhxtRZrzYRO2IKlcogb7t1Kdec9
         O7nmhzGIRMNKnr3B09n8aPP4G3RImy/N7WvL5mbr2ruU70mERFplNPfn1e6EcDGvM7qY
         v4MzP8oSH4sK3SatLidsUaUrHcVQ1TD6uINk6sXPcqpMgfrzquZqlvh0IiT1uv47htZ9
         srfN9/FzMVXrWoSpXOb9nJFr5ChhqxdJlTXD7KCOciTwOBudnMU/0c/32D8gdu6p1ORR
         0hcA==
X-Forwarded-Encrypted: i=1; AFNElJ9DRTKS87V2QSESi4U/uvCBBE7437OZAoeRxsOg2RLpxIZXgDMyb/c6ZoeEGx351nRSpzkPNStxxJwOXMm2jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylL6hW0ybh/cqYgrgwSAuCAvJzMpMhq65NQFKY9z/DnZzvaPJW
	E+hJQNPTxTGIEnAlKZXDO0yMuQiZonQ+e/6+mqhv+bNkGcc8RsW4XEsL021CCtf58R4anrQYty9
	xUf/mldFIPv3FJ4T7XQDM8LcYoYKG7W6nXvly11EAbcaozd3j33eeccNqfcmroj7zMldgvI1xVC
	7TU6zlxCQQiAHo8OM6A8WGeOogpbgC+t/TO/HAv6zOMSIpoKwCyFBGPrg=
X-Gm-Gg: Acq92OEyLF9xdJvIxs6ImV93sY8lqVj3EOfbUJbGVKy2e5gJI8R2atZoCMjUR3hvAIf
	p/1THN1bQOy28YtJetIrwiCHGwPbB2YR1yJzRV/Pl6QiaBXmQhLTiZJRZLNZuDm/a/xebURDiFD
	LAevst8C8JUxYIg2CTK1rlLRkFkWupyYSDldCXp1umXCD+1qKB3ETNPx5ZyipkrZxHIsXWhJsvL
	jczLvUvLpEU+YCYfu/zSCshZaP5xV/wkxegG3iblybN0ps7E4UytH0vQsJObxsWUbLB9uaiYDKu
	KPNMofGNIwnSmGmrRvfu4vx2OP61KGqVmPsiPlQ0BJIpTa7vo+kIxbdMYffj6nQOQCN26SqVomu
	ZJ28sNT/Mny27gonWHZSVF8xY/exvKomCjmpejRkXZlo/V7vHz2odUxQvE4HnEZN9GKcNdQ==
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-370ee82fe25mr20349294a91.6.1780995596515;
        Tue, 09 Jun 2026 01:59:56 -0700 (PDT)
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-370ee82fe25mr20349226a91.6.1780995595776;
        Tue, 09 Jun 2026 01:59:55 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d1fec5asm18472645a91.10.2026.06.09.01.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
	"David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
	"Gurchetan Singh" <gurchetansingh@chromium.org>, 
	"Chia-I Wu" <olvaffe@gmail.com>
In-Reply-To: <f3848234-4258-483f-bc27-cdd31f65e7aa@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/virtio: Fix driver removal with disabled KMS
Message-ID: <18b75e0e21e52581.f1a5ca06374b8df6.21049e9ba3a0559d@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Tue, 9 Jun 2026 08:59:52 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AT9akLz_72UL9fXqZXKUi8bj-dan_ChFLt8T6kIhlYs_1780995597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry

On 08/06/2026 21:40, Dmitry Osipenko wrote:
> Hi,
>=20
> On 6/7/26 07:31, Ryosuke Yasuoka wrote:
>> Hi Dmitry
>>=20
>> On 04/06/2026 15:27, Dmitry Osipenko wrote:
>>> DRM atomic and modesetting aren't initialized if virtio-gpu driver buil=
t
>>> with disabled KMS, leading to access of uninitialized data on driver
>>> removal/unbinding and crashing kernel. Fix it by skipping shutting down
>>> atomic core with unavailable KMS.
>>>
>>> Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/vir=
tio/virtgpu_drv.c
>>> index f0fb784c0f6f..2aaa7cb08085 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> @@ -138,7 +138,10 @@ static void virtio_gpu_remove(struct virtio_device=
 *vdev)
>>> =20
>>>  =09virtio_gpu_release_vqs(dev);
>>>  =09drm_dev_unplug(dev);
>>> -=09drm_atomic_helper_shutdown(dev);
>>> +
>>> +=09if (drm_core_check_feature(dev, DRIVER_ATOMIC))
>>> +=09=09drm_atomic_helper_shutdown(dev);
>>> +
>>>  =09virtio_gpu_deinit(dev);
>>>  =09drm_dev_put(dev);
>>>  }
>>=20
>> The patch looks good to me at a glance. I haven't done a full, deep code
>> review yet, but I've tested it on my lab and everything works as
>> expected.
>>=20
>> Tested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>=20
> Thanks a lot for the testing. The review from you will be very welcomed
> too.

I reviewed your patch and this change looks good to me.

Reviewed-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

Thank you!
Ryosuke

