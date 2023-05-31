Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E98C7EE24
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 10:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AF79820EC;
	Wed, 31 May 2023 10:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AF79820EC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=Eh+I0hgv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmIg2_lltAW3; Wed, 31 May 2023 10:51:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B6E7820D5;
	Wed, 31 May 2023 10:51:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B6E7820D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15F75C0087;
	Wed, 31 May 2023 10:51:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82DE1C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 10:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FC3360ABE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 10:51:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FC3360ABE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=Eh+I0hgv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Iv8m9qZ2-a2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 10:51:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFFF960899
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFFF960899
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 10:51:47 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-33b0cae115bso29231265ab.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1685530306; x=1688122306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OL+MUAGjHXCcVBhRxcCYXFGT+AfAFBLYOnPjKg/aVcI=;
 b=Eh+I0hgvt7vbsksAnBxrKvE4+kAg82/jq/WqMTCfwpB6OOhlxkMjQmpKkQLwUDz0jj
 VF8wShWQF/m5XJ+GeyDOCwaB8QRsPnjqRIjLXh/s5NqQk6uTUJ/6vYQkkC9CrUZX5jZ4
 TJIBITvLjFM+I57GTztJJ58kFDtAUmnlG5+KQbgXDoX/CZ2+oDs8LUVi9O9aVsU8p0Zq
 H/ZXbcAjkfyWpoOVydazKLtDVtY7wWbXmHyeG5rNo4wvfk8Ea5/Z/MTu9z6H30hYA/0N
 4E8r9KZF+N/Jigi0LROJvNcqN8CXNZQWaPW1aoQEJbSR1I5djVOz94pyaOZ/mCDY4nDK
 JWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685530306; x=1688122306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OL+MUAGjHXCcVBhRxcCYXFGT+AfAFBLYOnPjKg/aVcI=;
 b=cZKdi2aOp0iGBCjA5lnxiBS2RAklWGbpf4omr5bU+T0OFZIb84KPSX+n0Dx+N1kKY7
 S2VOgxQKTaBKVw9p8QjtwqrvkKXkQ+UyebsrQ5PJJr8UcWF0+tBEqsrunykDEC2o/XIg
 /VXCgqRDzr64OWCspSjUSiShvhetbAbs+JWuYHYxW6wQOM6/sc2O1G7eXpTBIuDsnbqR
 1DCt3PyXhh2g9q7i+VYd0W33GhADKfTetB5XYnjxpDi+Z8h94/0bmhu050C0O5qDnVhx
 ljuyPtzcTD2as5tG+rSOytGRnznLXIQKJ5DXHQDH6+QKVhXYPKKssjLAKPK0Hzel24Ik
 OyfA==
X-Gm-Message-State: AC+VfDygdsOUqrjm9xCPkyjbVgfjOLTfAiaGCZyvY2kO2k48zUtzSuo+
 syLO27tsdhTa5ECULb3ceapI+w==
X-Google-Smtp-Source: ACHHUZ5wTHf6brPVTM9Pu10tfLM6QoR8MR+RK/fU0uvSnUIafDy/ueDylPxOs/iblYKzccIBhVU3DA==
X-Received: by 2002:a92:c144:0:b0:33a:f1b2:eb6c with SMTP id
 b4-20020a92c144000000b0033af1b2eb6cmr2344646ilh.3.1685530306356; 
 Wed, 31 May 2023 03:51:46 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 jd21-20020a170903261500b001b045c9abd2sm1041969plb.143.2023.05.31.03.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 03:51:45 -0700 (PDT)
Message-ID: <2422273d-5ac2-63ef-8a31-230ebfbe3b23@igel.co.jp>
Date: Wed, 31 May 2023 19:51:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
To: Jason Wang <jasowang@redhat.com>
References: <20230427104428.862643-1-mie@igel.co.jp>
 <20230427104428.862643-4-mie@igel.co.jp>
 <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
 <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com>
 <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
 <CACGkMEvdVHQEcDD74TpeWgmHQ+J9aMpv5ui=iwT8E_SDZoY7EA@mail.gmail.com>
