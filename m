Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB14C48BCF
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 22:04:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73058613DF
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 22:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73058613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35681607B8;
	Wed,  9 Jun 2021 22:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8nkgF7u7uF5h; Wed,  9 Jun 2021 22:04:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1AE960746;
	Wed,  9 Jun 2021 22:04:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3959C000E;
	Wed,  9 Jun 2021 22:04:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E175DC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 22:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1B3241D1C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 22:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CDHJV6heq5tV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 22:04:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55BE041D1B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623276248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1+XTsbXIi8UuChDa/DLFwX5AWXjYwtgSyXqS9K71x0=;
 b=IMq+vsSLY6vrbtUIiKokt3S90X1Mwg1NKXONLV5ULjKxtXob2ucL+I0RssKufDaICWctrF
 h324i0ZG2X50jCsmoi1pEhYlB3+assTS0bmCcXLitl/5nDgfvgG0LppzGLA10ywcr+qHAI
 JhWMh9y/OeeDRrOkAItcH7k2mrKJcnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-oMVpiJaVOMSDd4xshvz6vQ-1; Wed, 09 Jun 2021 18:04:05 -0400
X-MC-Unique: oMVpiJaVOMSDd4xshvz6vQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 g81-20020a1c9d540000b02901a3d4d3f7fcso3166621wme.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 15:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=j1+XTsbXIi8UuChDa/DLFwX5AWXjYwtgSyXqS9K71x0=;
 b=o0nDrg6gggrWQEJltlkWSRtgkZvFKiR+FSPHTwRWq/rvig+R5jUGoqGGu/YbASXvGk
 5oe887dgNTdsr6Yh50AqSk2B/UuigZUGf+P5kt+L6pJIGWFE0w9OzDUeuFVJqP+Ka1/+
 b1BlsWv7rtIaJcuRkWx1O5gcdIbqQwHlywrngHgVzoJA5N0Pzk7oSP9mOAt8Hhh14GS7
 hYSenyQ9IHMpE8wEZx4aMhqKXNFcYT8+O82bbkLy2sQbeFv/uvC1Pn7CvvUj3+GolR/d
 Xmrx0x+BoZdnnrQl7xfprGZEfS7tXJxvtfaBU0+pc8MhTKOMwZH/bgCyDdyeQJn19mUL
 aPYQ==
X-Gm-Message-State: AOAM530O3dIDMRLG7ECtdnneCLdSusjqJ/VMdksBi4WpN7zXMcgt//Gl
 CmbZJs6fSCsv9po91CjHnrdYbWhIIENylnCJNluRJSdWCHZkDazzAiXJQvvkbA+COuhDYS/+O7h
 PIPfXH40KwbCp6/zRJUpftiVkqd6OIIUuv40EBzih6g==
X-Received: by 2002:a5d:4dc4:: with SMTP id f4mr1900426wru.181.1623276244113; 
 Wed, 09 Jun 2021 15:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK42aoT4mhmfnQnZDmX/DrUajp6FnM5dO8sLjvfv72GrDAnSKuoWe58PgmSU6TZ6TX/JJLgQ==
X-Received: by 2002:a5d:4dc4:: with SMTP id f4mr1900412wru.181.1623276243908; 
 Wed, 09 Jun 2021 15:04:03 -0700 (PDT)
Received: from redhat.com ([77.124.100.105])
 by smtp.gmail.com with ESMTPSA id m23sm8920358wml.27.2021.06.09.15.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 15:04:03 -0700 (PDT)
Date: Wed, 9 Jun 2021 18:03:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 1/4] virtio_net: move tx vq operation under tx queue
 lock
Message-ID: <20210609175825-mutt-send-email-mst@kernel.org>
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-2-mst@redhat.com>
 <476e9418-156d-dbc9-5105-11d2816b95f7@redhat.com>
 <CA+FuTSccMS4qEyexAuzjcuevS8KwaruJih5_0hgiOFz4BpDHzA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSccMS4qEyexAuzjcuevS8KwaruJih5_0hgiOFz4BpDHzA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
 David Miller <davem@davemloft.net>
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

