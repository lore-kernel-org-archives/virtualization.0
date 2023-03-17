Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D780BC7618B
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 11:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BD11821E1;
	Fri, 17 Mar 2023 11:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BD11821E1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IuaX2tZD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpXu5r-EukPS; Fri, 17 Mar 2023 11:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B36F081FAA;
	Fri, 17 Mar 2023 11:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B36F081FAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71ADFC0071;
	Fri, 17 Mar 2023 11:25:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD339C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 11:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CFC1416D8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 11:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CFC1416D8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IuaX2tZD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L4WMVxYtLluN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 11:25:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BB62416D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BB62416D3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679052347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eg+W4V459K453HHEWu6+WOIdJvDrwAbatlv4pe/Z8I=;
 b=IuaX2tZD9tpH475UV/B5yjxTZDTh7127lDIEPMgSFcNYgY+frCSi6+6HSCWeFJ1jwMP7WR
 erED6JYihGA2SV/T+IRQ1NlOxM2kWo0auyT7pjMCFfPy8xPswu1fL3yKEfkANuCV6xVPS3
 HWobqVsd8m/WfHfRLNOkMXAtwJzXpk8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-7O-xREQoOHiyhs6VaVE-Iw-1; Fri, 17 Mar 2023 07:25:40 -0400
X-MC-Unique: 7O-xREQoOHiyhs6VaVE-Iw-1
Received: by mail-wm1-f69.google.com with SMTP id
 fl22-20020a05600c0b9600b003ed26ca6206so4144993wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 04:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679052339;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3eg+W4V459K453HHEWu6+WOIdJvDrwAbatlv4pe/Z8I=;
 b=r96eh8qeK3rJlUNPOso4dHboFljcicZCM3h6vtQKa1ApnDDciBG6sIh+Re/FE2RRge
 UBi3WR5wXApGIi+MmqA9KAJN6S8Iewdj6Kaz37HZToZkZ72JdnsLlrtjY+Umx9ehbhw0
 xomBMtsEcamt3x1QKFBkCt0DnOKHnXGPv7V/9RZtwGVxmnihyp8Yo+TW3NRIeDgeuQQr
 QHO2XJUHL0kBpdSekZMl2VNAZa3xE2Z0fpLnKLB2usmECrFkxfGqQ/qUifGR6IV77Ozb
 3FTkQUFLJ3vPsDnfHkQCZURDEVyCMnKVuyjTf7G+xLtStXhTdi3fpp+nLRj5ICkA93F5
 4FJA==
X-Gm-Message-State: AO0yUKUM7YRQb3+sQBCRSZ3lPZvpsKIfVE3pY3ryChqP+KIzYii/fmsv
 yOuefGGeq+9zegI+MY0milAn2u9qc5/ZSOs3nQXGECPJADYoyLiFpRMMqtU+cOqnl5X/sF1pkko
 sF2qo5GQbBcw/vkE14xnjkHMKVril3jFsBlHdzNaDIQ==
X-Received: by 2002:adf:ecc4:0:b0:2c5:510b:8f9c with SMTP id
 s4-20020adfecc4000000b002c5510b8f9cmr7021028wro.52.1679052339555; 
 Fri, 17 Mar 2023 04:25:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set9FZ5f9vlrQw7xgnuvkWSEFXAo8AQG5rmR3D2Ycyj5yA2kbAhnhVzi4UvMN5l8xZtTnmtbeRA==
X-Received: by 2002:adf:ecc4:0:b0:2c5:510b:8f9c with SMTP id
 s4-20020adfecc4000000b002c5510b8f9cmr7021010wro.52.1679052339284; 
 Fri, 17 Mar 2023 04:25:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 r10-20020adfce8a000000b002cefcac0c62sm1770714wrn.9.2023.03.17.04.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Mar 2023 04:25:38 -0700 (PDT)
Date: Fri, 17 Mar 2023 12:25:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v2 4/8] vringh: support VA with iotlb
Message-ID: <20230317112536.t7gm4dop5cafgvoe@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-5-sgarzare@redhat.com>
 <CAJaqyWdeEzKnYuX-c348vVg0PpUH4y-e1dSLhRvYem=MEDKE=Q@mail.gmail.com>
 <CAGxU2F7GZxMwLNsAebaPx61MoePYYmFS1q66An-EDhq4u+a9ng@mail.gmail.com>
 <CAJaqyWcAfyANeShsdV55vVkK=sHxGNVef7E7jj-CqTL7SbqhCg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcAfyANeShsdV55vVkK=sHxGNVef7E7jj-CqTL7SbqhCg@mail.gmail.com>
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

