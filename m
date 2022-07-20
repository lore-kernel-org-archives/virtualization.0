Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F9C43334
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 09:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C96CA827F3;
	Wed, 20 Jul 2022 09:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C96CA827F3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwGze48S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qFSJuV5_gUD; Wed, 20 Jul 2022 09:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 313BC80870;
	Wed, 20 Jul 2022 09:30:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 313BC80870
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCE76C0035;
	Wed, 20 Jul 2022 09:30:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78A65C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44A1B60E9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44A1B60E9D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwGze48S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3D-9uJMmkOgb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:30:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AEDB60B30
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AEDB60B30
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658309414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDJ3pDuliBBFCjPRQRCyBqUtEOUMI1zRI5vOv79h/yg=;
 b=LwGze48SNqad5Ms13X7vUnJh7LGSOPOm69OqO3sfSTgL71BujVqTP/9cgqtrSCCFJnAFFZ
 hFf8ovKz+Ob2yrxpunBvXletrdJ4e3TOOSdXXYnUVqTFBc1dq370i9rC+m3Svozde8cWbD
 GEEXD7VrRpb+KTYrjbZWyXQ/KWvUqJ0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-MOaF7DIzO6W3Apog8Dzxrw-1; Wed, 20 Jul 2022 05:30:13 -0400
X-MC-Unique: MOaF7DIzO6W3Apog8Dzxrw-1
Received: by mail-qk1-f197.google.com with SMTP id
 bk21-20020a05620a1a1500b006b5c24695a4so13834793qkb.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 02:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GDJ3pDuliBBFCjPRQRCyBqUtEOUMI1zRI5vOv79h/yg=;
 b=wNauTTJItg23vtnnPgOgDUxkvfYtHjvE0qkK0zv81zlSXq7TojFNCx48Mh/Af05hwS
 ZoW9ScHMR/Joivs41k1mt7DC7IQ3ZlnUZdX9RtjsbHMcq+L27ORh9eROOKV53fJgOJU9
 ocbbYwEeXgo8K4GltBlTA3ZMRA7ykbKb1u87aq6CEQKhddAuU4qdM71bQ01HfzHv0eBX
 JxZHOe3NThrwm2R86apLSNBptM6XkKDsa/7cMJ9BWlFDjhHNwJsWNWU1EDafrWfy9F+R
 peUey3KsD4hzhui1TR5HVqWmdMYekk2Z/MZzD68Xfe6PVKf4zD+TP95MS1vkt1WFBg9S
 JWTQ==
X-Gm-Message-State: AJIora8OsQa1Wv6cBIefKIdoAGB6o1J/lnzytYigd39/rWXH0qtKuCgx
 O5EgJnjykGD+q0ca09WH0Tv1yNZPImiGnxUAUdRLEHW62gkDtNOeZ+1ZSJdohjM+HMyVVBQk5Mq
 AE632WcIAqOhxV2SAM9bikw9bnxZeGrhrYkiWELKzyw==
X-Received: by 2002:ac8:59c7:0:b0:31e:ede9:971b with SMTP id
 f7-20020ac859c7000000b0031eede9971bmr10707668qtf.208.1658309413092; 
 Wed, 20 Jul 2022 02:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s6mJMvfgOsm/KeVUVbnelP8FW2qMJbR3hxdq7pZeKI4iupDApN2I1fzLeoIKhfg5s7AfAEcg==
X-Received: by 2002:ac8:59c7:0:b0:31e:ede9:971b with SMTP id
 f7-20020ac859c7000000b0031eede9971bmr10707652qtf.208.1658309412863; 
 Wed, 20 Jul 2022 02:30:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05620a0c4c00b006a6ebde4799sm17257649qki.90.2022.07.20.02.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jul 2022 02:30:12 -0700 (PDT)
Date: Wed, 20 Jul 2022 11:30:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/3] virtio/vsock: use SO_RCVLOWAT to set
 POLLIN/POLLRDNORM
