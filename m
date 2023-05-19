Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BECC77B7D
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 02:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58F3642BF8;
	Fri, 19 May 2023 02:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58F3642BF8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cv7iYu6S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZCwrHjkKnwF2; Fri, 19 May 2023 02:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CBC6E40223;
	Fri, 19 May 2023 02:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBC6E40223
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3742C0035;
	Fri, 19 May 2023 02:02:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33F99C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 02:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 077E042961
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 02:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 077E042961
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cv7iYu6S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6ZxnqmnAb_i
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 02:02:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B41F442960
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B41F442960
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684461730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LxIDwxX5oZ/H5qgJAleyIOOnzzqbniVCDVAXDLMI3E=;
 b=Cv7iYu6SVyp9e5//Tgd4aAWT1hqw+IfHCcSqqw30L1fcaGxRbYxbdPlBV+uaXR28RLVXTT
 CG+a1IE5qIK0javueS90sH0Qk8YEY0GTLkn/nDCLnrQ7QvU6NwIF0KtKKNzPZYqmvskXMr
 9pjT19ftr4Sj4nlmuqcqE+58n/kvI7U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-TuewDrCkMmyhe5uTnZuA9Q-1; Thu, 18 May 2023 22:02:09 -0400
X-MC-Unique: TuewDrCkMmyhe5uTnZuA9Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f3a7765189so749139e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 19:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684461727; x=1687053727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LxIDwxX5oZ/H5qgJAleyIOOnzzqbniVCDVAXDLMI3E=;
 b=DwBKJfFYUMlvEdgBsSuBa/x/VZolbk0T9b/63PDJESQd5FTOF2IiR/PCf8WN6e/U0z
 NIJ4CVqTcCKSZyTawi8XgVgfB9UdDnXK166/GYa0yqRitaqKYW6IBZ2lRDQum8/vXz8F
 6wwZQQxAEt8cA+sKkqx9+GXNTORa1Xz5vcxdkho9uXxLCEPT/1vypFfA0OycOJUYb2Kk
 tPuxpqrv7Q5SHTi3zGLOx04O1vOyCRT+q+V9xiq6Wd4klZvtjlx+028tU/5Sd8GTG4vh
 UKYJSKGxD92UMJ8U43JW46b1ca/S3AIAJJkhfiGLwHDF/pDfzQNokbctvsC0eqYeVXvR
 rZOg==
X-Gm-Message-State: AC+VfDwZ1HP95OSvpUfuVIVOt1PJcjU3xUsT8wQTVfePrN/yxtCfj9HX
 GJn74zWbi39UX75Z1/9OKC1XJESjr2zEAuuXI2NLAtD5VsGw8jrRWr0PuUEytfjCrw45olVV5zK
 nOncGLsLmMDsUwP5taJrJTJevL9iIUnEzea74tcgCwfNQAO0ia9J7KXOGBA==
X-Received: by 2002:ac2:5612:0:b0:4ed:c7cc:6f12 with SMTP id
 v18-20020ac25612000000b004edc7cc6f12mr210049lfd.34.1684461727673; 
 Thu, 18 May 2023 19:02:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6whPVX/g3XA9o+83szsoUPp5+C2dXI1+p+PRYV3K9auvebjDWKokwY1L4+4bJUpr/8bEe0yh4W3U++26R9dqQ=
X-Received: by 2002:ac2:5612:0:b0:4ed:c7cc:6f12 with SMTP id
 v18-20020ac25612000000b004edc7cc6f12mr210035lfd.34.1684461727327; Thu, 18 May
 2023 19:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp>
 <20230427104428.862643-4-mie@igel.co.jp>
 <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
 <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com>
 <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
