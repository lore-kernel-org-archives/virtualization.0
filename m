Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB62C3A59F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 15:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1824409D3;
	Wed, 23 Nov 2022 15:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1824409D3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb4rp/Lg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oV3Q7rbeaItA; Wed, 23 Nov 2022 15:24:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 21F3A4032E;
	Wed, 23 Nov 2022 15:24:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21F3A4032E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEDECC0032;
	Wed, 23 Nov 2022 15:24:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F510C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 566F981EAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 566F981EAD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb4rp/Lg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjTEQL9jj1kb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:24:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48CBD81E66
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48CBD81E66
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669217086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JIKrf57nj1kWRXglPfPJ258p/fyMgl7dlr5TafbPCE=;
 b=Jb4rp/LgO7a7k5hkz0uv4DXBOMoEJzUu3IiG73WPBwvx0LYTSMZpe6Q5bEYxQ7y6cn21vc
 i40t7Y9QFCveT0v4A+opSInCxf+hB9eJx4JFfVfAvwmv0TG8oeDmDhrvUwUAmRVxts/JMx
 GXqCpFEzmgKWunYNasFnPNSeX//gn6E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-WBfJY0UCM0G6THkBE22owA-1; Wed, 23 Nov 2022 10:24:44 -0500
X-MC-Unique: WBfJY0UCM0G6THkBE22owA-1
Received: by mail-qv1-f72.google.com with SMTP id
 mf16-20020a0562145d9000b004c6d76c9efbso422604qvb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 07:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JIKrf57nj1kWRXglPfPJ258p/fyMgl7dlr5TafbPCE=;
 b=7QoJJbuLWEr7PaI6Ni5aG3KQvp1pPL+QazBmh+BQJ9Ply2Yqz1z5TTX5mKb/gN25ee
 H4+GXRlOv/MYiNa6iSAIXYNXljIpM+jaUTE0fv6UEO9WxI860rUze7+U9RnReyesNN6H
 QiwF59nfkz5dMDdLF8KUjgwRVI7ucoQRUYLuySB0RK/HhnHMylCjkJeSeAG0i/IycmDF
 3989n2FY+gUqdi+SCVLExGoh1KEwbHvj2S4k0RSKEZFlk00oJQgHxp8enQyWga8m3w7Z
 Jq+4BwOt82IaleqXhIH5l+uIZZkPZsKv7hRomTMRoKunFF3lHleFAp3K9wbGhdWkWg4b
 MvLg==
X-Gm-Message-State: ANoB5pm3Rg6AVDQ+/wTDD15DUq654FXbiLzGY2iQ1zJ71TTEu1PmHNfG
 1glWD9zeCwyrzSke0IJFz6G6jNZtbdqJD+TzRSJfCxkbupd8TzaRnT32DEfMToefEbU2fh7G4Cz
 hqhUeVLwgyZmTX4ZeGRkJTTdeuWqUZ0y33ROLHoeyPA==
X-Received: by 2002:a05:620a:1527:b0:6ec:ff06:8307 with SMTP id
 n7-20020a05620a152700b006ecff068307mr10509915qkk.683.1669217084252; 
 Wed, 23 Nov 2022 07:24:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf71bOLl6p3QloT2gsNe/gsl/rWhKoQzcq0yCqIGJJaDaiJrvVCJtiQp8VwqkDgswaMsII218Q==
X-Received: by 2002:a05:620a:1527:b0:6ec:ff06:8307 with SMTP id
 n7-20020a05620a152700b006ecff068307mr10509885qkk.683.1669217083898; 
 Wed, 23 Nov 2022 07:24:43 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 i5-20020a05622a08c500b003431446588fsm10141112qte.5.2022.11.23.07.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Nov 2022 07:24:43 -0800 (PST)
Date: Wed, 23 Nov 2022 16:24:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/3] test/vsock: rework message bound test
Message-ID: <20221123152437.gat3feinipkdsi3v@sgarzare-redhat>
References: <ba294dff-812a-bfc2-a43c-286f99aee0b8@sberdevices.ru>
 <c991dffd-1dbc-e1d1-b682-a3c71f6ce51c@sberdevices.ru>
 <20221121144602.gnrzlaatrnasaard@sgarzare-redhat>
 <e86656c2-079b-5223-cc69-d651cb846e24@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <e86656c2-079b-5223-cc69-d651cb846e24@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>
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

