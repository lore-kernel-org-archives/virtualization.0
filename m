Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7EBCD98E6
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 03:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B754641E03;
	Wed, 11 Oct 2023 03:36:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B754641E03
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TjXrZNTt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IMWk54YAbjvu; Wed, 11 Oct 2023 03:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A62DC41DFE;
	Wed, 11 Oct 2023 03:36:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A62DC41DFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8788FC0071;
	Wed, 11 Oct 2023 03:36:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7088C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8DEC2822DF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:36:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DEC2822DF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TjXrZNTt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t1iqQDekT851
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:36:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38047822DD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:36:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38047822DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696995361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efH/kRpa4dE/gib/ZywGtOC3moOcqR+H8WuIqkhCM28=;
 b=TjXrZNTtUxNr+xjWGHGpGR/kLofd/25+ge4V4kBmurOr3PquPuORDAWmgfyAbwdEVAS2e3
 iWhqEmssmdbl7C6QsKQWqq3KASUK2Jgxbwlm1Xyl+wHkjO73NgrtQVFJ3wFEXJ+tutTNmN
 OS+/0GXiMzErcSP+li4vSMd948hd4f8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-fyjLOmNhO3-0-DRRCUOMRg-1; Tue, 10 Oct 2023 23:35:59 -0400
X-MC-Unique: fyjLOmNhO3-0-DRRCUOMRg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-503269edbb3so5924152e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696995358; x=1697600158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efH/kRpa4dE/gib/ZywGtOC3moOcqR+H8WuIqkhCM28=;
 b=E1+rR8yv7j4Jl4jA0m4bcrYrMVzlscyrjB3Bf2nu+Uz9uv7zyVz/gx8emK6jYIqxWX
 +MaC+RAXtbJBOmHRvHPEbG74q6iDk0HU7B3tI+ukRNm193I82y1VN3h2BWt15QfzGwn3
 8uUKu/gQxQUrt6MCHtd1TfisifNUI8/l88Ld1aKLnAeBrw9xVJf81PB/AQetd6cKAgjV
 IrrMWufbNCa/e3VljbNu7L6I0j1lSEIIGvTYyZDVE0H292O5zLvAtHZ87YJfKA/U5X0V
 7D90EbwMZHX38jexAEBYCBFpfLSaD1xn1M57OOJEXASQ6qp9KhRQZzQhPhiFL6bXfx5f
 p9yg==
X-Gm-Message-State: AOJu0YyoQg3o9YPz1QX89FDV6RhNNf7OjrDUUniJQyV/I+GdIOiRJWJZ
 WFdAZAP1JBjNPmXLb2LolZzHp6l3IvF7RwwA8OmgB7d6YRGSrJKoQdiUiZgJ+3/q6SMTv87Ah//
 zjPQhLaiTZ5vbov+WgK55TfkHZacvn710NfEPwz63nyZt/xKAcaZsL7iUGA==
X-Received: by 2002:a05:6512:39d4:b0:4fb:911b:4e19 with SMTP id
 k20-20020a05651239d400b004fb911b4e19mr20496056lfu.35.1696995358172; 
 Tue, 10 Oct 2023 20:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsxW7WXvT4VX4xQCqn4QnxcCYGhql8ZpBLV6t/egRsacik8SF7dLQseH0gZoTrcAeAO2SnyY1vAUybxgNCviw=
X-Received: by 2002:a05:6512:39d4:b0:4fb:911b:4e19 with SMTP id
 k20-20020a05651239d400b004fb911b4e19mr20496049lfu.35.1696995357862; Tue, 10
 Oct 2023 20:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
 <20231010031120.81272-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEtChiwWV7KPLTJ=GqxT24YJh7oXoE2JbpwWMPJE9053qA@mail.gmail.com>
 <1696924540.7843366-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1696924540.7843366-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Oct 2023 11:35:46 +0800
