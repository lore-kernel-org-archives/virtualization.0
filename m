Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F04EE57DF
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 13:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19CAA60701;
	Mon, 11 Sep 2023 13:03:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19CAA60701
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddtpiiMp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMi30siVJgBN; Mon, 11 Sep 2023 13:03:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A0E9605AE;
	Mon, 11 Sep 2023 13:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A0E9605AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72CC6C0039;
	Mon, 11 Sep 2023 13:03:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CFE7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 13:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 279D740908
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 13:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 279D740908
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddtpiiMp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egs4XmUdFfms
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 13:03:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58AC4403A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 13:03:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58AC4403A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694437406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSJPoGx10J6x6+0exgf8zlMMy8M925rAu1G76vFf9bs=;
 b=ddtpiiMpoYS6qXRmCWVNVsI78uGqlrmMRsOA/+vBKG/cmXcWyLO3HJjkXWh4jWG3aJwEj2
 uqDsFViJNTHvVP7kZ3MWo8kv7YbLRlDh/WgR8n/iNcPZiBuB22hTbYZNCC/5aqkWOauMS4
 hkiqAVHe+91tYlVuMQISzN8jg6GRSO0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-HRl8HX2aMzS5sXQtod1MAA-1; Mon, 11 Sep 2023 09:03:23 -0400
X-MC-Unique: HRl8HX2aMzS5sXQtod1MAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E90643C1DC25;
 Mon, 11 Sep 2023 13:03:21 +0000 (UTC)
