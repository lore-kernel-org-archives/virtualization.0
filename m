Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEADC77B73
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 04:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B9C3417B8;
	Mon,  8 May 2023 04:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B9C3417B8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PQAbHiyZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVPI48Fku4OJ; Mon,  8 May 2023 04:04:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 26D6D4175D;
	Mon,  8 May 2023 04:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26D6D4175D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7B1BC0036;
	Mon,  8 May 2023 04:04:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5056BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 04:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 235F182033
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 04:04:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 235F182033
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PQAbHiyZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TZvLuR626Q8s
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 04:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C39D481EC1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C39D481EC1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 04:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683518639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjPs9stpL32DcqNj5bKjn9GpBpdTZMFDdDnlNEkwniM=;
 b=PQAbHiyZvGjJURQVJ2p12JQsBbYSJGxu5Jw/43HKRsjtvPhzNqbQSUHnDiGdTVqB4wEE2O
 tME8Cy95IiUcp+vMy9IucaTcxeygCWCUGAVs6Kdr9c83r4QE31hyz/yz4xWugNC7oDPtzb
 pWuuou0cKYqYFU9+9IdOPPI3CUBBfdo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-P32HQgEMMbCX9TORen4eYA-1; Mon, 08 May 2023 00:03:57 -0400
X-MC-Unique: P32HQgEMMbCX9TORen4eYA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso2065998e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 21:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683518636; x=1686110636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjPs9stpL32DcqNj5bKjn9GpBpdTZMFDdDnlNEkwniM=;
 b=THsKvmQXoUOtuC7FEfrCcZ1LCRIMzV8WNY6Xdd1UYjiGNweW6W5PBFhNT0gab0MdkI
 mww0w1e81jFvduBMNb3/nvqsvKHNJZcuKiS4t16IZWZI1rLtAvr1xKjr7RWL8XzgVJT4
 FwaArt3FyiLGYxz52RvbbCN3Oj7/M9wXv4EVT0dSBPUegviTHLjSsSnAY/h54KhTRewc
 l+qufeiBw5G6gE2EPQuiyMvIwhw/srVNJq7ASv8432CHQbXY7lyhP1tl8fhc7GHJuwa+
 ZxpY1c3qgiXg61KROMxxBB1NvGOdiLnxHG24OvvQxPdR3HewC1Wk3yVQ9ZR3DI11sBEC
 41YA==
X-Gm-Message-State: AC+VfDyiNGiUi0GFj/tQvJzxmaa3DPq1BKQzTQAfeZI6lOxCmJ348MMw
 I9cUw/f/dbu+ADU5/nDyoTOAvVd/9Gxu7sYigPmFdVU0c6TvfgPfbrw7Kifv4XqyRzWYY29V+p6
 dJve7qFW43WqIJ4YKDEw6vOJYrL5LZOYn0INohU22WZ0A3WJje23q6RPwGA==
X-Received: by 2002:ac2:5d42:0:b0:4f0:1a32:d51f with SMTP id
 w2-20020ac25d42000000b004f01a32d51fmr2130088lfd.23.1683518636470; 
 Sun, 07 May 2023 21:03:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qV2KFVI/GVAa9K7BHzf5fBIl+dJd4cI1tXXN94p9wvE+RjD75G6WDEDrhlh3J58C1wRSGJhuSPvsX2+k1sEs=
X-Received: by 2002:ac2:5d42:0:b0:4f0:1a32:d51f with SMTP id
 w2-20020ac25d42000000b004f01a32d51fmr2130074lfd.23.1683518636126; Sun, 07 May
 2023 21:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp>
 <20230427104428.862643-4-mie@igel.co.jp>
In-Reply-To: <20230427104428.862643-4-mie@igel.co.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 May 2023 12:03:44 +0800
Message-ID: <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
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

