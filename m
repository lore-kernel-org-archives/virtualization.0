Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF10DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:38:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851F7611C3
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 851F7611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CD1B60EEA;
	Fri, 15 Oct 2021 08:38:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3FgynHDLtnpb; Fri, 15 Oct 2021 08:38:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A683E6074D;
	Fri, 15 Oct 2021 08:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70C37C000F;
	Fri, 15 Oct 2021 08:38:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AED7FC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E40F4055D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zb2yYq0THHPT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:38:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87F4240464
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634287088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoMGm9c5FcKwSYN17lQoIEstKKjchGvETfEF0J0A4m8=;
 b=f7LzziYoIqwzryLa07/t2n/qUf+f5QBFufatRm2nIRH1Z34b8b1Kl2NAjKazPxem232TaP
 aH+ozOFSYW+fEmvFNVzScyNLBs3yqfmlHoewz7aKVEMrBe43i/74I26kkuMyviTOtzU+x1
 gYMAOm32JGwoTAfVex70W95c2Khnlg0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-j_X8RUVRPZeTmgo_C148xg-1; Fri, 15 Oct 2021 04:38:05 -0400
X-MC-Unique: j_X8RUVRPZeTmgo_C148xg-1
Received: by mail-lf1-f69.google.com with SMTP id
 i6-20020a056512318600b003fd8c8c2677so6166995lfe.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OoMGm9c5FcKwSYN17lQoIEstKKjchGvETfEF0J0A4m8=;
 b=7LV7i7yOt14+/SrtZU5JecDLZx669Ttv3nOGxDxjZpRiuATdknz88QuQyBXXDzEuiT
 V4ngOOcIiWBJ4K7/3iXz/9kytyTATLz6k0Pjo+DLb7V5VU4VIPm7qLraSLFP58Ra83jw
 xy1y7ChdU0+slwp7UQoOq0djgM0iN2IgjNVdzlMU6AAYoDRWbV3OWQBIwHpLiwIiYo7O
 mrVXWb5pKav+iodoECORyXzFNirUHHEq4p3j/Hf12rI3Pbf0CqcoshucBa20uqjtytC6
 LpdZ09VS9t+xSPbdTWZ74/z+9890CvDJEFOuCXeORNl7mRYy6Gfm1gRS0ErzZewhzhMn
 lJNw==
X-Gm-Message-State: AOAM530EaKoZnp0B+x+v/irQsCFJzhuVyBNHo19RrQ1bBis2BQQlwCk5
 AhiqBb3zRCdwFXcIemj8L8C59F0bhgRmrqDwjZBokisdAdcfprUflgD3XJcUvIy7CvQUEW0Fj9O
 upcGuISxSWbSNaf0YUJQ8u8i2oekGS5gfIIBVFCZSPNKZbF/5xl2UhWt2Ug==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr11130211ljp.307.1634287083414; 
 Fri, 15 Oct 2021 01:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRfow4w3eb6iAW3KZ4R+0L4o9HRZKwsA9nATDJYkX+kEb8Mq4nu8oQT4vxwd5FF3SLe/049WnPV3etii4Wz2c=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr11130185ljp.307.1634287083167; 
 Fri, 15 Oct 2021 01:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-21-eperezma@redhat.com>
 <d5f837ec-7b89-2e47-fcfb-680ee808f6ad@redhat.com>
 <CAJaqyWdEGWFNrxqKxRya=ybRiP0wTZ0aPksBBeOe9KOjOmUnqA@mail.gmail.com>
 <CACGkMEuhseBMckdzeGf-bCtyXKEKNNyCaR0LEeELTXhKWxxmwQ@mail.gmail.com>
 <CAJaqyWf7pFiw2twq9BPyr9fOJFa9ZpSMcbnoknOfC_pbuUWkmg@mail.gmail.com>
In-Reply-To: <CAJaqyWf7pFiw2twq9BPyr9fOJFa9ZpSMcbnoknOfC_pbuUWkmg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Oct 2021 16:37:52 +0800
Message-ID: <CACGkMEv_uPeOTffNmJYa7YkhRTf2D=JCFogSJi_ot=UdVBcrYA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 20/20] vdpa: Add custom IOTLB translations to SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
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

