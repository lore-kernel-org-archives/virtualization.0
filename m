Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A1EC433EF
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 12:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78DAA4064D;
	Fri, 13 May 2022 12:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_gRrPKCQcNQ; Fri, 13 May 2022 12:29:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D749440614;
	Fri, 13 May 2022 12:29:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA6FDC0039;
	Fri, 13 May 2022 12:29:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C1A4C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E03A24064D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aY4GFkrX87HR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:29:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D812F40614
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652444962;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KwufUflIN0+si5g5sPE5FPx8DWaH5QC9MTJ9abHStk=;
 b=SxO8NglYj7UZWX7PZf69tMp5jxpfjRvs8/aMEx//WXfz+2t0kLHnXKJKLQCnXs9E/RP1xo
 fu9h9mRl23t9n7fIdd2aKhiW4NtqtlRZAT3Ncr8pKK0+MDKG9/DDulU5Ek8KM+a/7Tx728
 ZwDULd5byqaXjuzjPub3HHaebsZl1NY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-iVsCinzTPRipcbI6YnuQgg-1; Fri, 13 May 2022 08:29:19 -0400
X-MC-Unique: iVsCinzTPRipcbI6YnuQgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC60D1C05AF5;
 Fri, 13 May 2022 12:29:18 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F969C33AE5;
 Fri, 13 May 2022 12:29:16 +0000 (UTC)
Date: Fri, 13 May 2022 13:29:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>
Subject: Re: [External] [PATCH v5 5/9] crypto: Implement RSA algorithm by
 hogweed
Message-ID: <Yn5PGWPbP9C4k4wD@redhat.com>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
 <20220428135943.178254-6-pizhenwei@bytedance.com>
 <Yn45CxgJ+KNIxXek@redhat.com>
 <90F3B18B-9B7E-423C-A909-45D4527A6B3C@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90F3B18B-9B7E-423C-A909-45D4527A6B3C@bytedance.com>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: "S. Tsirkin, Michael" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBNYXkgMTMsIDIwMjIgYXQgMDg6MjY6MTRQTSArMDgwMCwg5L2V56OKIHdyb3RlOgo+
