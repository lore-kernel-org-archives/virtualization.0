Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D53C64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 04:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 023554094C;
	Mon, 27 Feb 2023 04:12:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 023554094C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aqpZw07L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NKs76borxJ31; Mon, 27 Feb 2023 04:12:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20DD2409A4;
	Mon, 27 Feb 2023 04:12:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20DD2409A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7B3AC0032;
	Mon, 27 Feb 2023 04:12:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDB57C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 04:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83197409A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 04:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83197409A4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wcc-MBdXGsIL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 04:12:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE6994094C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE6994094C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 04:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677471137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bF6aiagdS4QYKhUwnh5wvwibqsaVZLVPjb91E7IR+3w=;
 b=aqpZw07LQpP7CMvPCj5XN0x3njFB+IhjsYsMq7yXdy0jJKIpSytBURPHM0lIR6SmO2Qryn
 6rMlxvebbTytKlEgUHvFE0r2MINIq8feLa8xl4DC/NKd6kwOdnHOD9xg1XiC4fgWAN8hZ/
 eJ3FPSOBEryg3xUBmv9SQ/O8DA0hobY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-7M9M7PuTOtOYCWjQZrdiCg-1; Sun, 26 Feb 2023 23:12:15 -0500
X-MC-Unique: 7M9M7PuTOtOYCWjQZrdiCg-1
Received: by mail-oo1-f72.google.com with SMTP id
 m14-20020a4add0e000000b0052010e01597so864470oou.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Feb 2023 20:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bF6aiagdS4QYKhUwnh5wvwibqsaVZLVPjb91E7IR+3w=;
 b=yVqsxnlK8xQ9PO8AwcSpORFLsiPGiNrBlz78/huqh38iW32j6ZEdrxXMBMiUiuDiz9
 4oWwTa8uEEFMV/cGD1a7Kkxdtyi0QMlkREL00+iKrHozmri+SRDGATUSIpNvn67PX7w9
 nojFX9LAC15Y2KAl1r4mqSrGM9c99PT69vkB3DwbWru2liSIRJVkmqsmpViwZbrevWdW
 y05BRYV7EpeJHjpU+cRrwA4/q4lld9S2b1qKGQRmf8xiDdV/hSHvSoBb6YgBUJ6X8QjU
 RcqeieBZUGLtPD3feh2ev0E3jQh1kqnmNpKeNOM+p9CkjB60QZuoQXFF7P7NL/Buhxou
 tz5g==
X-Gm-Message-State: AO0yUKXtUQScTU+zWmp9MjyMijJkjQbAUezVBZD8hbk3ZOFL09kWhm3b
 PqE8UnQ92Gj87hK5rIQy4hspTUMLAMJl2Y7eCb4f4tmDLkO+YUz7B8Yrq6SWh6Acrr18SAYxIp4
 eiipblzGNXbCCdxCJqiwB2e0aHVcXjxrsuvPmMNS/P9u2SzPW9WVnJPi/QA==
X-Received: by 2002:aca:170c:0:b0:37f:ab56:ff42 with SMTP id
 j12-20020aca170c000000b0037fab56ff42mr3473930oii.9.1677471135123; 
 Sun, 26 Feb 2023 20:12:15 -0800 (PST)
X-Google-Smtp-Source: AK7set/s+nbucOcz9b2Oq/7thNtMbK8QBjD/2uF5c2KiU21IMrI5QTglUfGm3DOphwmfmZOT3QQigLJlfH4Zl+n1WLc=
X-Received: by 2002:aca:170c:0:b0:37f:ab56:ff42 with SMTP id
 j12-20020aca170c000000b0037fab56ff42mr3473919oii.9.1677471134909; Sun, 26 Feb
 2023 20:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com>
 <20230224031932-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230224031932-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Feb 2023 12:12:03 +0800
