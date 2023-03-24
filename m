Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E3C6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 14:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DD008421A;
	Fri, 24 Mar 2023 14:40:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DD008421A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ul662qew
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UrfBqYrWx4sC; Fri, 24 Mar 2023 14:40:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C33484211;
	Fri, 24 Mar 2023 14:40:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C33484211
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6913CC0071;
	Fri, 24 Mar 2023 14:40:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15384C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 250A041E12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:40:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 250A041E12
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ul662qew
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8i1U1PCZkkX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:39:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EC7340BC2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EC7340BC2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679668798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMmYpV/LQ/c9lboloM+FB9+ISpjrbEj6iQBO9Iln0u8=;
 b=Ul662qew2931U8Z4PtR48M/iQky47NY3tQehg6KABrI5wpss4llMvf52g5uCZlT7xOpsgr
 S7yAgFI+8Inv28w6MRQaYdn5AGNVTX+ZZFW2Xyx3S4aLCBDNpUikk9qoxZwiRY/fYSlm+h
 HVz/JUOOp5wpYl2rbrQLiGqBtYoV+UE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-cr-8PAd6PWm4UXux62xcPA-1; Fri, 24 Mar 2023 10:39:56 -0400
X-MC-Unique: cr-8PAd6PWm4UXux62xcPA-1
Received: by mail-ed1-f70.google.com with SMTP id
 p36-20020a056402502400b004bb926a3d54so3510924eda.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679668793;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMmYpV/LQ/c9lboloM+FB9+ISpjrbEj6iQBO9Iln0u8=;
 b=esGgTP6OdHgKuD6PMsT0f9zVpAZVcRRVYNvaNTV3HaJG79txVNrmFOmSuDkMvhGRsk
 kk6UXhp6BaFLbuJTTKWlbrrtfjX0X8o7HrXiQmGNsKL1f7B677rfjldExjL7sBHRcxip
 jK5EeD3BXd/GChYGj11wpUC77Do4ZzbUNwTJnRWZRCUWXU35leFVf+xMIOcvNJAfRceB
 xNmTNwYvuap8v+Z4FWSewtYguTpzSmptCYlVYob0bSwBYZQu+4ZGqe4HbM1vY7Yu1CXt
 Vov6avp+lfuf0HDEQERE4sHwhs2oRGWTCVcpxiS2srHgG6jOe8X4dWAHL0Gy6XZxG0kw
 x39A==
X-Gm-Message-State: AAQBX9ewLGJqqYrkZSFnAgHf9WZm1i/u8QzfmZ/xVKStBNHYDd5kEHkH
 xqDNx2EJqxy+t4G+Euj0qCGrveOaX0pACxX98NWr8wsxtuSd7AiJbopvgCFxEP2n7eMTlzGQgvK
 wv+IIGPD1AbzAYwQC1GLFP52IraWQUdxUxb46hnls8w==
X-Received: by 2002:a17:906:e112:b0:933:1b05:8851 with SMTP id
 gj18-20020a170906e11200b009331b058851mr2845609ejb.16.1679668793612; 
 Fri, 24 Mar 2023 07:39:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4yRoRccUD6nI6QABMFjTLkWl/XWytdR65GGNlDWyNT8S11dQr5KKX4NxzjLSJru2A56ABJA==
X-Received: by 2002:a17:906:e112:b0:933:1b05:8851 with SMTP id
 gj18-20020a170906e11200b009331b058851mr2845585ejb.16.1679668793333; 
 Fri, 24 Mar 2023 07:39:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 b4-20020a17090630c400b0092b5384d6desm10339713ejb.153.2023.03.24.07.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 07:39:52 -0700 (PDT)
