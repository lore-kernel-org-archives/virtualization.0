Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7267C433EF
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 06:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48C80417B0;
	Thu, 17 Feb 2022 06:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yFiuS2rSMPqt; Thu, 17 Feb 2022 06:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 46939417AD;
	Thu, 17 Feb 2022 06:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB56C002D;
	Thu, 17 Feb 2022 06:02:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18038C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 06:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05D70417B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 06:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nn_Fzam5Pa83
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 06:02:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39505417AD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 06:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645077739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJ43gSmtVUJMmgA5fIQo+GYRl7d1tlzDB8+T6/5SR7g=;
 b=MJh2w0/GJamhfY4UKhPti7KohjDvnqgu37GPWcU6umEQrESkwkHKvZyhUM7HjXSaOwLS10
 o4U8YGiIulVdaS3ODzqA8fbkCZ8g+2BqqyO6ZgwXz359xt2JuZdizRcuHNoWfD1xIU4j7W
 i4L2QRIVcrgZkaqpB86R9JiLg7IbuHQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-MoV4KevONSKn0Qa1lLMGUw-1; Thu, 17 Feb 2022 01:02:18 -0500
X-MC-Unique: MoV4KevONSKn0Qa1lLMGUw-1
Received: by mail-yb1-f200.google.com with SMTP id
 b12-20020a056902030c00b0061d720e274aso8829001ybs.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 22:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AJ43gSmtVUJMmgA5fIQo+GYRl7d1tlzDB8+T6/5SR7g=;
 b=QAmsuoHSyXnQdS5Xdi6k9AuUtK+n35YC98yU/Io2kLAAh+CgkYptc0YKw+w0sud4g6
 zau40X0YJJThYNpfJ00degidHuSPrgkCgJKtqiqi9oG/XFz6cS2QMUppglTHhdrUdw+s
 iNRwAUKeOrxeFcPGsqmc80kNh5RoWlvdwPra4xrftENqhtuWGEGH3X/uEpWZhL4JWR49
 lAKudnFLmm1TZvJDIxPj2ChyrFU35DK/Ft/TjafP/eCgCLXtxWzvOfHsEmccm7Bnrud5
 P6+KSz5FYVn4AKQ/cABA2F42lbaw41zZg9Lg0HOjoPCx0QXtKLQAbTWkX/F8Bpw3bdjK
 N9zg==
X-Gm-Message-State: AOAM5313BZsV4/n35a6IfIYrR/3QAuSI+rXewJRlvgwAFPOfZd6cLpXP
 N97yztVaf3B10uo95PQ0kL2NBR4BHXKsJiI5ZlnySIwaCtpYhvQWaM8PtcVAqr3NX1DYf5yx7wi
 XEvLiYANbFaWsQ5Djv+2VMjHUszcyNEOpSwVP/ciaIpnbB8DzWCCrymjY6w==
X-Received: by 2002:a81:c54a:0:b0:2d6:435a:5875 with SMTP id
 o10-20020a81c54a000000b002d6435a5875mr1188494ywj.181.1645077737482; 
 Wed, 16 Feb 2022 22:02:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWDR785zTtcjGEoamEsKqFytogOfPdl/ew1QqgL/zFAsqSiEZOt7izL9dDH41YrCUJp0By1t1R65bKo1jhMYY=
X-Received: by 2002:a81:c54a:0:b0:2d6:435a:5875 with SMTP id
 o10-20020a81c54a000000b002d6435a5875mr1188475ywj.181.1645077737156; Wed, 16
 Feb 2022 22:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-29-eperezma@redhat.com>
 <42664143-6d0c-b107-ec90-8e6336bae29b@redhat.com>
 <CAJaqyWdBLU+maEhByepzeH7iwLmqUba0rRb8PM4VwBy2P8Vtow@mail.gmail.com>
 <9b32f664-56a9-3718-cf48-49003f87d430@redhat.com>
 <CAJaqyWcvWjPas0=xp+U-c-kG+e6k73jg=C4phFD7S-tZY=niSQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcvWjPas0=xp+U-c-kG+e6k73jg=C4phFD7S-tZY=niSQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Feb 2022 14:02:05 +0800
