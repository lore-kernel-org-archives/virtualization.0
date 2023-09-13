Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17A1EDEC50
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 13:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EC0C41D5F;
	Wed, 13 Sep 2023 13:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EC0C41D5F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T9eY3mOD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXSKXSoR6hwU; Wed, 13 Sep 2023 13:06:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 32133418BC;
	Wed, 13 Sep 2023 13:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32133418BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F30E8C0039;
	Wed, 13 Sep 2023 13:06:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9816CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 607D940586
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:06:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 607D940586
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T9eY3mOD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6IVKIeEI676
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:06:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FEAB400C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:06:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FEAB400C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694610407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N8nXpfMCNYLFwc5DqM2IQ2ttQ6FxXsVgYdelfbJc5Y=;
 b=T9eY3mODb/4Jr7k0DOfaEKR0YP+59bxDxTVLT9rdri9zvh0GZdUPHyLOGr0Z+9ksgXCuXh
 eXIQTQcxrse1G/0U0CO6ho7entgPHDCmBQmQJtquQsdowuaQ0Y0BaNqOtLwFIGkzflEw14
 lW60X+9MkzYFsZOZZENFNyjmv6kvMYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-QRcYUWmXNfChTXcc_wePhw-1; Wed, 13 Sep 2023 09:06:42 -0400
X-MC-Unique: QRcYUWmXNfChTXcc_wePhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B7A2101FAA1;
 Wed, 13 Sep 2023 13:06:41 +0000 (UTC)
