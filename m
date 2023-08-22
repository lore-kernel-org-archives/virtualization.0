Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98362EE4993
	for <virtualization@archiver.kernel.org>; Tue, 22 Aug 2023 09:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A5E960B09;
	Tue, 22 Aug 2023 09:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A5E960B09
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4/B3n+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Zb1WKLwGhCJ; Tue, 22 Aug 2023 09:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 969AA60AE3;
	Tue, 22 Aug 2023 09:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 969AA60AE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6530DC0071;
	Tue, 22 Aug 2023 09:39:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B43C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD0E08146A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:39:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD0E08146A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4/B3n+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0khs7YZYNhaR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:39:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A2238142E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 09:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A2238142E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692697165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txMvXVZ0kMppatMDVgUyzHmRHXS5/JZIN8KKI6DAuJ0=;
 b=a4/B3n+3Alayx59UFu/Yto/fDZ3TwDicEChCg3eCdJ0FPup3Yvm3X4z8xpqB/MCbhuDPPY
 huM3fFA9wBFp9QnjEt93MpOttuiiB3zxNK89nnP/GBo+X4apzoW4EzhN94JHYemeoNQ7dI
 40Z3Gsxgzfx/Zg7xzBkd2JpjUYJPD5Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-7C3P-9o5OLKu3mjUtUTGgQ-1; Tue, 22 Aug 2023 05:39:23 -0400
X-MC-Unique: 7C3P-9o5OLKu3mjUtUTGgQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-40ff829c836so41348011cf.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 02:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697163; x=1693301963;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=txMvXVZ0kMppatMDVgUyzHmRHXS5/JZIN8KKI6DAuJ0=;
 b=W+eE9nWRbmHD8Ifra/KwW+3bUfzDoHYbU4nByx1qP/SivYhNPjsSWozYuYYbtAeNxG
 Vuygod+8Bbo6U+bCY+GWUFrLtrVAmH3DZwyWPFVe0baXjH7gjD3yXtGaJzS3rdiT0Zzw
 sApBXPFSfraJhuRS065ec+iMo5+DyggnvsqbZh3dh2RY3GRV8ZAqeTA39iQiTrKEPWq3
 vGubPMajFVZDOPZEhRK3wDmnChaTI/qhlWvKK/PDTH5Qm39UnTB+5yz18H8YdKQwqHmx
 t8hvp6A2AbEdWulCeBdrwXxgFiPCMWv4z+XLQudsO0R9Re11hQXWcGxsSF+r/y35yPOz
 rlhQ==
X-Gm-Message-State: AOJu0YxrwrM+rzmAKU9lh5Wfz5rDZNwMqo0kgLEnwpnvae5o3jKlKnvp
 Kaa9C4PWGCJBAG30ZRYcCLc6VJFVCW+cKUJtX9OyX+GyMparoB3Dy8a5LCntyBECLrNdpq/7NKX
 zrmfLHxDHxbJdXWeptOj+Xr+oWd4Lzu8mLrj8+Nntsg==
X-Received: by 2002:ac8:59d6:0:b0:403:d440:2f99 with SMTP id
 f22-20020ac859d6000000b00403d4402f99mr10676960qtf.27.1692697163093; 
 Tue, 22 Aug 2023 02:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaxVbCTddadOKHJPm9G0BiLMjQpMjKaJTOzsoyhtziZnLWJPPYe0RA489/BqQdosjs8bS+aw==
X-Received: by 2002:ac8:59d6:0:b0:403:d440:2f99 with SMTP id
 f22-20020ac859d6000000b00403d4402f99mr10676944qtf.27.1692697162819; 
 Tue, 22 Aug 2023 02:39:22 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.203.174])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a05620a11b600b00767b4fa5d96sm3098824qkk.27.2023.08.22.02.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:39:22 -0700 (PDT)
Date: Tue, 22 Aug 2023 11:39:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <2ce6e3eihhtjigwectlgrbiv7ygnpki6vfdkav4effpti5gtj4@lldtdljxkyrb>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
 <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
 <49cdd121-3389-2f08-c0cc-89c9ac32cd1e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <49cdd121-3389-2f08-c0cc-89c9ac32cd1e@sberdevices.ru>
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

On Mon, Aug 14, 2023 at 10:46:05PM +0300, Arseniy Krasnov wrote:
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
>Update about sending SIGPIPE for SOCK_SEQPACKET, I checked POSIX doc and k=
ernel sources more deeply:
>
>
>1)
>
>I checked four types of sockets, which sends SIGPIPE for SOCK_SEQPACKET or=
 not ('YES' if
>this socket sends SIGPIPE in SOCK_SEQPACKET case):
>
>net/kcm/: YES
>net/unix/: NO
>net/sctp/: YES
>net/caif/: NO
>
>Looking for this, I think it is impossible to get the right answer, as the=
re is some
>mess - everyone implements it as wish.

Eheh, I had the same impression!

>
>2)
>
>I opened POSIX spec again, and here are details about returning EPIPE from=
 pages
>for 'send()', 'sendto()', 'sendmsg()':
>
>[EPIPE] The socket is shut down for writing, or the socket is connection-m=
ode and is
>no longer connected. In the latter case, and if the socket is of type
>SOCK_STREAM, the SIGPIPE signal is generated to the calling thread
>
>So my opinion is that we need to send SIGPIPE only for SOCK_STREAM. Anothe=
r question
>is how to interpret this from above (but again - SIGPIPE is related for SO=
CK_STREAM
>only):
>
>**" and is no longer connected"**
>
>IIUC, if we follow POSIX strictly, this check must be like:
>
>/* socket is shut down for writing or no longer connected. */
>if (sk->sk_shutdown & SEND_SHUTDOWN ||
>    vsk->peer_shutdown & RCV_SHUTDOWN ||
>    sock_flag(SOCK_DONE)) {
>	err =3D -EPIPE;
>	goto out;
>}
>
>...
>
>out:
>	/* Handle -EPIPE for stream socket which is no longer connected. */
>	if (sk->sk_type =3D=3D SOCK_STREAM &&
>		sock_flag(SOCK_DONE))
>		err =3D sk_stream_error();
>
>
>
>From the other side, we can just follow TCP/AF_UNIX implementations as bot=
h are
>popular types of socket. In this case I suggest to implement this check li=
ke
>(e.g. without sock_flag(SOCK_DONE)):
>
>
>if (sk->sk_shutdown & SEND_SHUTDOWN ||
>    vsk->peer_shutdown & RCV_SHUTDOWN) {
>	err =3D -EPIPE;
>	goto out;
>}
>
>...
>
>out:
>	if (sk->sk_type =3D=3D SOCK_STREAM)
>		err =3D sk_stream_error();
>
>What do you think?

I'd follow TCP/AF_UNIX implementations, but it is up to you ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
