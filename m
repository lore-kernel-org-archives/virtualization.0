Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33343EEAA5C
	for <virtualization@archiver.kernel.org>; Thu, 14 Sep 2023 17:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E50F40A9B;
	Thu, 14 Sep 2023 17:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E50F40A9B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJmOD/88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ovGaQ_EWcTE; Thu, 14 Sep 2023 17:24:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE985417FF;
	Thu, 14 Sep 2023 17:24:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE985417FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5DFBC0039;
	Thu, 14 Sep 2023 17:24:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89AF7C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 17:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6229D81DF0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 17:24:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6229D81DF0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJmOD/88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RJUCrmAYvAy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 17:24:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0874A82DDE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 17:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0874A82DDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694712244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0ikbkJVQghcPjJgsQrA+sUTUrPSvE6Jh+YB8KXgR/g=;
 b=KJmOD/88T422PBzboRwnW504Jp6pE+MiqqDJa5iMDT6yq/yc2w/jmwxzmGjZdxfdo2PXCi
 Et4n6Qncl+t3KE39sXNBdQvyP1sXAInEjFzEfTUUTc5N3W7sveE6NTl/5D6kf1ywgve25v
 Vd4/b0jJYLsZajjNjPMMacF+5mBLcOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-mt1uKXGTNm6m770irEEv9Q-1; Thu, 14 Sep 2023 13:24:02 -0400
X-MC-Unique: mt1uKXGTNm6m770irEEv9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1F4684ACAA;
 Thu, 14 Sep 2023 17:24:00 +0000 (UTC)
