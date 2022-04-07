Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458BBC433FE
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 08:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F396D41820;
	Thu,  7 Apr 2022 08:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXlMFqf2G0RL; Thu,  7 Apr 2022 08:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED650417EF;
	Thu,  7 Apr 2022 08:04:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD411C001D;
	Thu,  7 Apr 2022 08:04:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4E98C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C204341811
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HIZC7f0ylPuK
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A12F9417EF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649318673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2jSiAWc9glJJIwE5hD1mRnDPKRSEruFK/e4YesNwp0=;
 b=hnbzFiXxwieG/H3urc7lYsZWiMHMibDrHi6JMJGjX5Tl1ZWMrSFr7dPzbNk7kyWbTbd9Me
 SH0ZCcoAgB6akSOXKIoOy8VzmKCFDK3agDol7szK8tamjEQzA0Vm1aEPpc5cV7pehkjaed
 zbBrk9TMUpCJhvx/obrmMESG5V0jGwY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-Z9DnBXKENO-fedQNVD33jQ-1; Thu, 07 Apr 2022 04:04:31 -0400
X-MC-Unique: Z9DnBXKENO-fedQNVD33jQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 d41-20020a0565123d2900b0044a10c21f39so1556378lfv.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Apr 2022 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C2jSiAWc9glJJIwE5hD1mRnDPKRSEruFK/e4YesNwp0=;
 b=xeJyv+PXtmo38Vd0y+6+e+Z1vN3rDFIqQgXH3hXW5MOXUzqwogKxOsemdXTmB+J4rW
 QASO0n48LkyYlEG0SpjoYTL03myH28dBo/QaMyA+AdMPPu4WUe0hb98sonu1ubtRb6Aw
 9xffVH8m42YcZSPbjyvtktTuXGsUSGskd7E0zOARLrS8TtdKZUHMcPOBlep3RBsNQgeq
 cSvP9KevbHWC6FbeaddDmUEKDrtUAAqsdDcV6XWbUMTgqIGCPA2TPwgrFy6lVH8FNNf0
 Aehl2MZaiGeOanqgYanqRTF/GHc1v/WwnzOs+QAMZAJR5OcFeozz9SpkVSruoVX2d7N1
 qasA==
X-Gm-Message-State: AOAM532tkf1ijKZlJ7BHL7hyCEGaCDcuSyOcROjxZvXAqUOmC3jRqhBU
 +IVnJ/aY0ujXbooJ9SDNYIEGFGaoGoX3ORWeH6F8SUzmDct8CTc3CVo5pbCHzuquiEWVKdYN3n6
 EieQAhsBAGuUQf9oROOEEoIY7fEabkHI/0/UZWAW4mjMK+WxcsmGmugiD8g==
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr8329557lfl.376.1649318669900; 
 Thu, 07 Apr 2022 01:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3HDJ+Ox/XqE+9zxT6Qp0nlecVIsvWwfNMMU25624Ob33IZJs6lQrttXYmKoYwsOidOhAVV6AoKVtr7eF/+ec=
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr8329542lfl.376.1649318669682; Thu, 07
 Apr 2022 01:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220406112858-mutt-send-email-mst@kernel.org>
 <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
 <87r169ba90.fsf@redhat.com>
In-Reply-To: <87r169ba90.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Apr 2022 16:04:18 +0800
Message-ID: <CACGkMEu-V3NwSmzJciwa1z_P94McirZaxbm26gNgM-8A9J2emg@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

