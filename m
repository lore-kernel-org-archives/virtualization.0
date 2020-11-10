Return-Path: <SRS0=rWzq=EQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE47C5517A
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 03:29:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BF020721
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 03:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWKmV9AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BF020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B97A98142C;
	Tue, 10 Nov 2020 03:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BaOW6okty1sS; Tue, 10 Nov 2020 03:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0257B86718;
	Tue, 10 Nov 2020 03:29:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBEA7C0889;
	Tue, 10 Nov 2020 03:29:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB17C016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 03:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2A14B86718
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 03:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0PfYhfQvyEJr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 03:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C33378669E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 03:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604978936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gy325TA+QjnLsHvREb/bnqLu+jbhnnSodFxUsPTfsEI=;
 b=LWKmV9ARDB20zDbLOxbkwF/jsxRAG2JNESsaEGVuOwapu+oQ43k0Uc/4LrwAJth3siI6sb
 nnuiV5yRkWgrKdmQfAmLoBvK99HS/272DZpZZd5Ks5nlRLJJ30wTLsAzsWYtck1ohKfDHn
 13/BcDqNIZC+KI623NbW52d0g82/CdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-Rn-7pr4rP16VWr9jT5wYzg-1; Mon, 09 Nov 2020 22:28:54 -0500
X-MC-Unique: Rn-7pr4rP16VWr9jT5wYzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434DF1007464;
 Tue, 10 Nov 2020 03:28:53 +0000 (UTC)
