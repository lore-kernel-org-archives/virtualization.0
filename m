Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09455C43334
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 08:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94A2E60A9C;
	Mon, 13 Jun 2022 08:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ort2d1Iomf1K; Mon, 13 Jun 2022 08:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08C5960808;
	Mon, 13 Jun 2022 08:51:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1C29C0039;
	Mon, 13 Jun 2022 08:51:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 840B0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65C9481A1C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sn88IVCUMYUc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:51:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7785781A12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655110258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpNKgbpx+78NLRf26/oOXOkBqasMpEHURTXeLdxK0yI=;
 b=EDQ/yHqsg+Cr5cFKZyuK/hbct2b7htcOintF36AVoXlcSFN0hU0gTs9VKddQ14vfe9dneS
 z/UONkvWaKrLJQO6jFG/ADUZE281FcgQO+zUpwqOnPp06H3b5N3nq6lZxkFvzt7OGKjfo9
 tzcf56QzgszvIMB/3c/Y+ud20j+lfyA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-jl8r04csODyOt7bT-RaDbQ-1; Mon, 13 Jun 2022 04:50:57 -0400
X-MC-Unique: jl8r04csODyOt7bT-RaDbQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 v11-20020a05622a188b00b0030505efb2f1so3944082qtc.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mpNKgbpx+78NLRf26/oOXOkBqasMpEHURTXeLdxK0yI=;
 b=USjvt0areShWrwGwVaxZDkM8PMo+kw/VDnfskq1FNN6sMP6+1ViTX1kcNPegZIaulT
 fVgR6vA1+QFMg4gdGqNo/sO20ugYP4WPeKTaXRdRMLueLYI9wX4qVm+rwMjlvZ/4Ihag
 HkNBusmJ4M/gwKE6wfM5imFU2vu2/PJsk5Zv7FcmzY6fL4f65j6WrEkQNQ8LwOIeBkJw
 HGSk1vPxCDMrR5TYBD1wZzxjuHpsd/tysefc3kXvlO4bkv8Wys7xBzEO9LkCukk0t0Lj
 M5WoXG6UCIzxfsY1am6gYtw9reT/RZEdpzH1ALrRH3eqUI3pbuYUDMM+cRIE2Xka5Hhx
 7vJQ==
X-Gm-Message-State: AOAM531/vmHpP+G+eeNC4nk/iupm2AhGZGcgQwFYMLO3iRl0ti6NhDHY
 9eZ0RfgXYj3Ft8rxocX5Nlkr8eggOpPsBIEOP0mrdfoCRq+kD/6ZPq7xQW2JPOPlmaWvq2QIDI0
 4xloDCjP0VhWLhPrLw2jP/RE5TUlwEcI+HajQVyxncw==
X-Received: by 2002:ac8:5904:0:b0:304:f0d0:ed16 with SMTP id
 4-20020ac85904000000b00304f0d0ed16mr28949952qty.475.1655110257061; 
 Mon, 13 Jun 2022 01:50:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwccVKGRgAaqpV1votdrIxrBJEruzT8HwAeGhXCKLdk7lNXAQV1g1JTpnyocJYZ53WI0waY1Q==
X-Received: by 2002:ac8:5904:0:b0:304:f0d0:ed16 with SMTP id
 4-20020ac85904000000b00304f0d0ed16mr28949936qty.475.1655110256772; 
 Mon, 13 Jun 2022 01:50:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 w18-20020ac87192000000b002f9114d2ebcsm4592355qto.17.2022.06.13.01.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 01:50:56 -0700 (PDT)
Date: Mon, 13 Jun 2022 10:50:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 3/8] af_vsock: add zerocopy receive logic
Message-ID: <20220613085046.ee7cb2ye5yq5cbfo@sgarzare-redhat>
References: <e37fdf9b-be80-35e1-ae7b-c9dfeae3e3db@sberdevices.ru>
 <129aa328-ad4d-cb2c-4a51-4a2bf9c9be37@sberdevices.ru>
 <20220609083929.5k37tajo3qli4kr2@sgarzare-redhat>
 <204f5bc4-987e-a1ff-71e2-e51343e13f24@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <204f5bc4-987e-a1ff-71e2-e51343e13f24@sberdevices.ru>
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

On Thu, Jun 09, 2022 at 12:20:22PM +0000, Arseniy Krasnov wrote:
>On 09.06.2022 11:39, Stefano Garzarella wrote:
>> On Fri, Jun 03, 2022 at 05:35:48AM +0000, Arseniy Krasnov wrote:
>>> This:
>>> 1) Adds callback for 'mmap()' call on socket. It checks vm
>>> =A0 area flags and sets vm area ops.
>>> 2) Adds special 'getsockopt()' case which calls transport
>>> =A0 zerocopy callback. Input argument is vm area address.
>>> 3) Adds 'getsockopt()/setsockopt()' for switching on/off rx
>>> =A0 zerocopy mode.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> include/net/af_vsock.h=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 +++
>>> include/uapi/linux/vm_sockets.h |=A0=A0 3 +
>>> net/vmw_vsock/af_vsock.c=A0=A0=A0=A0=A0=A0=A0 | 100 +++++++++++++++++++=
+++++++++++++
>>> 3 files changed, 110 insertions(+)
>>>
>>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>> index f742e50207fb..f15f84c648ff 100644
>>> --- a/include/net/af_vsock.h
>>> +++ b/include/net/af_vsock.h
>>> @@ -135,6 +135,13 @@ struct vsock_transport {
>>> =A0=A0=A0=A0bool (*stream_is_active)(struct vsock_sock *);
>>> =A0=A0=A0=A0bool (*stream_allow)(u32 cid, u32 port);
>>>
>>> +=A0=A0=A0 int (*rx_zerocopy_set)(struct vsock_sock *vsk,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool enable);
>>> +=A0=A0=A0 int (*rx_zerocopy_get)(struct vsock_sock *vsk);
>>> +=A0=A0=A0 int (*zerocopy_dequeue)(struct vsock_sock *vsk,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct vm_area_struct *v=
ma,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long addr);
>>> +
>>> =A0=A0=A0=A0/* SEQ_PACKET. */
>>> =A0=A0=A0=A0ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct=
 msghdr *msg,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int flags);
