Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90680C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 16:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EEC7817EB;
	Fri, 11 Nov 2022 16:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EEC7817EB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dc8PZQw0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XxVt27iLuC5k; Fri, 11 Nov 2022 16:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79C9C81437;
	Fri, 11 Nov 2022 16:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79C9C81437
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54876C0032;
	Fri, 11 Nov 2022 16:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFF00C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5E9340167
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:30:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5E9340167
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dc8PZQw0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lArHouKPss90
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4091B400E2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4091B400E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668184217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiAHvW1lwp0CJd5SRYZObGD0Bl407lB+/Pr36qn3nJ8=;
 b=dc8PZQw0uUH6RGwO84PGgs/1r+EI1jqOUPQxKqacT8ObYBdFxVtWqFiEBomx3t0W9rnbII
 41fJyVFI64HJiIfAo3mapPQ10rzuaeYZBzUqvsoI6MKQvjTYtQ4ZfuGb4oHvhWNIQSZkU7
 ZgCcOxpxqjTuGHHPwEY6lNbJf5vt2rM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-Rs32n07AMhivnTTPFvDemg-1; Fri, 11 Nov 2022 11:30:15 -0500
X-MC-Unique: Rs32n07AMhivnTTPFvDemg-1
Received: by mail-qv1-f71.google.com with SMTP id
 h1-20020a0ceda1000000b004b899df67a4so3960212qvr.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 08:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QiAHvW1lwp0CJd5SRYZObGD0Bl407lB+/Pr36qn3nJ8=;
 b=Lt/p9xOdGmGCBhNxpQbSoO4vGfnKM2yE8KKdIsGBNGmhZFG9ExXnBM7rC5bWXWECFs
 pbWC7Nwyr/3oMU7Vg4zexpV0be97WCwnqmY0kUa8baKJBDAmrIXEhhRv6VQna/v8eCmo
 EvPT7cnN0EQkZ/75UvxrkABZx/F+MpcmjByVLydMR2igooOJbh4cyQxZ4bVuiGDOGCS1
 y3m5E5Fj2GjtoKjEmdeB/+4gedyH1hsc2UbAxq5eD9Gim1yAE8iJWUWef74Y8ouGyZSY
 WYys4Xc5fV9EoUfqH5miomNy3zc/ZE113h867NHkfo3hBGUdH2neDCFRz0kDntvdw3KV
 2TLg==
X-Gm-Message-State: ANoB5pmVZJSYgFs2xCUTgwNk+iGSjAb+hW6/Y6uKYaZBPAYoTzoZWumc
 NK7niMRDY/JuKqZDnanxY+0zMmhh5Rlepzkm8LGWJn0OFYEwObKpDSSzp8tCeIKJfFo2DZhDhIl
 6fNhZ5JdlY0alrXXH8v14a3PMcjvaNz0NxJaoI99MsA==
X-Received: by 2002:ac8:72c4:0:b0:3a4:e32b:2f7e with SMTP id
 o4-20020ac872c4000000b003a4e32b2f7emr2011252qtp.320.1668184215307; 
 Fri, 11 Nov 2022 08:30:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf54BT35cnejvOXQWGDStq9BX5uwI1sP1wxyjss0lhi6HO25WV7hDVOfAJ76tOFzj+0UuIRBTQ==
X-Received: by 2002:ac8:72c4:0:b0:3a4:e32b:2f7e with SMTP id
 o4-20020ac872c4000000b003a4e32b2f7emr2011227qtp.320.1668184215057; 
 Fri, 11 Nov 2022 08:30:15 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 z17-20020ac86b91000000b0038d9555b580sm1454930qts.44.2022.11.11.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 08:30:14 -0800 (PST)
Date: Fri, 11 Nov 2022 17:30:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in
 vdpasim_queue_ready()
Message-ID: <20221111163007.35kvkodvk6zpimmu@sgarzare-redhat>
References: <20221110141335.62171-1-sgarzare@redhat.com>
 <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Nov 11, 2022 at 04:40:33PM +0100, Eugenio Perez Martin wrote:
>On Thu, Nov 10, 2022 at 3:13 PM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>>
>> When we initialize vringh, we should pass the features and the
>> number of elements in the virtqueue negotiated with the driver,
>> otherwise operations with vringh may fail.
>>
>> This was discovered in a case where the driver sets a number of
>> elements in the virtqueue different from the value returned by
>> .get_vq_num_max().
>>
>> In vdpasim_vq_reset() is safe to initialize the vringh with
>> default values, since the virtqueue will not be used until
>> vdpasim_queue_ready() is called again.
>>
>> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vd=
pa_sim.c
>> index b071f0d842fb..b20689f8fe89 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasi=
m, unsigned int idx)
>>  {
>>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
>>
>> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_featur=
es,
>> -                         VDPASIM_QUEUE_MAX, false,
>> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>>                           (struct vring_avail *)
>>                           (uintptr_t)vq->driver_addr,
>> --
>> 2.38.1
>>
>
>I think this is definitely an improvement, but I'd say we should go a
>step further and rename VDPASIM_QUEUE_MAX to VDPASIM_QUEUE_DEFAULT. As
>you point out in the patch message it is not a max anymore.

I'm not sure about renaming since it is the value returned by =

vdpasim_get_vq_num_max, so IMHO the _MAX suffix is fine.
But I admit that initially I didn't understand whether it's the maximum =

number of queues or elements, so maybe VDPASIM_VQ_NUM_MAX is better.

>
>Another thing to note is that we don't have a way to report that
>userspace indicated a bad value for queue length. With the current
>code vringh will not initialize at all if I'm not wrong, so we should
>prevent userspace to put a bad num.

Right!

>
>Ideally, we should repeat the tests of vring_init_kern at
>vdpasim_set_vq_num. We could either call it with NULL vring addresses
>to check for -EINVAL, or simply repeat the conditional (!num || num >
>0xffff || (num & (num - 1))). I'd say the first one is better to not
>go out of sync.

Or we could do the check in vdpasim_set_vq_ready() and set it not ready =

if the vq_num is wrong.

>
>All of that can be done on top anyway, so for this patch:
>
>Acked-by: Eugenio P=E9rez <eperezma@redhat.com>
>

Thanks for the review,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