T24gVGh1LCBBcHIgMjcsIDIwMjMgYXQgNjo0NOKAr1BNIFNodW5zdWtlIE1pZSA8bWllQGlnZWwu
Y28uanA+IHdyb3RlOgo+Cj4gQWRkIGEgbmV3IFBDSWUgZW5kcG9pbnQgZnVuY3Rpb24gZHJpdmVy
IHRoYXQgd29ya3MgYXMgYSBwY2kgdmlydGlvLWNvbnNvbGUKPiBkZXZpY2UuIFRoZSBjb25zb2xl
IGNvbm5lY3QgdG8gZW5kcG9pbnQgc2lkZSBjb25zb2xlLiBJdCBlbmFibGVzIHRvCj4gY29tbXVu
aWNhdGUgUENJZSBob3N0IGFuZCBlbmRwb2ludC4KPgo+IEFyY2hpdGVjdHVyZSBpcyBmb2xsb3dp
bmc6Cj4KPiAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAg
ICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQ
Cj4gIOKUgnZpcnRpb2UgICAgIOKUgiAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDi
lIJ2aXJ0aW8gICAgICDilIIKPiAg4pSCY29uc29sZSBkcnYg4pSCICAgICAgICAg4pSc4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAg4pSCY29uc29s
ZSBkcnYg4pSCCj4gIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAg
ICAgICAgIOKUgih2aXJ0aW8gY29uc29sZeKUgiAgICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUpAo+ICDilIIgdmlydGlvIGJ1cyDilIIgICAgICAgICDilIIgZGV2
aWNlKSAgICAgICDilILil4TilIDilIDilIDilIDilrrilIIgdmlydGlvIGJ1cyDilIIKPiAg4pSc
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkICAgICAgICAg4pScLS0tLS0t
LS0tLS0tLS0t4pSkICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkCj4gIOKUgiAgICAgICAgICAgIOKUgiAgICAgICAgIOKUgiBwY2kgZXAgdmlydGlvIOKUgiAg
ICAgICAgICAgICAgICAgICDilIIKPiAg4pSCICBwY2kgYnVzICAg4pSCICAgICAgICAg4pSCICBj
b25zb2xlIGRydiAg4pSCICAgICAgICAgICAgICAgICAgIOKUggo+ICDilIIgICAgICAgICAgICDi
lIIgIHBjaWUgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilKQgICAgICAgICAgICAgICAgICAg4pSCCj4gIOKUgiAgICAgICAgICAgIOKUgiDil4TilIDi
lIDilIDilIDilIDilrog4pSCICBwY2kgZXAgQnVzICAg4pSCICAgICAgICAgICAgICAgICAgIOKU
ggo+ICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJggICAgICAgICDi
lJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLTilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgKPiAg
ICBQQ0llIFJvb3QgICAgICAgICAgICAgIFBDSWUgRW5kcG9pbnQKPgoKSSB0aGluayBpdCBtaWdo
dCBvbmx5IHdvcmtzIGZvciBwZWVyIGRldmljZXMgbGlrZToKCm5ldCwgY29uc29sZSBvciB2c29j
ay4KClNvIHRoZXJlJ3JlIG1hbnkgY2hvaWNlcyBoZXJlLCBJJ2QgbGlrZSB0byBrbm93IHdoYXQn
cyB0aGUgcmVhc29uIGZvcgp5b3UgdG8gaW1wbGVtZW50IGEgbWVkaWF0aW9uLgoKQW4gYWx0ZXJu
YXRpdmUgaXMgdG8gaW1wbGVtZW50IGEgZGVkaWNhdGVkIG5ldCwgY29uc29sZSBhbmQgdnNvY2sK
ZHJpdmVyIGZvciB2cmluZ2ggKENBSUYgc29tZWhvdyB3b3JrcyBsaWtlIHRoaXMpLiBUaGlzIHdv
dWxkIGhhdmUKYmV0dGVyIHBlcmZvcm1hbmNlLgoKCgo+IFRoaXMgZHJpdmVyIGhhcyB0d28gcm9s
ZXMuIFRoZSBmaXJzdCBpcyBhcyBhIFBDSWUgZW5kcG9pbnQgdmlydGlvIGNvbnNvbGUKPiBmdW5j
dGlvbiwgd2hpY2ggaXMgaW1wbGVtZW50ZWQgdXNpbmcgdGhlIFBDSWUgZW5kcG9pbnQgZnJhbWV3
b3JrIGFuZCBQQ0llCj4gRVAgdmlydGlvIGhlbHBlcnMuIFRoZSBzZWNvbmQgaXMgYXMgYSB2aXJ0
dWFsIHZpcnRpbyBjb25zb2xlIGRldmljZQo+IGNvbm5lY3RlZCB0byB0aGUgdmlydGlvIGJ1cyBv
biBQQ0llIGVuZHBvaW50IExpbnV4Lgo+Cj4gQ29tbXVuaWNhdGlvbiBiZXR3ZWVuIHRoZSB0d28g
aXMgYWNoaWV2ZWQgYnkgY29weWluZyB0aGUgdmlydHF1ZXVlIGRhdGEKPiBiZXR3ZWVuIFBDSWUg
cm9vdCBhbmQgZW5kcG9pbnQsIHJlc3BlY3RpdmVseS4KPgo+IFRoaXMgaXMgYSBzaW1wbGUgaW1w
bGVtZW50YXRpb24gYW5kIGRvZXMgbm90IGluY2x1ZGUgZmVhdHVyZXMgb2YKPiB2aXJ0aW8tY29u
c29sZSBzdWNoIGFzIE1VTFRJUE9SVCwgRU1FUkdfV1JJVEUsIGV0Yy4gQXMgYSByZXN1bHQsIGVh
Y2gKPiB2aXJ0aW8gY29uc29sZSBkcml2ZXIgb25seSBkaXNwbGF5cyAvZGV2L2h2YzAuCj4KPiBB
cyBhbiBleGFtcGxlIG9mIHVzYWdlLCBieSBzZXR0aW5nIGdldHR5IHRvIC9kZXYvaHZjMCwgaXQg
aXMgcG9zc2libGUgdG8KPiBsb2dpbiB0byBhbm90aGVyIGhvc3QuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPgo+IC0tLQo+IENoYW5nZXMgZnJvbSB2MjoK
PiAtIENoYW5nZSB0byB1c2UgY29weSBmdW5jdGlvbnMgYmV0d2VlbiBraW92cyBvZiBwY2ktZXBm
LXZpcnRpby4KPgo+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvS2NvbmZpZyAgICAg
ICAgfCAgMTIgKwo+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUgICAg
ICAgfCAgIDEgKwo+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12Y29u
LmMgfCA1OTYgKysrKysrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgNjA5IGluc2Vy
dGlvbnMoKykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0
aW9ucy9wY2ktZXBmLXZjb24uYwo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBvaW50
L2Z1bmN0aW9ucy9LY29uZmlnIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL0tjb25m
aWcKPiBpbmRleCBmYTFhNmE1NjlhOGYuLjljZTI2OThiNjdlMSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvcGNpL2Vu
ZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnCj4gQEAgLTQ0LDMgKzQ0LDE1IEBAIGNvbmZpZyBQQ0lf
RVBGX1ZJUlRJTwo+ICAgICAgICAgc2VsZWN0IFZIT1NUX1JJTkdfSU9NRU0KPiAgICAgICAgIGhl
bHAKPiAgICAgICAgICAgSGVscGVycyB0byBpbXBsZW1lbnQgUENJIHZpcnRpbyBFbmRwb2ludCBm
dW5jdGlvbgo+ICsKPiArY29uZmlnIFBDSV9FUEZfVkNPTgo+ICsgICAgICAgdHJpc3RhdGUgIlBD
SSBFbmRwb2ludCB2aXJpdG8tY29uc29sZSBkcml2ZXIiCj4gKyAgICAgICBkZXBlbmRzIG9uIFBD
SV9FTkRQT0lOVAo+ICsgICAgICAgc2VsZWN0IFZIT1NUX1JJTkcKPiArICAgICAgIHNlbGVjdCBQ
Q0lfRVBGX1ZJUlRJTwo+ICsgICAgICAgaGVscAo+ICsgICAgICAgICBQQ0llIEVuZHBvaW50IHZp
cnRpby1jb25zb2xlIGZ1bmN0aW9uIGltcGxlbWVudGF0aW5vLiBUaGlzIG1vZHVsZQo+ICsgICAg
ICAgICBlbmFibGVzIHRvIHNob3cgdGhlIHZpcnRpby1jb25zb2xlIGFzIHBjaSBkZXZpY2UgdG8g
UENJZSBob3N0IHNpZGUsIGFuZAo+ICsgICAgICAgICBhbm90aGVyIHZpcnR1YWwgdmlydGlvLWNv
bnNvbGUgZGV2aWNlIHJlZ2lzdGVycyB0byBlbmRwb2ludCBzeXN0ZW0uCj4gKyAgICAgICAgIFRo
b3NlIGRldmljZXMgYXJlIGNvbm5lY3RlZCB2aXJ0dWFsbHkgYW5kIGNhbiBjb21tdW5pY2F0ZSBl
YWNoIG90aGVyLgo+ICsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL01ha2VmaWxlIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL01ha2VmaWxlCj4g
aW5kZXggYTk2ZjEyN2NlOTAwLi5iNDA1NjY4OWNlMzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9w
Y2kvZW5kcG9pbnQvZnVuY3Rpb25zL01ha2VmaWxlCj4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9p
bnQvZnVuY3Rpb25zL01ha2VmaWxlCj4gQEAgLTcsMyArNyw0IEBAIG9iai0kKENPTkZJR19QQ0lf
RVBGX1RFU1QpICAgICAgICAgICAgICArPSBwY2ktZXBmLXRlc3Qubwo+ICBvYmotJChDT05GSUdf
UENJX0VQRl9OVEIpICAgICAgICAgICAgICArPSBwY2ktZXBmLW50Yi5vCj4gIG9iai0kKENPTkZJ
R19QQ0lfRVBGX1ZOVEIpICAgICAgICAgICAgICs9IHBjaS1lcGYtdm50Yi5vCj4gIG9iai0kKENP
TkZJR19QQ0lfRVBGX1ZJUlRJTykgICAgICAgICAgICs9IHBjaS1lcGYtdmlydGlvLm8KPiArb2Jq
LSQoQ09ORklHX1BDSV9FUEZfVkNPTikgICAgICAgICAgICAgKz0gcGNpLWVwZi12Y29uLm8KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmNvbi5j
IGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmNvbi5jCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLjMxZjQyNDdjZDEwZgo+IC0tLSAv
ZGV2L251bGwKPiArKysgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12
Y29uLmMKPiBAQCAtMCwwICsxLDU5NiBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMAo+ICsvKgo+ICsgKiBQQ0kgRW5kcG9pbnQgZnVuY3Rpb24gZHJpdmVyIHRvIGltcGxp
bWVudCB2aXJ0aW8tY29uc29sZSBkZXZpY2UKPiArICogZnVuY3Rpb25hbGl0eS4KPiArICovCj4g
KyNpbmNsdWRlIDxsaW51eC9wY2ktZXBmLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9faWRz
Lmg+Cj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC92
aXJ0aW9fY29uc29sZS5oPgo+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX3JpbmcuaD4KPiArCj4g
KyNpbmNsdWRlICJwY2ktZXBmLXZpcnRpby5oIgo+ICsKPiArc3RhdGljIGludCB2aXJ0aW9fcXVl
dWVfc2l6ZSA9IDB4MTAwOwo+ICttb2R1bGVfcGFyYW0odmlydGlvX3F1ZXVlX3NpemUsIGludCwg
MDQ0NCk7Cj4gK01PRFVMRV9QQVJNX0RFU0ModmlydGlvX3F1ZXVlX3NpemUsICJBIGxlbmd0aCBv
ZiB2aXJ0cXVldWUiKTsKPiArCj4gK3N0cnVjdCBlcGZfdmNvbiB7Cj4gKyAgICAgICAvKiBUbyBh
Y2Nlc3MgdmlydHF1ZXVlcyBvbiByZW1vdGUgaG9zdCAqLwo+ICsgICAgICAgc3RydWN0IGVwZl92
aXJ0aW8gZXZpbzsKPiArICAgICAgIHN0cnVjdCB2cmluZ2hfa2lvdiAqcmRldl9pb3ZzOwo+ICsK
PiArICAgICAgIC8qIFRvIHJlZ2lzdGVyIGEgbG9jYWwgdmlydGlvIGJ1cyAqLwo+ICsgICAgICAg
c3RydWN0IHZpcnRpb19kZXZpY2UgdmRldjsKPiArCj4gKyAgICAgICAvKiBUbyBhY2Nlc3Mgdmly
dHF1ZXVzIG9mIGxvY2FsIGhvc3QgZHJpdmVyICovCj4gKyAgICAgICBzdHJ1Y3QgdnJpbmdoICp2
ZGV2X3ZyaHM7Cj4gKyAgICAgICBzdHJ1Y3QgdnJpbmdoX2tpb3YgKnZkZXZfaW92czsKPiArICAg
ICAgIHN0cnVjdCB2aXJ0cXVldWUgKip2ZGV2X3ZxczsKPiArCj4gKyAgICAgICAvKiBGb3IgdHJh
bnNwb3J0YXRpb24gYW5kIG5vdGlmaWNhdGlvbiAqLwo+ICsgICAgICAgc3RydWN0IHdvcmtxdWV1
ZV9zdHJ1Y3QgKnRhc2tfd3E7Cj4gKyAgICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgcmFpc2VfaXJx
X3dvcmssIHJ4X3dvcmssIHR4X3dvcms7Cj4gKwo+ICsgICAgICAgLyogVG8gcmV0YWluIHZpcnRp
byBmZWF0dXJlcy4gSXQgaXMgY29tbW9ubHkgdXNlZCBsb2NhbCBhbmQgcmVtb3RlLiAqLwo+ICsg
ICAgICAgdTY0IGZlYXR1cmVzOwo+ICsKPiArICAgICAgIC8qIFRvIHNob3cgYSBzdGF0dXMgd2hl
dGhlciB0aGlzIGRyaXZlciBpcyByZWFkeSBhbmQgdGhlIHJlbW90ZSBpcyBjb25uZWN0ZWQgKi8K
PiArICAgICAgIGJvb2wgY29ubmVjdGVkOwo+ICt9Owo+ICsKPiArZW51bSB7Cj4gKyAgICAgICBW
Q09OX1ZJUlRRVUVVRV9SWCwKPiArICAgICAgIFZDT05fVklSVFFVRVVFX1RYLAo+ICsgICAgICAg
Ly8gU2hvdWxkIGJlIGVuZCBvZiBlbnVtCj4gKyAgICAgICBWQ09OX1ZJUlRRVUVVRV9OVU0KPiAr
fTsKCkl0IHdvdWxkIGJlIGJldHRlciBpZiB3ZSBjYW4gc3BsaXQgdGhlIGNvbnNvbGUgc3BlY2lm
aWMgdGhpbmcgb3V0LAp0aGVuIGl0IGFsbG93cyB1cyB0byBkbyBldGhlcm5ldCBhbmQgdnNvY2sg
aW4gdGhlIGZ1dHVyZS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
