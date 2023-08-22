Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D0AEE4993
	for <virtualization@archiver.kernel.org>; Tue, 22 Aug 2023 09:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8808081D47;
	Tue, 22 Aug 2023 09:37:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8808081D47
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=efG4w0c3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSIdRwRJN8Lo; Tue, 22 Aug 2023 09:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC37B81BF5;
	Tue, 22 Aug 2023 09:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC37B81BF5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9351C0071;
	Tue, 22 Aug 2023 09:37:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB62C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5E6240530
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5E6240530
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=efG4w0c3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00xDxQRP4iyK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:37:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4933F402E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4933F402E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692697025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88XKvBbvsZX0D94XbZs3LYQhbIwXeyaOzyGjFpIV09M=;
 b=efG4w0c3kkHxw/t2EqVM0fPXtANDihviph6LNqvnTzhj8VFOeUWc908BQ7h/U7WEvG+90k
 RLOFwSZYz02e9sneXAmUy0MRccBM4Q7MU3vO5zEcJ6oSmaeAs1ggSa4ntbrQvpCejo7TcN
 q3wv7jEc6YflaK6vB+LdlubW2UqC7C4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-K0p7zFVoOpyefuLgwGvQRg-1; Tue, 22 Aug 2023 05:37:01 -0400
X-MC-Unique: K0p7zFVoOpyefuLgwGvQRg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76d882c4906so576958185a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 02:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697021; x=1693301821;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88XKvBbvsZX0D94XbZs3LYQhbIwXeyaOzyGjFpIV09M=;
 b=epWEXCKNrUz+xbefUxNhiPJ36oh8vMcQiiYgWFOXbdl4UcmJOb0wsramNcUweJHHDm
 0MDaJblmq2SHQnfWHppUcK+xCJvV4SF2GcV2KYVdNiIVdu+pMxySP8E9Kk7xhPZ/2Tti
 Gu9orynW4YH1tLDDpmaJUlZPbse0VJFKASDFL0S0jBzgJL4LG1Of5VKlqVHmv7NQSnWf
 tiZ1lw37iJlbt7lpKfWb0qeo/n5dGpxJ4LVzyZjoNGrZX3H1uehBIX9Hd3x0noXvmSCm
 32Lz/dP7txmSdafF6rhTKiD1943lwNRtIKjnDcX1dPxXQ+DAI3z7/Bu41s1cupyO3Ajt
 6nzA==
X-Gm-Message-State: AOJu0Yw80B+mcQpYUpR78+FRPImFcscK9OoWU9r+p4fi/xKaSDSFSlpX
 q71qocGi7uoJ9MQjcgSWWJUmRxqPbuwPqQU6aQ+fF+CfFKa+It7QZI5lTu6Oglc8FnGPflAdoa/
 gFY3oNWuN/UjchQeAXcWVNr7hJomZE6TWgzXrdRJ/vQ==
X-Received: by 2002:a05:620a:2846:b0:76d:5d0a:bbae with SMTP id
 h6-20020a05620a284600b0076d5d0abbaemr11761440qkp.56.1692697020936; 
 Tue, 22 Aug 2023 02:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqiiFiAb1dy2pjAQIW67i5TzCZYjsu3zaiNgThtV7tFgSZ11knhoDsrhWXkOFFbN2wgXSlMQ==
X-Received: by 2002:a05:620a:2846:b0:76d:5d0a:bbae with SMTP id
 h6-20020a05620a284600b0076d5d0abbaemr11761419qkp.56.1692697020641; 
 Tue, 22 Aug 2023 02:37:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.203.174])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a05620a126800b00767cd764ecfsm3103547qkl.33.2023.08.22.02.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:37:00 -0700 (PDT)
Date: Tue, 22 Aug 2023 11:36:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <kernljom75y4nzle7s5cfid6pm6rvhf7t3zf4mrdes7oxjry23@pm7cdshzvemn>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
 <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
 <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
 <e2ytj5asmxnyb7oebxpzfuithtidwzcwxki7aao2q344sg3yru@ezqk5iezf3i4>
 <5a01c815-ae19-8f3c-2367-ca9aa74aba5f@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <5a01c815-ae19-8f3c-2367-ca9aa74aba5f@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <oxffffaa@gmail.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
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

On Mon, Aug 14, 2023 at 10:40:17PM +0300, Arseniy Krasnov wrote:
>
>
>On 04.08.2023 18:02, Stefano Garzarella wrote:
>> On Fri, Aug 04, 2023 at 05:34:20PM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 04.08.2023 17:28, Stefano Garzarella wrote:
>>>> On Fri, Aug 04, 2023 at 03:46:47PM +0300, Arseniy Krasnov wrote:
>>>>> Hi Stefano,
>>>>>
>>>>> On 02.08.2023 10:46, Stefano Garzarella wrote:
>>>>>> On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>>>>>>> POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which=
 was
