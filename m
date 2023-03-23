Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE4C6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 03:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 669A441DBC;
	Thu, 23 Mar 2023 03:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 669A441DBC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y2Kt1gp7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qX8LhesIr0q; Thu, 23 Mar 2023 03:02:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ACEF441DB3;
	Thu, 23 Mar 2023 03:02:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACEF441DB3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92049C0035;
	Thu, 23 Mar 2023 03:02:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D20EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BD0881D7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:02:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BD0881D7C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y2Kt1gp7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOH095q-GjEa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:02:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DBC781D72
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DBC781D72
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679540544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1/q/ATjsfc/6alZ9skuNHGyOSWC2q/7g+svCIqwPXA=;
 b=Y2Kt1gp7ytHDE7Hd2iJj68fRa18H28cDkyoUNi8jy3g4kNAR05QmJrl9TXR4dbO3+pe59N
 I5VomsRxTWxjPuoT/Dz3OHthiAWWL2mu7b6OGyrz4HGAoDBx6x66jnNS6zAcbhbpJMGC1u
 SQdj3HNoRHxNOc757AzL49ddvlofjnw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-Uy_jm5wfPn2d_OHSm5zILw-1; Wed, 22 Mar 2023 23:02:22 -0400
X-MC-Unique: Uy_jm5wfPn2d_OHSm5zILw-1
Received: by mail-oo1-f72.google.com with SMTP id
 w3-20020a4ae083000000b0052645d4a2dfso6720989oos.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 20:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679540542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1/q/ATjsfc/6alZ9skuNHGyOSWC2q/7g+svCIqwPXA=;
 b=40QOZFaHMZsvmco6XEG8r6ZOt9IKadpy3p40WqEhB85ydo1pHHW6zdVOIollmK+VbP
 XyloulMYjD5Z4KH1s7B5g6J2LMCor3zo21G2s5xKNjT1vUU65PA8OJdmdZ7NJS1gZQ5y
 eO2ls5ZJYZ3KWS41rtdWuVI0Q3xTvlz3Iy6kfHPQ79VgZLc1a0DhkzOaAIO9bRM0WrQx
 1xDM35SNtQzlZBA4REhBETHVM4K3jt0P9V0jg7hMC62Ik9D4Z38b8sGaPCIbV+n/jNAK
 dFrbU1zsbyqsK5sLqL+UJS4GXP0P3NsVOKWsHdWeVWEI3Np1pPv7HzbvT9/tZtN91CMk
 QVsw==
X-Gm-Message-State: AO0yUKXymGwnS75JoDoUSG4CTF4uyJX0nG3/Wmx3fHCUxyfm5XGCRrj4
 Omvef6lIdE92T3Pl0N6s2xNXOMPmRe7ZwTbSgew6VPUEqJzvJammb2bYEuFC0hXQVgUoYPjnfdA
 aHvWBlhzHu6qnL4wnhbbNjTgq6ipoJfI4w+vyLViCpjS9DqW/8l+9FgyRxw==
X-Received: by 2002:a54:400a:0:b0:384:27f0:bd0a with SMTP id
 x10-20020a54400a000000b0038427f0bd0amr1632035oie.9.1679540542227; 
 Wed, 22 Mar 2023 20:02:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set8KGY7ymo8deUihSS/JSlAOb5tzZYOZLT+Km6uuakG63U+Wxly37yoFJagU90whn6RDzKuaNOE/YjnljkXMXVA=
X-Received: by 2002:a54:400a:0:b0:384:27f0:bd0a with SMTP id
 x10-20020a54400a000000b0038427f0bd0amr1632024oie.9.1679540541948; Wed, 22 Mar
 2023 20:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154228.182769-4-sgarzare@redhat.com>
