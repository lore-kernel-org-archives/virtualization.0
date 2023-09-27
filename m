Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A220E80AA1
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 07:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C90341F1E;
	Wed, 27 Sep 2023 07:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C90341F1E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bOP9XgI+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4_-NFzAYgy9U; Wed, 27 Sep 2023 07:37:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 222F64191A;
	Wed, 27 Sep 2023 07:37:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 222F64191A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E57FFC0071;
	Wed, 27 Sep 2023 07:37:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C5D4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3AAE94013F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:37:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AAE94013F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bOP9XgI+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7V8u__WZ3E2g
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:37:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D901440128
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:37:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D901440128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695800273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzmdkgJVacl611f+REy0nRFcZdf1f4FGc4mWf9kNvKg=;
 b=bOP9XgI+m2HXexDHDrJTYYvdPMv1rVsNTTKhX7yYlx7Kg2xORj6wZFR72csW+khcgkmhRQ
 z0VgKBrm+Kb6vo0hX72rDoUoPFyL+FN1siKDsU1lvFznELZgRddhunHZmla2elWqp47WC4
 iRulFBdPpQSJXWEM2xC1LbOLSS+bLro=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-hkWgxlgcO7SHMhyic344Mw-1; Wed, 27 Sep 2023 03:37:51 -0400
X-MC-Unique: hkWgxlgcO7SHMhyic344Mw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so98163805e9.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 00:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695800270; x=1696405070;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tzmdkgJVacl611f+REy0nRFcZdf1f4FGc4mWf9kNvKg=;
 b=W1MhLAnqvSzPU+ud9PPFQKgig1qLJnYdowNw9s0to1mvmjHHEtNFeKyMxtwNAcXx9F
 3CtsRpg0nTkY10R+wra5xtrvDVMmmWXJrv7qKBkxLBu+P1PGkjoSK1/whnwP2ut+m6pz
 jYxV1dhAHforzg5mpZJahKXQeNA7ESn4r1ChpScRlQULQxaAXpx9AwBHkosi9ZWRqD3k
 EMhnlLCm1wAw2U3l93pwpGzZ4QFN0Ij3WSl0EOZ6AFLOGiITEFoZLsHdi15gTmFgP1N3
 aGUZDGS6fNOk7aoSKLNrlg8YqyXMYlVuTQILA/4aZbP7VTUvgPBQIe/CVWSmdYt+7r1K
 eUAA==
X-Gm-Message-State: AOJu0YzOpxptz/eDPMt5kooHoyGTdT8ji5EsLrHKXgPdoFfghk3tROgZ
 3MPl1IAzqWnKMJdZb6nw8EYOXNG43va3tysiTeQeqkW6sohEWdE6gxp3YnkYJmw8st+D/mvEQUG
 2JIGQxgBflq4T9i4otZdcGar+k7ZKURoZh4Rl72aK4A==
X-Received: by 2002:a05:600c:214:b0:401:bcb4:f133 with SMTP id
 20-20020a05600c021400b00401bcb4f133mr1317734wmi.22.1695800270778; 
 Wed, 27 Sep 2023 00:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6GTWPyjdRalcEyKRa4+1Afbjfckld/pyknV9vE0PjXAKdAdSloWwE+dhutPySlcYVRFQJ4w==
X-Received: by 2002:a05:600c:214:b0:401:bcb4:f133 with SMTP id
 20-20020a05600c021400b00401bcb4f133mr1317712wmi.22.1695800270393; 
 Wed, 27 Sep 2023 00:37:50 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.19.70])
 by smtp.gmail.com with ESMTPSA id
 e9-20020adfe7c9000000b003197efd1e7bsm2530401wrn.114.2023.09.27.00.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 00:37:49 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:37:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 12/12] test/vsock: io_uring rx/tx tests
Message-ID: <46h5yyg62ize2woqu6rp5ebffuhrivo4y7fw3iknicozcaxiz5@ojfvm6qeqzam>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-13-avkrasnov@salutedevices.com>
 <kfuzqzhrgdk5f5arbq4n3vd6vro6533aeysqhdgqevcqxrdm6e@57ylpkc2t4q4>
 <708be048-862f-76ee-6671-16b54e72e5a8@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <708be048-862f-76ee-6671-16b54e72e5a8@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
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

On Tue, Sep 26, 2023 at 11:00:19PM +0300, Arseniy Krasnov wrote:
>
>
>On 26.09.2023 16:04, Stefano Garzarella wrote:
>> On Fri, Sep 22, 2023 at 08:24:28AM +0300, Arseniy Krasnov wrote:
>>> This adds set of tests which use io_uring for rx/tx. This test suite is
>>> implemented as separated util like 'vsock_test' and has the same set of
>>> input arguments as 'vsock_test'. These tests only cover cases of data
>>> transmission (no connect/bind/accept etc).
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> Changelog:
>>> v5(big patchset) -> v1:
>>> =A0* Use LDLIBS instead of LDFLAGS.
>>>
>>> tools/testing/vsock/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 +-
>>> tools/testing/vsock/vsock_uring_test.c | 321 +++++++++++++++++++++++++
>>> 2 files changed, 327 insertions(+), 1 deletion(-)
>>> create mode 100644 tools/testing/vsock/vsock_uring_test.c
>>>
>>> diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>>> index 1a26f60a596c..c84380bfc18d 100644
>>> --- a/tools/testing/vsock/Makefile
>>> +++ b/tools/testing/vsock/Makefile
>>> @@ -1,12 +1,17 @@
>>> # SPDX-License-Identifier: GPL-2.0-only
>>> +ifeq ($(MAKECMDGOALS),vsock_uring_test)
>>> +LDLIBS =3D -luring
>>> +endif
>>> +
>>
>> This will fails if for example we call make with more targets,
>> e.g. `make vsock_test vsock_uring_test`.
>>
>> I'd suggest to use something like this:
>>
>> --- a/tools/testing/vsock/Makefile
>> +++ b/tools/testing/vsock/Makefile
>> @@ -1,13 +1,11 @@
>> =A0# SPDX-License-Identifier: GPL-2.0-only
>> -ifeq ($(MAKECMDGOALS),vsock_uring_test)
>> -LDLIBS =3D -luring
>> -endif
>> -
>> =A0all: test vsock_perf
>> =A0test: vsock_test vsock_diag_test
>> =A0vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o ut=
il.o
>> =A0vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>> =A0vsock_perf: vsock_perf.o
>> +
>> +vsock_uring_test: LDLIBS =3D -luring
>> =A0vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>>
>> =A0CFLAGS +=3D -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/i=
nclude -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-com=
mon -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
>>
>>> all: test vsock_perf
>>> test: vsock_test vsock_diag_test
>>> vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util=
.o
>>> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>>> vsock_perf: vsock_perf.o
>>> +vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>>
>> Shoud we add this new test to the "test" target as well?
>
>Ok, but in this case, this target will always depend on liburing.

I think it's fine.

If they want to run all the tests, they need liburing. If they don't
want to build io_uring tests, they can just do `make vsock_test`.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
