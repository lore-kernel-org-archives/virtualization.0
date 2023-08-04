Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B5EC04A94
	for <virtualization@archiver.kernel.org>; Fri,  4 Aug 2023 15:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992A183FAF;
	Fri,  4 Aug 2023 15:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 992A183FAF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMxoj31u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7wAKP-FHsNt; Fri,  4 Aug 2023 15:02:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 145128348C;
	Fri,  4 Aug 2023 15:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 145128348C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA669C0072;
	Fri,  4 Aug 2023 15:02:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB65CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 15:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D5C460FC1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 15:02:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D5C460FC1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMxoj31u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A9Kx3ifQWKfu
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 15:02:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9646360F5C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 15:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9646360F5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691161344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAWIlYpJLnUymxT3pJEp6AXLP821uJJ5c8Qht/hXEKc=;
 b=jMxoj31uMilJzvmvxrYMydZ1XgHbqlWwd08eTC5S6HONBmlEUaIgYPgZSex2cOQv1ftBtG
 eM3U+OXYzDVTHLOfkTPSwigbUUZyceMLOjXhDYnX5YLCt5wk4H9coqPgypGaGvuuYSw2v2
 l29OOTv0eGzG+YznpueYHfXg+n+G/Pc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-j7mLoCfZMQC5jgM9ZflLpA-1; Fri, 04 Aug 2023 11:02:17 -0400
X-MC-Unique: j7mLoCfZMQC5jgM9ZflLpA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so142723766b.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Aug 2023 08:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691161336; x=1691766136;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAWIlYpJLnUymxT3pJEp6AXLP821uJJ5c8Qht/hXEKc=;
 b=S/oqD5oumnoRZ8uySsHG4uI2uku0yDwrobUUaJK9wPa7v4HkYE1bcCwUUVRlsyaK1/
 0wCgmn5SEGS/bB9Spq2AnXLVaMU7mQobdbc69g1QWytcPGEQxRJsFEAC5EI+HSYZfe76
 adLt+ai5hCNuCgB0C7UaZzMTr30f6PmtBy4VFSxiCE6/+V/WAXZUZAtghKCblZU0/TmM
 iP3A6QAFWZXDWkqFmK8p/HYv6pZIjvA5ARkbYazSZaPaCLMV+h+2JZW9RVtaozACa1qw
 LyQOPKRS2t7+diWAVc78DS936fE3n53o5uzjHpxqC0ORgwqWjUalPZxLaIdmn4BOOBG4
 u3wg==
X-Gm-Message-State: AOJu0YzsAaLiL9Yf0hOE6KAOpusMlm3Q0u6D/q7pGXxuQF+ULvDY+89A
 78Up9viSYhv/hmmihfrl45/fWW6yVulHzLrV4UGAa6nkwlKXsYLXhQ9tObkwNS9uFxeg7zOfCZx
 qWfYi2iMwgg6NdMu2bEKeaXqTqRFx/X/I5wBP1Sf7VQ==
X-Received: by 2002:a17:906:308d:b0:99c:5708:496f with SMTP id
 13-20020a170906308d00b0099c5708496fmr1476056ejv.47.1691161336694; 
 Fri, 04 Aug 2023 08:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4buQlfj5+z9A6xIc2zcmROIFoujfZijSLwc66A0Da2XFPINrE4kSVfdcb8SyEajwJi0yrCg==
X-Received: by 2002:a17:906:308d:b0:99c:5708:496f with SMTP id
 13-20020a170906308d00b0099c5708496fmr1476035ejv.47.1691161336276; 
 Fri, 04 Aug 2023 08:02:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 lc21-20020a170906f91500b00992b510089asm1414920ejb.84.2023.08.04.08.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:02:15 -0700 (PDT)
Date: Fri, 4 Aug 2023 17:02:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <e2ytj5asmxnyb7oebxpzfuithtidwzcwxki7aao2q344sg3yru@ezqk5iezf3i4>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
 <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
 <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
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

