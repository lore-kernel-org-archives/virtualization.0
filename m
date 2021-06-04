Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EBFC07E94
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 15:57:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AC46108E
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 15:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AC46108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0906A415BD;
	Fri,  4 Jun 2021 15:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kMsmv8aUR-1a; Fri,  4 Jun 2021 15:57:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5E4B40575;
	Fri,  4 Jun 2021 15:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3AB9C000D;
	Fri,  4 Jun 2021 15:57:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1F0C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0631400E4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZ06Is37g0Lp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:57:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FA8C400AB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:57:43 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96C7C613E9;
 Fri,  4 Jun 2021 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622822263;
 bh=bjEw7NHq2+Hk4VLi51FDyLk7BzMQaucHh9l2IATcS2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aWCz92Y+JBBa0BBlRcfk84/ngxemMP7HF1zCIdL8rKpEFJ5yF2fdGvW1e9VQhXs2Q
 zmWWAGeoZWh/wucqxZYQBsyWSJUxhdkBfFvwlIscik82L7x09vxMzw2GRnaPpZTEyJ
 K2lPrx4uAhWH4VlxpTGLHKsCQ7gfFKXgCf9LwejQfPYCrJGxT2g98YsOoGq8kVxvRy
 H2VCo00UbpqHfn5cg5+MwJhOwYowveb6YUFQb5UC0iW0NZbXZrGMI6TtYNUM6awvnt
 p3Io3JZHjuBe7NWYBHNyD34JwCcorrL9KCrKsO8XSVOmFBRPtNl3KRlQ8NQtuDBr9R
 2TJo6+6/Dtcxw==
Date: Fri, 4 Jun 2021 18:57:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdp/mlx5: Fix setting the correct dma_device
Message-ID: <YLpNc5WsBWQ5f4cl@unreal>
References: <20210603112215.69259-1-elic@nvidia.com>
 <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com>
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMTA6MzU6NTlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzMg5LiL5Y2INzoyMiwgRWxpIENvaGVuIOWGmemBkzoKPiA+IEJl
Zm9yZSBTRiBzdXBwb3J0IHdhcyBpbnRyb2R1Y2VkLCB0aGUgRE1BIGRldmljZSB3YXMgZXF1YWwg
dG8KPiA+IG1kZXYtPmRldmljZSB3aGljaCB3YXMgaW4gZXNzZW5jZSBlcXVhbCB0byBwZGV2LT5k
ZXY7Cj4gPiBXaXRoIFNGIGludHJvZHVjdGlvbiB0aGlzIGlzIG5vIGxvbmdlciB0cnVlLiBJdCBo
YXMgYWxyZWFkeSBiZWVuCj4gPiBoYW5kbGVkIGZvciB2aG9zdF92ZHBhIHNpbmNlIHRoZSByZWZl
cmVuY2UgdG8gdGhlIGRtYSBkZXZpY2UgY2FuIGZyb20KPiA+IHdpdGhpbiBtbHg1X3ZkcGEuIFdp
dGggdmlydGlvX3ZkcGEgdGhpcyBicm9rZS4gVG8gZml4IHRoaXMgd2Ugc2V0IHRoZQo+ID4gcmVh
bCBkbWEgZGV2aWNlIHdoZW4gaW5pdGlhbGl6aW5nIHRoZSBkZXZpY2UuCj4gPiAKPiA+IEZpeGVz
OiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVk
IG1seDUgZGV2aWNlcyIpCj4gCj4gCj4gTm90ZSBzdXJlIHRoaXMgaXMgY29ycmVjdCwgYWNjb3Jk
aW5nIHRvIHRoZSBjb21taXQgbG9nIGl0IHNob3VsZCBiZSB0aGUKPiBwYXRjaCB0aGF0IGludHJv
ZHVjZXMgdGhlIFNGIG9yIGF1eCBidXMgc3VwcG9ydCBmb3IgdkRQQS4KCldoZXJlIGRpZCB5b3Ug
c2VlIHRoYXQ/CgpnaXQgbG9nIC1wIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwoK
Li4uCisgICAgICAgbXZkZXYtPnZkZXYuZG1hX2RldiA9IG1kZXYtPmRldmljZTsKKyAgICAgICBl
cnIgPSBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Ci4uLgogY29tZXMg
ZnJvbSBjb21taXQgMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9y
IHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQoKVGhhbmtzCgo+IAo+IAo+ID4gU2lnbmVkLW9mZi1i
eTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gCj4gCj4gUGF0Y2ggbG9va3MgY29ycmVj
dC4KPiAKPiBUaGFua3MKPiAKPiAKPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgfCAyICstCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiBpbmRl
eCBiYzMzZjJjNTIzZDMuLmE0ZmYxNTgxODFlMCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jCj4gPiBAQCAtMjA0Niw3ICsyMDQ2LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFf
ZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lKQo+
ID4gICAJaWYgKGVycikKPiA+ICAgCQlnb3RvIGVycl9tdHU7Cj4gPiAtCW12ZGV2LT52ZGV2LmRt
YV9kZXYgPSBtZGV2LT5kZXZpY2U7Cj4gPiArCW12ZGV2LT52ZGV2LmRtYV9kZXYgPSAmbWRldi0+
cGRldi0+ZGV2Owo+ID4gICAJZXJyID0gbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcygmbmRldi0+
bXZkZXYpOwo+ID4gICAJaWYgKGVycikKPiA+ICAgCQlnb3RvIGVycl9tdHU7Cj4gCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKPiBWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
