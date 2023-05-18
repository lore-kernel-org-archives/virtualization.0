Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2303FC7EE22
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 09:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8F948424A;
	Thu, 18 May 2023 09:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8F948424A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZ5fmr0S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMTPuniErOcU; Thu, 18 May 2023 09:43:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1682284303;
	Thu, 18 May 2023 09:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1682284303
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2475C0035;
	Thu, 18 May 2023 09:43:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76FBAC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50AD26140E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:43:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50AD26140E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZ5fmr0S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fmjBZ9JEjQ3F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:43:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBE8D60BD0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBE8D60BD0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684402990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gLODG9yLxDXLVjT7stPnmnLkvq9GWpQJE8OmPCmkGs=;
 b=ZZ5fmr0SehNimfDFo1UzJ7nbSieYw9L2G9TbYPVQUZRn6F5led2fmWPW7wC22aCBaSBdqI
 0lhlmM3f24vFEDCn5z+h3TeDPqnZRr8if6oxZEmJp6mpNHRjEOyKqx29a2tV6Ov0haE+hk
 iJqMjYEjNGoR7ySoxVA0+solnpbVSAI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-xNuvYRQzPkC6uNaqIVDJRg-1; Thu, 18 May 2023 05:43:04 -0400
X-MC-Unique: xNuvYRQzPkC6uNaqIVDJRg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so6798845e9.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 02:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684402983; x=1686994983;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gLODG9yLxDXLVjT7stPnmnLkvq9GWpQJE8OmPCmkGs=;
 b=bDsF9z75rOV0GPWFauyMvI0giWYZmq5Gefqj3qoU8CDPjN4M1bCrI+ykNXCv51uFBg
 LVoHxkuqEcm7JGW57iZXtNS7djw0gI/DoFJ8W3vgHEIEF4o3yE4zsltknghssDduwRJ3
 08DucbPygtsvwPMxsqNb6JVizNQ2enh9Ch4kvbi9dXw+V1gKATYDFrx/34enBNXg+9KA
 XxsGDVNKT6Svi56/Y6IS3ZZj78G+JUY1PAnUW+RMhWkz1+M4nrzbsxP4mUE2yinURzCW
 0AxrpSF6YltVucjKXoGk4BsGmZjBR70H+r3HnvtXtKNKu6j9hcirR76AL/QGgSXkIyjK
 mbMg==
X-Gm-Message-State: AC+VfDyr37gZv6rpBnKG50PjJUhulVbnjzXIZB8npVjnxIUfMzlpDNQy
 5VbVdXGCKCuyM6V1rhhAHxVVIkYuIznpYCJr67wEBZZN/MNquI4+7egQ7wJJGSLuU7X9ZyVUDN8
 +coOVXTvGp9v/9Sm9IRLsfG6KFmIg6VaextKHIlTrhg==
X-Received: by 2002:a1c:ed0c:0:b0:3f4:2610:5cc1 with SMTP id
 l12-20020a1ced0c000000b003f426105cc1mr1052810wmh.1.1684402983524; 
 Thu, 18 May 2023 02:43:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6m6gntd2jzkLBg09DBozwS2JgGbeBTqwCibHI6ShmLH3l0SZ8GdmMNNhDyW9vH0wO/Yyo5lg==
X-Received: by 2002:a1c:ed0c:0:b0:3f4:2610:5cc1 with SMTP id
 l12-20020a1ced0c000000b003f426105cc1mr1052792wmh.1.1684402983125; 
 Thu, 18 May 2023 02:43:03 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c204400b003f0aefcc457sm4863053wmg.45.2023.05.18.02.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:43:02 -0700 (PDT)
