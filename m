Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BBFC433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 02:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D09883EA5;
	Thu, 14 Jul 2022 02:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D09883EA5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iYeZK/hJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xah2vRt4sCa4; Thu, 14 Jul 2022 02:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1C2C83E72;
	Thu, 14 Jul 2022 02:27:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1C2C83E72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0F04C0035;
	Thu, 14 Jul 2022 02:27:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70C3AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B0AD405C2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B0AD405C2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iYeZK/hJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AaO0K4H9Fdv0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:27:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47AC6400CE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47AC6400CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657765660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKqtVQoelkyekmm3n/TzJpiFYoNhlddM3fmt1VyGkDE=;
 b=iYeZK/hJkOKCKhzgw11T3Vlakfw0Bu7u8tLYjE/021jhhaImm263pVn0D9TehaAAKn9AUQ
 +gaKaaEAxyQrfinVBhhcAuh2u9O0FOL6npXC6mO63JNCKI4A+HKqSHHG+g4NyUcl5I+lY8
 FXU9/Fg+COE0a1cwQPIR2u7ow6vdhbA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-XRun8URfMvyY1ocChwjHKg-1; Wed, 13 Jul 2022 22:27:36 -0400
X-MC-Unique: XRun8URfMvyY1ocChwjHKg-1
Received: by mail-lf1-f72.google.com with SMTP id
 h37-20020a0565123ca500b004889ff5f804so175779lfv.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 19:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DKqtVQoelkyekmm3n/TzJpiFYoNhlddM3fmt1VyGkDE=;
 b=zFdg7/wjIo4fwwKOrYj3AvQ0VMV19zRD8fh6KLl5HlYO15ahuoVr6S63Lfs/rqQGDd
 BzSYXZXPxZDTtrFa6P/ijilcVbCSz1xIHV2qr2dxFEoX0U0rrbfQXzulWpL4m4TyJ/Hz
 U4KnYBsKeZjElf4D0zSuSyAjrQw1ALvGAlyLYS+nzZkCYQ0yOwHjLrhbsl0Qpu0oxooH
 kDR7kzpf6X6KJA0Hyi1iE6tZldTF6uX9FXpFVOlvMob45Mq7RD95TnRKwjYvrHHzLT99
 Wghuh9uGC2OVeCNhtNlRIvvb7Ib5fms4CTgT5YfKiRt+CjGAbcW2vZy6bmtek4NsiXJQ
 PMWg==
X-Gm-Message-State: AJIora8uwUKKvIdOIPwaQk+ZMeZOdiS/YnVGz6OdNsBoBxJMjopdzNDv
 NfISHohdZtZMLB2z32VLLCIkoRxqmKFfEJXtpFHHYLOKmZVnUnMLQ5fW+OgZbYAjrMzjWPdXUqD
 77WWvEuDT22T96trcg3xPcivrinhSIHNqJVY1H0l0/fofY0Yfa69DD99OnQ==
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr3925202lfd.397.1657765655205; 
 Wed, 13 Jul 2022 19:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sm+WAiUx+ESlDemm3AD5k1QLfG2dAptqNFigTGtYGMDx63OJNqx3GB1rUNc0SY46t+RFz+/8OEIy5PHUQQUvA=
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr3925190lfd.397.1657765655011; Wed, 13
 Jul 2022 19:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-2-xieyongji@bytedance.com>
 <1106133f-ebd4-f6a8-83ab-19e995bcdba6@redhat.com>
 <CACycT3sNt_PcPQ__KVSqV6xd=+z5+gbMqWhu6H3vcj_fTGzUsw@mail.gmail.com>
In-Reply-To: <CACycT3sNt_PcPQ__KVSqV6xd=+z5+gbMqWhu6H3vcj_fTGzUsw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Jul 2022 10:27:23 +0800
Message-ID: <CACGkMEsOXyewVZ76Cc4BoZv1vhXbT1t8tm-9GqV9CJ70bF-xwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
To: Yongji Xie <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

