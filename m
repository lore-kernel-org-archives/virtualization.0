Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B25EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 02:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDE7B404BF;
	Mon, 26 Jun 2023 02:50:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDE7B404BF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HQhWwHVt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_3dD5gXnpMd; Mon, 26 Jun 2023 02:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 62C9C4012D;
	Mon, 26 Jun 2023 02:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62C9C4012D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35DF7C0037;
	Mon, 26 Jun 2023 02:50:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93B8AC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F6C641484
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F6C641484
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HQhWwHVt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wC9K7o-ZVEUh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:50:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BC2241403
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BC2241403
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687747815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Hxhu9zIdf4LQi+vOmtXdoq6uw4aXlS1py64ceNeDIo=;
 b=HQhWwHVtT/OsnAyiN+au7f9vEZ+KcZ7A4oGGS2OY0iiNssi6pxa627W9o9ipxQ5IIUXos8
 gLyq0IG4kfIi4ouDkwRvrVt2oxaWYC2NVURuLoMUq2beQ33hvbTZGlyJ51mW790m9jHDo8
 qrEmVORWJUaPnvTK17+7f82r2rrwbCI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Dt6LzA67NjKnPUJg5GEPQw-1; Sun, 25 Jun 2023 22:50:13 -0400
X-MC-Unique: Dt6LzA67NjKnPUJg5GEPQw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edb90ccaadso1644492e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 19:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687747796; x=1690339796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Hxhu9zIdf4LQi+vOmtXdoq6uw4aXlS1py64ceNeDIo=;
 b=KmSk8eFqloEVf90SYOx/LrmJpFYae4i3jgrTuotsCk8fcbrSsiGI+hFrf+AnhDTzc7
 BqVwP6I//KAwVRAdw6vlMzojxN9F1pjzpv1+3JMsO43Ejn54P7ZYhltxr64UyZr7FVF9
 2kUZIiQ7E1ilPX6quXBKnuO/8IJsy7dZGdb5YLsmQgzSUbuj/el9Gae7dVADvWcUmclC
 auHefFnBrBgIZK9lP/vuAs/vcyA+7Nm36Ryxg1fMpoiAOguvgFiylK1U4wjP6jxQPvvP
 Q8/2P8SwbF2H8Qi/cWd0EDKLUIrMcMYTOYTswmUkmy2vi3Ct71IlQ8M00ryUwi7I84XL
 RJVQ==
X-Gm-Message-State: AC+VfDx0woPJifjEeHqh+xuuuTOGSZexpb5zRACFJzRGDof7HauJHBg8
 0a+yb6ij4IqJ1JSgFMkd3qVIzZVgKlnuprq5Ig6NMcQ5IHKPUrn/JiYJABErVSX//z8BP4gUGgF
 MCdAjs0HzkIW7Ii0VJQRnvUeaoe1JAgYtTiPzsTnWPO7I4ET8f0PLO0ietA==
X-Received: by 2002:a19:380f:0:b0:4f8:4512:c844 with SMTP id
 f15-20020a19380f000000b004f84512c844mr14335402lfa.48.1687747796777; 
 Sun, 25 Jun 2023 19:49:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6JgaU+/bgBsohPnffsKMW4QYnt0ySKaX2gSVKTgKRit1Px050SMJ3AZ7saDISMPjvQLIBlmcN2uM6iLyqAq+s=
X-Received: by 2002:a19:380f:0:b0:4f8:4512:c844 with SMTP id
 f15-20020a19380f000000b004f84512c844mr14335398lfa.48.1687747796492; Sun, 25
 Jun 2023 19:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151420.1019504-1-lingshan.zhu@intel.com>
 <20230612151420.1019504-2-lingshan.zhu@intel.com>
 <CACGkMEspGu+N-CpE8J=Ux3m=+zMOByGPJU=My2U-BGW9QOHNhg@mail.gmail.com>
 <43c2e0c9-4195-bbeb-a7ed-0947580cbfe4@intel.com>
In-Reply-To: <43c2e0c9-4195-bbeb-a7ed-0947580cbfe4@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 10:49:44 +0800
Message-ID: <CACGkMEvWtPZRWmoSF5oJcLadUufCneqR-4dCn_Yv5B+_pqf3ng@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] vDPA/ifcvf: dynamic allocate vq data stores
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

