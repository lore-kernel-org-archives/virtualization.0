Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6828FC77B7D
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 07:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF5FD42833;
	Thu, 18 May 2023 07:52:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF5FD42833
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSsK28nw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C87M94MBTwvQ; Thu, 18 May 2023 07:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C2F434282E;
	Thu, 18 May 2023 07:52:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2F434282E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 909BAC0037;
	Thu, 18 May 2023 07:52:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5761EC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1ECBF401A4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:52:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1ECBF401A4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSsK28nw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R2z9J-GmM5gz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:52:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0754440111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0754440111
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684396345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFD0sWjdXfMiZ1MLKocdVCKjbTTbF1Xcj2ymOYRMpXE=;
 b=jSsK28nwU52l4qMKnbVFM1MXvYBBlhpGUswMw6SK/DrRRx/XaB/K8Flrh1Dqu2F2u4qKwy
 jGKhkTpKJaC8of4/D5sAFLtV3L0qRY/WXUm9RtxeO8xo3xUPwlcpgObh9oRUozox4Iguz6
 ind3ynkpVd2q3frYCmv7O9GxD6niwFY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-Tga4LT6IOXSnkg_eTWvQtw-1; Thu, 18 May 2023 03:52:23 -0400
X-MC-Unique: Tga4LT6IOXSnkg_eTWvQtw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f020caac60so1207523e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684396342; x=1686988342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFD0sWjdXfMiZ1MLKocdVCKjbTTbF1Xcj2ymOYRMpXE=;
 b=ds6V6F0U/lPTObT2aNZ14bCjoxfpbAEgOvjbcExvI0J/Ad2GYREEh3J43hjyLaPG3V
 OMkRirWmA9d4fjOCvLnziIqO25fQLF4FXVbBCkwsbAAcIqczaRByuqR2h6e5W/rPs6PY
 ah2dMhmQDBrOaxSTSeB5PvPTrGnA4cvCvmAMjYmt2yPSKam6qT84z5OEtvfhjVxjHMKV
 Ao08diSW4feqSQExCTxbgYjp4YLqib6LEUAl/3lcZ9vwMJO1Potu4CTyyRdGZc3EiY0O
 Fl91tkStaeaPSHSaNeof+8eMun3l2u5JssefiJSJxXQkgaY0ze57NizQMk9ls+FurNCd
 tnJg==
X-Gm-Message-State: AC+VfDxLqrDLOjakKGqVGO2BcsTvpTR2L/AwFrjAPSpyapEvZuXtZz0O
 ttzby0cgWT4aBE88eSV8BM3631T5Gi+L/eoRm/D2yEAZpra5QUIqq75CisM6WOYir3Wpt75ZJqZ
 BCTYDLzzFM23PgVwKY5BvtkvWxfYJQ9Vaa4ZQZlNEkiZIuYKFU5eUe/++Ww==
X-Received: by 2002:ac2:560b:0:b0:4f3:a408:b6cc with SMTP id
 v11-20020ac2560b000000b004f3a408b6ccmr538366lfd.19.1684396342438; 
 Thu, 18 May 2023 00:52:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yuqgsxpGqbfjGmMR4cwa/sp08i0ensTQmDrcAkJcLVcdxCk2DyUIoWcYviSKMoWlhtP+pXc4BT3m9n8LrUSA=
X-Received: by 2002:ac2:560b:0:b0:4f3:a408:b6cc with SMTP id
 v11-20020ac2560b000000b004f3a408b6ccmr538357lfd.19.1684396342084; Thu, 18 May
 2023 00:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
 <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
 <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