IAo+IAo+ID4gT24gTWF5IDEzLCAyMDIyLCBhdCA2OjU1IFBNLCBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToKPiA+IAo+ID4gT24gVGh1LCBBcHIgMjgsIDIw
MjIgYXQgMDk6NTk6MzlQTSArMDgwMCwgemhlbndlaSBwaSB3cm90ZToKPiA+PiBGcm9tOiBMZWkg
SGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gPj4gCj4gPj4gSW1wbGVtZW50IFJTQSBh
bGdvcml0aG0gYnkgaG9nd2VlZCBmcm9tIG5ldHRsZS4gVGh1cyBRRU1VIHN1cHBvcnRzCj4gPj4g
YSAncmVhbCcgUlNBIGJhY2tlbmQgdG8gaGFuZGxlIHJlcXVlc3QgZnJvbSBndWVzdCBzaWRlLiBJ
dCdzCj4gPj4gaW1wb3J0YW50IHRvIHRlc3QgUlNBIG9mZmxvYWQgY2FzZSB3aXRob3V0IE9TICYg
aGFyZHdhcmUgcmVxdWlyZW1lbnQuCj4gPj4gCj4gPj4gU2lnbmVkLW9mZi1ieTogbGVpIGhlIDxo
ZWxlaS5zaWcxMUBieXRlZGFuY2UuY29tPgo+ID4+IFNpZ25lZC1vZmYtYnk6IHpoZW53ZWkgcGkg
PHBpemhlbndlaUBieXRlZGFuY2UuY29tPgo+ID4+IC0tLQo+ID4+IGNyeXB0by9ha2NpcGhlci1u
ZXR0bGUuYy5pbmMgfCA0MzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+
PiBjcnlwdG8vYWtjaXBoZXIuYyAgICAgICAgICAgIHwgICA0ICsKPiA+PiBjcnlwdG8vbWVzb24u
YnVpbGQgICAgICAgICAgIHwgICA0ICsKPiA+PiBjcnlwdG8vcnNha2V5LWJ1aWx0aW4uYy5pbmMg
IHwgMjA5ICsrKysrKysrKysrKysrKysrCj4gPj4gY3J5cHRvL3JzYWtleS1uZXR0bGUuYy5pbmMg
ICB8IDE1NCArKysrKysrKysrKysrCj4gPj4gY3J5cHRvL3JzYWtleS5jICAgICAgICAgICAgICB8
ICA0NCArKysrCj4gPj4gY3J5cHRvL3JzYWtleS5oICAgICAgICAgICAgICB8ICA5NCArKysrKysr
Kwo+ID4+IG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgfCAgMTEgKwo+ID4+IDggZmlsZXMg
Y2hhbmdlZCwgOTUyIGluc2VydGlvbnMoKykKPiA+PiBjcmVhdGUgbW9kZSAxMDA2NDQgY3J5cHRv
L2FrY2lwaGVyLW5ldHRsZS5jLmluYwo+ID4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBjcnlwdG8vcnNh
a2V5LWJ1aWx0aW4uYy5pbmMKPiA+PiBjcmVhdGUgbW9kZSAxMDA2NDQgY3J5cHRvL3JzYWtleS1u
ZXR0bGUuYy5pbmMKPiA+PiBjcmVhdGUgbW9kZSAxMDA2NDQgY3J5cHRvL3JzYWtleS5jCj4gPj4g
Y3JlYXRlIG1vZGUgMTAwNjQ0IGNyeXB0by9yc2FrZXkuaAoKCj4gPj4gK3N0YXRpYyBpbnQgcWNy
eXB0b19uZXR0bGVfcnNhX2RlY3J5cHQoUUNyeXB0b0FrQ2lwaGVyICpha2NpcGhlciwKPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICplbmMsIHNp
emVfdCBlbmNfbGVuLAo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZvaWQgKmRhdGEsIHNpemVfdCBkYXRhX2xlbiwKPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApCj4gPj4gK3sKPiA+PiArICAgIFFDcnlwdG9O
ZXR0bGVSU0EgKnJzYSA9IChRQ3J5cHRvTmV0dGxlUlNBICopYWtjaXBoZXI7Cj4gPj4gKyAgICBt
cHpfdCBjOwo+ID4+ICsgICAgaW50IHJldCA9IC0xOwo+ID4+ICsgICAgaWYgKGVuY19sZW4gPiBy
c2EtPnByaXYuc2l6ZSkgewo+ID4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkludmFsaWQg
YnVmZmVyIHNpemUiKTsKPiA+PiArICAgICAgICByZXR1cm4gcmV0Owo+ID4+ICsgICAgfQo+ID4g
Cj4gPiBBZ2FpbiBwbGVhc2UgcmVwb3J0IHRoZSBpbnZhbGlkICYgZXhwZWN0ZWQgc2l6ZXMgaW4g
dGhlIG1lc3NhZ2UKPiA+IAo+ID4gV2UgZG9uJ3QgbmVlZCB0byB2YWxpZGF0ZSAnZGF0YV9sZW4n
IGluIHRoZSBkZWNyeXB0IGNhc2UsCj4gPiBhcyB5b3UgZGlkIGluIGVuY3J5cHQgPwo+IAo+IElu
IHRoZSBkZWNyeXB0IGNhc2UsIGl0IGlzIGRpZmZpY3VsdCAoYW5kIHVubmVjZXNzYXJ5KSB0byBj
aGVjayAnZGF0YV9sZW4nIGJlZm9yZSAKPiB3ZSBjb21wbGV0aW5nIHRoZSBkZWNyeXB0aW9uIGFj
dGlvbi4gSWYgdGhlIHBsYWludGV4dCBidWZmZXIgaXMgdG9vIHNtYWxsLCAKPiBmb2xsb3dpbmcg
4oCYcnNhX2RlY3J5cHTigJkgd2lsbCByZXR1cm4gYW4gZXJyb3IsIGFuZCBpdCBzaG91bGQgYmUg
dmFsaWQgdG8gcGFzcyBhIHZlcnkgCj4gbGFyZ2UgYnVmZmVyLgo+IAo+IEFjY29yZGluZyB0byB0
aGUgcGtjcyMxIHN0YXJkYXJkLCB0aGUgbGVuZ3RoIG9mIGNpcGhlcnRleHQgc2hvdWxkIGFsd2F5
cyBlcXVhbAo+IHRvIGtleSBzaXplLCBhbmQgdGhlIGxlbmd0aCBvZiBwbGFpbnRleHQgY2FuIGJl
IGFueSB2YWx1ZSBpbiByYW5nZSBbMSwga2V5X3NpemUgLSAxMV06Cj4gCj4gaHR0cHM6Ly9kYXRh
dHJhY2tlci5pZXRmLm9yZy9kb2MvaHRtbC9yZmMyNDM3I3NlY3Rpb24tNy4yCgpPaywgdGhhbmtz
IGZvciBleHBsYWluaW5nLgoKCldpdGggcmVnYXJkcywKRGFuaWVsCi0tIAp8OiBodHRwczovL2Jl
cnJhbmdlLmNvbSAgICAgIC1vLSAgICBodHRwczovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVy
cmFuZ2UgOnwKfDogaHR0cHM6Ly9saWJ2aXJ0Lm9yZyAgICAgICAgIC1vLSAgICAgICAgICAgIGh0
dHBzOi8vZnN0b3AxMzguYmVycmFuZ2UuY29tIDp8Cnw6IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8u
b3JnICAgIC1vLSAgICBodHRwczovL3d3dy5pbnN0YWdyYW0uY29tL2RiZXJyYW5nZSA6fAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
