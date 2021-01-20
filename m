Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B0C433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 04:24:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845BB23132
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 04:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845BB23132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1873886FC5;
	Wed, 20 Jan 2021 04:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4N3I3VxV7Pdi; Wed, 20 Jan 2021 04:24:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 621EF86FB3;
	Wed, 20 Jan 2021 04:24:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54E7DC0FA8;
	Wed, 20 Jan 2021 04:24:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8119C088B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 04:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B851C203A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 04:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WfONBZUPxxvw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 04:24:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 1E41420017
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 04:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611116666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIuh7SxU93BuybyBivroDVvSIaVYcMTbwm+jPxQBIoI=;
 b=F9OkwkXV0IcmO8iAj84RMuXebdUx4NKg8zQqHA/sTgxYaZeu20r9xqeLbIny111/jIwiat
 KhSpOGyR4gihjmXYEFItHeg+d60vrBAA/l6JnyxzhaZNlBoLl5pw3jvcDIAZcJY9TqzttS
 RRZtlQilYfJLSCk/9B7aSGK9R7W/uyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-lp2UjuhQMDGbIaW0q_X0HA-1; Tue, 19 Jan 2021 23:24:22 -0500
X-MC-Unique: lp2UjuhQMDGbIaW0q_X0HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78A1F800D53;
 Wed, 20 Jan 2021 04:24:20 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43D835D74B;
 Wed, 20 Jan 2021 04:24:08 +0000 (UTC)
Subject: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion depth
 separately in different cases
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com>
Date: Wed, 20 Jan 2021 12:24:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119045920.447-2-xieyongji@bytedance.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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

