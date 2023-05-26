Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C537EC7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 07:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42D4042C87;
	Fri, 26 May 2023 07:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42D4042C87
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YvE3Du6B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bf5OpQfR_C0G; Fri, 26 May 2023 07:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7FB840158;
	Fri, 26 May 2023 07:06:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7FB840158
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79BF5C0036;
	Fri, 26 May 2023 07:06:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76FACC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 07:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 423C742894
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 07:06:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 423C742894
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YvE3Du6B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tXPkRmcCRyhn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 07:06:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D60EC4288E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D60EC4288E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 07:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685084805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBejMg+s8pn89tl0WoGSR+vknKwo5Dacmjq+sP5U8E0=;
 b=YvE3Du6BSq4tsu7IKCr4OJIJOT1xt2Bwg8rYb/3Qd7vvTxipIJvA3Cv0slKp8eX4UVi5PZ
 0yayOCdnEMihEGI5Y6PyUvZcVdQPajnDvwLZI+lEkuZhsOsaKTSNPWiLuTrI5n3h16COeq
 Bd3K+KZ2KXeFV4yCt5utXCnSzprcs8c=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-z0Kj3LHENWq7JPMS6oDZfw-1; Fri, 26 May 2023 03:06:42 -0400
X-MC-Unique: z0Kj3LHENWq7JPMS6oDZfw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af570dc8daso1650001fa.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 00:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685084801; x=1687676801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBejMg+s8pn89tl0WoGSR+vknKwo5Dacmjq+sP5U8E0=;
 b=VoFkLCklKMXqHGbDEPQZuqjO6JEtvEMoK2dlRmU15i72nMDnwdNdO2to4pz7CgtEFb
 3WauWZEedyMgKKUluJZmEdJS62Sd5Pt0DlNYwNR7gGMznuSPGzHzLOvYyimIGG6KuDpM
 9oZznpMwPpqAjB8uZP4XWQRwSpSyT5jpbovI43Rj2Dsx2zGbxwgQS7OQMuLL47DHIkp5
 l7UPHuGhvFHL69sbCa8nqvBRjW959n1AJFX+3ViUC5IQ/VRAojkZgaegar1bDjimT98b
 6CAujOxEqq+Vwgq3YGwRFDwC7otmxdF8flz9UIDeE13w+vS725dVeZHf3u6tl2L2+X2y
 LV0g==
X-Gm-Message-State: AC+VfDxYWgKJtlrkyUnfhkOTz9snJrLTuINPV2jK6BHdQ5Ct9+2l3MxM
 dOAQ/B1NyGWc9snTmqU2Baf3pNAM1453ApXr0rYYgOGM9f7NFMo8/1KoJeaKw+sr4n68RW+ORY+
 PNSIIPCdKl+dxlF+Zbn/OrTIkDfW4sL9M3t3yz6ebp/T3qU9tsONVi94Hnw==
X-Received: by 2002:a2e:7817:0:b0:2ac:8c5e:e151 with SMTP id
 t23-20020a2e7817000000b002ac8c5ee151mr451667ljc.31.1685084801107; 
 Fri, 26 May 2023 00:06:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sHDrHvdUXjE/f4RLyIFJiZ9+BIhhYVMPihHPnwvEGGl1gTbFH1d/Kkjl1jRuizOa84yxiFWZP2XxBPAfuKMg=
X-Received: by 2002:a2e:7817:0:b0:2ac:8c5e:e151 with SMTP id
 t23-20020a2e7817000000b002ac8c5ee151mr451649ljc.31.1685084800799; Fri, 26 May
 2023 00:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-5-liangchen.linux@gmail.com>
