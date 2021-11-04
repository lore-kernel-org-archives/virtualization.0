Return-Path: <SRS0=bIcn=PX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38539C433F5
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 02:31:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C0A61073
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 02:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4C0A61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F62C401E3;
	Thu,  4 Nov 2021 02:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ce2HrkAL4oFc; Thu,  4 Nov 2021 02:31:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C177E401E2;
	Thu,  4 Nov 2021 02:31:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB66C0019;
	Thu,  4 Nov 2021 02:31:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B798C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 02:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2539260804
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 02:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCC7a7SC2rJx
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 02:31:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C101607F2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 02:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635993081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcNKgPAdotlma+SzbiL53/k1dV5NpFo2xKriZncoGG8=;
 b=QoqVLYgYeNeoxo4p2bC12fSggGTu80rYATdi0maemFf5mbizQL9QDshISaDmn2PbFezM+x
 0BETtW7qIdIBIPfrwHUJc73ulpwIwMu71gIJs+iAMES2ClRPFlfE7vwSFJf/oXwEnASVfu
 bpv6CXik9ReFBjryXOU5PwOujuiOe48=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-MXYMpf43NL-QPeT1kWPN3A-1; Wed, 03 Nov 2021 22:31:18 -0400
X-MC-Unique: MXYMpf43NL-QPeT1kWPN3A-1
Received: by mail-lf1-f71.google.com with SMTP id
 x7-20020a056512130700b003fd1a7424a8so1337901lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Nov 2021 19:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NcNKgPAdotlma+SzbiL53/k1dV5NpFo2xKriZncoGG8=;
 b=GqkOH7xp2ukwTknMKQ9wRU7HjL0xNqBnm2wfm7hDkcs1m1rdvtweT/SQooQo6MIdmn
 3BXFFDNNGkktTFBU78JFY8S9krBoqo7PZgAuWYVd+50XOMykWlx1p8dMIgwRkHp2HHT+
 q8VcH5VRYw05aEXI9OowZj/vyPTrTIBIuTAdr/C4wnaYccv7GLVK7krdc616pwE6XSlu
 0WWZ53sUOrrXbcvkTpgyGB1mE30MuFOnLt3ZTERwfHEEu4ZHw+CCDZp3kUi7oYN856EO
 iMynbPRNmxQLLUKPIV7lo/YcI5e/umNctntza08l9Uj6Nk9ucqhoUL1WZf9oTNGnFZ/X
 +mvw==
X-Gm-Message-State: AOAM530eMc4CIC6GbElMYigGVYMa1ZofTgV1K8U3gJVoPXM3Yw0mK/SI
 hJ29RPt8hvQqi846v4JHCcpoqDF9to9TfNTkmBTna54zTedE+QAuRdpVJUAc3LZqbCmw0ubg6uu
 eZYCYU42tckENTgVVNPOdjz+GV5WN5vueV7eO16tyTU/kxe8xsytxhkt2qg==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr45935289lfg.498.1635993076432; 
 Wed, 03 Nov 2021 19:31:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwpEZwopt/FLpSd93uaD8FQ8BeiJJ3BLvKAmk9tr1ED8T3ahFDV7Us6tZiLiBradYvwHPdQAg8wBwYgGnbRFs=
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr45935246lfg.498.1635993076043; 
 Wed, 03 Nov 2021 19:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-12-eperezma@redhat.com>
 <74dbf70f-96a7-6fe3-dbc5-28a7b7989109@redhat.com>
 <CAJaqyWe56+wzXgdQp4nbGxhrSU4tPU+SkgTBUa=wSB5nSbtwuw@mail.gmail.com>
 <CACGkMEvOxUMo1WA4tUfDhw+FOJVW87JJGPw=U3JvUSQTU_ogWQ@mail.gmail.com>
 <CAJaqyWd4DQwRSL5StCft+3-uq12TW5x1o4DN_YW97D0JzOr2XQ@mail.gmail.com>
In-Reply-To: <CAJaqyWd4DQwRSL5StCft+3-uq12TW5x1o4DN_YW97D0JzOr2XQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Nov 2021 10:31:05 +0800
Message-ID: <CACGkMEvXBHfgx+Vy-wjgHb_SYXAe1XOxp5NZPCkU06whXBHTmw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 11/26] vhost: Handle host notifiers in SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Parav Pandit <parav@mellanox.com>
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