T24gRnJpLCBNYXIgMTcsIDIwMjMgYXQgMTA6NDk6MjdBTSArMDEwMCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj5PbiBUaHUsIE1hciAxNiwgMjAyMyBhdCA1OjA34oCvUE0gU3RlZmFubyBH
YXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPj4KPj4gT24gRnJpLCBNYXIg
MywgMjAyMyBhdCAzOjM54oCvUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhh
dC5jb20+IHdyb3RlOgo+PiA+Cj4+ID4gT24gVGh1LCBNYXIgMiwgMjAyMyBhdCAxMjozNSBQTSBT
dGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+PiA+ID4KPj4g
PiA+IHZEUEEgc3VwcG9ydHMgdGhlIHBvc3NpYmlsaXR5IHRvIHVzZSB1c2VyIFZBIGluIHRoZSBp
b3RsYiBtZXNzYWdlcy4KPj4gPiA+IFNvLCBsZXQncyBhZGQgc3VwcG9ydCBmb3IgdXNlciBWQSBp
biB2cmluZ2ggdG8gdXNlIGl0IGluIHRoZSB2RFBBCj4+ID4gPiBzaW11bGF0b3JzLgo+PiA+ID4K
Pj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0
LmNvbT4KPj4gPiA+IC0tLQo+PiA+ID4KPj4gPiA+IE5vdGVzOgo+PiA+ID4gICAgIHYyOgo+PiA+
ID4gICAgIC0gcmVwbGFjZSBrbWFwX2F0b21pYygpIHdpdGgga21hcF9sb2NhbF9wYWdlKCkgW3Nl
ZSBwcmV2aW91cyBwYXRjaF0KPj4gPiA+ICAgICAtIGZpeCBjYXN0IHdhcm5pbmdzIHdoZW4gYnVp
bGQgd2l0aCBXPTEgQz0xCj4+ID4gPgo+PiA+ID4gIGluY2x1ZGUvbGludXgvdnJpbmdoLmggICAg
ICAgICAgICB8ICAgNSArLQo+PiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
YyB8ICAgMiArLQo+PiA+ID4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICB8ICAg
NCArLQo+PiA+ID4gIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgICAgICAgICAgICB8IDI0NyArKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0KPj4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDIwNSBp
bnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkKPj4gPiA+Cj4+Cj4+IFsuLi5dCj4+Cj4+ID4K
Pj4gPiBJdCBzZWVtcyB0byBtZSBpb3RsYl90cmFuc2xhdGVfdmEgYW5kIGlvdGxiX3RyYW5zbGF0
ZV9wYSBhcmUgdmVyeQo+PiA+IHNpbWlsYXIsIHRoZWlyIG9ubHkgZGlmZmVyZW5jZSBpcyB0aGF0
IHRoZSBhcmd1bWVudCBpcyB0aGF0IGlvdiBpcwo+PiA+IGlvdmVjIGluc3RlYWQgb2YgYmlvX3Zl
Yy4gQW5kIGhvdyB0byBmaWxsIGl0LCBvYnZpb3VzbHkuCj4+ID4KPj4gPiBJdCB3b3VsZCBiZSBn
cmVhdCB0byBtZXJnZSBib3RoIGZ1bmN0aW9ucywgb25seSBkaWZmZXJpbmcgd2l0aCBhCj4+ID4g
Y29uZGl0aW9uYWwgb24gdnJoLT51c2VfdmEsIG9yIGdlbmVyaWNzLCBvciBzaW1pbGFyLiBPciwg
aWYgZm9sbG93aW5nCj4+ID4gdGhlIHN0eWxlIG9mIHRoZSByZXN0IG9mIHZyaW5naCBjb2RlLCB0
byBwcm92aWRlIGEgY2FsbGJhY2sgdG8gZmlsbAo+PiA+IGlvdmVjIChhbHRob3VnaCBJIGxpa2Ug
Y29uZGl0aW9uYWwgbW9yZSkuCj4+ID4KPj4gPiBIb3dldmVyIEkgY2Fubm90IHRoaW5rIG9mIGFu
IGVhc3kgd2F5IHRvIHBlcmZvcm0gdGhhdCB3aXRob3V0IGxvbmcKPj4gPiBtYWNyb3Mgb3IgdHlw
ZSBlcmFzdXJlLgo+Pgo+PiBUaGFuayB5b3UgZm9yIHB1c2hpbmcgbWUgOi0pCj4+IEkgZmluYWxs
eSBtYW5hZ2VkIHRvIGF2b2lkIGNvZGUgZHVwbGljYXRpb24gKHBhcnRpYWwgcGF0Y2ggYXR0YWNo
ZWQsCj4+IGJ1dCBub3QgeWV0IGZ1bGx5IHRlc3RlZCkuCj4+Cj4+IEBKYXNvbjogd2l0aCB0aGlz
IHJlZmFjdG9yaW5nIEkgcmVtb3ZlZCBjb3B5X3RvX3ZhL2NvcHlfdG9fcGEsIHNvIEkKPj4gYWxz
byBhdm9pZGVkIGdldHUxNl9pb3RsYl92YS9wYS4KPj4KPj4gSSB3aWxsIHNlbmQgdGhlIGZ1bGwg
cGF0Y2ggaW4gdjMsIGJ1dCBJIHdvdWxkIGxpa2UgdG8gZ2V0IHlvdXIgb3Bpbmlvbgo+PiBmaXJz
dCA7LSkKPj4KPj4KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9k
cml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+IGluZGV4IDBiYTNlZjgwOWU0OC4uNzFkZDY3NzAwZTM2
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+ICsrKyBiL2RyaXZlcnMv
dmhvc3QvdnJpbmdoLmMKPj4gQEAgLTEwOTYsOCArMTA5Niw3IEBAIEVYUE9SVF9TWU1CT0wodnJp
bmdoX25lZWRfbm90aWZ5X2tlcm4pOwo+Pgo+PiAgc3RhdGljIGludCBpb3RsYl90cmFuc2xhdGUo
Y29uc3Qgc3RydWN0IHZyaW5naCAqdnJoLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
NjQgYWRkciwgdTY0IGxlbiwgdTY0ICp0cmFuc2xhdGVkLAo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgYmlvX3ZlYyBpb3ZbXSwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW50IGlvdl9zaXplLCB1MzIgcGVybSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
dm9pZCAqaW92LCBpbnQgaW92X3NpemUsIGJvb2wgaW92ZWMsIHUzMiBwZXJtKQo+Cj5JIHRoaW5r
IHRoaXMgaXMgYW4gaW1wcm92ZW1lbnQsIGJ1dCB3ZSdyZSBkb2luZyB0eXBlIGVyYXN1cmUgaGVy
ZS4gSQo+ZG9uJ3QgdGhpbmsgaXQgaXMgYSBiaWcgZGVhbCBzaW5jZSB0aGUgZnVuY3Rpb24gaXMg
bm90IGV4cG9ydGVkLCBpdCdzCj5wcmV0dHkgY29udGFpbmVkIGluIHRoaXMgZmlsZSwgc28gSSdk
IGFjayB0aGlzIHZlcnNpb24gdG9vLiBJJ20ganVzdAo+dGhyb3dpbmcgaWRlYXMgaGVyZToKPgo+
YSkgdHlwZWRlZiB0aGUgdW5pb24ge2lvdmVjLCBiaW9fdmVjfSBhbmQgdXNlIHRoYXQgdHlwZSBp
biB0aGUgcGFyYW1ldGVyLgo+Cj5BcyBhIGRyYXdiYWNrLCB0aGF0IHVuaW9uIGZlZWxzIG91dCBv
ZiBwbGFjZSBpbiB0aGlzIGZpbGUuIElzIHRoaXMgdGhlCj5vbmx5IHBsYWNlIHdoZXJlIGl0IGlz
IG5lZWRlZD8gSSBkb24ndCBzZWUgb3RoZXIgc2ltaWxhciB1c2VzIGluIHRoZQo+a2VybmVsLgoK
aW92X2l0ZXIgaGFzIHNvbWV0aGluZyBzaW1pbGFyLCBidXQgdGhleSBhcmUgY29uc3QgcG9pbnRl
cnMsIHNvIElJVUMKaXQgaXMgbm90IHN1cHBvc2VkIHRvIGJlIHVzZWQgdG8gc2V0IHRoZSBidmVj
IGNvbnRlbnRzLCBqdXN0IGl0ZXJhdGUgaXQuCgpBbnl3YXkgSSB0aG91Z2h0IHNvbWV0aGluZyBz
aW1pbGFyIGFuZCBzaG91bGQgYmUgZG9hYmxlLCBidXQgc2luY2UKaXQgd2FzIGludGVybmFsIEFQ
SSBJIHdlbnQgdG8gdHlwZSBlcmFzdXJlLgoKPgo+YikgVG8gY29udmVydCBmcm9tIGlvdiB0byBi
aW9faW92IGF0IHJldHVybgo+VGhlIGRyYXdiYWNrIGlzIHRoZSBleHRyYSBwcm9jZXNzaW5nIGlm
IHRoZSBjb21waWxlciBpcyBub3Qgc21hcnQKPmVub3VnaCB0byBpbmxpbmUgaXQuIEkgcHJlZmVy
IHRoZSBwcmV2aW91cyBvbmUgYnV0IEkgZGlkbid0IHdhbnQgdG8KPm9taXQgaXQsIGp1c3QgaW4g
Y2FzZS4KClllcCwgSSBwcmVmZXIgdG9vIHRoZSBwcmV2aW91cyBvbmUsIHNvIGxldCdzIGdvIGlu
IHRoYXQgZGlyZWN0aW9uIGZvcgp2MyA7LSkKClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
