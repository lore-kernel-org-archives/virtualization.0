Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06CDC25B41
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 16:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EA0D417B2;
	Mon, 23 Oct 2023 16:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EA0D417B2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ht9VOynw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYJQdAQYBo7x; Mon, 23 Oct 2023 16:10:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3EDD4417B6;
	Mon, 23 Oct 2023 16:10:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EDD4417B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14AE0C0071;
	Mon, 23 Oct 2023 16:10:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D137BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC77561273
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC77561273
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ht9VOynw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sx5EfeTWUKVc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:10:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9E616126F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9E616126F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698077436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uM6IGtTXgNreBRSdHRcyHDWS2q1BSGKyDG55d0zg7uE=;
 b=Ht9VOynwfmpS8zBkF6Dw/3tFgpFKi3kBp6jLkjqvm9FYgYbhDp8h3AQ01Js2Hf6KbX4fkT
 Pu4YrfB1R99uKLSyQleLU4C2CVPLCVTDV+QazP2ZGnlLipxg8x+k9i8myVRExULcs+8YuK
 pC/0FRdaYDptw35RQLRJr+OYUUteQMA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-JeQDs_toObCjPs3cI0ApAg-1; Mon, 23 Oct 2023 12:10:35 -0400
X-MC-Unique: JeQDs_toObCjPs3cI0ApAg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d120c28afso43929566d6.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 09:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077434; x=1698682234;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uM6IGtTXgNreBRSdHRcyHDWS2q1BSGKyDG55d0zg7uE=;
 b=HQbqHvKj/bgmGpCwLo3twzQEwLmzlh5vFJ55XXsWC+xFpiT4rCwdjyTFLkCd6Y/qoz
 WF2vpRir2e1IDpAaUYZjYkMgG+mzRpZOWs8BevYFk/fkpIxSfzFWMMzWBKic4DWxFp3U
 tks/zpxWNIjIvWrHcQ7KWvrWbYeyPET0yT3bU1ZGAgRwQBpmeuScdfLILSVb3WWJGjrS
 FqfkveOWujVC1jF/CazVTMaofWHotjO+bFgDE+6AiYlzhYdcP/qJTxQmqeSRWv5Wb7PJ
 Cx4CMQbYnQN6CCHlL2PCKtcKnoqzO2xCaY8SNOOFP4XKMX8BhtQP50Yu04VVlnjaTPvs
 B7QQ==
X-Gm-Message-State: AOJu0YzngRN5uVA4GJF1oLvRD29kNv+Ai5+UBNh4+KYxgU6XeL5oBNXr
 Lf9n6Wuujo78Njce6bjExlvlwPe76bSQbbY3SNp7iSxxYaK/O5N9Lsxu5Bec8Tl9NY3FtMXGZf9
 zRBIFjwWkMJIa09xmUpOoewVPNLc+l196/2Z/Ayhk8g==
X-Received: by 2002:a05:6214:c2a:b0:66d:818f:a483 with SMTP id
 a10-20020a0562140c2a00b0066d818fa483mr10587097qvd.32.1698077434692; 
 Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXvJRhDKCA/YN/pdkU/PNM0UdgNdRiMmQ0LK/XFZjxqjKVtJ/tiIKHk5iR/BGmtnOfa3u01A==
X-Received: by 2002:a05:6214:c2a:b0:66d:818f:a483 with SMTP id
 a10-20020a0562140c2a00b0066d818fa483mr10587070qvd.32.1698077434403; 
 Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 bz18-20020ad44c12000000b0065b29403540sm2960253qvb.127.2023.10.23.09.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:10:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Subject: Re: [PATCH v2] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <jyjfsjvfmmr7ucf53v6p57scdxah64bgvd2lj7l4hbjwiyd2ct@lj3ejlseqvog>
References: <20231023140833.11206-1-alexandru.matei@uipath.com>
 <2tc56vwgs5xwqzfqbv5vud346uzagwtygdhkngdt3wjqaslbmh@zauky5czyfkg>
 <0624137c-85cf-4086-8256-af2b8405f434@uipath.com>
 <632465d0-e04c-4e10-abb9-a740d6e3dc30@uipath.com>
 <dynlbzmgtr35byn5etbar33ufhweii6gk2pct5wpqxpqubchce@cltop4aar7r6>
 <01ad7d00-9a53-445b-8916-3342047112a0@uipath.com>
MIME-Version: 1.0
In-Reply-To: <01ad7d00-9a53-445b-8916-3342047112a0@uipath.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Viorel Canja <viorel.canja@uipath.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mihai Petrisor <mihai.petrisor@uipath.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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

