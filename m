Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8145DC433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 02:05:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F200460ED7
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 02:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F200460ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF1F840292;
	Mon, 11 Oct 2021 02:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kvX_sJIwLC8m; Mon, 11 Oct 2021 02:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 51DB64025D;
	Mon, 11 Oct 2021 02:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26953C0011;
	Mon, 11 Oct 2021 02:05:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11888C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3CB240283
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHtzD0xmsLqH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:05:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B939C4025D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633917909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dt3W97nn3nLieRHcwrHXkZHoe+y8SxklSbymQfso1QE=;
 b=De8W9ydjpOM6FchOpHJRXT+DP043yoGNWdJiCoRRfjW2znQU7SQs2R3CzUYBuNZWvhbcRQ
 XppcF2+Z+UwII6zWo0k6x8A+dKunhWDEO3gcg6vBn99iIVAQs3dBLNAf7wiOrSyY4Owd1t
 L6xTJIm0yF9q1Qq7MsuLrZgVxUMzfII=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-9nC-XmWGNBKGb-0rDRFthw-1; Sun, 10 Oct 2021 22:05:07 -0400
X-MC-Unique: 9nC-XmWGNBKGb-0rDRFthw-1
Received: by mail-lf1-f69.google.com with SMTP id
 bp11-20020a056512158b00b003fc7d722819so11450164lfb.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 19:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Dt3W97nn3nLieRHcwrHXkZHoe+y8SxklSbymQfso1QE=;
 b=kRHFNYWMfio0m0Qhi31oPdg1pDzpSBbO6jLoxpqQEOTnsMmt5goqNkX7Z+Fpc0zt+r
 fvJ7c6ZWyBTHBwWh0gU7cfYOPd8RoLl4sYMKkHu+i5oda5neyhE1SC4D1pFLzDhxjtuu
 2R5TZt1pGSnN0kyjw5qTM3yn4Xa95zbeI+F6ulkh5Sobo7Klm2qLhIj1dVlnOIMRZ2Ro
 aVTQcSvCdfncMBU8paMGEiF6hQqhpia8OrhTtoMeXIe4r3cxWbOO+fbrNiDvYXwCZX1e
 9iOluTFJcqLmWzgtwgw/2SsffKIINDDVJ4uJdeg8O4sLs1xHY6zlqygXvknFCwdFDPm8
 o9UQ==
X-Gm-Message-State: AOAM532F8e/fQ3Rj5p3PhHkw0ntCw/MdzxNNmDdvS80SxKCg4p8s+i86
 MnjBAIOOnNw4o9tANLEKsZDoiubLcdcGFm316BbLG9v/UiOr+SgGpHz9QlIey8u8VJvGuFDRrZG
 peOMcvzSv8XMNOo5CC8H7KTBI1dDXZ+3chbN5qKtZxwAhNtIJZLP9yK3Q+w==
X-Received: by 2002:a2e:8099:: with SMTP id i25mr8180060ljg.277.1633917906330; 
 Sun, 10 Oct 2021 19:05:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkDiR/BGptgc+pbWgE/RLAuwXL6JyrQ0fkP5KqdZaKCoCdI7ytGhHRzptoWN+ks5B3l30AvuWSt/eeqfwAjQw=
X-Received: by 2002:a2e:8099:: with SMTP id i25mr8180041ljg.277.1633917906102; 
 Sun, 10 Oct 2021 19:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211009091604.84141-1-mst@redhat.com>
In-Reply-To: <20211009091604.84141-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Oct 2021 10:04:55 +0800
Message-ID: <CACGkMEsjxm9u8QvQ9c9f34v1WWhGkbwPE-2BgAkRjd+zB6V-AQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Corentin_No=C3=ABl?= <corentin.noel@collabora.com>,
 netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gU2F0LCBPY3QgOSwgMjAyMSBhdCA1OjE4IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gRnJvbTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4KPgo+IGNvbW1pdCAxMjYyODU2NTFiN2YgKCJNZXJnZSByYS5rZXJuZWwub3JnOi9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldCIpCj4gYWNjaWRlbnRhbGx5IHJldmVy