T24gV2VkLCBKdWwgMTMsIDIwMjIgYXQgNzowOSBQTSBZb25namkgWGllIDx4aWV5b25namlAYnl0
ZWRhbmNlLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAxMywgMjAyMiBhdCAxOjQ0IFBNIEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDlnKggMjAy
Mi83LzYgMTM6MDQsIFhpZSBZb25namkg5YaZ6YGTOgo+ID4gPiBUYWtpbmcgaW90bGIgbG9jayB0
byBhY2Nlc3MgYm91bmNlIHBhZ2UgaW4gcGFnZSBmYXVsdAo+ID4gPiBoYW5kbGVyIGlzIG1lYW5p
bmdsZXNzIHNpbmNlIHZkdXNlX2RvbWFpbl9mcmVlX2JvdW5jZV9wYWdlcygpCj4gPiA+IHdvdWxk
IG9ubHkgYmUgY2FsbGVkIGR1cmluZyBmaWxlIHJlbGVhc2UuCj4gPiA+Cj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+ID4gPiAtLS0KPiA+
ID4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmMgfCA3ICsrLS0tLS0KPiA+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+ID4g
Pgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5j
IGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5jCj4gPiA+IGluZGV4IDZkYWEz
OTc4ZDI5MC4uYmNhMWYwYjg4NTBjIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL2lvdmFfZG9tYWluLmMKPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9p
b3ZhX2RvbWFpbi5jCj4gPiA+IEBAIC0yMTEsMTcgKzIxMSwxNCBAQCBzdGF0aWMgc3RydWN0IHBh
Z2UgKgo+ID4gPiAgIHZkdXNlX2RvbWFpbl9nZXRfYm91bmNlX3BhZ2Uoc3RydWN0IHZkdXNlX2lv
dmFfZG9tYWluICpkb21haW4sIHU2NCBpb3ZhKQo+ID4gPiAgIHsKPiA+ID4gICAgICAgc3RydWN0
IHZkdXNlX2JvdW5jZV9tYXAgKm1hcDsKPiA+ID4gLSAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBO
VUxMOwo+ID4gPiArICAgICBzdHJ1Y3QgcGFnZSAqcGFnZTsKPiA+ID4KPiA+ID4gLSAgICAgc3Bp
bl9sb2NrKCZkb21haW4tPmlvdGxiX2xvY2spOwo+ID4gPiAgICAgICBtYXAgPSAmZG9tYWluLT5i
b3VuY2VfbWFwc1tpb3ZhID4+IFBBR0VfU0hJRlRdOwo+ID4gPiAgICAgICBpZiAoIW1hcC0+Ym91
bmNlX3BhZ2UpCj4gPiA+IC0gICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7Cj4gPgo+ID4KPiA+IEludGVyZXN0aW5nLCBJIHdvbmRlciB3aHkgd2Ug
ZG9uJ3Qgc2VyaWFsaXplIHdpdGgKPiA+IHZkdXNlX2RvbWFpbl9tYXBfYm91bmNlX3BhZ2UoKSB3
aXRoIGlvdGxiX2xvY2s/Cj4gPgo+Cj4gVXNlcnNwYWNlIHNob3VsZCBvbmx5IGFjY2VzcyB0aGUg
Ym91bmNlIHBhZ2UgYWZ0ZXIgd2Ugc2V0IHVwIHRoZSBkbWEKPiBtYXBwaW5nLCBzbyB3ZSBkb24n
dCBuZWVkIHNlcmlhbGl6YXRpb24gZnJvbSB0aGUgaW90bGJfbG9jayBpbiB0aGlzCj4gY2FzZS4K
CldoYXQgYWJvdXQgdGhlIGJ1Z2d5L21hbGljaW91cyB1c2VyIHNwYWNlIHRoYXQgdHJpZXMgdG8g
YWNjZXNzIHRob3NlCnBhZ2VzIGJlZm9yZSBvciBqdXN0IGluIHRoZSBtaWRkbGUgb2YgaXQgaGFz
IGJlZW4gbWFwcGVkPwoKPiBBbmQgdmR1c2VfZG9tYWluX21hcF9ib3VuY2VfcGFnZSgpIG9ubHkg
c2V0cyB0aGUKPiBtYXAtPmJvdW5jZV9wYWdlIHJhdGhlciB0aGFuIGNsZWFycyB0aGUgbWFwLT5i
b3VuY2VfcGFnZSwgd2Ugd291bGQgbm90Cj4gaGF2ZSBhbnkgcHJvYmxlbSB3aXRob3V0IHRoZSBs
b2NrIHByb3RlY3Rpb24uCgpQcm9iYWJseSwgSSBzZWUgYW4gYXNzaWdubWVudCBvZiBvcmlnX3Bo
eXMgYWZ0ZXIgdGhlIGFsbG9jX3BhZ2UoKSBidXQKaXQgc2VlbXMgb25seSB1c2VkIGluIGJvdW5j
aW5nIHdoaWNoIHdpbGwgb25seSBiZSBjYWxsZWQgYnkgZG1hIG9wcy4KQXQgbGVhc3Qgd2UnZCBi
ZXR0ZXIgaGF2ZSBhIGNvbW1lbnQgdG8gZXhwbGFpbiB0aGUgc3luY2hyb25pemF0aW9uCmhlcmUu
CgpUaGFua3MKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