Ck9uIDIwMjEvMS8xOSDkuIvljYgxMjo1OSwgWGllIFlvbmdqaSB3cm90ZToKPiBOb3cgd2UgaGF2
ZSBhIGdsb2JhbCBwZXJjcHUgY291bnRlciB0byBsaW1pdCB0aGUgcmVjdXJzaW9uIGRlcHRoCj4g
b2YgZXZlbnRmZF9zaWduYWwoKS4gVGhpcyBjYW4gYXZvaWQgZGVhZGxvY2sgb3Igc3RhY2sgb3Zl
cmZsb3cuCj4gQnV0IGluIHN0YWNrIG92ZXJmbG93IGNhc2UsIGl0IHNob3VsZCBiZSBPSyB0byBp
bmNyZWFzZSB0aGUKPiByZWN1cnNpb24gZGVwdGggaWYgbmVlZGVkLiBTbyB3ZSBhZGQgYSBwZXJj
cHUgY291bnRlciBpbiBldmVudGZkX2N0eAo+IHRvIGxpbWl0IHRoZSByZWN1cnNpb24gZGVwdGgg
Zm9yIGRlYWRsb2NrIGNhc2UuIFRoZW4gaXQgY291bGQgYmUKPiBmaW5lIHRvIGluY3JlYXNlIHRo
ZSBnbG9iYWwgcGVyY3B1IGNvdW50ZXIgbGF0ZXIuCgoKSSB3b25kZXIgd2hldGhlciBvciBub3Qg
aXQncyB3b3J0aCB0byBpbnRyb2R1Y2UgcGVyY3B1IGZvciBlYWNoIGV2ZW50ZmQuCgpIb3cgYWJv
dXQgc2ltcGx5IGNoZWNrIGlmIGV2ZW50ZmRfc2lnbmFsX2NvdW50KCkgaXMgZ3JlYXRlciB0aGFu
IDI/CgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5
dGVkYW5jZS5jb20+Cj4gLS0tCj4gICBmcy9haW8uYyAgICAgICAgICAgICAgICB8ICAzICsrLQo+
ICAgZnMvZXZlbnRmZC5jICAgICAgICAgICAgfCAyMCArKysrKysrKysrKysrKysrKysrLQo+ICAg
aW5jbHVkZS9saW51eC9ldmVudGZkLmggfCAgNSArLS0tLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAy
MiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2ZzL2Fpby5j
IGIvZnMvYWlvLmMKPiBpbmRleCAxZjMyZGExM2QzOWUuLjVkODI5MDMxNjFmNSAxMDA2NDQKPiAt
LS0gYS9mcy9haW8uYwo+ICsrKyBiL2ZzL2Fpby5jCj4gQEAgLTE2OTgsNyArMTY5OCw4IEBAIHN0
YXRpYyBpbnQgYWlvX3BvbGxfd2FrZShzdHJ1Y3Qgd2FpdF9xdWV1ZV9lbnRyeSAqd2FpdCwgdW5z
aWduZWQgbW9kZSwgaW50IHN5bmMsCj4gICAJCWxpc3RfZGVsKCZpb2NiLT5raV9saXN0KTsKPiAg
IAkJaW9jYi0+a2lfcmVzLnJlcyA9IG1hbmdsZV9wb2xsKG1hc2spOwo+ICAgCQlyZXEtPmRvbmUg
PSB0cnVlOwo+IC0JCWlmIChpb2NiLT5raV9ldmVudGZkICYmIGV2ZW50ZmRfc2lnbmFsX2NvdW50
KCkpIHsKPiArCQlpZiAoaW9jYi0+a2lfZXZlbnRmZCAmJgo+ICsJCQlldmVudGZkX3NpZ25hbF9j
b3VudChpb2NiLT5raV9ldmVudGZkKSkgewo+ICAgCQkJaW9jYiA9IE5VTEw7Cj4gICAJCQlJTklU
X1dPUksoJnJlcS0+d29yaywgYWlvX3BvbGxfcHV0X3dvcmspOwo+ICAgCQkJc2NoZWR1bGVfd29y
aygmcmVxLT53b3JrKTsKPiBkaWZmIC0tZ2l0IGEvZnMvZXZlbnRmZC5jIGIvZnMvZXZlbnRmZC5j
Cj4gaW5kZXggZTI2NWI2ZGQ0ZjM0Li4yZGYyNGY5YmFkYTMgMTAwNjQ0Cj4gLS0tIGEvZnMvZXZl
bnRmZC5jCj4gKysrIGIvZnMvZXZlbnRmZC5jCj4gQEAgLTI1LDYgKzI1LDggQEAKPiAgICNpbmNs
dWRlIDxsaW51eC9pZHIuaD4KPiAgICNpbmNsdWRlIDxsaW51eC91aW8uaD4KPiAgIAo+ICsjZGVm
aW5lIEVWRU5URkRfV0FLRV9ERVBUSCAwCj4gKwo+ICAgREVGSU5FX1BFUl9DUFUoaW50LCBldmVu
dGZkX3dha2VfY291bnQpOwo+ICAgCj4gICBzdGF0aWMgREVGSU5FX0lEQShldmVudGZkX2lkYSk7
Cj4gQEAgLTQyLDkgKzQ0LDE3IEBAIHN0cnVjdCBldmVudGZkX2N0eCB7Cj4gICAJICovCj4gICAJ
X191NjQgY291bnQ7Cj4gICAJdW5zaWduZWQgaW50IGZsYWdzOwo+ICsJaW50IF9fcGVyY3B1ICp3
YWtlX2NvdW50Owo+ICAgCWludCBpZDsKPiAgIH07Cj4gICAKPiArYm9vbCBldmVudGZkX3NpZ25h
bF9jb3VudChzdHJ1Y3QgZXZlbnRmZF9jdHggKmN0eCkKPiArewo+ICsJcmV0dXJuICh0aGlzX2Nw
dV9yZWFkKCpjdHgtPndha2VfY291bnQpIHx8Cj4gKwkJdGhpc19jcHVfcmVhZChldmVudGZkX3dh
a2VfY291bnQpID4gRVZFTlRGRF9XQUtFX0RFUFRIKTsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQ
TChldmVudGZkX3NpZ25hbF9jb3VudCk7Cj4gKwo+ICAgLyoqCj4gICAgKiBldmVudGZkX3NpZ25h
bCAtIEFkZHMgQG4gdG8gdGhlIGV2ZW50ZmQgY291bnRlci4KPiAgICAqIEBjdHg6IFtpbl0gUG9p
bnRlciB0byB0aGUgZXZlbnRmZCBjb250ZXh0Lgo+IEBAIC03MSwxNyArODEsMTkgQEAgX191NjQg
ZXZlbnRmZF9zaWduYWwoc3RydWN0IGV2ZW50ZmRfY3R4ICpjdHgsIF9fdTY0IG4pCj4gICAJICog
aXQgcmV0dXJucyB0cnVlLCB0aGUgZXZlbnRmZF9zaWduYWwoKSBjYWxsIHNob3VsZCBiZSBkZWZl
cnJlZCB0byBhCj4gICAJICogc2FmZSBjb250ZXh0Lgo+ICAgCSAqLwo+IC0JaWYgKFdBUk5fT05f
T05DRSh0aGlzX2NwdV9yZWFkKGV2ZW50ZmRfd2FrZV9jb3VudCkpKQo+ICsJaWYgKFdBUk5fT05f
T05DRShldmVudGZkX3NpZ25hbF9jb3VudChjdHgpKSkKPiAgIAkJcmV0dXJuIDA7Cj4gICAKPiAg
IAlzcGluX2xvY2tfaXJxc2F2ZSgmY3R4LT53cWgubG9jaywgZmxhZ3MpOwo+ICAgCXRoaXNfY3B1
X2luYyhldmVudGZkX3dha2VfY291bnQpOwo+ICsJdGhpc19jcHVfaW5jKCpjdHgtPndha2VfY291
bnQpOwo+ICAgCWlmIChVTExPTkdfTUFYIC0gY3R4LT5jb3VudCA8IG4pCj4gICAJCW4gPSBVTExP
TkdfTUFYIC0gY3R4LT5jb3VudDsKPiAgIAljdHgtPmNvdW50ICs9IG47Cj4gICAJaWYgKHdhaXRx
dWV1ZV9hY3RpdmUoJmN0eC0+d3FoKSkKPiAgIAkJd2FrZV91cF9sb2NrZWRfcG9sbCgmY3R4LT53
cWgsIEVQT0xMSU4pOwo+ICAgCXRoaXNfY3B1X2RlYyhldmVudGZkX3dha2VfY291bnQpOwo+ICsJ
dGhpc19jcHVfZGVjKCpjdHgtPndha2VfY291bnQpOwo+ICAgCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmN0eC0+d3FoLmxvY2ssIGZsYWdzKTsKPiAgIAo+ICAgCXJldHVybiBuOwo+IEBAIC05Miw2
ICsxMDQsNyBAQCBzdGF0aWMgdm9pZCBldmVudGZkX2ZyZWVfY3R4KHN0cnVjdCBldmVudGZkX2N0
eCAqY3R4KQo+ICAgewo+ICAgCWlmIChjdHgtPmlkID49IDApCj4gICAJCWlkYV9zaW1wbGVfcmVt
b3ZlKCZldmVudGZkX2lkYSwgY3R4LT5pZCk7Cj4gKwlmcmVlX3BlcmNwdShjdHgtPndha2VfY291
bnQpOwo+ICAgCWtmcmVlKGN0eCk7Cj4gICB9Cj4gICAKPiBAQCAtNDIzLDYgKzQzNiwxMSBAQCBz
dGF0aWMgaW50IGRvX2V2ZW50ZmQodW5zaWduZWQgaW50IGNvdW50LCBpbnQgZmxhZ3MpCj4gICAK
PiAgIAlrcmVmX2luaXQoJmN0eC0+a3JlZik7Cj4gICAJaW5pdF93YWl0cXVldWVfaGVhZCgmY3R4
LT53cWgpOwo+ICsJY3R4LT53YWtlX2NvdW50ID0gYWxsb2NfcGVyY3B1KGludCk7Cj4gKwlpZiAo
IWN0eC0+d2FrZV9jb3VudCkgewo+ICsJCWtmcmVlKGN0eCk7Cj4gKwkJcmV0dXJuIC1FTk9NRU07
Cj4gKwl9Cj4gICAJY3R4LT5jb3VudCA9IGNvdW50Owo+ICAgCWN0eC0+ZmxhZ3MgPSBmbGFnczsK
PiAgIAljdHgtPmlkID0gaWRhX3NpbXBsZV9nZXQoJmV2ZW50ZmRfaWRhLCAwLCAwLCBHRlBfS0VS
TkVMKTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ldmVudGZkLmggYi9pbmNsdWRlL2xp
bnV4L2V2ZW50ZmQuaAo+IGluZGV4IGZhMGE1MjRiYWVkMC4uMWExMWViYmQ3NGE5IDEwMDY0NAo+
IC0tLSBhL2luY2x1ZGUvbGludXgvZXZlbnRmZC5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9ldmVu
dGZkLmgKPiBAQCAtNDUsMTAgKzQ1LDcgQEAgdm9pZCBldmVudGZkX2N0eF9kb19yZWFkKHN0cnVj
dCBldmVudGZkX2N0eCAqY3R4LCBfX3U2NCAqY250KTsKPiAgIAo+ICAgREVDTEFSRV9QRVJfQ1BV
KGludCwgZXZlbnRmZF93YWtlX2NvdW50KTsKPiAgIAo+IC1zdGF0aWMgaW5saW5lIGJvb2wgZXZl
bnRmZF9zaWduYWxfY291bnQodm9pZCkKPiAtewo+IC0JcmV0dXJuIHRoaXNfY3B1X3JlYWQoZXZl
bnRmZF93YWtlX2NvdW50KTsKPiAtfQo+ICtib29sIGV2ZW50ZmRfc2lnbmFsX2NvdW50KHN0cnVj
dCBldmVudGZkX2N0eCAqY3R4KTsKPiAgIAo+ICAgI2Vsc2UgLyogQ09ORklHX0VWRU5URkQgKi8K
PiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