>>>>>>> shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>>>>>>> flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>>>>>>>
>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>> ---
>>>>>>> net/vmw_vsock/af_vsock.c | 3 +++
>>>>>>> 1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>>>> index 020cf17ab7e4..013b65241b65 100644
>>>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>>>> @@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct s=
ocket *sock, struct msghdr *msg,
>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D total_written;
>>>>>>> =A0=A0=A0=A0}
>>>>>>> out:
>>>>>>> +=A0=A0=A0 if (sk->sk_type =3D=3D SOCK_STREAM)
>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 err =3D sk_stream_error(sk, msg->msg_flags, =
err);
>>>>>>
>>>>>> Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?
>>>>>
>>>>> Yes, here is my explanation:
>>>>>
>>>>> This function checks that input error is SIGPIPE, and if so it sends =
SIGPIPE to the 'current' thread
>>>>> (except case when MSG_NOSIGNAL flag is set). This behaviour is descri=
bed in POSIX:
>>>>>
>>>>> Page 367 (description of defines from sys/socket.h):
>>>>> MSG_NOSIGNAL: No SIGPIPE generated when an attempt to send is made on=
 a stream-
>>>>> oriented socket that is no longer connected.
>>>>>
>>>>> Page 497 (description of SOCK_STREAM):
>>>>> A SIGPIPE signal is raised if a thread sends on a broken stream (one =
that is
>>>>> no longer connected).
>>>>
>>>> Okay, but I think we should do also for SEQPACKET:
>>>>
>>>> https://pubs.opengroup.org/onlinepubs/009696699/functions/xsh_chap02_1=
0.html
>>>>
>>>> In 2.10.6 Socket Types:
>>>>
>>>> "The SOCK_SEQPACKET socket type is similar to the SOCK_STREAM type, and
>>>> is also connection-oriented. The only difference between these types is
>>>> that record boundaries ..."
>>>>
>>>> Then in=A0 2.10.14 Signals:
>>>>
>>>> "The SIGPIPE signal shall be sent to a thread that attempts to send da=
ta
>>>> on a socket that is no longer able to send. In addition, the send
>>>> operation fails with the error [EPIPE]."
>>>>
>>>> It's honestly not super clear, but I assume the problem is similar with
>>>> seqpacket since it's connection-oriented, or did I miss something?
>>>>
>>>> For example in sctp_sendmsg() IIUC we raise a SIGPIPE regardless of
>>>> whether the socket is STREAM or SEQPACKET.
>>>
>>> Hm, yes, you're right. Seems check for socket type is not needed in thi=
s case,
>>> as this function is only for connection oriented sockets.
>>
>> Ack!
>>
>>>
>>>>
>>>>>
>>>>> Page 1802 (description of 'send()' call):
>>>>> MSG_NOSIGNAL
>>>>>
>>>>> Requests not to send the SIGPIPE signal if an attempt to
>>>>> send is made on a stream-oriented socket that is no
>>>>> longer connected. The [EPIPE] error shall still be
>>>>> returned
>>>>>
>>>>> And the same for 'sendto()' and 'sendmsg()'
>>>>>
>>>>> Link to the POSIX document:
>>>>> https://www.open-std.org/jtc1/sc22/open/n4217.pdf
>>>>>
>>>>> TCP (I think we must rely on it), KCM, SMC sockets (all of them are s=
tream) work in the same
>>>>> way by calling this function. AF_UNIX also works in the same way, but=
 it implements SIGPIPE handling
>>>>> without this function.
>>>>
>>>> I'm okay calling this function.
>>>>
>>>>>
>>>>> The only thing that confused me a little bit, that sockets above retu=
rns EPIPE when
>>>>> we have only SEND_SHUTDOWN set, but for AF_VSOCK EPIPE is returned fo=
r RCV_SHUTDOWN
>>>>> also, but I think it is related to this patchset.
>>>>
>>>> Do you mean that it is NOT related to this patchset?
>>>
>>> Yes, **NOT**
>>
>> Got it, so if you have time when you're back, let's check also that
>> (not for this series as you mentioned).
>
>^^^
>Hello Stefano, so:
>
>there is some confusion with check for RCV_SHUTDOWN: it presents in AF_UNI=
X, but missed
>in TCP (it checks only for SEND_SHUTDOWN). I performed simple test which t=
ries
>to send data to peer which already called shutdown(SHUT_RD) - AF_UNIX and =
TCP behave
>differently. AF_UNIX sends SIGPIPE, while TCP allows to send data.
>
>I suggest to not touch this check for AF_VSOCK (e.g. continue work as AF_U=
NIX),
>because I don't see strong motivation/argument to remove it.

Yep, I agree!

However, I think it's a fairly borderline case, so unless we have a
specific request, I wouldn't spend too much time on it.

Thanks for looking at it!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
