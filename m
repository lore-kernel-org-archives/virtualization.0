Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA39EC7618E
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 05:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50F5B60D63;
	Mon, 24 Apr 2023 05:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50F5B60D63
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sfd3VxBr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKMtUYaaGRWL; Mon, 24 Apr 2023 05:20:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBEA060E58;
	Mon, 24 Apr 2023 05:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBEA060E58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89226C0037;
	Mon, 24 Apr 2023 05:20:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2142AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 05:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7C8160E58
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 05:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7C8160E58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPhBNmiog207
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 05:20:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2804E60D63
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2804E60D63
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 05:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682313628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUiMUnH0WF4k9MEHrNS0cUtHJ7SFOpchLaBD3xRYGmA=;
 b=Sfd3VxBrrZF/0dx321sKOj25omRSotDgpNCBrIyH5a0FB/hUBDRAFaII9k6WdnIt7JUqfz
 k3pJROtmcJwCqyX1St1cLdiMKDKAiokFn3HCMEn2LAVIWSYV+QrwsXr+hR3bHFgKqX4QUj
 BDs8U18tqjgXUyA68iMx+KxQeKAHVl8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-j6TAexR6PumxF4G3F45lQw-1; Mon, 24 Apr 2023 01:20:27 -0400
X-MC-Unique: j6TAexR6PumxF4G3F45lQw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-38def77dd7fso2656050b6e.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 22:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682313626; x=1684905626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUiMUnH0WF4k9MEHrNS0cUtHJ7SFOpchLaBD3xRYGmA=;
 b=GO3a2PRppCMkM7fQK+4vfzz/096WaUQOX+k7umDjjrIbwMEPQFNCengTdc/Wn6Qem8
 kwfZlJNIx2z1/pT5tr0z4/oOViHp91giKlVuvfrqeMHIz5Nly8JPrjwR5jNm3yTwqE+E
 7CwJkp+cHQtpjF/Fr0QPx4fg+pQC0Cr+FEVRDN1QO3exXs5vM2zNesy+VkzntCU4odaS
 Wq6Xc3zY3iVATZMoLJMHE6qReKCVdO8FhFSe9g6F6lBsB5xIvo4L/lZgM7bx9rAxY1Gy
 p6WWvgN2PKmTkRuBYiIXe//xLmx4O0XUn0SYlPoZ/7xGEcU4giYeqUKY84neLJ14cEJx
 d+og==
X-Gm-Message-State: AAQBX9dNkhtGqzO6jCVIvzmRjskLGREhoSlD+6r5394Sv6vKCiDWtl6H
 DmA8SQ1InBW1aoPf0ywMR5t1wtrwUFKuyUsCVxyc+MiH0og2axtpBL8IMxz44ktAA6qGckcVyLZ
 s1yhdvZKKq9CfdJ2h99MkVw2QpgbiUQm4+ToAY6vxp5rmQaHTOInl5SZOww==
X-Received: by 2002:a54:4d88:0:b0:38d:f4dd:ac69 with SMTP id
 y8-20020a544d88000000b0038df4ddac69mr5359624oix.42.1682313626448; 
 Sun, 23 Apr 2023 22:20:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350aASS1hE92xR+DLjOrsttmzxASEeAZaASwLpEVCIHuCk6hJp52M0OozAgpEHYsGloz0DBWDMTftmIsIxNtrdLY=
X-Received: by 2002:a54:4d88:0:b0:38d:f4dd:ac69 with SMTP id
 y8-20020a544d88000000b0038df4ddac69mr5359620oix.42.1682313626161; Sun, 23 Apr
 2023 22:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <CACGkMEstNJ1TJtTApniJLyN872gF9ZpAbj3hEKUw6yX3ZpPiFg@mail.gmail.com>
 <cf384aed-7ac4-02af-c2b5-b66c03a86aa9@intel.com>
 <c939205a-adc3-75eb-de16-617d6d001e18@intel.com>
 <CACGkMEsHDZAiOHi31gOV=OLF4sbQGY3sRLDkReQMmRAP322gBw@mail.gmail.com>
 <20230424005242-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230424005242-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Apr 2023 13:20:12 +0800
