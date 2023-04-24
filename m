Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9965CC7618E
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 04:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30E5D813EA;
	Mon, 24 Apr 2023 04:53:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30E5D813EA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R7+9oqrF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NvvSWI4XFy4G; Mon, 24 Apr 2023 04:53:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A211981379;
	Mon, 24 Apr 2023 04:53:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A211981379
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8339CC0036;
	Mon, 24 Apr 2023 04:53:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0869C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8841740350
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:53:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8841740350
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R7+9oqrF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fp8p7wTvp9yZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:53:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5552D402A5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5552D402A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 04:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682312009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KS/jnFpc3BXgwSjNAHwjGgepq4c6pD4VwOrzvIuXGw=;
 b=R7+9oqrFi9BwSZKK9oD0vrgdaip/Qy9UIMIVfhpsi+hj2Dzlfehm3NFnPp1I6ALEB9owb1
 cE5mo9hsxQ7gRH+B9Mp0f122NiXOQXRPItDb2K9TPjKdYB7ZZiQ6oxx84GjC4QuqRivlFy
 +mon7WWGPGGCiGWcwD5R2nj4x3Pze3s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Xqsf4lTbNmW_NuFfmQ9ShA-1; Mon, 24 Apr 2023 00:53:02 -0400
X-MC-Unique: Xqsf4lTbNmW_NuFfmQ9ShA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2f625d521abso2126846f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 21:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682311981; x=1684903981;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3KS/jnFpc3BXgwSjNAHwjGgepq4c6pD4VwOrzvIuXGw=;
 b=hQpl3bapGALbhO6iMg09lVntcef2aMQHOhQ9fHyuTp2xEpyUM698AqWVAW0/47pFBl
 3L69bLQTqo887hj3O+JvuLI7uBG2/5NMBH/GQJNjZkMnal6BO99G9MyKaP87wVcWLPP5
 /uC+UMv9SbFajeZsQPiIwhClNh4suN/KITrjKIM6QdEM6wdrM+OarqmQSN+yh/HbS+IH
 rO0WPyKTJrT2Ls90hq2eA7Bb88nIEabQO844WlmAKfseTUjwUMxphnJwhNjdVjZGObaj
 ZpJdH+B1grrKvkqoG5UJe4/qC5+mqGPSyv97vj0+KHUCbAAuu96OVMATEM/Jf/sDbijd
 wjlA==
X-Gm-Message-State: AAQBX9fyCasxYE4mpl245eY1aIG4Piju21lblFHSboDwqJBd5O/OMzrk
 rbSU8xregMmb6syJJc8Ji/n89k/bYSwH+lqpMiLZ7ssLC9+3rByDbbCtJaqvc5y/0roXTIJkkG1
 5v8fuy2QECIP5LXdATaXUZlkUmT788M32iTWhcJXb3A==
X-Received: by 2002:adf:ec47:0:b0:2fb:5296:cd19 with SMTP id
 w7-20020adfec47000000b002fb5296cd19mr8423858wrn.53.1682311981275; 
 Sun, 23 Apr 2023 21:53:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bB3mjz+cVZDqOtrHNeyIsKxlCwBtG0hPjx5dXqK0UROOD8XD5Sh6gp2SodtNhSnes8CM2cYw==
X-Received: by 2002:adf:ec47:0:b0:2fb:5296:cd19 with SMTP id
 w7-20020adfec47000000b002fb5296cd19mr8423851wrn.53.1682311981009; 
 Sun, 23 Apr 2023 21:53:01 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d500e000000b002cff0e213ddsm9866024wrt.14.2023.04.23.21.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 21:53:00 -0700 (PDT)
