Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FCEC433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 04:06:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A5F61039
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 04:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5A5F61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 787824020E;
	Tue, 12 Oct 2021 04:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dOljkRdWH1dN; Tue, 12 Oct 2021 04:06:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D2EC8401B0;
	Tue, 12 Oct 2021 04:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B30CAC000F;
	Tue, 12 Oct 2021 04:06:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C004EC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 04:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF35280EFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 04:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MKiD5ufIAFTa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 04:06:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C46D880EFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 04:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634011609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEEfo6/fO7vnWVX0k3aMZCS0u4yEik1OBiwvcb73+bY=;
 b=FPbU+P6tSKHSY4qjkj0aQ/7vc9+JDuSk/msl8vGsZLE28nKjkyNRFqSGcuv3eYFHbgnqii
 HFx3MiEwr+QGmJqjgAl0zp/BvUjJ2IpiK47PuZNTCvVGWP6itbSVQWp8PENRZc08w+RDSa
 7wC+wzqpb5/6L+RO/QUql7qvKzxb/qc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-4qCEWfWfPYS5pYK11jRJkw-1; Tue, 12 Oct 2021 00:06:35 -0400
X-MC-Unique: 4qCEWfWfPYS5pYK11jRJkw-1
Received: by mail-lf1-f72.google.com with SMTP id
 g9-20020a0565123b8900b003f33a027130so14183463lfv.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 21:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FEEfo6/fO7vnWVX0k3aMZCS0u4yEik1OBiwvcb73+bY=;
 b=yXVo1sCfVHkfEArP53DMqtHQTFqOniUhmmZbls/OlIHVHMILSIQWJiUB3n3/iNCFs6
 Z2E5aHv37poViT3e4uQTg2Tp3LOoRayXKcS6Ja9IgVa5zqM9gkMIGTuPeNWuTPQ/H78r
 Do9vrZMgQJUOgblhf5XLWiIrkX3yLEAqpqNhy7UJa2kFhp8ZcKhgmNWeA5p/xnKb222R
 Dab9jDivXq7VeU73r15YWQ9j6BSq09qmIIg3UUB6usWb476DJEjwMJUVhYAZE069oIqP
 1q404inUHibLUwK1ltL0CEfqVuGSG76WARewwWDTtOCx7I6OOpgOiEGIJNV2ENObObfC
 n85Q==
X-Gm-Message-State: AOAM530ke6B8Yvk3c3XzVwV+t4nIj5PVLqg1o2lXC5fU+VVHnxv2p/SP
 fj5VgBxn5q9xALlcTlgpa5q7CBfDRpusV9epxtxMpN0FrGzpo1Sg20+9Mk+mzmY/gqDKqvEjP1r
 igYQfogrPDgAmxR3lGgy2Mg5+aAK4iCgDduKMJRRLtz39O34zbuuDzrZptA==
X-Received: by 2002:a2e:5c8:: with SMTP id 191mr7851180ljf.107.1634011593799; 
 Mon, 11 Oct 2021 21:06:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT2mncpArnx1I4VGQ2+qfICD/ll4RDk/14xrqiwVrrF92XtuUcahJCyNw/3aVVN3pnra8I4t/Lc6MRY/KUQOA=
X-Received: by 2002:a2e:5c8:: with SMTP id 191mr7851162ljf.107.1634011593595; 
 Mon, 11 Oct 2021 21:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211001070603.307037-1-eperezma@redhat.com>
 <9f438a35-a5ff-1891-24e6-dd11d1a3bba6@redhat.com>
In-Reply-To: <9f438a35-a5ff-1891-24e6-dd11d1a3bba6@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Oct 2021 12:06:17 +0800
Message-ID: <CACGkMEvQrJKYZ_xm+f5saZwd7jkYcDOdhNQXwHPU1PvGjGCFLA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/20] vDPA shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

