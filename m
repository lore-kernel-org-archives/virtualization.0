Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EFEC43217
	for <virtualization@archiver.kernel.org>; Wed,  2 Nov 2022 13:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB698409DE;
	Wed,  2 Nov 2022 13:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB698409DE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=docker.com header.i=@docker.com header.a=rsa-sha256 header.s=google header.b=Z1G3Uu9L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B12iU7oNuTf6; Wed,  2 Nov 2022 13:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6BDE24012F;
	Wed,  2 Nov 2022 13:30:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BDE24012F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B3FCC0032;
	Wed,  2 Nov 2022 13:30:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90789C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 13:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 583AD40168
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 13:30:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 583AD40168
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xEjXDL2Y5WPM
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 13:30:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 776C04012F
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 776C04012F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 13:30:53 +0000 (UTC)
Received: by mail-io1-xd34.google.com with SMTP id p184so14977179iof.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Nov 2022 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=docker.com; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzaJHFBthKI+N9jxIZGxCYyCJNLPmN4e+ahut/KLlwU=;
 b=Z1G3Uu9Lq7rVn008/R7qQNc36TD/itgKx7kUwlTZfUo5IN+FIIlbjt8ZQMasFfxQv/
 7ZcXjtTGfguGBZMZeloCNGhQZobrVDESsgnp74DwVEsgMpre+qssJTKu7jorrORpLVug
 vPsZJ3ucMyUTwOVQQIj5hVtyx8plTk1vOS82g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzaJHFBthKI+N9jxIZGxCYyCJNLPmN4e+ahut/KLlwU=;
 b=omgxDr+oaw07bj4QAhL1EZezHNYGBdeDcdAGsNxMLg52nENR2udgFInuV6uf9Q+drK
 motgLtAdH0I4LsVVt3JbLBrHqC2x4feujGALWsiYSPWoFJCr811OmD389j3xTkreolB9
 USBnyUQ0lx78w/dGAYb7yZgabLGDWw/EJuUmv7RVtvopZgO2xHt2pQALRCYN5/PMR/sK
 XP9F/7uyp6uWclOkUkIw+9iN1uK2RwWJxiP6yxHuNK8Ili7WUPbMl6FeX1b+0z+ItnVZ
 WHAgDfHMyu/H+jBWHJQFMutie94bnje1PNnik0ZEQ2MML6EsHW5OFwRgzvvPxzvklQFG
 UTgg==
X-Gm-Message-State: ACrzQf3TfpvDsssNBmpMS3F5U4O6v2jyIc3UBS66dWm9SYx9GTO65uVX
 ZzBULJwGsIKAx7U3okZ6Q58hS/NzfeugamOIFwRzig==
X-Google-Smtp-Source: AMsMyM4VY9g5n2ABc5ygSVSDsCFRasTDP+7DPN2cQU3wN0pNpeoFN4/+EvRJlj9i89lTtEQDqsiHOyx4b96d25H0VPQ=
X-Received: by 2002:a6b:ba83:0:b0:6d3:e190:5abd with SMTP id
 k125-20020a6bba83000000b006d3e1905abdmr4589591iof.188.1667395852513; Wed, 02
 Nov 2022 06:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221101021706.26152-1-decui@microsoft.com>
 <20221101021706.26152-3-decui@microsoft.com>
 <20221102093137.2il5u7opfyddheis@sgarzare-redhat>
 <20221102094224.2n2p6cakjtd4n2yf@sgarzare-redhat>
In-Reply-To: <20221102094224.2n2p6cakjtd4n2yf@sgarzare-redhat>
Date: Wed, 2 Nov 2022 14:30:41 +0100
Message-ID: <CANWeT6gCfXbGVVySyiG9oQi9EXS2U5aEdN38z9qz1u91vCetyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: wei.liu@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, Dexuan Cui <decui@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stephen@networkplumber.org, edumazet@google.com, kuba@kernel.org,
 arseny.krasnov@kaspersky.com, pabeni@redhat.com, davem@davemloft.net
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
From: Frederic Dalleau via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Frederic Dalleau <frederic.dalleau@docker.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgRGV4dWFuLCBTdGVmYW5vLAoKVGVzdGVkLWJ5OiBGcsOpZMOpcmljIERhbGxlYXUgPGZyZWRl
cmljLmRhbGxlYXVAZG9ja2VyLmNvbT4KClJlZ2FyZHMsCkZyw6lkw6lyaWMKCgpPbiBXZWQsIE5v
diAyLCAyMDIyIGF0IDEwOjQyIEFNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIE5vdiAwMiwgMjAyMiBhdCAxMDozMTozN0FNICswMTAw
LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPk9uIE1vbiwgT2N0IDMxLCAyMDIyIGF0IDA3
OjE3OjA2UE0gLTA3MDAsIERleHVhbiBDdWkgd3JvdGU6Cj4gPj5DdXJyZW50bHkgdnNvY2tfY29u
bmVjdGlibGVfaGFzX2RhdGEoKSBtYXkgbWlzcyBhIHdha2V1cCBvcGVyYXRpb24KPiA+PmJldHdl
ZW4gdnNvY2tfY29ubmVjdGlibGVfaGFzX2RhdGEoKSA9PSAwIGFuZCB0aGUgcHJlcGFyZV90b193
YWl0KCkuCj4gPj4KPiA+PkZpeCB0aGUgcmFjZSBieSBhZGRpbmcgdGhlIHByb2Nlc3MgdG8gdGhl
IHdhaXQgcXVldWUgYmVmb3JlIGNoZWNraW5nCj4gPj52c29ja19jb25uZWN0aWJsZV9oYXNfZGF0
YSgpLgo+ID4+Cj4gPj5GaXhlczogYjNmN2ZkNTQ4ODFiICgiYWZfdnNvY2s6IHNlcGFyYXRlIHdh
aXQgZGF0YSBsb29wIikKPiA+PlNpZ25lZC1vZmYtYnk6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jv
c29mdC5jb20+Cj4gPj4tLS0KPiA+Pgo+ID4+Q2hhbmdlcyBpbiB2MiAoVGhhbmtzIFN0ZWZhbm8h
KToKPiA+PiBGaXhlZCBhIHR5cG8gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgo+ID4+IFJlbW92ZWQg
dGhlIHVubmVjZXNzYXJ5IGZpbmlzaF93YWl0KCkgYXQgdGhlIGVuZCBvZiB0aGUgbG9vcC4KPiA+
Cj4gPkxHVE06Cj4gPgo+ID5SZXZpZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFy
ZUByZWRoYXQuY29tPgo+ID4KPgo+IEFuZCBJIHdvdWxkIGFkZAo+Cj4gUmVwb3J0ZWQtYnk6IEZy
w6lkw6lyaWMgRGFsbGVhdSA8ZnJlZGVyaWMuZGFsbGVhdUBkb2NrZXIuY29tPgo+Cj4gU2luY2Ug
RnLDqWTDqXJpYyBwb3N0ZWQgYSBzaW1pbGFyIHBhdGNoIHNvbWUgbW9udGhzIGFnbyAoSSBsb3N0
IGl0IGJlY2F1c2UKPiBuZXRkZXYgYW5kIEkgd2VyZSBub3QgaW4gY2MpOgo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzIwMjIwODI0MDc0MjUxLjIzMzY5OTctMi1mcmVk
ZXJpYy5kYWxsZWF1QGRvY2tlci5jb20vCj4KPiBUaGFua3MsCj4gU3RlZmFubwo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