Message-ID: <CACGkMEvu=sRmXQaJ55FTi_8nXT4s5azFmrngOAbb=OzF_3gL3g@mail.gmail.com>
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gTW9uLCBBcHIgMjQsIDIwMjMgYXQgMTI6NTPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgQXByIDI0LCAyMDIzIGF0IDExOjUwOjIw
QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUaHUsIEFwciAyMCwgMjAyMyBhdCA1
OjE34oCvUE0gWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4g
PiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+IE9uIDQvMy8yMDIzIDY6MTAgUE0sIFpodSwgTGluZ3NoYW4g
d3JvdGU6Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IE9uIDQvMy8yMDIzIDE6MjggUE0sIEphc29u
IFdhbmcgd3JvdGU6Cj4gPiA+ID4+IE9uIEZyaSwgTWFyIDMxLCAyMDIzIGF0IDg6NDnigK9QTSBa
aHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPiA+ID4+IHdyb3RlOgo+ID4g
PiA+Pj4gRm9ybWVybHksIGlmY3ZmIGRyaXZlciBoYXMgaW1wbGVtZW50ZWQgYSBsYXp5LWluaXRp
YWxpemF0aW9uIG1lY2hhbmlzbQo+ID4gPiA+Pj4gZm9yIHRoZSB2aXJ0cXVldWVzIGFuZCBvdGhl
ciBjb25maWcgc3BhY2UgY29udGVudHMsCj4gPiA+ID4+PiBpdCB3b3VsZCBzdG9yZSBhbGwgY29u
ZmlndXJhdGlvbnMgdGhhdCBwYXNzZWQgZG93biBmcm9tIHRoZSB1c2Vyc3BhY2UsCj4gPiA+ID4+
PiB0aGVuIGxvYWQgdGhlbSB0byB0aGUgZGV2aWNlIGNvbmZpZyBzcGFjZSB1cG9uIERSSVZFUl9P
Sy4KPiA+ID4gPj4+Cj4gPiA+ID4+PiBUaGlzIGNhbiBub3Qgc2VydmUgbGl2ZSBtaWdyYXRpb24s
IHNvIHRoaXMgc2VyaWVzIGltcGxlbWVudCBhbgo+ID4gPiA+Pj4gaW1tZWRpYXRlIGluaXRpYWxp
emF0aW9uIG1lY2hhbmlzbSwgd2hpY2ggbWVhbnMgcmF0aGVyIHRoYW4gdGhlCj4gPiA+ID4+PiBm
b3JtZXIgc3RvcmUtbG9hZCBwcm9jZXNzLCB0aGUgdmlydGlvIG9wZXJhdGlvbnMgbGlrZSB2cSBv
cHMKPiA+ID4gPj4+IHdvdWxkIHRha2UgaW1tZWRpYXRlIGFjdGlvbnMgYnkgYWNjZXNzIHRoZSB2
aXJ0aW8gcmVnaXN0ZXJzLgo+ID4gPiA+PiBJcyB0aGVyZSBhbnkgY2hhbmNlIHRoYXQgaWZjdmYg
Y2FuIHVzZSB2aXJ0aW9fcGNpX21vZGVybl9kZXYgbGlicmFyeT8KPiA+ID4gPj4KPiA+ID4gPj4g
VGhlbiB3ZSBkb24ndCBuZWVkIHRvIGR1cGxpY2F0ZSB0aGUgY29kZXMuCj4gPiA+ID4+Cj4gPiA+
ID4+IE5vdGUgdGhhdCBwZHNfdmRwYSB3aWxsIGJlIHRoZSBzZWNvbmQgdXNlciBmb3IgdmlydGlv
X3BjaV9tb2Rlcm5fZGV2Cj4gPiA+ID4+IGxpYnJhcnkgKGFuZCB0aGUgZmlyc3QgdkRQQSBwYXJl
bnQgdG8gdXNlIHRoYXQgbGlicmFyeSkuCj4gPiA+ID4gWWVzIEkgYWdyZWUgdGhpcyBsaWJyYXJ5
IGNhbiBoZWxwIGEgbG90IGZvciBhIHN0YW5kYXJkIHZpcnRpbyBwY2kgZGV2aWNlLgo+ID4gPiA+
IEJ1dCB0aGlzIGNoYW5nZSB3b3VsZCBiZSBodWdlLCBpdHMgbGlrZSByZXF1aXJlIHRvIGNoYW5n
ZSBldmVyeSBsaW5lIG9mCj4gPiA+ID4gdGhlIGRyaXZlci4gRm9yIGV4YW1wbGUgY3VycmVudCBk
cml2ZXIgZnVuY3Rpb25zIHdvcmsgb24gdGhlIGFkYXB0ZXIgYW5kCj4gPiA+ID4gaWZjdmZfaHcs
IGlmIHdlIHdhbnRzIHRvIHJldXNlIHRoZSBsaWIsIHdlIG5lZWQgdGhlIGRyaXZlciB3b3JrIG9u
Cj4gPiA+ID4gc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZS4KPiA+ID4gPiBBbG1vc3Qg
bmVlZCB0byByZS13cml0ZSB0aGUgZHJpdmVyLgo+ID4gPiA+Cj4gPiA+ID4gQ2FuIHdlIHBsYW4g
dGhpcyBodWdlIGNoYW5nZSBpbiBmb2xsb3dpbmcgc2VyaWVzPwo+ID4gPiBwaW5nCj4gPgo+ID4g
V2lsbCBnbyB0aHJvdWdoIHRoaXMgdGhpcyB3ZWVrLgo+ID4KPiA+IFRoYW5rcwo+Cj4gd2h5IGRv
IHlvdSBleHBlY3QgaXQgdG8gZ28gdGhyb3VnaCwgeW91IGRpZG4ndCBhY2s/CgpJIG1lYW50IEkg
d2lsbCBoYXZlIGEgbG9vayBhdCBpdCB0aGlzIHdlZWssCgooR29vZ2xlIHRvbGQgbWUgImdvIHRo
cm91Z2giIG1lYW50ICJ0byBsb29rIGF0IG9yIGV4YW1pbmUgc29tZXRoaW5nIGNhcmVmdWxseSIp
CgpUaGFua3MKCj4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiBaaHUgTGluZ3NoYW4K
PiA+ID4gPj4KPiA+ID4gPj4gVGhhbmtzCj4gPiA+ID4+Cj4gPiA+ID4+PiBUaGlzIHNlcmllcyBh
bHNvIGltcGxlbWVudCBpcnEgc3luY2hyb25pemF0aW9uIGluIHRoZSByZXNldAo+ID4gPiA+Pj4g
cm91dGluZQo+ID4gPiA+Pj4KPiA+ID4gPj4+IFpodSBMaW5nc2hhbiAoNSk6Cj4gPiA+ID4+PiAg
ICB2aXJ0IHF1ZXVlIG9wcyB0YWtlIGltbWVkaWF0ZSBhY3Rpb25zCj4gPiA+ID4+PiAgICBnZXRf
ZHJpdmVyX2ZlYXR1cmVzIGZyb20gdmlyaXRvIHJlZ2lzdGVycwo+ID4gPiA+Pj4gICAgcmV0aXJl
IGlmY3ZmX3N0YXJ0X2RhdGFwYXRoIGFuZCBpZmN2Zl9hZGRfc3RhdHVzCj4gPiA+ID4+PiAgICBz
eW5jaHJvbml6ZSBpcnFzIGluIHRoZSByZXNldCByb3V0aW5lCj4gPiA+ID4+PiAgICBhIHZlbmRv
ciBkcml2ZXIgc2hvdWxkIG5vdCBzZXQgX0NPTkZJR19TX0ZBSUxFRAo+ID4gPiA+Pj4KPiA+ID4g
Pj4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDE2Mgo+ID4gPiA+Pj4gKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiA+ID4gPj4+ICAgZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX2Jhc2UuaCB8ICAxNiArKy0tCj4gPiA+ID4+PiAgIGRyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMgfCAgOTcgKysrKy0tLS0tLS0tLS0tLS0tLQo+ID4gPiA+Pj4gICAzIGZp
bGVzIGNoYW5nZWQsIDEyMiBpbnNlcnRpb25zKCspLCAxNTMgZGVsZXRpb25zKC0pCj4gPiA+ID4+
Pgo+ID4gPiA+Pj4gLS0KPiA+ID4gPj4+IDIuMzkuMQo+ID4gPiA+Pj4KPiA+ID4gPgo+ID4gPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
