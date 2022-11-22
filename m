Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A20C433FE
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 15:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAA0B40133;
	Tue, 22 Nov 2022 15:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAA0B40133
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J8ryw+Ek
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Q08UfJqOg3U; Tue, 22 Nov 2022 15:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50B50400CB;
	Tue, 22 Nov 2022 15:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50B50400CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31560C0033;
	Tue, 22 Nov 2022 15:15:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE86FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 15:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C61BC410DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 15:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C61BC410DE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J8ryw+Ek
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iJ7va5ivJj1G
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 15:15:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A74C9410C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A74C9410C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669130132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hK0ObLejkUdO2kT5TG9vuCU2RH+H4+xSCZQ9aj/PoXU=;
 b=J8ryw+EkuV7DG2NHZ3QMwcUrLprL3LBkrQi+mqUfE6LnpVoHYq1kbKqyKxmR+37k6mdRLD
 +cArgk+FmWeU/uNnEndSgVdjF70C0vC0Uk4jy8JQZSm/9o/Fjr3pdPjjUq/nLzopMRiM+k
 FqYV/Tu1qJmTLZ8FEIUB+opkn7edrBE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-5RngAGHMPOCZH4kooiS14Q-1; Tue, 22 Nov 2022 10:15:30 -0500
X-MC-Unique: 5RngAGHMPOCZH4kooiS14Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 c1-20020a7bc001000000b003cfe40fca79so4184000wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 07:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hK0ObLejkUdO2kT5TG9vuCU2RH+H4+xSCZQ9aj/PoXU=;
 b=v8CMmiuZazY2uw5bvyBhv2iQ2Tq9SqgKOSx6aT03hd7Ko3Q2stjKXPzKG3qay5LwQm
 67dzF63TSTmong4fq5CdjdkYkIB/SOnFBs5akcCASQgAgsq6fwF5TfOsADCXnt72osxH
 3EiGCAMdqpEJbEHe7s/COSDJ7SGFZIzmcmwTVUkisdLu/nAZI5eXANYYhEm2QfJfVmPP
 hFG0WrycxX/TvPFU1kpviA9gZ2Q+TmnKyKbsewnTo94l/tF6HgeTAi7fQfkr2JtxkBN8
 LaP1ZkiJEKewu8Xi4LWwzvO8+zemC0rKy+FLxXyVQACLKjkpBXAuVWQgHm8dBftYBbha
 hx9w==
X-Gm-Message-State: ANoB5pm4mvq/BX80MeQgYK4tuD6CXUDqTXejgKwVM/p4BMpqQPAwry9B
 wzxoBKLSM3ZuasT1T9e89L5IJiPyBnhWEnrP6YwhxJ8rDUyf5OHcwhCSBB4SJ14o3FvwHeVgOEl
 GjU9LF4Dty6FLz6gTUbczt58oO8cl2n3YpSiMQ+EUvA==
X-Received: by 2002:a7b:c3c9:0:b0:3cf:5442:bbe with SMTP id
 t9-20020a7bc3c9000000b003cf54420bbemr20606644wmj.2.1669130129161; 
 Tue, 22 Nov 2022 07:15:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5SOw1y9jXJkuwchkA+/tOO86TqATmbtRGdYrHaEKbQW+CeSO9KlzdRp2zdpCm9yQDtyT4spw==
X-Received: by 2002:a7b:c3c9:0:b0:3cf:5442:bbe with SMTP id
 t9-20020a7bc3c9000000b003cf54420bbemr20606627wmj.2.1669130128874; 
 Tue, 22 Nov 2022 07:15:28 -0800 (PST)
Received: from [192.168.8.105] (tmo-116-109.customers.d1-online.com.
 [80.187.116.109]) by smtp.gmail.com with ESMTPSA id
 f28-20020a5d58fc000000b0022e36c1113fsm14093648wrd.13.2022.11.22.07.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Nov 2022 07:15:28 -0800 (PST)