In-Reply-To: <20230321154228.182769-4-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 11:02:11 +0800
Message-ID: <CACGkMEsnh9atkXwqn7gx0uKfPLLuph9ROh_0GvaUTXQfv01hkw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] vringh: replace kmap_atomic() with
 kmap_local_page()
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMTE6NDLigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNn
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4ga21hcF9hdG9taWMoKSBpcyBkZXByZWNhdGVk
IGluIGZhdm9yIG9mIGttYXBfbG9jYWxfcGFnZSgpIHNpbmNlIGNvbW1pdAo+IGYzYmEzYzcxMGFj
NSAoIm1tL2hpZ2htZW06IFByb3ZpZGUga21hcF9sb2NhbCoiKS4KPgo+IFdpdGgga21hcF9sb2Nh
bF9wYWdlKCkgdGhlIG1hcHBpbmdzIGFyZSBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGNhbiB0YWtl
Cj4gcGFnZS1mYXVsdHMsIGFuZCBjYW4gYmUgY2FsbGVkIGZyb20gYW55IGNvbnRleHQgKGluY2x1
ZGluZyBpbnRlcnJ1cHRzKS4KPiBGdXJ0aGVybW9yZSwgdGhlIHRhc2tzIGNhbiBiZSBwcmVlbXB0
ZWQgYW5kLCB3aGVuIHRoZXkgYXJlIHNjaGVkdWxlZCB0bwo+IHJ1biBhZ2FpbiwgdGhlIGtlcm5l
bCB2aXJ0dWFsIGFkZHJlc3NlcyBhcmUgcmVzdG9yZWQgYW5kIHN0aWxsIHZhbGlkLgo+Cj4ga21h
cF9hdG9taWMoKSBpcyBpbXBsZW1lbnRlZCBsaWtlIGEga21hcF9sb2NhbF9wYWdlKCkgd2hpY2gg
YWxzbyBkaXNhYmxlcwo+IHBhZ2UtZmF1bHRzIGFuZCBwcmVlbXB0aW9uICh0aGUgbGF0dGVyIG9u
bHkgZm9yICFQUkVFTVBUX1JUIGtlcm5lbHMsCj4gb3RoZXJ3aXNlIGl0IG9ubHkgZGlzYWJsZXMg
bWlncmF0aW9uKS4KPgo+IFRoZSBjb2RlIHdpdGhpbiB0aGUgbWFwcGluZ3MvdW4tbWFwcGluZ3Mg
aW4gZ2V0dTE2X2lvdGxiKCkgYW5kCj4gcHV0dTE2X2lvdGxiKCkgZG9uJ3QgZGVwZW5kIG9uIHRo
ZSBhYm92ZS1tZW50aW9uZWQgc2lkZSBlZmZlY3RzIG9mCj4ga21hcF9hdG9taWMoKSwgc28gdGhh
dCBtZXJlIHJlcGxhY2VtZW50cyBvZiB0aGUgb2xkIEFQSSB3aXRoIHRoZSBuZXcgb25lCj4gaXMg
YWxsIHRoYXQgaXMgcmVxdWlyZWQgKGkuZS4sIHRoZXJlIGlzIG5vIG5lZWQgdG8gZXhwbGljaXRs
eSBhZGQgY2FsbHMKPiB0byBwYWdlZmF1bHRfZGlzYWJsZSgpIGFuZC9vciBwcmVlbXB0X2Rpc2Fi
bGUoKSkuCj4KPiBUaGlzIGNvbW1pdCByZXVzZXMgYSAiYm9pbGVyIHBsYXRlIiBjb21taXQgbWVz
c2FnZSBmcm9tIEZhYmlvLCB3aG8gaGFzCj4gYWxyZWFkeSBkaWQgdGhpcyBjaGFuZ2UgaW4gc2V2
ZXJhbCBwbGFjZXMuCj4KPiBDYzogIkZhYmlvIE0uIERlIEZyYW5jZXNjbyIgPGZtZGVmcmFuY2Vz
Y29AZ21haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnph
cmVAcmVkaGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKVGhhbmtzCgo+IC0tLQo+Cj4gTm90ZXM6Cj4gICAgIHYzOgo+ICAgICAtIGNyZWRpdGVkIEZh
YmlvIGZvciB0aGUgY29tbWl0IG1lc3NhZ2UKPiAgICAgLSBhZGRlZCByZWZlcmVuY2UgdG8gdGhl
IGNvbW1pdCB0aGF0IGRlcHJlY2F0ZWQga21hcF9hdG9taWMoKSBbSmFzb25dCj4gICAgIHYyOgo+
ICAgICAtIGFkZGVkIHRoaXMgcGF0Y2ggc2luY2UgY2hlY2twYXRjaC5wbCBjb21wbGFpbmVkIGFi
b3V0IGRlcHJlY2F0aW9uCj4gICAgICAgb2Yga21hcF9hdG9taWMoKSB0b3VjaGVkIGJ5IG5leHQg
cGF0Y2gKPgo+ICBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jIHwgOCArKysrLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gaW5kZXgg
YTFlMjdkYTU0NDgxLi4wYmEzZWY4MDllNDggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92
cmluZ2guYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiBAQCAtMTIyMCwxMCArMTIy
MCwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBnZXR1MTZfaW90bGIoY29uc3Qgc3RydWN0IHZyaW5n
aCAqdnJoLAo+ICAgICAgICAgaWYgKHJldCA8IDApCj4gICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7Cj4KPiAtICAgICAgIGthZGRyID0ga21hcF9hdG9taWMoaW92LmJ2X3BhZ2UpOwo+ICsgICAg
ICAga2FkZHIgPSBrbWFwX2xvY2FsX3BhZ2UoaW92LmJ2X3BhZ2UpOwo+ICAgICAgICAgZnJvbSA9
IGthZGRyICsgaW92LmJ2X29mZnNldDsKPiAgICAgICAgICp2YWwgPSB2cmluZ2gxNl90b19jcHUo
dnJoLCBSRUFEX09OQ0UoKihfX3ZpcnRpbzE2ICopZnJvbSkpOwo+IC0gICAgICAga3VubWFwX2F0
b21pYyhrYWRkcik7Cj4gKyAgICAgICBrdW5tYXBfbG9jYWwoa2FkZHIpOwo+Cj4gICAgICAgICBy
ZXR1cm4gMDsKPiAgfQo+IEBAIC0xMjQxLDEwICsxMjQxLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50
IHB1dHUxNl9pb3RsYihjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4gICAgICAgICBpZiAocmV0
IDwgMCkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPgo+IC0gICAgICAga2FkZHIgPSBr
bWFwX2F0b21pYyhpb3YuYnZfcGFnZSk7Cj4gKyAgICAgICBrYWRkciA9IGttYXBfbG9jYWxfcGFn
ZShpb3YuYnZfcGFnZSk7Cj4gICAgICAgICB0byA9IGthZGRyICsgaW92LmJ2X29mZnNldDsKPiAg
ICAgICAgIFdSSVRFX09OQ0UoKihfX3ZpcnRpbzE2ICopdG8sIGNwdV90b192cmluZ2gxNih2cmgs
IHZhbCkpOwo+IC0gICAgICAga3VubWFwX2F0b21pYyhrYWRkcik7Cj4gKyAgICAgICBrdW5tYXBf
bG9jYWwoa2FkZHIpOwo+Cj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+IC0tCj4gMi4zOS4yCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