Content-Language: en-US
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <CACGkMEvdVHQEcDD74TpeWgmHQ+J9aMpv5ui=iwT8E_SDZoY7EA@mail.gmail.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SSdtIHNvcnJ5IGZvciBsYXRlIHJlc3BvbnNlLgoKT24gMjAyMy8wNS8xOSAxMTowMSwgSmFzb24g
V2FuZyB3cm90ZToKPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCA1OjU04oCvUE0gU2h1bnN1a2Ug
TWllIDxtaWVAaWdlbC5jby5qcD4gd3JvdGU6Cj4+IEdlbnRsZSBwaW5nIC4uLgo+Pgo+Pgo+PiBU
aGFua3MsCj4+Cj4+IFNodW5zdWtlLgo+Pgo+PiBPbiAyMDIzLzA1LzEwIDEyOjE3LCBTaHVuc3Vr
ZSBNaWUgd3JvdGU6Cj4+PiBIaSBKc29uLAo+Pj4gMjAyM+W5tDXmnIg45pelKOaciCkgMTM6MDMg
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT46Cj4+Pj4gT24gVGh1LCBBcHIgMjcsIDIw
MjMgYXQgNjo0NOKAr1BNIFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+IHdyb3RlOgo+Pj4+
PiBBZGQgYSBuZXcgUENJZSBlbmRwb2ludCBmdW5jdGlvbiBkcml2ZXIgdGhhdCB3b3JrcyBhcyBh
IHBjaSB2aXJ0aW8tY29uc29sZQo+Pj4+PiBkZXZpY2UuIFRoZSBjb25zb2xlIGNvbm5lY3QgdG8g
ZW5kcG9pbnQgc2lkZSBjb25zb2xlLiBJdCBlbmFibGVzIHRvCj4+Pj4+IGNvbW11bmljYXRlIFBD
SWUgaG9zdCBhbmQgZW5kcG9pbnQuCj4+Pj4+Cj4+Pj4+IEFyY2hpdGVjdHVyZSBpcyBmb2xsb3dp
bmc6Cj4+Pj4+Cj4+Pj4+ICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUkCAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUkAo+Pj4+PiAgICDilIJ2aXJ0aW9lICAgICDilIIgICAgICAgICDilIIgICAgICAg
ICAgICAgICAgICAgICAg4pSCdmlydGlvICAgICAg4pSCCj4+Pj4+ICAgIOKUgmNvbnNvbGUgZHJ2
IOKUgiAgICAgICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUkCAgICAgIOKUgmNvbnNvbGUgZHJ2IOKUggo+Pj4+PiAgICDilJzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAgICDilIIodmlydGlvIGNvbnNvbGXilIIg
ICAgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQKPj4+Pj4gICAg
4pSCIHZpcnRpbyBidXMg4pSCICAgICAgICAg4pSCIGRldmljZSkgICAgICAg4pSC4peE4pSA4pSA
4pSA4pSA4pa64pSCIHZpcnRpbyBidXMg4pSCCj4+Pj4+ICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgIOKUnC0tLS0tLS0tLS0tLS0tLeKUpCAgICAg
IOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpAo+Pj4+PiAgICDilIIg
ICAgICAgICAgICDilIIgICAgICAgICDilIIgcGNpIGVwIHZpcnRpbyDilIIgICAgICAgICAgICAg
ICAgICAg4pSCCj4+Pj4+ICAgIOKUgiAgcGNpIGJ1cyAgIOKUgiAgICAgICAgIOKUgiAgY29uc29s
ZSBkcnYgIOKUgiAgICAgICAgICAgICAgICAgICDilIIKPj4+Pj4gICAg4pSCICAgICAgICAgICAg
4pSCICBwY2llICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSkICAgICAgICAgICAgICAgICAgIOKUggo+Pj4+PiAgICDilIIgICAgICAgICAgICDilIIg
4peE4pSA4pSA4pSA4pSA4pSA4pa6IOKUgiAgcGNpIGVwIEJ1cyAgIOKUgiAgICAgICAgICAgICAg
ICAgICDilIIKPj4+Pj4gICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSYICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSYCj4+Pj4+ICAgICAgUENJZSBSb290ICAgICAgICAgICAgICBQQ0llIEVuZHBvaW50
Cj4+Pj4+Cj4+Pj4gSSB0aGluayBpdCBtaWdodCBvbmx5IHdvcmtzIGZvciBwZWVyIGRldmljZXMg
bGlrZToKPj4+Pgo+Pj4+IG5ldCwgY29uc29sZSBvciB2c29jay4KPj4+IENvdWxkIHlvdSB0ZWxs
IG1lIHdoYXQgInBlZXIgZGV2aWNlcyIgbWVhbnM/Cj4gSSBtZWFudCwgZm9yIGV4YW1wbGUgd2Ug
a25vdyBpbiB0aGUgY2FzZSBvZiB2aXJ0aW8tbmV0LCBUWCBjYW4gdGFsawo+IHdpdGggUlggYmVs
b25naW5nIHRvIGFub3RoZXIgZGV2aWNlIGRpcmVjdGx5Lgo+Cj4gQnV0IHRoaXMgaXMgbm90IHRo
ZSBjYXNlIGZvciBvdGhlciBkZXZpY2VzIGxpa2UgdmlyaXRvLWJsay4KVGhhbmsgeW91LiBJIGNv
bXByZWhlbmRlZCBpdC4KPj4+PiBTbyB0aGVyZSdyZSBtYW55IGNob2ljZXMgaGVyZSwgSSdkIGxp
a2UgdG8ga25vdyB3aGF0J3MgdGhlIHJlYXNvbiBmb3IKPj4+PiB5b3UgdG8gaW1wbGVtZW50IGEg
bWVkaWF0aW9uLgo+Pj4+Cj4+Pj4gQW4gYWx0ZXJuYXRpdmUgaXMgdG8gaW1wbGVtZW50IGEgZGVk
aWNhdGVkIG5ldCwgY29uc29sZSBhbmQgdnNvY2sKPj4+PiBkcml2ZXIgZm9yIHZyaW5naCAoQ0FJ
RiBzb21laG93IHdvcmtzIGxpa2UgdGhpcykuIFRoaXMgd291bGQgaGF2ZQo+Pj4+IGJldHRlciBw
ZXJmb3JtYW5jZS4KPj4+IERvZXMgaXQgbWVhbiB0aGF0IHRoZSBkcml2ZXIgYWxzbyBmdW5jdGlv
bnMgYXMgYSBuZXR3b3JrIGRyaXZlciBkaXJlY3RseT8KPiBJIG1lYW50LCBlLmcgaW4gdGhlIGNh
c2Ugb2YgbmV0d29ya2luZywgeW91IGNhbiBoYXZlIGEgZGVkaWNhdGVkCj4gZHJpdmVyIHdpdGgg
dHdvIHZyaW5naCBpbiB0aGUgZW5kcG9pbnQgc2lkZS4KPgo+IFRoZSBiZW5lZml0IGlzIHRoZSBw
ZXJmb3JtYW5jZSwgbm8gbmVlZCBmb3IgdGhlIChkYXRhcGF0aCkgbWVkaWF0aW9uLgo+Cj4gQnV0
IGlmIHdlIGRvbid0IGNhcmUgYWJvdXQgdGhlIHBlcmZvcm1hbmNlLCB0aGlzIHByb3Bvc2FsIHNl
ZW1zIHRvIGJlIGZpbmUuCj4KPiBUaGFua3MKSSBhZ3JlZSB3aXRoIHlvdS7CoCBUaGUgZGVzaWdu
IHlvdSBzdWdnZXN0ZWQgaXMgYmV0dGVyIGluIHRlcm1zIG9mIApwZXJmb3JtYW5jZS4KSG93ZXZl
ciwgdGhlIHByb3Bvc2VkIGRlc2lnbiBpcyBub3QgYmFkIGZvciB0aGUgZm9sbG93aW5nIHRoZSBy
ZWFzb25zIEkgCnRoaW5rLgoKVGhlIHByb3Bvc2VkIGRlc2lnbiBoYXMgb25lIG1vcmUgb3BlcmF0
aW9uIGluIGNvbnRyb2wgcGxhbmUgYmVjYXVzZSB0aGUgZGF0YQpzdGVwcyBvdmVyIHRoZSB2aXJ0
aW8tbmV0IGRyaXZlciwgYnV0IHRoZSBudW1iZXIgb2YgY29waWVzIGF0IHRoZSBkYXRhIHBsYW5l
CnJlbWFpbnMgdGhlIHNhbWUuIEkgdGhpbmsgdGhlIG9wZXJhdGlvbiBhZGRlZCBpbiBjb250cm9s
IHBsYW5lIGhhcyBzbWFsbCAKZWZmZWN0cwpmb3IgcGVyZm9ybWFuY2UuCgpNb3Jlb3ZlciwgdGhl
cmUgYXJlIHNvbWUgYWR2YW50YWdlcyB3aGVuIHRoZSBkYXRhIHN0ZXAgb3ZlciB0aGUgdmlydGlv
LW5ldApkcml2ZXIuIFdlIGNhbiBtYWtlIHVzZSBvZiB0aGUgb3B0aW1pemF0aW9ucyBhbmQgc29t
ZSBmdW5jdGlvbnMgd2l0aG91dAptb2RpZmljYXRpb25zIGFuZCBpbXBsZW1lbnRhdGlvbnMuIGUu
Zy4gZXRodG9vbCBhbmQgWERQKEJQRikgc3VwcG9ydHMuCgpBbnkgY29tbWVudHMgd291bGQgYmUg
YXBwcmVjaWF0ZWQuCgo+Pj4+PiBUaGlzIGRyaXZlciBoYXMgdHdvIHJvbGVzLiBUaGUgZmlyc3Qg
aXMgYXMgYSBQQ0llIGVuZHBvaW50IHZpcnRpbyBjb25zb2xlCj4+Pj4+IGZ1bmN0aW9uLCB3aGlj
aCBpcyBpbXBsZW1lbnRlZCB1c2luZyB0aGUgUENJZSBlbmRwb2ludCBmcmFtZXdvcmsgYW5kIFBD
SWUKPj4+Pj4gRVAgdmlydGlvIGhlbHBlcnMuIFRoZSBzZWNvbmQgaXMgYXMgYSB2aXJ0dWFsIHZp
cnRpbyBjb25zb2xlIGRldmljZQo+Pj4+PiBjb25uZWN0ZWQgdG8gdGhlIHZpcnRpbyBidXMgb24g
UENJZSBlbmRwb2ludCBMaW51eC4KPj4+Pj4KPj4+Pj4gQ29tbXVuaWNhdGlvbiBiZXR3ZWVuIHRo
ZSB0d28gaXMgYWNoaWV2ZWQgYnkgY29weWluZyB0aGUgdmlydHF1ZXVlIGRhdGEKPj4+Pj4gYmV0
d2VlbiBQQ0llIHJvb3QgYW5kIGVuZHBvaW50LCByZXNwZWN0aXZlbHkuCj4+Pj4+Cj4+Pj4+IFRo
aXMgaXMgYSBzaW1wbGUgaW1wbGVtZW50YXRpb24gYW5kIGRvZXMgbm90IGluY2x1ZGUgZmVhdHVy
ZXMgb2YKPj4+Pj4gdmlydGlvLWNvbnNvbGUgc3VjaCBhcyBNVUxUSVBPUlQsIEVNRVJHX1dSSVRF
LCBldGMuIEFzIGEgcmVzdWx0LCBlYWNoCj4+Pj4+IHZpcnRpbyBjb25zb2xlIGRyaXZlciBvbmx5
IGRpc3BsYXlzIC9kZXYvaHZjMC4KPj4+Pj4KPj4+Pj4gQXMgYW4gZXhhbXBsZSBvZiB1c2FnZSwg
Ynkgc2V0dGluZyBnZXR0eSB0byAvZGV2L2h2YzAsIGl0IGlzIHBvc3NpYmxlIHRvCj4+Pj4+IGxv
Z2luIHRvIGFub3RoZXIgaG9zdC4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogU2h1bnN1a2Ug
TWllIDxtaWVAaWdlbC5jby5qcD4KPj4+Pj4gLS0tCj4+Pj4+IENoYW5nZXMgZnJvbSB2MjoKPj4+
Pj4gLSBDaGFuZ2UgdG8gdXNlIGNvcHkgZnVuY3Rpb25zIGJldHdlZW4ga2lvdnMgb2YgcGNpLWVw
Zi12aXJ0aW8uCj4+Pj4+Cj4+Pj4+ICAgIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9L
Y29uZmlnICAgICAgICB8ICAxMiArCj4+Pj4+ICAgIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0
aW9ucy9NYWtlZmlsZSAgICAgICB8ICAgMSArCj4+Pj4+ICAgIGRyaXZlcnMvcGNpL2VuZHBvaW50
L2Z1bmN0aW9ucy9wY2ktZXBmLXZjb24uYyB8IDU5NiArKysrKysrKysrKysrKysrKysKPj4+Pj4g
ICAgMyBmaWxlcyBjaGFuZ2VkLCA2MDkgaW5zZXJ0aW9ucygrKQo+Pj4+PiAgICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmNvbi5jCj4+
Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvS2Nv
bmZpZyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnCj4+Pj4+IGluZGV4
IGZhMWE2YTU2OWE4Zi4uOWNlMjY5OGI2N2UxIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3Bj
aS9lbmRwb2ludC9mdW5jdGlvbnMvS2NvbmZpZwo+Pj4+PiArKysgYi9kcml2ZXJzL3BjaS9lbmRw
b2ludC9mdW5jdGlvbnMvS2NvbmZpZwo+Pj4+PiBAQCAtNDQsMyArNDQsMTUgQEAgY29uZmlnIFBD
SV9FUEZfVklSVElPCj4+Pj4+ICAgICAgICAgICBzZWxlY3QgVkhPU1RfUklOR19JT01FTQo+Pj4+
PiAgICAgICAgICAgaGVscAo+Pj4+PiAgICAgICAgICAgICBIZWxwZXJzIHRvIGltcGxlbWVudCBQ
Q0kgdmlydGlvIEVuZHBvaW50IGZ1bmN0aW9uCj4+Pj4+ICsKPj4+Pj4gK2NvbmZpZyBQQ0lfRVBG
X1ZDT04KPj4+Pj4gKyAgICAgICB0cmlzdGF0ZSAiUENJIEVuZHBvaW50IHZpcml0by1jb25zb2xl
IGRyaXZlciIKPj4+Pj4gKyAgICAgICBkZXBlbmRzIG9uIFBDSV9FTkRQT0lOVAo+Pj4+PiArICAg
ICAgIHNlbGVjdCBWSE9TVF9SSU5HCj4+Pj4+ICsgICAgICAgc2VsZWN0IFBDSV9FUEZfVklSVElP
Cj4+Pj4+ICsgICAgICAgaGVscAo+Pj4+PiArICAgICAgICAgUENJZSBFbmRwb2ludCB2aXJ0aW8t
Y29uc29sZSBmdW5jdGlvbiBpbXBsZW1lbnRhdGluby4gVGhpcyBtb2R1bGUKPj4+Pj4gKyAgICAg
ICAgIGVuYWJsZXMgdG8gc2hvdyB0aGUgdmlydGlvLWNvbnNvbGUgYXMgcGNpIGRldmljZSB0byBQ
Q0llIGhvc3Qgc2lkZSwgYW5kCj4+Pj4+ICsgICAgICAgICBhbm90aGVyIHZpcnR1YWwgdmlydGlv
LWNvbnNvbGUgZGV2aWNlIHJlZ2lzdGVycyB0byBlbmRwb2ludCBzeXN0ZW0uCj4+Pj4+ICsgICAg
ICAgICBUaG9zZSBkZXZpY2VzIGFyZSBjb25uZWN0ZWQgdmlydHVhbGx5IGFuZCBjYW4gY29tbXVu
aWNhdGUgZWFjaCBvdGhlci4KPj4+Pj4gKwo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
ZW5kcG9pbnQvZnVuY3Rpb25zL01ha2VmaWxlIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL01ha2VmaWxlCj4+Pj4+IGluZGV4IGE5NmYxMjdjZTkwMC4uYjQwNTY2ODljZTMzIDEwMDY0
NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUKPj4+
Pj4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL01ha2VmaWxlCj4+Pj4+IEBA
IC03LDMgKzcsNCBAQCBvYmotJChDT05GSUdfUENJX0VQRl9URVNUKSAgICAgICAgICAgICAgKz0g
cGNpLWVwZi10ZXN0Lm8KPj4+Pj4gICAgb2JqLSQoQ09ORklHX1BDSV9FUEZfTlRCKSAgICAgICAg
ICAgICAgKz0gcGNpLWVwZi1udGIubwo+Pj4+PiAgICBvYmotJChDT05GSUdfUENJX0VQRl9WTlRC
KSAgICAgICAgICAgICArPSBwY2ktZXBmLXZudGIubwo+Pj4+PiAgICBvYmotJChDT05GSUdfUENJ
X0VQRl9WSVJUSU8pICAgICAgICAgICArPSBwY2ktZXBmLXZpcnRpby5vCj4+Pj4+ICtvYmotJChD
T05GSUdfUENJX0VQRl9WQ09OKSAgICAgICAgICAgICArPSBwY2ktZXBmLXZjb24ubwo+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmNvbi5j
IGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmNvbi5jCj4+Pj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzFmNDI0N2NkMTBm
Cj4+Pj4+IC0tLSAvZGV2L251bGwKPj4+Pj4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVu
Y3Rpb25zL3BjaS1lcGYtdmNvbi5jCj4+Pj4+IEBAIC0wLDAgKzEsNTk2IEBACj4+Pj4+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+Pj4+PiArLyoKPj4+Pj4gKyAqIFBDSSBF
bmRwb2ludCBmdW5jdGlvbiBkcml2ZXIgdG8gaW1wbGltZW50IHZpcnRpby1jb25zb2xlIGRldmlj
ZQo+Pj4+PiArICogZnVuY3Rpb25hbGl0eS4KPj4+Pj4gKyAqLwo+Pj4+PiArI2luY2x1ZGUgPGxp
bnV4L3BjaS1lcGYuaD4KPj4+Pj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9faWRzLmg+Cj4+Pj4+
ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX3BjaS5oPgo+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L3Zp
cnRpb19jb25zb2xlLmg+Cj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX3JpbmcuaD4KPj4+
Pj4gKwo+Pj4+PiArI2luY2x1ZGUgInBjaS1lcGYtdmlydGlvLmgiCj4+Pj4+ICsKPj4+Pj4gK3N0
YXRpYyBpbnQgdmlydGlvX3F1ZXVlX3NpemUgPSAweDEwMDsKPj4+Pj4gK21vZHVsZV9wYXJhbSh2
aXJ0aW9fcXVldWVfc2l6ZSwgaW50LCAwNDQ0KTsKPj4+Pj4gK01PRFVMRV9QQVJNX0RFU0Modmly
dGlvX3F1ZXVlX3NpemUsICJBIGxlbmd0aCBvZiB2aXJ0cXVldWUiKTsKPj4+Pj4gKwo+Pj4+PiAr
c3RydWN0IGVwZl92Y29uIHsKPj4+Pj4gKyAgICAgICAvKiBUbyBhY2Nlc3MgdmlydHF1ZXVlcyBv
biByZW1vdGUgaG9zdCAqLwo+Pj4+PiArICAgICAgIHN0cnVjdCBlcGZfdmlydGlvIGV2aW87Cj4+
Pj4+ICsgICAgICAgc3RydWN0IHZyaW5naF9raW92ICpyZGV2X2lvdnM7Cj4+Pj4+ICsKPj4+Pj4g
KyAgICAgICAvKiBUbyByZWdpc3RlciBhIGxvY2FsIHZpcnRpbyBidXMgKi8KPj4+Pj4gKyAgICAg
ICBzdHJ1Y3QgdmlydGlvX2RldmljZSB2ZGV2Owo+Pj4+PiArCj4+Pj4+ICsgICAgICAgLyogVG8g
YWNjZXNzIHZpcnRxdWV1cyBvZiBsb2NhbCBob3N0IGRyaXZlciAqLwo+Pj4+PiArICAgICAgIHN0
cnVjdCB2cmluZ2ggKnZkZXZfdnJoczsKPj4+Pj4gKyAgICAgICBzdHJ1Y3QgdnJpbmdoX2tpb3Yg
KnZkZXZfaW92czsKPj4+Pj4gKyAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICoqdmRldl92cXM7Cj4+
Pj4+ICsKPj4+Pj4gKyAgICAgICAvKiBGb3IgdHJhbnNwb3J0YXRpb24gYW5kIG5vdGlmaWNhdGlv
biAqLwo+Pj4+PiArICAgICAgIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp0YXNrX3dxOwo+Pj4+
PiArICAgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCByYWlzZV9pcnFfd29yaywgcnhfd29yaywgdHhf
d29yazsKPj4+Pj4gKwo+Pj4+PiArICAgICAgIC8qIFRvIHJldGFpbiB2aXJ0aW8gZmVhdHVyZXMu
IEl0IGlzIGNvbW1vbmx5IHVzZWQgbG9jYWwgYW5kIHJlbW90ZS4gKi8KPj4+Pj4gKyAgICAgICB1
NjQgZmVhdHVyZXM7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAgICAvKiBUbyBzaG93IGEgc3RhdHVzIHdo
ZXRoZXIgdGhpcyBkcml2ZXIgaXMgcmVhZHkgYW5kIHRoZSByZW1vdGUgaXMgY29ubmVjdGVkICov
Cj4+Pj4+ICsgICAgICAgYm9vbCBjb25uZWN0ZWQ7Cj4+Pj4+ICt9Owo+Pj4+PiArCj4+Pj4+ICtl
bnVtIHsKPj4+Pj4gKyAgICAgICBWQ09OX1ZJUlRRVUVVRV9SWCwKPj4+Pj4gKyAgICAgICBWQ09O
X1ZJUlRRVUVVRV9UWCwKPj4+Pj4gKyAgICAgICAvLyBTaG91bGQgYmUgZW5kIG9mIGVudW0KPj4+
Pj4gKyAgICAgICBWQ09OX1ZJUlRRVUVVRV9OVU0KPj4+Pj4gK307Cj4+Pj4gSXQgd291bGQgYmUg
YmV0dGVyIGlmIHdlIGNhbiBzcGxpdCB0aGUgY29uc29sZSBzcGVjaWZpYyB0aGluZyBvdXQsCj4+
Pj4gdGhlbiBpdCBhbGxvd3MgdXMgdG8gZG8gZXRoZXJuZXQgYW5kIHZzb2NrIGluIHRoZSBmdXR1
cmUuCj4+PiBJJ20gcGxhbm5pbmcgdG8gaW1wbGVtZW50IGVhY2ggdmlydGlvIGRldmljZSBpbiBh
IHNlcGFyYXRlIGZpbGUuCj4+PiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvOTIyMTI0Lwo+Pj4K
Pj4+Cj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+PiBCZXN0IHJlZ2FyZHMsCj4+PiBTaHVuc3VrZQoK
QmVzdCByZWdhcmRzLAoKU2h1bnN1a2UKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