T24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgMTA6MzjigK9BTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hh
bi56aHVAaW50ZWwuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiA2LzI2LzIwMjMgMTA6MzIgQU0sIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIEp1biAxMiwgMjAyMyBhdCAzOjE04oCvUE0gWmh1
IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPiA+PiBUaGlzIGNvbW1p
dCBkeW5hbWljYWxseSBhbGxvY2F0ZXMgdGhlIGRhdGEKPiA+PiBzdG9yZXMgZm9yIHRoZSB2aXJ0
cXVldWVzIGJhc2VkIG9uCj4gPj4gdmlydGlvX3BjaV9jb21tb25fY2ZnLm51bV9xdWV1ZXMuCj4g
PiBXaGlsZSBhdCBpdCwgaXQncyBiZXR0ZXIgdG8gYWxsb2NhdGUgdnJpbmdfbG1fY2ZnIGFzIHdl
bGwgYW5kIGRyb3AKPiA+IElGQ1ZGX01BWF9RVUVVRVMuCj4gWWVzLCB0aGlzIGhhcyBiZWVuIGRv
bmUgaW4gMy8zIHBhdGNoIGluIHRoaXMgc2VyaWVzLgoKT2ssIHllcywgYnV0IGl0IHNlZW1zIHBh
dGNoIDMgaW1wbGVtZW50cyBhIGxvdCBvZiBsb2dpYyBzbyBJIHN1Z2dlc3QKbW92aW5nIGl0IHRv
IHBhdGNoIDEuCgpOb3Qgc3VyZSBpdCdzIHRvbyBsYXRlIHNpbmNlIEkgc2VlIHRoZSBwYXRjaCBo
YXMgYmVlbiBtZXJnZWQgYnkgTWljaGFlbC4KClRoYW5rcwoKPgo+IFRoYW5rcwo+IFpodSBMaW5n
c2hhbgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4g
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPj4gLS0tCj4gPj4gICBkcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jIHwgMyArKysKPiA+PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmggfCAyICstCj4gPj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMiAr
Kwo+ID4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
PiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ID4+IGluZGV4IDFiNWRhMTFmNTQwMy4u
Zjg2NDk1YWNlODI1IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmMKPiA+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gPj4gQEAg
LTEzNCw2ICsxMzQsOSBAQCBpbnQgaWZjdmZfaW5pdF9odyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCBz
dHJ1Y3QgcGNpX2RldiAqcGRldikKPiA+PiAgICAgICAgICB9Cj4gPj4KPiA+PiAgICAgICAgICBo
dy0+bnJfdnJpbmcgPSB2cF9pb3JlYWQxNigmaHctPmNvbW1vbl9jZmctPm51bV9xdWV1ZXMpOwo+
ID4+ICsgICAgICAgaHctPnZyaW5nID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHZyaW5nX2luZm8p
ICogaHctPm5yX3ZyaW5nLCBHRlBfS0VSTkVMKTsKPiA+PiArICAgICAgIGlmICghaHctPnZyaW5n
KQo+ID4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+Pgo+ID4+ICAgICAgICAg
IGZvciAoaSA9IDA7IGkgPCBody0+bnJfdnJpbmc7IGkrKykgewo+ID4+ICAgICAgICAgICAgICAg
ICAgdnBfaW93cml0ZTE2KGksICZody0+Y29tbW9uX2NmZy0+cXVldWVfc2VsZWN0KTsKPiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCBiL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiA+PiBpbmRleCAzMTEwZmZjNTBjYWYuLmZhNzk3MTg0MDU2
YiAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gPj4g
KysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ID4+IEBAIC03NCw3ICs3NCw3
IEBAIHN0cnVjdCBpZmN2Zl9odyB7Cj4gPj4gICAgICAgICAgdTY0IGRldl9mZWF0dXJlczsKPiA+
PiAgICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIF9faW9tZW0gKmNvbW1vbl9j
Zmc7Cj4gPj4gICAgICAgICAgdm9pZCBfX2lvbWVtICpkZXZfY2ZnOwo+ID4+IC0gICAgICAgc3Ry
dWN0IHZyaW5nX2luZm8gdnJpbmdbSUZDVkZfTUFYX1FVRVVFU107Cj4gPj4gKyAgICAgICBzdHJ1
Y3QgdnJpbmdfaW5mbyAqdnJpbmc7Cj4gPj4gICAgICAgICAgdm9pZCBfX2lvbWVtICogY29uc3Qg
KmJhc2U7Cj4gPj4gICAgICAgICAgY2hhciBjb25maWdfbXNpeF9uYW1lWzI1Nl07Cj4gPj4gICAg
ICAgICAgc3RydWN0IHZkcGFfY2FsbGJhY2sgY29uZmlnX2NiOwo+ID4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X21haW4uYwo+ID4+IGluZGV4IDZlNDdhYzJjNjY5YS4uMmFmMGRlNzcxYjQ5IDEwMDY0NAo+ID4+
IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiA+PiArKysgYi9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gPj4gQEAgLTgzMCw2ICs4MzAsNyBAQCBzdGF0aWMg
aW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCAqaWQpCj4gPj4gICAgICAgICAgcmV0dXJuIDA7Cj4gPj4KPiA+PiAgIGVycjoKPiA+
PiArICAgICAgIGtmcmVlKGlmY3ZmX21nbXRfZGV2LT52Zi52cmluZyk7Cj4gPj4gICAgICAgICAg
a2ZyZWUoaWZjdmZfbWdtdF9kZXYpOwo+ID4+ICAgICAgICAgIHJldHVybiByZXQ7Cj4gPj4gICB9
Cj4gPj4gQEAgLTg0MCw2ICs4NDEsNyBAQCBzdGF0aWMgdm9pZCBpZmN2Zl9yZW1vdmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYpCj4gPj4KPiA+PiAgICAgICAgICBpZmN2Zl9tZ210X2RldiA9IHBjaV9n
ZXRfZHJ2ZGF0YShwZGV2KTsKPiA+PiAgICAgICAgICB2ZHBhX21nbXRkZXZfdW5yZWdpc3Rlcigm
aWZjdmZfbWdtdF9kZXYtPm1kZXYpOwo+ID4+ICsgICAgICAga2ZyZWUoaWZjdmZfbWdtdF9kZXYt
PnZmLnZyaW5nKTsKPiA+PiAgICAgICAgICBrZnJlZShpZmN2Zl9tZ210X2Rldik7Cj4gPj4gICB9
Cj4gPj4KPiA+PiAtLQo+ID4+IDIuMzkuMQo+ID4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
