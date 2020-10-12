Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A1C433DF
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 05:02:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA1F2076D
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 05:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTHhpDrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA1F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF02985EEF;
	Mon, 12 Oct 2020 05:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lo6DV4ryn-_M; Mon, 12 Oct 2020 05:02:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B158685E03;
	Mon, 12 Oct 2020 05:02:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91582C0052;
	Mon, 12 Oct 2020 05:02:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D627AC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C3E8C87359
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U1lDsFtAWCQC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:02:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 124D687328
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602478970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VR+6M+UQjwu5GJv31x62ZjcTl58x8U8h5akrMCl4D0=;
 b=ZTHhpDrOzlOiykGp+FAVY4E8o5TPnK9Q40s3ceUupczUpX/2C00yONGKCTfrvVml58AM3Y
 cYLG+/fIaEkycoqm4k2RpNiXv05YTWOml2Oy10vVmU62DR6NQQO1dDfDUlCmcXbBE24yx8
 KuZ69kiqHk7SeVaDGJpdfUSaMJSUT+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-FXyaQoylPrCN0gVC8K4Z1g-1; Mon, 12 Oct 2020 01:02:47 -0400
X-MC-Unique: FXyaQoylPrCN0gVC8K4Z1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D710B107ACF8;
 Mon, 12 Oct 2020 05:02:44 +0000 (UTC)
