Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F2C2D0A3
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 13:01:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD5920731
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 13:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmasCj/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD5920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1119020529;
	Tue,  3 Nov 2020 13:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Luz8EuifK4V5; Tue,  3 Nov 2020 13:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 30DA520523;
	Tue,  3 Nov 2020 13:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1951CC0889;
	Tue,  3 Nov 2020 13:01:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40042C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 13:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 255FE2050F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 13:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qyj9is6lMN2F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 13:01:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B34FE203EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 13:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604408464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O2iJ/zgY4Lte+KS6CupKkbJfPOpvRKxzpKWrj3MKA0=;
 b=YmasCj/3ugRjpDZAw0MXchUJaUSrscZiCsga/bjzRuNBbUegtaaC6WvjiAVALWAvDr8WnL
 w7piH5OSV21CyxodCzvYAa5u6ShhINGrljFY8vrRgTBfa68rXnSRpYNJwyEa3Ka1LybDbC
 Yed/ty+h8lFwj5rLmRhb3El3klHd23Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-VEWn-h9CPqq0JLAQqybR3w-1; Tue, 03 Nov 2020 08:01:00 -0500
X-MC-Unique: VEWn-h9CPqq0JLAQqybR3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1651718CB723;
 Tue,  3 Nov 2020 13:00:55 +0000 (UTC)
Received: from [10.72.12.109] (ovpn-12-109.pek2.redhat.com [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3DC6672C0;
 Tue,  3 Nov 2020 13:00:15 +0000 (UTC)
Subject: Re: [PATCH 2/2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
 <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42fe6ef3-90f6-ddb9-f206-e60c1e98c301@redhat.com>
Date: Tue, 3 Nov 2020 21:00:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
IGxhc3RfcGZuKSB7Cj4gKwkJCXVuc2lnbmVkIGxvbmcgcGZuOwo+ICsKPiArCQkJLyoKPiArCQkJ
ICogVW5waW4gdGhlIG91dHN0YW5kaW5nIHBhZ2VzIHdoaWNoIGFyZSB1bm1hcHBlZC4KPiArCQkJ
ICogTWFwcGVkIHBhZ2VzIGFyZSBhY2NvdW50ZWQgaW4gdmRwYV9tYXAoKSwgdGh1cwo+ICsJCQkg
KiB3aWxsIGJlIGhhbmRsZWQgYnkgdmRwYV91bm1hcCgpLgo+ICsJCQkgKi8KPiArCQkJZm9yIChw
Zm4gPSBtYXBfcGZuOyBwZm4gPD0gbGFzdF9wZm47IHBmbisrKQo+ICsJCQkJdW5waW5fdXNlcl9w
YWdlKHBmbl90b19wYWdlKHBmbikpOwo+ICsJCX0KPiAgIAkJdmhvc3RfdmRwYV91bm1hcCh2LCBt
c2ctPmlvdmEsIG1zZy0+c2l6ZSk7CgoKSSB3YW50IHRvIGtub3cgd2hhdCdzIHdyb25nIHdpdGgg
Y3VycmVudCBjb2RlLgoKV2UgY2FsbCB2aG9zdF92ZHBhX3VubWFwKCkgb24gZXJyb3Igd2hpY2gg
Y2FsbHMgdmhvc3RfdmRwYV9pb3RsYl91bm1hcCgpIAp0aGF0IHdpbGwgdW5waW4gYW5kIHJlZHVj
ZSB0aGUgcGlubmVkX3ZtLgoKVGhhbmtzCgoKPiAtCQlhdG9taWM2NF9zdWIobnBhZ2VzLCAmZGV2
LT5tbS0+cGlubmVkX3ZtKTsKPiAgIAl9Cj4gK3VubG9jazoKPiAgIAltbWFwX3JlYWRfdW5sb2Nr
KGRldi0+bW0pOwo+ICtmcmVlOgo+ICAgCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwYWdlX2xp
c3QpOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