Message-ID: <CACGkMEtbd9RsE9f-HLnwmhJEFsK++uBHnqG4N0c6qJG0PxDdzw@mail.gmail.com>
Subject: Re: [PATCH 28/31] vdpa: Expose VHOST_F_LOG_ALL on SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

T24gV2VkLCBGZWIgMTYsIDIwMjIgYXQgMTE6NTQgUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4KPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBGZWIgOCwgMjAyMiBhdCA5OjI1
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDl
nKggMjAyMi8yLzEg5LiL5Y2INzo0NSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+ID4g
PiBPbiBTdW4sIEphbiAzMCwgMjAyMiBhdCA3OjUwIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4KPiA+ID4+IOWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywg
RXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+ID4gPj4+IFNWUSBpcyBhYmxlIHRvIGxvZyB0aGUgZGly
dHkgYml0cyBieSBpdHNlbGYsIHNvIGxldCdzIHVzZSBpdCB0byBub3QKPiA+ID4+PiBibG9jayBt
aWdyYXRpb24uCj4gPiA+Pj4KPiA+ID4+PiBBbHNvLCBpZ25vcmUgc2V0IGFuZCBjbGVhciBvZiBW
SE9TVF9GX0xPR19BTEwgb24gc2V0X2ZlYXR1cmVzIGlmIFNWUSBpcwo+ID4gPj4+IGVuYWJsZWQu
IEV2ZW4gaWYgdGhlIGRldmljZSBzdXBwb3J0cyBpdCwgdGhlIHJlcG9ydHMgd291bGQgYmUgbm9u
c2Vuc2UKPiA+ID4+PiBiZWNhdXNlIFNWUSBtZW1vcnkgaXMgaW4gdGhlIHFlbXUgcmVnaW9uLgo+
ID4gPj4+Cj4gPiA+Pj4gVGhlIGxvZyByZWdpb24gaXMgc3RpbGwgYWxsb2NhdGVkLiBGdXR1cmUg
Y2hhbmdlcyBtaWdodCBza2lwIHRoYXQsIGJ1dAo+ID4gPj4+IHRoaXMgc2VyaWVzIGlzIGFscmVh
ZHkgbG9uZyBlbm91Z2guCj4gPiA+Pj4KPiA+ID4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4+PiAtLS0KPiA+ID4+PiAgICBody92aXJ0
aW8vdmhvc3QtdmRwYS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysKPiA+ID4+PiAgICAxIGZp
bGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQo+ID4gPj4+Cj4gPiA+Pj4gZGlmZiAtLWdpdCBh
L2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gPiA+Pj4g
aW5kZXggZmIwYTMzOGJhYS4uNzUwOTBkNjVlOCAxMDA2NDQKPiA+ID4+PiAtLS0gYS9ody92aXJ0
aW8vdmhvc3QtdmRwYS5jCj4gPiA+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+ID4g
Pj4+IEBAIC0xMDIyLDYgKzEwMjIsOSBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfZ2V0X2ZlYXR1
cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDY0X3QgKmZlYXR1cmVzKQo+ID4gPj4+ICAg
ICAgICBpZiAocmV0ID09IDAgJiYgdi0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gPiA+Pj4gICAg
ICAgICAgICAvKiBGaWx0ZXIgb25seSBmZWF0dXJlcyB0aGF0IFNWUSBjYW4gb2ZmZXIgdG8gZ3Vl
c3QgKi8KPiA+ID4+PiAgICAgICAgICAgIHZob3N0X3N2cV92YWxpZF9ndWVzdF9mZWF0dXJlcyhm
ZWF0dXJlcyk7Cj4gPiA+Pj4gKwo+ID4gPj4+ICsgICAgICAgIC8qIEFkZCBTVlEgbG9nZ2luZyBj
YXBhYmlsaXRpZXMgKi8KPiA+ID4+PiArICAgICAgICAqZmVhdHVyZXMgfD0gQklUX1VMTChWSE9T
VF9GX0xPR19BTEwpOwo+ID4gPj4+ICAgICAgICB9Cj4gPiA+Pj4KPiA+ID4+PiAgICAgICAgcmV0
dXJuIHJldDsKPiA+ID4+PiBAQCAtMTAzOSw4ICsxMDQyLDI1IEBAIHN0YXRpYyBpbnQgdmhvc3Rf
dmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ID4gPj4+Cj4gPiA+Pj4g
ICAgICAgIGlmICh2LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsKPiA+ID4+PiAgICAgICAgICAgIHVp
bnQ2NF90IGRldl9mZWF0dXJlcywgc3ZxX2ZlYXR1cmVzLCBhY2tlZF9mZWF0dXJlczsKPiA+ID4+
PiArICAgICAgICB1aW50OF90IHN0YXR1cyA9IDA7Cj4gPiA+Pj4gICAgICAgICAgICBib29sIG9r
Owo+ID4gPj4+Cj4gPiA+Pj4gKyAgICAgICAgcmV0ID0gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhP
U1RfVkRQQV9HRVRfU1RBVFVTLCAmc3RhdHVzKTsKPiA+ID4+PiArICAgICAgICBpZiAodW5saWtl
bHkocmV0KSkgewo+ID4gPj4+ICsgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4gPj4+ICsgICAg
ICAgIH0KPiA+ID4+PiArCj4gPiA+Pj4gKyAgICAgICAgaWYgKHN0YXR1cyAmIFZJUlRJT19DT05G
SUdfU19EUklWRVJfT0spIHsKPiA+ID4+PiArICAgICAgICAgICAgLyoKPiA+ID4+PiArICAgICAg
ICAgICAgICogdmhvc3QgaXMgdHJ5aW5nIHRvIGVuYWJsZSBvciBkaXNhYmxlIF9GX0xPRywgYW5k
IHRoZSBkZXZpY2UKPiA+ID4+PiArICAgICAgICAgICAgICogd291bGQgcmVwb3J0IHdyb25nIGRp
cnR5IHBhZ2VzLiBTVlEgaGFuZGxlcyBpdC4KPiA+ID4+PiArICAgICAgICAgICAgICovCj4gPiA+
Pgo+ID4gPj4gSSBmYWlsIHRvIHVuZGVyc3RhbmQgdGhpcyBjb21tZW50LCBJJ2QgdGhpbmsgdGhl
cmUncyBubyB3YXkgdG8gZGlzYWJsZQo+ID4gPj4gZGlydHkgcGFnZSB0cmFja2luZyBmb3IgU1ZR
Lgo+ID4gPj4KPiA+ID4gdmhvc3RfbG9nX2dsb2JhbF97c3RhcnQsc3RvcH0gYXJlIGNhbGxlZCBh
dCB0aGUgYmVnaW5uaW5nIGFuZCBlbmQgb2YKPiA+ID4gbWlncmF0aW9uLiBUbyBpbmZvcm0gdGhl
IGRldmljZSB0aGF0IGl0IHNob3VsZCBzdGFydCBsb2dnaW5nLCB0aGV5IHNldAo+ID4gPiBvciBj
bGVhbiBWSE9TVF9GX0xPR19BTEwgYXQgdmhvc3RfZGV2X3NldF9sb2cuCj4gPgo+ID4KPiA+IFll
cywgYnV0IGZvciBTVlEsIHdlIGNhbid0IGRpc2FibGUgZGlydHkgcGFnZSB0cmFja2luZywgaXNu
J3QgaXQ/IFRoZQo+ID4gb25seSB0aGluZyBpcyB0byBpZ25vcmUgb3IgZmlsdGVyIG91dCB0aGUg
Rl9MT0dfQUxMIGFuZCBwcmV0ZW5kIHRvIGJlCj4gPiBlbmFibGVkIGFuZCBkaXNhYmxlZC4KPiA+
Cj4KPiBZZXMsIHRoYXQncyB3aGF0IHRoaXMgcGF0Y2ggZG9lcy4KPgo+ID4KPiA+ID4KPiA+ID4g
V2hpbGUgU1ZRIGRvZXMgbm90IHVzZSBWSE9TVF9GX0xPR19BTEwsIGl0IGV4cG9ydHMgdGhlIGZl
YXR1cmUgYml0IHNvCj4gPiA+IHZob3N0IGRvZXMgbm90IGJsb2NrIG1pZ3JhdGlvbi4gTWF5YmUg
d2UgbmVlZCB0byBsb29rIGZvciBhbm90aGVyIHdheQo+ID4gPiB0byBkbyB0aGlzPwo+ID4KPiA+
Cj4gPiBJJ20gZmluZSB3aXRoIGZpbHRlcmluZyBzaW5jZSBpdCdzIG11Y2ggbW9yZSBzaW1wbGVy
LCBidXQgSSBmYWlsIHRvCj4gPiB1bmRlcnN0YW5kIHdoeSB3ZSBuZWVkIHRvIGNoZWNrIERSSVZF
Ul9PSy4KPiA+Cj4KPiBPayBtYXliZSBJIGNhbiBtYWtlIHRoYXQgcGFydCBtb3JlIGNsZWFyLAo+
Cj4gU2luY2UgYm90aCBvcGVyYXRpb25zIHVzZSB2aG9zdF92ZHBhX3NldF9mZWF0dXJlcyB3ZSBt
dXN0IGp1c3QgZmlsdGVyCj4gdGhlIG9uZSB0aGF0IGFjdHVhbGx5IHNldHMgb3IgcmVtb3ZlcyBW
SE9TVF9GX0xPR19BTEwsIHdpdGhvdXQKPiBhZmZlY3Rpbmcgb3RoZXIgZmVhdHVyZXMuCj4KPiBJ
biBwcmFjdGljZSwgdGhhdCBtZWFucyB0byBub3QgZm9yd2FyZCB0aGUgc2V0IGZlYXR1cmVzIGFm
dGVyCj4gRFJJVkVSX09LLiBUaGUgZGV2aWNlIGlzIG5vdCBleHBlY3RpbmcgdGhlbSBhbnltb3Jl
LgoKSSB3b25kZXIgd2hhdCBoYXBwZW5zIGlmIHdlIGRvbid0IGRvIHRoaXMuCgpTbyBrZXJuZWwg
aGFkIHRoaXMgY2hlY2s6CgogICAgICAgIC8qCiAgICAgICAgICogSXQncyBub3QgYWxsb3dlZCB0
byBjaGFuZ2UgdGhlIGZlYXR1cmVzIGFmdGVyIHRoZXkgaGF2ZQogICAgICAgICAqIGJlZW4gbmVn
b3RpYXRlZC4KICAgICAgICAgKi8KaWYgKG9wcy0+Z2V0X3N0YXR1cyh2ZHBhKSAmIFZJUlRJT19D
T05GSUdfU19GRUFUVVJFU19PSykKICAgICAgICByZXR1cm4gLUVCVVNZOwoKU28gaXMgaXQgRkVB
VFVSRVNfT0sgYWN0dWFsbHk/CgpGb3IgdGhpcyBwYXRjaCwgSSB3b25kZXIgaWYgdGhlIHRoaW5n
IHdlIG5lZWQgdG8gZG8gaXMgdG8gc2VlIHdoZXRoZXIKaXQgaXMgYSBlbmFibGUvZGlzYWJsZSBG
X0xPR19BTEwgYW5kIHNpbXBseSByZXR1cm4uCgpUaGFua3MKCj4KPiBEb2VzIHRoYXQgbWFrZSBt
b3JlIHNlbnNlPwo+Cj4gVGhhbmtzIQo+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPgo+ID4gPiBU
aGFua3MhCj4gPiA+Cj4gPiA+PiBUaGFua3MKPiA+ID4+Cj4gPiA+Pgo+ID4gPj4+ICsgICAgICAg
ICAgICByZXR1cm4gMDsKPiA+ID4+PiArICAgICAgICB9Cj4gPiA+Pj4gKwo+ID4gPj4+ICsgICAg
ICAgIC8qIFdlIG11c3Qgbm90IGFjayBfRl9MT0cgaWYgU1ZRIGlzIGVuYWJsZWQgKi8KPiA+ID4+
PiArICAgICAgICBmZWF0dXJlcyAmPSB+QklUX1VMTChWSE9TVF9GX0xPR19BTEwpOwo+ID4gPj4+
ICsKPiA+ID4+PiAgICAgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfZ2V0X2Rldl9mZWF0dXJlcyhk
ZXYsICZkZXZfZmVhdHVyZXMpOwo+ID4gPj4+ICAgICAgICAgICAgaWYgKHJldCAhPSAwKSB7Cj4g
PiA+Pj4gICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJDYW4ndCBnZXQgdmRwYSBkZXZpY2Ug
ZmVhdHVyZXMsIGdvdCAoJWQpIiwgcmV0KTsKPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