Received: from [10.22.32.237] (unknown [10.22.32.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 460CC40C6EA8;
 Mon, 11 Sep 2023 13:03:20 +0000 (UTC)
Message-ID: <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com>
Date: Mon, 11 Sep 2023 09:03:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number
 of cpus >= 16k
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
 <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: Guo Ren <guoren@linux.alibaba.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 bjorn@rivosinc.com, palmer@rivosinc.com,
 virtualization@lists.linux-foundation.org, conor.dooley@microchip.com,
 jszhang@kernel.org, linux-riscv@lists.infradead.org, will@kernel.org,
 keescook@chromium.org, linux-arch@vger.kernel.org, anup@brainfault.org,
 linux-csky@vger.kernel.org, xiaoguang.xing@sophgo.com, mingo@redhat.com,
 greentime.hu@sifive.com, ajones@ventanamicro.com, alexghiti@rivosinc.com,
 paulmck@kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 leobras@redhat.com, paul.walmsley@sifive.com, tglx@linutronix.de,
 rdunlap@infradead.org, wuwei2016@iscas.ac.cn, wefu@redhat.com
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

T24gOS8xMC8yMyAyMzowOSwgR3VvIFJlbiB3cm90ZToKPiBPbiBNb24sIFNlcCAxMSwgMjAyMyBh
dCAxMDozNeKAr0FNIFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+
PiBPbiA5LzEwLzIzIDA0OjI4LCBndW9yZW5Aa2VybmVsLm9yZyB3cm90ZToKPj4+IEZyb206IEd1
byBSZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNvbT4KPj4+Cj4+PiBUaGUgdGFyZ2V0IG9mIHhj
aGdfdGFpbCBpcyB0byB3cml0ZSB0aGUgdGFpbCB0byB0aGUgbG9jayB2YWx1ZSwgc28KPj4+IGFk
ZGluZyBwcmVmZXRjaHcgY291bGQgaGVscCB0aGUgbmV4dCBjbXB4Y2hnIHN0ZXAsIHdoaWNoIG1h
eQo+Pj4gZGVjcmVhc2UgdGhlIGNtcHhjaGcgcmV0cnkgbG9vcHMgb2YgeGNoZ190YWlsLiBTb21l
IHByb2Nlc3NvcnMgbWF5Cj4+PiB1dGlsaXplIHRoaXMgZmVhdHVyZSB0byBnaXZlIGEgZm9yd2Fy
ZCBndWFyYW50ZWUsIGUuZy4sIFJJU0MtVgo+Pj4gWHVhblRpZSBwcm9jZXNzb3JzIHdvdWxkIGJs
b2NrIHRoZSBzbm9vcCBjaGFubmVsICYgaXJxIGZvciBzZXZlcmFsCj4+PiBjeWNsZXMgd2hlbiBw
cmVmZXRjaC53IGluc3RydWN0aW9uIChmcm9tIFppY2JvcCBleHRlbnNpb24pIHJldGlyZWQsCj4+
PiB3aGljaCBndWFyYW50ZWVzIHRoZSBuZXh0IGNtcHhjaGcgc3VjY2VlZHMuCj4+Pgo+Pj4gU2ln
bmVkLW9mZi1ieTogR3VvIFJlbiA8Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gU2lnbmVk
LW9mZi1ieTogR3VvIFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+Cj4+PiAtLS0KPj4+ICAgIGtlcm5l
bC9sb2NraW5nL3FzcGlubG9jay5jIHwgNSArKysrLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9rZXJuZWwv
bG9ja2luZy9xc3BpbmxvY2suYyBiL2tlcm5lbC9sb2NraW5nL3FzcGlubG9jay5jCj4+PiBpbmRl
eCBkM2Y5OTA2MGI2MGYuLjk2YjU0ZTJhZGU4NiAxMDA2NDQKPj4+IC0tLSBhL2tlcm5lbC9sb2Nr
aW5nL3FzcGlubG9jay5jCj4+PiArKysgYi9rZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYwo+Pj4g
QEAgLTIyMyw3ICsyMjMsMTAgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGNsZWFyX3Bl
bmRpbmdfc2V0X2xvY2tlZChzdHJ1Y3QgcXNwaW5sb2NrICpsb2NrKQo+Pj4gICAgICovCj4+PiAg
ICBzdGF0aWMgX19hbHdheXNfaW5saW5lIHUzMiB4Y2hnX3RhaWwoc3RydWN0IHFzcGlubG9jayAq
bG9jaywgdTMyIHRhaWwpCj4+PiAgICB7Cj4+PiAtICAgICB1MzIgb2xkLCBuZXcsIHZhbCA9IGF0
b21pY19yZWFkKCZsb2NrLT52YWwpOwo+Pj4gKyAgICAgdTMyIG9sZCwgbmV3LCB2YWw7Cj4+PiAr
Cj4+PiArICAgICBwcmVmZXRjaHcoJmxvY2stPnZhbCk7Cj4+PiArICAgICB2YWwgPSBhdG9taWNf
cmVhZCgmbG9jay0+dmFsKTsKPj4+Cj4+PiAgICAgICAgZm9yICg7Oykgewo+Pj4gICAgICAgICAg
ICAgICAgbmV3ID0gKHZhbCAmIF9RX0xPQ0tFRF9QRU5ESU5HX01BU0spIHwgdGFpbDsKPj4gVGhh
dCBsb29rcyBhIGJpdCB3ZWlyZC4gWW91IHByZS1mZXRjaCBhbmQgdGhlbiBpbW1lZGlhdGVseSBy
ZWFkIGl0LiBIb3cKPj4gbXVjaCBwZXJmb3JtYW5jZSBnYWluIHlvdSBnZXQgYnkgdGhpcyBjaGFu
Z2UgYWxvbmU/Cj4+Cj4+IE1heWJlIHlvdSBjYW4gZGVmaW5lIGFuIGFyY2ggc3BlY2lmaWMgcHJp
bWl0aXZlIHRoYXQgZGVmYXVsdCBiYWNrIHRvCj4+IGF0b21pY19yZWFkKCkgaWYgbm90IGRlZmlu
ZWQuCj4gVGh4IGZvciB0aGUgcmVwbHkuIFRoaXMgaXMgYSBnZW5lcmljIG9wdGltaXphdGlvbiBw
b2ludCBJIHdvdWxkIGxpa2UKPiB0byB0YWxrIGFib3V0IHdpdGggeW91Lgo+Cj4gRmlyc3QsIHBy
ZWZldGNodygpIG1ha2VzIGNhY2hlbGluZSBhbiBleGNsdXNpdmUgc3RhdGUgYW5kIHNlcnZlcyBm
b3IKPiB0aGUgbmV4dCBjbXB4Y2hnIGxvb3Agc2VtYW50aWMsIHdoaWNoIHdyaXRlcyB0aGUgaWR4
X3RhaWwgcGFydCBvZgo+IGFyY2hfc3Bpbl9sb2NrLiBUaGUgYXRvbWljX3JlYWQgb25seSBtYWtl
cyBjYWNoZWxpbmUgaW4gdGhlIHNoYXJlZAo+IHN0YXRlLCB3aGljaCBjb3VsZG4ndCBnaXZlIGFu
eSBndWFyYW50ZWUgZm9yIHRoZSBuZXh0IGNtcHhjaGcgbG9vcAo+IHNlbWFudGljLiBNaWNyby1h
cmNoaXRlY3R1cmUgY291bGQgdXRpbGl6ZSBwcmVmZXRjaHcoKSB0byBwcm92aWRlIGEKPiBzdHJv
bmcgZm9yd2FyZCBwcm9ncmVzcyBndWFyYW50ZWUgZm9yIHRoZSB4Y2hnX3RhaWwsIGUuZy4sIHRo
ZSBULUhFQUQKPiBYdWFuVGllIHByb2Nlc3NvciB3b3VsZCBob2xkIHRoZSBleGNsdXNpdmUgY2Fj
aGVsaW5lIHN0YXRlIHVudGlsIHRoZQo+IG5leHQgY21weGNoZyB3cml0ZSBzdWNjZXNzLgo+Cj4g
SW4gdGhlIGVuZCwgTGV0J3MgZ28gYmFjayB0byB0aGUgcHJpbmNpcGxlOiB0aGUgeGNoZ190YWls
IGlzIGFuIGF0b21pYwo+IHN3YXAgb3BlcmF0aW9uIHRoYXQgY29udGFpbnMgd3JpdGUgZXZlbnR1
YWxseSwgc28gZ2l2aW5nIGEgcHJlZmV0Y2h3KCkKPiBhdCB0aGUgYmVnaW5uaW5nIGlzIGFjY2Vw
dGFibGUgZm9yIGFsbCBhcmNoaXRlY3R1cmVzLi4KPiDigKLigKLigKLigKLigKLigKLigKLigKLi
gKLigKLigKLigKIKCkkgZGlkIHJlYWxpemUgYWZ0ZXJ3YXJkIHRoYXQgcHJlZmV0Y2h3IGdldHMg
dGhlIGNhY2hlbGluZSBpbiBleGNsdXNpdmUgCnN0YXRlLiBJIHdpbGwgc3VnZ2VzdCB5b3UgbWVu
dGlvbiB0aGF0IGluIHlvdXIgY29tbWl0IGxvZyBhcyB3ZWxsIGFzIAphZGRpbmcgYSBjb21tZW50
IGFib3V0IGl0cyBwdXJwb3NlIGluIHRoZSBjb2RlLgoKVGhhbmtzLApMb25nbWFuCgo+PiBDaGVl
cnMsCj4+IExvbmdtYW4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
