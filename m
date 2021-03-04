Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B4DC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 08:31:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2DD64E41
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 08:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2DD64E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D7AE4EBF7;
	Thu,  4 Mar 2021 08:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MVhtqL6leQ48; Thu,  4 Mar 2021 08:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 685FE4EBF5;
	Thu,  4 Mar 2021 08:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A78AC000A;
	Thu,  4 Mar 2021 08:31:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D952BC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC72B431CA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Ajcs3bza-KN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:31:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40150430BC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614846700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIgimn0UIHHj/HcSM5k1NV19AV4eDUyhIzCAKNQZCBo=;
 b=UfGtzi/5Kq648j24PXD/7oAFpRbwLgAvobrtea3y8w6eiQaQqbTWzkZVVM0+U/Rzms0fCU
 WP2bDxeu8KBoYlbd+54gvb9ukM4JR859YbB8QA4Iokgi/Nz+qdT2BZTVmSI2elufKC+Txt
 TbkL9d/faW4CEgg2DFvPpEdOQbwIgA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-s5snE4gtMi-DtQ6TIJq10Q-1; Thu, 04 Mar 2021 03:31:37 -0500
X-MC-Unique: s5snE4gtMi-DtQ6TIJq10Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FFC01009E25;
 Thu,  4 Mar 2021 08:31:36 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-64.pek2.redhat.com
 [10.72.12.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1AB55C304;
 Thu,  4 Mar 2021 08:31:23 +0000 (UTC)
Subject: Re: [RFC PATCH 10/10] vhost/vdpa: return configuration bytes read and
 written to user space
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-11-sgarzare@redhat.com>
 <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
 <20210302140654.ybmjqui5snp5wxym@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5cf852b1-1279-20e9-516d-30f876e0162d@redhat.com>
Date: Thu, 4 Mar 2021 16:31:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302140654.ybmjqui5snp5wxym@steredhat>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjEvMy8yIDEwOjA2IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9u
IFR1ZSwgTWFyIDAyLCAyMDIxIGF0IDEyOjA1OjM1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Cj4+IE9uIDIwMjEvMi8xNiA1OjQ0IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pj4gdmRwYV9nZXRfY29uZmlnKCkgYW5kIHZkcGFfc2V0X2NvbmZpZygpIG5vdyByZXR1cm4g
dGhlIGFtb3VudAo+Pj4gb2YgYnl0ZXMgcmVhZCBhbmQgd3JpdHRlbiwgc28gbGV0J3MgcmV0dXJu
IHRoZW0gdG8gdGhlIHVzZXIgc3BhY2UuCj4+Pgo+Pj4gV2UgYWxzbyBtb2RpZnkgdmhvc3RfdmRw
YV9jb25maWdfdmFsaWRhdGUoKSB0byByZXR1cm4gMCAoYnl0ZXMgcmVhZAo+Pj4gb3Igd3JpdHRl
bikgaW5zdGVhZCBvZiBhbiBlcnJvciwgd2hlbiB0aGUgYnVmZmVyIGxlbmd0aCBpcyAwLgo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNv
bT4KPj4+IC0tLQo+Pj4gwqBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDI2ICsrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tCj4+PiDCoDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gaW5kZXggMjFlZWEyYmU1YWZhLi5iNzU0YzUzMTcxYTcg
MTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92
aG9zdC92ZHBhLmMKPj4+IEBAIC0xOTEsOSArMTkxLDYgQEAgc3RhdGljIHNzaXplX3Qgdmhvc3Rf
dmRwYV9jb25maWdfdmFsaWRhdGUoc3RydWN0IAo+Pj4gdmhvc3RfdmRwYSAqdiwKPj4+IMKgwqDC
oMKgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+PiDCoMKgwqDCoCB1MzIg
c2l6ZSA9IHZkcGEtPmNvbmZpZy0+Z2V0X2NvbmZpZ19zaXplKHZkcGEpOwo+Pj4gLcKgwqDCoCBp
ZiAoYy0+bGVuID09IDApCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiAt
Cj4+PiDCoMKgwqDCoCByZXR1cm4gbWluKGMtPmxlbiwgc2l6ZSk7Cj4+PiDCoH0KPj4+IEBAIC0y
MDQsNiArMjAxLDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCAK
Pj4+IHZob3N0X3ZkcGEgKnYsCj4+PiDCoMKgwqDCoCBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcg
Y29uZmlnOwo+Pj4gwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBzaXplID0gb2Zmc2V0b2Yoc3RydWN0
IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+Pj4gwqDCoMKgwqAgc3NpemVfdCBjb25maWdfc2l6
ZTsKPj4+ICvCoMKgwqAgbG9uZyByZXQ7Cj4+PiDCoMKgwqDCoCB1OCAqYnVmOwo+Pj4gwqDCoMKg
wqAgaWYgKGNvcHlfZnJvbV91c2VyKCZjb25maWcsIGMsIHNpemUpKQo+Pj4gQEAgLTIxNywxNSAr
MjE1LDE4IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgCj4+PiB2
aG9zdF92ZHBhICp2LAo+Pj4gwqDCoMKgwqAgaWYgKCFidWYpCj4+PiDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5PTUVNOwo+Pj4gLcKgwqDCoCB2ZHBhX2dldF9jb25maWcodmRwYSwgY29uZmln
Lm9mZiwgYnVmLCBjb25maWdfc2l6ZSk7Cj4+PiAtCj4+PiAtwqDCoMKgIGlmIChjb3B5X3RvX3Vz
ZXIoYy0+YnVmLCBidWYsIGNvbmZpZ19zaXplKSkgewo+Pj4gLcKgwqDCoMKgwqDCoMKgIGt2ZnJl
ZShidWYpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUZBVUxUOwo+Pj4gK8KgwqDCoCBy
ZXQgPSB2ZHBhX2dldF9jb25maWcodmRwYSwgY29uZmlnLm9mZiwgYnVmLCBjb25maWdfc2l6ZSk7
Cj4+PiArwqDCoMKgIGlmIChyZXQgPCAwKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVG
QVVMVDsKPj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4+IMKgwqDCoMKgIH0KPj4+ICvC
oMKgwqAgaWYgKGNvcHlfdG9fdXNlcihjLT5idWYsIGJ1ZiwgY29uZmlnX3NpemUpKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHJldCA9IC1FRkFVTFQ7Cj4+PiArCj4+PiArb3V0Ogo+Pj4gwqDCoMKgwqAg
a3ZmcmVlKGJ1Zik7Cj4+PiAtwqDCoMKgIHJldHVybiAwOwo+Pj4gK8KgwqDCoCByZXR1cm4gcmV0
Owo+Pj4gwqB9Cj4+PiDCoHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiwKPj4+IEBAIC0yMzUsNiArMjM2LDcgQEAgc3RhdGljIGxvbmcgdmhvc3Rf
dmRwYV9zZXRfY29uZmlnKHN0cnVjdCAKPj4+IHZob3N0X3ZkcGEgKnYsCj4+PiDCoMKgwqDCoCBz
dHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgY29uZmlnOwo+Pj4gwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBzaXplID0gb2Zmc2V0b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+Pj4gwqDC
oMKgwqAgc3NpemVfdCBjb25maWdfc2l6ZTsKPj4+ICvCoMKgwqAgbG9uZyByZXQ7Cj4+PiDCoMKg
wqDCoCB1OCAqYnVmOwo+Pj4gwqDCoMKgwqAgaWYgKGNvcHlfZnJvbV91c2VyKCZjb25maWcsIGMs
IHNpemUpKQo+Pj4gQEAgLTI0OCwxMCArMjUwLDEyIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFf
c2V0X2NvbmZpZyhzdHJ1Y3QgCj4+PiB2aG9zdF92ZHBhICp2LAo+Pj4gwqDCoMKgwqAgaWYgKElT
X0VSUihidWYpKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihidWYpOwo+Pj4g
LcKgwqDCoCB2ZHBhX3NldF9jb25maWcodmRwYSwgY29uZmlnLm9mZiwgYnVmLCBjb25maWdfc2l6
ZSk7Cj4+PiArwqDCoMKgIHJldCA9IHZkcGFfc2V0X2NvbmZpZyh2ZHBhLCBjb25maWcub2ZmLCBi
dWYsIGNvbmZpZ19zaXplKTsKPj4+ICvCoMKgwqAgaWYgKHJldCA8IDApCj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0ID0gLUVGQVVMVDsKPj4+IMKgwqDCoMKgIGt2ZnJlZShidWYpOwo+Pj4gLcKgwqDC
oCByZXR1cm4gMDsKPj4+ICvCoMKgwqAgcmV0dXJuIHJldDsKPj4+IMKgfQo+Pgo+Pgo+PiBTbyBJ
IHdvbmRlciB3aGV0aGVyIGl0J3Mgd29ydGggdG8gcmV0dXJuIHRoZSBudW1iZXIgb2YgYnl0ZXMg
c2luY2Ugd2UgCj4+IGNhbid0IHByb3BvZ2F0ZSB0aGUgcmVzdWx0IHRvIGRyaXZlciBvciBkcml2
ZXIgZG9lc24ndCBjYXJlIGFib3V0IHRoYXQuCj4KPiBPa2F5LCBidXQgSUlVQyB1c2VyIHNwYWNl
IGFwcGxpY2F0aW9uIHRoYXQgaXNzdWUgVkhPU1RfVkRQQV9HRVRfQ09ORklHIAo+IGlvY3RsIGNh
biB1c2UgdGhlIHJldHVybiB2YWx1ZS4KCgpZZXMsIGJ1dCBpdCBsb29rcyB0byBpdCdzIHRvbyBs
YXRlIHRvIGNoYW5nZSBzaW5jZSBpdCdzIGEgdXNlcnNwYWNlIApub3RpY2JsZSBiZWhhdmlvdXIu
CgoKPgo+IFNob3VsZCB3ZSBjaGFuZ2UgYWxzbyAnc3RydWN0IHZpcnRpb19jb25maWdfb3BzJyB0
byBwcm9wYWdhdGUgdGhpcyAKPiB2YWx1ZSBhbHNvIHRvIHZpcnRpbyBkcml2ZXJzPwoKCkkgdGhp
bmsgbm90LCB0aGUgcmVhc29uIGlzIHRoZSBkcml2ZXIgZG9lc24ndCBleHBlY3QgdGhlIGdldCgp
L3NldCgpIGNhbiAKZmFpbC4uLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