T24gRnJpLCBPY3QgMTUsIDIwMjEgYXQgNDoyMSBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIE9jdCAxNSwgMjAyMSBhdCA5OjM3
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIEZy
aSwgT2N0IDE1LCAyMDIxIGF0IDM6MjggUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4KPiA+IDxlcGVy
ZXptYUByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gV2VkLCBPY3QgMTMsIDIwMjEg
YXQgNzozNCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4g5ZyoIDIwMjEvMTAvMSDkuIvljYgzOjA2LCBFdWdlbmlvIFDDqXJl
eiDlhpnpgZM6Cj4gPiA+ID4gPiBVc2UgdHJhbnNsYXRpb25zIGFkZGVkIGluIFZob3N0SU9WQVRy
ZWUgaW4gU1ZRLgo+ID4gPiA+ID4KPiA+ID4gPiA+IE5vdyBldmVyeSBlbGVtZW50IG5lZWRzIHRv
IHN0b3JlIHRoZSBwcmV2aW91cyBhZGRyZXNzIGFsc28sIHNvIFZpcnRRdWV1ZQo+ID4gPiA+ID4g
Y2FuIGNvbnN1bWUgdGhlIGVsZW1lbnRzIHByb3Blcmx5LiBUaGlzIGFkZHMgYSBsaXR0bGUgb3Zl
cmhlYWQgcGVyIFZRCj4gPiA+ID4gPiBlbGVtZW50LCBoYXZpbmcgdG8gYWxsb2NhdGUgbW9yZSBt
ZW1vcnkgdG8gc3Rhc2ggdGhlbS4gQXMgYSBwb3NzaWJsZQo+ID4gPiA+ID4gb3B0aW1pemF0aW9u
LCB0aGlzIGFsbG9jYXRpb24gY291bGQgYmUgYXZvaWRlZCBpZiB0aGUgZGVzY3JpcHRvciBpcyBu
b3QKPiA+ID4gPiA+IGEgY2hhaW4gYnV0IGEgc2luZ2xlIG9uZSwgYnV0IHRoaXMgaXMgbGVmdCB1
bmRvbmUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVE9ETzogaW92YSByYW5nZSBzaG91bGQgYmUgcXVl
cmllZCBiZWZvcmUsIGFuZCBhZGQgbG9naWMgdG8gZmFpbCB3aGVuCj4gPiA+ID4gPiBHUEEgaXMg
b3V0c2lkZSBvZiBpdHMgcmFuZ2UgYW5kIG1lbW9yeSBsaXN0ZW5lciBvciBzdnEgYWRkIGl0Lgo+
ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6PGVwZXJlem1h
QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ICAgaHcvdmlydGlvL3Zob3N0LXNo
YWRvdy12aXJ0cXVldWUuaCB8ICAgNCArLQo+ID4gPiA+ID4gICBody92aXJ0aW8vdmhvc3Qtc2hh
ZG93LXZpcnRxdWV1ZS5jIHwgMTMwICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gPiA+
ID4gPiAgIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgICAgICAgICAgICAgfCAgNDAgKysrKysrKyst
Cj4gPiA+ID4gPiAgIGh3L3ZpcnRpby90cmFjZS1ldmVudHMgICAgICAgICAgICAgfCAgIDEgKwo+
ID4gPiA+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDE1MiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlv
bnMoLSkKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhpbmsgaGFyZCBhYm91dCB0aGUgd2hvbGUg
bG9naWMuIFRoaXMgaXMgc2FmZSBzaW5jZSBxZW11IG1lbW9yeSBtYXAKPiA+ID4gPiB3aWxsIGZh
aWwgaWYgZ3Vlc3Qgc3VibWl0cyBhIGludmFsaWRhdGUgSU9WQS4KPiA+ID4gPgo+ID4gPgo+ID4g
PiBDYW4geW91IGV4cGFuZCBvbiB0aGlzPyBXaGF0IHlvdSBtZWFuIGlzIHRoYXQgVmlydFF1ZXVl
IGFscmVhZHkKPiA+ID4gcHJvdGVjdHMgU1ZRIGNvZGUgaWYgdGhlIGd1ZXN0IHNldHMgYW4gaW52
YWxpZCBidWZmZXIgYWRkcmVzcyAoR1BBKSwKPiA+ID4gaXNuJ3QgaXQ/Cj4gPgo+ID4gWWVzLgo+
ID4KPiA+ID4KPiA+ID4gPiBUaGVuIEkgd29uZGVyIGlmIHdlIGRvIHNvbWV0aGluZyBtdWNoIG1v
cmUgc2ltcGxlcjoKPiA+ID4gPgo+ID4gPiA+IDEpIFVzaW5nIHFlbXUgVkEgYXMgSU9WQSBidXQg
b25seSBtYXBzIHRoZSBWQSB0aGF0IGJlbG9uZ3MgdG8gZ3Vlc3QKPiA+ID4gPiAyKSBUaGVuIHdl
IGRvbid0IG5lZWQgYW55IElPVkEgdHJlZSBoZXJlLCB3aGF0IHdlIG5lZWQgaXMgdG8ganVzdCBt
YXAKPiA+ID4gPiB2cmluZyBhbmQgdXNlIHFlbXUgVkEgd2l0aG91dCBhbnkgdHJhbnNsYXRpb24K
PiA+ID4gPgo+ID4gPgo+ID4gPiBUaGF0IHdvdWxkIGJlIGdyZWF0LCBidXQgZWl0aGVyIHFlbXUn
cyBTVlEgdnJpbmcgb3IgZ3Vlc3QgdHJhbnNsYXRlZAo+ID4gPiBidWZmZXJzIGFkZHJlc3MgKGlu
IHFlbXUgVkEgZm9ybSkgd2VyZSBhbHJlYWR5IGluIGhpZ2ggYWRkcmVzc2VzLAo+ID4gPiBvdXRz
aWRlIG9mIHRoZSBkZXZpY2UncyBpb3ZhIHJhbmdlIChpbiBteSB0ZXN0KS4KPiA+Cj4gPiBZb3Un
cmUgcmlnaHQuIEkgbWlzcyB0aGF0IGFuZCB0aGF0J3Mgd2h5IHdlIG5lZWQgZS5nIGlvdmEgdHJl
ZSBhbmQgYWxsb2NhdG9yLgo+ID4KPiA+IFdoYXQgSSBwcm9wb3NlZCBvbmx5IG1ha2VzIHNlbnNl
IHdoZW4gc2hhcmVkIHZpcnR1YWwgbWVtb3J5IChTVkEpIGlzCj4gPiBpbXBsZW1lbnRlZC4gSW4g
dGhlIGNhc2Ugb2YgU1ZBLCB0aGUgdmFsaWQgaW92YSByYW5nZSBzaG91bGQgYmUgdGhlCj4gPiBm
dWxsIFZBIHJhbmdlLgo+ID4KPiA+ID4KPiA+ID4gSSBkaWRuJ3QgdHJ5IHJlbWFwcGluZyB0cmlj
a3MgdG8gbWFrZSB0aGVtIGZpdCBpbiB0aGUgcmFuZ2UsIGJ1dCBJCj4gPiA+IHRoaW5rIGl0IGRv
ZXMgY29tcGxpY2F0ZSB0aGUgc29sdXRpb24gcmVsYXRpdmVseSBmYXN0IGlmIHRoZXJlIHdhcwo+
ID4gPiBhbHJlYWR5IG1lbW9yeSBpbiB0aGF0IHJhbmdlIG93bmVkIGJ5IHFlbXUgYmVmb3JlIGVu
YWJsaW5nIFNWUToKPiA+ID4KPiA+ID4gKiBHdWVzdCBtZW1vcnkgbXVzdCBiZSBjb250aWd1b3Vz
IGluIFZBIGFkZHJlc3Mgc3BhY2UsIGJ1dCBpdCAibXVzdCIKPiA+ID4gc3VwcG9ydCBob3RwbHVn
L3VucGx1ZyAoYWx0aG91Z2ggdkRQQSBjdXJyZW50bHkgcGlucyBpdCkuIEhvdHBsdWcKPiA+ID4g
bWVtb3J5IGNvdWxkIGFsd2F5cyBvdmVybGFwIHdpdGggU1ZRIHZyaW5nLCBzbyB3ZSB3b3VsZCBu
ZWVkIHRvIG1vdmUKPiA+ID4gaXQuCj4gPiA+ICogRHVwbGljYXRpbmcgbWFwcGVkIG1lbW9yeSBm
b3Igd3JpdGluZz8gKE5vdCBzdXJlIGlmIGd1ZXN0IG1lbW9yeSBpcwo+ID4gPiBhY3R1YWxseSBt
b3ZhYmxlIGluIHFlbXUpLgo+ID4gPiAqIEluZGlyZWN0IGRlc2NyaXB0b3JzIHdpbGwgbmVlZCB0
byBhbGxvY2F0ZSBhbmQgZnJlZSBtZW1vcnkgbW9yZSBvcgo+ID4gPiBsZXNzIGZyZXF1ZW50bHks
IGluY3JlYXNpbmcgdGhlIHBvc3NpYmlsaXR5IG9mIG92ZXJsYXBwaW5nLgo+ID4KPiA+IEknbSBu
b3Qgc3VyZSBJIGdldCB0aGUgcHJvYmxlbSwgYnV0IG92ZXJsYXBwaW5nIGlzIG5vdCBhbiBpc3N1
ZSBzaW5jZQo+ID4gd2UncmUgdXNpbmcgVkEuCj4gPgo+Cj4gSXQncyBiYXNpY2FsbHkgdGhlIHNh
bWUgKHBvdGVudGlhbCkgcHJvYmxlbSBvZiBEUERLJ3MgU1ZROiBJT1ZBIFJhbmdlCj4gZ29lcyBm
cm9tIDAgdG8gWC4gVGhhdCBtZWFucyB0aGF0IGJvdGggR1BBIGFuZCBTVlEgbXVzdCBiZSBpbiBJ
T1ZBCj4gcmFuZ2UuIEFzIGFuIGV4YW1wbGUsIHdlIHB1dCBHUEEgYXQgdGhlIGJlZ2lubmluZyBv
ZiB0aGUgcmFuZ2UsIHRoYXQKPiBncm93cyB1cHdhcmRzIHdoZW4gbWVtb3J5IGlzIGhvdCBwbHVn
Z2VkLCBhbmQgU1ZRIHZyaW5ncyB0aGF0IGdyb3dzCj4gZG93bndhcmRzIHdoZW4gZGV2aWNlcyBh
cmUgYWRkZWQgb3Igc2V0IGluIFNWUSBtb2RlLgoKWWVzLCBidXQgdGhpcyBpcyBub3QgdGhlIGNh
c2UgaWYgd2UncmUgdXNpbmcgVkEuCgo+Cj4gRXZlbiB3aXRob3V0IGJvdGggc3BhY2UgZnJhZ21l
bnRhdGlvbiBwcm9ibGVtcywgd2UgY291bGQgcmVhY2ggYSBwb2ludAo+IHdoZXJlIGJvdGggd2ls
bCB0YWtlIHRoZSBzYW1lIGFkZHJlc3MsIGFuZCB3ZSB3b3VsZCBuZWVkIHRvIGdvIHRvIHRoZQo+
IHRyZWUuCj4KPiBCdXQgc2luY2Ugd2UgYXJlIGFibGUgdG8gZGV0ZWN0IHRob3NlIHNpdHVhdGlv
bnMsIEkgY2FuIHNlZSBob3cgd2UgY2FuCj4gd29yayBpbiB0d28gbW9kZXMgYXMgYW4gb3B0aW1p
emF0aW9uOiAxOjEgd2hlbiB0aGV5IGRvbid0IG92ZXJsYXAsIGFuZAo+IGZyYWdtZW50ZWQgdHJl
ZSB3aGVyZSBpdCBkb2VzLiBCdXQgSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvCj4g
aW5jbHVkZSBpdCBmcm9tIHRoZSBiZWdpbm5pbmcsIGFuZCBJJ20gbm90IHN1cmUgaWYgdGhhdCBp
cyB3b3J0aCBpdAo+IHdpdGhvdXQgbWVhc3VyaW5nIHRoZSAgdHJlZSB0cmFuc2xhdGlvbiBjb3N0
IGZpcnN0Lgo+Cj4gPiA+Cj4gPiA+IElmIHdlIGNhbiBtb3ZlIGd1ZXN0IG1lbW9yeSwKPiA+Cj4g
PiBJJ20gbm90IHN1cmUgd2UgY2FuIGRvIHRoaXMgb3IgaXQgbG9va3MgdmVyeSB0cmlja3kuCj4g
Pgo+Cj4gSnVzdCB0aGlua2luZyBvdXQgbG91ZCBoZXJlLCBidXQgbWF5YmUgd2UgY291bGQgbWFw
IGFsbCBtZW1vcnkgYW5kCj4gcGxheSB3aXRoIHJlbWFwX2ZpbGVfcGFnZXMgWzFdIGEgbGl0dGxl
IGJpdCBmb3IgdGhhdC4KClRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlcmUncyBubyBndWFyYW50ZWUg
dGhhdCBpdCB3aWxsIGFsd2F5cyBzdWNjZWVkLgpTbyBsZXQncyBzdGFydCB3aXRoIHRoZSBjdXJy
ZW50IGRlZGljYXRlZCBJT1ZBIGFkZHJlc3Mgc3BhY2UuIFdlIGNhbgpkbyBvcHRpbWl6YXRpb24g
b24gdG9wIGFueWhvdy4KCj4KPiA+ID4gaG93ZXZlciwgSSBjYW4gc2VlIGhvdyB3ZSBjYW4gdHJh
Y2sgaXQgaW4KPiA+ID4gYSB0cmVlICpidXQqIG1hcmsgd2hlbiB0aGUgdHJlZSBpcyAxOjEgd2l0
aCBxZW11J3MgVkEsIHNvIGJ1ZmZlcnMKPiA+ID4gZm9yd2FyZGluZyBkb2VzIG5vdCB0YWtlIHRo
ZSB0cmFuc2xhdGlvbiBwZW5hbHR5LiBXaGVuIGd1ZXN0IG1lbW9yeQo+ID4gPiBjYW5ub3QgYmUg
bWFwIDE6MSwgd2UgY2FuIHJlc29ydCB0byB0cmVlLCBhbmQgY29tZSBiYWNrIHRvIDE6MQo+ID4g
PiB0cmFuc2xhdGlvbiBpZiB0aGUgb2ZmZW5kaW5nIHRyZWUgbm9kZShzKSBnZXQgZGVsZXRlZC4K
PiA+ID4KPiA+ID4gSG93ZXZlciBJIHRoaW5rIHRoaXMgcHV0cyB0aGUgc29sdXRpb24gYSBsaXR0
bGUgYml0IGZhcnRoZXIgdGhhbgo+ID4gPiAic3RhcnRpbmcgc2ltcGxlIiA6KS4KPiA+ID4KPiA+
ID4gRG9lcyBpdCBtYWtlIHNlbnNlPwo+ID4KPiA+IFllcy4gU28gSSB0aGluayBJIHdpbGwgcmV2
aWV3IHRoZSBJT1ZBIHRyZWUgY29kZXMgYW5kIGdldCBiYWNrIHRvIHlvdS4KPiA+Cj4KPiBMb29r
aW5nIGZvcndhcmQgdG8gaXQgOikuCgpUaGFua3MKCj4KPiBUaGFua3MhCj4KPiBbMV0gaHR0cHM6
Ly9saW51eC5kaWUubmV0L21hbi8yL3JlbWFwX2ZpbGVfcGFnZXMKPgo+ID4gVEhhbmtzCj4gPgo+
ID4gPgo+ID4gPiBUaGFua3MhCj4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4KPiA+
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
