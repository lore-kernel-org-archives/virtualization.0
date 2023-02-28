Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A186DC64ED6
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 10:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 31B2F40B69;
	Tue, 28 Feb 2023 10:34:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31B2F40B69
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aaf2FZY/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DFzQ9w70llQL; Tue, 28 Feb 2023 10:34:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A594040B1D;
	Tue, 28 Feb 2023 10:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A594040B1D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 874F5C0032;
	Tue, 28 Feb 2023 10:34:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEF01C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3B4181DA3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:34:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3B4181DA3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aaf2FZY/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ypvMXzkCYgz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:34:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF93B81A95
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF93B81A95
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677580440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWE/IH7Gk0DOgzMvd0Lmdxjp64jnYWrJuTM5923X0kE=;
 b=Aaf2FZY/SI7XovaVhGID1otoWGbTHNWNf/t/AimVlTkZ0F7Jqj+v5aluxBIUIR6dRS5TKO
 JnfavO3cmo+Q7+O8JeHaRJucbS1rx19Kb0aE3clezWyVlDaCH6Cgpqp94GbqkW9OJpLgxJ
 MFjXCGQSG3tfVo8z4cFqIQCnbSB1y64=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-2-ys86qDbVNnCwPEmcBwyQbQ-1; Tue, 28 Feb 2023 05:32:10 -0500
X-MC-Unique: ys86qDbVNnCwPEmcBwyQbQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 c30-20020adfa31e000000b002c59b266371so1426980wrb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 02:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWE/IH7Gk0DOgzMvd0Lmdxjp64jnYWrJuTM5923X0kE=;
 b=ehtlM6FPPc7huE0nHB1aSpW+9jDzYD3+Igki1VARxEQGsPd1N4Ex3f39UuHmiiPkm6
 nRCNqjbDhQVucVQKvz3Uous883Pe/ZQVteBD9yebjp9A0VLFnik1BZrBzHVJ0bAU2FcA
 fipeECV/toqRu7DCmuJKsGbrAXEUvT1EQn5n9i3E+zHwileEt99xIj8gmldiAMuusluE
 x68WNGEdXijHRSQnYu4r797F72Mqa8Slihr4ZWfzEwOHuzySj8EZ+S9llUHeYGkOtAyV
 9eWkeJS5vBihlRrsbf1Wxbap5PoJf3Ahp0SWXSQzeNgTPfSIGTfqfGPG7146LALzHl8h
 I/7g==
X-Gm-Message-State: AO0yUKUettcGES7aOV0oRBX22P0q2CeQDMcOlMEerz99vSVbYQ/wHrNh
 QBO6Ck95TzVmJ4sioAPc/gVNngFvgANNNZYjOhTI3vA9prPMntDl9xZXD2OQlFo9RZnL2UGc/Ia
 bIpVVSGdROucvKQtG/wGrcet4C+3YGaHnleyjuOPPmA==
X-Received: by 2002:a5d:6f1b:0:b0:2bf:bf05:85ac with SMTP id
 ay27-20020a5d6f1b000000b002bfbf0585acmr1808252wrb.23.1677580329580; 
 Tue, 28 Feb 2023 02:32:09 -0800 (PST)
X-Google-Smtp-Source: AK7set9ZFVtpNUSDKjWbiaTH1BQVRiKxdUcmbd6hiGVcxOhG2xmXBJ61c13FJ8zRMszkvybFURNUgQ==
X-Received: by 2002:a5d:6f1b:0:b0:2bf:bf05:85ac with SMTP id
 ay27-20020a5d6f1b000000b002bfbf0585acmr1808234wrb.23.1677580329303; 
 Tue, 28 Feb 2023 02:32:09 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 k28-20020a5d525c000000b002c556a4f1casm9321915wrc.42.2023.02.28.02.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Feb 2023 02:32:08 -0800 (PST)
Date: Tue, 28 Feb 2023 11:32:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 12/12] test/vsock: MSG_ZEROCOPY support for
 vsock_perf
Message-ID: <20230228103205.6vorc4z363wtxwlk@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <03570f48-f56a-2af4-9579-15a685127aeb@sberdevices.ru>
 <20230216152945.qdh6vrq66pl2bfxe@sgarzare-redhat>
 <d5de8b79-f903-d65f-a5bc-e591578144e7@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <d5de8b79-f903-d65f-a5bc-e591578144e7@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Feb 20, 2023 at 09:05:12AM +0000, Krasnov Arseniy wrote:
>On 16.02.2023 18:29, Stefano Garzarella wrote:
>> On Mon, Feb 06, 2023 at 07:06:32AM +0000, Arseniy Krasnov wrote:
>>> To use this option pass '--zc' parameter:
>>
>> --zerocopy or --zero-copy maybe better follow what we did with the other=
 parameters :-)
>>
>>>
>>> ./vsock_perf --zc --sender <cid> --port <port> --bytes <bytes to send>
>>>
>>> With this option MSG_ZEROCOPY flag will be passed to the 'send()' call.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> tools/testing/vsock/vsock_perf.c | 127 +++++++++++++++++++++++++++++--
>>> 1 file changed, 120 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vso=
ck_perf.c
>>> index a72520338f84..1d435be9b48e 100644
>>> --- a/tools/testing/vsock/vsock_perf.c
>>> +++ b/tools/testing/vsock/vsock_perf.c
>>> @@ -18,6 +18,8 @@
>>> #include <poll.h>
>>> #include <sys/socket.h>
>>> #include <linux/vm_sockets.h>
>>> +#include <sys/mman.h>
>>> +#include <linux/errqueue.h>
>>>
>>> #define DEFAULT_BUF_SIZE_BYTES=A0=A0=A0 (128 * 1024)
>>> #define DEFAULT_TO_SEND_BYTES=A0=A0=A0 (64 * 1024)
>>> @@ -28,9 +30,14 @@
>>> #define BYTES_PER_GB=A0=A0=A0=A0=A0=A0=A0 (1024 * 1024 * 1024ULL)
>>> #define NSEC_PER_SEC=A0=A0=A0=A0=A0=A0=A0 (1000000000ULL)
>>>
>>> +#ifndef SOL_VSOCK
>>> +#define SOL_VSOCK 287
>>> +#endif
>>
>> I thought we use the current kernel headers when we compile the tests,
>> do we need to fix something in the makefile?
>Not sure, of course we are using uapi. But i see, that defines like SOL_XX=
X is not
>defined in uapi headers. For example SOL_IP is defined in include/linux/so=
cket.h,
>but userspace app uses SOL_IP from in.h (at least on my machine). E.g. SOL=
_XXX is
>not exported to user.

Right, I see only few SOL_* in the uapi, e.g. SOL_TIPC in =

uapi/linux/tipc.h

So it's fine for now, otherwise we can define it in =

uapi/linux/vm_sockets.h

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