In-Reply-To: <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 15:52:10 +0800
Message-ID: <CACGkMEudGC8jbCyD6A4mCpeBomatZ88t+5WahLGAxe9vaYH6fw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, drivers@pensando.io
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

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMzozNOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCA3OjI0
4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
V2VkLCBNYXkgMTcsIDIwMjMgYXQgMzowMOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnph
cmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0
IDc6MjbigK9BTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
Pgo+ID4gPiA+IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDI6MjbigK9BTSBTaGFubm9uIE5lbHNv
biA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24g
NS8xNi8yMyAxMjo0OSBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+ID4gPiBP
biBNb24sIE1heSAxNSwgMjAyMyBhdCAwMTo0MToxMlBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3
cm90ZToKPiA+ID4gPiA+ID4+IE9uIDUvOS8yMyAxOjQ2IEFNLCBTdGVmYW5vIEdhcnphcmVsbGEg
d3JvdGU6Cj4gPiA+ID4gPiA+Pj4gT24gTW9uLCBBcHIgMjQsIDIwMjMgYXQgMDM6NTA6MzBQTSAt
MDcwMCwgU2hhbm5vbiBOZWxzb24gdmlhCj4gPiA+ID4gPiA+Pj4gVmlydHVhbGl6YXRpb24gd3Jv
dGU6Cj4gPiA+ID4gPiA+Pj4+IFVzZSB0aGUgcmlnaHQgc3RydWN0cyBmb3IgUEFDS0VEIG9yIHNw
bGl0IHZxcyB3aGVuIHNldHRpbmcgYW5kCj4gPiA+ID4gPiA+Pj4+IGdldHRpbmcgdGhlIHZyaW5n
IGJhc2UuCj4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYW5u
b24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4gPiA+ID4gPj4+PiAtLS0KPiA+
ID4gPiA+ID4+Pj4gZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTggKysrKysrKysrKysrKy0tLS0t
Cj4gPiA+ID4gPiA+Pj4+IGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8ICA4ICsrKysrKy0tCj4gPiA+
ID4gPiA+Pj4+IDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkKPiA+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhv
c3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+ID4gPj4+PiBpbmRleCBm
MTFiZGJlNGMyYzUuLmY2NGVmZGE0OGYyMSAxMDA2NDQKPiA+ID4gPiA+ID4+Pj4gLS0tIGEvZHJp
dmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+Pj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYwo+ID4gPiA+ID4gPj4+PiBAQCAtMTYzMywxNyArMTYzMywyNSBAQCBsb25nIHZob3N0X3Zy
aW5nX2lvY3RsKHN0cnVjdCB2aG9zdF9kZXYKPiA+ID4gPiA+ID4+Pj4gKmQsIHVuc2lnbmVkIGlu
dCBpb2N0bCwgdm9pZCBfX3VzZXIgKmFyZwo+ID4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgciA9IC1FRkFVTFQ7Cj4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsKPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICB9Cj4gPiA+ID4gPiA+Pj4+IC0gICAg
ICAgICAgICAgIGlmIChzLm51bSA+IDB4ZmZmZikgewo+ID4gPiA+ID4gPj4+PiAtICAgICAgICAg
ICAgICAgICAgICAgIHIgPSAtRUlOVkFMOwo+ID4gPiA+ID4gPj4+PiAtICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOwo+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICBpZiAodmhvc3RfaGFz
X2ZlYXR1cmUodnEsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkgewo+ID4gPiA+ID4gPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMubnVtICYgMHhmZmZmOwo+
ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4ID0g
KHMubnVtID4+IDE2KSAmIDB4ZmZmZjsKPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgfSBl
bHNlIHsKPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICBpZiAocy5udW0gPiAw
eGZmZmYpIHsKPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHIg
PSAtRUlOVkFMOwo+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7Cj4gPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgfQo+ID4gPiA+ID4g
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMubnVtOwo+
ID4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgIH0KPiA+ID4gPiA+ID4+Pj4gLSAgICAgICAgICAg
ICAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW07Cj4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAg
ICAgLyogRm9yZ2V0IHRoZSBjYWNoZWQgaW5kZXggdmFsdWUuICovCj4gPiA+ID4gPiA+Pj4+ICAg
ICAgICAgICAgICAgdnEtPmF2YWlsX2lkeCA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiA+ID4gPiA+
ID4+Pj4gICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPiA+ID4+Pj4gICAgICAgY2FzZSBWSE9T
VF9HRVRfVlJJTkdfQkFTRToKPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICBzLmluZGV4ID0g
aWR4Owo+ID4gPiA+ID4gPj4+PiAtICAgICAgICAgICAgICBzLm51bSA9IHZxLT5sYXN0X2F2YWls
X2lkeDsKPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgaWYgKHZob3N0X2hhc19mZWF0dXJl
KHZxLCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpCj4gPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgcy5udW0gPSAodTMyKXZxLT5sYXN0X2F2YWlsX2lkeCB8Cj4gPiA+ID4gPiA+Pj4+
ICgodTMyKXZxLT5sYXN0X3VzZWRfaWR4IDw8IDE2KTsKPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAg
ICAgICAgZWxzZQo+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHMubnVtID0g
dnEtPmxhc3RfYXZhaWxfaWR4Owo+ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+Pj4gVGhlIGNoYW5n
ZXMgTEdUTSwgYnV0IHNpbmNlIHdlIGFyZSBjaGFuZ2luZyB0aGUgVUFQSSwgc2hvdWxkIHdlCj4g
PiA+ID4gPiA+Pj4gdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIG9mIFZIT1NUX1NFVF9WUklOR19C
QVNFIGFuZAo+ID4gPiA+ID4gPj4+IFZIT1NUX0dFVF9WUklOR19CQVNFIGluIGluY2x1ZGUvdWFw
aS9saW51eC92aG9zdC5oPwo+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4+IENvcnJlY3QgbWUgaWYg
SSdtIHdyb25nLCBidXQgSSBkb24ndCB0aGluayB3ZSdyZSBjaGFuZ2luZyBhbnl0aGluZyBpbgo+
ID4gPiA+ID4gPj4gdGhlIFVBUEkgaGVyZSwganVzdCBmaXhpbmcgY29kZSB0byB3b3JrIGNvcnJl
Y3RseSB3aXRoIHdoYXQgaXMgYWxyZWFkeQo+ID4gPiA+ID4gPj4gaGFwcGVuaW5nLgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBJSVVDIGJlZm9yZSB0aGlzIHBhdGNoIFZIT1NUX0dFVF9WUklOR19C
QVNFIGFuZCBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+ID4gPiA+ID4gPiBuZXZlciB3b3JrZWQgd2l0
aCBwYWNrZWQgdmlydHF1ZXVlLCBzaW5jZSB3ZSB3ZXJlIG9ubHkgaGFuZGxpbmcKPiA+ID4gPiA+
ID4gbGFzdF9hdmFpbF9pZHguIE5vdyB3ZSBhcmUgc3VwcG9ydGluZyBwYWNrZWQgdmlydHF1ZXVl
LCBoYW5kbGluZwo+ID4gPiA+ID4gPiBpbiB2aG9zdF92cmluZ19zdGF0ZS5udW0gYm90aCBsYXN0
X2F2YWlsX2lkeCBhbmQgbGFzdF91c2VkX2lkeCAod2l0aAo+ID4gPiA+ID4gPiB3cmFwIGNvdW50
ZXJzKS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gRm9yIGV4YW1wbGUgZm9yIFZIT1NUX0dFVF9W
UklOR19CQVNFIHdoZXJlIGlzIGRvY3VtZW50ZWQgdGhhdCB0aGUgZmlyc3QKPiA+ID4gPiA+ID4g
MTUgYml0cyBhcmUgbGFzdF9hdmFpbF9pZHgsIHRoZSAxNnRoIHRoZSBhdmFpbF93cmFwX2NvdW50
ZXIsIGFuZCB0aGUKPiA+ID4gPiA+ID4gb3RoZXJzIGFyZSBsYXN0X3VzZWRfaWR4IGFuZCB1c2Vk
X3dyYXBfY291bnRlcj8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gTWF5YmUgSSBtaXNzZWQgc29t
ZXRoaW5nLCBidXQgc2luY2UgdGhpcyBpcyBVQVBJLCBJTUhPIHdlIHNob3VsZAo+ID4gPiA+ID4g
PiBkb2N1bWVudCB0aGUgcGFyYW1ldGVycyBvZiBpb2N0bHMgYXQgbGVhc3QgaW4KPiA+ID4gPiA+
ID4gaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmguCj4gPiA+ID4gPgo+ID4gPiA+ID4gUGVyaGFw
cyBKYXNvbiBhbHJlYWR5IGhhcyBzb21ldGhpbmcgd3JpdHRlbiB1cCB0aGF0IGNvdWxkIGJlIHB1
dCBpbiBoZXJlCj4gPiA+ID4gPiBmcm9tIHdoZW4gaGUgZmlyc3QgYWRkZWQgdGhlIHdyYXBfY291
bnRlciBhIGNvdXBsZSBvZiB5ZWFycyBhZ28/Cj4gPiA+ID4KPiA+ID4gPiBJZiB5b3UgbWVhbnQg
dGhlIHZpcnRpbyBkcml2ZXIgc3VwcG9ydCBmb3IgcGFja2VkLCBJIHRoaW5rIGl0J3MKPiA+ID4g
PiBkaWZmZXJlbnQgZnJvbSB0aGUgY29udGV4dCB3aGljaCBpcyB2aG9zdCBoZXJlLgo+ID4gPiA+
Cj4gPiA+ID4gSSBhZ3JlZSB3aXRoIFN0ZWZhbm8gdGhhdCB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUg
Y29tbWVudHMgYXJvdW5kCj4gPiA+ID4gR0VUX1ZSSU5HX0JBU0UgYW5kIFNFVF9WUklOR19CQVNF
LCB0aGVuIHdlIGFyZSBmaW5lLgo+ID4gPgo+ID4gPiBJJ20gdGhpbmtpbmcgaWYgd2Ugc2hvdWxk
IGFsc28gYWRkIGEgbmV3IFZIT1NUX0JBQ0tFTkRfRl9SSU5HX1BBQ0tFRAo+ID4gPiBmZWF0dXJl
IChvciBzb21ldGhpbmcgc2ltaWxhcikgdG8gaW5mb3JtIHRoZSB1c2VyIHNwYWNlIHRoYXQgbm93
IHdlCj4gPiA+IGFyZSBhYmxlIHRvIGhhbmRsZSBwYWNrZWQgdmlydHF1ZXVlIHRocm91Z2ggdmhv
c3QgSU9DVExzLCBvdGhlcndpc2UKPiA+ID4gaG93IGNhbiB0aGUgdXNlcnNwYWNlIGtub3cgaWYg
aXQgaXMgc3VwcG9ydGVkIG9yIG5vdD8KPiA+Cj4gPiBJIHByb2JhYmx5IHVuZGVyc3RhbmQgdGhp
cyBidXQgSSB0aGluayBpdCBzaG91bGQgYmUgZG9uZSB2aWEKPiA+IFZIT1NUX0dFVF9GRUFFVFVS
RVMuIEl0IHdvdWxkIGJlIGEgYnVyZGVuIGlmIHdlIG1hdGlhbmluZyBkdXBsaWNhdGVkCj4gPiBm
ZWF0dXJlcy4KPgo+IEdvb2QgcG9pbnQsIEkgc2VlLgo+Cj4gSSB0aGluayB3ZSBzaG91bGQgZG8g
b25lIG9mIHRoZXNlIHRoaW5ncywgdGhvdWdoOgo+IC0gbWFzayBWSVJUSU9fRl9SSU5HX1BBQ0tF
RCBpbiB0aGUgc3RhYmxlIGtlcm5lbHMgd2hlbgo+IFZIT1NUX0dFVF9GRUFFVFVSRVMgaXMgY2Fs
bGVkCj4gLSBiYWNrcG9ydCB0aGlzIHBhdGNoIG9uIGFsbCBzdGFibGUga2VybmVscyB0aGF0IHN1
cHBvcnQgdmhvc3QtdmRwYQo+Cj4gTWF5YmUgdGhlIGxhc3Qgb25lIG1ha2VzIG1vcmUgc2Vuc2Uu
CgpOb3Qgc3VyZSwgaXQgbG9va3MgdG8gbWUgdGhlIHBhY2tlZCBzdXBwb3J0IGZvciB2RFBBIHdh
cyBmaXJzdCBhZGRlZApieSBHYXV0YW0uIFNvIGl0IHByb2JhYmx5IG1lYW5zIHRoYXQgZXhjZXB0
IGZvciB2cF92ZHBhLCB3ZSBkb24ndCBoYXZlCmEgdkRQQSBwYXJlbnQgdGhhdCBjYW4gZG8gdGhl
IHBhY2tlZCB2aXJ0dXF1ZSBub3cuIEFkZGluZyB0aGUgcmVsZXZhbnQKcGVvcGxlIGhlcmUgZm9y
IG1vcmUgY29tbWVudAoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
