Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8EBEEAA4E
	for <virtualization@archiver.kernel.org>; Thu, 14 Sep 2023 15:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24C6C401D5;
	Thu, 14 Sep 2023 15:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24C6C401D5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmC5uH5I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yBlGglR7oHW7; Thu, 14 Sep 2023 15:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5FE864004A;
	Thu, 14 Sep 2023 15:34:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FE864004A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36C41C0039;
	Thu, 14 Sep 2023 15:34:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE4CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 15:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EFD360FE3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 15:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EFD360FE3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmC5uH5I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S5eHO4Q4Bxn6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 15:34:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34F4E60FAD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 15:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34F4E60FAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694705667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=buiiu+tLXB8hg1uWGuKZq7mBUyxAEPJaVjE6lmvNhuc=;
 b=JmC5uH5IE19aaeO/yBZHpMWZaQ9UuAHoAdfpjUWygwv7Ir1uYOrmvFF5oeTuv+6DyJ269y
 fCfAZ5aaEfrK1CNG0p00UNfnvcFfG2e1y/mshmCl3BLCxCrFsz9N+oyAjFWJsdl+36fRhB
 XDLXzzsVHIb5uFJ8MlUWeas9Wl46bRw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-e-9MUVFzOwCaSvXlr8a43g-1; Thu, 14 Sep 2023 11:34:26 -0400
X-MC-Unique: e-9MUVFzOwCaSvXlr8a43g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31facb07f53so493595f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 08:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694705665; x=1695310465;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=buiiu+tLXB8hg1uWGuKZq7mBUyxAEPJaVjE6lmvNhuc=;
 b=C9OR4QL1nfNPEJYWY1+elRALTt3wqiGOGBTGo3VLxW8Vd80fkEl4NeRfkX5+IPN3T/
 +CuAHqBIc5fuE9AD7dEmTYj7T7FL5nbgVwR55P3XZ/rHOWcMEX+dXGj0300PLyIoEtR8
 6s7qapZIaEfPoxUpOgqvlpAmN1tAklLjsEC2lptLWs4I5IBogT8GZoM3pCW36CNC8/A8
 lnKJCgeWgwlxZHpjR9tWm5E7yZeUlF3KN6RdkTh8L1LY3G0eZMCmPRA11bz8CBftrCWB
 eKCgR22y+PTes4xO0pTUS442Y1ntrP+lvUW6y8zAkv7XtcS46VpEh5/CsBnUbPk6fy/b
 hDYA==
X-Gm-Message-State: AOJu0YzB6jSM8FFJ8CZIFP1DMcxEPbz4K6D4XEbtFmxfX/THfh9iF3qh
 urm3C68x6mzUho2mcrV/2N2ZC0FPwVDrc18485DxnrrsRTR9L6yR1edc8C5yslfY5No1PwMrRbc
 ZShVThFFQ1CdmXcmXcI367xQde+6QNkQmFiqFBKgfPQ==
X-Received: by 2002:a5d:5948:0:b0:31c:8c5f:877e with SMTP id
 e8-20020a5d5948000000b0031c8c5f877emr1882386wri.33.1694705665493; 
 Thu, 14 Sep 2023 08:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+nCbcXFaH/HOSF4+8+BhfwcplnBX+yHnh9Wu4fo/aPF7ErBAktIXQigHFHZ5NP8kmGbuZA==
X-Received: by 2002:a5d:5948:0:b0:31c:8c5f:877e with SMTP id
 e8-20020a5d5948000000b0031c8c5f877emr1882368wri.33.1694705665105; 
 Thu, 14 Sep 2023 08:34:25 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.114.183])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a7bc445000000b003fee849df23sm2283011wmi.22.2023.09.14.08.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:34:24 -0700 (PDT)
Date: Thu, 14 Sep 2023 17:34:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v8 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <63xflnwiohdfo6m3vnrrxgv2ulplencpwug5qqacugqh7xxpu3@tsczkuqgwurb>
References: <20230911202234.1932024-1-avkrasnov@salutedevices.com>
 <554ugdobcmxraek662xkxjdehcu5ri6awxvhvlvnygyru5zlsx@e7cyloz6so7u>
 <7bf35d28-893b-5bea-beb7-9a25bc2f0a0e@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <7bf35d28-893b-5bea-beb7-9a25bc2f0a0e@salutedevices.com>
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