Received: from [10.72.13.74] (ovpn-13-74.pek2.redhat.com [10.72.13.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD3C6198C;
 Mon, 12 Oct 2020 05:02:39 +0000 (UTC)
Subject: Re: [PATCH net-next v3] virtio-net: ethtool configurable RXCSUM
To: xiangxia.m.yue@gmail.com, mst@redhat.com, willemb@google.com
References: <20201012015820.62042-1-xiangxia.m.yue@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fb819f6c-6115-e9c0-818e-159e7f7e8189@redhat.com>
Date: Mon, 12 Oct 2020 13:02:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012015820.62042-1-xiangxia.m.yue@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTAvMTIg5LiK5Y2IOTo1OCwgeGlhbmd4aWEubS55dWVAZ21haWwuY29tIHdyb3Rl
Ogo+IEZyb206IFRvbmdoYW8gWmhhbmcgPHhpYW5neGlhLm0ueXVlQGdtYWlsLmNvbT4KPgo+IEFs
bG93IHVzZXIgY29uZmlndXJpbmcgUlhDU1VNIHNlcGFyYXRlbHkgd2l0aCBldGh0b29sIC1LLAo+
IHJldXNpbmcgdGhlIGV4aXN0aW5nIHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzIGhlbHBlcgo+
IHRoYXQgY29uZmlndXJlcyBSWENTVU0gZm9yIFhEUC4gVGhpcyBpcyBjb25kaXRpb25hbCBvbgo+
IFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxPQURTLgo+Cj4gSWYgUnggY2hlY2tzdW0gaXMg
ZGlzYWJsZWQsIExSTyBzaG91bGQgYWxzbyBiZSBkaXNhYmxlZC4KPgo+IENjOiBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+IENjOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgo+IENjOiBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1iQGdvb2dsZS5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogVG9uZ2hhbyBaaGFuZyA8eGlhbmd4aWEubS55dWVAZ21haWwuY29tPgo+IEFj
a2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDEyIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDIxYjcxMTQ4YzUzMi4uZDJkMmM0YTUzY2YyIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+IEBAIC02OCw2ICs2OCw4IEBAIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBs
b25nIGd1ZXN0X29mZmxvYWRzW10gPSB7Cj4gICAJCQkJKDFVTEwgPDwgVklSVElPX05FVF9GX0dV
RVNUX0VDTikgIHwgXAo+ICAgCQkJCSgxVUxMIDw8IFZJUlRJT19ORVRfRl9HVUVTVF9VRk8pKQo+
ICAgCj4gKyNkZWZpbmUgR1VFU1RfT0ZGTE9BRF9DU1VNX01BU0sgKDFVTEwgPDwgVklSVElPX05F
VF9GX0dVRVNUX0NTVU0pCj4gKwo+ICAgc3RydWN0IHZpcnRuZXRfc3RhdF9kZXNjIHsKPiAgIAlj
aGFyIGRlc2NbRVRIX0dTVFJJTkdfTEVOXTsKPiAgIAlzaXplX3Qgb2Zmc2V0Owo+IEBAIC0yNTIy
LDI5ICsyNTI0LDQ4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9nZXRfcGh5c19wb3J0X25hbWUoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwgY2hhciAqYnVmLAo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAg
Cj4gK3N0YXRpYyBuZXRkZXZfZmVhdHVyZXNfdCB2aXJ0bmV0X2ZpeF9mZWF0dXJlcyhzdHJ1Y3Qg
bmV0X2RldmljZSAqbmV0ZGV2LAo+ICsJCQkJCSAgICAgIG5ldGRldl9mZWF0dXJlc190IGZlYXR1
cmVzKQo+ICt7Cj4gKwkvKiBJZiBSeCBjaGVja3N1bSBpcyBkaXNhYmxlZCwgTFJPIHNob3VsZCBh
bHNvIGJlIGRpc2FibGVkLiAqLwo+ICsJaWYgKCEoZmVhdHVyZXMgJiBORVRJRl9GX1JYQ1NVTSkp
Cj4gKwkJZmVhdHVyZXMgJj0gfk5FVElGX0ZfTFJPOwo+ICsKPiArCXJldHVybiBmZWF0dXJlczsK
PiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgdmlydG5ldF9zZXRfZmVhdHVyZXMoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwKPiAgIAkJCQluZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJlcykKPiAgIHsKPiAg
IAlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gLQl1NjQgb2Zm
bG9hZHM7Cj4gKwl1NjQgb2ZmbG9hZHMgPSB2aS0+Z3Vlc3Rfb2ZmbG9hZHM7Cj4gICAJaW50IGVy
cjsKPiAgIAo+IC0JaWYgKChkZXYtPmZlYXR1cmVzIF4gZmVhdHVyZXMpICYgTkVUSUZfRl9MUk8p
IHsKPiAtCQlpZiAodmktPnhkcF9xdWV1ZV9wYWlycykKPiAtCQkJcmV0dXJuIC1FQlVTWTsKPiAr
CS8qIERvbid0IGFsbG93IGNvbmZpZ3VyYXRpb24gd2hpbGUgWERQIGlzIGFjdGl2ZS4gKi8KPiAr
CWlmICh2aS0+eGRwX3F1ZXVlX3BhaXJzKQo+ICsJCXJldHVybiAtRUJVU1k7Cj4gICAKPiArCWlm
ICgoZGV2LT5mZWF0dXJlcyBeIGZlYXR1cmVzKSAmIE5FVElGX0ZfTFJPKSB7Cj4gICAJCWlmIChm
ZWF0dXJlcyAmIE5FVElGX0ZfTFJPKQo+IC0JCQlvZmZsb2FkcyA9IHZpLT5ndWVzdF9vZmZsb2Fk
c19jYXBhYmxlOwo+ICsJCQlvZmZsb2FkcyB8PSBHVUVTVF9PRkZMT0FEX0xST19NQVNLICYKPiAr
CQkJCSAgICB2aS0+Z3Vlc3Rfb2ZmbG9hZHNfY2FwYWJsZTsKPiAgIAkJZWxzZQo+IC0JCQlvZmZs
b2FkcyA9IHZpLT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlICYKPiAtCQkJCSAgIH5HVUVTVF9PRkZM
T0FEX0xST19NQVNLOwo+ICsJCQlvZmZsb2FkcyAmPSB+R1VFU1RfT0ZGTE9BRF9MUk9fTUFTSzsK
PiArCX0KPiAgIAo+IC0JCWVyciA9IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZs
b2Fkcyk7Cj4gLQkJaWYgKGVycikKPiAtCQkJcmV0dXJuIGVycjsKPiAtCQl2aS0+Z3Vlc3Rfb2Zm
bG9hZHMgPSBvZmZsb2FkczsKPiArCWlmICgoZGV2LT5mZWF0dXJlcyBeIGZlYXR1cmVzKSAmIE5F
VElGX0ZfUlhDU1VNKSB7Cj4gKwkJaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9SWENTVU0pCj4gKwkJ
CW9mZmxvYWRzIHw9IEdVRVNUX09GRkxPQURfQ1NVTV9NQVNLICYKPiArCQkJCSAgICB2aS0+Z3Vl
c3Rfb2ZmbG9hZHNfY2FwYWJsZTsKPiArCQllbHNlCj4gKwkJCW9mZmxvYWRzICY9IH5HVUVTVF9P
RkZMT0FEX0NTVU1fTUFTSzsKPiAgIAl9Cj4gICAKPiArCWVyciA9IHZpcnRuZXRfc2V0X2d1ZXN0
X29mZmxvYWRzKHZpLCBvZmZsb2Fkcyk7Cj4gKwlpZiAoZXJyKQo+ICsJCXJldHVybiBlcnI7Cj4g
Kwo+ICsJdmktPmd1ZXN0X29mZmxvYWRzID0gb2ZmbG9hZHM7Cj4gICAJcmV0dXJuIDA7Cj4gICB9
Cj4gICAKPiBAQCAtMjU2Myw2ICsyNTg0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBuZXRfZGV2
aWNlX29wcyB2aXJ0bmV0X25ldGRldiA9IHsKPiAgIAkubmRvX2ZlYXR1cmVzX2NoZWNrCT0gcGFz
c3RocnVfZmVhdHVyZXNfY2hlY2ssCj4gICAJLm5kb19nZXRfcGh5c19wb3J0X25hbWUJPSB2aXJ0
bmV0X2dldF9waHlzX3BvcnRfbmFtZSwKPiAgIAkubmRvX3NldF9mZWF0dXJlcwk9IHZpcnRuZXRf
c2V0X2ZlYXR1cmVzLAo+ICsJLm5kb19maXhfZmVhdHVyZXMJPSB2aXJ0bmV0X2ZpeF9mZWF0dXJl
cywKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZpcnRuZXRfY29uZmlnX2NoYW5nZWRfd29y
ayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gQEAgLTMwMTMsOCArMzAzNSwxMCBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJaWYg
KHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPiAg
IAkgICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU082KSkK
PiAgIAkJZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0xSTzsKPiAtCWlmICh2aXJ0aW9faGFzX2Zl
YXR1cmUodmRldiwgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMpKQo+ICsJaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykp
IHsKPiArCQlkZXYtPmh3X2ZlYXR1cmVzIHw9IE5FVElGX0ZfUlhDU1VNOwo+ICAgCQlkZXYtPmh3
X2ZlYXR1cmVzIHw9IE5FVElGX0ZfTFJPOwo+ICsJfQo+ICAgCj4gICAJZGV2LT52bGFuX2ZlYXR1
cmVzID0gZGV2LT5mZWF0dXJlczsKCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KCgo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