Message-ID: <20220720093005.2unej4jnnvrn55f2@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <20220719125856.a6bfwrvy66gxxzqe@sgarzare-redhat>
 <ac05e1ee-23b3-75e0-f9a4-1056a68934d8@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <ac05e1ee-23b3-75e0-f9a4-1056a68934d8@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
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

On Wed, Jul 20, 2022 at 06:07:47AM +0000, Arseniy Krasnov wrote:
>On 19.07.2022 15:58, Stefano Garzarella wrote:
>> On Mon, Jul 18, 2022 at 08:12:52AM +0000, Arseniy Krasnov wrote:
>>> Hello,
>>>
>>> during my experiments with zerocopy receive, i found, that in some
>>> cases, poll() implementation violates POSIX: when socket has non-
>>> default SO_RCVLOWAT(e.g. not 1), poll() will always set POLLIN and
>>> POLLRDNORM bits in 'revents' even number of bytes available to read
>>> on socket is smaller than SO_RCVLOWAT value. In this case,user sees
>>> POLLIN flag and then tries to read data(for example using=A0 'read()'
>>> call), but read call will be blocked, because=A0 SO_RCVLOWAT logic is
>>> supported in dequeue loop in af_vsock.c. But the same time,=A0 POSIX
>>> requires that:
>>>
>>> "POLLIN=A0=A0=A0=A0 Data other than high-priority data may be read with=
out
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blocking.
>>> POLLRDNORM Normal data may be read without blocking."
>>>
>>> See https://www.open-std.org/jtc1/sc22/open/n4217.pdf, page 293.
>>>
>>> So, we have, that poll() syscall returns POLLIN, but read call will
>>> be blocked.
>>>
>>> Also in man page socket(7) i found that:
>>>
>>> "Since Linux 2.6.28, select(2), poll(2), and epoll(7) indicate a
>>> socket as readable only if at least SO_RCVLOWAT bytes are available."
>>>
>>> I checked TCP callback for poll()(net/ipv4/tcp.c, tcp_poll()), it
>>> uses SO_RCVLOWAT value to set POLLIN bit, also i've tested TCP with
>>> this case for TCP socket, it works as POSIX required.
>>
>> I tried to look at the code and it seems that only TCP complies with it =
or am I wrong?
>Yes, i checked AF_UNIX, it also don't care about that. It calls skb_queue_=
empty() that of
>course ignores SO_RCVLOWAT.
>>
>>>
>>> I've added some fixes to af_vsock.c and virtio_transport_common.c,
>>> test is also implemented.
>>>
>>> What do You think guys?
>>
>> Nice, thanks for fixing this and for the test!
>>
>> I left some comments, but I think the series is fine if we will support =
it in all transports.
>Ack
>>
>> I'd just like to understand if it's just TCP complying with it or I'm mi=
ssing some check included in the socket layer that we could reuse.
>Seems sock_poll() which is socket layer entry point for poll() doesn't con=
tain any such checks
>>
>> @David, @Jakub, @Paolo, any advice?
>>
>> Thanks,
>> Stefano
>>
>
>PS: moreover, i found one more interesting thing with TCP and poll: TCP re=
ceive logic wakes up poll waiter
>only when number of available bytes > SO_RCVLOWAT. E.g. it prevents "spuri=
ous" wake ups, when poll will be
>woken up because new data arrived, but POLLIN to allow user dequeue this d=
ata won't be set(as amount of data
>is too small).
>See tcp_data_ready() in net/ipv4/tcp_input.c

Do you mean that we should call sk->sk_data_ready(sk) checking =

SO_RCVLOWAT?

It seems fine, maybe we can add vsock_data_ready() in af_vsock.c that =

transports should call instead of calling sk->sk_data_ready(sk) =

directly.

Then we can something similar to tcp_data_ready().

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
