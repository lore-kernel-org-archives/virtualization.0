Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE71C6FA8F
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 00:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC54E8266D;
	Thu, 31 Aug 2023 00:55:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC54E8266D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ELkw2CxR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tu2Bhijm8bkR; Thu, 31 Aug 2023 00:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF9CA822C1;
	Thu, 31 Aug 2023 00:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF9CA822C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 963B5C0039;
	Thu, 31 Aug 2023 00:55:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32F5BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 00:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC34F41C1F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 00:55:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC34F41C1F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ELkw2CxR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hih6fOgcvsKd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 00:55:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 772B141C14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 00:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 772B141C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693443340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddPWXyjeHrI19yJxQJKSFG8ckl/5yZrofT1cwTzp4OI=;
 b=ELkw2CxR1ZaiN7GsSwYQntb6rUEGHvpK4jNmIypNKL7yk4tDqK4LPQwOqq3I/23j6fprP7
 qbAWopf9PdigCY6Vfr2Bm3et1d66ndvPJigcaxLZlMSZTQw5a1QVINfbbXhqyu0zojeWOU
 hLgQDzi+l+mnC9WLDOg0pICJ1SNi2jc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-i3xN-LukP2a7tpI3nc1Jgg-1; Wed, 30 Aug 2023 20:55:37 -0400
X-MC-Unique: i3xN-LukP2a7tpI3nc1Jgg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-563b4d68e07so1458288a12.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 17:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693443335; x=1694048135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ddPWXyjeHrI19yJxQJKSFG8ckl/5yZrofT1cwTzp4OI=;
 b=hSPikQa9AnRDMlDotYPmby7ei6FupV8VAbX1QYLKxYUIgaDEqpfX90g4J5Uy1hcmlp
 1019pFR/L3H+bvspRkHYKxJORUdHslRF7oMzBeZyNzN2MmMKAfd8d8REsoH0vGRq3lWd
 t75XzSL2Ul6fnE3EkwZm9rBaDQ3UIJt8+gQYxqCFNRuzH4DydKKS7sNz8Ufdb1gFpDed
 VArsxuQWuYh+S06JtJInYTPMjTR+hxLW+ByaS57UiToV2hcgbjwYRqCqO+uNaa4yAG3n
 mb5CaBSi98csiYFSu0MbPXae0LLPsYRUGIZCTLecqhyQQ1JYzus99x+DaKhYz6KbYJXE
 4tVQ==
X-Gm-Message-State: AOJu0YyWgTCDB+F0yLJ9w3p30XMcALFzh3JbYH2xHYM6fqSFef3i0IYs
 aBSX4pbeMPlHBaTY1nd8/RoU3bk6JX1dtijHXsa6dg0NF5NoHg0s5CBD5IyVntnBvrGYFh3rY3N
 XwndV2EgJ2JvWz5mK7nTDmg4Jzgi4tRmBpuQnrKchZw==
X-Received: by 2002:a05:6a20:3cab:b0:149:97e4:8ae4 with SMTP id
 b43-20020a056a203cab00b0014997e48ae4mr1735658pzj.0.1693443335524; 
 Wed, 30 Aug 2023 17:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1F2T71Ojl1Jpdqpquexx1XTD8oeByqwPBqSl8BEi9B5Ecr+9kpxXOli0qBmMGEBS+lADhUQ==
X-Received: by 2002:a05:6a20:3cab:b0:149:97e4:8ae4 with SMTP id
 b43-20020a056a203cab00b0014997e48ae4mr1735645pzj.0.1693443335183; 
 Wed, 30 Aug 2023 17:55:35 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a639354000000b00564be149a15sm205429pgm.65.2023.08.30.17.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 17:55:34 -0700 (PDT)
Message-ID: <eb8f274b-03d9-6b1c-5a4e-d004bdde2804@redhat.com>
Date: Thu, 31 Aug 2023 10:55:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] virtio_balloon: Fix endless deflation and inflation on
 arm64
To: David Hildenbrand <david@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20230829015421.920511-1-gshan@redhat.com>
 <d2bf8d72-8d41-e26f-2dc7-d45973fe2164@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <d2bf8d72-8d41-e26f-2dc7-d45973fe2164@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com, mst@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gOC8zMS8yMyAwMjozMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMjkuMDguMjMg
