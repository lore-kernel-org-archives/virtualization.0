Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BF4CCA480
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 08:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F155611F0;
	Wed, 20 Jul 2022 08:23:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F155611F0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ryddgz21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z5tvdRIv4Qfc; Wed, 20 Jul 2022 08:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AC2061223;
	Wed, 20 Jul 2022 08:23:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AC2061223
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF969C0033;
	Wed, 20 Jul 2022 08:23:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED33CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B695540407
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:23:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B695540407
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ryddgz21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EonKfm_9coR7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:23:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0A77400AB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0A77400AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658305394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqWXkpMYDjGMkR6N048q9/Kkfh0q8LEuKcrhvdxBx9U=;
 b=Ryddgz21Hjea6a0njB3Qp8QEjnL8IPEMJWDYi4C3SPpe5pEuMuat8JPGDNKj5oeW2LjIVm
 k8l9e6kgDmeS/kTG6dN4AIY2KPdZLeejOFt/dCEjBbnQTRZwZKaDmKb81FypAumeEYt6o9
 cc3lmAmaWEKsbgw2SkUzvXIc/ncAC6Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-q8Z6VjVzPCuyxBRwxHsNRQ-1; Wed, 20 Jul 2022 04:23:13 -0400
X-MC-Unique: q8Z6VjVzPCuyxBRwxHsNRQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 q9-20020adfb189000000b0021e3e7d3242so761760wra.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 01:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=WqWXkpMYDjGMkR6N048q9/Kkfh0q8LEuKcrhvdxBx9U=;
 b=pcX1hcRZDnJ+v/2kZ5hyPYm55gleqxBPN9satjYjDgY9lrvr8lccgXaoCetdqIJWaG
 oVe3noWrkHA+S/00aLoqOCedzJgcrAipZa41mm1iqF4dSja0zH+Voa+dljnHUpOQ4fVk
 Rn56S9PehMwSyz+LN9Ll9RLtB53Wci1WZPWQ3KUkMALrtShyAccW82rTkWjL1z7/+0s3
 u0Fxhf/8lwgwDGIvRgV1tR83n6AebX/WyeMQYY7xT5fK+lHbmUH90nu13NW78nVX3F1E
 xdTcNGRrdKwtqJ6a3VqYHOqQ4LhE8/ShNmfxpQfiao9sCmp+nYPErZQCYguTIlaQLWyc
 MhDg==
X-Gm-Message-State: AJIora8/3VA9Kdd2JfZ7kblgm4l0XBDEsALk2KFhzWe37mG1eR+UlMbV
 IXLJ/rplZaP1XgvaX3jVFXuAfaA4ecttRyaoym81auaKtPWP6sx1cvQsRn2f8p3bchADdfsbGRU
 2F85ML2N26TkGBlEF1eyi5eqkp64D7g0hFwCVKJ7zuw==
X-Received: by 2002:a05:600c:3227:b0:3a3:be7:2917 with SMTP id
 r39-20020a05600c322700b003a30be72917mr2760518wmp.83.1658305392296; 
 Wed, 20 Jul 2022 01:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sk2lxdgaBkVc5Kem0cnAq2mfCBRvNA74098gzKOVACYFwhUlWyh6yfDCAwDcJmLBObthn+bA==
X-Received: by 2002:a05:600c:3227:b0:3a3:be7:2917 with SMTP id
 r39-20020a05600c322700b003a30be72917mr2760502wmp.83.1658305392025; 
 Wed, 20 Jul 2022 01:23:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 g8-20020a05600c4ec800b003a317ee3036sm1887541wmq.2.2022.07.20.01.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jul 2022 01:23:11 -0700 (PDT)
Date: Wed, 20 Jul 2022 10:23:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [RFC PATCH v1 2/3] virtio/vsock: use 'target' in notify_poll_in, 
 callback.
Message-ID: <20220720082307.djbf7qgnlsjmrxcf@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <358f8d52-fd88-ad2e-87e2-c64bfa516a58@sberdevices.ru>
 <20220719124857.akv25sgp6np3pdaw@sgarzare-redhat>
 <15f38fcf-f1ff-3aad-4c30-4436bb8c4c44@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <15f38fcf-f1ff-3aad-4c30-4436bb8c4c44@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jul 20, 2022 at 05:38:03AM +0000, Arseniy Krasnov wrote:
>On 19.07.2022 15:48, Stefano Garzarella wrote:
>> On Mon, Jul 18, 2022 at 08:17:31AM +0000, Arseniy Krasnov wrote:
>>> This callback controls setting of POLLIN,POLLRDNORM output bits
>>> of poll() syscall,but in some cases,it is incorrectly to set it,
>>> when socket has at least 1 bytes of available data. Use 'target'
>>> which is already exists and equal to sk_rcvlowat in this case.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
>>> index ec2c2afbf0d0..591908740992 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -634,7 +634,7 @@ virtio_transport_notify_poll_in(struct vsock_sock *=
vsk,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t target,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool *data_ready_now)
>>> {
>>> -=A0=A0=A0 if (vsock_stream_has_data(vsk))
>>> +=A0=A0=A0 if (vsock_stream_has_data(vsk) >=3D target)
>>> =A0=A0=A0=A0=A0=A0=A0 *data_ready_now =3D true;
>>> =A0=A0=A0=A0else
>>> =A0=A0=A0=A0=A0=A0=A0 *data_ready_now =3D false;
>>
>> Perhaps we can take the opportunity to clean up the code in this way:
>>
>> =A0=A0=A0=A0*data_ready_now =3D vsock_stream_has_data(vsk) >=3D target;
>Ack
>>
>> Anyway, I think we also need to fix the other transports (vmci and hyper=
v), what do you think?
>For vmci it is look clear to fix it. For hyperv i need to check it more, b=
ecause it already
>uses some internal target value.

Yep, I see. Maybe you can pass `target` to hvs_channel_readable() and =

use it as parameter of HVS_PKT_LEN().

@Dexuan what do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