Received: from [10.72.13.94] (ovpn-13-94.pek2.redhat.com [10.72.13.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F4003614F5;
 Tue, 10 Nov 2020 03:28:47 +0000 (UTC)
Subject: Re: [PATCH v3] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e4b0cda-8118-0ed0-7a27-5d284c49f936@redhat.com>
Date: Tue, 10 Nov 2020 11:28:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjAvMTEvNiDkuIrljYg3OjI2LCBTaS1XZWkgTGl1IHdyb3RlOgo+IFBpbm5lZCBwYWdl
cyBhcmUgbm90IHByb3Blcmx5IGFjY291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+IG1hcHBpbmcg
ZXJyb3Igb2NjdXJzIG9uIElPVExCIHVwZGF0ZS4gQ2xlYW4gdXAgZGFuZ2xpbmcKPiBwaW5uZWQg
cGFnZXMgZm9yIHRoZSBlcnJvciBwYXRoLgo+Cj4gVGhlIG1lbW9yeSB1c2FnZSBmb3IgYm9va2tl
ZXBpbmcgcGlubmVkIHBhZ2VzIGlzIHJldmVydGVkCj4gdG8gd2hhdCBpdCB3YXMgYmVmb3JlOiBv
bmx5IG9uZSBzaW5nbGUgZnJlZSBwYWdlIGlzIG5lZWRlZC4KPiBUaGlzIGhlbHBzIHJlZHVjZSB0
aGUgaG9zdCBtZW1vcnkgZGVtYW5kIGZvciBWTSB3aXRoIGEgbGFyZ2UKPiBhbW91bnQgb2YgbWVt
b3J5LCBvciBpbiB0aGUgc2l0dWF0aW9uIHdoZXJlIGhvc3QgaXMgcnVubmluZwo+IHNob3J0IG9m
IGZyZWUgbWVtb3J5Lgo+Cj4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1Y2Ug
dkRQQS1iYXNlZCBiYWNrZW5kIikKPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MzoKPiAtIFR1cm4gZXhwbGljaXQg
bGFzdF9wZm4gY2hlY2sgdG8gYSBXQVJOX09OKCkgKEphc29uKQo+Cj4gQ2hhbmdlcyBpbiB2MjoK
PiAtIERyb3AgdGhlIHJldmVyc2lvbiBwYXRjaAo+IC0gRml4IHVuaGFuZGxlZCBwYWdlIGxlYWsg
dG93YXJkcyB0aGUgZW5kIG9mIHBhZ2VfbGlzdAoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgoKPgo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA4
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
IGluZGV4IGI2ZDkwMTYuLjViMTNkZmQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBh
LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC01NjAsNiArNTYwLDggQEAgc3Rh
dGljIGludCB2aG9zdF92ZHBhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAo+ICAgCWlm
IChyKQo+ICAgCQl2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoZGV2LT5pb3RsYiwgaW92YSwgaW92YSAr
IHNpemUgLSAxKTsKPiArCWVsc2UKPiArCQlhdG9taWM2NF9hZGQoc2l6ZSA+PiBQQUdFX1NISUZU
LCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiAgIAo+ICAgCXJldHVybiByOwo+ICAgfQo+IEBAIC01
OTEsMTQgKzU5MywxNiBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRh
dGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQ
QUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4gICAJdW5zaWduZWQgaW50IGd1cF9m
bGFncyA9IEZPTExfTE9OR1RFUk07Cj4gICAJdW5zaWduZWQgbG9uZyBucGFnZXMsIGN1cl9iYXNl
LCBtYXBfcGZuLCBsYXN0X3BmbiA9IDA7Cj4gLQl1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19s
aW1pdCwgcGlubmVkLCBpOwo+ICsJdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5j
aHVua3MsIGk7Cj4gICAJdTY0IGlvdmEgPSBtc2ctPmlvdmE7Cj4gKwlsb25nIHBpbm5lZDsKPiAg
IAlpbnQgcmV0ID0gMDsKPiAgIAo+ICAgCWlmICh2aG9zdF9pb3RsYl9pdHJlZV9maXJzdChpb3Rs
YiwgbXNnLT5pb3ZhLAo+ICAgCQkJCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxKSkKPiAg
IAkJcmV0dXJuIC1FRVhJU1Q7Cj4gICAKPiArCS8qIExpbWl0IHRoZSB1c2Ugb2YgbWVtb3J5IGZv
ciBib29ra2VlcGluZyAqLwo+ICAgCXBhZ2VfbGlzdCA9IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRf
ZnJlZV9wYWdlKEdGUF9LRVJORUwpOwo+ICAgCWlmICghcGFnZV9saXN0KQo+ICAgCQlyZXR1cm4g
LUVOT01FTTsKPiBAQCAtNjA3LDUyICs2MTEsNzUgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3By
b2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCQlndXBfZmxhZ3Mg
fD0gRk9MTF9XUklURTsKPiAgIAo+ICAgCW5wYWdlcyA9IFBBR0VfQUxJR04obXNnLT5zaXplICsg
KGlvdmEgJiB+UEFHRV9NQVNLKSkgPj4gUEFHRV9TSElGVDsKPiAtCWlmICghbnBhZ2VzKQo+IC0J
CXJldHVybiAtRUlOVkFMOwo+ICsJaWYgKCFucGFnZXMpIHsKPiArCQlyZXQgPSAtRUlOVkFMOwo+
ICsJCWdvdG8gZnJlZTsKPiArCX0KPiAgIAo+ICAgCW1tYXBfcmVhZF9sb2NrKGRldi0+bW0pOwo+
ICAgCj4gLQlsb2NrZWQgPSBhdG9taWM2NF9hZGRfcmV0dXJuKG5wYWdlcywgJmRldi0+bW0tPnBp
bm5lZF92bSk7Cj4gICAJbG9ja19saW1pdCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFH
RV9TSElGVDsKPiAtCj4gLQlpZiAobG9ja2VkID4gbG9ja19saW1pdCkgewo+ICsJaWYgKG5wYWdl
cyArIGF0b21pYzY0X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xpbWl0KSB7Cj4g
ICAJCXJldCA9IC1FTk9NRU07Cj4gLQkJZ290byBvdXQ7Cj4gKwkJZ290byB1bmxvY2s7Cj4gICAJ
fQo+ICAgCj4gICAJY3VyX2Jhc2UgPSBtc2ctPnVhZGRyICYgUEFHRV9NQVNLOwo+ICAgCWlvdmEg
Jj0gUEFHRV9NQVNLOwo+ICsJbmNodW5rcyA9IDA7Cj4gICAKPiAgIAl3aGlsZSAobnBhZ2VzKSB7
Cj4gLQkJcGlubmVkID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+
IC0JCXJldCA9IHBpbl91c2VyX3BhZ2VzKGN1cl9iYXNlLCBwaW5uZWQsCj4gLQkJCQkgICAgIGd1
cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPiAtCQlpZiAocmV0ICE9IHBpbm5lZCkKPiArCQlz
ejJwaW4gPSBtaW5fdCh1bnNpZ25lZCBsb25nLCBucGFnZXMsIGxpc3Rfc2l6ZSk7Cj4gKwkJcGlu
bmVkID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHN6MnBpbiwKPiArCQkJCQlndXBfZmxhZ3Ms
IHBhZ2VfbGlzdCwgTlVMTCk7Cj4gKwkJaWYgKHN6MnBpbiAhPSBwaW5uZWQpIHsKPiArCQkJaWYg
KHBpbm5lZCA8IDApIHsKPiArCQkJCXJldCA9IHBpbm5lZDsKPiArCQkJfSBlbHNlIHsKPiArCQkJ
CXVucGluX3VzZXJfcGFnZXMocGFnZV9saXN0LCBwaW5uZWQpOwo+ICsJCQkJcmV0ID0gLUVOT01F
TTsKPiArCQkJfQo+ICAgCQkJZ290byBvdXQ7Cj4gKwkJfQo+ICsJCW5jaHVua3MrKzsKPiAgIAo+
ICAgCQlpZiAoIWxhc3RfcGZuKQo+ICAgCQkJbWFwX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlz
dFswXSk7Cj4gICAKPiAtCQlmb3IgKGkgPSAwOyBpIDwgcmV0OyBpKyspIHsKPiArCQlmb3IgKGkg
PSAwOyBpIDwgcGlubmVkOyBpKyspIHsKPiAgIAkJCXVuc2lnbmVkIGxvbmcgdGhpc19wZm4gPSBw
YWdlX3RvX3BmbihwYWdlX2xpc3RbaV0pOwo+ICAgCQkJdTY0IGNzaXplOwo+ICAgCj4gICAJCQlp
ZiAobGFzdF9wZm4gJiYgKHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkpIHsKPiAgIAkJCQkvKiBQ
aW4gYSBjb250aWd1b3VzIGNodW5rIG9mIG1lbW9yeSAqLwo+ICAgCQkJCWNzaXplID0gKGxhc3Rf
cGZuIC0gbWFwX3BmbiArIDEpIDw8IFBBR0VfU0hJRlQ7Cj4gLQkJCQlpZiAodmhvc3RfdmRwYV9t
YXAodiwgaW92YSwgY3NpemUsCj4gLQkJCQkJCSAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPiAt
CQkJCQkJICAgbXNnLT5wZXJtKSkKPiArCQkJCXJldCA9IHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEs
IGNzaXplLAo+ICsJCQkJCQkgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPiArCQkJCQkJICAg
ICBtc2ctPnBlcm0pOwo+ICsJCQkJaWYgKHJldCkgewo+ICsJCQkJCS8qCj4gKwkJCQkJICogVW5w
aW4gdGhlIHBhZ2VzIHRoYXQgYXJlIGxlZnQgdW5tYXBwZWQKPiArCQkJCQkgKiBmcm9tIHRoaXMg
cG9pbnQgb24gaW4gdGhlIGN1cnJlbnQKPiArCQkJCQkgKiBwYWdlX2xpc3QuIFRoZSByZW1haW5p
bmcgb3V0c3RhbmRpbmcKPiArCQkJCQkgKiBvbmVzIHdoaWNoIG1heSBzdHJpZGUgYWNyb3NzIHNl
dmVyYWwKPiArCQkJCQkgKiBjaHVua3Mgd2lsbCBiZSBjb3ZlcmVkIGluIHRoZSBjb21tb24KPiAr
CQkJCQkgKiBlcnJvciBwYXRoIHN1YnNlcXVlbnRseS4KPiArCQkJCQkgKi8KPiArCQkJCQl1bnBp
bl91c2VyX3BhZ2VzKCZwYWdlX2xpc3RbaV0sCj4gKwkJCQkJCQkgcGlubmVkIC0gaSk7Cj4gICAJ
CQkJCWdvdG8gb3V0Owo+ICsJCQkJfQo+ICsKPiAgIAkJCQltYXBfcGZuID0gdGhpc19wZm47Cj4g
ICAJCQkJaW92YSArPSBjc2l6ZTsKPiArCQkJCW5jaHVua3MgPSAwOwo+ICAgCQkJfQo+ICAgCj4g
ICAJCQlsYXN0X3BmbiA9IHRoaXNfcGZuOwo+ICAgCQl9Cj4gICAKPiAtCQljdXJfYmFzZSArPSBy
ZXQgPDwgUEFHRV9TSElGVDsKPiAtCQlucGFnZXMgLT0gcmV0Owo+ICsJCWN1cl9iYXNlICs9IHBp
bm5lZCA8PCBQQUdFX1NISUZUOwo+ICsJCW5wYWdlcyAtPSBwaW5uZWQ7Cj4gICAJfQo+ICAgCj4g
ICAJLyogUGluIHRoZSByZXN0IGNodW5rICovCj4gQEAgLTY2MCwxMCArNjg3LDI3IEBAIHN0YXRp
YyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAq
diwKPiAgIAkJCSAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULCBtc2ctPnBlcm0pOwo+ICAgb3V0
Ogo+ICAgCWlmIChyZXQpIHsKPiArCQlpZiAobmNodW5rcykgewo+ICsJCQl1bnNpZ25lZCBsb25n
IHBmbjsKPiArCj4gKwkJCS8qCj4gKwkJCSAqIFVucGluIHRoZSBvdXRzdGFuZGluZyBwYWdlcyB3
aGljaCBhcmUgeWV0IHRvIGJlCj4gKwkJCSAqIG1hcHBlZCBidXQgaGF2ZW4ndCBkdWUgdG8gdmRw
YV9tYXAoKSBvcgo+ICsJCQkgKiBwaW5fdXNlcl9wYWdlcygpIGZhaWx1cmUuCj4gKwkJCSAqCj4g
KwkJCSAqIE1hcHBlZCBwYWdlcyBhcmUgYWNjb3VudGVkIGluIHZkcGFfbWFwKCksIGhlbmNlCj4g
KwkJCSAqIHRoZSBjb3JyZXNwb25kaW5nIHVucGlubmluZyB3aWxsIGJlIGhhbmRsZWQgYnkKPiAr
CQkJICogdmRwYV91bm1hcCgpLgo+ICsJCQkgKi8KPiArCQkJV0FSTl9PTighbGFzdF9wZm4pOwo+
ICsJCQlmb3IgKHBmbiA9IG1hcF9wZm47IHBmbiA8PSBsYXN0X3BmbjsgcGZuKyspCj4gKwkJCQl1
bnBpbl91c2VyX3BhZ2UocGZuX3RvX3BhZ2UocGZuKSk7Cj4gKwkJfQo+ICAgCQl2aG9zdF92ZHBh
X3VubWFwKHYsIG1zZy0+aW92YSwgbXNnLT5zaXplKTsKPiAtCQlhdG9taWM2NF9zdWIobnBhZ2Vz
LCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiAgIAl9Cj4gK3VubG9jazoKPiAgIAltbWFwX3JlYWRf
dW5sb2NrKGRldi0+bW0pOwo+ICtmcmVlOgo+ICAgCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylw
YWdlX2xpc3QpOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
