Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358B0C43334
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 08:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE242827CA;
	Wed, 20 Jul 2022 08:57:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE242827CA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYcbF9eC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLZPcccXz_dv; Wed, 20 Jul 2022 08:57:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5061B827D2;
	Wed, 20 Jul 2022 08:57:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5061B827D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC47C0033;
	Wed, 20 Jul 2022 08:57:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD24FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 898EA419A0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 898EA419A0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYcbF9eC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVpFxnkgDVB6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:57:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 245334199E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 245334199E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658307418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PlCq6ajL/Z4I1TluumiywIvpa4NQvyOba7zhGyb68U=;
 b=hYcbF9eC1KySREeAYv5+KwO0yUAtYAtjv/y5p0zVU5DB0QQ5UW017ge+LLdFwYNYbA8+gH
 qYrsqFc0I9JUfREFncgK5NVk61llq8v8Sso568ZMgiPAdWvm82pBiuqJMPRgx44Ax72l/i
 Zr2K0AFo4jt/HoSvFhRds2HthTL7hlY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-3lC4yLPNOFO3hWkjB3JHCg-1; Wed, 20 Jul 2022 04:56:57 -0400
X-MC-Unique: 3lC4yLPNOFO3hWkjB3JHCg-1
Received: by mail-qt1-f199.google.com with SMTP id
 q21-20020ac84115000000b0031bf60d9b35so11696599qtl.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 01:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0PlCq6ajL/Z4I1TluumiywIvpa4NQvyOba7zhGyb68U=;
 b=7XyFb3IGIH9Y9PCMuY6sSqlF4y82znbekZwOKkpjd8wr+aD4eeqvJykE1GOsA+77iS
 jVPGqXOkk2dq5PiZ7SEJGFW7I+sbpiDJSLNTG4JTvi9yNCrcWwDOTummW3wmhC8psfgG
 +sGF4NGxheuiLW+Mq10flBeOa/f61ndPgssykhNPYEv2lMBDIhHWXws0o5XN6HMCUOeA
 gmk5RmRWS/wOLsq0QAZ9ANm1mRsMUOQMNPbOPoh18K0zBeUephyXA6e9sjiUTBvktPkv
 agrDS56hxe82lpa0l7PR4+pkNS3yYkpvua393bdxOPJ7bgERqv1suesgqPU3S5yPgyPq
 gd8A==
X-Gm-Message-State: AJIora8vEgIrSpniC8tgX9opzQPTQIFj7k9bHKx5h9jmjySgpEcuDhph
 hm1fH8u6114Ih6267Oi0b66nPgWZ4sWwE83DMLNeRguU9HzD1+ieN2/P3xnUnqz8/j38/SaCAhF
 l6INO7wDpnJdSX1vN/lAjSqxZqW/1Ts35ZNgcfkYP3Q==
X-Received: by 2002:a0c:8c89:0:b0:470:9ab6:bb27 with SMTP id
 p9-20020a0c8c89000000b004709ab6bb27mr28764643qvb.118.1658307417211; 
 Wed, 20 Jul 2022 01:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uUEd8wd9tFBWjZIynLvqe+YW58v3ThG/Igh7FbI5iMXJ4uDVuxP2SQYrdm0ppCHCoqmP9x8A==
X-Received: by 2002:a0c:8c89:0:b0:470:9ab6:bb27 with SMTP id
 p9-20020a0c8c89000000b004709ab6bb27mr28764632qvb.118.1658307416999; 
 Wed, 20 Jul 2022 01:56:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 bn10-20020a05622a1dca00b0031ece6e0f17sm3229189qtb.71.2022.07.20.01.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jul 2022 01:56:56 -0700 (PDT)
Date: Wed, 20 Jul 2022 10:56:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] vsock_test: POLLIN + SO_RCVLOWAT test.
Message-ID: <20220720085649.6pqj55hmkxlamxjq@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <df70a274-4e69-ca1f-acba-126eb517e532@sberdevices.ru>
 <20220719125227.bktosg3yboeaeoo5@sgarzare-redhat>
 <ea414c31-741f-6994-651a-a686cba3d25e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <ea414c31-741f-6994-651a-a686cba3d25e@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
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

On Wed, Jul 20, 2022 at 05:46:01AM +0000, Arseniy Krasnov wrote:
>On 19.07.2022 15:52, Stefano Garzarella wrote:
>> On Mon, Jul 18, 2022 at 08:19:06AM +0000, Arseniy Krasnov wrote:
>>> This adds test to check, that when poll() returns POLLIN and
>>> POLLRDNORM bits, next read call won't block.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> tools/testing/vsock/vsock_test.c | 90 ++++++++++++++++++++++++++++++++
>>> 1 file changed, 90 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vso=
ck_test.c
>>> index dc577461afc2..8e394443eaf6 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -18,6 +18,7 @@
>>> #include <sys/socket.h>
>>> #include <time.h>
>>> #include <sys/mman.h>
>>> +#include <poll.h>
>>>
>>> #include "timeout.h"
>>> #include "control.h"
>>> @@ -596,6 +597,90 @@ static void test_seqpacket_invalid_rec_buffer_serv=
er(const struct test_opts *opt
>>> =A0=A0=A0=A0close(fd);
>>> }
>>>
>>> +static void test_stream_poll_rcvlowat_server(const struct test_opts *o=
pts)
>>> +{
>>> +#define RCVLOWAT_BUF_SIZE 128
>>> +=A0=A0=A0 int fd;
>>> +=A0=A0=A0 int i;
>>> +
>>> +=A0=A0=A0 fd =3D vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>>> +=A0=A0=A0 if (fd < 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0 perror("accept");
>>> +=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 /* Send 1 byte. */
>>> +=A0=A0=A0 send_byte(fd, 1, 0);
>>> +
>>> +=A0=A0=A0 control_writeln("SRVSENT");
>>> +
>>> +=A0=A0=A0 /* Just empirically delay value. */
>>> +=A0=A0=A0 sleep(4);
>>
>> Why we need this sleep()?
>Purpose of sleep() is to move client in state, when it has 1 byte of rx da=
ta
>and poll() won't wake. For example:
>client:                        server:
>waits for "SRVSENT"
>                               send 1 byte
>                               send "SRVSENT"
>poll()
>                               sleep
>...
>poll sleeps
>...
>                               send rest of data
>poll wake up
>
>I think, without sleep there is chance, that client enters poll() when who=
le
>data from server is already received, thus test will be useless(it just te=
sts

Right, I see (maybe add a comment in the test).

>poll()). May be i can remove "SRVSENT" as sleep is enough.

I think it's fine.

An alternative could be to use the `timeout` of poll():

client:                        server:
waits for "SRVSENT"
                                send 1 byte
                                send "SRVSENT"
poll(, timeout =3D 1 * 1000)
                                wait for "CLNSENT"
poll should return 0
send "CLNSENT"

poll(, timeout =3D 10 * 1000)
...
poll sleeps
...
                                send rest of data
poll wake up


I don't have a strong opinion, also your version seems fine, just an =

alternative ;-)

Maybe in your version you can add a 10 sec timeout to poll, to avoid =

that the test stuck for some reason (failing if the timeout is reached).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
