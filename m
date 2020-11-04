Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC7C388F2
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 02:42:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8812236F
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 02:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1SqT1bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8812236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E61686A17;
	Wed,  4 Nov 2020 02:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iH5kYg3rVgDY; Wed,  4 Nov 2020 02:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D0AF8682A;
	Wed,  4 Nov 2020 02:42:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3E53C0889;
	Wed,  4 Nov 2020 02:42:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 363DEC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 19A9620438
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AfiqzvB3I+UY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:42:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 6A6D7203F8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604457740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rb8Gi0pri/Bf4YFmm+SGx2KisIIUt6r7oMKw9nSOZYs=;
 b=Z1SqT1bjWmmZRmbHINUP+MO1+llAwXiRmK6N3KaRtNEP2xos+u5Y35jUg71OW8tQHOQeGV
 /X45vmYhSFyF6xLkyjJsmDwjcoCQd4+sL+v3V3cLnoZ5LQJtnhAhJuK+TYx44pIm2/jceC
 hhf84ruF6NEkScRKdBw/ihLY+bSbqkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-drJiGjQeNYWSXNx9kF-Zkg-1; Tue, 03 Nov 2020 21:42:18 -0500
X-MC-Unique: drJiGjQeNYWSXNx9kF-Zkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC3C800400;
 Wed,  4 Nov 2020 02:42:17 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C829C194B9;
 Wed,  4 Nov 2020 02:42:11 +0000 (UTC)