Received: from [10.22.32.174] (unknown [10.22.32.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A80792904;
 Wed, 13 Sep 2023 13:06:37 +0000 (UTC)
Message-ID: <0ea8d0e7-6447-3a60-8cf4-d6a4e89fa8be@redhat.com>
Date: Wed, 13 Sep 2023 09:06:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number
 of cpus >= 16k
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>, Leonardo Bras <leobras@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
 <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
 <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com>
 <CAJF2gTQ3Q7f+FGorVTR66c6TGWsSeeKVvLF+LH1_m3kSHrm0yA@mail.gmail.com>
 <ZQF49GIZoFceUGYH@redhat.com>
 <CAJF2gTTHdCr-FQVSGUc+LapkJPmDiEYYa_1P6T86uCjRujgnTg@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJF2gTTHdCr-FQVSGUc+LapkJPmDiEYYa_1P6T86uCjRujgnTg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: Guo Ren <guoren@linux.alibaba.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 bjorn@rivosinc.com, palmer@rivosinc.com,
 virtualization@lists.linux-foundation.org, conor.dooley@microchip.com,
 jszhang@kernel.org, linux-riscv@lists.infradead.org, will@kernel.org,
 keescook@chromium.org, linux-arch@vger.kernel.org, anup@brainfault.org,
 linux-csky@vger.kernel.org, xiaoguang.xing@sophgo.com, mingo@redhat.com,
 greentime.hu@sifive.com, ajones@ventanamicro.com, alexghiti@rivosinc.com,
 paulmck@kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 paul.walmsley@sifive.com, tglx@linutronix.de, rdunlap@infradead.org,
 wuwei2016@iscas.ac.cn, wefu@redhat.com
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

T24gOS8xMy8yMyAwODo1MiwgR3VvIFJlbiB3cm90ZToKPiBPbiBXZWQsIFNlcCAxMywgMjAyMyBh
dCA0OjU14oCvUE0gTGVvbmFyZG8gQnJhcyA8bGVvYnJhc0ByZWRoYXQuY29tPiB3cm90ZToKPj4g
T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMDk6MTA6MDhBTSArMDgwMCwgR3VvIFJlbiB3cm90ZToK
Pj4+IE9uIE1vbiwgU2VwIDExLCAyMDIzIGF0IDk6MDPigK9QTSBXYWltYW4gTG9uZyA8bG9uZ21h
bkByZWRoYXQuY29tPiB3cm90ZToKPj4+PiBPbiA5LzEwLzIzIDIzOjA5LCBHdW8gUmVuIHdyb3Rl
Ogo+Pj4+PiBPbiBNb24sIFNlcCAxMSwgMjAyMyBhdCAxMDozNeKAr0FNIFdhaW1hbiBMb25nIDxs
b25nbWFuQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4gT24gOS8xMC8yMyAwNDoyOCwgZ3VvcmVu
QGtlcm5lbC5vcmcgd3JvdGU6Cj4+Pj4+Pj4gRnJvbTogR3VvIFJlbiA8Z3VvcmVuQGxpbnV4LmFs
aWJhYmEuY29tPgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhlIHRhcmdldCBvZiB4Y2hnX3RhaWwgaXMgdG8g
d3JpdGUgdGhlIHRhaWwgdG8gdGhlIGxvY2sgdmFsdWUsIHNvCj4+Pj4+Pj4gYWRkaW5nIHByZWZl
dGNodyBjb3VsZCBoZWxwIHRoZSBuZXh0IGNtcHhjaGcgc3RlcCwgd2hpY2ggbWF5Cj4+Pj4+Pj4g
ZGVjcmVhc2UgdGhlIGNtcHhjaGcgcmV0cnkgbG9vcHMgb2YgeGNoZ190YWlsLiBTb21lIHByb2Nl
c3NvcnMgbWF5Cj4+Pj4+Pj4gdXRpbGl6ZSB0aGlzIGZlYXR1cmUgdG8gZ2l2ZSBhIGZvcndhcmQg
Z3VhcmFudGVlLCBlLmcuLCBSSVNDLVYKPj4+Pj4+PiBYdWFuVGllIHByb2Nlc3NvcnMgd291bGQg
YmxvY2sgdGhlIHNub29wIGNoYW5uZWwgJiBpcnEgZm9yIHNldmVyYWwKPj4+Pj4+PiBjeWNsZXMg
d2hlbiBwcmVmZXRjaC53IGluc3RydWN0aW9uIChmcm9tIFppY2JvcCBleHRlbnNpb24pIHJldGly
ZWQsCj4+Pj4+Pj4gd2hpY2ggZ3VhcmFudGVlcyB0aGUgbmV4dCBjbXB4Y2hnIHN1Y2NlZWRzLgo+
Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogR3VvIFJlbiA8Z3VvcmVuQGxpbnV4LmFsaWJh
YmEuY29tPgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3Jn
Pgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+ICAgICBrZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYyB8IDUg
KysrKy0KPj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9sb2NraW5nL3FzcGlu
bG9jay5jIGIva2VybmVsL2xvY2tpbmcvcXNwaW5sb2NrLmMKPj4+Pj4+PiBpbmRleCBkM2Y5OTA2
MGI2MGYuLjk2YjU0ZTJhZGU4NiAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9rZXJuZWwvbG9ja2luZy9x
c3BpbmxvY2suYwo+Pj4+Pj4+ICsrKyBiL2tlcm5lbC9sb2NraW5nL3FzcGlubG9jay5jCj4+Pj4+
Pj4gQEAgLTIyMyw3ICsyMjMsMTAgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGNsZWFy
X3BlbmRpbmdfc2V0X2xvY2tlZChzdHJ1Y3QgcXNwaW5sb2NrICpsb2NrKQo+Pj4+Pj4+ICAgICAg
Ki8KPj4+Pj4+PiAgICAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB1MzIgeGNoZ190YWlsKHN0cnVj
dCBxc3BpbmxvY2sgKmxvY2ssIHUzMiB0YWlsKQo+Pj4+Pj4+ICAgICB7Cj4+Pj4+Pj4gLSAgICAg
dTMyIG9sZCwgbmV3LCB2YWwgPSBhdG9taWNfcmVhZCgmbG9jay0+dmFsKTsKPj4+Pj4+PiArICAg
ICB1MzIgb2xkLCBuZXcsIHZhbDsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgICAgcHJlZmV0Y2h3KCZs
b2NrLT52YWwpOwo+Pj4+Pj4+ICsgICAgIHZhbCA9IGF0b21pY19yZWFkKCZsb2NrLT52YWwpOwo+
Pj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICBmb3IgKDs7KSB7Cj4+Pj4+Pj4gICAgICAgICAgICAgICAg
IG5ldyA9ICh2YWwgJiBfUV9MT0NLRURfUEVORElOR19NQVNLKSB8IHRhaWw7Cj4+Pj4+PiBUaGF0
IGxvb2tzIGEgYml0IHdlaXJkLiBZb3UgcHJlLWZldGNoIGFuZCB0aGVuIGltbWVkaWF0ZWx5IHJl
YWQgaXQuIEhvdwo+Pj4+Pj4gbXVjaCBwZXJmb3JtYW5jZSBnYWluIHlvdSBnZXQgYnkgdGhpcyBj
aGFuZ2UgYWxvbmU/Cj4+Pj4+Pgo+Pj4+Pj4gTWF5YmUgeW91IGNhbiBkZWZpbmUgYW4gYXJjaCBz
cGVjaWZpYyBwcmltaXRpdmUgdGhhdCBkZWZhdWx0IGJhY2sgdG8KPj4+Pj4+IGF0b21pY19yZWFk
KCkgaWYgbm90IGRlZmluZWQuCj4+Pj4+IFRoeCBmb3IgdGhlIHJlcGx5LiBUaGlzIGlzIGEgZ2Vu
ZXJpYyBvcHRpbWl6YXRpb24gcG9pbnQgSSB3b3VsZCBsaWtlCj4+Pj4+IHRvIHRhbGsgYWJvdXQg
d2l0aCB5b3UuCj4+Pj4+Cj4+Pj4+IEZpcnN0LCBwcmVmZXRjaHcoKSBtYWtlcyBjYWNoZWxpbmUg
YW4gZXhjbHVzaXZlIHN0YXRlIGFuZCBzZXJ2ZXMgZm9yCj4+Pj4+IHRoZSBuZXh0IGNtcHhjaGcg
bG9vcCBzZW1hbnRpYywgd2hpY2ggd3JpdGVzIHRoZSBpZHhfdGFpbCBwYXJ0IG9mCj4+Pj4+IGFy
Y2hfc3Bpbl9sb2NrLiBUaGUgYXRvbWljX3JlYWQgb25seSBtYWtlcyBjYWNoZWxpbmUgaW4gdGhl
IHNoYXJlZAo+Pj4+PiBzdGF0ZSwgd2hpY2ggY291bGRuJ3QgZ2l2ZSBhbnkgZ3VhcmFudGVlIGZv
ciB0aGUgbmV4dCBjbXB4Y2hnIGxvb3AKPj4+Pj4gc2VtYW50aWMuIE1pY3JvLWFyY2hpdGVjdHVy
ZSBjb3VsZCB1dGlsaXplIHByZWZldGNodygpIHRvIHByb3ZpZGUgYQo+Pj4+PiBzdHJvbmcgZm9y
d2FyZCBwcm9ncmVzcyBndWFyYW50ZWUgZm9yIHRoZSB4Y2hnX3RhaWwsIGUuZy4sIHRoZSBULUhF
QUQKPj4+Pj4gWHVhblRpZSBwcm9jZXNzb3Igd291bGQgaG9sZCB0aGUgZXhjbHVzaXZlIGNhY2hl
bGluZSBzdGF0ZSB1bnRpbCB0aGUKPj4+Pj4gbmV4dCBjbXB4Y2hnIHdyaXRlIHN1Y2Nlc3MuCj4+
Pj4+Cj4+Pj4+IEluIHRoZSBlbmQsIExldCdzIGdvIGJhY2sgdG8gdGhlIHByaW5jaXBsZTogdGhl
IHhjaGdfdGFpbCBpcyBhbiBhdG9taWMKPj4+Pj4gc3dhcCBvcGVyYXRpb24gdGhhdCBjb250YWlu
cyB3cml0ZSBldmVudHVhbGx5LCBzbyBnaXZpbmcgYSBwcmVmZXRjaHcoKQo+Pj4+PiBhdCB0aGUg
YmVnaW5uaW5nIGlzIGFjY2VwdGFibGUgZm9yIGFsbCBhcmNoaXRlY3R1cmVzLi4KPj4+Pj4g4oCi
4oCi4oCi4oCi4oCi4oCi4oCi4oCi4oCi4oCi4oCi4oCiCj4+Pj4gSSBkaWQgcmVhbGl6ZSBhZnRl
cndhcmQgdGhhdCBwcmVmZXRjaHcgZ2V0cyB0aGUgY2FjaGVsaW5lIGluIGV4Y2x1c2l2ZQo+Pj4+
IHN0YXRlLiBJIHdpbGwgc3VnZ2VzdCB5b3UgbWVudGlvbiB0aGF0IGluIHlvdXIgY29tbWl0IGxv
ZyBhcyB3ZWxsIGFzCj4+Pj4gYWRkaW5nIGEgY29tbWVudCBhYm91dCBpdHMgcHVycG9zZSBpbiB0
aGUgY29kZS4KPj4+IE9rYXksIEkgd291bGQgZG8gdGhhdCBpbiB2MTIsIHRoeC4KPj4gSSB3b3Vs
ZCBzdWdnZXN0IGFkZGluZyBhIHNuaXBwZXQgZnJvbSB0aGUgSVNBIEV4dGVuc3Rpb24gZG9jOgo+
Pgo+PiAiQSBwcmVmZXRjaC53IGluc3RydWN0aW9uIGluZGljYXRlcyB0byBoYXJkd2FyZSB0aGF0
IHRoZSBjYWNoZSBibG9jayB3aG9zZQo+PiBlZmZlY3RpdmUgYWRkcmVzcyBpcyB0aGUgc3VtIG9m
IHRoZSBiYXNlIGFkZHJlc3Mgc3BlY2lmaWVkIGluIHJzMSBhbmQgdGhlCj4+IHNpZ24tZXh0ZW5k
ZWQgb2Zmc2V0IGVuY29kZWQgaW4gaW1tWzExOjBdLCB3aGVyZSBpbW1bNDowXSBlcXVhbHMgMGIw
MDAwMCwKPj4gaXMgbGlrZWx5IHRvIGJlIGFjY2Vzc2VkIGJ5IGEgZGF0YSB3cml0ZSAoaS5lLiBz
dG9yZSkgaW4gdGhlIG5lYXIgZnV0dXJlLiIKPiBHb29kIHBvaW50LCB0aHguCgpxc3BpbmxvY2sg
aXMgZ2VuZXJpYyBjb2RlLiBJIHN1cHBvc2UgdGhpcyBpcyBmb3IgdGhlIFJJU0NWIGFyY2hpdGVj
dHVyZS4gCllvdSBjYW4gbWVudGlvbiB0aGF0IGluIHRoZSBjb21taXQgbG9nIGFzIGFuIGV4YW1w
bGUsIGJ1dCBJIHByZWZlciBtb3JlIApnZW5lcmljIGNvbW1lbnQgZXNwZWNpYWxseSBpbiB0aGUg
Y29kZS4KCkNoZWVycywKTG9uZ21hbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
