Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07699C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 09:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 802E6813C5;
	Mon,  5 Dec 2022 09:39:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 802E6813C5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZZ/9uT6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DM7XDQftU1nD; Mon,  5 Dec 2022 09:38:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BFE780DCC;
	Mon,  5 Dec 2022 09:38:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BFE780DCC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2954EC0033;
	Mon,  5 Dec 2022 09:38:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F805C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A93D40514
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A93D40514
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZZ/9uT6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tx5XnBUv10sb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:38:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA011404DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA011404DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670233128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fbDbQQPxO62jOc30ZCiGvrM9jORKTwJPATgGVcGw/4=;
 b=aZZ/9uT675CFPIjv+V3iL8i7WRnI7pI5MT8HeqLtoOipYnSeQEuVulaQWYPu1MEChyfSEr
 F4tIXlUnTZ//pN4Z1VdpmvwRsDybGwgQXDcEQgwKGkWaN5KkyEyfsIiBx2JV3+j0LyTHMG
 0OjgsT0UuVJmHOc+bad7/FKQRYnJkfE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-504-sVq3UFWkP6yq0XHAioNQbw-1; Mon, 05 Dec 2022 04:38:47 -0500
X-MC-Unique: sVq3UFWkP6yq0XHAioNQbw-1
Received: by mail-qt1-f198.google.com with SMTP id
 fb5-20020a05622a480500b003a525d52abcso31512655qtb.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 01:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fbDbQQPxO62jOc30ZCiGvrM9jORKTwJPATgGVcGw/4=;
 b=qmwqO0exTcCSAnfbi+1nnuyVHb0QOC1qx04riBBzd/kMRHL/BbA6n7gtn1ML53gkMi
 0sMXTA2uju8/GxpfGe2aJtBN9kOlt1W0kodBeLCCQCut5zEOBVPBbyLCWApPKCMdZYXU
 oBoQ5ta5PAca3kG+0gcNa1XwhYO9qX035qBVFaY2VM83u5JZtKZ7x+0sj27b+4vHD+sK
 xnlLhZ8vALDBlkwpLSZNzDDKqbtrLivFQ1NHmzUNaj6092L1VeFAY1GZjxd3yLdEhCpi
 vJxq8ihDpMOMCXZFPpZp/J/j3ATolVQyMFuVowXTqtYMMpZYydGDQFvc4WeE63DeL8x0
 vCzw==
X-Gm-Message-State: ANoB5pkTs/f5XbdTzqNlprU3kVi4vEprt0rgBDmBMvAsTpLKzqnM1bhM
 f++xYxxGq3PFBDGzEOyJMmZi884iR2tLOqkitWGrxjL3WBLkVxgczzSTyq76gk9Tr0ht9PvT7Xp
 cDXsZT/loSPeBsQdONx8YA34n2kld/AmAKm2tEhw5JQ==
X-Received: by 2002:a05:6214:348a:b0:4c7:53a9:9093 with SMTP id
 mr10-20020a056214348a00b004c753a99093mr8233899qvb.79.1670233126803; 
 Mon, 05 Dec 2022 01:38:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6tHHotrSA8b/cA8OdX2reWyR5JpmHe9IB3vPxBjfFYu5K8xypQAG0C+aqEeW0Vinl/4QRK4A==
X-Received: by 2002:a05:6214:348a:b0:4c7:53a9:9093 with SMTP id
 mr10-20020a056214348a00b004c753a99093mr8233877qvb.79.1670233126520; 
 Mon, 05 Dec 2022 01:38:46 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 s18-20020a05620a29d200b006f9ddaaf01esm12476510qkp.102.2022.12.05.01.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 01:38:46 -0800 (PST)
Date: Mon, 5 Dec 2022 10:38:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 5/6] test/vsock: add big message test
Message-ID: <20221205093837.2aag3xnvqviyxbqv@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <2634ad7f-b462-5c69-8aa1-2f200a6beb20@sberdevices.ru>
 <20221201094541.gj7zthelbeqhsp63@sgarzare-redhat>
 <2694faa5-c460-857d-6ca9-a6328530ff23@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2694faa5-c460-857d-6ca9-a6328530ff23@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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

On Thu, Dec 01, 2022 at 11:44:39AM +0000, Arseniy Krasnov wrote:
>On 01.12.2022 12:45, Stefano Garzarella wrote:
>> On Fri, Nov 25, 2022 at 05:13:06PM +0000, Arseniy Krasnov wrote:
>>> This adds test for sending message, bigger than peer's buffer size.
>>> For SOCK_SEQPACKET socket it must fail, as this type of socket has
>>> message size limit.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> tools/testing/vsock/vsock_test.c | 69 ++++++++++++++++++++++++++++++++
>>> 1 file changed, 69 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vso=
ck_test.c
>>> index 12ef0cca6f93..a8e43424fb32 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -569,6 +569,70 @@ static void test_seqpacket_timeout_server(const st=
ruct test_opts *opts)
>>> =A0=A0=A0=A0close(fd);
>>> }
>>>
>>> +static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>>> +{
>>> +=A0=A0=A0 unsigned long sock_buf_size;
>>> +=A0=A0=A0 ssize_t send_size;
>>> +=A0=A0=A0 socklen_t len;
>>> +=A0=A0=A0 void *data;
>>> +=A0=A0=A0 int fd;
>>> +
>>> +=A0=A0=A0 len =3D sizeof(sock_buf_size);
>>> +
>>> +=A0=A0=A0 fd =3D vsock_seqpacket_connect(opts->peer_cid, 1234);
>>> +=A0=A0=A0 if (fd < 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0 perror("connect");
>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 if (getsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &sock_buf_size, &len)) {
>>> +=A0=A0=A0=A0=A0=A0=A0 perror("getsockopt");
>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 sock_buf_size++;
>>> +
>>> +=A0=A0=A0 data =3D malloc(sock_buf_size);
>>> +=A0=A0=A0 if (!data) {
>>> +=A0=A0=A0=A0=A0=A0=A0 perror("malloc");
>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 send_size =3D send(fd, data, sock_buf_size, 0);
>>> +=A0=A0=A0 if (send_size !=3D -1) {
>>> +=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "expected 'send(2)' failure, got=
 %zi\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 send_size);
>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 if (errno !=3D EMSGSIZE) {
>>> +=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "expected EMSGSIZE in 'errno', g=
ot %i\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 errno);
>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0 }
>>
>> We should make sure that this is true for all transports, but since now =
only virtio-vsock supports it, we should be okay.
>Hm, in general: I've tested this test suite for vmci may be several months=
 ago, and found, that some tests
>didn't work. I'm thinking about reworking this test suite a little bit: ea=
ch transport must have own set of
>tests for features that it supports. I had feeling, that all these tests a=
re run only with virtio transport :)
>Because for example SEQPACKET mode is suported only for virtio.

Yep, when we developed it, we added the "--skip" param for that.
Ideally there should be no difference, but I remember VMCI had a =

different behavior and we couldn't change it for backward compatibility, =

so we added "--skip".

Thanks,
Steano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