MDM6NTQsIEdhdmluIFNoYW4gd3JvdGU6Cj4+IFRoZSBkZWZsYXRpb24gcmVxdWVzdCB0byB0aGUg
dGFyZ2V0LCB3aGljaCBpc24ndCB1bmFsaWduZWQgdG8gdGhlCj4+IGd1ZXN0IHBhZ2Ugc2l6ZSBj
YXVzZXMgZW5kbGVzcyBkZWZsYXRpb24gYW5kIGluZmxhdGlvbiBhY3Rpb25zLiBGb3IKPj4gZXhh
bXBsZSwgd2UgcmVjZWl2ZSB0aGUgZmxvb2RpbmcgUU1QIGV2ZW50cyBmb3IgdGhlIGNoYW5nZXMg
b24gbWVtb3J5Cj4+IGJhbGxvb24ncyBzaXplIGFmdGVyIGEgZGVmbGF0aW9uIHJlcXVlc3QgdG8g
dGhlIHVuYWxpZ25lZCB0YXJnZXQgaXMKPj4gc2VudCBmb3IgdGhlIEFSTTY0IGd1ZXN0LCB3aGVy
ZSB3ZSBoYXZlIDY0S0IgYmFzZSBwYWdlIHNpemUuCj4+Cj4+IMKgwqAgL2hvbWUvZ2F2aW4vc2Fu
ZGJveC9xZW11Lm1haW4vYnVpbGQvcWVtdS1zeXN0ZW0tYWFyY2g2NMKgwqDCoMKgwqAgXAo+PiDC
oMKgIC1hY2NlbCBrdm0gLW1hY2hpbmUgdmlydCxnaWMtdmVyc2lvbj1ob3N0IC1jcHUgaG9zdMKg
wqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKgwqAgLXNtcCBtYXhjcHVzPTgsY3B1cz04LHNvY2tldHM9
MixjbHVzdGVycz0yLGNvcmVzPTIsdGhyZWFkcz0xIFwKPj4gwqDCoCAtbSAxMDI0TSxzbG90cz0x
NixtYXhtZW09NjRHwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKgwqAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0s
aWQ9bWVtMCxzaXplPTUxMk3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKg
wqAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0saWQ9bWVtMSxzaXplPTUxMk3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKgwqAgLW51bWEgbm9kZSxub2RlaWQ9MCxtZW1k
ZXY9bWVtMCxjcHVzPTAtM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XAo+PiDCoMKgIC1udW1hIG5vZGUsbm9kZWlkPTEsbWVtZGV2PW1lbTEsY3B1cz00LTfCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gwqDCoMKgwqAgOsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKg
wqAgLWRldmljZSB2aXJ0aW8tYmFsbG9vbi1wY2ksaWQ9YmFsbG9vbjAsYnVzPXBjaWUuMTAKPj4K
Pj4gwqDCoCB7ICJleGVjdXRlIiA6ICJiYWxsb29uIiwgImFyZ3VtZW50cyI6IHsgInZhbHVlIiA6
IDEwNzM2NzIxOTIgfSB9Cj4+IMKgwqAgeyJyZXR1cm4iOiB7fX0KPj4gwqDCoCB7InRpbWVzdGFt
cCI6IHsic2Vjb25kcyI6IDE2OTMyNzIxNzMsICJtaWNyb3NlY29uZHMiOiA4ODY2N30swqDCoCBc
Cj4+IMKgwqDCoCAiZXZlbnQiOiAiQkFMTE9PTl9DSEFOR0UiLCAiZGF0YSI6IHsiYWN0dWFsIjog
MTA3MzYxMDc1Mn19Cj4+IMKgwqAgeyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAxNjkzMjcyMTc0
LCAibWljcm9zZWNvbmRzIjogODk3MDR9LMKgwqAgXAo+PiDCoMKgwqAgImV2ZW50IjogIkJBTExP
T05fQ0hBTkdFIiwgImRhdGEiOiB7ImFjdHVhbCI6IDEwNzM2MTA3NTJ9fQo+PiDCoMKgIHsidGlt
ZXN0YW1wIjogeyJzZWNvbmRzIjogMTY5MzI3MjE3NSwgIm1pY3Jvc2Vjb25kcyI6IDkwODE5fSzC
oMKgIFwKPj4gwqDCoMKgICJldmVudCI6ICJCQUxMT09OX0NIQU5HRSIsICJkYXRhIjogeyJhY3R1
YWwiOiAxMDczNjEwNzUyfX0KPj4gwqDCoCB7InRpbWVzdGFtcCI6IHsic2Vjb25kcyI6IDE2OTMy
NzIxNzYsICJtaWNyb3NlY29uZHMiOiA5MTk2MX0swqDCoCBcCj4+IMKgwqDCoCAiZXZlbnQiOiAi
QkFMTE9PTl9DSEFOR0UiLCAiZGF0YSI6IHsiYWN0dWFsIjogMTA3MzYxMDc1Mn19Cj4+IMKgwqAg
eyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAxNjkzMjcyMTc3LCAibWljcm9zZWNvbmRzIjogOTMw
NDB9LMKgwqAgXAo+PiDCoMKgwqAgImV2ZW50IjogIkJBTExPT05fQ0hBTkdFIiwgImRhdGEiOiB7
ImFjdHVhbCI6IDEwNzM2NzYyODh9fQo+PiDCoMKgIHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjog
MTY5MzI3MjE3OCwgIm1pY3Jvc2Vjb25kcyI6IDk0MTE3fSzCoMKgIFwKPj4gwqDCoMKgICJldmVu
dCI6ICJCQUxMT09OX0NIQU5HRSIsICJkYXRhIjogeyJhY3R1YWwiOiAxMDczNjc2Mjg4fX0KPj4g
wqDCoCB7InRpbWVzdGFtcCI6IHsic2Vjb25kcyI6IDE2OTMyNzIxNzksICJtaWNyb3NlY29uZHMi
OiA5NTMzN30swqDCoCBcCj4+IMKgwqDCoCAiZXZlbnQiOiAiQkFMTE9PTl9DSEFOR0UiLCAiZGF0
YSI6IHsiYWN0dWFsIjogMTA3MzYxMDc1Mn19Cj4+IMKgwqAgeyJ0aW1lc3RhbXAiOiB7InNlY29u
ZHMiOiAxNjkzMjcyMTgwLCAibWljcm9zZWNvbmRzIjogOTY2MTV9LMKgwqAgXAo+PiDCoMKgwqAg
ImV2ZW50IjogIkJBTExPT05fQ0hBTkdFIiwgImRhdGEiOiB7ImFjdHVhbCI6IDEwNzM2NzYyODh9
fQo+PiDCoMKgIHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjogMTY5MzI3MjE4MSwgIm1pY3Jvc2Vj
b25kcyI6IDk3NjI2fSzCoMKgIFwKPj4gwqDCoMKgICJldmVudCI6ICJCQUxMT09OX0NIQU5HRSIs
ICJkYXRhIjogeyJhY3R1YWwiOiAxMDczNjEwNzUyfX0KPj4gwqDCoCB7InRpbWVzdGFtcCI6IHsi
c2Vjb25kcyI6IDE2OTMyNzIxODIsICJtaWNyb3NlY29uZHMiOiA5ODY5M30swqDCoCBcCj4+IMKg
wqDCoCAiZXZlbnQiOiAiQkFMTE9PTl9DSEFOR0UiLCAiZGF0YSI6IHsiYWN0dWFsIjogMTA3MzY3
NjI4OH19Cj4+IMKgwqAgeyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAxNjkzMjcyMTgzLCAibWlj
cm9zZWNvbmRzIjogOTk2OTh9LMKgwqAgXAo+PiDCoMKgwqAgImV2ZW50IjogIkJBTExPT05fQ0hB
TkdFIiwgImRhdGEiOiB7ImFjdHVhbCI6IDEwNzM2MTA3NTJ9fQo+PiDCoMKgIHsidGltZXN0YW1w
IjogeyJzZWNvbmRzIjogMTY5MzI3MjE4NCwgIm1pY3Jvc2Vjb25kcyI6IDEwMDcyN30swqAgXAo+
PiDCoMKgwqAgImV2ZW50IjogIkJBTExPT05fQ0hBTkdFIiwgImRhdGEiOiB7ImFjdHVhbCI6IDEw
NzM2MTA3NTJ9fQo+PiDCoMKgIHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjogMTY5MzI3MjE4NSwg
Im1pY3Jvc2Vjb25kcyI6IDkwNDMwfSzCoMKgIFwKPj4gwqDCoMKgICJldmVudCI6ICJCQUxMT09O
X0NIQU5HRSIsICJkYXRhIjogeyJhY3R1YWwiOiAxMDczNjEwNzUyfX0KPj4gwqDCoCB7InRpbWVz
dGFtcCI6IHsic2Vjb25kcyI6IDE2OTMyNzIxODYsICJtaWNyb3NlY29uZHMiOiAxMDI5OTl9LMKg
IFwKPj4gwqDCoMKgICJldmVudCI6ICJCQUxMT09OX0NIQU5HRSIsICJkYXRhIjogeyJhY3R1YWwi
OiAxMDczNjc2Mjg4fX0KPj4gwqDCoMKgwqDCoCA6Cj4+IMKgwqAgPFRoZSBzaW1pbGFyIFFNUCBl
dmVudHMgcmVwZWF0Pgo+Pgo+PiBGaXggaXQgYnkgaGF2aW5nIHRoZSB0YXJnZXQgYWxpZ25lZCB0
byB0aGUgZ3Vlc3QgcGFnZSBzaXplLCA2NEtCCj4+IGluIHRoaXMgc3BlY2lmaWMgY2FzZS4gV2l0
aCB0aGlzIGFwcGxpZWQsIG5vIGZsb29kaW5nIFFNUCBldmVudAo+PiBpcyBvYnNlcnZlZCBhbmQg
dGhlIG1lbW9yeSBiYWxsb29uJ3Mgc2l6ZSBjYW4gYmUgc3RhYmxpemllZCB0bwo+PiAweDNmZmUw
MDAwIHNvb24gYWZ0ZXIgdGhlIGRlZmxhdGlvbiByZXF1ZXN0IGlzIHNlbnQuCj4+Cj4+IMKgwqAg
eyAiZXhlY3V0ZSIgOiAiYmFsbG9vbiIsICJhcmd1bWVudHMiOiB7ICJ2YWx1ZSIgOiAxMDczNjcy
MTkyIH0gfQo+PiDCoMKgIHsicmV0dXJuIjoge319Cj4+IMKgwqAgeyJ0aW1lc3RhbXAiOiB7InNl
Y29uZHMiOiAxNjkzMjczMzI4LCAibWljcm9zZWNvbmRzIjogNzkzMDc1fSzCoCBcCj4+IMKgwqDC
oCAiZXZlbnQiOiAiQkFMTE9PTl9DSEFOR0UiLCAiZGF0YSI6IHsiYWN0dWFsIjogMTA3MzYxMDc1
Mn19Cj4+IMKgwqAgeyAiZXhlY3V0ZSIgOiAicXVlcnktYmFsbG9vbiIgfQo+PiDCoMKgIHsicmV0
dXJuIjogeyJhY3R1YWwiOiAxMDczNjEwNzUyfX0KPj4KPj4gU2lnbmVkLW9mZi1ieTogR2F2aW4g
U2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19iYWxsb29uLmMgfCAxMyArKysrKysrKysrKystCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fYmFsbG9vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX2JhbGxvb24uYwo+
PiBpbmRleCA1YjE1OTM2YTUyMTQuLjYyNWNhYWMzNTI2NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX2JhbGxvb24uYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
YmFsbG9vbi5jCj4+IEBAIC0zODYsNiArMzg2LDE3IEBAIHN0YXRpYyB2b2lkIHN0YXRzX2hhbmRs
ZV9yZXF1ZXN0KHN0cnVjdCB2aXJ0aW9fYmFsbG9vbiAqdmIpCj4+IMKgwqDCoMKgwqAgdmlydHF1
ZXVlX2tpY2sodnEpOwo+PiDCoCB9Cj4+ICtzdGF0aWMgaW5saW5lIHM2NCBhbGlnbl9wYWdlc191
cChzNjQgZGlmZikKPj4gK3sKPj4gK8KgwqDCoCBpZiAoZGlmZiA9PSAwKQo+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGRpZmY7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoZGlmZiA+IDApCj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gQUxJR04oZGlmZiwgVklSVElPX0JBTExPT05fUEFHRVNfUEVSX1BB
R0UpOwo+PiArCj4+ICvCoMKgwqAgcmV0dXJuIC1BTElHTigtZGlmZiwgVklSVElPX0JBTExPT05f
UEFHRVNfUEVSX1BBR0UpOwo+PiArfQo+PiArCj4+IMKgIHN0YXRpYyBpbmxpbmUgczY0IHRvd2Fy
ZHNfdGFyZ2V0KHN0cnVjdCB2aXJ0aW9fYmFsbG9vbiAqdmIpCj4+IMKgIHsKPj4gwqDCoMKgwqDC
oCBzNjQgdGFyZ2V0Owo+PiBAQCAtMzk2LDcgKzQwNyw3IEBAIHN0YXRpYyBpbmxpbmUgczY0IHRv
d2FyZHNfdGFyZ2V0KHN0cnVjdCB2aXJ0aW9fYmFsbG9vbiAqdmIpCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICZudW1fcGFnZXMpOwo+PiDCoMKgwqDCoMKgIHRhcmdldCA9IG51bV9wYWdl
czsKPj4gLcKgwqDCoCByZXR1cm4gdGFyZ2V0IC0gdmItPm51bV9wYWdlczsKPiAKPiBXZSBrbm93
IHRoYXQgdmItPm51bV9wYWdlcyBpcyBhbHdheXMgbXVsdGlwbGVzIG9mIFZJUlRJT19CQUxMT09O
X1BBR0VTX1BFUl9QQUdFLgo+IAo+IFdoeSBub3Qgc2ltcGx5IGFsaWduIHRhcmdldCBkb3duPwo+
IAo+IHRhcmdldCA9IEFMSUdOKG51bV9wYWdlcywgVklSVElPX0JBTExPT05fUEFHRVNfUEVSX1BB
R0UpOwo+IHJldHVybiB0YXJnZXQgLSB2Yi0+bnVtX3BhZ2VzOwo+IAoKR29vZCBwb2ludC4gVGhh
bmtzIGEgbG90LCBEYXZpZC4gVGhlIGNvZGUgd2lsbCBiZSBjaGFuZ2VkIHRvIHdoYXQncyBzdWdn
ZXN0ZWQgaW4KdjIsIHRvIGJlIHBvc3RlZCBzb29uLiBJIHdpbGwgYWxzbyBhZGQgYSBjb21tZW50
IHRvIGV4cGxhaW4gaXQgYSBiaXQuIEJlc2lkZXMsIEFMSUdOKCkKaXMgYWxpZ24tdXAgaW5zdGVh
ZCBvZiBhbGlnbi1kb3duIHRvIGdpdmUgYmlhcyB0byBkZWZsYXRpb24gaW50ZW50aW9uYWxseSwg
dG8gYXZvaWQKb3ZlcnJ1bm5pbmcgdGhlIG1hY2hpbmUncyBtZW1vcnkgc2l6ZSBpZiBpdCdzIG5v
dCBhbGlnbmVkIHRvIDY0S0IuIEZ1cnRoZXIgbW9yZSwKdGhlIGFsaWduLXVwIGNhdXNlcyBkZWZs
YXRpb24gZXZlbiB1c2VyIHJlcXVlc3RzIGEgNEtCIGRpZmYuIEhvd2V2ZXIsIHRoZSBvdXRjb21l
Cm9mIEFMSUdOX0RPV04oNEtCLCA2NEtCKSBpcyB6ZXJvIGFuZCBubyBkZWZsYXRpb24gd2lsbCBi
ZSB0cmlnZ2VyZWQuCgpUaGFua3MsCkdhdmluCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
