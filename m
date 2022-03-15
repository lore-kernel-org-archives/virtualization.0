Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E403AC433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 12:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91B93841FF;
	Tue, 15 Mar 2022 12:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2Pork9nMOLo; Tue, 15 Mar 2022 12:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE180841DD;
	Tue, 15 Mar 2022 12:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72E0EC001A;
	Tue, 15 Mar 2022 12:55:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41BBFC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1969F416BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynnR2PU_E11p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:55:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D655416B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647348914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7kF6mwRMvcQL1DtiGEysf7dz4yz7QqO8NSJRvpKnr4=;
 b=DKBmqFg1HlKuETJ/TdoLqLnERW9Q5aBrSFBh7oPIdKDZ1cnexxxqndR8xjCFRPfF18mw22
 eI/YewnIsKGQkmMKmA27CG4GQIOVhQR3XpmTSn//riN/h8JAvlkzS1s+CoCq9L2VFKxX9b
 zveyLrdIdYNmAFOTkjKsJwDQg5+duQw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-xkOLlRGHMDKAJqo1Teg5tw-1; Tue, 15 Mar 2022 08:55:13 -0400
X-MC-Unique: xkOLlRGHMDKAJqo1Teg5tw-1
Received: by mail-qv1-f72.google.com with SMTP id
 j6-20020a056214032600b004358f15c51bso16470274qvu.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/7kF6mwRMvcQL1DtiGEysf7dz4yz7QqO8NSJRvpKnr4=;
 b=5mB4V6N7aPGSztFMWGD9IfCPc1iSUCa7iTk4sxSx/UfTYm4XGE7i8FE0tv/ToueG2G
 +dDDhkjjide8yqhNMDjwb8wG5KU/Bh80gXLlf0P0u0RC+X2PttYXIjZLIpZefNWN/D78
 igNF2r5cQ1Bwtkj5Jru0/5bsx/XFe2Ojtg5lT7qqShYCYA2Rdd+L6X1FbPti3VR78ols
 5vcxB1QR8t4zIbbeMED5FfbR8bN8SW9IoohegGVnHbnQ2rHimKPrP0y7jGogT+DOakZ1
 5kSSKKFQhmne+VaG+vEkmlL8eFRE+dLzoH0V1OAbGHjIiOWVG7PSqPL+zIPWPLufD4TP
 rs4w==
X-Gm-Message-State: AOAM533NXz2LkHnbVxvU7ALy56ZHdlkUdL2kI83CWQJDs4U1MuBTsLFa
 ujrIoiwxgJhzZWd/YRjyP/6MSdd/CMmLqIJu0tXwZWMzl4iy9uw2FyK4znBQ5rrRzICotjL2Exz
 G63pNneZD/iV3JdD3bSrLy0CnyP3IzNT9pV72Ztuuqg==
X-Received: by 2002:a05:6214:2689:b0:435:be79:a17e with SMTP id
 gm9-20020a056214268900b00435be79a17emr20994834qvb.35.1647348913104; 
 Tue, 15 Mar 2022 05:55:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBekmlL+mi9yLEYSbEo0oZTdDpBDWm38egtm8H1DGuL5A7k5WLIfNlBSOt5YUdgYGPYOnxvA==
X-Received: by 2002:a05:6214:2689:b0:435:be79:a17e with SMTP id
 gm9-20020a056214268900b00435be79a17emr20994818qvb.35.1647348912845; 
 Tue, 15 Mar 2022 05:55:12 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a376b07000000b006492f19ae76sm9286561qkc.27.2022.03.15.05.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 05:55:12 -0700 (PDT)
Date: Tue, 15 Mar 2022 13:55:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] af_vsock: SOCK_SEQPACKET broken buffer test
Message-ID: <20220315125504.ut3bxfw5jvuop33d@sgarzare-redhat>
References: <1bb5ce91-da53-7de9-49ba-f49f76f45512@sberdevices.ru>
 <bc309cf9-5bcf-b645-577f-8e5b0cf6f220@sberdevices.ru>
 <20220315083617.n33naazzf3se4ozo@sgarzare-redhat>
 <b452aeac-9628-5e37-e0e6-d33f8bb47b22@sberdevices.ru>
 <f05280bb-9b48-8705-a2ef-3d02ea98fd25@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <f05280bb-9b48-8705-a2ef-3d02ea98fd25@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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

