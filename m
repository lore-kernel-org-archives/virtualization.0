Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B84BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 07:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED9AB6100C;
	Tue, 24 May 2022 07:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6IxvwjcN_xu; Tue, 24 May 2022 07:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CF5D60AB3;
	Tue, 24 May 2022 07:52:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30769C0032;
	Tue, 24 May 2022 07:52:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D490C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A6064099D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mxW10pPVxxuS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:52:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1A4A40922
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653378730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLiRBJigFuDJflEBL1yIFfpnc5pdYqpynwY7vvoEGYo=;
 b=JDX1Ahjhxz3F+4fo1DzMBu3Ycd+sW1N3dhJ7o+VmE+WtkUEglqL7HmxQFxd9rrQyJ2e3k3
 aq2JsTu1Xv8wxKWlqdH5y3PXulR7DFzbrhCpDKM+WPjxaKk3djAjYDbTa5Ze9+ubjeyVLc
 0TLAlMhzWAZPxs8aEydZqsrA7WgfaSU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-TclihP6NPLC4qLO6FO-MOg-1; Tue, 24 May 2022 03:52:09 -0400
X-MC-Unique: TclihP6NPLC4qLO6FO-MOg-1
Received: by mail-qv1-f69.google.com with SMTP id
 kk13-20020a056214508d00b004622b4b8762so4758828qvb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 00:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eLiRBJigFuDJflEBL1yIFfpnc5pdYqpynwY7vvoEGYo=;
 b=8PQhn3X2z4rstmT/FnXf49Z2PRZgVHrHP5VkzzxJa7q2jeWvTG/a+RHNcK6HbniSLa
 AiZX55SOgtVWloTUPJp0p3sSVemKpnj1HIe8DnKIvrVnkez0TGt3YJFPm0rz9sMrfSqi
 hzB+Io/CZeiNVDzrKEfOLJ653z6Rrhaa0Y/HSt88Hv4ZSPDNMw+OrYji+FoE2T7q4v9Y
 bswy4STFFcOJXPOggIPbucN+JRaqh/ZzLWE7DjXFOllcXcMvIQ2nTbVWF9PTywaM21QB
 iOaHrsiSF/TNI9dDnV3OxHy6GKMZRSegdiDCdjwMZJeEwSqjo5QTEaqQGfCueIsQdWP1
 EnHA==
X-Gm-Message-State: AOAM531dKQkNJht1iLF4gl0H4aEHlDS9Ra8J5d+D4p8QrcJlag9hNuFX
 xEJ9dW665M+69iZ7yApICH9Gn0ayuwHvO25UxFAjTbpygeXGFXvAKbcYqcvNFnOiZzKszBk0Pzr
 bC4Ma6Dy5MiYKIndMIjumbAQFd19KAr1tSYJFrBkZVw==
X-Received: by 2002:a05:622a:216:b0:2f9:30b3:45ee with SMTP id
 b22-20020a05622a021600b002f930b345eemr9051397qtx.397.1653378728050; 
 Tue, 24 May 2022 00:52:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgFlPc9qJ1j1IzDb/M0V3FRtH4WCnJY0MqJ/BAD5tylD1UiTiBef3dxP0vV+Ovsmsho5ZXvA==
X-Received: by 2002:a05:622a:216:b0:2f9:30b3:45ee with SMTP id
 b22-20020a05622a021600b002f930b345eemr9051362qtx.397.1653378727818; 
 Tue, 24 May 2022 00:52:07 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 o62-20020a37a541000000b006a34df5a9a9sm5288177qke.126.2022.05.24.00.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 May 2022 00:52:07 -0700 (PDT)
Date: Tue, 24 May 2022 09:51:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 1/4] vdpa: Add stop operation
Message-ID: <20220524075158.2vyuw7ga72xub7pp@sgarzare-redhat>
References: <20220520172325.980884-1-eperezma@redhat.com>
 <20220520172325.980884-2-eperezma@redhat.com>
 <79089dc4-07c4-369b-826c-1c6e12edcaff@oracle.com>
 <CAJaqyWd3BqZfmJv+eBYOGRwNz3OhNKjvHPiFOafSjzAnRMA_tQ@mail.gmail.com>
 <20220524070900.ak7a5frwtezjhhrq@sgarzare-redhat>
 <CAJaqyWeiNWnWUzEUEo8HeuuF8XMPtKw9SapxLxLJECWJ0zNTUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeiNWnWUzEUEo8HeuuF8XMPtKw9SapxLxLJECWJ0zNTUA@mail.gmail.com>
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