Subject: Re: [PATCH 2/2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
 <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <77a2aefe-ccad-bd51-3721-1139d4e535d7@redhat.com>
Date: Wed, 4 Nov 2020 10:42:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTAvMzAg5LiL5Y2IMzo0NSwgU2ktV2VpIExpdSB3cm90ZToKPiBQaW5uZWQgcGFn
ZXMgYXJlIG5vdCBwcm9wZXJseSBhY2NvdW50ZWQgcGFydGljdWxhcmx5IHdoZW4KPiBtYXBwaW5n
IGVycm9yIG9jY3VycyBvbiBJT1RMQiB1cGRhdGUuIENsZWFuIHVwIGRhbmdsaW5nCj4gcGlubmVk
IHBhZ2VzIGZvciB0aGUgZXJyb3IgcGF0aC4KPgo+IFRoZSBtZW1vcnkgdXNhZ2UgZm9yIGJvb2tr
ZWVwaW5nIHBpbm5lZCBwYWdlcyBpcyByZXZlcnRlZAo+IHRvIHdoYXQgaXQgd2FzIGJlZm9yZTog
b25seSBvbmUgc2luZ2xlIGZyZWUgcGFnZSBpcyBuZWVkZWQuCj4gVGhpcyBoZWxwcyByZWR1Y2Ug
dGhlIGhvc3QgbWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdlCj4gYW1vdW50IG9mIG1l
bW9yeSwgb3IgaW4gdGhlIHNpdHVhdGlvbiB3aGVyZSBob3N0IGlzIHJ1bm5pbmcKPiBzaG9ydCBv
ZiBmcmVlIG1lbW9yeS4KPgo+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNl
IHZEUEEtYmFzZWQgYmFja2VuZCIpCj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2Vp
LmxpdUBvcmFjbGUuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA2NCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4
IGI2ZDkwMTYuLjhkYTg1NTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiAr
KysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC01NjAsNiArNTYwLDggQEAgc3RhdGljIGlu
dCB2aG9zdF92ZHBhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAo+ICAgCWlmIChyKQo+
ICAgCQl2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoZGV2LT5pb3RsYiwgaW92YSwgaW92YSArIHNpemUg
LSAxKTsKPiArCWVsc2UKPiArCQlhdG9taWM2NF9hZGQoc2l6ZSA+PiBQQUdFX1NISUZULCAmZGV2
LT5tbS0+cGlubmVkX3ZtKTsKPiAgIAo+ICAgCXJldHVybiByOwo+ICAgfQo+IEBAIC01OTEsMTQg
KzU5MywxNiBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJ
WkUgLyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4gICAJdW5zaWduZWQgaW50IGd1cF9mbGFncyA9
IEZPTExfTE9OR1RFUk07Cj4gICAJdW5zaWduZWQgbG9uZyBucGFnZXMsIGN1cl9iYXNlLCBtYXBf
cGZuLCBsYXN0X3BmbiA9IDA7Cj4gLQl1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19saW1pdCwg
cGlubmVkLCBpOwo+ICsJdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5jaHVua3Ms
IGk7Cj4gICAJdTY0IGlvdmEgPSBtc2ctPmlvdmE7Cj4gKwlsb25nIHBpbm5lZDsKPiAgIAlpbnQg
cmV0ID0gMDsKPiAgIAo+ICAgCWlmICh2aG9zdF9pb3RsYl9pdHJlZV9maXJzdChpb3RsYiwgbXNn
LT5pb3ZhLAo+ICAgCQkJCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxKSkKPiAgIAkJcmV0
dXJuIC1FRVhJU1Q7Cj4gICAKPiArCS8qIExpbWl0IHRoZSB1c2Ugb2YgbWVtb3J5IGZvciBib29r
a2VlcGluZyAqLwo+ICAgCXBhZ2VfbGlzdCA9IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRfZnJlZV9w
YWdlKEdGUF9LRVJORUwpOwo+ICAgCWlmICghcGFnZV9saXN0KQo+ICAgCQlyZXR1cm4gLUVOT01F
TTsKPiBAQCAtNjA3LDUyICs2MTEsNjQgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3Nf
aW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCQlndXBfZmxhZ3MgfD0gRk9M
TF9XUklURTsKPiAgIAo+ICAgCW5wYWdlcyA9IFBBR0VfQUxJR04obXNnLT5zaXplICsgKGlvdmEg
JiB+UEFHRV9NQVNLKSkgPj4gUEFHRV9TSElGVDsKPiAtCWlmICghbnBhZ2VzKQo+IC0JCXJldHVy
biAtRUlOVkFMOwo+ICsJaWYgKCFucGFnZXMpIHsKPiArCQlyZXQgPSAtRUlOVkFMOwo+ICsJCWdv
dG8gZnJlZTsKPiArCX0KPiAgIAo+ICAgCW1tYXBfcmVhZF9sb2NrKGRldi0+bW0pOwo+ICAgCj4g
LQlsb2NrZWQgPSBhdG9taWM2NF9hZGRfcmV0dXJuKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92
bSk7Cj4gICAJbG9ja19saW1pdCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElG
VDsKPiAtCj4gLQlpZiAobG9ja2VkID4gbG9ja19saW1pdCkgewo+ICsJaWYgKG5wYWdlcyArIGF0
b21pYzY0X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xpbWl0KSB7Cj4gICAJCXJl
dCA9IC1FTk9NRU07Cj4gLQkJZ290byBvdXQ7Cj4gKwkJZ290byB1bmxvY2s7Cj4gICAJfQo+ICAg
Cj4gICAJY3VyX2Jhc2UgPSBtc2ctPnVhZGRyICYgUEFHRV9NQVNLOwo+ICAgCWlvdmEgJj0gUEFH
RV9NQVNLOwo+ICsJbmNodW5rcyA9IDA7Cj4gICAKPiAgIAl3aGlsZSAobnBhZ2VzKSB7Cj4gLQkJ
cGlubmVkID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+IC0JCXJl
dCA9IHBpbl91c2VyX3BhZ2VzKGN1cl9iYXNlLCBwaW5uZWQsCj4gLQkJCQkgICAgIGd1cF9mbGFn
cywgcGFnZV9saXN0LCBOVUxMKTsKPiAtCQlpZiAocmV0ICE9IHBpbm5lZCkKPiArCQlzejJwaW4g
PSBtaW5fdCh1bnNpZ25lZCBsb25nLCBucGFnZXMsIGxpc3Rfc2l6ZSk7Cj4gKwkJcGlubmVkID0g
cGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHN6MnBpbiwKPiArCQkJCQlndXBfZmxhZ3MsIHBhZ2Vf
bGlzdCwgTlVMTCk7Cj4gKwkJaWYgKHN6MnBpbiAhPSBwaW5uZWQpIHsKPiArCQkJaWYgKHBpbm5l
ZCA8IDApIHsKPiArCQkJCXJldCA9IHBpbm5lZDsKPiArCQkJfSBlbHNlIHsKPiArCQkJCXVucGlu
X3VzZXJfcGFnZXMocGFnZV9saXN0LCBwaW5uZWQpOwo+ICsJCQkJcmV0ID0gLUVOT01FTTsKPiAr
CQkJfQo+ICAgCQkJZ290byBvdXQ7Cj4gKwkJfQo+ICsJCW5jaHVua3MrKzsKPiAgIAo+ICAgCQlp
ZiAoIWxhc3RfcGZuKQo+ICAgCQkJbWFwX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7
Cj4gICAKPiAtCQlmb3IgKGkgPSAwOyBpIDwgcmV0OyBpKyspIHsKPiArCQlmb3IgKGkgPSAwOyBp
IDwgcGlubmVkOyBpKyspIHsKPiAgIAkJCXVuc2lnbmVkIGxvbmcgdGhpc19wZm4gPSBwYWdlX3Rv
X3BmbihwYWdlX2xpc3RbaV0pOwo+ICAgCQkJdTY0IGNzaXplOwo+ICAgCj4gICAJCQlpZiAobGFz
dF9wZm4gJiYgKHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkpIHsKPiAgIAkJCQkvKiBQaW4gYSBj
b250aWd1b3VzIGNodW5rIG9mIG1lbW9yeSAqLwo+ICAgCQkJCWNzaXplID0gKGxhc3RfcGZuIC0g
bWFwX3BmbiArIDEpIDw8IFBBR0VfU0hJRlQ7Cj4gLQkJCQlpZiAodmhvc3RfdmRwYV9tYXAodiwg
aW92YSwgY3NpemUsCj4gLQkJCQkJCSAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPiAtCQkJCQkJ
ICAgbXNnLT5wZXJtKSkKPiArCQkJCXJldCA9IHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXpl
LAo+ICsJCQkJCQkgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPiArCQkJCQkJICAgICBtc2ct
PnBlcm0pOwo+ICsJCQkJaWYgKHJldCkKPiAgIAkJCQkJZ290byBvdXQ7Cj4gKwo+ICAgCQkJCW1h
cF9wZm4gPSB0aGlzX3BmbjsKPiAgIAkJCQlpb3ZhICs9IGNzaXplOwo+ICsJCQkJbmNodW5rcyA9
IDA7Cj4gICAJCQl9Cj4gICAKPiAgIAkJCWxhc3RfcGZuID0gdGhpc19wZm47Cj4gICAJCX0KPiAg
IAo+IC0JCWN1cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZUOwo+IC0JCW5wYWdlcyAtPSByZXQ7
Cj4gKwkJY3VyX2Jhc2UgKz0gcGlubmVkIDw8IFBBR0VfU0hJRlQ7Cj4gKwkJbnBhZ2VzIC09IHBp
bm5lZDsKPiAgIAl9Cj4gICAKPiAgIAkvKiBQaW4gdGhlIHJlc3QgY2h1bmsgKi8KPiBAQCAtNjYw
LDEwICs2NzYsMjIgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRl
KHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCQkJICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQs
IG1zZy0+cGVybSk7Cj4gICBvdXQ6Cj4gICAJaWYgKHJldCkgewo+ICsJCWlmIChuY2h1bmtzICYm
IGxhc3RfcGZuKSB7CgoKQ2FuIHdlIGRlY3JlYXNlIG5wYWdlcyB3aGVyZSB5b3UgZGlkICJuY2h1
bmtzKysiIHRoZW4gd2UgY2FuIGNoZWNrIApucGFnZXMgaGVyZSBpbnN0ZWFkPwoKVGhhbmtzCgoK
PiArCQkJdW5zaWduZWQgbG9uZyBwZm47Cj4gKwo+ICsJCQkvKgo+ICsJCQkgKiBVbnBpbiB0aGUg
b3V0c3RhbmRpbmcgcGFnZXMgd2hpY2ggYXJlIHVubWFwcGVkLgo+ICsJCQkgKiBNYXBwZWQgcGFn
ZXMgYXJlIGFjY291bnRlZCBpbiB2ZHBhX21hcCgpLCB0aHVzCj4gKwkJCSAqIHdpbGwgYmUgaGFu
ZGxlZCBieSB2ZHBhX3VubWFwKCkuCj4gKwkJCSAqLwo+ICsJCQlmb3IgKHBmbiA9IG1hcF9wZm47
IHBmbiA8PSBsYXN0X3BmbjsgcGZuKyspCj4gKwkJCQl1bnBpbl91c2VyX3BhZ2UocGZuX3RvX3Bh
Z2UocGZuKSk7Cj4gKwkJfQo+ICAgCQl2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92YSwgbXNn
LT5zaXplKTsKPiAtCQlhdG9taWM2NF9zdWIobnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsK
PiAgIAl9Cj4gK3VubG9jazoKPiAgIAltbWFwX3JlYWRfdW5sb2NrKGRldi0+bW0pOwo+ICtmcmVl
Ogo+ICAgCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwYWdlX2xpc3QpOwo+ICAgCXJldHVybiBy
ZXQ7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