>>> diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_so=
ckets.h
>>> index c60ca33eac59..d1f792bed1a7 100644
>>> --- a/include/uapi/linux/vm_sockets.h
>>> +++ b/include/uapi/linux/vm_sockets.h
>>> @@ -83,6 +83,9 @@
>>>
>>> #define SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW 8
>>>
>>> +#define SO_VM_SOCKETS_MAP_RX 9
>>> +#define SO_VM_SOCKETS_ZEROCOPY 10
>>> +
>>> #if !defined(__KERNEL__)
>>> #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP3=
2__))
>>> #define SO_VM_SOCKETS_CONNECT_TIMEOUT SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index f04abf662ec6..10061ef21730 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1644,6 +1644,17 @@ static int vsock_connectible_setsockopt(struct s=
ocket *sock,
>>> =A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0}
>>> +=A0=A0=A0 case SO_VM_SOCKETS_ZEROCOPY: {
>>> +=A0=A0=A0=A0=A0=A0=A0 if (!transport || !transport->rx_zerocopy_set) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D -EOPNOTSUPP;
>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 COPY_IN(val);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (transport->rx_zerocopy_set(vsk, =
val))
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D -EINVAL;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 break;
>>> +=A0=A0=A0 }
>>>
>>> =A0=A0=A0=A0default:
>>> =A0=A0=A0=A0=A0=A0=A0 err =3D -ENOPROTOOPT;
>>> @@ -1657,6 +1668,48 @@ static int vsock_connectible_setsockopt(struct s=
ocket *sock,
>>> =A0=A0=A0=A0return err;
>>> }
>>>
>>> +static const struct vm_operations_struct afvsock_vm_ops =3D {
>>> +};
>>> +
>>> +static int vsock_recv_zerocopy(struct socket *sock,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long a=
ddress)
>>> +{
>>> +=A0=A0=A0 struct sock *sk =3D sock->sk;
>>> +=A0=A0=A0 struct vsock_sock *vsk =3D vsock_sk(sk);
>>> +=A0=A0=A0 struct vm_area_struct *vma;
>>> +=A0=A0=A0 const struct vsock_transport *transport;
>>> +=A0=A0=A0 int res;
>>> +
>>> +=A0=A0=A0 transport =3D vsk->transport;
>>> +
>>> +=A0=A0=A0 if (!transport->rx_zerocopy_get)
>>> +=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
>>> +
>>> +=A0=A0=A0 if (!transport->rx_zerocopy_get(vsk))
>>> +=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
>>
>> Maybe we can merge in
>> =A0=A0=A0=A0=A0=A0=A0 if (!transport->rx_zerocopy_get ||
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !transport->rx_zerocopy_get(vsk)}
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
>>
>>> +
>>> +=A0=A0=A0 if (!transport->zerocopy_dequeue)
>>> +=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
>>> +
>>> +=A0=A0=A0 lock_sock(sk);
>>> +=A0=A0=A0 mmap_write_lock(current->mm);
>>
>> So, multiple threads using different sockets are serialized if they use =
zero-copy?
>>
>> IIUC this is necessary because the callback calls vm_insert_page().
>>
>> At this point I think it's better not to do this in every transport, but=
 have the callback return an array of pages to map and we map them here try=
ing to limit as much as possible the critical section to protect with mmap_=
write_lock().
>
>Yes, it will be easy to return array of pages by transport callback,
>
>>
>>> +
>>> +=A0=A0=A0 vma =3D vma_lookup(current->mm, address);
>>> +
>>> +=A0=A0=A0 if (!vma || vma->vm_ops !=3D &afvsock_vm_ops) {
>>> +=A0=A0=A0=A0=A0=A0=A0 mmap_write_unlock(current->mm);
>>> +=A0=A0=A0=A0=A0=A0=A0 release_sock(sk);
>>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 res =3D transport->zerocopy_dequeue(vsk, vma, address);
>>> +
>>> +=A0=A0=A0 mmap_write_unlock(current->mm);
>>> +=A0=A0=A0 release_sock(sk);
>>> +
>>> +=A0=A0=A0 return res;
>>> +}
>>> +
>>> static int vsock_connectible_getsockopt(struct socket *sock,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int level, in=
t optname,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char __user *=
optval,
>>> @@ -1701,6 +1754,39 @@ static int vsock_connectible_getsockopt(struct s=
ocket *sock,
>>> =A0=A0=A0=A0=A0=A0=A0 lv =3D sock_get_timeout(vsk->connect_timeout, &v,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 optname=
 =3D=3D SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
>>> =A0=A0=A0=A0=A0=A0=A0 break;
>>> +=A0=A0=A0 case SO_VM_SOCKETS_ZEROCOPY: {
>>> +=A0=A0=A0=A0=A0=A0=A0 const struct vsock_transport *transport;
>>> +=A0=A0=A0=A0=A0=A0=A0 int res;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 transport =3D vsk->transport;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (!transport->rx_zerocopy_get)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 lock_sock(sk);
>>
>> I think we should call lock_sock() before reading the transport to avoid=
 races and we should check if it is assigned.
>>
>> At that point I think is better to store this info in vsock_sock and not=
 in the transport.
>You mean to store flag that zerocopy is enabled in 'vsock_sock', just read=
ing it here, without touching transport?

Yep.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
