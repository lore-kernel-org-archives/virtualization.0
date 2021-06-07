Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC8C47082
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 05:52:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A616121E
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 05:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A616121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0524440172;
	Mon,  7 Jun 2021 05:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dyh-Urn-wurH; Mon,  7 Jun 2021 05:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77E9740147;
	Mon,  7 Jun 2021 05:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49266C000E;
	Mon,  7 Jun 2021 05:52:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B41F0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 05:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BCC382C89
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 05:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Krm_bEmzJbbt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 05:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4DFE82C61
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 05:52:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C840E6121D;
 Mon,  7 Jun 2021 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623045124;
 bh=a4Lg+JUPxxsJc/eOTxfRRMHpv5LjKRVeKemBpbGWIDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RHM8rB/mlV328H1xAE61n5jsu0XfeToCJbIOMtvG/VU2srJ6FQVAGeF5KV1VZq7q9
 trPVnOCbCfDHXN06WSjktBmAI7j9G3R+6A4v7HMJGydwzj4qnsWOl0LhVROIIiNkj8
 6v8V8DfhFpDWeUDmimOUU6hduL1KByIPOwok5ulFwyCbFMWFW2ck4y9B11WEgdddrd
 LDX/cW4G/bln15fenJ1ef7oUzeWV2QvXe0GZB6ctRsOoGnEOdPAFnf3/j0U9oQkizD
 shLELQ82kWJlWhFkQYaNGuTE4FuOWHIWX3XhXp/fCAIluryxWgYSu3Lj4i/Sveja2r
 c8VvkRzbouW6Q==
Date: Mon, 7 Jun 2021 08:51:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdp/mlx5: Fix setting the correct dma_device
Message-ID: <YL2z/4RT/nwHscYE@unreal>
References: <20210603112215.69259-1-elic@nvidia.com>
 <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com>
 <YLpNc5WsBWQ5f4cl@unreal>
 <c083f4b2-aa0a-ad3c-7a16-fe1c7dbda92d@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c083f4b2-aa0a-ad3c-7a16-fe1c7dbda92d@redhat.com>
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

T24gTW9uLCBKdW4gMDcsIDIwMjEgYXQgMTA6MzA6NDJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzQg5LiL5Y2IMTE6NTcsIExlb24gUm9tYW5vdnNreSDlhpnpgZM6
Cj4gPiBPbiBGcmksIEp1biAwNCwgMjAyMSBhdCAxMDozNTo1OUFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiDlnKggMjAyMS82LzMg5LiL5Y2INzoyMiwgRWxpIENvaGVuIOWGmemBkzoK
PiA+ID4gPiBCZWZvcmUgU0Ygc3VwcG9ydCB3YXMgaW50cm9kdWNlZCwgdGhlIERNQSBkZXZpY2Ug
d2FzIGVxdWFsIHRvCj4gPiA+ID4gbWRldi0+ZGV2aWNlIHdoaWNoIHdhcyBpbiBlc3NlbmNlIGVx
dWFsIHRvIHBkZXYtPmRldjsKPiA+ID4gPiBXaXRoIFNGIGludHJvZHVjdGlvbiB0aGlzIGlzIG5v
IGxvbmdlciB0cnVlLiBJdCBoYXMgYWxyZWFkeSBiZWVuCj4gPiA+ID4gaGFuZGxlZCBmb3Igdmhv
c3RfdmRwYSBzaW5jZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSBkbWEgZGV2aWNlIGNhbiBmcm9tCj4g
PiA+ID4gd2l0aGluIG1seDVfdmRwYS4gV2l0aCB2aXJ0aW9fdmRwYSB0aGlzIGJyb2tlLiBUbyBm
aXggdGhpcyB3ZSBzZXQgdGhlCj4gPiA+ID4gcmVhbCBkbWEgZGV2aWNlIHdoZW4gaW5pdGlhbGl6
aW5nIHRoZSBkZXZpY2UuCj4gPiA+ID4gCj4gPiA+ID4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZk
cGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiA+
ID4gCj4gPiA+IE5vdGUgc3VyZSB0aGlzIGlzIGNvcnJlY3QsIGFjY29yZGluZyB0byB0aGUgY29t
bWl0IGxvZyBpdCBzaG91bGQgYmUgdGhlCj4gPiA+IHBhdGNoIHRoYXQgaW50cm9kdWNlcyB0aGUg
U0Ygb3IgYXV4IGJ1cyBzdXBwb3J0IGZvciB2RFBBLgo+ID4gV2hlcmUgZGlkIHlvdSBzZWUgdGhh
dD8KPiA+IAo+ID4gZ2l0IGxvZyAtcCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiA+IAo+ID4gLi4uCj4gPiArICAgICAgIG12ZGV2LT52ZGV2LmRtYV9kZXYgPSBtZGV2LT5kZXZp
Y2U7Cj4gPiArICAgICAgIGVyciA9IG1seDVfdmRwYV9hbGxvY19yZXNvdXJjZXMoJm5kZXYtPm12
ZGV2KTsKPiA+IC4uLgo+ID4gICBjb21lcyBmcm9tIGNvbW1pdCAxYTg2YjM3N2FhMjEgKCJ2ZHBh
L21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gCj4g
Cj4gSWYgSSByZWFkIHRoZSBjb21taXQgbG9nIGFuZCBjb2RlIGNvcnJlY3RseToKPiAKPiAiCj4g
Cj4gV2l0aCBTRiBpbnRyb2R1Y3Rpb24gdGhpcyBpcyBubyBsb25nZXIgdHJ1ZS4KPiAKPiAiCj4g
Cj4gSXQgd29ya3MgYmVmb3JlIFNGIGlzIGludHJvZHVjZWQuCgpZZXMsIHlvdSBhcmUgcmlnaHQs
IHNvcnJ5IGZvciB0aGUgbm9pc2UuCgo+IAo+IFRoYW5rcwo+IAo+IAo+ID4gCj4gPiBUaGFua3MK
PiA+IAo+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlh
LmNvbT4KPiA+ID4gCj4gPiA+IFBhdGNoIGxvb2tzIGNvcnJlY3QuCj4gPiA+IAo+ID4gPiBUaGFu
a3MKPiA+ID4gCj4gPiA+IAo+ID4gPiA+IC0tLQo+ID4gPiA+ICAgIGRyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYyB8IDIgKy0KPiA+ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jCj4gPiA+ID4gaW5kZXggYmMzM2YyYzUyM2QzLi5hNGZmMTU4MTgxZTAgMTAwNjQ0
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4g
KysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gQEAgLTIwNDYs
NyArMjA0Niw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdt
dF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSkKPiA+ID4gPiAgICAJaWYgKGVycikKPiA+
ID4gPiAgICAJCWdvdG8gZXJyX210dTsKPiA+ID4gPiAtCW12ZGV2LT52ZGV2LmRtYV9kZXYgPSBt
ZGV2LT5kZXZpY2U7Cj4gPiA+ID4gKwltdmRldi0+dmRldi5kbWFfZGV2ID0gJm1kZXYtPnBkZXYt
PmRldjsKPiA+ID4gPiAgICAJZXJyID0gbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcygmbmRldi0+
bXZkZXYpOwo+ID4gPiA+ICAgIAlpZiAoZXJyKQo+ID4gPiA+ICAgIAkJZ290byBlcnJfbXR1Owo+
ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4g
PiBWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPiA+ID4gVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKPiA+ID4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