On Tue, May 24, 2022 at 09:42:06AM +0200, Eugenio Perez Martin wrote:
>On Tue, May 24, 2022 at 9:09 AM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>>
>> On Mon, May 23, 2022 at 09:20:14PM +0200, Eugenio Perez Martin wrote:
>> >On Sat, May 21, 2022 at 12:13 PM Si-Wei Liu <si-wei.liu@oracle.com> wro=
te:
>> >>
>> >>
>> >>
>> >> On 5/20/2022 10:23 AM, Eugenio P=E9rez wrote:
>> >> > This operation is optional: It it's not implemented, backend featur=
e bit
>> >> > will not be exposed.
>> >> >
>> >> > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>> >> > ---
>> >> >   include/linux/vdpa.h | 6 ++++++
>> >> >   1 file changed, 6 insertions(+)
>> >> >
>> >> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> >> > index 15af802d41c4..ddfebc4e1e01 100644
>> >> > --- a/include/linux/vdpa.h
>> >> > +++ b/include/linux/vdpa.h
>> >> > @@ -215,6 +215,11 @@ struct vdpa_map_file {
>> >> >    * @reset:                  Reset device
>> >> >    *                          @vdev: vdpa device
>> >> >    *                          Returns integer: success (0) or error=
 (< 0)
>> >> > + * @stop:                    Stop or resume the device (optional, =
but it must
>> >> > + *                           be implemented if require device stop)
>> >> > + *                           @vdev: vdpa device
>> >> > + *                           @stop: stop (true), not stop (false)
>> >> > + *                           Returns integer: success (0) or error=
 (< 0)
>> >> Is this uAPI meant to address all use cases described in the full blo=
wn
>> >> _F_STOP virtio spec proposal, such as:
>> >>
>> >> --------------%<--------------
>> >>
>> >> ...... the device MUST finish any in flight
>> >> operations after the driver writes STOP.  Depending on the device, it
>> >> can do it
>> >> in many ways as long as the driver can recover its normal operation
>> >> if it
>> >> resumes the device without the need of resetting it:
>> >>
>> >> - Drain and wait for the completion of all pending requests until a
>> >>    convenient avail descriptor. Ignore any other posterior descriptor.
>> >> - Return a device-specific failure for these descriptors, so the driv=
er
>> >>    can choose to retry or to cancel them.
>> >> - Mark them as done even if they are not, if the kind of device can
>> >>    assume to lose them.
>> >> --------------%<--------------
>> >>
>> >
>> >Right, this is totally underspecified in this series.
>> >
>> >I'll expand on it in the next version, but that text proposed to
>> >virtio-comment was complicated and misleading. I find better to get
>> >the previous version description. Would the next description work?
>> >
>> >```
>> >After the return of ioctl, the device MUST finish any pending operation=
s like
>> >in flight requests. It must also preserve all the necessary state (the
>> >virtqueue vring base plus the possible device specific states) that is =
required
>> >for restoring in the future.
>>
>> For block devices wait for all in-flight requests could take several
>> time.
>>
>> Could this be a problem if the caller gets stuck on this ioctl?
>>
>> If it could be a problem, maybe we should use an eventfd to signal that
>> the device is successfully stopped.
>>
>
>For that particular problem I'd very much prefer to add directly an
>ioctl to get the inflight descriptors. We know for sure we will need
>them, and it will be cleaner in the long run.

Makes sense!

>
>As I understand the vdpa block simulator, there is no need to return
>the inflight descriptors since all of the requests are processed in a
>synchronous way. So, for this iteration, we could offer the stop
>feature to qemu.

Right, the simulator handles everything synchronously.

>
>Other non-simulated devices would need it. Could it be delayed to
>future development?

Yep, sure, it sounds like you already have a plan, so no problem :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