On Thu, Sep 14, 2023 at 05:05:17PM +0300, Arseniy Krasnov wrote:
>Hello Stefano,
>
>On 14.09.2023 17:07, Stefano Garzarella wrote:
>> Hi Arseniy,
>>
>> On Mon, Sep 11, 2023 at 11:22:30PM +0300, Arseniy Krasnov wrote:
>>> Hello,
>>>
>>> this patchset is first of three parts of another big patchset for
>>> MSG_ZEROCOPY flag support:
>>> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberd=
evices.ru/
>>>
>>> During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>>> suggested to split it for three parts to simplify review and merging:
>>>
>>> 1) virtio and vhost updates (for fragged skbs) <--- this patchset
>>> 2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>>> =A0 tx completions) and update for Documentation/.
>>> 3) Updates for tests and utils.
>>>
>>> This series enables handling of fragged skbs in virtio and vhost parts.
>>> Newly logic won't be triggered, because SO_ZEROCOPY options is still
>>> impossible to enable at this moment (next bunch of patches from big
>>> set above will enable it).
>>>
>>> I've included changelog to some patches anyway, because there were some
>>> comments during review of last big patchset from the link above.
>>
>> Thanks, I left some comments on patch 4, the others LGTM.
>> Sorry to not having spotted them before, but moving
>> virtio_transport_alloc_skb() around the file, made the patch a little
>> confusing and difficult to review.
>
>Sure, no problem, I'll fix them! Thanks for review.
>
>>
>> In addition, I started having failures of test 14 (server: host,
>> client: guest), so I looked better to see if there was anything wrong,
>> but it fails me even without this series applied.
>>
>> It happens to me intermittently (~30%), does it happen to you?
>> Can you take a look at it?
>
>Yes! sometime ago I also started to get fails of this test, not ~30%,
>significantly rare, but it depends on environment I guess, anyway I'm goin=
g to
>look at this on the next few days

Maybe it's just a timing issue in the test, indeed we are expecting 8
bytes but we received only 3 plus the 2 bytes we received before it
seems exactly the same bytes we send with the first
`send(fd, HELLO_STR, strlen(HELLO_STR), 0);`

Since it is a stream socket, it could happen, so we should retry
the recv() or just use MSG_WAITALL.

Applying the following patch fixed the issue for me (15 mins without
errors for now):

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_t=
est.c
index 90718c2fd4ea..7b0fed9fc58d 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1129,7 +1129,7 @@ static void test_stream_virtio_skb_merge_server(const=
 struct test_opts *opts)
         control_expectln("SEND0");

         /* Read skbuff partially. */
-       res =3D recv(fd, buf, 2, 0);
+       res =3D recv(fd, buf, 2, MSG_WAITALL);
         if (res !=3D 2) {
                 fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi=
\n", res);
                 exit(EXIT_FAILURE);
@@ -1138,7 +1138,7 @@ static void test_stream_virtio_skb_merge_server(const=
 struct test_opts *opts)
         control_writeln("REPLY0");
         control_expectln("SEND1");

-       res =3D recv(fd, buf + 2, sizeof(buf) - 2, 0);
+       res =3D recv(fd, buf + 2, 8, MSG_WAITALL);
         if (res !=3D 8) {
                 fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi=
\n", res);
                 exit(EXIT_FAILURE);

I will check better all the cases and send a patch upstream.

Anyway it looks just an issue in our test suite :-)

Stefano

>
>Thanks, Arseniy
>
>>
>> host$ ./vsock_test --mode=3Dserver --control-port=3D12345 --peer-cid=3D4
>> ...
>> 14 - SOCK_STREAM virtio skb merge...expected recv(2) returns 8 bytes, go=
t 3
>>
>> guest$ ./vsock_test --mode=3Dclient --control-host=3D192.168.133.2 --con=
trol-port=3D12345 --peer-cid=3D2
>>
>> Thanks,
>> Stefano
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
