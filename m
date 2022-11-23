Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75918C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 15:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F0FFD40BB5;
	Wed, 23 Nov 2022 15:22:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0FFD40BB5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XQ4zh5vJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0zKBWjXtY-R; Wed, 23 Nov 2022 15:22:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 823DC4032E;
	Wed, 23 Nov 2022 15:22:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 823DC4032E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE52C0032;
	Wed, 23 Nov 2022 15:22:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B987C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6347C61085
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:22:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6347C61085
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XQ4zh5vJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dVWOPKQ9R81I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:22:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 580B061183
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 580B061183
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669216928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAQ+WUBilLvtBfWw+OuxYtN3auR7ZBxIQdmmFViSJCU=;
 b=XQ4zh5vJn4kX6WkkgoZwvhmjP748S6BsAZel1G00opQiMHKJ8XNXrhKEwkrXUCWGE6tpt4
 eQya7MKwK0NlK1foLmvVW5bD6zj1wWmaXnQulqjiosfD0nCz9xdqkvwrfOqTT0s3cJw8qJ
 7MgZYyiDh2x2ED1WJlJ+44EAcuJKneo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-fM0_9el7Md2F1O44_WzCyA-1; Wed, 23 Nov 2022 10:22:07 -0500
X-MC-Unique: fM0_9el7Md2F1O44_WzCyA-1
Received: by mail-qv1-f69.google.com with SMTP id
 og17-20020a056214429100b004c6ae186493so7482485qvb.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 07:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iAQ+WUBilLvtBfWw+OuxYtN3auR7ZBxIQdmmFViSJCU=;
 b=BMQ/2hRLTsN/cGqjkCPfJ85CByDWLvNXbaG2M6CbAioMxs+sS9KpQWDqyBn5/XunHX
 a6gyUSZpfiaE0iOva9c3K/BkhbAgFi7K97/0/52grviYNyOWlcRazqJzehnqDHoyZWwj
 6kX057HA0XnwyaH53s5XUix/xWW8T8PGi8ba+OONFbqzSuAFnlODqwiC6K3eaFL/xA4a
 pEFwVoYVXszTd8i6uEI1qU0TxgjG8GmqsAK1XXd/HabxgNWzqzrWTcbOgalAPABSf+ZE
 jeK4ev/LfGQUDCsCV/uj7Ql3vtK+PbhxRvhrJ755RWsbk2H9jVgdXKZdKmSMbxB3Mlor
 m3jg==
X-Gm-Message-State: ANoB5pkowhUYWS4guoivxm8b6WGy1RJ558XXDAohnWLDerWhfCcXsWLa
 nem4xsvRSyfntXLli/twOfDuFs/akCerg6mT0pYRuGfJhjzBj2Vf+qVaSL7G+UUeqtD3Dvqbvt6
 eFIo+S5R/Let6tTiwtirpR213kKWaml3Fpz1wmaJ1LQ==
X-Received: by 2002:a05:622a:4c15:b0:398:8048:6f75 with SMTP id
 ey21-20020a05622a4c1500b0039880486f75mr10367985qtb.316.1669216926650; 
 Wed, 23 Nov 2022 07:22:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4sD3+Iedq4yhwBmBg6QKG+ew06sbvutG4uKTF/wuyFU4KECi/G/prQEwmsbfcWmBDXde195w==
X-Received: by 2002:a05:622a:4c15:b0:398:8048:6f75 with SMTP id
 ey21-20020a05622a4c1500b0039880486f75mr10367963qtb.316.1669216926356; 
 Wed, 23 Nov 2022 07:22:06 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 m20-20020a05620a24d400b006b949afa980sm12666193qkn.56.2022.11.23.07.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Nov 2022 07:22:05 -0800 (PST)
Date: Wed, 23 Nov 2022 16:21:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [RFC PATCH v1 2/3] test/vsock: add big message test
Message-ID: <20221123152159.xbqhsslrhh4ymbnn@sgarzare-redhat>
References: <ba294dff-812a-bfc2-a43c-286f99aee0b8@sberdevices.ru>
 <f0510949-cc97-7a01-5fc8-f7e855b80515@sberdevices.ru>
 <20221121145248.cmscv5vg3fir543x@sgarzare-redhat>
 <ff71c2d3-9f61-d649-7ae5-cd012eada10d@sberdevices.ru>
 <749f147b-6112-2e6f-1ebe-05ba2e8a8727@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <749f147b-6112-2e6f-1ebe-05ba2e8a8727@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel <kernel@sberdevices.ru>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Nov 21, 2022 at 09:40:39PM +0000, Arseniy Krasnov wrote:
>On 21.11.2022 19:50, Arseniy Krasnov wrote:
>> On 21.11.2022 17:52, Stefano Garzarella wrote:
>>> On Tue, Nov 15, 2022 at 08:52:35PM +0000, Arseniy Krasnov wrote:
>>>> This adds test for sending message, bigger than peer's buffer size.
>>>> For SOCK_SEQPACKET socket it must fail, as this type of socket has
>>>> message size limit.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>> tools/testing/vsock/vsock_test.c | 62 ++++++++++++++++++++++++++++++++
>>>> 1 file changed, 62 insertions(+)
>>>>
>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vs=
ock_test.c
>>>> index 107c11165887..bb4e8657f1d6 100644
>>>> --- a/tools/testing/vsock/vsock_test.c
>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>> @@ -560,6 +560,63 @@ static void test_seqpacket_timeout_server(const s=
truct test_opts *opts)
>>>> =A0=A0=A0=A0close(fd);
>>>> }
>>>>
>>>> +static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>>>> +{
>>>> +=A0=A0=A0 unsigned long sock_buf_size;
>>>> +=A0=A0=A0 ssize_t send_size;
>>>> +=A0=A0=A0 socklen_t len;
>>>> +=A0=A0=A0 void *data;
>>>> +=A0=A0=A0 int fd;
>>>> +
>>>> +=A0=A0=A0 len =3D sizeof(sock_buf_size);
>>>> +
>>>> +=A0=A0=A0 fd =3D vsock_seqpacket_connect(opts->peer_cid, 1234);
>>>
>>> Not for this patch, but someday we should add a macro for this port and=
 maybe even make it configurable :-)
>>>
>>>> +=A0=A0=A0 if (fd < 0) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("connect");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 if (getsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &sock_buf_size, &len)) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("getsockopt");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 sock_buf_size++;
>>>> +
>>>> +=A0=A0=A0 data =3D malloc(sock_buf_size);
>>>> +=A0=A0=A0 if (!data) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("malloc");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 send_size =3D send(fd, data, sock_buf_size, 0);
>>>> +=A0=A0=A0 if (send_size !=3D -1) {
>>>
>>> Can we check also `errno`?
>>> IIUC it should contains EMSGSIZE.
>Hm, seems current implementation is a little bit broken and returns ENOMEM=
, because any negative value, returned by
>transport callback is always replaced to ENOMEM. I think i need this patch=
 from Bobby:
>https://lore.kernel.org/lkml/d81818b868216c774613dd03641fcfe63cc55a45.1660=
362668.git.bobby.eshleman@bytedance.com/
>May be i can include it to this patchset also fixing review comments(of co=
urse keeping Bobby as author). Or more
>simple way is to check ENOMEM instead of EMSGSIZE in this test(simple, but=
 a little bit dumb i think).

Maybe in this patch you can start checking ENOMEM (with a TODO comment),
and then Bobby can change it when sending his patch.

Or you can repost it (I'm not sure if we should keep the legacy behavior =

for other transports or it was an error, but better to discuss it on =

that patch). However, I think we should merge that patch.

@Bobby, what do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