On Tue, Mar 15, 2022 at 12:43:13PM +0000, Krasnov Arseniy Vladimirovich wro=
te:
>On 15.03.2022 12:35, Arseniy Krasnov wrote:
>> On 15.03.2022 11:36, Stefano Garzarella wrote:
>>> On Fri, Mar 11, 2022 at 10:58:32AM +0000, Krasnov Arseniy Vladimirovich=
 wrote:
>>>> Add test where sender sends two message, each with own
>>>> data pattern. Reader tries to read first to broken buffer:
>>>> it has three pages size, but middle page is unmapped. Then,
>>>> reader tries to read second message to valid buffer. Test
>>>> checks, that uncopied part of first message was dropped
>>>> and thus not copied as part of second message.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>> tools/testing/vsock/vsock_test.c | 121 +++++++++++++++++++++++++++++++
>>>> 1 file changed, 121 insertions(+)
>>>>
>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vs=
ock_test.c
>>>> index aa2de27d0f77..686af712b4ad 100644
>>>> --- a/tools/testing/vsock/vsock_test.c
>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>> @@ -16,6 +16,7 @@
>>>> #include <linux/kernel.h>
>>>> #include <sys/types.h>
>>>> #include <sys/socket.h>
>>>> +#include <sys/mman.h>
>>>>
>>>> #include "timeout.h"
>>>> #include "control.h"
>>>> @@ -435,6 +436,121 @@ static void test_seqpacket_timeout_server(const =
struct test_opts *opts)
>>>> =A0=A0=A0=A0close(fd);
>>>> }
>>>>
>>>> +#define BUF_PATTERN_1 'a'
>>>> +#define BUF_PATTERN_2 'b'
>>>> +
>>>> +static void test_seqpacket_invalid_rec_buffer_client(const struct tes=
t_opts *opts)
>>>> +{
>>>> +=A0=A0=A0 int fd;
>>>> +=A0=A0=A0 unsigned char *buf1;
>>>> +=A0=A0=A0 unsigned char *buf2;
>>>> +=A0=A0=A0 int buf_size =3D getpagesize() * 3;
>>>> +
>>>> +=A0=A0=A0 fd =3D vsock_seqpacket_connect(opts->peer_cid, 1234);
>>>> +=A0=A0=A0 if (fd < 0) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("connect");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 buf1 =3D malloc(buf_size);
>>>> +=A0=A0=A0 if (buf1 =3D=3D NULL) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("'malloc()' for 'buf1'");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 buf2 =3D malloc(buf_size);
>>>> +=A0=A0=A0 if (buf2 =3D=3D NULL) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("'malloc()' for 'buf2'");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 memset(buf1, BUF_PATTERN_1, buf_size);
>>>> +=A0=A0=A0 memset(buf2, BUF_PATTERN_2, buf_size);
>>>> +
>>>> +=A0=A0=A0 if (send(fd, buf1, buf_size, 0) !=3D buf_size) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("send failed");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 if (send(fd, buf2, buf_size, 0) !=3D buf_size) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("send failed");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 close(fd);
>>>> +}
>>>> +
>>>> +static void test_seqpacket_invalid_rec_buffer_server(const struct tes=
t_opts *opts)
>>>> +{
>>>> +=A0=A0=A0 int fd;
>>>> +=A0=A0=A0 unsigned char *broken_buf;
>>>> +=A0=A0=A0 unsigned char *valid_buf;
>>>> +=A0=A0=A0 int page_size =3D getpagesize();
>>>> +=A0=A0=A0 int buf_size =3D page_size * 3;
>>>> +=A0=A0=A0 ssize_t res;
>>>> +=A0=A0=A0 int prot =3D PROT_READ | PROT_WRITE;
>>>> +=A0=A0=A0 int flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
>>>> +=A0=A0=A0 int i;
>>>> +
>>>> +=A0=A0=A0 fd =3D vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>>>> +=A0=A0=A0 if (fd < 0) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("accept");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 /* Setup first buffer. */
>>>> +=A0=A0=A0 broken_buf =3D mmap(NULL, buf_size, prot, flags, -1, 0);
>>>> +=A0=A0=A0 if (broken_buf =3D=3D MAP_FAILED) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("mmap for 'broken_buf'");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 /* Unmap "hole" in buffer. */
>>>> +=A0=A0=A0 if (munmap(broken_buf + page_size, page_size)) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("'broken_buf' setup");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 valid_buf =3D mmap(NULL, buf_size, prot, flags, -1, 0);
>>>> +=A0=A0=A0 if (valid_buf =3D=3D MAP_FAILED) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("mmap for 'valid_buf'");
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 /* Try to fill buffer with unmapped middle. */
>>>> +=A0=A0=A0 res =3D read(fd, broken_buf, buf_size);
>>>> +=A0=A0=A0 if (res !=3D -1) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("invalid read result of 'broken_buf'");
>>>
>>> if `res` is valid, errno is not set, better to use fprintf(stderr, ...)=
 printing the expected and received result.
>>> Take a look at test_stream_connection_reset()
>>
>> Ack, fix it in v2
>>
>>>
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 if (errno !=3D ENOMEM) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("invalid errno of 'broken_buf'");
>>>
>>> Instead of "invalid", I would say "unexpected".
>>
>> Ack
>>
>>>
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>
>>>
>>>> +
>>>> +=A0=A0=A0 /* Try to fill valid buffer. */
>>>> +=A0=A0=A0 res =3D read(fd, valid_buf, buf_size);
>>>> +=A0=A0=A0 if (res !=3D buf_size) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 perror("invalid read result of 'valid_buf'");
>>>
>>> I would split in 2 checks:
>>> - (res < 0) then use perror()
>>> - (res !=3D buf_size) then use fprintf(stderr, ...) printing the expect=
ed =A0 and received result.
>>
>> Ack
>>
>>>
>>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 for (i =3D 0; i < buf_size; i++) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 if (valid_buf[i] !=3D BUF_PATTERN_2) {
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 perror("invalid pattern for valid b=
uf");
>>>
>>> errno is not set here, better to use fprintf(stderr, ...)
>>
>> Ack
>>
>>>
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>>> +=A0=A0=A0 }
>>>
>>> What about replace this for with a memcmp()?
>
>memcmp() will require special buffer with BUF_PATTERN_2 data as
>second argument. I think 'if()' condition is better here, as we
>compare each element of buffer with single byte. Anyway, 'memcmp()'
>does the same things inside itself.

Ah, I see. Okay, I agree on for()/if(), maybe we can also print more =

info (index, expected value, current value).

>
>>
>> Ack
>>
>>>
>>>> +
>>>> +
>>>> +=A0=A0=A0 /* Unmap buffers. */
>>>> +=A0=A0=A0 munmap(broken_buf, page_size);
>>>> +=A0=A0=A0 munmap(broken_buf + page_size * 2, page_size);
>>>> +=A0=A0=A0 munmap(valid_buf, buf_size);
>>>> +=A0=A0=A0 close(fd);
>>>> +}
>>>> +
>>>> static struct test_case test_cases[] =3D {
>>>> =A0=A0=A0=A0{
>>>> =A0=A0=A0=A0=A0=A0=A0 .name =3D "SOCK_STREAM connection reset",
>>>> @@ -480,6 +596,11 @@ static struct test_case test_cases[] =3D {
>>>> =A0=A0=A0=A0=A0=A0=A0 .run_client =3D test_seqpacket_timeout_client,
>>>> =A0=A0=A0=A0=A0=A0=A0 .run_server =3D test_seqpacket_timeout_server,
>>>> =A0=A0=A0=A0},
>>>> +=A0=A0=A0 {
>>>> +=A0=A0=A0=A0=A0=A0=A0 .name =3D "SOCK_SEQPACKET invalid receive buffe=
r",
>>>> +=A0=A0=A0=A0=A0=A0=A0 .run_client =3D test_seqpacket_invalid_rec_buff=
er_client,
>>>> +=A0=A0=A0=A0=A0=A0=A0 .run_server =3D test_seqpacket_invalid_rec_buff=
er_server,
>>>> +=A0=A0=A0 },
>>>
>>>
>>> Is this the right behavior? If read() fails because the buffer is inval=
id, do we throw out the whole packet?
>>>
>>> I was expecting the packet not to be consumed, have you tried AF_UNIX, =
does it have the same behavior?
>>
>> I've just checked AF_UNIX implementation of SEQPACKET receive in net/uni=
x/af_unix.c. So, if 'skb_copy_datagram_msg()'
>> fails, it calls 'skb_free_datagram()'. I think this means that whole sk =
buff will be dropped, but anyway, i'll check
>> this behaviour in practice. See '__unix_dgram_recvmsg()' in net/unix/af_=
unix.c.
>
>So i've checked that assumption for SEQPACKET + AF_UNIX: when user passes =
broken buffer to
>the kernel(for example with unmapped page in the mid), rest of message wil=
l be dropped. Next
>read will never get tail of the dropped message.

Thanks for checking, so it seems the same behaviour.
Let's go ahead with this test :-)

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