In-Reply-To: <20230526054621.18371-5-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 15:06:29 +0800
Message-ID: <CACGkMEsrr-3ArBgCksq=c60+5fZ-Xc-i653ix_vdr2f7c7wYfg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: Implement DMA pre-handler
To: Liang Chen <liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMTo0N+KAr1BNIExpYW5nIENoZW4gPGxpYW5nY2hlbi5s
aW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gQWRkaW5nIGEgRE1BIHByZS1oYW5kbGVyIHRoYXQg
dXRpbGl6ZXMgcGFnZSBwb29sIGZvciBtYW5hZ2luZyBETUEgbWFwcGluZ3MuCj4gV2hlbiBJT01N
VSBpcyBlbmFibGVkLCB0dXJuaW5nIG9uIHRoZSBwYWdlX3Bvb2xfZG1hX21hcCBtb2R1bGUgcGFy
YW1ldGVyIHRvCj4gc2VsZWN0IHBhZ2UgcG9vbCBmb3IgRE1BIG1hcHBpbmcgbWFuYWdlbWVudCBn
aXZlcyBhIHNpZ25pZmljYW50IHJlZHVjdGlvbgo+IGluIHRoZSBvdmVyaGVhZCBjYXVzZWQgYnkg
RE1BIG1hcHBpbmdzLgo+Cj4gSW4gdGVzdGluZyBlbnZpcm9ubWVudHMgd2l0aCBhIHNpbmdsZSBj
b3JlIHZtIGFuZCBxZW11IGVtdWxhdGVkIElPTU1VLAo+IHNpZ25pZmljYW50IHBlcmZvcm1hbmNl
IGltcHJvdmVtZW50cyBjYW4gYmUgb2JzZXJ2ZWQ6Cj4gICBVcHN0cmVhbSBjb2RlYmFzZTogMS43
NiBHYml0cy9zZWMKPiAgIFVwc3RyZWFtIGNvZGViYXNlIHdpdGggcGFnZSBwb29sIGZyYWdtZW50
YXRpb24gc3VwcG9ydDogMS44MSBHYml0cy9zZWMKPiAgIFVwc3RyZWFtIGNvZGViYXNlIHdpdGgg
cGFnZSBwb29sIGZyYWdtZW50YXRpb24gYW5kIERNQSBzdXBwb3J0OiAxOS4zCj4gICBHYml0cy9z
ZWMKPgo+IFNpZ25lZC1vZmYtYnk6IExpYW5nIENoZW4gPGxpYW5nY2hlbi5saW51eEBnbWFpbC5j
b20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDU1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDU1IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCBhYzQwYjhjNjZjNTkuLjczY2M0ZjlmZTRmYSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiBAQCAtMjIsNiArMjIsNyBAQAo+ICAjaW5jbHVkZSA8bmV0L3JvdXRlLmg+
Cj4gICNpbmNsdWRlIDxuZXQveGRwLmg+Cj4gICNpbmNsdWRlIDxuZXQvbmV0X2ZhaWxvdmVyLmg+
Cj4gKyNpbmNsdWRlIDxsaW51eC9pb21tdS5oPgo+Cj4gIHN0YXRpYyBpbnQgbmFwaV93ZWlnaHQg
PSBOQVBJX1BPTExfV0VJR0hUOwo+ICBtb2R1bGVfcGFyYW0obmFwaV93ZWlnaHQsIGludCwgMDQ0
NCk7Cj4gQEAgLTMzLDggKzM0LDEwIEBAIG1vZHVsZV9wYXJhbShuYXBpX3R4LCBib29sLCAwNjQ0
KTsKPgo+ICBzdGF0aWMgYm9vbCBwYWdlX3Bvb2xfZW5hYmxlZDsKPiAgc3RhdGljIGJvb2wgcGFn
ZV9wb29sX2ZyYWc7Cj4gK3N0YXRpYyBib29sIHBhZ2VfcG9vbF9kbWFfbWFwOwo+ICBtb2R1bGVf
cGFyYW0ocGFnZV9wb29sX2VuYWJsZWQsIGJvb2wsIDA0MDApOwo+ICBtb2R1bGVfcGFyYW0ocGFn
ZV9wb29sX2ZyYWcsIGJvb2wsIDA0MDApOwo+ICttb2R1bGVfcGFyYW0ocGFnZV9wb29sX2RtYV9t
YXAsIGJvb2wsIDA0MDApOwo+Cj4gIC8qIEZJWE1FOiBNVFUgaW4gY29uZmlnLiAqLwo+ICAjZGVm
aW5lIEdPT0RfUEFDS0VUX0xFTiAoRVRIX0hMRU4gKyBWTEFOX0hMRU4gKyBFVEhfREFUQV9MRU4p
Cj4gQEAgLTM4MzAsNiArMzgzMyw0OSBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2RlbF92cXMoc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICAgICAgICB2aXJ0bmV0X2ZyZWVfcXVldWVzKHZpKTsK
PiAgfQo+Cj4gK3N0YXRpYyBkbWFfYWRkcl90IHZpcnRuZXRfcHBfZG1hX21hcF9wYWdlKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IHBhZ2UgKnBhZ2UsCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBvZmZzZXQsIHNpemVfdCBzaXplLAo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gZG1hX2RhdGFf
ZGlyZWN0aW9uIGRpciwgdW5zaWduZWQgbG9uZyBhdHRycykKPiArewo+ICsgICAgICAgc3RydWN0
IHBhZ2UgKmhlYWRfcGFnZTsKPiArCj4gKyAgICAgICBpZiAoZGlyICE9IERNQV9GUk9NX0RFVklD
RSkKPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKwo+ICsgICAgICAgaGVhZF9wYWdlID0g
Y29tcG91bmRfaGVhZChwYWdlKTsKPiArICAgICAgIHJldHVybiBwYWdlX3Bvb2xfZ2V0X2RtYV9h
ZGRyKGhlYWRfcGFnZSkKPiArICAgICAgICAgICAgICAgKyAocGFnZSAtIGhlYWRfcGFnZSkgKiBQ
QUdFX1NJWkUKPiArICAgICAgICAgICAgICAgKyBvZmZzZXQ7CgpTbyBpdCdzIG5vdCBhIG1hcCwg
aXQgaXMganVzdCBhIHF1ZXJ5IGZyb20gdGhlIGRtYSBhZGRyZXNzIGZyb20gdGhlIHBvb2wuCgo+
ICt9Cj4gKwo+ICtzdGF0aWMgYm9vbCB2aXJ0bmV0X3BwX2RtYV91bm1hcF9wYWdlKHN0cnVjdCBk
ZXZpY2UgKmRldiwgZG1hX2FkZHJfdCBkbWFfaGFuZGxlLAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZV90IHNpemUsIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uIGRp
ciwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
YXR0cnMpCj4gK3sKPiArICAgICAgIHBoeXNfYWRkcl90IHBoeXM7Cj4gKwo+ICsgICAgICAgLyog
SGFuZGxlIG9ubHkgdGhlIFJYIGRpcmVjdGlvbiwgYW5kIHN5bmMgdGhlIERNQSBtZW1vcnkgb25s
eSBpZiBpdCdzIG5vdAo+ICsgICAgICAgICogYSBETUEgY29oZXJlbnQgYXJjaGl0ZWN0dXJlLgo+
ICsgICAgICAgICovCj4gKyAgICAgICBpZiAoZGlyICE9IERNQV9GUk9NX0RFVklDRSkKPiArICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ICsKPiArICAgICAgIGlmIChkZXZfaXNfZG1hX2Nv
aGVyZW50KGRldikpCj4gKyAgICAgICAgICAgICAgIHJldHVybiB0cnVlOwo+ICsKPiArICAgICAg
IHBoeXMgPSBpb21tdV9pb3ZhX3RvX3BoeXMoaW9tbXVfZ2V0X2RtYV9kb21haW4oZGV2KSwgZG1h
X2hhbmRsZSk7CgpUaGlzIHdvdWxkIGJlIHNvbWVob3cgc2xvdy4gSWYgd2UgdHJhY2sgdGhlIG1h
cHBpbmcgYnkgZHJpdmVyLCBpdAp3b3VsZCBiZSBtdWNoIGZhc3Rlci4KCk1vcmUgY291bGQgYmUg
c2VlbiBoZXJlOgoKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL3BpcGVybWFpbC92
aXJ0dWFsaXphdGlvbi8yMDIzLU1heS8wNjY3NzguaHRtbAoKVGhhbmtzCgo+ICsgICAgICAgaWYg
KFdBUk5fT04oIXBoeXMpKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4gKwo+ICsg
ICAgICAgYXJjaF9zeW5jX2RtYV9mb3JfY3B1KHBoeXMsIHNpemUsIGRpcik7Cj4gKyAgICAgICBy
ZXR1cm4gdHJ1ZTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVldWVfcHJlX2RtYV9v
cHMgdmlydG5ldF9wcF9wcmVfZG1hX29wcyA9IHsKPiArICAgICAgIC5tYXBfcGFnZSA9IHZpcnRu
ZXRfcHBfZG1hX21hcF9wYWdlLAo+ICsgICAgICAgLnVubWFwX3BhZ2UgPSB2aXJ0bmV0X3BwX2Rt
YV91bm1hcF9wYWdlLAo+ICt9Owo+ICsKPiAgc3RhdGljIHZvaWQgdmlydG5ldF9hbGxvY19wYWdl
X3Bvb2woc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldiA9IHJxLT52cS0+dmRldjsKPiBAQCAtMzg0NSw2ICszODkxLDE1IEBA
IHN0YXRpYyB2b2lkIHZpcnRuZXRfYWxsb2NfcGFnZV9wb29sKHN0cnVjdCByZWNlaXZlX3F1ZXVl
ICpycSkKPiAgICAgICAgIGlmIChwYWdlX3Bvb2xfZnJhZykKPiAgICAgICAgICAgICAgICAgcHBf
cGFyYW1zLmZsYWdzIHw9IFBQX0ZMQUdfUEFHRV9GUkFHOwo+Cj4gKyAgICAgICAvKiBDb25zaWRl
ciB1c2luZyBwYWdlIHBvb2wgRE1BIHN1cHBvcnQgb25seSB3aGVuIERNQSBBUEkgaXMgdXNlZC4g
Ki8KPiArICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfQUNDRVNT
X1BMQVRGT1JNKSAmJgo+ICsgICAgICAgICAgIHBhZ2VfcG9vbF9kbWFfbWFwKSB7Cj4gKyAgICAg
ICAgICAgICAgIHBwX3BhcmFtcy5mbGFncyB8PSBQUF9GTEFHX0RNQV9NQVAgfCBQUF9GTEFHX0RN
QV9TWU5DX0RFVjsKPiArICAgICAgICAgICAgICAgcHBfcGFyYW1zLmRtYV9kaXIgPSBETUFfRlJP
TV9ERVZJQ0U7Cj4gKyAgICAgICAgICAgICAgIHBwX3BhcmFtcy5tYXhfbGVuID0gUEFHRV9TSVpF
IDw8IHBwX3BhcmFtcy5vcmRlcjsKPiArICAgICAgICAgICAgICAgdmlydHF1ZXVlX3JlZ2lzdGVy
X3ByZV9kbWFfb3BzKHJxLT52cSwgJnZpcnRuZXRfcHBfcHJlX2RtYV9vcHMpOwo+ICsgICAgICAg
fQo+ICsKPiAgICAgICAgIHJxLT5wYWdlX3Bvb2wgPSBwYWdlX3Bvb2xfY3JlYXRlKCZwcF9wYXJh
bXMpOwo+ICAgICAgICAgaWYgKElTX0VSUihycS0+cGFnZV9wb29sKSkgewo+ICAgICAgICAgICAg
ICAgICBkZXZfd2FybigmdmRldi0+ZGV2LCAicGFnZSBwb29sIGNyZWF0aW9uIGZhaWxlZDogJWxk
XG4iLAo+IC0tCj4gMi4zMS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