T24gVHVlLCBPY3QgMTIsIDIwMjEgYXQgMTE6NTkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQ
w6lyZXog5YaZ6YGTOgo+ID4gVGhpcyBzZXJpZXMgZW5hYmxlIHNoYWRvdyB2aXJ0cXVldWUgKFNW
USkgZm9yIHZob3N0LXZkcGEgZGV2aWNlcy4gVGhpcwo+ID4gaXMgaW50ZW5kZWQgYXMgYSBuZXcg
bWV0aG9kIG9mIHRyYWNraW5nIHRoZSBtZW1vcnkgdGhlIGRldmljZXMgdG91Y2gKPiA+IGR1cmlu
ZyBhIG1pZ3JhdGlvbiBwcm9jZXNzOiBJbnN0ZWFkIG9mIHJlbGF5IG9uIHZob3N0IGRldmljZSdz
IGRpcnR5Cj4gPiBsb2dnaW5nIGNhcGFiaWxpdHksIFNWUSBpbnRlcmNlcHRzIHRoZSBWUSBkYXRh
cGxhbmUgZm9yd2FyZGluZyB0aGUKPiA+IGRlc2NyaXB0b3JzIGJldHdlZW4gVk0gYW5kIGRldmlj
ZS4gVGhpcyB3YXkgcWVtdSBpcyB0aGUgZWZmZWN0aXZlCj4gPiB3cml0ZXIgb2YgZ3Vlc3RzIG1l
bW9yeSwgbGlrZSBpbiBxZW11J3MgdmlydGlvIGRldmljZSBvcGVyYXRpb24uCj4gPgo+ID4gV2hl
biBTVlEgaXMgZW5hYmxlZCBxZW11IG9mZmVycyBhIG5ldyB2cmluZyB0byB0aGUgZGV2aWNlIHRv
IHJlYWQKPiA+IGFuZCB3cml0ZSBpbnRvLCBhbmQgYWxzbyBpbnRlcmNlcHRzIGtpY2tzIGFuZCBj
YWxscyBiZXR3ZWVuIHRoZSBkZXZpY2UKPiA+IGFuZCB0aGUgZ3Vlc3QuIFVzZWQgYnVmZmVycyBy
ZWxheSB3b3VsZCBjYXVzZSBkaXJ0eSBtZW1vcnkgYmVpbmcKPiA+IHRyYWNrZWQsIGJ1dCBhdCB0
aGlzIFJGQyBTVlEgaXMgbm90IGVuYWJsZWQgb24gbWlncmF0aW9uIGF1dG9tYXRpY2FsbHkuCj4g
Pgo+ID4gSXQgaXMgYmFzZWQgb24gdGhlIGlkZWFzIG9mIERQREsgU1cgYXNzaXN0ZWQgTE0sIGlu
IHRoZSBzZXJpZXMgb2YKPiA+IERQREsncyBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9jb3Zl
ci80ODM3MC8gLiBIb3dldmVyLCB0aGVzZSBkb2VzCj4gPiBub3QgbWFwIHRoZSBzaGFkb3cgdnEg
aW4gZ3Vlc3QncyBWQSwgYnV0IGluIHFlbXUncy4KPiA+Cj4gPiBGb3IgcWVtdSB0byB1c2Ugc2hh
ZG93IHZpcnRxdWV1ZXMgdGhlIGd1ZXN0IHZpcnRpbyBkcml2ZXIgbXVzdCBub3QgdXNlCj4gPiBm
ZWF0dXJlcyBsaWtlIGV2ZW50X2lkeCBvciBpbmRpcmVjdCBkZXNjcmlwdG9ycy4gVGhlc2UgbGlt
aXRhdGlvbnMgd2lsbAo+ID4gYmUgYWRkcmVzc2VkIGluIGxhdGVyIHNlcmllcywgYnV0IHRoZXkg
YXJlIGxlZnQgb3V0IGZvciBzaW1wbGljaXR5IGF0Cj4gPiB0aGUgbW9tZW50Lgo+ID4KPiA+IFNW
USBuZWVkcyB0byBiZSBlbmFibGVkIHdpdGggUU1QIGNvbW1hbmQ6Cj4gPgo+ID4geyAiZXhlY3V0
ZSI6ICJ4LXZob3N0LWVuYWJsZS1zaGFkb3ctdnEiLAo+ID4gICAgICAgICJhcmd1bWVudHMiOiB7
ICJuYW1lIjogImRldjAiLCAiZW5hYmxlIjogdHJ1ZSB9IH0KPiA+Cj4gPiBUaGlzIHNlcmllcyBp
bmNsdWRlcyBzb21lIHBhdGNoZXMgdG8gZGVsZXRlIGluIHRoZSBmaW5hbCB2ZXJzaW9uIHRoYXQK
PiA+IGhlbHBzIHdpdGggaXRzIHRlc3RpbmcuIFRoZSBmaXJzdCB0d28gb2YgdGhlIHNlcmllcyBm
cmVlbHkgaW1wbGVtZW50cwo+ID4gdGhlIGZlYXR1cmUgdG8gc3RvcCB0aGUgZGV2aWNlIGFuZCBi
ZSBhYmxlIHRvIHJldHJpZXZlIGl0cyBzdGF0dXMuIEl0J3MKPiA+IGludGVuZGVkIHRvIGJlIHVz
ZWQgd2l0aCB2cF92cGRhIGRyaXZlciBpbiBhIG5lc3RlZCBlbnZpcm9ubWVudC4gVGhpcwo+ID4g
ZHJpdmVyIGFsc28gbmVlZCBtb2RpZmljYXRpb25zIHRvIGZvcndhcmQgdGhlIG5ldyBzdGF0dXMg
Yml0Lgo+ID4KPiA+IFBhdGNoZXMgMi04IHByZXBhcmVzIHRoZSBTVlEgYW5kIFFNUCBjb21tYW5k
IHRvIHN1cHBvcnQgZ3Vlc3QgdG8gaG9zdAo+ID4gbm90aWZpY2F0aW9ucyBmb3J3YXJkaW5nLiBJ
ZiB0aGUgU1ZRIGlzIGVuYWJsZWQgd2l0aCB0aGVzZSBvbmVzCj4gPiBhcHBsaWVkIGFuZCB0aGUg
ZGV2aWNlIHN1cHBvcnRzIGl0LCB0aGF0IHBhcnQgY2FuIGJlIHRlc3RlZCBpbgo+ID4gaXNvbGF0
aW9uIChmb3IgZXhhbXBsZSwgd2l0aCBuZXR3b3JraW5nKSwgaG9wcGluZyB0aHJvdWdoIFNWUS4K
PiA+Cj4gPiBTYW1lIHRoaW5nIGlzIHRydWUgd2l0aCBwYXRjaGVzIDktMTMsIGJ1dCB3aXRoIGRl
dmljZSB0byBndWVzdAo+ID4gbm90aWZpY2F0aW9ucy4KPiA+Cj4gPiBUaGUgcmVzdCBvZiB0aGUg
cGF0Y2hlcyBpbXBsZW1lbnRzIHRoZSBhY3R1YWwgYnVmZmVyIGZvcndhcmRpbmcuCj4gPgo+ID4g
Q29tbWVudHMgYXJlIHdlbGNvbWUuCj4KPgo+IEhpIEV1Z2VuaW86Cj4KPgo+IEl0IHdvdWxkIGJl
IGhlbHBmdWwgdG8gaGF2ZSBhIHB1YmxpYyBnaXQgcmVwbyBmb3IgdXMgdG8gZWFzZSB0aGUgcmV2
aWV3Lgo+Cj4gVGhhbmtzCj4KCkJ0dywgd2UgYWxzbyBuZWVkIHRvIG1lYXN1cmUgdGhlIHBlcmZv
cm1hbmNlIGltcGFjdCBvZiB0aGUgc2hhZG93IHZpcnRxdWV1ZS4KClRoYW5rcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