T24gRnJpLCBNYXkgMjgsIDIwMjEgYXQgMDY6MjU6MTFQTSAtMDQwMCwgV2lsbGVtIGRlIEJydWlq
biB3cm90ZToKPiBPbiBXZWQsIE1heSAyNiwgMjAyMSBhdCAxMTo0MSBQTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPgo+ID4g5ZyoIDIwMjEvNS8yNiDkuIvl
jYg0OjI0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiBJdCdzIHVuc2FmZSB0byBv
cGVyYXRlIGEgdnEgZnJvbSBtdWx0aXBsZSB0aHJlYWRzLgo+ID4gPiBVbmZvcnR1bmF0ZWx5IHRo
aXMgaXMgZXhhY3RseSB3aGF0IHdlIGRvIHdoZW4gaW52b2tpbmcKPiA+ID4gY2xlYW4gdHggcG9s
bCBmcm9tIHJ4IG5hcGkuCj4gPiA+IFNhbWUgaGFwcGVucyB3aXRoIG5hcGktdHggZXZlbiB3aXRo
b3V0IHRoZQo+ID4gPiBvcHBvcnR1bmlzdGljIGNsZWFuaW5nIGZyb20gdGhlIHJlY2VpdmUgaW50
ZXJydXB0OiB0aGF0IHJhY2VzCj4gPiA+IHdpdGggcHJvY2Vzc2luZyB0aGUgdnEgaW4gc3RhcnRf
eG1pdC4KPiA+ID4KPiA+ID4gQXMgYSBmaXggbW92ZSBldmVyeXRoaW5nIHRoYXQgZGVhbHMgd2l0
aCB0aGUgdnEgdG8gdW5kZXIgdHggbG9jay4KPiAKPiBUaGlzIHBhdGNoIGFsc28gZGlzYWJsZXMg
Y2FsbGJhY2tzIGR1cmluZyBmcmVlX29sZF94bWl0X3NrYnMKPiBwcm9jZXNzaW5nIG9uIHR4IGlu
dGVycnVwdC4gU2hvdWxkIHRoYXQgYmUgYSBzZXBhcmF0ZSBjb21taXQsIHdpdGggaXRzCj4gb3du
IGV4cGxhbmF0aW9uPwo+ID4gPgo+ID4gPiBGaXhlczogYjkyZjFlNjc1MWE2ICgidmlydGlvLW5l
dDogdHJhbnNtaXQgbmFwaSIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
IGluZGV4IGFjMGMxNDNmOTdiNC4uMTI1MTJkMTAwMmVjIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gPiA+IEBAIC0xNTA4LDYgKzE1MDgsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChz
dHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gPiA+ICAgICAgIHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpID0gc3EtPnZxLT52ZGV2LT5wcml2Owo+ID4gPiAgICAgICB1bnNpZ25l
ZCBpbnQgaW5kZXggPSB2cTJ0eHEoc3EtPnZxKTsKPiA+ID4gICAgICAgc3RydWN0IG5ldGRldl9x
dWV1ZSAqdHhxOwo+ID4gPiArICAgICBpbnQgb3BhcXVlOwo+ID4gPiArICAgICBib29sIGRvbmU7
Cj4gPiA+Cj4gPiA+ICAgICAgIGlmICh1bmxpa2VseShpc194ZHBfcmF3X2J1ZmZlcl9xdWV1ZSh2
aSwgaW5kZXgpKSkgewo+ID4gPiAgICAgICAgICAgICAgIC8qIFdlIGRvbid0IG5lZWQgdG8gZW5h
YmxlIGNiIGZvciBYRFAgKi8KPiA+ID4gQEAgLTE1MTcsMTAgKzE1MTksMjggQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQo+
ID4gPgo+ID4gPiAgICAgICB0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHZpLT5kZXYsIGluZGV4
KTsKPiA+ID4gICAgICAgX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQo
KSk7Cj4gPiA+ICsgICAgIHZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gPiA+ICAgICAg
IGZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gPiA+ICsKPiA+ID4gKyAgICAgb3BhcXVl
ID0gdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHNxLT52cSk7Cj4gPiA+ICsKPiA+ID4gKyAg
ICAgZG9uZSA9IG5hcGlfY29tcGxldGVfZG9uZShuYXBpLCAwKTsKPiA+ID4gKwo+ID4gPiArICAg
ICBpZiAoIWRvbmUpCj4gPiA+ICsgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3Et
PnZxKTsKPiA+ID4gKwo+ID4gPiAgICAgICBfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ID4gPgo+
ID4gPiAtICAgICB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+ID4g
PiArICAgICBpZiAoZG9uZSkgewo+ID4gPiArICAgICAgICAgICAgIGlmICh1bmxpa2VseSh2aXJ0
cXVldWVfcG9sbChzcS0+dnEsIG9wYXF1ZSkpKSB7Cj4gCj4gU2hvdWxkIHRoaXMgYWxzbyBiZSBp
bnNpZGUgdGhlIGxvY2ssIGFzIGl0IG9wZXJhdGVzIG9uIHZxPwoKTm8gdnEgcG9sbCBpcyBvayBv
dXRzaWRlIG9mIGxvY2tzLCBpdCdzIGF0b21pYy4KCj4gSXMgdGhlcmUgYW55dGhpbmcgdGhhdCBp
cyBub3QgYWxsb3dlZCB0byBydW4gd2l0aCB0aGUgbG9jayBoZWxkPwo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgaWYgKG5hcGlfc2NoZWR1bGVfcHJlcChuYXBpKSkgewo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBfX25ldGlmX3R4X2xvY2sodHhxLCByYXdfc21wX3Byb2Nl
c3Nvcl9pZCgpKTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVl
X2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
X19uZXRpZl90eF91bmxvY2sodHhxKTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgX19uYXBpX3NjaGVkdWxlKG5hcGkpOwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgfQo+
ID4gPiArICAgICAgICAgICAgIH0KPiA+ID4gKyAgICAgfQo+ID4KPiA+Cj4gPiBJbnRlcmVzdGlu
ZywgdGhpcyBsb29rcyBsaWtlIHNvbWVod28gYSBvcGVuLWNvZGVkIHZlcnNpb24gb2YKPiA+IHZp
cnRxdWV1ZV9uYXBpX2NvbXBsZXRlKCkuIEkgd29uZGVyIGlmIHdlIGNhbiBzaW1wbHkga2VlcCB1
c2luZwo+ID4gdmlydHF1ZXVlX25hcGlfY29tcGxldGUoKSBieSBzaW1wbHkgbW92aW5nIHRoZSBf
X25ldGlmX3R4X3VubG9jaygpIGFmdGVyCj4gPiB0aGF0Ogo+ID4KPiA+IG5ldGlmX3R4X2xvY2so
dHhxKTsKPiA+IGZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gPiB2aXJ0cXVldWVfbmFw
aV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+ID4gX19uZXRpZl90eF91bmxvY2sodHhxKTsK
PiAKPiBBZ3JlZWQuIEFuZCBzdWJzZXF1ZW50IGJsb2NrCj4gCj4gICAgICAgIGlmIChzcS0+dnEt
Pm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+ICAgICAgICAgICAgICAgIG5ldGlmX3R4
X3dha2VfcXVldWUodHhxKTsKPiAKPiBhcyB3ZWxsCgpZZXMgSSB0aG91Z2h0IEkgc2F3IHNvbWV0
aGluZyBoZXJlIHRoYXQgY2FuJ3QgYmUgY2FsbGVkIHdpdGggdHggbG9jawpoZWxkIGJ1dCBJIG5v
IGxvbmdlciBzZWUgaXQuIFdpbGwgZG8uCgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4gPiA+Cj4g
PiA+ICAgICAgIGlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+ID4g
PiAgICAgICAgICAgICAgIG5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsKPiA+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