Message-ID: <CACGkMEs8f6akn62UKGUC=N=+MMRdLuGrzC7OpOps5_Ug6h933g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Fix probe of virtio-net on kvmtool
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rbradford@rivosinc.com, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gRnJpLCBGZWIgMjQsIDIwMjMgYXQgNDoyNeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBGZWIgMjMsIDIwMjMgYXQgMDc6Mzg6MjVQ
TSArMDAwMCwgUm9iIEJyYWRmb3JkIHZpYSBCNCBSZWxheSB3cm90ZToKPiA+IEZyb206IFJvYiBC
cmFkZm9yZCA8cmJyYWRmb3JkQHJpdm9zaW5jLmNvbT4KPiA+Cj4gPiBrdm10b29sIGRvZXMgbm90
IHN1cHBvcnQgdGhlIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxPQURTIGZlYXR1cmUKPiA+
IGJ1dCBkb2VzIGFkdmVydGlzZSB0aGUgVklSVElPX05FVF9GX0dVRVNUX1RTT3s0LDZ9IGZlYXR1
cmVzLiBDaGVjayB0aGF0Cj4gPiB0aGUgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMg
ZmVhdHVyZSBpcyBwcmVzZW50IGJlZm9yZSBzZXR0aW5nCj4gPiB0aGUgTkVUSUZfRl9HUk9fSFcg
ZmVhdHVyZSBiaXQgYXMgb3RoZXJ3aXNlIGFuIGF0dGVtcHQgd2lsbCBiZSBtYWRlIHRvCj4gPiBw
cm9ncmFtIHRoZSB2aXJ0aW8tbmV0IGRldmljZSB1c2luZyB0aGUgY3RybCBxdWV1ZSB3aGljaCB3
aWxsIGZhaWwuCj4gPgo+ID4gVGhpcyByZXNvbHZlcyB0aGUgZm9sbG93aW5nIGVycm9yIHdoZW4g
cnVubmluZyBvbiBrdm10b29sOgo+ID4KPiA+IFsgICAgMS44NjU5OTJdIG5ldCBldGgwOiBGYWls
IHRvIHNldCBndWVzdCBvZmZsb2FkLgo+ID4gWyAgICAxLjg3MjQ5MV0gdmlydGlvX25ldCB2aXJ0
aW8yIGV0aDA6IHNldF9mZWF0dXJlcygpIGZhaWxlZCAoLTIyKTsgd2FudGVkIDB4MDAwMDAwMDAw
MDEzNDgyOSwgbGVmdCAweDAwODAwMDAwMDAxMzQ4MjkKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBS
b2IgQnJhZGZvcmQgPHJicmFkZm9yZEByaXZvc2luYy5jb20+Cj4gPiAtLS0KPiA+IENoYW5nZXMg
aW4gdjI6Cj4gPiAtIFVzZSBwYXJlbnRoZXNlcyB0byBncm91cCBsb2dpY2FsIE9SIG9mIGZlYXR1
cmVzCj4gPiAtIExpbmsgdG8gdjE6Cj4gPiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
MzAyMjMtdmlydGlvLW5ldC1rdm10b29sLXYxLTEtZmMyM2QyOWI5ZDdhQHJpdm9zaW5jLmNvbQo+
ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNyArKystLS0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiBpbmRleCA2MWUzM2U0ZGQwY2QuLmY4MzQxZDFhNGNjZCAxMDA2NDQKPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiBAQCAtMzc4MCwxMCArMzc4MCw5IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ICAgICAgIH0KPiA+ICAgICAgIGlmICh2aXJ0
aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX0NTVU0pKQo+ID4gICAgICAg
ICAgICAgICBkZXYtPmZlYXR1cmVzIHw9IE5FVElGX0ZfUlhDU1VNOwo+ID4gLSAgICAgaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPiA+IC0g
ICAgICAgICB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYp
KQo+ID4gLSAgICAgICAgICAgICBkZXYtPmZlYXR1cmVzIHw9IE5FVElGX0ZfR1JPX0hXOwo+ID4g
LSAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVT
VF9PRkZMT0FEUykpCj4gPiArICAgICBpZiAoKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPiA+ICsgICAgICAgICB2aXJ0aW9faGFzX2ZlYXR1cmUo
dmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKSAmJgo+ID4gKyAgICAgICAgIHZpcnRpb19o
YXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykpCj4gPiAg
ICAgICAgICAgICAgIGRldi0+aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9HUk9fSFc7Cj4KPiBUaGlz
IHdpbGwgZGlzYWJsZSBHUk8vTFJPIG9uIGt2bXRvb2wgY29tcGxldGVseSBjYXVzaW5nIGEgc2ln
bmlmaWNhbnQKPiBwZXJmb3JtYW5jZSByZWdyZXNzaW9uLgo+Cj4gSmFzb24sIGlzbid0IHRoaXMg
d2hhdAo+ICAgICAgICAgY29tbWl0IGRiY2YyNGQxNTM4ODQ0MzlkYWQzMDQ4NGEwZTNmMDIzNTA2
OTJlNGMKPiAgICAgICAgIEF1dGhvcjogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
PiAgICAgICAgIERhdGU6ICAgVHVlIEF1ZyAxNyAxNjowNjo1OSAyMDIxICswODAwCj4KPiAgICAg
ICAgICAgICB2aXJ0aW8tbmV0OiB1c2UgTkVUSUZfRl9HUk9fSFcgaW5zdGVhZCBvZiBORVRJRl9G
X0xSTwo+Cj4gd2FzIHN1cHBvc2VkIHRvIGFkZHJlc3M/Cj4KClllcywgSSd2ZSBhc2tlZCBhIHNp
bWlsYXIgcXVlc3Rpb24gaW4gYW5vdGhlciB0aHJlYWQuCgo+Cj4gQW5kIGFwcm9wb3MgdGhpczoK
Pgo+ICAgICBGaXggdGhpcyBieSB1c2luZyBORVRJRl9GX0dST19IVyBpbnN0ZWFkLiBUaG91Z2gg
dGhlIHNwZWMgZG9lcyBub3QKPiAgICAgZ3VhcmFudGVlIHBhY2tldHMgdG8gYmUgcmUtc2VnbWVu
dGVkIGFzIHRoZSBvcmlnaW5hbCBvbmVzLAo+ICAgICB3ZSBjYW4gYWRkIHRoYXQgdG8gdGhlIHNw
ZWMsIHBvc3NpYmx5IHdpdGggYSBmbGFnIGZvciBkZXZpY2VzIHRvCj4gICAgIGRpZmZlcmVudGlh
dGUgYmV0d2VlbiBHUk8gYW5kIExSTy4KPgo+IHRoaXMgbmV2ZXIgaGFwcGVuZWQuIFdoYXQncyB0
aGUgcGxhbiBleGFjdGx5PwoKSXQncyBpbiB0aGUgYmFja2xvZywgYnV0IEknbSBvdXQgb2YgYmFu
ZHdpZHRoIGZvciBkb2luZyB0aGF0IG5vdy4KClRoYW5rcwoKPgo+Cj4KPgo+ID4gICAgICAgZGV2
LT52bGFuX2ZlYXR1cmVzID0gZGV2LT5mZWF0dXJlczsKPiA+Cj4gPiAtLS0KPiA+IGJhc2UtY29t
bWl0OiBjMzljZWE2ZjM4ZWVmZTM1NmQ2NGQwYmMxZTFmMjI2N2UyODJjZGQzCj4gPiBjaGFuZ2Ut
aWQ6IDIwMjMwMjIzLXZpcnRpby1uZXQta3ZtdG9vbC04N2YzNzUxNWJlMjIKPiA+Cj4gPiBCZXN0
IHJlZ2FyZHMsCj4gPiAtLQo+ID4gUm9iIEJyYWRmb3JkIDxyYnJhZGZvcmRAcml2b3NpbmMuY29t
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