Date: Thu, 18 May 2023 05:42:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Message-ID: <20230518054149-mutt-send-email-mst@kernel.org>
References: <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
 <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
 <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
 <CACGkMEudGC8jbCyD6A4mCpeBomatZ88t+5WahLGAxe9vaYH6fw@mail.gmail.com>
 <20230518043114-mutt-send-email-mst@kernel.org>
 <CACGkMEvcM=M9XdFN2=tFGi-rNgfwS7SWhRagMkpLzqtS46Yn_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvcM=M9XdFN2=tFGi-rNgfwS7SWhRagMkpLzqtS46Yn_g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMDQ6NTk6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCA0OjM44oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVGh1LCBNYXkgMTgsIDIwMjMgYXQg
MDM6NTI6MTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gVGh1LCBNYXkgMTgs
IDIwMjMgYXQgMzozNOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCA3OjI04oCv
QU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gT24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMzowMOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxs
YSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9u
IFdlZCwgTWF5IDE3LCAyMDIzIGF0IDc6MjbigK9BTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9uIFdlZCwgTWF5IDE3
LCAyMDIzIGF0IDI6MjbigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gNS8xNi8yMyAxMjo0
OSBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24s
IE1heSAxNSwgMjAyMyBhdCAwMTo0MToxMlBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToK
PiA+ID4gPiA+ID4gPiA+ID4+IE9uIDUvOS8yMyAxOjQ2IEFNLCBTdGVmYW5vIEdhcnphcmVsbGEg
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gT24gTW9uLCBBcHIgMjQsIDIwMjMgYXQgMDM6NTA6
MzBQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24gdmlhCj4gPiA+ID4gPiA+ID4gPiA+Pj4gVmlydHVh
bGl6YXRpb24gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+IFVzZSB0aGUgcmlnaHQgc3RydWN0
cyBmb3IgUEFDS0VEIG9yIHNwbGl0IHZxcyB3aGVuIHNldHRpbmcgYW5kCj4gPiA+ID4gPiA+ID4g
PiA+Pj4+IGdldHRpbmcgdGhlIHZyaW5nIGJhc2UuCj4gPiA+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+
ID4gPiA+ID4gPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5l
bHNvbkBhbWQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPj4+PiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4+
Pj4gZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTggKysrKysrKysrKysrKy0tLS0tCj4gPiA+ID4g
PiA+ID4gPiA+Pj4+IGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8ICA4ICsrKysrKy0tCj4gPiA+ID4g
PiA+ID4gPiA+Pj4+IDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkKPiA+ID4gPiA+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+
ID4gPiA+ID4gPj4+PiBpbmRleCBmMTFiZGJlNGMyYzUuLmY2NGVmZGE0OGYyMSAxMDA2NDQKPiA+
ID4gPiA+ID4gPiA+ID4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+
ID4gPiA+Pj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+ID4gPiA+ID4gPj4+
PiBAQCAtMTYzMywxNyArMTYzMywyNSBAQCBsb25nIHZob3N0X3ZyaW5nX2lvY3RsKHN0cnVjdCB2
aG9zdF9kZXYKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gKmQsIHVuc2lnbmVkIGludCBpb2N0bCwgdm9p
ZCBfX3VzZXIgKmFyZwo+ID4gPiA+ID4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ciA9IC1FRkFVTFQ7Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICB9Cj4gPiA+ID4gPiA+ID4g
PiA+Pj4+IC0gICAgICAgICAgICAgIGlmIChzLm51bSA+IDB4ZmZmZikgewo+ID4gPiA+ID4gPiA+
ID4gPj4+PiAtICAgICAgICAgICAgICAgICAgICAgIHIgPSAtRUlOVkFMOwo+ID4gPiA+ID4gPiA+
ID4gPj4+PiAtICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiA+ID4gPiA+ID4gPj4+
PiArICAgICAgICAgICAgICBpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX1JJTkdf
UEFDS0VEKSkgewo+ID4gPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHZx
LT5sYXN0X2F2YWlsX2lkeCA9IHMubnVtICYgMHhmZmZmOwo+ID4gPiA+ID4gPiA+ID4gPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4ID0gKHMubnVtID4+IDE2KSAm
IDB4ZmZmZjsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgfSBlbHNlIHsKPiA+
ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICBpZiAocy5udW0gPiAweGZm
ZmYpIHsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHIgPSAtRUlOVkFMOwo+ID4gPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgfQo+ID4gPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0
X2F2YWlsX2lkeCA9IHMubnVtOwo+ID4gPiA+ID4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgIH0K
PiA+ID4gPiA+ID4gPiA+ID4+Pj4gLSAgICAgICAgICAgICAgdnEtPmxhc3RfYXZhaWxfaWR4ID0g
cy5udW07Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgLyogRm9yZ2V0IHRoZSBj
YWNoZWQgaW5kZXggdmFsdWUuICovCj4gPiA+ID4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAg
dnEtPmF2YWlsX2lkeCA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4g
ICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gICAgICAgY2FzZSBWSE9T
VF9HRVRfVlJJTkdfQkFTRToKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICBzLmlu
ZGV4ID0gaWR4Owo+ID4gPiA+ID4gPiA+ID4gPj4+PiAtICAgICAgICAgICAgICBzLm51bSA9IHZx
LT5sYXN0X2F2YWlsX2lkeDsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgaWYg
KHZob3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpCj4gPiA+ID4gPiA+
ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgcy5udW0gPSAodTMyKXZxLT5sYXN0X2F2
YWlsX2lkeCB8Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+ICgodTMyKXZxLT5sYXN0X3VzZWRfaWR4IDw8
IDE2KTsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgZWxzZQo+ID4gPiA+ID4g
PiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHMubnVtID0gdnEtPmxhc3RfYXZhaWxf
aWR4Owo+ID4gPiA+ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gVGhlIGNoYW5nZXMg
TEdUTSwgYnV0IHNpbmNlIHdlIGFyZSBjaGFuZ2luZyB0aGUgVUFQSSwgc2hvdWxkIHdlCj4gPiA+
ID4gPiA+ID4gPiA+Pj4gdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIG9mIFZIT1NUX1NFVF9WUklO
R19CQVNFIGFuZAo+ID4gPiA+ID4gPiA+ID4gPj4+IFZIT1NUX0dFVF9WUklOR19CQVNFIGluIGlu
Y2x1ZGUvdWFwaS9saW51eC92aG9zdC5oPwo+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4g
PiA+ID4+IENvcnJlY3QgbWUgaWYgSSdtIHdyb25nLCBidXQgSSBkb24ndCB0aGluayB3ZSdyZSBj
aGFuZ2luZyBhbnl0aGluZyBpbgo+ID4gPiA+ID4gPiA+ID4gPj4gdGhlIFVBUEkgaGVyZSwganVz
dCBmaXhpbmcgY29kZSB0byB3b3JrIGNvcnJlY3RseSB3aXRoIHdoYXQgaXMgYWxyZWFkeQo+ID4g
PiA+ID4gPiA+ID4gPj4gaGFwcGVuaW5nLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiBJSVVDIGJlZm9yZSB0aGlzIHBhdGNoIFZIT1NUX0dFVF9WUklOR19CQVNFIGFuZCBWSE9T
VF9TRVRfVlJJTkdfQkFTRQo+ID4gPiA+ID4gPiA+ID4gPiBuZXZlciB3b3JrZWQgd2l0aCBwYWNr
ZWQgdmlydHF1ZXVlLCBzaW5jZSB3ZSB3ZXJlIG9ubHkgaGFuZGxpbmcKPiA+ID4gPiA+ID4gPiA+
ID4gbGFzdF9hdmFpbF9pZHguIE5vdyB3ZSBhcmUgc3VwcG9ydGluZyBwYWNrZWQgdmlydHF1ZXVl
LCBoYW5kbGluZwo+ID4gPiA+ID4gPiA+ID4gPiBpbiB2aG9zdF92cmluZ19zdGF0ZS5udW0gYm90
aCBsYXN0X2F2YWlsX2lkeCBhbmQgbGFzdF91c2VkX2lkeCAod2l0aAo+ID4gPiA+ID4gPiA+ID4g
PiB3cmFwIGNvdW50ZXJzKS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gRm9y
IGV4YW1wbGUgZm9yIFZIT1NUX0dFVF9WUklOR19CQVNFIHdoZXJlIGlzIGRvY3VtZW50ZWQgdGhh
dCB0aGUgZmlyc3QKPiA+ID4gPiA+ID4gPiA+ID4gMTUgYml0cyBhcmUgbGFzdF9hdmFpbF9pZHgs
IHRoZSAxNnRoIHRoZSBhdmFpbF93cmFwX2NvdW50ZXIsIGFuZCB0aGUKPiA+ID4gPiA+ID4gPiA+
ID4gb3RoZXJzIGFyZSBsYXN0X3VzZWRfaWR4IGFuZCB1c2VkX3dyYXBfY291bnRlcj8KPiA+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gTWF5YmUgSSBtaXNzZWQgc29tZXRoaW5nLCBi
dXQgc2luY2UgdGhpcyBpcyBVQVBJLCBJTUhPIHdlIHNob3VsZAo+ID4gPiA+ID4gPiA+ID4gPiBk
b2N1bWVudCB0aGUgcGFyYW1ldGVycyBvZiBpb2N0bHMgYXQgbGVhc3QgaW4KPiA+ID4gPiA+ID4g
PiA+ID4gaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmguCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gUGVyaGFwcyBKYXNvbiBhbHJlYWR5IGhhcyBzb21ldGhpbmcgd3JpdHRlbiB1cCB0
aGF0IGNvdWxkIGJlIHB1dCBpbiBoZXJlCj4gPiA+ID4gPiA+ID4gPiBmcm9tIHdoZW4gaGUgZmly
c3QgYWRkZWQgdGhlIHdyYXBfY291bnRlciBhIGNvdXBsZSBvZiB5ZWFycyBhZ28/Cj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBJZiB5b3UgbWVhbnQgdGhlIHZpcnRpbyBkcml2ZXIgc3VwcG9y
dCBmb3IgcGFja2VkLCBJIHRoaW5rIGl0J3MKPiA+ID4gPiA+ID4gPiBkaWZmZXJlbnQgZnJvbSB0
aGUgY29udGV4dCB3aGljaCBpcyB2aG9zdCBoZXJlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gSSBhZ3JlZSB3aXRoIFN0ZWZhbm8gdGhhdCB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUgY29tbWVu
dHMgYXJvdW5kCj4gPiA+ID4gPiA+ID4gR0VUX1ZSSU5HX0JBU0UgYW5kIFNFVF9WUklOR19CQVNF
LCB0aGVuIHdlIGFyZSBmaW5lLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJJ20gdGhpbmtpbmcg
aWYgd2Ugc2hvdWxkIGFsc28gYWRkIGEgbmV3IFZIT1NUX0JBQ0tFTkRfRl9SSU5HX1BBQ0tFRAo+
ID4gPiA+ID4gPiBmZWF0dXJlIChvciBzb21ldGhpbmcgc2ltaWxhcikgdG8gaW5mb3JtIHRoZSB1
c2VyIHNwYWNlIHRoYXQgbm93IHdlCj4gPiA+ID4gPiA+IGFyZSBhYmxlIHRvIGhhbmRsZSBwYWNr
ZWQgdmlydHF1ZXVlIHRocm91Z2ggdmhvc3QgSU9DVExzLCBvdGhlcndpc2UKPiA+ID4gPiA+ID4g
aG93IGNhbiB0aGUgdXNlcnNwYWNlIGtub3cgaWYgaXQgaXMgc3VwcG9ydGVkIG9yIG5vdD8KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBJIHByb2JhYmx5IHVuZGVyc3RhbmQgdGhpcyBidXQgSSB0aGluayBp
dCBzaG91bGQgYmUgZG9uZSB2aWEKPiA+ID4gPiA+IFZIT1NUX0dFVF9GRUFFVFVSRVMuIEl0IHdv
dWxkIGJlIGEgYnVyZGVuIGlmIHdlIG1hdGlhbmluZyBkdXBsaWNhdGVkCj4gPiA+ID4gPiBmZWF0
dXJlcy4KPiA+ID4gPgo+ID4gPiA+IEdvb2QgcG9pbnQsIEkgc2VlLgo+ID4gPiA+Cj4gPiA+ID4g
SSB0aGluayB3ZSBzaG91bGQgZG8gb25lIG9mIHRoZXNlIHRoaW5ncywgdGhvdWdoOgo+ID4gPiA+
IC0gbWFzayBWSVJUSU9fRl9SSU5HX1BBQ0tFRCBpbiB0aGUgc3RhYmxlIGtlcm5lbHMgd2hlbgo+
ID4gPiA+IFZIT1NUX0dFVF9GRUFFVFVSRVMgaXMgY2FsbGVkCj4gPiA+ID4gLSBiYWNrcG9ydCB0
aGlzIHBhdGNoIG9uIGFsbCBzdGFibGUga2VybmVscyB0aGF0IHN1cHBvcnQgdmhvc3QtdmRwYQo+
ID4gPiA+Cj4gPiA+ID4gTWF5YmUgdGhlIGxhc3Qgb25lIG1ha2VzIG1vcmUgc2Vuc2UuCj4gPiA+
Cj4gPiA+IE5vdCBzdXJlLCBpdCBsb29rcyB0byBtZSB0aGUgcGFja2VkIHN1cHBvcnQgZm9yIHZE
UEEgd2FzIGZpcnN0IGFkZGVkCj4gPiA+IGJ5IEdhdXRhbS4gU28gaXQgcHJvYmFibHkgbWVhbnMg
dGhhdCBleGNlcHQgZm9yIHZwX3ZkcGEsIHdlIGRvbid0IGhhdmUKPiA+ID4gYSB2RFBBIHBhcmVu
dCB0aGF0IGNhbiBkbyB0aGUgcGFja2VkIHZpcnR1cXVlIG5vdy4gQWRkaW5nIHRoZSByZWxldmFu
dAo+ID4gPiBwZW9wbGUgaGVyZSBmb3IgbW9yZSBjb21tZW50Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+
ID4KPiA+IEJUVyBzaG91bGQgd2UgZml4IHVwIHZob3N0LmMgdG8gc3VwcG9ydCBwYWNrZWQgcmlu
Z3MgdG9vPwo+ID4gRS5nLiBzbyB3ZSBjYW4gbWlncmF0ZSB0byB2aG9zdD8KPiAKPiBCZXR0ZXIg
dG8gaGF2ZS4KPiAKPiA+IFRoZXJlJ3MgYW4gb2xkIHBhdGNoc2V0IG9mIG1pbmUgdGhhdCBzdGFy
dGVkIHdvcmsgb24gdGhpczoKPiA+Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MDA0MDcwMTE2MTIuNDc4MjI2LTEtbXN0JTQwcmVkaGF0LmNvbQo+ID4KPiA+IElzIHRoZXJlIG5l
ZWQgZm9yIHRoaXMgbm93Pwo+IAo+IElzIHRoZXJlIGFueSBiZW5jaG1hcmsgZm9yIHRoYXQ/Cj4g
Cj4gVGhhbmtzCgpJIHVzZWQgb25lIGluIHRvb2xzL3ZpcnRpbywgdGhlcmUgd2FzIG5vIHJlYWwg
Y2hhbmdlLgpNaWdodCBtYWtlIHNlbnNlIHRvIHJlbWFrZSBpdCBzaW5jZSB3ZSBmaXhlZCBzb21l
IGJ1Z3MKaW4gRVZFTlRfSURYIHN1cHBvcnQgYW5kIHRoaW5ncyBtaWdodCBoYXZlIGNoYW5nZWQu
CgoKPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4gU3RlZmFubwo+ID4gPiA+Cj4g
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
