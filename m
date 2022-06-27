Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DC7C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 08:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E523E82D75;
	Mon, 27 Jun 2022 08:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E523E82D75
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a3/WyQeA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1G2w5E-dPxbP; Mon, 27 Jun 2022 08:44:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7FB8F825E8;
	Mon, 27 Jun 2022 08:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FB8F825E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56284C0032;
	Mon, 27 Jun 2022 08:44:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA582C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D048F61052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D048F61052
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a3/WyQeA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xk_u5KlqivoN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:44:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD7CA61058
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD7CA61058
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656319472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOSdUJ9DTd4yNtlD6ik6qKDIpbC30Mybp9dXuAps9zY=;
 b=a3/WyQeAzTOW81XfATISl4YVsdnOAZ78iABX/zKSRLD0Mp4juhVn2JZ/FOtbSFEPvqh3ck
 RjB81M5brsug+MwbpCj2qMIHACEv7RyKLO7IttBuvdNMm0FCqtvgnxjY8xwZQI8BQvsGLf
 ZzzvXfa/0aN33KeXuQso2CkDNUi15pc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-qTZMcU_9Pp-v4juGoWWcdg-1; Mon, 27 Jun 2022 04:44:31 -0400
X-MC-Unique: qTZMcU_9Pp-v4juGoWWcdg-1
Received: by mail-wm1-f70.google.com with SMTP id
 6-20020a1c0206000000b003a02cd754d1so3268004wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 01:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vOSdUJ9DTd4yNtlD6ik6qKDIpbC30Mybp9dXuAps9zY=;
 b=VOd70CJaJjItpZGEiXiTPrUpfOioXUNGj5fRCunHje2bsQ/R76Uxf9OZHquIIdAndd
 i/DSgkODYnliiQS/JM2BWBUoHG0cobetT/XWchgwuKy0zOkc1pUCdHGNRt91c4WY+vuL
 FP08kn0LlVQcjhH1kTlY4U56/jnW/X4Kt9xoX/31nc908rHoV1PbE19b99Lw+7Q108s1
 9upP7YB5srehLvuUH80j+RZyx+VYrxthcwoQQrW64VFj8cNDqH4fyAUBE821v4fd4X9b
 Dl1L3R63uhMORxbXDzmv4q97RZzWSVWj8q/180l7J/LnsbIQQA56KbbpB4yhwj2GQn1d
 Wjzw==
X-Gm-Message-State: AJIora91GAKGnf4nuy5zrgzN0uaSpu7KxYOhVNyqCWliXju95OcqysUt
 PnL30VO6TG/r7/UGLOmuFWqEg/1/LwchreOqu3Xbzgg1Bwrm301eNHcFlNb+CBVA3nwX5ZYtzc4
 eGelsv0AH/Xvn+ic+je26uWQ5+I9XFxBo1Mb1jxZtZw==
X-Received: by 2002:a05:600c:1ca9:b0:3a0:43a9:5e1a with SMTP id
 k41-20020a05600c1ca900b003a043a95e1amr10888780wms.155.1656319470213; 
 Mon, 27 Jun 2022 01:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vmz5gzbpoirGRYpra0pe/yPt4FMgC8vGl8BJG8IIOfD5hso/moKCBxWAMYIDd92gNej2EoZg==
X-Received: by 2002:a05:600c:1ca9:b0:3a0:43a9:5e1a with SMTP id
 k41-20020a05600c1ca900b003a043a95e1amr10888753wms.155.1656319469953; 
 Mon, 27 Jun 2022 01:44:29 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 5-20020a05600c230500b0039c8a22554bsm12367609wmo.27.2022.06.27.01.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 01:44:29 -0700 (PDT)
Date: Mon, 27 Jun 2022 10:44:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: vhost-vdpa tests in tools/virtio
Message-ID: <20220627084425.apxkyhykwyhr42qi@sgarzare-redhat>
References: <20220622153936.to2yh5zixjevy4r4@sgarzare-redhat>
 <CAJaqyWdBjJ2AUQL2hHAgEMQG1Gqp5vMj5Wrpz2p+hpXQGzKPLA@mail.gmail.com>
 <CACGkMEv0w8MdVwTX_G1k8uSqPDY2XWVA2Mhw=Zop-TZA97-+4w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv0w8MdVwTX_G1k8uSqPDY2XWVA2Mhw=Zop-TZA97-+4w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 Michael Tsirkin <mst@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 23, 2022 at 11:59:56AM +0800, Jason Wang wrote:
>On Thu, Jun 23, 2022 at 3:21 AM Eugenio Perez Martin
><eperezma@redhat.com> wrote:
>>
>> On Wed, Jun 22, 2022 at 5:39 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > Hi,
>> > while developing/testing the vdpa-blk support in libblkio [1], I
>> > realized that we added several regressions with the "[PATCH v2 00/19]
>> > Control VQ support in vDPA" series (patches/clarifications already
>> > sent).
>> >
>> > To minimize these problems in the future, I was thinking of adding tests
>> > for vhost_vdpa in tools/virtio using vDPA simulators as devices.
>> >
>> > What do you think about this?
>>
>> I think it's definitely a good idea. Maybe a good starting point is to
>> copy the virtio_test for the moment?
>>
>> Maybe to add a new parameter to tell it it will test a vhost-vdpa
>> device? Initialization is pretty similar.
>
>+1
>

Good idea, I will use it as a starting point.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