dGVkIHRoZSBlZmZlY3Qgb2YKPiBjb21taXQgMWE4MDI0MjM5ZGEgKCJ2aXJ0aW8tbmV0OiBmaXgg
Zm9yIHNrYl9vdmVyX3BhbmljIGluc2lkZSBiaWcgbW9kZSIpCj4gb24gZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4KPiBBcyBhIHJlc3VsdCwgdXNlcnMgb2YgY3Jvc3ZtICh3aGljaCBpcyB1c2lu
ZyBsYXJnZSBwYWNrZXQgbW9kZSkKPiBhcmUgZXhwZXJpZW5jaW5nIGNyYXNoZXMgd2l0aCA1LjE0
LXJjMSBhbmQgYWJvdmUgdGhhdCBkbyBub3QKPiBvY2N1ciB3aXRoIDUuMTMuCj4KPiBDcmFzaCB0
cmFjZToKPgo+IFsgICA2MS4zNDY2NzddIHNrYnVmZjogc2tiX292ZXJfcGFuaWM6IHRleHQ6ZmZm
ZmZmZmY4ODFhZTJjNyBsZW46Mzc2MiBwdXQ6Mzc2MiBoZWFkOmZmZmY4YTVlYzhjMjIwMDAgZGF0
YTpmZmZmOGE1ZWM4YzIyMDEwIHRhaWw6MHhlYzIgZW5kOjB4ZWMwIGRldjo8TlVMTD4KPiBbICAg
NjEuMzY5MTkyXSBrZXJuZWwgQlVHIGF0IG5ldC9jb3JlL3NrYnVmZi5jOjExMSEKPiBbICAgNjEu
MzcyODQwXSBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNNUCBQVEkKPiBbICAgNjEuMzc0ODky
XSBDUFU6IDUgUElEOiAwIENvbW06IHN3YXBwZXIvNSBOb3QgdGFpbnRlZCA1LjE0LjAtcmMxIGxp
bnV4LXY1LjE0LXJjMS1mb3ItbWVzYS1jaS50YXIuYnoyICMxCj4gWyAgIDYxLjM3NjQ1MF0gSGFy
ZHdhcmUgbmFtZTogQ2hyb21pdW1PUyBjcm9zdm0sIEJJT1MgMAo+Cj4gLi4KPgo+IFsgICA2MS4z
OTM2MzVdIENhbGwgVHJhY2U6Cj4gWyAgIDYxLjM5NDEyN10gIDxJUlE+Cj4gWyAgIDYxLjM5NDQ4
OF0gIHNrYl9wdXQuY29sZCsweDEwLzB4MTAKPiBbICAgNjEuMzk1MDk1XSAgcGFnZV90b19za2Ir
MHhmNy8weDQxMAo+IFsgICA2MS4zOTU2ODldICByZWNlaXZlX2J1ZisweDgxLzB4MTY2MAo+IFsg
ICA2MS4zOTYyMjhdICA/IG5ldGlmX3JlY2VpdmVfc2tiX2xpc3RfaW50ZXJuYWwrMHgxYWQvMHgy
YjAKPiBbICAgNjEuMzk3MTgwXSAgPyBuYXBpX2dyb19mbHVzaCsweDk3LzB4ZTAKPiBbICAgNjEu
Mzk3ODk2XSAgPyBkZXRhY2hfYnVmX3NwbGl0KzB4NjcvMHgxMjAKPiBbICAgNjEuMzk4NTczXSAg
dmlydG5ldF9wb2xsKzB4MmNmLzB4NDIwCj4gWyAgIDYxLjM5OTE5N10gIF9fbmFwaV9wb2xsKzB4
MjUvMHgxNTAKPiBbICAgNjEuMzk5NzY0XSAgbmV0X3J4X2FjdGlvbisweDIyZi8weDI4MAo+IFsg
ICA2MS40MDAzOTRdICBfX2RvX3NvZnRpcnErMHhiYS8weDI1Nwo+IFsgICA2MS40MDEwMTJdICBp
cnFfZXhpdF9yY3UrMHg4ZS8weGIwCj4gWyAgIDYxLjQwMTYxOF0gIGNvbW1vbl9pbnRlcnJ1cHQr
MHg3Yi8weGEwCj4gWyAgIDYxLjQwMjI3MF0gIDwvSVJRPgo+Cj4gU2VlCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci81ZWRhYTJiN2MyZmU0YWJkMDM0N2I4NDU0YjJhYzAzMmI2Njk0ZTJjLmNh
bWVsJTQwY29sbGFib3JhLmNvbQo+IGZvciB0aGUgcmVwb3J0Lgo+Cj4gQXBwbHkgdGhlIG9yaWdp
bmFsIDFhODAyNDIzOWRhICgidmlydGlvLW5ldDogZml4IGZvciBza2Jfb3Zlcl9wYW5pYyBpbnNp
ZGUgYmlnIG1vZGUiKQo+IGFnYWluLCB0aGUgb3JpZ2luYWwgbG9naWMgc3RpbGwgaG9sZHM6Cj4K
PiBJbiB2aXJ0aW8tbmV0J3MgbGFyZ2UgcGFja2V0IG1vZGUsIHRoZXJlIGlzIGEgaG9sZSBpbiB0
aGUgc3BhY2UgYmVoaW5kCj4gYnVmLgo+Cj4gICAgIGhkcl9wYWRkZWRfbGVuIC0gaGRyX2xlbgo+
Cj4gV2UgbXVzdCB0YWtlIHRoaXMgaW50byBhY2NvdW50IHdoZW4gY2FsY3VsYXRpbmcgdGFpbHJv
b20uCj4KPiBDYzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4gRml4ZXM6
IGZiMzI4NTZiMTZhZCAoInZpcnRpby1uZXQ6IHBhZ2VfdG9fc2tiKCkgdXNlIGJ1aWxkX3NrYiB3
aGVuIHRoZXJlJ3Mgc3VmZmljaWVudCB0YWlscm9vbSIpCj4gRml4ZXM6IDEyNjI4NTY1MWI3ZiAo
Ik1lcmdlIHJhLmtlcm5lbC5vcmc6L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0
IikKPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29t
Pgo+IFJlcG9ydGVkLWJ5OiBDb3JlbnRpbiBOb8OrbCA8Y29yZW50aW4ubm9lbEBjb2xsYWJvcmEu
Y29tPgo+IFRlc3RlZC1ieTogQ29yZW50aW4gTm/Dq2wgPGNvcmVudGluLm5vZWxAY29sbGFib3Jh
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+IC0tLQoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cgo+Cj4g
RGF2aWQsIEkgdGhpbmsgd2UgbmVlZCB0aGlzIGluIHN0YWJsZSwgdG9vLgo+Cj4gIGRyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggMDk2YzJhYzZiN2E2Li42YjA4MTJm
NDRiYmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTQwNiw3ICs0MDYsNyBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgICAgICAg
ICogYWRkX3JlY3ZidWZfbWVyZ2VhYmxlKCkgKyBnZXRfbWVyZ2VhYmxlX2J1Zl9sZW4oKQo+ICAg
ICAgICAgICovCj4gICAgICAgICB0cnVlc2l6ZSA9IGhlYWRyb29tID8gUEFHRV9TSVpFIDogdHJ1
ZXNpemU7Cj4gLSAgICAgICB0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gaGVhZHJvb207Cj4g
KyAgICAgICB0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gaGVhZHJvb20gLSAoaGRyX3BhZGRl
ZF9sZW4gLSBoZHJfbGVuKTsKPiAgICAgICAgIGJ1ZiA9IHAgLSBoZWFkcm9vbTsKPgo+ICAgICAg
ICAgbGVuIC09IGhkcl9sZW47Cj4gLS0KPiBNU1QKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
