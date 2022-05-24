Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D0C43219
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 07:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B27D182F6F;
	Tue, 24 May 2022 07:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AWSH7g55hHUi; Tue, 24 May 2022 07:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25C7A82EB4;
	Tue, 24 May 2022 07:09:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB910C0032;
	Tue, 24 May 2022 07:09:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16907C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F21CF82EB6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0vOFGrrlnW-x
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 279BF82EB4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653376160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jg/VQp3/7T8NXHS/IRW4J+wxsI4fOnWx/NzDoP4bWw=;
 b=PRFGS23FPUppYbwehK/5x15ZALuRx8JBD1sS6Umg5phe9r+oV6pmwJ55aqtu+i7JJSelqI
 y7LvvZXvq/7DHGBAfb8kTjD88JTspKdUMB2keyGSsenDLsNRn82Cqp1iQHfup+nQ5UaXaz
 DoJseQ9xYK3DL2pqjiq3nYyoLLbLxW0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-EDBmUxLDOh6xKKen0fSs6g-1; Tue, 24 May 2022 03:09:19 -0400
X-MC-Unique: EDBmUxLDOh6xKKen0fSs6g-1
Received: by mail-qt1-f197.google.com with SMTP id
 m6-20020ac866c6000000b002f52f9fb4edso13266624qtp.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 00:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4Jg/VQp3/7T8NXHS/IRW4J+wxsI4fOnWx/NzDoP4bWw=;
 b=ezpYh2tfrHGeHoFuELbAtHkVJ4jBCR6Sm8LjFdrThv28lELS++TrPmiM7aNE58ooTM
 bAxM5QXqkI8VybeLV0Mg51CX25sg1cdrLNpdpRW6/lGZLPwZBPQQDbACW5IlN5O+ecjQ
 YOOYutOSuhKK7aH2vizh1kXhk9XhXFTCOQNZkoFWmSKAXyIFBN+HjdcvUT8eneyLtKkm
 U8PwhlN/HiIVmU+jMlcpzlqCPi/Mz9s0YfNL+jLev7zB7gUOvsEidfvF3DELe3h0C9l6
 uchb8zPNTT52HaOsNn2sMxy9Wx839bM5A4VCaKpslZyjdGrdpniULEFAJ/M0SvVD0izf
 iugQ==
X-Gm-Message-State: AOAM53330s8J7EEqVlyMIjxITKt4grDH3L7iUTHjw9XK0TP+hfU7OIVM
 lHRn6rdphmQDjTWGr63EC6C7IS/V0WizZEmAm4M2h9FVlt9d+wIM82xo+PWfDuMxB5p+pXmUbAW
 os6VgXiT7juch77F2yVIO7i+md8iCqzwlp7IYxU8WsQ==
X-Received: by 2002:a05:6214:194e:b0:45a:d8e3:2d3f with SMTP id
 q14-20020a056214194e00b0045ad8e32d3fmr19980110qvk.59.1653376151734; 
 Tue, 24 May 2022 00:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7GaMbEtJARwuaEZHhi6Q4+UwgAVZKJMVkhQCWvjA6aMpUiA710enlZjHGU7oXX2vN4IPk8A==
X-Received: by 2002:a05:6214:194e:b0:45a:d8e3:2d3f with SMTP id
 q14-20020a056214194e00b0045ad8e32d3fmr19980097qvk.59.1653376151522; 
 Tue, 24 May 2022 00:09:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 bs40-20020a05620a472800b006a34918ea64sm6589755qkb.98.2022.05.24.00.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 May 2022 00:09:10 -0700 (PDT)
Date: Tue, 24 May 2022 09:09:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 1/4] vdpa: Add stop operation
Message-ID: <20220524070900.ak7a5frwtezjhhrq@sgarzare-redhat>
References: <20220520172325.980884-1-eperezma@redhat.com>
 <20220520172325.980884-2-eperezma@redhat.com>
 <79089dc4-07c4-369b-826c-1c6e12edcaff@oracle.com>
 <CAJaqyWd3BqZfmJv+eBYOGRwNz3OhNKjvHPiFOafSjzAnRMA_tQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd3BqZfmJv+eBYOGRwNz3OhNKjvHPiFOafSjzAnRMA_tQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 pabloc@xilinx.com, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 Harpreet Singh Anand <hanand@xilinx.com>, martinpo@xilinx.com, "Dawar,
 Gautam" <gautam.dawar@amd.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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

On Mon, May 23, 2022 at 09:20:14PM +0200, Eugenio Perez Martin wrote:
>On Sat, May 21, 2022 at 12:13 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>>
>> On 5/20/2022 10:23 AM, Eugenio P=E9rez wrote:
>> > This operation is optional: It it's not implemented, backend feature b=
it
>> > will not be exposed.
>> >
>> > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>> > ---
>> >   include/linux/vdpa.h | 6 ++++++
>> >   1 file changed, 6 insertions(+)
>> >
>> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> > index 15af802d41c4..ddfebc4e1e01 100644
>> > --- a/include/linux/vdpa.h
>> > +++ b/include/linux/vdpa.h
>> > @@ -215,6 +215,11 @@ struct vdpa_map_file {
>> >    * @reset:                  Reset device
>> >    *                          @vdev: vdpa device
>> >    *                          Returns integer: success (0) or error (<=
 0)
>> > + * @stop:                    Stop or resume the device (optional, but=
 it must
>> > + *                           be implemented if require device stop)
>> > + *                           @vdev: vdpa device
>> > + *                           @stop: stop (true), not stop (false)
>> > + *                           Returns integer: success (0) or error (<=
 0)
>> Is this uAPI meant to address all use cases described in the full blown
>> _F_STOP virtio spec proposal, such as:
>>
>> --------------%<--------------
>>
>> ...... the device MUST finish any in flight
>> operations after the driver writes STOP.  Depending on the device, it
>> can do it
>> in many ways as long as the driver can recover its normal operation =

>> if it
>> resumes the device without the need of resetting it:
>>
>> - Drain and wait for the completion of all pending requests until a
>>    convenient avail descriptor. Ignore any other posterior descriptor.
>> - Return a device-specific failure for these descriptors, so the driver
>>    can choose to retry or to cancel them.
>> - Mark them as done even if they are not, if the kind of device can
>>    assume to lose them.
>> --------------%<--------------
>>
>
>Right, this is totally underspecified in this series.
>
>I'll expand on it in the next version, but that text proposed to
>virtio-comment was complicated and misleading. I find better to get
>the previous version description. Would the next description work?
>
>```
>After the return of ioctl, the device MUST finish any pending operations l=
ike
>in flight requests. It must also preserve all the necessary state (the
>virtqueue vring base plus the possible device specific states) that is req=
uired
>for restoring in the future.

For block devices wait for all in-flight requests could take several =

time.

Could this be a problem if the caller gets stuck on this ioctl?

If it could be a problem, maybe we should use an eventfd to signal that =

the device is successfully stopped.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