On Fri, Aug 04, 2023 at 05:34:20PM +0300, Arseniy Krasnov wrote:
>
>
>On 04.08.2023 17:28, Stefano Garzarella wrote:
>> On Fri, Aug 04, 2023 at 03:46:47PM +0300, Arseniy Krasnov wrote:
>>> Hi Stefano,
>>>
>>> On 02.08.2023 10:46, Stefano Garzarella wrote:
>>>> On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>>>>> POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which w=
as
>>>>> shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>>>>> flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>> net/vmw_vsock/af_vsock.c | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>> index 020cf17ab7e4..013b65241b65 100644
>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>> @@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct soc=
ket *sock, struct msghdr *msg,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D total_written;
>>>>> =A0=A0=A0=A0}
>>>>> out:
>>>>> +=A0=A0=A0 if (sk->sk_type =3D=3D SOCK_STREAM)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 err =3D sk_stream_error(sk, msg->msg_flags, er=
r);
>>>>
>>>> Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?
>>>
>>> Yes, here is my explanation:
>>>
>>> This function checks that input error is SIGPIPE, and if so it sends SI=
GPIPE to the 'current' thread
>>> (except case when MSG_NOSIGNAL flag is set). This behaviour is describe=
d in POSIX:
>>>
>>> Page 367 (description of defines from sys/socket.h):
>>> MSG_NOSIGNAL: No SIGPIPE generated when an attempt to send is made on a=
 stream-
>>> oriented socket that is no longer connected.
>>>
>>> Page 497 (description of SOCK_STREAM):
>>> A SIGPIPE signal is raised if a thread sends on a broken stream (one th=
at is
>>> no longer connected).
>>
>> Okay, but I think we should do also for SEQPACKET:
>>
>> https://pubs.opengroup.org/onlinepubs/009696699/functions/xsh_chap02_10.=
html
>>
>> In 2.10.6 Socket Types:
>>
>> "The SOCK_SEQPACKET socket type is similar to the SOCK_STREAM type, and
>> is also connection-oriented. The only difference between these types is
>> that record boundaries ..."
>>
>> Then in=A0 2.10.14 Signals:
>>
>> "The SIGPIPE signal shall be sent to a thread that attempts to send data
>> on a socket that is no longer able to send. In addition, the send
>> operation fails with the error [EPIPE]."
>>
>> It's honestly not super clear, but I assume the problem is similar with
>> seqpacket since it's connection-oriented, or did I miss something?
>>
>> For example in sctp_sendmsg() IIUC we raise a SIGPIPE regardless of
>> whether the socket is STREAM or SEQPACKET.
>
>Hm, yes, you're right. Seems check for socket type is not needed in this c=
ase,
>as this function is only for connection oriented sockets.

Ack!

>
>>
>>>
>>> Page 1802 (description of 'send()' call):
>>> MSG_NOSIGNAL
>>>
>>> Requests not to send the SIGPIPE signal if an attempt to
>>> send is made on a stream-oriented socket that is no
>>> longer connected. The [EPIPE] error shall still be
>>> returned
>>>
>>> And the same for 'sendto()' and 'sendmsg()'
>>>
>>> Link to the POSIX document:
>>> https://www.open-std.org/jtc1/sc22/open/n4217.pdf
>>>
>>> TCP (I think we must rely on it), KCM, SMC sockets (all of them are str=
eam) work in the same
>>> way by calling this function. AF_UNIX also works in the same way, but i=
t implements SIGPIPE handling
>>> without this function.
>>
>> I'm okay calling this function.
>>
>>>
>>> The only thing that confused me a little bit, that sockets above return=
s EPIPE when
>>> we have only SEND_SHUTDOWN set, but for AF_VSOCK EPIPE is returned for =
RCV_SHUTDOWN
>>> also, but I think it is related to this patchset.
>>
>> Do you mean that it is NOT related to this patchset?
>
>Yes, **NOT**

Got it, so if you have time when you're back, let's check also that
(not for this series as you mentioned).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
