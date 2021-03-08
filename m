Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC85C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:59:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4353E64FB7
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4353E64FB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03D6982FEA;
	Mon,  8 Mar 2021 03:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7wmffAmOC8y; Mon,  8 Mar 2021 03:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9789082FB1;
	Mon,  8 Mar 2021 03:59:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE90C000B;
	Mon,  8 Mar 2021 03:59:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE731C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE6C2430DC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6kZffzeW2_l
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:59:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1568942C2B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615175962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGiugw84K0yAazMlXfQCN5eRxZQb5KNF3VYCr/dWXMU=;
 b=iNSfz4ttEElqpYU8uo517VazVYO7+dyt8GsRQa818Iztu3qFfycT2iYcRDl1LyO6hc8aU1
 a/0f1uL2bzNnKOAngABzV3TynCdRST82re5bjTO/FSw5vxWmrPN7a1CL+oIVQtcJ8tcgyj
 pmqR19ZXjrUguwotOSoI7x8uPrbnwhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-oxtmNiEiPm-Tepl0IYgO_w-1; Sun, 07 Mar 2021 22:59:20 -0500
X-MC-Unique: oxtmNiEiPm-Tepl0IYgO_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7556226860;
 Mon,  8 Mar 2021 03:59:19 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F7B55B4B3;
 Mon,  8 Mar 2021 03:59:13 +0000 (UTC)
Subject: Re: [RFC PATCH 10/10] vhost/vdpa: return configuration bytes read and
 written to user space
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-11-sgarzare@redhat.com>
 <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
 <20210302140654.ybmjqui5snp5wxym@steredhat>
 <5cf852b1-1279-20e9-516d-30f876e0162d@redhat.com>
 <20210305083712.atfrlpq6bkjrf6pd@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ec8dba28-820b-4948-999e-439e268b536c@redhat.com>
