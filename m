Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAEEC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 06:28:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEB7207FC
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 06:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPys+voY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEB7207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5DD80204BF;
	Wed,  5 Aug 2020 06:28:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4NZbGOMpDwN9; Wed,  5 Aug 2020 06:28:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 44AD82042D;
	Wed,  5 Aug 2020 06:28:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37B82C0050;
	Wed,  5 Aug 2020 06:28:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1421C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C02B084A6C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0msKAoHsnqGO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:28:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1570084964
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596608915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4EoEwZG+swIVHP0lP8YoiVbx/lrSzlRaGxj/pUTBqw=;
 b=TPys+voYW70iKIRrvC4D0Ma+UNP22IR6vl7IwpDWPWezhHhvhNGUMgFfbIq3ccQ4UYvSXV
 caU4/6SqiqKuoJoAmNzKALlNQzGAiYLnmf9BCbXaARjhYdfHIjtwBKGs5YdyymKv42aPTb
 /I4fG3xCLZnTXvD4So8kylQptWIJVLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Z6h-CcQlNsSmC0oA6Dl8uQ-1; Wed, 05 Aug 2020 02:28:31 -0400
X-MC-Unique: Z6h-CcQlNsSmC0oA6Dl8uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D9F418FF662;
 Wed,  5 Aug 2020 06:28:30 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C97D8AC25;
 Wed,  5 Aug 2020 06:28:24 +0000 (UTC)
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
Date: Wed, 5 Aug 2020 14:28:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-4-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOC80IOS4iuWNiDQ6NTgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBDdXJy
ZW50bHkgYWxsIGNvbmZpZyBzcGFjZSBmaWVsZHMgYXJlIG9mIHRoZSB0eXBlIF9fdVhYLgo+IFRo
aXMgY29uZnVzZXMgcGVvcGxlIGFuZCBzb21lIGRyaXZlcnMgKG5vdGFibHkgdmRwYSkKPiBhY2Nl
c3MgdGhlbSB1c2luZyBDUFUgZW5kaWFuLW5lc3MgLSB3aGljaCBvbmx5Cj4gd29ya3Mgd2VsbCBm
b3IgbGVnYWN5IG9yIExFIHBsYXRmb3Jtcy4KPgo+IFVwZGF0ZSB2aXJ0aW9fY3JlYWQvdmlydGlv
X2N3cml0ZSBtYWNyb3MgdG8gYWxsb3cgX192aXJ0aW9YWAo+IGFuZCBfX2xlWFggZmllbGQgdHlw
ZXMuIEZvbGxvdy11cCBwYXRjaGVzIHdpbGwgY29udmVydAo+IGNvbmZpZyBzcGFjZSB0byB1c2Ug
dGhlc2UgdHlwZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggfCA1MCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92aXJ0aW9fY29uZmlnLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+IGlu
ZGV4IDNiNGVhZTVhYzVlMy4uNjRkYTQ5MTkzNmY3IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvdmlydGlvX2NvbmZpZy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgK
PiBAQCAtNiw2ICs2LDcgQEAKPiAgICNpbmNsdWRlIDxsaW51eC9idWcuaD4KPiAgICNpbmNsdWRl
IDxsaW51eC92aXJ0aW8uaD4KPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYnl0ZW9yZGVyLmg+
Cj4gKyNpbmNsdWRlIDxsaW51eC9jb21waWxlcl90eXBlcy5oPgo+ICAgI2luY2x1ZGUgPHVhcGkv
bGludXgvdmlydGlvX2NvbmZpZy5oPgo+ICAgCj4gICBzdHJ1Y3QgaXJxX2FmZmluaXR5Owo+IEBA
IC0yODcsMTIgKzI4OCw1NyBAQCBzdGF0aWMgaW5saW5lIF9fdmlydGlvNjQgY3B1X3RvX3ZpcnRp
bzY0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1NjQgdmFsKQo+ICAgCXJldHVybiBfX2Nw
dV90b192aXJ0aW82NCh2aXJ0aW9faXNfbGl0dGxlX2VuZGlhbih2ZGV2KSwgdmFsKTsKPiAgIH0K
PiAgIAo+ICsvKgo+ICsgKiBPbmx5IHRoZSBjaGVja2VyIGRpZmZlcmVudGlhdGVzIGJldHdlZW4g
X192aXJ0aW9YWCBhbmQgX191WFggdHlwZXMuIEJ1dCB3ZQo+ICsgKiB0cnkgdG8gc2hhcmUgYXMg
bXVjaCBjb2RlIGFzIHdlIGNhbiB3aXRoIHRoZSByZWd1bGFyIEdDQyBidWlsZC4KPiArICovCj4g
KyNpZiAhZGVmaW5lZChDT05GSUdfQ0NfSVNfR0NDKSAmJiAhZGVmaW5lZChfX0NIRUNLRVJfXykK
PiArCj4gKy8qIE5vdCBhIGNoZWNrZXIgLSB3ZSBjYW4ga2VlcCB0aGluZ3Mgc2ltcGxlICovCj4g
KyNkZWZpbmUgX192aXJ0aW9fbmF0aXZlX3R5cGVvZih4KSB0eXBlb2YoeCkKPiArCj4gKyNlbHNl
Cj4gKwo+ICsvKgo+ICsgKiBXZSBidWlsZCB0aGlzIG91dCBvZiBhIGNvdXBsZSBvZiBoZWxwZXIg
bWFjcm9zIGluIGEgdmFpbiBhdHRlbXB0IHRvCj4gKyAqIGhlbHAgeW91IGtlZXAgeW91ciBsdW5j
aCBkb3duIHdoaWxlIHJlYWRpbmcgaXQuCj4gKyAqLwo+ICsjZGVmaW5lIF9fdmlydGlvX3BpY2tf
dmFsdWUoeCwgdHlwZSwgdGhlbiwgb3RoZXJ3aXNlKQkJCVwKPiArCV9fYnVpbHRpbl9jaG9vc2Vf
ZXhwcihfX3NhbWVfdHlwZSh4LCB0eXBlKSwgdGhlbiwgb3RoZXJ3aXNlKQo+ICsKPiArI2RlZmlu
ZSBfX3ZpcnRpb19waWNrX3R5cGUoeCwgdHlwZSwgdGhlbiwgb3RoZXJ3aXNlKQkJCVwKPiArCV9f
dmlydGlvX3BpY2tfdmFsdWUoeCwgdHlwZSwgKHRoZW4pMCwgb3RoZXJ3aXNlKQo+ICsKPiArI2Rl
ZmluZSBfX3ZpcnRpb19waWNrX2VuZGlhbih4LCB4MTYsIHgzMiwgeDY0LCBvdGhlcndpc2UpCQkJ
XAo+ICsJX192aXJ0aW9fcGlja190eXBlKHgsIHgxNiwgX191MTYsCQkJCQlcCj4gKwkJX192aXJ0
aW9fcGlja190eXBlKHgsIHgzMiwgX191MzIsCQkJCVwKPiArCQkJX192aXJ0aW9fcGlja190eXBl
KHgsIHg2NCwgX191NjQsCQkJXAo+ICsJCQkJb3RoZXJ3aXNlKSkpCj4gKwo+ICsjZGVmaW5lIF9f
dmlydGlvX25hdGl2ZV90eXBlb2YoeCkgdHlwZW9mKAkJCQkJXAo+ICsJX192aXJ0aW9fcGlja190
eXBlKHgsIF9fdTgsIF9fdTgsCQkJCQlcCj4gKwkJX192aXJ0aW9fcGlja19lbmRpYW4oeCwgX192
aXJ0aW8xNiwgX192aXJ0aW8zMiwgX192aXJ0aW82NCwJXAo+ICsJCQlfX3ZpcnRpb19waWNrX2Vu
ZGlhbih4LCBfX2xlMTYsIF9fbGUzMiwgX19sZTY0LAkJXAo+ICsJCQkJX192aXJ0aW9fcGlja19l
bmRpYW4oeCwgX191MTYsIF9fdTMyLCBfX3U2NCwJXAo+ICsJCQkJCS8qIE5vIG90aGVyIHR5cGUg
YWxsb3dlZCAqLwkJXAo+ICsJCQkJCSh2b2lkKTApKSkpKQo+ICsKPiArI2VuZGlmCj4gKwo+ICsj
ZGVmaW5lIF9fdmlydGlvX25hdGl2ZV90eXBlKHN0cnVjdG5hbWUsIG1lbWJlcikgXAo+ICsJX192
aXJ0aW9fbmF0aXZlX3R5cGVvZigoKHN0cnVjdG5hbWUqKTApLT5tZW1iZXIpCj4gKwo+ICsjZGVm
aW5lIF9fdmlydGlvX3R5cGVjaGVjayhzdHJ1Y3RuYW1lLCBtZW1iZXIsIHZhbCkgXAo+ICsJCS8q
IE11c3QgbWF0Y2ggdGhlIG1lbWJlcidzIHR5cGUsIGFuZCBiZSBpbnRlZ2VyICovIFwKPiArCQl0
eXBlY2hlY2soX192aXJ0aW9fbmF0aXZlX3R5cGUoc3RydWN0bmFtZSwgbWVtYmVyKSwgKHZhbCkp
Cj4gKwo+ICsKPiAgIC8qIENvbmZpZyBzcGFjZSBhY2Nlc3NvcnMuICovCj4gICAjZGVmaW5lIHZp
cnRpb19jcmVhZCh2ZGV2LCBzdHJ1Y3RuYW1lLCBtZW1iZXIsIHB0cikJCQlcCj4gICAJZG8gewkJ
CQkJCQkJXAo+ICAgCQltaWdodF9zbGVlcCgpOwkJCQkJCVwKPiAgIAkJLyogTXVzdCBtYXRjaCB0
aGUgbWVtYmVyJ3MgdHlwZSwgYW5kIGJlIGludGVnZXIgKi8JXAo+IC0JCWlmICghdHlwZWNoZWNr
KHR5cGVvZigoKChzdHJ1Y3RuYW1lKikwKS0+bWVtYmVyKSksICoocHRyKSkpIFwKPiArCQlpZiAo
IV9fdmlydGlvX3R5cGVjaGVjayhzdHJ1Y3RuYW1lLCBtZW1iZXIsICoocHRyKSkpCVwKPiAgIAkJ
CSgqcHRyKSA9IDE7CQkJCQlcCgoKQSBzaWxseSBxdWVzdGlvbizCoCBjb21wYXJlIHRvIHVzaW5n
IHNldCgpL2dldCgpIGRpcmVjdGx5LCB3aGF0J3MgdGhlIAp2YWx1ZSBvZiB0aGUgYWNjZXNzb3Jz
IG1hY3JvIGhlcmU/CgpUaGFua3MKCgo+ICAgCQkJCQkJCQkJXAo+ICAgCQlzd2l0Y2ggKHNpemVv
ZigqcHRyKSkgewkJCQkJXAo+IEBAIC0zMjIsNyArMzY4LDcgQEAgc3RhdGljIGlubGluZSBfX3Zp
cnRpbzY0IGNwdV90b192aXJ0aW82NChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdTY0IHZh
bCkKPiAgIAlkbyB7CQkJCQkJCQlcCj4gICAJCW1pZ2h0X3NsZWVwKCk7CQkJCQkJXAo+ICAgCQkv
KiBNdXN0IG1hdGNoIHRoZSBtZW1iZXIncyB0eXBlLCBhbmQgYmUgaW50ZWdlciAqLwlcCj4gLQkJ
aWYgKCF0eXBlY2hlY2sodHlwZW9mKCgoKHN0cnVjdG5hbWUqKTApLT5tZW1iZXIpKSwgKihwdHIp
KSkgXAo+ICsJCWlmICghX192aXJ0aW9fdHlwZWNoZWNrKHN0cnVjdG5hbWUsIG1lbWJlciwgKihw
dHIpKSkJXAo+ICAgCQkJQlVHX09OKCgqcHRyKSA9PSAxKTsJCQkJXAo+ICAgCQkJCQkJCQkJXAo+
ICAgCQlzd2l0Y2ggKHNpemVvZigqcHRyKSkgewkJCQkJXAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
