Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA30EE0207
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 19:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99B8C416C0;
	Wed, 13 Sep 2023 19:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99B8C416C0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLSH4bcl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vze25BEJOB_W; Wed, 13 Sep 2023 19:32:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 04AEB40169;
	Wed, 13 Sep 2023 19:32:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04AEB40169
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C081BC0071;
	Wed, 13 Sep 2023 19:32:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE1BDC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 19:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9AA4160ED3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 19:32:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AA4160ED3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLSH4bcl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XGexvavOGl40
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 19:32:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9709C60760
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 19:32:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9709C60760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694633550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hr0iocCjf//0RhyjTv2/Yc2Az/JEnnVmtYVPY2/RBDU=;
 b=aLSH4bclwxxQznSyueRBs+IwstsW1xgFFyaolWRV2Zbq0OZYVk8780R8TwG2dSXRgnAAel
 Wtes0GevJRuQerbFwHT7Eix4L40mz7oNFHYBjzn3P0ZyZHCt7XESTcYu9b0hCHB8Te8qKA
 AqQLAKGJP8Nh0KpaJVEOncKOaQ4yu8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-rrV5uf9TM-OJdx_9e_fpbg-1; Wed, 13 Sep 2023 15:32:27 -0400
X-MC-Unique: rrV5uf9TM-OJdx_9e_fpbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78504801FA0;
 Wed, 13 Sep 2023 19:32:25 +0000 (UTC)
