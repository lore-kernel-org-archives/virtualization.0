Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B7BC63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:15:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122A420771
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jyd+hGOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122A420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C6AEC20C41;
	Mon, 30 Nov 2020 03:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sLoKldGh78hi; Mon, 30 Nov 2020 03:15:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0059921080;
	Mon, 30 Nov 2020 03:15:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7BD1C163C;
	Mon, 30 Nov 2020 03:15:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 161E1C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0504D872FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:15:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h9NZg5x1UyXC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:15:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 483C987302
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606706114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/l6cTsAZGusKnRzEZB3ltcVErk8W3qbT7pUDiDkWwTQ=;
 b=Jyd+hGOmsBJCUlBemTYD+WY5cHQMSlU3n5TGApH+sP7wLcP5zqP+qIrAwDBKsrTre4mnJC
 WM9KuhUoxdp3fOHTRQzEDYzpE6nDAI7u0gyvVYkhOXaweP0rFxy40zgRQJUfa3bKK7mGqd
 9WA3MhXjK7TpCnhnWCEemcMVjGz5Fss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-xs5qnsXROniOU2OAnwE0Hw-1; Sun, 29 Nov 2020 22:15:10 -0500
X-MC-Unique: xs5qnsXROniOU2OAnwE0Hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5DC1E7ED;
 Mon, 30 Nov 2020 03:15:08 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EBED277C3;
 Mon, 30 Nov 2020 03:14:56 +0000 (UTC)
Subject: Re: [PATCH v2 08/17] vdpa_sim: add supported_features field in
 vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-9-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5ad77c37-7de5-4df2-ff2d-70952d103640@redhat.com>