Date: Mon, 8 Mar 2021 11:59:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305083712.atfrlpq6bkjrf6pd@steredhat>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMy81IDQ6Mzcg5LiL5Y2ILCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
VGh1LCBNYXIgMDQsIDIwMjEgYXQgMDQ6MzE6MjJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4KPj4gT24gMjAyMS8zLzIgMTA6MDYg5LiL5Y2ILCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+PiBPbiBUdWUsIE1hciAwMiwgMjAyMSBhdCAxMjowNTozNVBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMS8yLzE2IDU6NDQg5LiL5Y2ILCBTdGVmYW5vIEdhcnph
cmVsbGEgd3JvdGU6Cj4+Pj4+IHZkcGFfZ2V0X2NvbmZpZygpIGFuZCB2ZHBhX3NldF9jb25maWco
KSBub3cgcmV0dXJuIHRoZSBhbW91bnQKPj4+Pj4gb2YgYnl0ZXMgcmVhZCBhbmQgd3JpdHRlbiwg
c28gbGV0J3MgcmV0dXJuIHRoZW0gdG8gdGhlIHVzZXIgc3BhY2UuCj4+Pj4+Cj4+Pj4+IFdlIGFs
c28gbW9kaWZ5IHZob3N0X3ZkcGFfY29uZmlnX3ZhbGlkYXRlKCkgdG8gcmV0dXJuIDAgKGJ5dGVz
IHJlYWQKPj4+Pj4gb3Igd3JpdHRlbikgaW5zdGVhZCBvZiBhbiBlcnJvciwgd2hlbiB0aGUgYnVm
ZmVyIGxlbmd0aCBpcyAwLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnph
cmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoGRyaXZlcnMvdmhv
c3QvdmRwYS5jIHwgMjYgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPj4+Pj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+
Pj4+IGluZGV4IDIxZWVhMmJlNWFmYS4uYjc1NGM1MzE3MWE3IDEwMDY0NAo+Pj4+PiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+
PiBAQCAtMTkxLDkgKzE5MSw2IEBAIHN0YXRpYyBzc2l6ZV90IAo+Pj4+PiB2aG9zdF92ZHBhX2Nv
bmZpZ192YWxpZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+Pj4gwqDCoMKgwqAgc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4+Pj4gwqDCoMKgwqAgdTMyIHNpemUgPSB2
ZHBhLT5jb25maWctPmdldF9jb25maWdfc2l6ZSh2ZHBhKTsKPj4+Pj4gLcKgwqDCoCBpZiAoYy0+
bGVuID09IDApCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+Pj4gLQo+
Pj4+PiDCoMKgwqDCoCByZXR1cm4gbWluKGMtPmxlbiwgc2l6ZSk7Cj4+Pj4+IMKgfQo+Pj4+PiBA
QCAtMjA0LDYgKzIwMSw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1
Y3QgCj4+Pj4+IHZob3N0X3ZkcGEgKnYsCj4+Pj4+IMKgwqDCoMKgIHN0cnVjdCB2aG9zdF92ZHBh
X2NvbmZpZyBjb25maWc7Cj4+Pj4+IMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgc2l6ZSA9IG9mZnNl
dG9mKHN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZywgYnVmKTsKPj4+Pj4gwqDCoMKgwqAgc3NpemVf
dCBjb25maWdfc2l6ZTsKPj4+Pj4gK8KgwqDCoCBsb25nIHJldDsKPj4+Pj4gwqDCoMKgwqAgdTgg
KmJ1ZjsKPj4+Pj4gwqDCoMKgwqAgaWYgKGNvcHlfZnJvbV91c2VyKCZjb25maWcsIGMsIHNpemUp
KQo+Pj4+PiBAQCAtMjE3LDE1ICsyMTUsMTggQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRf
Y29uZmlnKHN0cnVjdCAKPj4+Pj4gdmhvc3RfdmRwYSAqdiwKPj4+Pj4gwqDCoMKgwqAgaWYgKCFi
dWYpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+Pj4+IC3CoMKgwqAg
dmRwYV9nZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1ZiwgY29uZmlnX3NpemUpOwo+Pj4+
PiAtCj4+Pj4+IC3CoMKgwqAgaWYgKGNvcHlfdG9fdXNlcihjLT5idWYsIGJ1ZiwgY29uZmlnX3Np
emUpKSB7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBrdmZyZWUoYnVmKTsKPj4+Pj4gLcKgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUZBVUxUOwo+Pj4+PiArwqDCoMKgIHJldCA9IHZkcGFfZ2V0X2NvbmZp
Zyh2ZHBhLCBjb25maWcub2ZmLCBidWYsIGNvbmZpZ19zaXplKTsKPj4+Pj4gK8KgwqDCoCBpZiAo
cmV0IDwgMCkgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVGQVVMVDsKPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pj4+PiDCoMKgwqDCoCB9Cj4+Pj4+ICvCoMKgwqAgaWYg
KGNvcHlfdG9fdXNlcihjLT5idWYsIGJ1ZiwgY29uZmlnX3NpemUpKQo+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0ID0gLUVGQVVMVDsKPj4+Pj4gKwo+Pj4+PiArb3V0Ogo+Pj4+PiDCoMKgwqDCoCBr
dmZyZWUoYnVmKTsKPj4+Pj4gLcKgwqDCoCByZXR1cm4gMDsKPj4+Pj4gK8KgwqDCoCByZXR1cm4g
cmV0Owo+Pj4+PiDCoH0KPj4+Pj4gwqBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9jb25maWco
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+Pj4+IEBAIC0yMzUsNiArMjM2LDcgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV9zZXRfY29uZmlnKHN0cnVjdCAKPj4+Pj4gdmhvc3RfdmRwYSAqdiwKPj4+
Pj4gwqDCoMKgwqAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnIGNvbmZpZzsKPj4+Pj4gwqDCoMKg
wqAgdW5zaWduZWQgbG9uZyBzaXplID0gb2Zmc2V0b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmln
LCBidWYpOwo+Pj4+PiDCoMKgwqDCoCBzc2l6ZV90IGNvbmZpZ19zaXplOwo+Pj4+PiArwqDCoMKg
IGxvbmcgcmV0Owo+Pj4+PiDCoMKgwqDCoCB1OCAqYnVmOwo+Pj4+PiDCoMKgwqDCoCBpZiAoY29w
eV9mcm9tX3VzZXIoJmNvbmZpZywgYywgc2l6ZSkpCj4+Pj4+IEBAIC0yNDgsMTAgKzI1MCwxMiBA
QCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9jb25maWcoc3RydWN0IAo+Pj4+PiB2aG9zdF92
ZHBhICp2LAo+Pj4+PiDCoMKgwqDCoCBpZiAoSVNfRVJSKGJ1ZikpCj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIFBUUl9FUlIoYnVmKTsKPj4+Pj4gLcKgwqDCoCB2ZHBhX3NldF9jb25maWco
dmRwYSwgY29uZmlnLm9mZiwgYnVmLCBjb25maWdfc2l6ZSk7Cj4+Pj4+ICvCoMKgwqAgcmV0ID0g
dmRwYV9zZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1ZiwgY29uZmlnX3NpemUpOwo+Pj4+
PiArwqDCoMKgIGlmIChyZXQgPCAwKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVGQVVM
VDsKPj4+Pj4gwqDCoMKgwqAga3ZmcmVlKGJ1Zik7Cj4+Pj4+IC3CoMKgwqAgcmV0dXJuIDA7Cj4+
Pj4+ICvCoMKgwqAgcmV0dXJuIHJldDsKPj4+Pj4gwqB9Cj4+Pj4KPj4+Pgo+Pj4+IFNvIEkgd29u
ZGVyIHdoZXRoZXIgaXQncyB3b3J0aCB0byByZXR1cm4gdGhlIG51bWJlciBvZiBieXRlcyBzaW5j
ZSAKPj4+PiB3ZSBjYW4ndCBwcm9wb2dhdGUgdGhlIHJlc3VsdCB0byBkcml2ZXIgb3IgZHJpdmVy
IGRvZXNuJ3QgY2FyZSAKPj4+PiBhYm91dCB0aGF0Lgo+Pj4KPj4+IE9rYXksIGJ1dCBJSVVDIHVz
ZXIgc3BhY2UgYXBwbGljYXRpb24gdGhhdCBpc3N1ZSAKPj4+IFZIT1NUX1ZEUEFfR0VUX0NPTkZJ
RyBpb2N0bCBjYW4gdXNlIHRoZSByZXR1cm4gdmFsdWUuCj4+Cj4+Cj4+IFllcywgYnV0IGl0IGxv
b2tzIHRvIGl0J3MgdG9vIGxhdGUgdG8gY2hhbmdlIHNpbmNlIGl0J3MgYSB1c2Vyc3BhY2UgCj4+
IG5vdGljYmxlIGJlaGF2aW91ci4KPgo+IFllYWgsIHRoaXMgaXMgYSBnb29kIHBvaW50Lgo+IEkg
bG9va2VkIGF0IFFFTVUgYW5kIHdlIG9ubHkgY2hlY2sgaWYgdGhlIHZhbHVlIGlzIG5vdCBuZWdh
dGl2ZSwgc28gaXQgCj4gc2hvdWxkIHdvcmssIGJ1dCBmb3Igb3RoZXIgYXBwbGljYXRpb25zIGl0
IGNvdWxkIGJlIGEgcmVhbCBjaGFuZ2UuCj4KPiBEbyB3ZSBsZWF2ZSBpdCBhcyBpcz8KCgpZZXMs
IEkgdGhpbmsgd2UnZCBiZXR0ZXIgYmUgY29uc2VydmF0aXZlIGhlcmUuCgpUaGFua3MKCgo+Cj4+
Cj4+Cj4+Pgo+Pj4gU2hvdWxkIHdlIGNoYW5nZSBhbHNvICdzdHJ1Y3QgdmlydGlvX2NvbmZpZ19v
cHMnIHRvIHByb3BhZ2F0ZSB0aGlzIAo+Pj4gdmFsdWUgYWxzbyB0byB2aXJ0aW8gZHJpdmVycz8K
Pj4KPj4KPj4gSSB0aGluayBub3QsIHRoZSByZWFzb24gaXMgdGhlIGRyaXZlciBkb2Vzbid0IGV4
cGVjdCB0aGUgZ2V0KCkvc2V0KCkgCj4+IGNhbiBmYWlsLi4uCj4KPiBHb3QgaXQuCj4KPiBUaGFu
a3MsCj4gU3RlZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