Received: from [10.18.17.156] (dhcp-17-156.bos.redhat.com [10.18.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4016140C6EBF;
 Wed, 13 Sep 2023 19:32:23 +0000 (UTC)
Message-ID: <1f02232b-2ffc-797c-2331-a164322594d2@redhat.com>
Date: Wed, 13 Sep 2023 15:32:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce
 ERRATA_THEAD_QSPINLOCK
Content-Language: en-US
To: Palmer Dabbelt <palmer@rivosinc.com>, sorear@fastmail.com
References: <mhng-ee184bd2-7666-402d-b0df-d484ed6d8236@palmer-ri-x1c9>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <mhng-ee184bd2-7666-402d-b0df-d484ed6d8236@palmer-ri-x1c9>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: guoren@linux.alibaba.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 peterz@infradead.org, Catalin Marinas <catalin.marinas@arm.com>,
 Bjorn Topel <bjorn@rivosinc.com>, virtualization@lists.linux-foundation.org,
 Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
 jszhang@kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, keescook@chromium.org,
 linux-arch@vger.kernel.org, anup@brainfault.org, linux-csky@vger.kernel.org,
 xiaoguang.xing@sophgo.com, mingo@redhat.com, greentime.hu@sifive.com,
 ajones@ventanamicro.com, alexghiti@rivosinc.com, paulmck@kernel.org,
 boqun.feng@gmail.com, rostedt@goodmis.org,
 Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
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

T24gOS8xMy8yMyAxNDo1NCwgUGFsbWVyIERhYmJlbHQgd3JvdGU6Cj4gT24gU3VuLCAwNiBBdWcg
MjAyMyAyMjoyMzozNCBQRFQgKC0wNzAwKSwgc29yZWFyQGZhc3RtYWlsLmNvbSB3cm90ZToKPj4g
T24gV2VkLCBBdWcgMiwgMjAyMywgYXQgMTI6NDYgUE0sIGd1b3JlbkBrZXJuZWwub3JnIHdyb3Rl
Ogo+Pj4gRnJvbTogR3VvIFJlbiA8Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4KPj4+IEFj
Y29yZGluZyB0byBxc3BpbmxvY2sgcmVxdWlyZW1lbnRzLCBSSVNDLVYgZ2l2ZXMgb3V0IGEgd2Vh
ayBMUi9TQwo+Pj4gZm9yd2FyZCBwcm9ncmVzcyBndWFyYW50ZWUgd2hpY2ggZG9lcyBub3Qgc2F0
aXNmeSBxc3BpbmxvY2suIEJ1dAo+Pj4gbWFueSB2ZW5kb3JzIGNvdWxkIHByb2R1Y2Ugc3Ryb25n
ZXIgZm9yd2FyZCBndWFyYW50ZWUgTFIvU0MgdG8KPj4+IGVuc3VyZSB0aGUgeGNoZ190YWlsIGNv
dWxkIGJlIGZpbmlzaGVkIGluIHRpbWUgb24gYW55IGtpbmQgb2YKPj4+IGhhcnQuIFQtSEVBRCBp
cyB0aGUgdmVuZG9yIHdoaWNoIGltcGxlbWVudHMgc3Ryb25nIGZvcndhcmQKPj4+IGd1YXJhbnRl
ZSBMUi9TQyBpbnN0cnVjdGlvbiBwYWlycywgc28gZW5hYmxlIHFzcGlubG9jayBmb3IgVC1IRUFE
Cj4+PiB3aXRoIGVycmF0YSBoZWxwLgo+Pj4KPj4+IFQtSEVBRCBlYXJseSB2ZXJzaW9uIG9mIHBy
b2Nlc3NvcnMgaGFzIHRoZSBtZXJnZSBidWZmZXIgZGVsYXkKPj4+IHByb2JsZW0sIHNvIHdlIG5l
ZWQgRVJSQVRBX1dSSVRFT05DRSB0byBzdXBwb3J0IHFzcGlubG9jay4KPj4+Cj4+PiBTaWduZWQt
b2ZmLWJ5OiBHdW8gUmVuIDxndW9yZW5AbGludXguYWxpYmFiYS5jb20+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4KPj4+IC0tLQo+Pj4gwqBhcmNoL3Jpc2N2
L0tjb25maWcuZXJyYXRhwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMyArKysrKysrKysr
KysrCj4+PiDCoGFyY2gvcmlzY3YvZXJyYXRhL3RoZWFkL2VycmF0YS5jwqDCoMKgwqDCoMKgIHwg
MjQgKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoGFyY2gvcmlzY3YvaW5jbHVkZS9hc20v
ZXJyYXRhX2xpc3QuaMKgwqAgfCAyMCArKysrKysrKysrKysrKysrKysrKwo+Pj4gwqBhcmNoL3Jp
c2N2L2luY2x1ZGUvYXNtL3ZlbmRvcmlkX2xpc3QuaCB8wqAgMyArKy0KPj4+IMKgYXJjaC9yaXNj
di9rZXJuZWwvY3B1ZmVhdHVyZS5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArKy0KPj4+IMKgNSBm
aWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcuZXJyYXRhIGIvYXJjaC9yaXNjdi9LY29uZmln
LmVycmF0YQo+Pj4gaW5kZXggNDc0NWE1YzU3ZTdjLi5lYjQzNjc3YjEzY2MgMTAwNjQ0Cj4+PiAt
LS0gYS9hcmNoL3Jpc2N2L0tjb25maWcuZXJyYXRhCj4+PiArKysgYi9hcmNoL3Jpc2N2L0tjb25m
aWcuZXJyYXRhCj4+PiBAQCAtOTYsNCArOTYsMTcgQEAgY29uZmlnIEVSUkFUQV9USEVBRF9XUklU
RV9PTkNFCj4+Pgo+Pj4gwqDCoMKgwqDCoMKgIElmIHlvdSBkb24ndCBrbm93IHdoYXQgdG8gZG8g
aGVyZSwgc2F5ICJZIi4KPj4+Cj4+PiArY29uZmlnIEVSUkFUQV9USEVBRF9RU1BJTkxPQ0sKPj4+
ICvCoMKgwqAgYm9vbCAiQXBwbHkgVC1IZWFkIHF1ZXVlZCBzcGlubG9jayBlcnJhdGEiCj4+PiAr
wqDCoMKgIGRlcGVuZHMgb24gRVJSQVRBX1RIRUFECj4+PiArwqDCoMKgIGRlZmF1bHQgeQo+Pj4g
K8KgwqDCoCBoZWxwCj4+PiArwqDCoMKgwqDCoCBUaGUgVC1IRUFEIEM5eHggcHJvY2Vzc29ycyBp
bXBsZW1lbnQgc3Ryb25nIGZ3ZCBndWFyYW50ZWUgCj4+PiBMUi9TQyB0bwo+Pj4gK8KgwqDCoMKg
wqAgbWF0Y2ggdGhlIHhjaGdfdGFpbCByZXF1aXJlbWVudCBvZiBxc3BpbmxvY2suCj4+PiArCj4+
PiArwqDCoMKgwqDCoCBUaGlzIHdpbGwgYXBwbHkgdGhlIFFTUElOTE9DSyBlcnJhdGEgdG8gaGFu
ZGxlIHRoZSBub24tc3RhbmRhcmQKPj4+ICvCoMKgwqDCoMKgIGJlaGF2aW9yIHZpYSB1c2luZyBx
c3BpbmxvY2sgaW5zdGVhZCBvZiB0aWNrZXRfbG9jay4KPj4+ICsKPj4+ICvCoMKgwqDCoMKgIElm
IHlvdSBkb24ndCBrbm93IHdoYXQgdG8gZG8gaGVyZSwgc2F5ICJZIi4KPj4KPj4gSWYgdGhpcyBp
cyB0byBiZSBhcHBsaWVkLCBJIHdvdWxkIGxpa2UgdG8gc2VlIGEgZGV0YWlsZWQgZXhwbGFuYXRp
b24gCj4+IHNvbWV3aGVyZSwKPj4gcHJlZmVyYWJseSB3aXRoIGNpdGF0aW9ucywgb2Y6Cj4+Cj4+
IChhKSBUaGUgbWVtb3J5IG1vZGVsIHJlcXVpcmVtZW50cyBmb3IgcXNwaW5sb2NrCgpUaGUgcGFy
dCBvZiBxc3BpbmxvY2sgdGhhdCBjYXVzZXMgcHJvYmxlbSB3aXRoIG1hbnkgUklTQyBhcmNoaXRl
Y3R1cmVzIAppcyBpdHMgdXNlIG9mIGEgMTYtYml0IHhjaGcoKSBmdW5jdGlvbiBjYWxsIHdoaWNo
IG1hbnkgUklTQyAKYXJjaGl0ZWN0dXJlcyBjYW5ub3QgZG8gaXQgbmF0aXZlbHkgYW5kIGhhdmUg
dG8gYmUgZW11bGF0ZWQgd2l0aCAKaG9wZWZ1bGx5IHNvbWUgZm9yd2FyZCBwcm9ncmVzcyBndWFy
YW50ZWUuIEV4Y2VwdCB0aGF0IG9uZSBjYWxsLCB0aGUgCm90aGVyIGF0b21pYyBvcGVyYXRpb25z
IGFyZSBhbGwgMzIgYml0IGluIHNpemUuCgpDaGVlcnMsCkxvbmdtYW4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