In-Reply-To: <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 May 2023 10:01:56 +0800
Message-ID: <CACGkMEvdVHQEcDD74TpeWgmHQ+J9aMpv5ui=iwT8E_SDZoY7EA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
To: Shunsuke Mie <mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ren Zhijie <renzhijie2@huawei.com>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgNTo1NOKAr1BNIFNodW5zdWtlIE1pZSA8bWllQGlnZWwu
Y28uanA+IHdyb3RlOgo+Cj4gR2VudGxlIHBpbmcgLi4uCj4KPgo+IFRoYW5rcywKPgo+IFNodW5z
dWtlLgo+Cj4gT24gMjAyMy8wNS8xMCAxMjoxNywgU2h1bnN1a2UgTWllIHdyb3RlOgo+ID4gSGkg
SnNvbiwKPiA+IDIwMjPlubQ15pyIOOaXpSjmnIgpIDEzOjAzIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+Ogo+ID4+IE9uIFRodSwgQXByIDI3LCAyMDIzIGF0IDY6NDTigK9QTSBTaHVu
c3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPiB3cm90ZToKPiA+Pj4gQWRkIGEgbmV3IFBDSWUgZW5k
cG9pbnQgZnVuY3Rpb24gZHJpdmVyIHRoYXQgd29ya3MgYXMgYSBwY2kgdmlydGlvLWNvbnNvbGUK
PiA+Pj4gZGV2aWNlLiBUaGUgY29uc29sZSBjb25uZWN0IHRvIGVuZHBvaW50IHNpZGUgY29uc29s
ZS4gSXQgZW5hYmxlcyB0bwo+ID4+PiBjb21tdW5pY2F0ZSBQQ0llIGhvc3QgYW5kIGVuZHBvaW50
Lgo+ID4+Pgo+ID4+PiBBcmNoaXRlY3R1cmUgaXMgZm9sbG93aW5nOgo+ID4+Pgo+ID4+PiAgIOKU
jOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgICAgIOKUjOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUrOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkAo+ID4+PiAgIOKU
gnZpcnRpb2UgICAgIOKUgiAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilIJ2aXJ0
aW8gICAgICDilIIKPiA+Pj4gICDilIJjb25zb2xlIGRydiDilIIgICAgICAgICDilJzilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJAgICAgICDilIJjb25zb2xl
IGRydiDilIIKPiA+Pj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lKQgICAgICAgICDilIIodmlydGlvIGNvbnNvbGXilIIgICAgICDilJzilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilKQKPiA+Pj4gICDilIIgdmlydGlvIGJ1cyDilIIgICAgICAg
ICDilIIgZGV2aWNlKSAgICAgICDilILil4TilIDilIDilIDilIDilrrilIIgdmlydGlvIGJ1cyDi
lIIKPiA+Pj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAg
ICAgICDilJwtLS0tLS0tLS0tLS0tLS3ilKQgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilKQKPiA+Pj4gICDilIIgICAgICAgICAgICDilIIgICAgICAgICDilIIg
cGNpIGVwIHZpcnRpbyDilIIgICAgICAgICAgICAgICAgICAg4pSCCj4gPj4+ICAg4pSCICBwY2kg
YnVzICAg4pSCICAgICAgICAg4pSCICBjb25zb2xlIGRydiAg4pSCICAgICAgICAgICAgICAgICAg
IOKUggo+ID4+PiAgIOKUgiAgICAgICAgICAgIOKUgiAgcGNpZSAgIOKUnOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgICAgICAgICAgICDilIIK
PiA+Pj4gICDilIIgICAgICAgICAgICDilIIg4peE4pSA4pSA4pSA4pSA4pSA4pa6IOKUgiAgcGNp
IGVwIEJ1cyAgIOKUgiAgICAgICAgICAgICAgICAgICDilIIKPiA+Pj4gICDilJTilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilJggICAgICAgICDilJTilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLTilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgKPiA+Pj4gICAgIFBDSWUgUm9vdCAg
ICAgICAgICAgICAgUENJZSBFbmRwb2ludAo+ID4+Pgo+ID4+IEkgdGhpbmsgaXQgbWlnaHQgb25s
eSB3b3JrcyBmb3IgcGVlciBkZXZpY2VzIGxpa2U6Cj4gPj4KPiA+PiBuZXQsIGNvbnNvbGUgb3Ig
dnNvY2suCj4gPiBDb3VsZCB5b3UgdGVsbCBtZSB3aGF0ICJwZWVyIGRldmljZXMiIG1lYW5zPwoK
SSBtZWFudCwgZm9yIGV4YW1wbGUgd2Uga25vdyBpbiB0aGUgY2FzZSBvZiB2aXJ0aW8tbmV0LCBU
WCBjYW4gdGFsawp3aXRoIFJYIGJlbG9uZ2luZyB0byBhbm90aGVyIGRldmljZSBkaXJlY3RseS4K
CkJ1dCB0aGlzIGlzIG5vdCB0aGUgY2FzZSBmb3Igb3RoZXIgZGV2aWNlcyBsaWtlIHZpcml0by1i
bGsuCgo+ID4KPiA+PiBTbyB0aGVyZSdyZSBtYW55IGNob2ljZXMgaGVyZSwgSSdkIGxpa2UgdG8g
a25vdyB3aGF0J3MgdGhlIHJlYXNvbiBmb3IKPiA+PiB5b3UgdG8gaW1wbGVtZW50IGEgbWVkaWF0
aW9uLgo+ID4+Cj4gPj4gQW4gYWx0ZXJuYXRpdmUgaXMgdG8gaW1wbGVtZW50IGEgZGVkaWNhdGVk
IG5ldCwgY29uc29sZSBhbmQgdnNvY2sKPiA+PiBkcml2ZXIgZm9yIHZyaW5naCAoQ0FJRiBzb21l
aG93IHdvcmtzIGxpa2UgdGhpcykuIFRoaXMgd291bGQgaGF2ZQo+ID4+IGJldHRlciBwZXJmb3Jt
YW5jZS4KPiA+IERvZXMgaXQgbWVhbiB0aGF0IHRoZSBkcml2ZXIgYWxzbyBmdW5jdGlvbnMgYXMg
YSBuZXR3b3JrIGRyaXZlciBkaXJlY3RseT8KCkkgbWVhbnQsIGUuZyBpbiB0aGUgY2FzZSBvZiBu
ZXR3b3JraW5nLCB5b3UgY2FuIGhhdmUgYSBkZWRpY2F0ZWQKZHJpdmVyIHdpdGggdHdvIHZyaW5n
aCBpbiB0aGUgZW5kcG9pbnQgc2lkZS4KClRoZSBiZW5lZml0IGlzIHRoZSBwZXJmb3JtYW5jZSwg
bm8gbmVlZCBmb3IgdGhlIChkYXRhcGF0aCkgbWVkaWF0aW9uLgoKQnV0IGlmIHdlIGRvbid0IGNh
cmUgYWJvdXQgdGhlIHBlcmZvcm1hbmNlLCB0aGlzIHByb3Bvc2FsIHNlZW1zIHRvIGJlIGZpbmUu
CgpUaGFua3MKCj4gPj4KPiA+Pj4gVGhpcyBkcml2ZXIgaGFzIHR3byByb2xlcy4gVGhlIGZpcnN0
IGlzIGFzIGEgUENJZSBlbmRwb2ludCB2aXJ0aW8gY29uc29sZQo+ID4+PiBmdW5jdGlvbiwgd2hp
Y2ggaXMgaW1wbGVtZW50ZWQgdXNpbmcgdGhlIFBDSWUgZW5kcG9pbnQgZnJhbWV3b3JrIGFuZCBQ
Q0llCj4gPj4+IEVQIHZpcnRpbyBoZWxwZXJzLiBUaGUgc2Vjb25kIGlzIGFzIGEgdmlydHVhbCB2
aXJ0aW8gY29uc29sZSBkZXZpY2UKPiA+Pj4gY29ubmVjdGVkIHRvIHRoZSB2aXJ0aW8gYnVzIG9u
IFBDSWUgZW5kcG9pbnQgTGludXguCj4gPj4+Cj4gPj4+IENvbW11bmljYXRpb24gYmV0d2VlbiB0
aGUgdHdvIGlzIGFjaGlldmVkIGJ5IGNvcHlpbmcgdGhlIHZpcnRxdWV1ZSBkYXRhCj4gPj4+IGJl
dHdlZW4gUENJZSByb290IGFuZCBlbmRwb2ludCwgcmVzcGVjdGl2ZWx5Lgo+ID4+Pgo+ID4+PiBU
aGlzIGlzIGEgc2ltcGxlIGltcGxlbWVudGF0aW9uIGFuZCBkb2VzIG5vdCBpbmNsdWRlIGZlYXR1
cmVzIG9mCj4gPj4+IHZpcnRpby1jb25zb2xlIHN1Y2ggYXMgTVVMVElQT1JULCBFTUVSR19XUklU
RSwgZXRjLiBBcyBhIHJlc3VsdCwgZWFjaAo+ID4+PiB2aXJ0aW8gY29uc29sZSBkcml2ZXIgb25s
eSBkaXNwbGF5cyAvZGV2L2h2YzAuCj4gPj4+Cj4gPj4+IEFzIGFuIGV4YW1wbGUgb2YgdXNhZ2Us
IGJ5IHNldHRpbmcgZ2V0dHkgdG8gL2Rldi9odmMwLCBpdCBpcyBwb3NzaWJsZSB0bwo+ID4+PiBs
b2dpbiB0byBhbm90aGVyIGhvc3QuCj4gPj4+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNodW5zdWtl
IE1pZSA8bWllQGlnZWwuY28uanA+Cj4gPj4+IC0tLQo+ID4+PiBDaGFuZ2VzIGZyb20gdjI6Cj4g
Pj4+IC0gQ2hhbmdlIHRvIHVzZSBjb3B5IGZ1bmN0aW9ucyBiZXR3ZWVuIGtpb3ZzIG9mIHBjaS1l
cGYtdmlydGlvLgo+ID4+Pgo+ID4+PiAgIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9L
Y29uZmlnICAgICAgICB8ICAxMiArCj4gPj4+ICAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL01ha2VmaWxlICAgICAgIHwgICAxICsKPiA+Pj4gICBkcml2ZXJzL3BjaS9lbmRwb2ludC9m
dW5jdGlvbnMvcGNpLWVwZi12Y29uLmMgfCA1OTYgKysrKysrKysrKysrKysrKysrCj4gPj4+ICAg
MyBmaWxlcyBjaGFuZ2VkLCA2MDkgaW5zZXJ0aW9ucygrKQo+ID4+PiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12Y29uLmMKPiA+Pj4K
PiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9LY29uZmln
IGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL0tjb25maWcKPiA+Pj4gaW5kZXggZmEx
YTZhNTY5YThmLi45Y2UyNjk4YjY3ZTEgMTAwNjQ0Cj4gPj4+IC0tLSBhL2RyaXZlcnMvcGNpL2Vu
ZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnCj4gPj4+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50
L2Z1bmN0aW9ucy9LY29uZmlnCj4gPj4+IEBAIC00NCwzICs0NCwxNSBAQCBjb25maWcgUENJX0VQ
Rl9WSVJUSU8KPiA+Pj4gICAgICAgICAgc2VsZWN0IFZIT1NUX1JJTkdfSU9NRU0KPiA+Pj4gICAg
ICAgICAgaGVscAo+ID4+PiAgICAgICAgICAgIEhlbHBlcnMgdG8gaW1wbGVtZW50IFBDSSB2aXJ0
aW8gRW5kcG9pbnQgZnVuY3Rpb24KPiA+Pj4gKwo+ID4+PiArY29uZmlnIFBDSV9FUEZfVkNPTgo+
ID4+PiArICAgICAgIHRyaXN0YXRlICJQQ0kgRW5kcG9pbnQgdmlyaXRvLWNvbnNvbGUgZHJpdmVy
Igo+ID4+PiArICAgICAgIGRlcGVuZHMgb24gUENJX0VORFBPSU5UCj4gPj4+ICsgICAgICAgc2Vs
ZWN0IFZIT1NUX1JJTkcKPiA+Pj4gKyAgICAgICBzZWxlY3QgUENJX0VQRl9WSVJUSU8KPiA+Pj4g
KyAgICAgICBoZWxwCj4gPj4+ICsgICAgICAgICBQQ0llIEVuZHBvaW50IHZpcnRpby1jb25zb2xl
IGZ1bmN0aW9uIGltcGxlbWVudGF0aW5vLiBUaGlzIG1vZHVsZQo+ID4+PiArICAgICAgICAgZW5h
YmxlcyB0byBzaG93IHRoZSB2aXJ0aW8tY29uc29sZSBhcyBwY2kgZGV2aWNlIHRvIFBDSWUgaG9z
dCBzaWRlLCBhbmQKPiA+Pj4gKyAgICAgICAgIGFub3RoZXIgdmlydHVhbCB2aXJ0aW8tY29uc29s
ZSBkZXZpY2UgcmVnaXN0ZXJzIHRvIGVuZHBvaW50IHN5c3RlbS4KPiA+Pj4gKyAgICAgICAgIFRo
b3NlIGRldmljZXMgYXJlIGNvbm5lY3RlZCB2aXJ0dWFsbHkgYW5kIGNhbiBjb21tdW5pY2F0ZSBl
YWNoIG90aGVyLgo+ID4+PiArCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvTWFrZWZpbGUgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFr
ZWZpbGUKPiA+Pj4gaW5kZXggYTk2ZjEyN2NlOTAwLi5iNDA1NjY4OWNlMzMgMTAwNjQ0Cj4gPj4+
IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9NYWtlZmlsZQo+ID4+PiArKysg
Yi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUKPiA+Pj4gQEAgLTcsMyAr
Nyw0IEBAIG9iai0kKENPTkZJR19QQ0lfRVBGX1RFU1QpICAgICAgICAgICAgICArPSBwY2ktZXBm
LXRlc3Qubwo+ID4+PiAgIG9iai0kKENPTkZJR19QQ0lfRVBGX05UQikgICAgICAgICAgICAgICs9
IHBjaS1lcGYtbnRiLm8KPiA+Pj4gICBvYmotJChDT05GSUdfUENJX0VQRl9WTlRCKSAgICAgICAg
ICAgICArPSBwY2ktZXBmLXZudGIubwo+ID4+PiAgIG9iai0kKENPTkZJR19QQ0lfRVBGX1ZJUlRJ
TykgICAgICAgICAgICs9IHBjaS1lcGYtdmlydGlvLm8KPiA+Pj4gK29iai0kKENPTkZJR19QQ0lf
RVBGX1ZDT04pICAgICAgICAgICAgICs9IHBjaS1lcGYtdmNvbi5vCj4gPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12Y29uLmMgYi9kcml2ZXJz
L3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12Y29uLmMKPiA+Pj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKPiA+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi4zMWY0MjQ3Y2QxMGYKPiA+Pj4gLS0t
IC9kZXYvbnVsbAo+ID4+PiArKysgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNp
LWVwZi12Y29uLmMKPiA+Pj4gQEAgLTAsMCArMSw1OTYgQEAKPiA+Pj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gPj4+ICsvKgo+ID4+PiArICogUENJIEVuZHBvaW50IGZ1
bmN0aW9uIGRyaXZlciB0byBpbXBsaW1lbnQgdmlydGlvLWNvbnNvbGUgZGV2aWNlCj4gPj4+ICsg
KiBmdW5jdGlvbmFsaXR5Lgo+ID4+PiArICovCj4gPj4+ICsjaW5jbHVkZSA8bGludXgvcGNpLWVw
Zi5oPgo+ID4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19pZHMuaD4KPiA+Pj4gKyNpbmNsdWRl
IDxsaW51eC92aXJ0aW9fcGNpLmg+Cj4gPj4+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX2NvbnNv
bGUuaD4KPiA+Pj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcmluZy5oPgo+ID4+PiArCj4gPj4+
ICsjaW5jbHVkZSAicGNpLWVwZi12aXJ0aW8uaCIKPiA+Pj4gKwo+ID4+PiArc3RhdGljIGludCB2
aXJ0aW9fcXVldWVfc2l6ZSA9IDB4MTAwOwo+ID4+PiArbW9kdWxlX3BhcmFtKHZpcnRpb19xdWV1
ZV9zaXplLCBpbnQsIDA0NDQpOwo+ID4+PiArTU9EVUxFX1BBUk1fREVTQyh2aXJ0aW9fcXVldWVf
c2l6ZSwgIkEgbGVuZ3RoIG9mIHZpcnRxdWV1ZSIpOwo+ID4+PiArCj4gPj4+ICtzdHJ1Y3QgZXBm
X3Zjb24gewo+ID4+PiArICAgICAgIC8qIFRvIGFjY2VzcyB2aXJ0cXVldWVzIG9uIHJlbW90ZSBo
b3N0ICovCj4gPj4+ICsgICAgICAgc3RydWN0IGVwZl92aXJ0aW8gZXZpbzsKPiA+Pj4gKyAgICAg
ICBzdHJ1Y3QgdnJpbmdoX2tpb3YgKnJkZXZfaW92czsKPiA+Pj4gKwo+ID4+PiArICAgICAgIC8q
IFRvIHJlZ2lzdGVyIGEgbG9jYWwgdmlydGlvIGJ1cyAqLwo+ID4+PiArICAgICAgIHN0cnVjdCB2
aXJ0aW9fZGV2aWNlIHZkZXY7Cj4gPj4+ICsKPiA+Pj4gKyAgICAgICAvKiBUbyBhY2Nlc3Mgdmly
dHF1ZXVzIG9mIGxvY2FsIGhvc3QgZHJpdmVyICovCj4gPj4+ICsgICAgICAgc3RydWN0IHZyaW5n
aCAqdmRldl92cmhzOwo+ID4+PiArICAgICAgIHN0cnVjdCB2cmluZ2hfa2lvdiAqdmRldl9pb3Zz
Owo+ID4+PiArICAgICAgIHN0cnVjdCB2aXJ0cXVldWUgKip2ZGV2X3ZxczsKPiA+Pj4gKwo+ID4+
PiArICAgICAgIC8qIEZvciB0cmFuc3BvcnRhdGlvbiBhbmQgbm90aWZpY2F0aW9uICovCj4gPj4+
ICsgICAgICAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKnRhc2tfd3E7Cj4gPj4+ICsgICAgICAg
c3RydWN0IHdvcmtfc3RydWN0IHJhaXNlX2lycV93b3JrLCByeF93b3JrLCB0eF93b3JrOwo+ID4+
PiArCj4gPj4+ICsgICAgICAgLyogVG8gcmV0YWluIHZpcnRpbyBmZWF0dXJlcy4gSXQgaXMgY29t
bW9ubHkgdXNlZCBsb2NhbCBhbmQgcmVtb3RlLiAqLwo+ID4+PiArICAgICAgIHU2NCBmZWF0dXJl
czsKPiA+Pj4gKwo+ID4+PiArICAgICAgIC8qIFRvIHNob3cgYSBzdGF0dXMgd2hldGhlciB0aGlz
IGRyaXZlciBpcyByZWFkeSBhbmQgdGhlIHJlbW90ZSBpcyBjb25uZWN0ZWQgKi8KPiA+Pj4gKyAg
ICAgICBib29sIGNvbm5lY3RlZDsKPiA+Pj4gK307Cj4gPj4+ICsKPiA+Pj4gK2VudW0gewo+ID4+
PiArICAgICAgIFZDT05fVklSVFFVRVVFX1JYLAo+ID4+PiArICAgICAgIFZDT05fVklSVFFVRVVF
X1RYLAo+ID4+PiArICAgICAgIC8vIFNob3VsZCBiZSBlbmQgb2YgZW51bQo+ID4+PiArICAgICAg
IFZDT05fVklSVFFVRVVFX05VTQo+ID4+PiArfTsKPiA+PiBJdCB3b3VsZCBiZSBiZXR0ZXIgaWYg
d2UgY2FuIHNwbGl0IHRoZSBjb25zb2xlIHNwZWNpZmljIHRoaW5nIG91dCwKPiA+PiB0aGVuIGl0
IGFsbG93cyB1cyB0byBkbyBldGhlcm5ldCBhbmQgdnNvY2sgaW4gdGhlIGZ1dHVyZS4KPiA+IEkn
bSBwbGFubmluZyB0byBpbXBsZW1lbnQgZWFjaCB2aXJ0aW8gZGV2aWNlIGluIGEgc2VwYXJhdGUg
ZmlsZS4KPiA+IGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy85MjIxMjQvCj4gPgo+ID4KPiA+Cj4g
Pj4gVGhhbmtzCj4gPj4KPiA+IEJlc3QgcmVnYXJkcywKPiA+IFNodW5zdWtlCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