Received: from [10.22.34.133] (unknown [10.22.34.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5003640C2070;
 Thu, 14 Sep 2023 17:23:57 +0000 (UTC)
Message-ID: <fb7d6e67-f396-dfe7-1461-8790bdeaad01@redhat.com>
Date: Thu, 14 Sep 2023 13:23:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 07/17] riscv: qspinlock: Introduce qspinlock param for
 command line
Content-Language: en-US
To: Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-8-guoren@kernel.org>
 <5ba0b8f3-f8f5-3a25-e9b7-f29a1abe654a@redhat.com>
 <CAJF2gTT2hRxgnQt+WJ9P0YBWnUaZJ1-9g3ZE9tOz_MiLSsUjwQ@mail.gmail.com>
 <ZQK2-CIL9U_QdMjh@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZQK2-CIL9U_QdMjh@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

T24gOS8xNC8yMyAwMzozMiwgTGVvbmFyZG8gQnJhcyB3cm90ZToKPiBPbiBUdWUsIFNlcCAxMiwg
MjAyMyBhdCAwOTowODozNEFNICswODAwLCBHdW8gUmVuIHdyb3RlOgo+PiBPbiBNb24sIFNlcCAx
MSwgMjAyMyBhdCAxMTozNOKAr1BNIFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pj4gT24gOS8xMC8yMyAwNDoyOSwgZ3VvcmVuQGtlcm5lbC5vcmcgd3JvdGU6Cj4+Pj4g
RnJvbTogR3VvIFJlbiA8Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4+Cj4+Pj4gQWxsb3cg
Y21kbGluZSB0byBmb3JjZSB0aGUga2VybmVsIHRvIHVzZSBxdWV1ZWRfc3BpbmxvY2sgd2hlbgo+
Pj4+IENPTkZJR19SSVNDVl9DT01CT19TUElOTE9DS1M9eS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEd1byBSZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNvbT4KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4KPj4+PiAtLS0KPj4+PiAgICBEb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8ICAyICsrCj4+Pj4gICAgYXJj
aC9yaXNjdi9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxNiArKysrKysr
KysrKysrKystCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5l
bC1wYXJhbWV0ZXJzLnR4dAo+Pj4+IGluZGV4IDdkZmI1NDBjNGY2Yy4uNjFjYWNiOGRmZDBlIDEw
MDY0NAo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRl
cnMudHh0Cj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1l
dGVycy50eHQKPj4+PiBAQCAtNDY5Myw2ICs0NjkzLDggQEAKPj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgIFtLTkxdIE51bWJlciBvZiBsZWdhY3kgcHR5J3MuIE92ZXJ3cml0ZXMgY29tcGlsZWQt
aW4KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQgbnVtYmVyLgo+Pj4+Cj4+Pj4g
KyAgICAgcXNwaW5sb2NrICAgICAgIFtSSVNDVl0gRm9yY2UgdG8gdXNlIHFzcGlubG9jayBvciBh
dXRvLWRldGVjdCBzcGlubG9jay4KPj4+PiArCj4+Pj4gICAgICAgIHFzcGlubG9jay5udW1hX3Nw
aW5sb2NrX3RocmVzaG9sZF9ucz0gICBbTlVNQSwgUFZfT1BTXQo+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgU2V0IHRoZSB0aW1lIHRocmVzaG9sZCBpbiBuYW5vc2Vjb25kcyBmb3IgdGhlCj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICBudW1iZXIgb2YgaW50cmEtbm9kZSBsb2NrIGhhbmQt
b2ZmcyBiZWZvcmUgdGhlCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3NldHVw
LmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5jCj4+Pj4gaW5kZXggYTQ0N2NmMzYwYTE4Li4w
ZjA4NGYwMzc2NTEgMTAwNjQ0Cj4+Pj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYwo+
Pj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL3NldHVwLmMKPj4+PiBAQCAtMjcwLDYgKzI3MCwx
NSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgcGFyc2VfZHRiKHZvaWQpCj4+Pj4gICAgfQo+Pj4+Cj4+
Pj4gICAgI2lmZGVmIENPTkZJR19SSVNDVl9DT01CT19TUElOTE9DS1MKPj4+PiArYm9vbCBlbmFi
bGVfcXNwaW5sb2NrX2tleSA9IGZhbHNlOwo+Pj4gWW91IGNhbiB1c2UgX19yb19hZnRlcl9pbml0
IHF1YWxpZmllciBmb3IgZW5hYmxlX3FzcGlubG9ja19rZXkuIEJUVywKPj4+IHRoaXMgaXMgbm90
IGEgc3RhdGljIGtleSwganVzdCBhIHNpbXBsZSBmbGFnLiBTbyB3aGF0IGlzIHRoZSBwb2ludCBv
Zgo+Pj4gdGhlIF9rZXkgc3VmZml4Pwo+PiBPa2F5LCBJIHdvdWxkIGNoYW5nZSBpdCB0bzoKPj4g
Ym9vbCBlbmFibGVfcXNwaW5sb2NrX2ZsYWcgX19yb19hZnRlcl9pbml0ID0gZmFsc2U7Cj4gSUlV
QywgdGhpcyBib29sIC8gZmxhZyBpcyB1c2VkIGluIGEgc2luZ2xlIGZpbGUsIHNvIGl0IG1ha2Vz
IHNlbnNlIGZvciBpdAo+IHRvIGJlIHN0YXRpYy4gQmVpbmcgc3RhdGljIG1lYW5zIGl0IGRvZXMg
bm90IG5lZWQgdG8gYmUgaW5pdGlhbGl6ZWQgdG8KPiBmYWxzZSwgYXMgaXQncyBzdGFuZGFyZCB0
byB6ZXJvLWZpbGwgdGhpcyBhcmVhcy4KPgo+IEFsc28sIHNpbmNlIGl0J3MgYSBib29sLCBpdCBk
b2VzIG5vdCBuZWVkIHRvIGJlIGNhbGxlZCBfZmxhZy4KPgo+IEkgd291bGQgZ28gd2l0aDoKPgo+
IHN0YXRpYyBib29sIGVuYWJsZV9xc3BpbmxvY2sgX19yb19hZnRlcl9pbml0OwoKSSBhY3R1YWxs
eSB3YXMgdGhpbmtpbmcgYWJvdXQgdGhlIHNhbWUgc3VnZ2VzdGlvbiB0byBhZGQgc3RhdGljLiBU
aGVuIEkgCnJlYWxpemVkIHRoYXQgdGhlIGZsYWcgd2FzIGFsc28gdXNlZCBpbiBhbm90aGVyIGZp
bGUgaW4gYSBsYXRlciBwYXRjaC4gCk9mIGNvdXJzZSwgaWYgaXQgdHVybnMgb3V0IHRoYXQgdGhp
cyBmbGFnIGlzIG5vIGxvbmdlciBuZWVkZWQgb3V0c2lkZSBvZiAKdGhpcyBmaWxlLCBpdCBzaG91
bGQgYmUgc3RhdGljLgoKQ2hlZXJzLApMb25nbWFuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