Date: Fri, 24 Mar 2023 15:39:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v3 4/8] vringh: support VA with iotlb
Message-ID: <xjhkyuurmxoispl2ndpeq4w3zsivq56lq4siw3cv3k5ucf7i43@e2ydqxiyxglc>
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154228.182769-5-sgarzare@redhat.com>
 <CAJaqyWcCwwu1UJ968A=s30GCezjLcwWKDhCFMsQ2EcGGgkiz7g@mail.gmail.com>
 <20230323104638.67hbwwbk7ayp4psq@sgarzare-redhat>
 <CAJaqyWfSor5PKZn0iAOthCkeGDBc7+rjVXuSHMy1LWY+fV5o7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfSor5PKZn0iAOthCkeGDBc7+rjVXuSHMy1LWY+fV5o7A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMDM6NDM6MzRQTSArMDEwMCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj5PbiBUaHUsIE1hciAyMywgMjAyMyBhdCAxMTo0NuKAr0FNIFN0ZWZhbm8g
R2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIFRodSwgTWFy
IDIzLCAyMDIzIGF0IDA5OjA5OjE0QU0gKzAxMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3Rl
Ogo+PiA+T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNDo0M+KAr1BNIFN0ZWZhbm8gR2FyemFyZWxs
YSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+ID4+Cj4+ID4+IHZEUEEgc3VwcG9ydHMg
dGhlIHBvc3NpYmlsaXR5IHRvIHVzZSB1c2VyIFZBIGluIHRoZSBpb3RsYiBtZXNzYWdlcy4KPj4g
Pj4gU28sIGxldCdzIGFkZCBzdXBwb3J0IGZvciB1c2VyIFZBIGluIHZyaW5naCB0byB1c2UgaXQg
aW4gdGhlIHZEUEEKPj4gPj4gc2ltdWxhdG9ycy4KPj4gPj4KPj4gPj4gU2lnbmVkLW9mZi1ieTog
U3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+PiA+PiAtLS0KPj4gPj4K
Pj4gPj4gTm90ZXM6Cj4+ID4+ICAgICB2MzoKPj4gPj4gICAgIC0gcmVmYWN0b3JlZCBhdm9pZGlu
ZyBjb2RlIGR1cGxpY2F0aW9uIFtFdWdlbmlvXQo+PiA+PiAgICAgdjI6Cj4+ID4+ICAgICAtIHJl
cGxhY2Uga21hcF9hdG9taWMoKSB3aXRoIGttYXBfbG9jYWxfcGFnZSgpIFtzZWUgcHJldmlvdXMg
cGF0Y2hdCj4+ID4+ICAgICAtIGZpeCBjYXN0IHdhcm5pbmdzIHdoZW4gYnVpbGQgd2l0aCBXPTEg
Qz0xCj4+ID4+Cj4+ID4+ICBpbmNsdWRlL2xpbnV4L3ZyaW5naC5oICAgICAgICAgICAgfCAgIDUg
Ky0KPj4gPj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8ICAgMiArLQo+PiA+
PiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgIHwgICA0ICstCj4+ID4+ICBkcml2
ZXJzL3Zob3N0L3ZyaW5naC5jICAgICAgICAgICAgfCAxNTMgKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tCj4+ID4+ICA0IGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspLCAzNyBk
ZWxldGlvbnMoLSkKPj4gPj4KPj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdnJpbmdo
LmggYi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4+ID4+IGluZGV4IDE5OTFhMDJjNjQzMS4uZDM5
YjlmMmRjYmEwIDEwMDY0NAo+PiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4+ID4+
ICsrKyBiL2luY2x1ZGUvbGludXgvdnJpbmdoLmgKPj4gPj4gQEAgLTMyLDYgKzMyLDkgQEAgc3Ry
dWN0IHZyaW5naCB7Cj4+ID4+ICAgICAgICAgLyogQ2FuIHdlIGdldCBhd2F5IHdpdGggd2VhayBi
YXJyaWVycz8gKi8KPj4gPj4gICAgICAgICBib29sIHdlYWtfYmFycmllcnM7Cj4+ID4+Cj4+ID4+
ICsgICAgICAgLyogVXNlIHVzZXIncyBWQSAqLwo+PiA+PiArICAgICAgIGJvb2wgdXNlX3ZhOwo+
PiA+PiArCj4+ID4+ICAgICAgICAgLyogTGFzdCBhdmFpbGFibGUgaW5kZXggd2Ugc2F3IChpZS4g
d2hlcmUgd2UncmUgdXAgdG8pLiAqLwo+PiA+PiAgICAgICAgIHUxNiBsYXN0X2F2YWlsX2lkeDsK
Pj4gPj4KPj4gPj4gQEAgLTI3OSw3ICsyODIsNyBAQCB2b2lkIHZyaW5naF9zZXRfaW90bGIoc3Ry
dWN0IHZyaW5naCAqdnJoLCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+PiA+PiAgICAgICAg
ICAgICAgICAgICAgICAgc3BpbmxvY2tfdCAqaW90bGJfbG9jayk7Cj4+ID4+Cj4+ID4+ICBpbnQg
dnJpbmdoX2luaXRfaW90bGIoc3RydWN0IHZyaW5naCAqdnJoLCB1NjQgZmVhdHVyZXMsCj4+ID4+
IC0gICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbnVtLCBib29sIHdlYWtfYmFycmll
cnMsCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbnVtLCBib29sIHdl
YWtfYmFycmllcnMsIGJvb2wgdXNlX3ZhLAo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZyaW5nX2Rlc2MgKmRlc2MsCj4+ID4+ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dnJpbmdfYXZhaWwgKmF2YWlsLAo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZy
aW5nX3VzZWQgKnVzZWQpOwo+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+ID4+IGlu
ZGV4IDUyMDY0NmFlN2ZhMC4uZGZkMGUwMDAyMTdiIDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gPj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+ID4+IEBAIC0yNTM3LDcgKzI1MzcsNyBAQCBzdGF0aWMgaW50IHNl
dHVwX2N2cV92cmluZyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4+ID4+Cj4+ID4+ICAg
ICAgICAgaWYgKG12ZGV2LT5hY3R1YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9D
VFJMX1ZRKSkKPj4gPj4gICAgICAgICAgICAgICAgIGVyciA9IHZyaW5naF9pbml0X2lvdGxiKCZj
dnEtPnZyaW5nLCBtdmRldi0+YWN0dWFsX2ZlYXR1cmVzLAo+PiA+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTUxYNV9DVlFfTUFYX0VOVCwgZmFsc2UsCj4+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTFg1X0NWUV9NQVhfRU5ULCBm
YWxzZSwgZmFsc2UsCj4+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoc3RydWN0IHZyaW5nX2Rlc2MgKikodWludHB0cl90KWN2cS0+ZGVzY19hZGRyLAo+PiA+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCB2cmluZ19hdmFp
bCAqKSh1aW50cHRyX3QpY3ZxLT5kcml2ZXJfYWRkciwKPj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3QgdnJpbmdfdXNlZCAqKSh1aW50cHRyX3QpY3Zx
LT5kZXZpY2VfYWRkcik7Cj4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+ID4+IGluZGV4
IGVlYTIzYzYzMGY3Yy4uNDdjZGYyYTFmNWI4IDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PiA+PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+PiA+PiBAQCAtNjAsNyArNjAsNyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3F1
ZXVlX3JlYWR5KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB1bnNpZ25lZCBpbnQgaWR4KQo+PiA+
PiAgICAgICAgIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEgPSAmdmRwYXNpbS0+dnFzW2lk
eF07Cj4+ID4+ICAgICAgICAgdWludDE2X3QgbGFzdF9hdmFpbF9pZHggPSB2cS0+dnJpbmcubGFz
dF9hdmFpbF9pZHg7Cj4+ID4+Cj4+ID4+IC0gICAgICAgdnJpbmdoX2luaXRfaW90bGIoJnZxLT52
cmluZywgdmRwYXNpbS0+ZmVhdHVyZXMsIHZxLT5udW0sIHRydWUsCj4+ID4+ICsgICAgICAgdnJp
bmdoX2luaXRfaW90bGIoJnZxLT52cmluZywgdmRwYXNpbS0+ZmVhdHVyZXMsIHZxLT5udW0sIHRy
dWUsIGZhbHNlLAo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3QgdnJpbmdf
ZGVzYyAqKSh1aW50cHRyX3QpdnEtPmRlc2NfYWRkciwKPj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAoc3RydWN0IHZyaW5nX2F2YWlsICopCj4+ID4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHVpbnRwdHJfdCl2cS0+ZHJpdmVyX2FkZHIsCj4+ID4+IEBAIC05Miw3ICs5Miw3IEBA
IHN0YXRpYyB2b2lkIHZkcGFzaW1fdnFfcmVzZXQoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sCj4+
ID4+ICAgICAgICAgdnEtPmNiID0gTlVMTDsKPj4gPj4gICAgICAgICB2cS0+cHJpdmF0ZSA9IE5V
TEw7Cj4+ID4+ICAgICAgICAgdnJpbmdoX2luaXRfaW90bGIoJnZxLT52cmluZywgdmRwYXNpbS0+
ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzLAo+PiA+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgIFZEUEFTSU1fUVVFVUVfTUFYLCBmYWxzZSwgTlVMTCwgTlVMTCwgTlVMTCk7Cj4+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgVkRQQVNJTV9RVUVVRV9NQVgsIGZhbHNlLCBmYWxzZSwg
TlVMTCwgTlVMTCwgTlVMTCk7Cj4+ID4+Cj4+ID4+ICAgICAgICAgdnEtPnZyaW5nLm5vdGlmeSA9
IE5VTEw7Cj4+ID4+ICB9Cj4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5j
IGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+PiA+PiBpbmRleCAwYmEzZWY4MDllNDguLjcyYzg4
NTE5MzI5YSAxMDA2NDQKPj4gPj4gLS0tIGEvZHJpdmVycy92aG9zdC92cmluZ2guYwo+PiA+PiAr
KysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+ID4+IEBAIC0xMDk0LDEwICsxMDk0LDE4IEBA
IEVYUE9SVF9TWU1CT0wodnJpbmdoX25lZWRfbm90aWZ5X2tlcm4pOwo+PiA+Pgo+PiA+PiAgI2lm
IElTX1JFQUNIQUJMRShDT05GSUdfVkhPU1RfSU9UTEIpCj4+ID4+Cj4+ID4+ICtzdHJ1Y3QgaW90
bGJfdmVjIHsKPj4gPj4gKyAgICAgICB1bmlvbiB7Cj4+ID4+ICsgICAgICAgICAgICAgICBzdHJ1
Y3QgaW92ZWMgKmlvdmVjOwo+PiA+PiArICAgICAgICAgICAgICAgc3RydWN0IGJpb192ZWMgKmJ2
ZWM7Cj4+ID4+ICsgICAgICAgfSBpb3Y7Cj4+ID4+ICsgICAgICAgc2l6ZV90IGNvdW50Owo+PiA+
PiArICAgICAgIGJvb2wgaXNfaW92ZWM7Cj4+ID4+ICt9Owo+PiA+PiArCj4+ID4+ICBzdGF0aWMg
aW50IGlvdGxiX3RyYW5zbGF0ZShjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHU2NCBhZGRyLCB1NjQgbGVuLCB1NjQgKnRyYW5zbGF0ZWQs
Cj4+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBiaW9fdmVjIGlvdltdLAo+
PiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgaW92X3NpemUsIHUzMiBwZXJtKQo+
PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW90bGJfdmVjICppdmVjLCB1
MzIgcGVybSkKPj4gPj4gIHsKPj4gPj4gICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGJfbWFwICpt
YXA7Cj4+ID4+ICAgICAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiA9IHZyaC0+aW90bGI7
Cj4+ID4+IEBAIC0xMTA3LDkgKzExMTUsOSBAQCBzdGF0aWMgaW50IGlvdGxiX3RyYW5zbGF0ZShj
b25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4+ID4+ICAgICAgICAgc3Bpbl9sb2NrKHZyaC0+aW90
bGJfbG9jayk7Cj4+ID4+Cj4+ID4+ICAgICAgICAgd2hpbGUgKGxlbiA+IHMpIHsKPj4gPj4gLSAg
ICAgICAgICAgICAgIHU2NCBzaXplLCBwYSwgcGZuOwo+PiA+PiArICAgICAgICAgICAgICAgdTY0
IHNpemU7Cj4+ID4+Cj4+ID4+IC0gICAgICAgICAgICAgICBpZiAodW5saWtlbHkocmV0ID49IGlv
dl9zaXplKSkgewo+PiA+PiArICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHJldCA+PSBpdmVj
LT5jb3VudCkpIHsKPj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT0JVRlM7
Cj4+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+PiA+PiAgICAgICAgICAgICAg
ICAgfQo+PiA+PiBAQCAtMTEyNCwxMCArMTEzMiwyMiBAQCBzdGF0aWMgaW50IGlvdGxiX3RyYW5z
bGF0ZShjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4+ID4+ICAgICAgICAgICAgICAgICB9Cj4+
ID4+Cj4+ID4+ICAgICAgICAgICAgICAgICBzaXplID0gbWFwLT5zaXplIC0gYWRkciArIG1hcC0+
c3RhcnQ7Cj4+ID4+IC0gICAgICAgICAgICAgICBwYSA9IG1hcC0+YWRkciArIGFkZHIgLSBtYXAt
PnN0YXJ0Owo+PiA+PiAtICAgICAgICAgICAgICAgcGZuID0gcGEgPj4gUEFHRV9TSElGVDsKPj4g
Pj4gLSAgICAgICAgICAgICAgIGJ2ZWNfc2V0X3BhZ2UoJmlvdltyZXRdLCBwZm5fdG9fcGFnZShw
Zm4pLCBtaW4obGVuIC0gcywgc2l6ZSksCj4+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBhICYgKFBBR0VfU0laRSAtIDEpKTsKPj4gPj4gKyAgICAgICAgICAgICAgIGlmIChpdmVj
LT5pc19pb3ZlYykgewo+PiA+PiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW92ZWMg
KmlvdmVjID0gaXZlYy0+aW92LmlvdmVjOwo+PiA+PiArCj4+ID4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlvdmVjW3JldF0uaW92X2xlbiA9IG1pbihsZW4gLSBzLCBzaXplKTsKPj4gPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgaW92ZWNbcmV0XS5pb3ZfYmFzZSA9ICh2b2lkIF9fdXNlciAq
KSh1bnNpZ25lZCBsb25nKQo+PiA+Cj4+ID5zL3Vuc2lnbmVkIGxvbmcvdWludHB0cl90ID8KPj4g
Pgo+Pgo+PiB5ZXAsIGdvb2QgY2F0Y2ghCj4+Cj4+IEFzIEkgd3JvdGUgdG8gSmFzb24sIEkgdGhp
bmsgSSdsbCB0YWtlIGl0IG91dCBvZiB0aGUgaWYgYW5kIGp1c3QgZGVjbGFyZQo+PiBhbiB1aW50
cHRyX3QgdmFyaWFibGUsIHNpbmNlIEknbSB1c2luZyBpdCBhbHNvIGluIHRoZSBlbHNlIGJyYW5j
aC4KPj4KPj4gPgo+PiA+Cj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAobWFwLT5hZGRyICsgYWRkciAtIG1hcC0+c3RhcnQpOwo+PiA+PiArICAgICAg
ICAgICAgICAgfSBlbHNlIHsKPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgdTY0IHBhID0g
bWFwLT5hZGRyICsgYWRkciAtIG1hcC0+c3RhcnQ7Cj4+ID4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHU2NCBwZm4gPSBwYSA+PiBQQUdFX1NISUZUOwo+PiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYmlvX3ZlYyAqYnZlYyA9IGl2ZWMtPmlvdi5idmVjOwo+PiA+PiArCj4+ID4+
ICsgICAgICAgICAgICAgICAgICAgICAgIGJ2ZWNfc2V0X3BhZ2UoJmJ2ZWNbcmV0XSwgcGZuX3Rv
X3BhZ2UocGZuKSwKPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBt
aW4obGVuIC0gcywgc2l6ZSksCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGEgJiAoUEFHRV9TSVpFIC0gMSkpOwo+PiA+PiArICAgICAgICAgICAgICAgfQo+PiA+
PiArCj4+ID4+ICAgICAgICAgICAgICAgICBzICs9IHNpemU7Cj4+ID4+ICAgICAgICAgICAgICAg
ICBhZGRyICs9IHNpemU7Cj4+ID4+ICAgICAgICAgICAgICAgICArK3JldDsKPj4gPj4gQEAgLTEx
NDEsMjYgKzExNjEsNDIgQEAgc3RhdGljIGludCBpb3RsYl90cmFuc2xhdGUoY29uc3Qgc3RydWN0
IHZyaW5naCAqdnJoLAo+PiA+PiAgICAgICAgIHJldHVybiByZXQ7Cj4+ID4+ICB9Cj4+ID4+Cj4+
ID4+ICsjZGVmaW5lIElPVExCX0lPVl9TSVpFIDE2Cj4+ID4KPj4gPkknbSBmaW5lIHdpdGggZGVm
aW5pbmcgaGVyZSwgYnV0IG1heWJlIGl0IGlzIGJldHRlciB0byBpc29sYXRlIHRoZQo+PiA+Y2hh
bmdlIGluIGEgcHJldmlvdXMgcGF0Y2ggb3IgcmV1c2UgYW5vdGhlciB3ZWxsIGtub3duIG1hY3Jv
Pwo+Pgo+PiBZZXAsIGdvb2QgcG9pbnQhCj4+Cj4+IERvIHlvdSBoYXZlIGFueSB3ZWxsIGtub3du
IG1hY3JvIHRvIHN1Z2dlc3Q/Cj4+Cj4KPk5vdCByZWFsbHksIDE2IHNlZW1zIGxpa2UgYSBjb252
ZW5pZW5jZSB2YWx1ZSBoZXJlIGFjdHVhbGx5IDopLiBNYXliZQo+cmVwbGFjZSBfU0laRSB3aXRo
IF9TVFJJREUgb3Igc2ltaWxhcj8KCkFjaywgSSB3aWxsIGFkZCBJT1RMQl9JT1ZfU1RSSURFIGlu
IGEgcHJlcGFyYXRpb24gcGF0Y2ggYmVmb3JlIHRoaXMKb25lLgoKPgo+SSBrZWVwIHRoZSBBY2tl
ZC1ieSBldmVuIGlmIHRoZSBmaW5hbCBuYW1lIGlzIElPVExCX0lPVl9TSVpFIHRob3VnaC4KClRo
YW5rcywKSSBjaGFuZ2VkIGEgYml0IHRoaXMgcGF0Y2ggZm9sbG93aW5nIEphc29uJ3MgYW5kIHlv
dXIgc3VnZ2VzdGlvbnMuCgpJJ2QgbGlrZSBhbiBleHBsaWNpdCBBY2tlZC1ieSBvbiB0aGUgbmV4
dCB2ZXJzaW9uIGlmIGl0IGlzIG9rYXkgd2l0aCAKeW91LgoKVGhhbmtzLApTdGVmYW5vCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