Date: Mon, 24 Apr 2023 00:52:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Message-ID: <20230424005242-mutt-send-email-mst@kernel.org>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <CACGkMEstNJ1TJtTApniJLyN872gF9ZpAbj3hEKUw6yX3ZpPiFg@mail.gmail.com>
 <cf384aed-7ac4-02af-c2b5-b66c03a86aa9@intel.com>
 <c939205a-adc3-75eb-de16-617d6d001e18@intel.com>
 <CACGkMEsHDZAiOHi31gOV=OLF4sbQGY3sRLDkReQMmRAP322gBw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsHDZAiOHi31gOV=OLF4sbQGY3sRLDkReQMmRAP322gBw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gTW9uLCBBcHIgMjQsIDIwMjMgYXQgMTE6NTA6MjBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIEFwciAyMCwgMjAyMyBhdCA1OjE34oCvUE0gWmh1LCBMaW5nc2hhbiA8bGlu
Z3NoYW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4gPgo+ID4KPiA+Cj4gPiBPbiA0LzMvMjAyMyA2
OjEwIFBNLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+ID4gPgo+ID4gPgo+ID4gPiBPbiA0LzMvMjAy
MyAxOjI4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPj4gT24gRnJpLCBNYXIgMzEsIDIwMjMg
YXQgODo0OeKAr1BNIFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+ID4+
IHdyb3RlOgo+ID4gPj4+IEZvcm1lcmx5LCBpZmN2ZiBkcml2ZXIgaGFzIGltcGxlbWVudGVkIGEg
bGF6eS1pbml0aWFsaXphdGlvbiBtZWNoYW5pc20KPiA+ID4+PiBmb3IgdGhlIHZpcnRxdWV1ZXMg
YW5kIG90aGVyIGNvbmZpZyBzcGFjZSBjb250ZW50cywKPiA+ID4+PiBpdCB3b3VsZCBzdG9yZSBh
bGwgY29uZmlndXJhdGlvbnMgdGhhdCBwYXNzZWQgZG93biBmcm9tIHRoZSB1c2Vyc3BhY2UsCj4g
PiA+Pj4gdGhlbiBsb2FkIHRoZW0gdG8gdGhlIGRldmljZSBjb25maWcgc3BhY2UgdXBvbiBEUklW
RVJfT0suCj4gPiA+Pj4KPiA+ID4+PiBUaGlzIGNhbiBub3Qgc2VydmUgbGl2ZSBtaWdyYXRpb24s
IHNvIHRoaXMgc2VyaWVzIGltcGxlbWVudCBhbgo+ID4gPj4+IGltbWVkaWF0ZSBpbml0aWFsaXph
dGlvbiBtZWNoYW5pc20sIHdoaWNoIG1lYW5zIHJhdGhlciB0aGFuIHRoZQo+ID4gPj4+IGZvcm1l
ciBzdG9yZS1sb2FkIHByb2Nlc3MsIHRoZSB2aXJ0aW8gb3BlcmF0aW9ucyBsaWtlIHZxIG9wcwo+
ID4gPj4+IHdvdWxkIHRha2UgaW1tZWRpYXRlIGFjdGlvbnMgYnkgYWNjZXNzIHRoZSB2aXJ0aW8g
cmVnaXN0ZXJzLgo+ID4gPj4gSXMgdGhlcmUgYW55IGNoYW5jZSB0aGF0IGlmY3ZmIGNhbiB1c2Ug
dmlydGlvX3BjaV9tb2Rlcm5fZGV2IGxpYnJhcnk/Cj4gPiA+Pgo+ID4gPj4gVGhlbiB3ZSBkb24n
dCBuZWVkIHRvIGR1cGxpY2F0ZSB0aGUgY29kZXMuCj4gPiA+Pgo+ID4gPj4gTm90ZSB0aGF0IHBk
c192ZHBhIHdpbGwgYmUgdGhlIHNlY29uZCB1c2VyIGZvciB2aXJ0aW9fcGNpX21vZGVybl9kZXYK
PiA+ID4+IGxpYnJhcnkgKGFuZCB0aGUgZmlyc3QgdkRQQSBwYXJlbnQgdG8gdXNlIHRoYXQgbGli
cmFyeSkuCj4gPiA+IFllcyBJIGFncmVlIHRoaXMgbGlicmFyeSBjYW4gaGVscCBhIGxvdCBmb3Ig
YSBzdGFuZGFyZCB2aXJ0aW8gcGNpIGRldmljZS4KPiA+ID4gQnV0IHRoaXMgY2hhbmdlIHdvdWxk
IGJlIGh1Z2UsIGl0cyBsaWtlIHJlcXVpcmUgdG8gY2hhbmdlIGV2ZXJ5IGxpbmUgb2YKPiA+ID4g
dGhlIGRyaXZlci4gRm9yIGV4YW1wbGUgY3VycmVudCBkcml2ZXIgZnVuY3Rpb25zIHdvcmsgb24g
dGhlIGFkYXB0ZXIgYW5kCj4gPiA+IGlmY3ZmX2h3LCBpZiB3ZSB3YW50cyB0byByZXVzZSB0aGUg
bGliLCB3ZSBuZWVkIHRoZSBkcml2ZXIgd29yayBvbgo+ID4gPiBzdHJ1Y3QgdmlydGlvX3BjaV9t
b2Rlcm5fZGV2aWNlLgo+ID4gPiBBbG1vc3QgbmVlZCB0byByZS13cml0ZSB0aGUgZHJpdmVyLgo+
ID4gPgo+ID4gPiBDYW4gd2UgcGxhbiB0aGlzIGh1Z2UgY2hhbmdlIGluIGZvbGxvd2luZyBzZXJp
ZXM/Cj4gPiBwaW5nCj4gCj4gV2lsbCBnbyB0aHJvdWdoIHRoaXMgdGhpcyB3ZWVrLgo+IAo+IFRo
YW5rcwoKd2h5IGRvIHlvdSBleHBlY3QgaXQgdG8gZ28gdGhyb3VnaCwgeW91IGRpZG4ndCBhY2s/
Cgo+ID4gPgo+ID4gPiBUaGFua3MsCj4gPiA+IFpodSBMaW5nc2hhbgo+ID4gPj4KPiA+ID4+IFRo
YW5rcwo+ID4gPj4KPiA+ID4+PiBUaGlzIHNlcmllcyBhbHNvIGltcGxlbWVudCBpcnEgc3luY2hy
b25pemF0aW9uIGluIHRoZSByZXNldAo+ID4gPj4+IHJvdXRpbmUKPiA+ID4+Pgo+ID4gPj4+IFpo
dSBMaW5nc2hhbiAoNSk6Cj4gPiA+Pj4gICAgdmlydCBxdWV1ZSBvcHMgdGFrZSBpbW1lZGlhdGUg
YWN0aW9ucwo+ID4gPj4+ICAgIGdldF9kcml2ZXJfZmVhdHVyZXMgZnJvbSB2aXJpdG8gcmVnaXN0
ZXJzCj4gPiA+Pj4gICAgcmV0aXJlIGlmY3ZmX3N0YXJ0X2RhdGFwYXRoIGFuZCBpZmN2Zl9hZGRf
c3RhdHVzCj4gPiA+Pj4gICAgc3luY2hyb25pemUgaXJxcyBpbiB0aGUgcmVzZXQgcm91dGluZQo+
ID4gPj4+ICAgIGEgdmVuZG9yIGRyaXZlciBzaG91bGQgbm90IHNldCBfQ09ORklHX1NfRkFJTEVE
Cj4gPiA+Pj4KPiA+ID4+PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgfCAxNjIK
PiA+ID4+PiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ID4gPj4+ICAgZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8ICAxNiArKy0tCj4gPiA+Pj4gICBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgIDk3ICsrKystLS0tLS0tLS0tLS0tLS0KPiA+ID4+PiAg
IDMgZmlsZXMgY2hhbmdlZCwgMTIyIGluc2VydGlvbnMoKyksIDE1MyBkZWxldGlvbnMoLSkKPiA+
ID4+Pgo+ID4gPj4+IC0tCj4gPiA+Pj4gMi4zOS4xCj4gPiA+Pj4KPiA+ID4KPiA+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