T24gV2VkLCBOb3YgMywgMjAyMSBhdCAzOjQwIFBNIEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVy
ZXptYUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgTm92IDMsIDIwMjEgYXQgMzo1NiBB
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUs
IE5vdiAyLCAyMDIxIGF0IDQ6NDcgUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIE5vdiAyLCAyMDIxIGF0IDg6NTUg
QU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+IOWcqCAyMDIxLzEwLzMwIOS4iuWNiDI6MzUsIEV1Z2VuaW8gUMOpcmV6IOWGmemB
kzoKPiA+ID4gPiA+IElmIGRldmljZSBzdXBwb3J0cyBob3N0IG5vdGlmaWVycywgdGhpcyBtYWtl
cyBvbmUganVtcCBsZXNzIChrZXJuZWwpIHRvCj4gPiA+ID4gPiBkZWxpdmVyIFNWUSBub3RpZmlj
YXRpb25zIHRvIGl0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8g
UMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgIGh3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggfCAgMiArKwo+ID4gPiA+ID4gICBody92
aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysr
Ky0KPiA+ID4gPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC1z
aGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4g
PiA+ID4gPiBpbmRleCAzMGFiOTY0M2I5Li5lYjBhNTRmOTU0IDEwMDY0NAo+ID4gPiA+ID4gLS0t
IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ID4gPiA+ID4gKysrIGIvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ID4gPiA+ID4gQEAgLTE4LDYgKzE4LDgg
QEAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUgVmhvc3RTaGFkb3dWaXJ0cXVl
dWU7Cj4gPiA+ID4gPiAgIHZvaWQgdmhvc3Rfc3ZxX3NldF9zdnFfa2lja19mZChWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3ZxX2tpY2tfZmQpOwo+ID4gPiA+ID4gICBjb25zdCBFdmVu
dE5vdGlmaWVyICp2aG9zdF9zdnFfZ2V0X2Rldl9raWNrX25vdGlmaWVyKAo+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVmhvc3RT
aGFkb3dWaXJ0cXVldWUgKnN2cSk7Cj4gPiA+ID4gPiArdm9pZCB2aG9zdF9zdnFfc2V0X2hvc3Rf
bXJfbm90aWZpZXIoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgdm9pZCAqYWRkcik7Cj4gPiA+
ID4gPiArCj4gPiA+ID4gPiAgIHZvaWQgdmhvc3Rfc3ZxX3N0YXJ0KHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwgdW5zaWduZWQgaWR4LAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICBWaG9z
dFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3ZxX2tpY2tfZmQpOwo+ID4gPiA+ID4gICB2b2lk
IHZob3N0X3N2cV9zdG9wKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdW5zaWduZWQgaWR4LAo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgYi9o
dy92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gPiA+ID4gPiBpbmRleCBmZGE2MGQx
MWRiLi5lM2RjYzAzOWI2IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNo
YWRvdy12aXJ0cXVldWUuYwo+ID4gPiA+ID4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12
aXJ0cXVldWUuYwo+ID4gPiA+ID4gQEAgLTI5LDYgKzI5LDEyIEBAIHR5cGVkZWYgc3RydWN0IFZo
b3N0U2hhZG93VmlydHF1ZXVlIHsKPiA+ID4gPiA+ICAgICAgICAqIFNvIHNoYWRvdyB2aXJ0cXVl
dWUgbXVzdCBub3QgY2xlYW4gaXQsIG9yIHdlIHdvdWxkIGxvc2UgVmlydFF1ZXVlIG9uZS4KPiA+
ID4gPiA+ICAgICAgICAqLwo+ID4gPiA+ID4gICAgICAgRXZlbnROb3RpZmllciBzdnFfa2ljazsK
PiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICAgLyogRGV2aWNlJ3MgaG9zdCBub3RpZmllciBtZW1v
cnkgcmVnaW9uLiBOVUxMIG1lYW5zIG5vIHJlZ2lvbiAqLwo+ID4gPiA+ID4gKyAgICB2b2lkICpo
b3N0X25vdGlmaWVyX21yOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgICAvKiBWaXJ0aW8gcXVl
dWUgc2hhZG93aW5nICovCj4gPiA+ID4gPiArICAgIFZpcnRRdWV1ZSAqdnE7Cj4gPiA+ID4gPiAg
IH0gVmhvc3RTaGFkb3dWaXJ0cXVldWU7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAvKioKPiA+ID4g
PiA+IEBAIC01MCw3ICs1NiwyMCBAQCBzdGF0aWMgdm9pZCB2aG9zdF9oYW5kbGVfZ3Vlc3Rfa2lj
ayhFdmVudE5vdGlmaWVyICpuKQo+ID4gPiA+ID4gICAgICAgICAgIHJldHVybjsKPiA+ID4gPiA+
ICAgICAgIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiAtICAgIGV2ZW50X25vdGlmaWVyX3NldCgmc3Zx
LT5oZGV2X2tpY2spOwo+ID4gPiA+ID4gKyAgICBpZiAoc3ZxLT5ob3N0X25vdGlmaWVyX21yKSB7
Cj4gPiA+ID4gPiArICAgICAgICB1aW50MTZfdCAqbXIgPSBzdnEtPmhvc3Rfbm90aWZpZXJfbXI7
Cj4gPiA+ID4gPiArICAgICAgICAqbXIgPSB2aXJ0aW9fZ2V0X3F1ZXVlX2luZGV4KHN2cS0+dnEp
Owo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBEbyB3ZSBuZWVkIGJhcnJpZXJzIGFyb3VuZCB0aGUg
cG9zc2libGUgTU1JTyBoZXJlPwo+ID4gPgo+ID4gPiBUaGF0J3MgcmlnaHQsIEkgbWlzc2VkIHRo
ZW0uCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUbyBhdm9pZCB0aG9zZSBjb21wbGljYXRlZCBzdHVm
ZiwgSSdkIHJhdGhlciBzaW1wbHkgZ28gd2l0aCBldmVudGZkIHBhdGguCj4gPiA+ID4KPiA+ID4g
PiBOb3RlIG1taW8gYW5kIGV2ZW50ZmQgYXJlIG5vdCBtdXR1YWxseSBleGNsdXNpdmUuCj4gPiA+
Cj4gPiA+IEFjdHVhbGx5IHdlIGNhbm5vdCBpZ25vcmUgdGhlbSBzaW5jZSB0aGV5IGFyZSBzZXQg
aW4gdGhlIGd1ZXN0LiBJZiBTVlEKPiA+ID4gZG9lcyBub3RoaW5nIGFib3V0IHRoZW0sIHRoZSBn
dWVzdCdzIG5vdGlmaWNhdGlvbiB3aWxsIHRyYXZlbCBkaXJlY3RseQo+ID4gPiB0byB0aGUgdmRw
YSBkZXZpY2UsIGFuZCBTVlEgY2Fubm90IGludGVyY2VwdCB0aGVtLgo+ID4gPgo+ID4gPiBUYWtp
bmcgdGhhdCBpbnRvIGFjY291bnQsIGl0J3MgYWN0dWFsbHkgbGVzcyBjaGFuZ2VzIHRvIG1vdmUg
dGhlbSB0bwo+ID4gPiBTVlEgKGxpa2UgaW4gdGhpcyBzZXJpZXMpIHRoYW4gdG8gZGlzYWJsZSB0
aGVtIChsaWtlIGluIHByZXZpb3VzCj4gPiA+IHNlcmllcykuIEJ1dCB3ZSBjYW4gZ28gd2l0aCBk
aXNhYmxpbmcgdGhlbSBmb3Igc3VyZS4KPiA+Cj4gPiBJIHRoaW5rIHdlIGNhbiBzaW1wbHkgZGlz
YWJsZSB0aGUgbWVtb3J5IHJlZ2lvbiBmb3IgdGhlIGRvb3JiZWxsLCB0aGVuCj4gPiBxZW11L2t2
bSB3aWxsIGRvIGFsbCB0aGUgcmVzdCBmb3IgdXMuCj4gPgo+ID4gSWYgd2Ugd2FudCB0byBhZGQg
YmFycmllcnMgaXQgd291bGQgYmUgYSBsb3Qgb2YgYXJjaGl0ZWN0dXJlIHNwZWNpZmljCj4gPiBp
bnN0cnVjdGlvbnMgd2hpY2ggbG9va3MgbGlrZSBhIGJ1cmRlbiBmb3IgdXMgdG8gbWFpbnRhaW4g
aW4gUWVtdS4KPiA+Cj4gPiBTbyBpZiB3ZSBkaXNhYmxlIHRoZSBtZW1vcnkgcmVnaW9uLCBLVk0g
d2lsbCBmYWxsYmFjayB0byB0aGUgZXZlbnRmZCwKPiA+IHRoZW4gcWVtdSBjYW4gaW50ZXJjZXB0
IGFuZCB3ZSBjYW4gc2ltcGx5IHJlbGF5IGl0IHZpYSBraWNrZmQuIFRoaXMKPiA+IGxvb2tzIGVh
c2llciB0byBtYWludGFpbi4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4KPiBBbnkgcmVhc29uIHRvIGdv
IG9mZi1saXN0PyA6KS4KCkhpdCB0aGUgd3JvbmcgYnV0dG9uOigKCkFkZGluZyB0aGUgbGlzdCBi
YWNrLgoKPgo+IEknbSBmaW5lIGRvaW5nIGl0IHRoYXQgd2F5LCBidXQgaXQgc2VlbXMgdG8gbWUg
dGhlcmUgbXVzdCBiZSBhIHdheQo+IHNpbmNlIFZGSU8sIFVJTywgZXRjIHdvdWxkIGhhdmUgdGhl
IHNhbWUgaXNzdWVzLiBUaGUgd29yc3QgY2FzZSB3b3VsZAo+IGJlIHRoYXQgdGhlc2UgYWNjZXNz
ZXMgYXJlIHJlc29sdmVkIHRocm91Z2ggYSBzeXNjYWxsIG9yIHNpbWlsYXIuIEhvdwo+IGRvZXMg
RFBESyBzb2x2ZSBpdD8KCkkgZ3Vlc3MgaXQgc2hvdWxkIGhhdmUgcGVyIGFyY2ggYXNzZW1ibGll
cyBldGMuCgo+IFByb2JhYmx5IHdpdGggc3BlY2lmaWMgYXNtIGFzIHlvdSBzYXkuLi4KCldlIGNh
biBnbyB0aGlzIHdheSwgYnV0IHRvIHNwZWVkIHVwIHRoZSBtZXJnaW5nLCBJJ2QgZ28gd2l0aCBl
dmVudGZkCmZpcnN0IHRvIGF2b2lkIGRlcGVuZGVuY2llcy4gQW5kIHdlIGNhbiBkbyB0aGF0IGlu
IHRoZSBmdXR1cmUgYXMgdGhlCnBlcmZvcm1hbmNlIG9wdGltaXphdGlvbi4KClRoYW5rcwoKPgo+
IFRoYW5rcyEKPgo+Cj4gPiA+Cj4gPiA+IFRoYW5rcyEKPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRo
YW5rcwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICsgICAgfSBlbHNlIHsKPiA+ID4gPiA+ICsg
ICAgICAgIGV2ZW50X25vdGlmaWVyX3NldCgmc3ZxLT5oZGV2X2tpY2spOwo+ID4gPiA+ID4gKyAg
ICB9Cj4gPiA+ID4gPiArfQo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKy8qCj4gPiA+ID4gPiArICog
U2V0IHRoZSBkZXZpY2UncyBtZW1vcnkgcmVnaW9uIG5vdGlmaWVyLiBhZGRyID0gTlVMTCBjbGVh
ciBpdC4KPiA+ID4gPiA+ICsgKi8KPiA+ID4gPiA+ICt2b2lkIHZob3N0X3N2cV9zZXRfaG9zdF9t
cl9ub3RpZmllcihWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLCB2b2lkICphZGRyKQo+ID4gPiA+
ID4gK3sKPiA+ID4gPiA+ICsgICAgc3ZxLT5ob3N0X25vdGlmaWVyX21yID0gYWRkcjsKPiA+ID4g
PiA+ICAgfQo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgLyoqCj4gPiA+ID4gPiBAQCAtMTM0LDYgKzE1
Myw3IEBAIHZvaWQgdmhvc3Rfc3ZxX3N0b3Aoc3RydWN0IHZob3N0X2RldiAqZGV2LCB1bnNpZ25l
ZCBpZHgsCj4gPiA+ID4gPiAgICAqLwo+ID4gPiA+ID4gICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAq
dmhvc3Rfc3ZxX25ldyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBpZHgpCj4gPiA+ID4gPiAg
IHsKPiA+ID4gPiA+ICsgICAgaW50IHZxX2lkeCA9IGRldi0+dnFfaW5kZXggKyBpZHg7Cj4gPiA+
ID4gPiAgICAgICBnX2F1dG9mcmVlIFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEgPSBnX25ldzAo
Vmhvc3RTaGFkb3dWaXJ0cXVldWUsIDEpOwo+ID4gPiA+ID4gICAgICAgaW50IHI7Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gQEAgLTE1MSw2ICsxNzEsNyBAQCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhv
c3Rfc3ZxX25ldyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCBpZHgpCj4gPiA+ID4gPiAgICAg
ICAgICAgZ290byBlcnJfaW5pdF9oZGV2X2NhbGw7Cj4gPiA+ID4gPiAgICAgICB9Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gKyAgICBzdnEtPnZxID0gdmlydGlvX2dldF9xdWV1ZShkZXYtPnZkZXYsIHZx
X2lkeCk7Cj4gPiA+ID4gPiAgICAgICByZXR1cm4gZ19zdGVhbF9wb2ludGVyKCZzdnEpOwo+ID4g
PiA+ID4KPiA+ID4gPiA+ICAgZXJyX2luaXRfaGRldl9jYWxsOgo+ID4gPiA+Cj4gPiA+Cj4gPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