On Mon, Nov 21, 2022 at 04:49:23PM +0000, Arseniy Krasnov wrote:
>On 21.11.2022 17:46, Stefano Garzarella wrote:
>> On Tue, Nov 15, 2022 at 08:50:36PM +0000, Arseniy Krasnov wrote:
>>> This updates message bound test making it more complex. Instead of
>>> sending 1 bytes messages with one MSG_EOR bit, it sends messages of
>>> random length(one half of messages are smaller than page size, second
>>> half are bigger) with random number of MSG_EOR bits set. Receiver
>>> also don't know total number of messages.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> tools/testing/vsock/control.c=A0=A0=A0 |=A0 34 +++++++++
>>> tools/testing/vsock/control.h=A0=A0=A0 |=A0=A0 2 +
>>> tools/testing/vsock/util.c=A0=A0=A0=A0=A0=A0 |=A0 13 ++++
>>> tools/testing/vsock/util.h=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>>> tools/testing/vsock/vsock_test.c | 115 +++++++++++++++++++++++++++----
>>> 5 files changed, 152 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/contro=
l.c
>>> index 4874872fc5a3..bed1649bdf3d 100644
>>> --- a/tools/testing/vsock/control.c
>>> +++ b/tools/testing/vsock/control.c
>>> @@ -141,6 +141,40 @@ void control_writeln(const char *str)
>>> =A0=A0=A0=A0timeout_end();
>>> }
>>>
>>> +void control_writeulong(unsigned long value)
>>> +{
>>> +=A0=A0=A0 char str[32];
>>> +
>>> +=A0=A0=A0 if (snprintf(str, sizeof(str), "%lu", value) >=3D sizeof(str=
)) {
>>> +=A0=A0=A0=A0=A0=A0=A0 perror("snprintf");
>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 control_writeln(str);
>>> +}
>>> +
>>> +unsigned long control_readulong(bool *ok)
>>> +{
>>> +=A0=A0=A0 unsigned long value;
>>> +=A0=A0=A0 char *str;
>>> +
>>> +=A0=A0=A0 if (ok)
>>> +=A0=A0=A0=A0=A0=A0=A0 *ok =3D false;
>>> +
>>> +=A0=A0=A0 str =3D control_readln();
>>> +
>>> +=A0=A0=A0 if (str =3D=3D NULL)
>>
>> checkpatch suggests to use !str
>>
>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>
>> Maybe we can just call exit(EXIT_FAILURE) here and remove the `ok`
>> parameter, since I'm not sure we can recover from this error.
>>
>>> +
>>> +=A0=A0=A0 value =3D strtoul(str, NULL, 10);
>>> +=A0=A0=A0 free(str);
>>> +
>>> +=A0=A0=A0 if (ok)
>>> +=A0=A0=A0=A0=A0=A0=A0 *ok =3D true;
>>> +
>>> +=A0=A0=A0 return value;
>>> +}
>>> +
>>> /* Return the next line from the control socket (without the trailing n=
ewline).
>>> =A0*
>>> =A0* The program terminates if a timeout occurs.
>>> diff --git a/tools/testing/vsock/control.h b/tools/testing/vsock/contro=
l.h
>>> index 51814b4f9ac1..cdd922dfea68 100644
>>> --- a/tools/testing/vsock/control.h
>>> +++ b/tools/testing/vsock/control.h
>>> @@ -9,7 +9,9 @@ void control_init(const char *control_host, const char =
*control_port,
>>> void control_cleanup(void);
>>> void control_writeln(const char *str);
>>> char *control_readln(void);
>>> +unsigned long control_readulong(bool *ok);
>>> void control_expectln(const char *str);
>>> bool control_cmpln(char *line, const char *str, bool fail);
>>> +void control_writeulong(unsigned long value);
>>>
>>> #endif /* CONTROL_H */
>>> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>> index 2acbb7703c6a..351903836774 100644
>>> --- a/tools/testing/vsock/util.c
>>> +++ b/tools/testing/vsock/util.c
>>> @@ -395,3 +395,16 @@ void skip_test(struct test_case *test_cases, size_=
t test_cases_len,
>>>
>>> =A0=A0=A0=A0test_cases[test_id].skip =3D true;
>>> }
>>> +
>>> +unsigned long djb2(const void *data, size_t len)
>>
>> I would add hash_ as a prefix (or suffix).
>>
>>> +{
>>> +=A0=A0=A0 unsigned long hash =3D 5381;
>>> +=A0=A0=A0 int i =3D 0;
>>> +
>>> +=A0=A0=A0 while (i < len) {
>>> +=A0=A0=A0=A0=A0=A0=A0 hash =3D ((hash << 5) + hash) + ((unsigned char =
*)data)[i];
>>> +=A0=A0=A0=A0=A0=A0=A0 i++;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 return hash;
>>> +}
>>> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>>> index a3375ad2fb7f..988cc69a4642 100644
>>> --- a/tools/testing/vsock/util.h
>>> +++ b/tools/testing/vsock/util.h
>>> @@ -49,4 +49,5 @@ void run_tests(const struct test_case *test_cases,
>>> void list_tests(const struct test_case *test_cases);
>>> void skip_test(struct test_case *test_cases, size_t test_cases_len,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const char *test_id_str);
>>> +unsigned long djb2(const void *data, size_t len);
>>> #endif /* UTIL_H */
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vso=
ck_test.c
>>> index bb6d691cb30d..107c11165887 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -284,10 +284,14 @@ static void test_stream_msg_peek_server(const str=
uct test_opts *opts)
>>> =A0=A0=A0=A0close(fd);
>>> }
>>>
>>> -#define MESSAGES_CNT 7
>>> -#define MSG_EOR_IDX (MESSAGES_CNT / 2)
>>> +#define SOCK_BUF_SIZE (2 * 1024 * 1024)
>>> +#define MAX_MSG_SIZE (32 * 1024)
>>> +
>>> static void test_seqpacket_msg_bounds_client(const struct test_opts *op=
ts)
>>> {
>>> +=A0=A0=A0 unsigned long curr_hash;
>>> +=A0=A0=A0 int page_size;
>>> +=A0=A0=A0 int msg_count;
>>> =A0=A0=A0=A0int fd;
>>>
>>> =A0=A0=A0=A0fd =3D vsock_seqpacket_connect(opts->peer_cid, 1234);
>>> @@ -296,18 +300,69 @@ static void test_seqpacket_msg_bounds_client(cons=
t struct test_opts *opts)
>>> =A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> =A0=A0=A0=A0}
>>>
>>> -=A0=A0=A0 /* Send several messages, one with MSG_EOR flag */
>>> -=A0=A0=A0 for (int i =3D 0; i < MESSAGES_CNT; i++)
>>> -=A0=A0=A0=A0=A0=A0=A0 send_byte(fd, 1, (i =3D=3D MSG_EOR_IDX) ? MSG_EO=
R : 0);
>>> +=A0=A0=A0 /* Wait, until receiver sets buffer size. */
>>> +=A0=A0=A0 control_expectln("SRVREADY");
>>> +
>>> +=A0=A0=A0 curr_hash =3D 0;
>>> +=A0=A0=A0 page_size =3D getpagesize();
>>> +=A0=A0=A0 msg_count =3D SOCK_BUF_SIZE / MAX_MSG_SIZE;
>>> +
>>> +=A0=A0=A0 for (int i =3D 0; i < msg_count; i++) {
>>> +=A0=A0=A0=A0=A0=A0=A0 ssize_t send_size;
>>> +=A0=A0=A0=A0=A0=A0=A0 size_t buf_size;
>>> +=A0=A0=A0=A0=A0=A0=A0 int flags;
>>> +=A0=A0=A0=A0=A0=A0=A0 void *buf;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 /* Use "small" buffers and "big" buffers. */
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i & 1)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buf_size =3D page_size +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (rand() % (M=
AX_MSG_SIZE - page_size));
>>> +=A0=A0=A0=A0=A0=A0=A0 else
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buf_size =3D 1 + (rand() % page_size=
);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 buf =3D malloc(buf_size);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (!buf) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 perror("malloc");
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 /* Set at least one MSG_EOR + some random. */
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i =3D=3D (msg_count / 2) || (rand() & 1)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flags =3D MSG_EOR;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 curr_hash++;
>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flags =3D 0;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 send_size =3D send(fd, buf, buf_size, flags);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (send_size < 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 perror("send");
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (send_size !=3D buf_size) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "Invalid send size\n=
");
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 curr_hash +=3D send_size;
>>> +=A0=A0=A0=A0=A0=A0=A0 curr_hash =3D djb2(&curr_hash, sizeof(curr_hash)=
);
>>> +=A0=A0=A0 }
>>>
>>> =A0=A0=A0=A0control_writeln("SENDDONE");
>>> +=A0=A0=A0 control_writeulong(curr_hash);
>>
>> Why do we need to hash the size?
>>
>> Maybe we can send it without making the hash, anyway even if it wraps,
>> it should wrap the same way in both the server and the client.
>> (Or maybe we can use uin32_t or uint64_t to make sure both were
>> using 4 or 8 bytes)
>Hello, thanks for review. I think if we will use sum of message size(IIUC)=
, in most
>paranoic case it won't guarantee message bounds control: single 4 bytes me=
ssage
>could be read as 4 x 1 byte message(IIUC of course). Idea of hashing is si=
mple:
>every iteration we do current_hash =3D hash(previous_hash + size of curren=
t message);
>I think this is more reliable and protects from case described above.

Okay, now I understand what it is for and agree that using hash is =

better.
Please add a comment to explain it.

>
>All other comments - ack.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
