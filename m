Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9504AC04E69
	for <virtualization@archiver.kernel.org>; Fri,  4 Aug 2023 14:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15E274159B;
	Fri,  4 Aug 2023 14:28:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15E274159B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NdUGmDYV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJc_CjPYzgof; Fri,  4 Aug 2023 14:28:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37E804054E;
	Fri,  4 Aug 2023 14:28:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37E804054E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09CA5C0072;
	Fri,  4 Aug 2023 14:28:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D49AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 14:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31B054159B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 14:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31B054159B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id STJp0EeJZwUc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 14:28:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15A2040253
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 14:28:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15A2040253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691159314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6TKiUoe55IIrqSia7IbdrPQay+jmTfT+IM/4+k+lpc=;
 b=NdUGmDYVFNvaB/pm6eHfz3xOv6F2Rjm6RKFDhYvx3LzckJodjNJdwKgx6fj2GINb+PK8TF
 xfTJ+RJPMjEWESIG3weKRdlC7fQCIaoxmfmYvnWlu3DIFdwjWd/Wa3CQ/oyN2TkeCOIVzk
 nwU8iu6oSPibTOx90z8NeD41HLxmvNQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Oz7RDPJgMeKRIZQ9nkBx2Q-1; Fri, 04 Aug 2023 10:28:31 -0400
X-MC-Unique: Oz7RDPJgMeKRIZQ9nkBx2Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63cceb8c21aso24373876d6.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Aug 2023 07:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691159311; x=1691764111;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/6TKiUoe55IIrqSia7IbdrPQay+jmTfT+IM/4+k+lpc=;
 b=PympMdVPSdKQhW7aiIBKgh8/KuuWsMkc33mnZyGbZripvvMT7XqI5oZOhKZJ3w4xl7
 nI4YJTc5ty/Irmhdv7XKpMNly2+hHIhm1ZP1T7ouZJytCTCtE1zNluxfcMU+bZmf62Dn
 nEPoEzhN//xyesRbfPveRRi6jpSP5r2o5gCvrt+O9KSMa1ZqCwXS0iwvaS4LgQwm6Owp
 SAojUh55G6fDXhaC63NTD0gd5GedUNf3qkkprBy7CwMo9Fj+qdQ6N+7WIQvJcSQ60gZ4
 NnbqgeZ6CRALvp3OWEmsbTqti0P2tmcl5ehxJJfw9w7p21yPVBPJFKoHXYiI+Dx0XhmU
 G9Hg==
X-Gm-Message-State: AOJu0YyyVCFyJe52aQkejZ3mwPJXcL1o5MVWQwTtd233wWfai+JzHKH1
 E/NBHreZn9JcDDTIQxsjQYV7t9IantSXyo1my6lpztDA5T/OllPC40GMS1jkQFzNUvSmKQ/AbgP
 XC1fCT2ZCznUi5MzSu/AcUAd5fvzca7e3Vd9HoshaZA==
X-Received: by 2002:a0c:9d04:0:b0:63c:eb1e:e004 with SMTP id
 m4-20020a0c9d04000000b0063ceb1ee004mr1771016qvf.3.1691159310917; 
 Fri, 04 Aug 2023 07:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQOm1oB5/xrHwYk3PxdGj4/DBN9i2DE5i3OHfDF64MaIhm95kSdYL67jDQe5etcx8sQx28kw==
X-Received: by 2002:a0c:9d04:0:b0:63c:eb1e:e004 with SMTP id
 m4-20020a0c9d04000000b0063ceb1ee004mr1770996qvf.3.1691159310619; 
 Fri, 04 Aug 2023 07:28:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 d30-20020a0caa1e000000b00637abbfaac9sm698043qvb.98.2023.08.04.07.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 07:28:30 -0700 (PDT)
Date: Fri, 4 Aug 2023 16:28:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Aug 04, 2023 at 03:46:47PM +0300, Arseniy Krasnov wrote:
>Hi Stefano,
>
>On 02.08.2023 10:46, Stefano Garzarella wrote:
>> On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>>> POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>>> shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>>> flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 020cf17ab7e4..013b65241b65 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socke=
t *sock, struct msghdr *msg,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D total_written;
>>> =A0=A0=A0=A0}
>>> out:
>>> +=A0=A0=A0 if (sk->sk_type =3D=3D SOCK_STREAM)
>>> +=A0=A0=A0=A0=A0=A0=A0 err =3D sk_stream_error(sk, msg->msg_flags, err);
>>
>> Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?
>
>Yes, here is my explanation:
>
>This function checks that input error is SIGPIPE, and if so it sends SIGPI=
PE to the 'current' thread
>(except case when MSG_NOSIGNAL flag is set). This behaviour is described i=
n POSIX:
>
>Page 367 (description of defines from sys/socket.h):
>MSG_NOSIGNAL: No SIGPIPE generated when an attempt to send is made on a st=
ream-
>oriented socket that is no longer connected.
>
>Page 497 (description of SOCK_STREAM):
>A SIGPIPE signal is raised if a thread sends on a broken stream (one that =
is
>no longer connected).

Okay, but I think we should do also for SEQPACKET:

https://pubs.opengroup.org/onlinepubs/009696699/functions/xsh_chap02_10.html

In 2.10.6 Socket Types:

"The SOCK_SEQPACKET socket type is similar to the SOCK_STREAM type, and
is also connection-oriented. The only difference between these types is
that record boundaries ..."

Then in  2.10.14 Signals:

"The SIGPIPE signal shall be sent to a thread that attempts to send data
on a socket that is no longer able to send. In addition, the send
operation fails with the error [EPIPE]."

It's honestly not super clear, but I assume the problem is similar with
seqpacket since it's connection-oriented, or did I miss something?

For example in sctp_sendmsg() IIUC we raise a SIGPIPE regardless of
whether the socket is STREAM or SEQPACKET.

>
>Page 1802 (description of 'send()' call):
>MSG_NOSIGNAL
>
>Requests not to send the SIGPIPE signal if an attempt to
>send is made on a stream-oriented socket that is no
>longer connected. The [EPIPE] error shall still be
>returned
>
>And the same for 'sendto()' and 'sendmsg()'
>
>Link to the POSIX document:
>https://www.open-std.org/jtc1/sc22/open/n4217.pdf
>
>TCP (I think we must rely on it), KCM, SMC sockets (all of them are stream=
) work in the same
>way by calling this function. AF_UNIX also works in the same way, but it i=
mplements SIGPIPE handling
>without this function.

I'm okay calling this function.

>
>The only thing that confused me a little bit, that sockets above returns E=
PIPE when
>we have only SEND_SHUTDOWN set, but for AF_VSOCK EPIPE is returned for RCV=
_SHUTDOWN
>also, but I think it is related to this patchset.

Do you mean that it is NOT related to this patchset?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