Message-ID: <61474ecb-fa2a-e651-9157-b73b6b5a8295@redhat.com>
Date: Tue, 22 Nov 2022 16:15:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] virtio_console: Introduce an ID allocator for virtual
 console numbers
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20221122134643.376184-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20221122134643.376184-1-clg@kaod.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux-foundation.org
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

T24gMjIvMTEvMjAyMiAxNC40NiwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6Cj4gV2hlbiBhIHZp
cnRpbyBjb25zb2xlIHBvcnQgaXMgaW5pdGlhbGl6ZWQsIGl0IGlzIHJlZ2lzdGVyZWQgYXMgYW4g
aHZjCj4gY29uc29sZSB1c2luZyBhIHZpcnR1YWwgY29uc29sZSBudW1iZXIuIElmIGEgS1ZNIGd1
ZXN0IGlzIHN0YXJ0ZWQgd2l0aAo+IG11bHRpcGxlIHZpcnRpbyBjb25zb2xlIGRldmljZXMsIHRo
ZSBzYW1lIHZ0ZXJtbm8gKG9yIHZpcnR1YWwgY29uc29sZQo+IG51bWJlcikgY2FuIGJlIHVzZWQg
dG8gYWxsb2NhdGUgZGlmZmVyZW50IGh2YyBjb25zb2xlcywgd2hpY2ggbGVhZHMgdG8KPiB2YXJp
b3VzIGNvbW11bmljYXRpb24gcHJvYmxlbXMgbGF0ZXIgb24uCj4gCj4gVGhpcyBpcyBhbHNvIHJl
cG9ydGVkIGluIGRlYnVnZnMgOgo+IAo+ICAgICMgZ3JlcCB2dGVybW5vIC9zeXMva2VybmVsL2Rl
YnVnL3ZpcnRpby1wb3J0cy8qCj4gICAgL3N5cy9rZXJuZWwvZGVidWcvdmlydGlvLXBvcnRzL3Zw
b3J0MXAxOmNvbnNvbGVfdnRlcm1ubzogMQo+ICAgIC9zeXMva2VybmVsL2RlYnVnL3ZpcnRpby1w
b3J0cy92cG9ydDJwMTpjb25zb2xlX3Z0ZXJtbm86IDEKPiAgICAvc3lzL2tlcm5lbC9kZWJ1Zy92
aXJ0aW8tcG9ydHMvdnBvcnQzcDE6Y29uc29sZV92dGVybW5vOiAyCj4gICAgL3N5cy9rZXJuZWwv
ZGVidWcvdmlydGlvLXBvcnRzL3Zwb3J0NHAxOmNvbnNvbGVfdnRlcm1ubzogMwo+IAo+IFJlcGxh
Y2UgdGhlIG5leHRfdnRlcm1ubyBnbG9iYWwgd2l0aCBhbiBJRCBhbGxvY2F0b3IgYW5kIHN0YXJ0
IHRoZQo+IGFsbG9jYXRpb24gYXQgMSBhcyBpdCBpcyB0b2RheS4gQWxzbyByZWN5Y2xlIElEcyB3
aGVuIGEgY29uc29sZSBwb3J0Cj4gaXMgcmVtb3ZlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPgo+IC0tLQo+IAo+ICAgQ2hhbmdlcyBpbiB2MzoK
PiAgIC0gbWFkZSB1c2Ugb2YgaWRhX2FsbG9jX21pbigpCj4gICAtIGZyZWUgSUQgaW4gY2FzZSBv
ZiBlcnJvcgo+ICAgCj4gICBDaGFuZ2VzIGluIHYyOgo+ICAgLSBpbnRyb2R1Y2VkIGFuIElEIGFs
bG9jYXRvcgo+IAo+ICAgZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMgfCAyNiArKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDE1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdmlydGlvX2Nv
bnNvbGUuYyBiL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jCj4gaW5kZXggOWZhM2M3NmEy
NjdmLi42YTgyMTExOGQ1NTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25z
b2xlLmMKPiArKysgYi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwo+IEBAIC0xMyw2ICsx
Myw3IEBACj4gICAjaW5jbHVkZSA8bGludXgvZnMuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9zcGxp
Y2UuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9wYWdlbWFwLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9p
ZHIuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvbGlz
dC5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3BvbGwuaD4KPiBAQCAtNDgsMjIgKzQ5LDExIEBAIHN0
cnVjdCBwb3J0c19kcml2ZXJfZGF0YSB7Cj4gICAJLyogTGlzdCBvZiBhbGwgdGhlIGRldmljZXMg
d2UncmUgaGFuZGxpbmcgKi8KPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIHBvcnRkZXZzOwo+ICAgCj4g
LQkvKgo+IC0JICogVGhpcyBpcyB1c2VkIHRvIGtlZXAgdHJhY2sgb2YgdGhlIG51bWJlciBvZiBo
dmMgY29uc29sZXMKPiAtCSAqIHNwYXduZWQgYnkgdGhpcyBkcml2ZXIuICBUaGlzIG51bWJlciBp
cyBnaXZlbiBhcyB0aGUgZmlyc3QKPiAtCSAqIGFyZ3VtZW50IHRvIGh2Y19hbGxvYygpLiAgVG8g
Y29ycmVjdGx5IG1hcCBhbiBpbml0aWFsCj4gLQkgKiBjb25zb2xlIHNwYXduZWQgdmlhIGh2Y19p
bnN0YW50aWF0ZSB0byB0aGUgY29uc29sZSBiZWluZwo+IC0JICogaG9va2VkIHVwIHZpYSBodmNf
YWxsb2MsIHdlIG5lZWQgdG8gcGFzcyB0aGUgc2FtZSB2dGVybW5vLgo+IC0JICoKPiAtCSAqIFdl
IGFsc28ganVzdCBhc3N1bWUgdGhlIGZpcnN0IGNvbnNvbGUgYmVpbmcgaW5pdGlhbGlzZWQgd2Fz
Cj4gLQkgKiB0aGUgZmlyc3Qgb25lIHRoYXQgZ290IHVzZWQgYXMgdGhlIGluaXRpYWwgY29uc29s
ZS4KPiAtCSAqLwo+IC0JdW5zaWduZWQgaW50IG5leHRfdnRlcm1ubzsKPiAtCj4gICAJLyogQWxs
IHRoZSBjb25zb2xlIGRldmljZXMgaGFuZGxlZCBieSB0aGlzIGRyaXZlciAqLwo+ICAgCXN0cnVj
dCBsaXN0X2hlYWQgY29uc29sZXM7Cj4gICB9Owo+IC1zdGF0aWMgc3RydWN0IHBvcnRzX2RyaXZl
cl9kYXRhIHBkcnZkYXRhID0geyAubmV4dF92dGVybW5vID0gMX07Cj4gKwo+ICtzdGF0aWMgc3Ry
dWN0IHBvcnRzX2RyaXZlcl9kYXRhIHBkcnZkYXRhOwo+ICAgCj4gICBzdGF0aWMgREVGSU5FX1NQ
SU5MT0NLKHBkcnZkYXRhX2xvY2spOwo+ICAgc3RhdGljIERFQ0xBUkVfQ09NUExFVElPTihlYXJs
eV9jb25zb2xlX2FkZGVkKTsKPiBAQCAtODksNiArNzksOCBAQCBzdHJ1Y3QgY29uc29sZSB7Cj4g
ICAJdTMyIHZ0ZXJtbm87Cj4gICB9Owo+ICAgCj4gK3N0YXRpYyBERUZJTkVfSURBKHZ0ZXJtbm9f
aWRhKTsKPiArCj4gICBzdHJ1Y3QgcG9ydF9idWZmZXIgewo+ICAgCWNoYXIgKmJ1ZjsKPiAgIAo+
IEBAIC0xMjQ0LDE4ICsxMjM2LDIxIEBAIHN0YXRpYyBpbnQgaW5pdF9wb3J0X2NvbnNvbGUoc3Ry
dWN0IHBvcnQgKnBvcnQpCj4gICAJICogcG9pbnRlcnMuICBUaGUgZmluYWwgYXJndW1lbnQgaXMg
dGhlIG91dHB1dCBidWZmZXIgc2l6ZTogd2UKPiAgIAkgKiBjYW4gZG8gYW55IHNpemUsIHNvIHdl
IHB1dCBQQUdFX1NJWkUgaGVyZS4KPiAgIAkgKi8KPiAtCXBvcnQtPmNvbnMudnRlcm1ubyA9IHBk
cnZkYXRhLm5leHRfdnRlcm1ubzsKPiArCXJldCA9IGlkYV9hbGxvY19taW4oJnZ0ZXJtbm9faWRh
LCAxLCBHRlBfS0VSTkVMKTsKPiArCWlmIChyZXQgPCAwKQo+ICsJCXJldHVybiByZXQ7Cj4gICAK
PiArCXBvcnQtPmNvbnMudnRlcm1ubyA9IHJldDsKPiAgIAlwb3J0LT5jb25zLmh2YyA9IGh2Y19h
bGxvYyhwb3J0LT5jb25zLnZ0ZXJtbm8sIDAsICZodl9vcHMsIFBBR0VfU0laRSk7Cj4gICAJaWYg
KElTX0VSUihwb3J0LT5jb25zLmh2YykpIHsKPiAgIAkJcmV0ID0gUFRSX0VSUihwb3J0LT5jb25z
Lmh2Yyk7Cj4gICAJCWRldl9lcnIocG9ydC0+ZGV2LAo+ICAgCQkJImVycm9yICVkIGFsbG9jYXRp
bmcgaHZjIGZvciBwb3J0XG4iLCByZXQpOwo+ICAgCQlwb3J0LT5jb25zLmh2YyA9IE5VTEw7Cj4g
KwkJaWRhX2ZyZWUoJnZ0ZXJtbm9faWRhLCBwb3J0LT5jb25zLnZ0ZXJtbm8pOwo+ICAgCQlyZXR1
cm4gcmV0Owo+ICAgCX0KPiAgIAlzcGluX2xvY2tfaXJxKCZwZHJ2ZGF0YV9sb2NrKTsKPiAtCXBk
cnZkYXRhLm5leHRfdnRlcm1ubysrOwo+ICAgCWxpc3RfYWRkX3RhaWwoJnBvcnQtPmNvbnMubGlz
dCwgJnBkcnZkYXRhLmNvbnNvbGVzKTsKPiAgIAlzcGluX3VubG9ja19pcnEoJnBkcnZkYXRhX2xv
Y2spOwo+ICAgCXBvcnQtPmd1ZXN0X2Nvbm5lY3RlZCA9IHRydWU7Cj4gQEAgLTE1MzIsNiArMTUy
Nyw3IEBAIHN0YXRpYyB2b2lkIHVucGx1Z19wb3J0KHN0cnVjdCBwb3J0ICpwb3J0KQo+ICAgCQls
aXN0X2RlbCgmcG9ydC0+Y29ucy5saXN0KTsKPiAgIAkJc3Bpbl91bmxvY2tfaXJxKCZwZHJ2ZGF0
YV9sb2NrKTsKPiAgIAkJaHZjX3JlbW92ZShwb3J0LT5jb25zLmh2Yyk7Cj4gKwkJaWRhX2ZyZWUo
JnZ0ZXJtbm9faWRhLCBwb3J0LT5jb25zLnZ0ZXJtbm8pOwo+ICAgCX0KPiAgIAo+ICAgCXJlbW92
ZV9wb3J0X2RhdGEocG9ydCk7CgpSZXZpZXdlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhh
dC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