Message-ID: <CACGkMEvsip7PCRH=DNLjH4hQPseO1_R=KX+UH_c1ayHVi2nMxA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 3/4] virtio_pci: add check for common cfg size
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMzo1OOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAxMCBPY3QgMjAyMyAxNDo0MTozOSAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUs
IE9jdCAxMCwgMjAyMyBhdCAxMToxMeKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBTb21lIGJ1Z2d5IGRldmljZXMsIHRoZSBjb21t
b24gY2ZnIHNpemUgbWF5IG5vdCBtYXRjaCB0aGUgZmVhdHVyZXMuCj4gPiA+Cj4gPiA+IFRoaXMg
cGF0Y2ggY2hlY2tzIHRoZSBjb21tb24gY2ZnIHNpemUgZm9yIHRoZQo+ID4gPiBmZWF0dXJlcyhW
SVJUSU9fRl9OT1RJRl9DT05GSUdfREFUQSwgVklSVElPX0ZfUklOR19SRVNFVCkuIFdoZW4gdGhl
Cj4gPiA+IGNvbW1vbiBjZmcgc2l6ZSBkb2VzIG5vdCBtYXRjaCB0aGUgY29ycmVzcG9uZGluZyBm
ZWF0dXJlLCB3ZSBmYWlsIHRoZQo+ID4gPiBwcm9iZSBhbmQgcHJpbnQgZXJyb3IgbWVzc2FnZS4K
PiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVy
bi5jICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYyB8ICAyICstCj4gPiA+ICBpbmNsdWRlL2xpbnV4
L3ZpcnRpb19wY2lfbW9kZXJuLmggICAgICB8ICAxICsKPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
MzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbW9kZXJuLmMKPiA+ID4gaW5kZXggZDZiYjY4YmE4NGU1Li42YThmNWZmMDU2MzYgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiA+ID4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ID4gPiBAQCAtMzksNiAr
MzksMzkgQEAgc3RhdGljIHZvaWQgdnBfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gPiA+ICAgICAgICAgICAgICAgICBfX3ZpcnRp
b19zZXRfYml0KHZkZXYsIFZJUlRJT19GX1JJTkdfUkVTRVQpOwo+ID4gPiAgfQo+ID4gPgo+ID4g
PiArc3RhdGljIGludCBfX3ZwX2NoZWNrX2NvbW1vbl9zaXplX29uZV9mZWF0dXJlKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2LCB1MzIgZmJpdCwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1MzIgb2Zmc2V0LCBjb25zdCBjaGFyICpmbmFtZSkKPiA+
ID4gK3sKPiA+ID4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IHRv
X3ZwX2RldmljZSh2ZGV2KTsKPiA+ID4gKwo+ID4gPiArICAgICAgIGlmICghX192aXJ0aW9fdGVz
dF9iaXQodmRldiwgZmJpdCkpCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+ID4g
Kwo+ID4gPiArICAgICAgIGlmIChsaWtlbHkodnBfZGV2LT5tZGV2LmNvbW1vbl9sZW4gPj0gb2Zm
c2V0KSkKPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gPiArCj4gPiA+ICsgICAg
ICAgZGV2X2VycigmdmRldi0+ZGV2LAo+ID4gPiArICAgICAgICAgICAgICAgInZpcnRpbzogY29t
bW9uIGNmZyBzaXplKCVsZCkgZG9lcyBub3QgbWF0Y2ggdGhlIGZlYXR1cmUgJXNcbiIsCj4gPiA+
ICsgICAgICAgICAgICAgICB2cF9kZXYtPm1kZXYuY29tbW9uX2xlbiwgZm5hbWUpOwo+ID4gPiAr
Cj4gPiA+ICsgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gKyNk
ZWZpbmUgdnBfY2hlY2tfY29tbW9uX3NpemVfb25lX2ZlYXR1cmUodmRldiwgZmJpdCwgZmllbGQp
IFwKPiA+ID4gKyAgICAgICBfX3ZwX2NoZWNrX2NvbW1vbl9zaXplX29uZV9mZWF0dXJlKHZkZXYs
IGZiaXQsIFwKPiA+ID4gKyAgICAgICAgICAgICAgIG9mZnNldG9mZW5kKHN0cnVjdCB2aXJ0aW9f
cGNpX21vZGVybl9jb21tb25fY2ZnLCBmaWVsZCksICNmYml0KQo+ID4gPiArCj4gPiA+ICtzdGF0
aWMgaW50IHZwX2NoZWNrX2NvbW1vbl9zaXplKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
ID4gPiArewo+ID4gPiArICAgICAgIGlmICh2cF9jaGVja19jb21tb25fc2l6ZV9vbmVfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fRl9OT1RJRl9DT05GSUdfREFUQSwgcXVldWVfbm90aWZ5X2RhdGEpKQo+
ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ICsKPiA+ID4gKyAgICAg
ICBpZiAodnBfY2hlY2tfY29tbW9uX3NpemVfb25lX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklO
R19SRVNFVCwgcXVldWVfcmVzZXQpKQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7Cj4gPgo+ID4gRG8gd2UgbmVlZCB0byBhdCBsZWFzdCBjaGVjayB0aGUgb2Zmc2V0IG9mIHRo
ZSBxdWV1ZV9kZXZpY2UgYXMgd2VsbCBoZXJlPwo+Cj4KPiBOb3QgbmVlZC4KPgo+Cj4gLyoKPiAg
KiB2cF9tb2Rlcm5fbWFwX2NhcGFiaWxpdHkgLSBtYXAgYSBwYXJ0IG9mIHZpcnRpbyBwY2kgY2Fw
YWJpbGl0eQo+ICAqIEBtZGV2OiB0aGUgbW9kZXJuIHZpcnRpby1wY2kgZGV2aWNlCj4gICogQG9m
Zjogb2Zmc2V0IG9mIHRoZSBjYXBhYmlsaXR5Cj4gICogQG1pbmxlbjogbWluaW1hbCBsZW5ndGgg
b2YgdGhlIGNhcGFiaWxpdHkKPiAgKiBAYWxpZ246IGFsaWduIHJlcXVpcmVtZW50Cj4gICogQHN0
YXJ0OiBzdGFydCBmcm9tIHRoZSBjYXBhYmlsaXR5Cj4gICogQHNpemU6IG1hcCBzaXplCj4gICog
QGxlbjogdGhlIGxlbmd0aCB0aGF0IGlzIGFjdHVhbGx5IG1hcHBlZAo+ICAqIEBwYTogcGh5c2lj
YWwgYWRkcmVzcyBvZiB0aGUgY2FwYWJpbGl0eQo+ICAqCj4gICogUmV0dXJucyB0aGUgaW8gYWRk
cmVzcyBvZiBmb3IgdGhlIHBhcnQgb2YgdGhlIGNhcGFiaWxpdHkKPiAgKi8KPiBzdGF0aWMgdm9p
ZCBfX2lvbWVtICoKPiB2cF9tb2Rlcm5fbWFwX2NhcGFiaWxpdHkoc3RydWN0IHZpcnRpb19wY2lf
bW9kZXJuX2RldmljZSAqbWRldiwgaW50IG9mZiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZV90IG1pbmxlbiwgdTMyIGFsaWduLCB1MzIgc3RhcnQsIHUzMiBzaXplLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplX3QgKmxlbiwgcmVzb3VyY2Vfc2l6ZV90ICpwYSkKPgo+Cj4K
PiBjYWxsZXI6Cj4gICAgICAgICBtZGV2LT5jb21tb24gPSB2cF9tb2Rlcm5fbWFwX2NhcGFiaWxp
dHkobWRldiwgY29tbW9uLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZW9mKHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcpLCA0LAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMCwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVy
bl9jb21tb25fY2ZnKSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZt
ZGV2LT5jb21tb25fbGVuLCBOVUxMKTsKPgo+Cj4gV2UgcGFzcyB0aGUgc2l6ZW9mKHN0cnVjdCB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmcpIGFzIHRoZSBtaW5sZW4uCj4KPiBTbyB3ZSBkbyBub3QgbmVl
ZCB0byBjaGVjayB0aGUgY29tbW9uIGNmZyBzaXplIGlzIHNtYWxsZXIgdGhlbgo+IHNpemVvZihz
dHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnKS4KCkdyZWF0LgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPiA+Cj4gPiBU
aGFua3MKPiA+Cj4gPiA+ICsKPiA+ID4gKyAgICAgICByZXR1cm4gMDsKPiA+ID4gK30KPiA+ID4g
Kwo+ID4gPiAgLyogdmlydGlvIGNvbmZpZy0+ZmluYWxpemVfZmVhdHVyZXMoKSBpbXBsZW1lbnRh
dGlvbiAqLwo+ID4gPiAgc3RhdGljIGludCB2cF9maW5hbGl6ZV9mZWF0dXJlcyhzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPiA+ID4gIHsKPiA+ID4gQEAgLTU3LDYgKzkwLDkgQEAgc3RhdGlj
IGludCB2cF9maW5hbGl6ZV9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+
ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gPiAgICAgICAgIH0KPiA+ID4K
PiA+ID4gKyAgICAgICBpZiAodnBfY2hlY2tfY29tbW9uX3NpemUodmRldikpCj4gPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ID4gKwo+ID4gPiAgICAgICAgIHZwX21vZGVy
bl9zZXRfZmVhdHVyZXMoJnZwX2Rldi0+bWRldiwgdmRldi0+ZmVhdHVyZXMpOwo+ID4gPgo+ID4g
PiAgICAgICAgIHJldHVybiAwOwo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9k
ZXYuYwo+ID4gPiBpbmRleCA5Y2I2MDFlMTY2ODguLjMzZjMxOWRhMTU1OCAxMDA2NDQKPiA+ID4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiA+ID4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiA+ID4gQEAgLTI5Miw3ICsy
OTIsNyBAQCBpbnQgdnBfbW9kZXJuX3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZp
Y2UgKm1kZXYpCj4gPiA+ICAgICAgICAgbWRldi0+Y29tbW9uID0gdnBfbW9kZXJuX21hcF9jYXBh
YmlsaXR5KG1kZXYsIGNvbW1vbiwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2Yoc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyksIDQsCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgc2l6ZW9mKHN0cnVjdCB2aXJ0
aW9fcGNpX21vZGVybl9jb21tb25fY2ZnKSwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBOVUxMLCBOVUxMKTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmbWRldi0+Y29tbW9uX2xlbiwgTlVMTCk7Cj4gPiA+ICAgICAgICAgaWYg
KCFtZGV2LT5jb21tb24pCj4gPiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9tYXBfY29tbW9u
Owo+ID4gPiAgICAgICAgIG1kZXYtPmlzciA9IHZwX21vZGVybl9tYXBfY2FwYWJpbGl0eShtZGV2
LCBpc3IsIHNpemVvZih1OCksIDEsCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Zp
cnRpb19wY2lfbW9kZXJuLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiA+
ID4gaW5kZXggMDY3YWMxZDc4OWJjLi5lZGY2MmJhZTA0NzQgMTAwNjQ0Cj4gPiA+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiA+ID4gQEAgLTI4LDYgKzI4LDcgQEAgc3RydWN0IHZpcnRp
b19wY2lfbW9kZXJuX2RldmljZSB7Cj4gPiA+ICAgICAgICAgLyogU28gd2UgY2FuIHNhbml0eS1j
aGVjayBhY2Nlc3Nlcy4gKi8KPiA+ID4gICAgICAgICBzaXplX3Qgbm90aWZ5X2xlbjsKPiA+ID4g
ICAgICAgICBzaXplX3QgZGV2aWNlX2xlbjsKPiA+ID4gKyAgICAgICBzaXplX3QgY29tbW9uX2xl
bjsKPiA+ID4KPiA+ID4gICAgICAgICAvKiBDYXBhYmlsaXR5IGZvciB3aGVuIHdlIG5lZWQgdG8g
bWFwIG5vdGlmaWNhdGlvbnMgcGVyLXZxLiAqLwo+ID4gPiAgICAgICAgIGludCBub3RpZnlfbWFw
X2NhcDsKPiA+ID4gLS0KPiA+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4gPgo+ID4KPiA+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKPiA+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCj4gPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