Date: Mon, 30 Nov 2020 11:14:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-9-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBJ
bnRyb2R1Y2UgYSBuZXcgVkRQQVNJTV9GRUFUVVJFUyBtYWNybyB3aXRoIHRoZSBnZW5lcmljIGZl
YXR1cmVzCj4gc3VwcG9ydGVkIGJ5IHRoZSB2RFBBIHNpbXVsYXRvciwgYW5kIFZEUEFTSU1fTkVU
X0ZFQVRVUkVTIG1hY3JvIHdpdGgKPiB2RFBBLW5ldCBmZWF0dXJlcy4KPgo+IEFkZCAnc3VwcG9y
dGVkX2ZlYXR1cmVzJyBmaWVsZCBpbiB2ZHBhc2ltX2Rldl9hdHRyLCB0byBhbGxvdyBkZXZpY2Vz
Cj4gdG8gc3BlY2lmeSB0aGVpciBmZWF0dXJlcy4KPgo+IENvLWRldmVsb3BlZC1ieTogTWF4IEd1
cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNYXggR3VydG92
b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFy
ZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jIHwgMjkgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltLmMKPiBpbmRleCAzOTNiNTRhOWYwZTQuLjM2Njc3ZmMzNjMxYiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbS5jCj4gQEAgLTQ5LDEyICs0OSwxNSBAQCBzdHJ1Y3QgdmRwYXNpbV92aXJ0
cXVldWUgewo+ICAgI2RlZmluZSBWRFBBU0lNX1ZRX05VTSAweDIKPiAgICNkZWZpbmUgVkRQQVNJ
TV9OQU1FICJ2ZHBhc2ltLW5ldGRldiIKPiAgIAo+IC1zdGF0aWMgdTY0IHZkcGFzaW1fZmVhdHVy
ZXMgPSAoMVVMTCA8PCBWSVJUSU9fRl9BTllfTEFZT1VUKSB8Cj4gLQkJCSAgICAgICgxVUxMIDw8
IFZJUlRJT19GX1ZFUlNJT05fMSkgIHwKPiAtCQkJICAgICAgKDFVTEwgPDwgVklSVElPX0ZfQUND
RVNTX1BMQVRGT1JNKSB8Cj4gLQkJCSAgICAgICgxVUxMIDw8IFZJUlRJT19ORVRfRl9NQUMpOwo+
ICsjZGVmaW5lIFZEUEFTSU1fRkVBVFVSRVMJKCgxVUxMIDw8IFZJUlRJT19GX0FOWV9MQVlPVVQp
IHwgXAo+ICsJCQkJICgxVUxMIDw8IFZJUlRJT19GX1ZFUlNJT05fMSkgIHwgXAo+ICsJCQkJICgx
VUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpCj4gKwo+ICsjZGVmaW5lIFZEUEFTSU1f
TkVUX0ZFQVRVUkVTCShWRFBBU0lNX0ZFQVRVUkVTIHwgXAo+ICsJCQkJICgxVUxMIDw8IFZJUlRJ
T19ORVRfRl9NQUMpKQo+ICAgCj4gICBzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciB7Cj4gKwl1NjQg
c3VwcG9ydGVkX2ZlYXR1cmVzOwo+ICAgCWludCBudnFzOwo+ICAgCXUzMiBpZDsKPiAgIH07Cj4g
QEAgLTExMiw3ICsxMTUsNyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3F1ZXVlX3JlYWR5KHN0cnVj
dCB2ZHBhc2ltICp2ZHBhc2ltLCB1bnNpZ25lZCBpbnQgaWR4KQo+ICAgewo+ICAgCXN0cnVjdCB2
ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEgPSAmdmRwYXNpbS0+dnFzW2lkeF07Cj4gICAKPiAtCXZyaW5n
aF9pbml0X2lvdGxiKCZ2cS0+dnJpbmcsIHZkcGFzaW1fZmVhdHVyZXMsCj4gKwl2cmluZ2hfaW5p
dF9pb3RsYigmdnEtPnZyaW5nLCB2ZHBhc2ltLT5kZXZfYXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXMs
Cj4gICAJCQkgIFZEUEFTSU1fUVVFVUVfTUFYLCBmYWxzZSwKPiAgIAkJCSAgKHN0cnVjdCB2cmlu
Z19kZXNjICopKHVpbnRwdHJfdCl2cS0+ZGVzY19hZGRyLAo+ICAgCQkJICAoc3RydWN0IHZyaW5n
X2F2YWlsICopCj4gQEAgLTEyMSw3ICsxMjQsOCBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3F1ZXVl
X3JlYWR5KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB1bnNpZ25lZCBpbnQgaWR4KQo+ICAgCQkJ
ICAodWludHB0cl90KXZxLT5kZXZpY2VfYWRkcik7Cj4gICB9Cj4gICAKPiAtc3RhdGljIHZvaWQg
dmRwYXNpbV92cV9yZXNldChzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZxKQo+ICtzdGF0aWMg
dm9pZCB2ZHBhc2ltX3ZxX3Jlc2V0KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLAo+ICsJCQkgICAg
IHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEpCj4gICB7Cj4gICAJdnEtPnJlYWR5ID0gZmFs
c2U7Cj4gICAJdnEtPmRlc2NfYWRkciA9IDA7Cj4gQEAgLTEyOSw4ICsxMzMsOCBAQCBzdGF0aWMg
dm9pZCB2ZHBhc2ltX3ZxX3Jlc2V0KHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEpCj4gICAJ
dnEtPmRldmljZV9hZGRyID0gMDsKPiAgIAl2cS0+Y2IgPSBOVUxMOwo+ICAgCXZxLT5wcml2YXRl
ID0gTlVMTDsKPiAtCXZyaW5naF9pbml0X2lvdGxiKCZ2cS0+dnJpbmcsIHZkcGFzaW1fZmVhdHVy
ZXMsIFZEUEFTSU1fUVVFVUVfTUFYLAo+IC0JCQkgIGZhbHNlLCBOVUxMLCBOVUxMLCBOVUxMKTsK
PiArCXZyaW5naF9pbml0X2lvdGxiKCZ2cS0+dnJpbmcsIHZkcGFzaW0tPmRldl9hdHRyLnN1cHBv
cnRlZF9mZWF0dXJlcywKPiArCQkJICBWRFBBU0lNX1FVRVVFX01BWCwgZmFsc2UsIE5VTEwsIE5V
TEwsIE5VTEwpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCB2ZHBhc2ltX3Jlc2V0KHN0cnVj
dCB2ZHBhc2ltICp2ZHBhc2ltKQo+IEBAIC0xMzgsNyArMTQyLDcgQEAgc3RhdGljIHZvaWQgdmRw
YXNpbV9yZXNldChzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSkKPiAgIAlpbnQgaTsKPiAgIAo+ICAg
CWZvciAoaSA9IDA7IGkgPCB2ZHBhc2ltLT5kZXZfYXR0ci5udnFzOyBpKyspCj4gLQkJdmRwYXNp
bV92cV9yZXNldCgmdmRwYXNpbS0+dnFzW2ldKTsKPiArCQl2ZHBhc2ltX3ZxX3Jlc2V0KHZkcGFz
aW0sICZ2ZHBhc2ltLT52cXNbaV0pOwo+ICAgCj4gICAJc3Bpbl9sb2NrKCZ2ZHBhc2ltLT5pb21t
dV9sb2NrKTsKPiAgIAl2aG9zdF9pb3RsYl9yZXNldCh2ZHBhc2ltLT5pb21tdSk7Cj4gQEAgLTQ5
OCw3ICs1MDIsOSBAQCBzdGF0aWMgdTMyIHZkcGFzaW1fZ2V0X3ZxX2FsaWduKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSkKPiAgIAo+ICAgc3RhdGljIHU2NCB2ZHBhc2ltX2dldF9mZWF0dXJlcyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gICB7Cj4gLQlyZXR1cm4gdmRwYXNpbV9mZWF0dXJl
czsKPiArCXN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7Cj4gKwo+
ICsJcmV0dXJuIHZkcGFzaW0tPmRldl9hdHRyLnN1cHBvcnRlZF9mZWF0dXJlczsKPiAgIH0KPiAg
IAo+ICAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEsIHU2NCBmZWF0dXJlcykKPiBAQCAtNTEwLDcgKzUxNiw3IEBAIHN0YXRpYyBpbnQgdmRw
YXNpbV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQgZmVhdHVyZXMp
Cj4gICAJaWYgKCEoZmVhdHVyZXMgJiAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0p
KSkKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAtCXZkcGFzaW0tPmZlYXR1cmVzID0gZmVh
dHVyZXMgJiB2ZHBhc2ltX2ZlYXR1cmVzOwo+ICsJdmRwYXNpbS0+ZmVhdHVyZXMgPSBmZWF0dXJl
cyAmIHZkcGFzaW0tPmRldl9hdHRyLnN1cHBvcnRlZF9mZWF0dXJlczsKPiAgIAo+ICAgCS8qIFdl
IGdlbmVyYWxseSBvbmx5IGtub3cgd2hldGhlciBndWVzdCBpcyB1c2luZyB0aGUgbGVnYWN5IGlu
dGVyZmFjZQo+ICAgCSAqIGhlcmUsIHNvIGdlbmVyYWxseSB0aGF0J3MgdGhlIGVhcmxpZXN0IHdl
IGNhbiBzZXQgY29uZmlnIGZpZWxkcy4KPiBAQCAtNzIyLDYgKzcyOCw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IHZkcGFzaW1fZGV2X2luaXQodm9pZCkKPiAgIAlzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0
ciBkZXZfYXR0ciA9IHt9Owo+ICAgCj4gICAJZGV2X2F0dHIuaWQgPSBWSVJUSU9fSURfTkVUOwo+
ICsJZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzID0gVkRQQVNJTV9ORVRfRkVBVFVSRVM7Cj4g
ICAJZGV2X2F0dHIubnZxcyA9IFZEUEFTSU1fVlFfTlVNOwo+ICAgCj4gICAJdmRwYXNpbV9kZXYg
PSB2ZHBhc2ltX2NyZWF0ZSgmZGV2X2F0dHIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