On Mon, Oct 23, 2023 at 06:36:21PM +0300, Alexandru Matei wrote:
>On 10/23/2023 6:13 PM, Stefano Garzarella wrote:
>> On Mon, Oct 23, 2023 at 05:59:45PM +0300, Alexandru Matei wrote:
>>> On 10/23/2023 5:52 PM, Alexandru Matei wrote:
>>>> On 10/23/2023 5:29 PM, Stefano Garzarella wrote:
>>>>> On Mon, Oct 23, 2023 at 05:08:33PM +0300, Alexandru Matei wrote:
>>>>>> Once VQs are filled with empty buffers and we kick the host,
>>>>>> it can send connection requests.=A0 If 'the_virtio_vsock' is not
>>>>>> initialized before, replies are silently dropped and do not reach th=
e host.
>>>>>>
>>>>>> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free =
on the_virtio_vsock")
>>>>>> Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>>>>>> ---
>>>>>> v2:
>>>>>> - split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>>>>>> =A0the_virtio_vsock initialization after vqs_init
>>>>>>
>>>>>> net/vmw_vsock/virtio_transport.c | 9 +++++++--
>>>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio=
_transport.c
>>>>>> index e95df847176b..92738d1697c1 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport.c
>>>>>> @@ -559,6 +559,11 @@ static int virtio_vsock_vqs_init(struct virtio_=
vsock *vsock)
>>>>>> =A0=A0=A0=A0vsock->tx_run =3D true;
>>>>>> =A0=A0=A0=A0mutex_unlock(&vsock->tx_lock);
>>>>>>
>>>>>> +=A0=A0=A0 return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)
>>>>>
>>>>> What about renaming this function in virtio_vsock_vqs_start() and mov=
e also the setting of `tx_run` here?
>>>>
>>>> It works but in this case we also need to move rcu_assign_pointer in v=
irtio_vsock_vqs_start(),
>>>> the assignment needs to be right after setting tx_run to true and befo=
re filling the VQs.
>>
>> Why?
>>
>> If `rx_run` is false, we shouldn't need to send replies to the host IIUC.
>>
>> If we need this instead, please add a comment in the code, but also in t=
he commit, because it's not clear why.
>>
>
>We need rcu_assign_pointer after setting tx_run to true for connections =

>that are initiated from the guest -> host.
>virtio_transport_connect() calls virtio_transport_send_pkt().  Once =

>'the_virtio_vsock' is initialized, virtio_transport_send_pkt() will =

>queue the packet,
>but virtio_transport_send_pkt_work() will exit if tx_run is false.

Okay, but in this case we could safely queue &vsock->send_pkt_work after =

finishing initialization to send those packets queued earlier.

In the meantime I'll try to see if we can leave the initialization of =

`the_virtio_vsock` as the ulitmate step and maybe go out first in the =

workers if it's not set.

That way just queue all the workers after everything is done and we =

should be fine.

>
>>>>
>>>
>>> And if we move rcu_assign_pointer then there is no need to split the fu=
nction in two,
>>> We can move rcu_assign_pointer() directly inside virtio_vsock_vqs_init(=
) after setting tx_run.
>>
>> Yep, this could be another option, but we need to change the name of tha=
t function in this case.
>>
>
>OK, how does virtio_vsock_vqs_setup() sound?

Or virtio_vsock_start() (without vqs)

Stefano

>
>> Stefano
>>
>>>
>>>>>
>>>>> Thanks,
>>>>> Stefano
>>>>>
>>>>>> +{
>>>>>> =A0=A0=A0=A0mutex_lock(&vsock->rx_lock);
>>>>>> =A0=A0=A0=A0virtio_vsock_rx_fill(vsock);
>>>>>> =A0=A0=A0=A0vsock->rx_run =3D true;
>>>>>> @@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_v=
sock *vsock)
>>>>>> =A0=A0=A0=A0virtio_vsock_event_fill(vsock);
>>>>>> =A0=A0=A0=A0vsock->event_run =3D true;
>>>>>> =A0=A0=A0=A0mutex_unlock(&vsock->event_lock);
>>>>>> -
>>>>>> -=A0=A0=A0 return 0;
>>>>>> }
>>>>>>
>>>>>> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>>>>> @@ -664,6 +667,7 @@ static int virtio_vsock_probe(struct virtio_devi=
ce *vdev)
>>>>>> =A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>>>
>>>>>> =A0=A0=A0=A0rcu_assign_pointer(the_virtio_vsock, vsock);
>>>>>> +=A0=A0=A0 virtio_vsock_vqs_fill(vsock);
>>>>>>
>>>>>> =A0=A0=A0=A0mutex_unlock(&the_virtio_vsock_mutex);
>>>>>>
>>>>>> @@ -736,6 +740,7 @@ static int virtio_vsock_restore(struct virtio_de=
vice *vdev)
>>>>>> =A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>>>
>>>>>> =A0=A0=A0=A0rcu_assign_pointer(the_virtio_vsock, vsock);
>>>>>> +=A0=A0=A0 virtio_vsock_vqs_fill(vsock);
>>>>>>
>>>>>> out:
>>>>>> =A0=A0=A0=A0mutex_unlock(&the_virtio_vsock_mutex);
>>>>>> --=A0
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