T24gVGh1LCBBcHIgNywgMjAyMiBhdCAzOjUzIFBNIENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgQXByIDA3IDIwMjIsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gPiDlnKggMjAyMi80LzYg5LiL5Y2IMTE6MzEsIE1p
Y2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPj4gT24gV2VkLCBBcHIgMDYsIDIwMjIgYXQgMDM6
MDQ6MzJQTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPiA+Pj4gT24gV2VkLCBBcHIgMDYg
MjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4K
PiA+Pj4+IE9uIFdlZCwgQXByIDA2LCAyMDIyIGF0IDA0OjM1OjM3UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPj4+Pj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIFBDSSB2ZXJzaW9uIG9mIHN5
bmNocm9uaXplX3ZxcygpLgo+ID4+Pj4+Cj4gPj4+Pj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPgo+ID4+Pj4+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+Cj4gPj4+Pj4gQ2M6ICJQYXVsIEUuIE1jS2VubmV5IiA8cGF1bG1ja0BrZXJuZWwu
b3JnPgo+ID4+Pj4+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+ID4+Pj4+IFNp
Z25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPj4+PiBQbGVh
c2UgYWRkIGltcGxlbWVudGF0aW9ucyBhdCBsZWFzdCBmb3IgY2N3IGFuZCBtbWlvLgo+ID4+PiBJ
J20gbm90IHN1cmUgd2hhdCAoaWYgYW55dGhpbmcpIGNhbi9zaG91bGQgYmUgZG9uZSBmb3IgY2N3
Li4uCj4gPj4+Cj4gPj4+Pj4gLS0tCj4gPj4+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2NvbW1vbi5jIHwgMTQgKysrKysrKysrKysrKysKPiA+Pj4+PiAgIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmggfCAgMiArKwo+ID4+Pj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9sZWdhY3kuYyB8ICAxICsKPiA+Pj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bW9kZXJuLmMgfCAgMiArKwo+ID4+Pj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspCj4gPj4+Pj4KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9jb21tb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+Pj4+PiBp
bmRleCBkNzI0ZjY3NjYwOGIuLmI3OGM4YmM5M2E5NyAxMDA2NDQKPiA+Pj4+PiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4gPj4+Pj4gKysrIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9jb21tb24uYwo+ID4+Pj4+IEBAIC0zNyw2ICszNywyMCBAQCB2b2lkIHZw
X3N5bmNocm9uaXplX3ZlY3RvcnMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPj4+Pj4g
ICAgICAgICAgICAgICAgICAgc3luY2hyb25pemVfaXJxKHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+
cGNpX2RldiwgaSkpOwo+ID4+Pj4+ICAgfQo+ID4+Pj4+Cj4gPj4+Pj4gK3ZvaWQgdnBfc3luY2hy
b25pemVfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4+Pj4+ICt7Cj4gPj4+Pj4g
KyBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IHRvX3ZwX2RldmljZSh2ZGV2KTsK
PiA+Pj4+PiArIGludCBpOwo+ID4+Pj4+ICsKPiA+Pj4+PiArIGlmICh2cF9kZXYtPmludHhfZW5h
YmxlZCkgewo+ID4+Pj4+ICsgICAgICAgICBzeW5jaHJvbml6ZV9pcnEodnBfZGV2LT5wY2lfZGV2
LT5pcnEpOwo+ID4+Pj4+ICsgICAgICAgICByZXR1cm47Cj4gPj4+Pj4gKyB9Cj4gPj4+Pj4gKwo+
ID4+Pj4+ICsgZm9yIChpID0gMDsgaSA8IHZwX2Rldi0+bXNpeF92ZWN0b3JzOyArK2kpCj4gPj4+
Pj4gKyAgICAgICAgIHN5bmNocm9uaXplX2lycShwY2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9k
ZXYsIGkpKTsKPiA+Pj4+PiArfQo+ID4+Pj4+ICsKPiA+Pj4gLi4uZ2l2ZW4gdGhhdCB0aGlzIHNl
ZW1zIHRvIHN5bmNocm9uaXplIHRocmVhZGVkIGludGVycnVwdCBoYW5kbGVycz8KPiA+PiBObywg
YW55IGhhbmRsZXJzIGF0IGFsbC4gVGhlIHBvaW50IGlzIHRvIG1ha2Ugc3VyZSBhbnkgbWVtb3J5
IGNoYW5nZXMKPiA+PiBtYWRlIHByaW9yIHRvIHRoaXMgb3AgYXJlIHZpc2libGUgdG8gY2FsbGJh
Y2tzLgo+ID4+Cj4gPj4gSmFzb24sIG1heWJlIGFkZCB0aGF0IHRvIHRoZSBkb2N1bWVudGF0aW9u
Pwo+ID4KPiA+Cj4gPiBTdXJlLgo+ID4KPiA+Cj4gPj4KPiA+Pj4gSGFsaWwsIGRvIHlvdSB0aGlu
ayBjY3cgbmVlZHMgdG8gZG8gYW55dGhpbmc/IChBRkFJQ1MsIHdlIG9ubHkgaGF2ZSBvbmUKPiA+
Pj4gJ2lycScgZm9yIGNoYW5uZWwgZGV2aWNlcyBhbnl3YXksIGFuZCB0aGUgaGFuZGxlciBqdXN0
IGNhbGxzIHRoZQo+ID4+PiByZWxldmFudCBjYWxsYmFja3MgZGlyZWN0bHkuKQo+ID4+IFRoZW4g
eW91IG5lZWQgdG8gc3luY2hyb25pemUgd2l0aCB0aGF0Lgo+ID4KPiA+Cj4gPiBIYXZlIGEgcXVp
Y2sgZ2xhbmNlIGF0IHRoZSBjb2RlcywgaXQgbG9va3MgdG8gbWUgd2UgY2FuIHN5bmNocm9uaXpl
IHdpdGgKPiA+IHRoZSBJT19JTlRFUlJVUFQuIChBc3N1bWluZyBhbGwgY2FsbGJhY2tzIGFyZSB0
cmlnZ2VyZWQgdmlhCj4gPiBjY3dfZGV2aWNlX2lycSgpKS4KPgo+IE5vdCBxdWl0ZSwgYWRhcHRl
ciBpbnRlcnJ1cHRzIGFyZSBkZXZpY2UtaW5kZXBlbmRlbnQsIGJ1dCB0aGV5IGFyZQo+IHJlbGV2
YW50IGZvciB2cmluZyBpbnRlcnJ1cHRzLgo+Cj4gVGhhdCB3b3VsZCBtZWFuIHRoYXQgd2Ugd291
bGQgbmVlZCB0byBzeW5jaHJvbml6ZSBfYWxsXyBjaGFubmVsIEkvTwo+IGludGVycnVwdHMsIHdo
aWNoIGxvb2tzIGxpa2UgYSBodWdlIGhhbW1lci4gQnV0IGRvIHdlIHJlYWxseSBuZWVkIHRoYXQK
PiBhdCBhbGw/CgpXZSBkb24ndCwgd2Ugb25seSBuZWVkIHRvIHN5bmNocm9uaXplIHdpdGggdGhl
IHZyaW5nIGNhbGxiYWNrcywgdG8gbWFrZSBzdXJlOgoKMSkgdGhlIG1lbW9yeSBjaGFuZ2VzIHRo
YXQgaXMgZG9uZSBiZWZvcmUgdGhpcyBvcCBpcyB2aXNpYmxlIHRvIHRoZQpjYWxsYmFja3MgdGhh
dCBjYW1lIGFmdGVyIHRoaXMgb3AKMikgdGhlIG1lbW9yeSBjaGFuZ2VzIHRoYXQgaXMgZG9uZSBh
ZnRlciB0aGlzIG9wIGlzIG5vdCB2aXNpYmxlIHRvCmNhbGxiYWNrcyB0aGF0IGNhbWUgYmVmb3Jl
IHRoaXMgb3AKCj4KPiBUaGUgbGFzdCBwYXRjaCBpbiB0aGlzIHNlcmllcyBzZWVtcyB0byBiZSBj
b25jZXJuZWQgd2l0aCB0aGUgIm5vIHZyaW5nCj4gaW50ZXJydXB0cyBpZiB0aGUgZGV2aWNlIGlz
IG5vdCByZWFkeSIgY2FzZSwgc28gaXQgbmVlZHMgdG8gc3luY2hyb25pemUKPiB2cmluZyBpbnRl
cnJ1cHRzIHdpdGggZGV2aWNlIHJlc2V0IGFuZCBzZXR0aW5nIHRoZSBkZXZpY2Ugc3RhdHVzIHRv
Cj4gcmVhZHkuIEZvciB2aXJ0aW8tY2N3LCBib3RoIHJlc2V0IGFuZCBzZXR0aW5nIHRoZSBzdGF0
dXMgYXJlIGNoYW5uZWwgSS9PCj4gb3BlcmF0aW9ucywgaS5lLiBzdGFydGluZyBhIHByb2dyYW0g
YW5kIHdhaXRpbmcgZm9yIHRoZSBmaW5hbCBkZXZpY2UKPiBpbnRlcnJ1cHQgZm9yIGl0LCBzbyBz
eW5jaHJvbml6YXRpb24gKG9uIGEgZGV2aWNlIGxldmVsKSBpcyBhbHJlYWR5Cj4gaGFwcGVuaW5n
IGluIGEgd2F5LiBTbyBJJ20gbm90IHN1cmUgaWYgYW55IGV4dHJhIHN5bmNocm9uaXphdGlvbiBp
cwo+IGFjdHVhbGx5IG5lZWRlZCBpbiB0aGlzIGNhc2UsIGJ1dCBtYXliZSBJJ20gbWlzdW5kZXJz
dGFuZGluZy4KPgo+IERvIHlvdSBoYXZlIGZ1cnRoZXIgdXNlIGNhc2VzIGluIG1pbmQ/CgpJdHMg
Z29hbCBpcyB0byBwcmV2ZW50IHRoZSBidWdneSBvciBtYWxpY3VzIGRldmljZS9ob3N0IGZyb20g
YXR0YWNraW5nCnRoZSBkcml2ZXIvZ3Vlc3QuIE9uZSB1c2UgY2FzZSBpcyB0aGUgY29uZmlkZW50
aWFsIGNvbXB1dGluZyB3aGVyZQpndWVzdCBtZW1vcnkgaXMgZW5jcnlwdGVkIGFuZCB0aGUgZ3Vl
c3QgZG9lc24ndCB0cnVzdCB0aGUgaHlwZXJ2aXNvci4KCkluIHRoYXQgY2FzZSwgdGhlIGRldmlj
ZSBjYW4gdHJ5IHRvIHJhaXNlIHRoZSBpbnRlcnJ1cHQgYWZ0ZXIKcmVxdWVzdF9pcnEgYnV0IGJl
Zm9yZSBEUklWRVJfT0ssIHdoaWNoIHRyaWVzIHRvIHRyaWdnZXIgdGhlIHZxCmNhbGxiYWNrcyB3
aGVuIHRoZSBkZXZpY2UgaXMgbm90IGZ1bGx5IGluaXRpYWxpemVkOgoKcmVxdWVzdF9pcnEoKQp2
aXJ0aW9fc3BlY2lmaWNfc2V0dXAoKSAvLyB2cSBjYWxsYmFja3MgdG8gYmUgdHJpZ2dlcmVkIGlu
IHRoZSBtaWRkbGUKdmlydGlvX2RldmljZV9yZWFkeSgpCgpUaGFua3MKCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
