Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5182EC7EE2C
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 09:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9D8460EF4;
	Thu, 18 May 2023 09:54:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9D8460EF4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=oa56e/cO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R6_lMaP8Tp4s; Thu, 18 May 2023 09:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F0A660A61;
	Thu, 18 May 2023 09:54:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F0A660A61
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 449E2C0035;
	Thu, 18 May 2023 09:54:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40AEAC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A5C6416C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:54:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A5C6416C6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=oa56e/cO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h3cm0joZDN4Y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:54:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B086D4173F
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B086D4173F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:54:33 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6434e65d808so1797614b3a.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1684403673; x=1686995673;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wt78fUxV6LOew5dfjUF3WMm8EbNEfc8NoopwolgUsm4=;
 b=oa56e/cOFzouJJv0/MzasDsZCTvPgTaB7sJCEQvT0wP/eycS8LqxRbFSmGBHFcW/Yq
 Pwv7SlrXHAGE59pwj9hnqdqU7DpahBba+IByjlAPLS1zUdYSkJcYUpMUSosYJ3Lu5uB9
 CDKTb4GxrgeG5GpL6s/9AfD0UA0vnb7N4XzTazYWjs9BY1tLyUFC4qMBLhLUVjk2JPgB
 nMskIF5V7Yja08OJ8yxnmF2EFh0RpY4ntmNWK2sbo9f+wo61nMXezi0/kPgo3n9KcTTh
 o/5xbZfbWEvLkr6Nf8y79uiYypC2sHNc9A/mDzgt5M6SupbpWyL8NVHk8ERp7kCSaQUO
 enng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684403673; x=1686995673;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wt78fUxV6LOew5dfjUF3WMm8EbNEfc8NoopwolgUsm4=;
 b=hdkTbIlfyeZX/93fNZOwhAvPrZ4+75H32oZ93e1zQ17aygo6c978E9usAHRdNaFIb6
 3HahaqcxKYuKHVtJu1O66THWCOh2I/U6d3Xq8qrNp4x6S+V+DCkK8uYy0MOocf3/nVfv
 OzlSwwdWvu7beNXUAp7oqQ7QGuohmnSGS7uMwEL8KvZBpomyBx38eRwq8yIjsQhtFkf7
 ohSPf50TBS1OjSB7+VKaeHX9DiGFonGYAaRgxR/rVgF/QP4ODhyJYrUl34BbwPBR7SfQ
 BJ8e6xlDsEXF+U8zYDid8DZjcAdUHftNptst6EL/vQLigA8u6hnqdt4C+pmKP4kCsF7G
 g9Cw==
X-Gm-Message-State: AC+VfDwl0pwl57Jd6ebZ0JFfHduLaD6aJ15T05Cmrq1kvoJhSjdzDydA
 vvAaW1Bhf2fP7YH2R5rLjM/ZIQ==
X-Google-Smtp-Source: ACHHUZ5Y/5eVpiIq2BE9YtPYSYOpfkKx54IPVaQdjI3ksPbZmzoFIpZ5xJQw09lbxNUw1uhpMhr97w==
X-Received: by 2002:a05:6a20:8e1c:b0:109:c500:376c with SMTP id
 y28-20020a056a208e1c00b00109c500376cmr256819pzj.12.1684403672718; 
 Thu, 18 May 2023 02:54:32 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 x53-20020a056a000bf500b0063d3801d196sm996774pfu.23.2023.05.18.02.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 02:54:32 -0700 (PDT)
Message-ID: <ad3dd4ef-3489-683c-c9e1-2592621687f7@igel.co.jp>
Date: Thu, 18 May 2023 18:54:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
Content-Language: en-US
From: Shunsuke Mie <mie@igel.co.jp>
To: Jason Wang <jasowang@redhat.com>
References: <20230427104428.862643-1-mie@igel.co.jp>
 <20230427104428.862643-4-mie@igel.co.jp>
 <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
 <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com>
In-Reply-To: <CANXvt5r7eha_xnExsdS_4yMW8xTJxVzYhMVrXyQkGQe-_ZURBg@mail.gmail.com>
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

R2VudGxlIHBpbmcgLi4uCgoKVGhhbmtzLAoKU2h1bnN1a2UuCgpPbiAyMDIzLzA1LzEwIDEyOjE3
LCBTaHVuc3VrZSBNaWUgd3JvdGU6Cj4gSGkgSnNvbiwKPiAyMDIz5bm0NeaciDjml6Uo5pyIKSAx
MzowMyBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjoKPj4gT24gVGh1LCBBcHIgMjcs
IDIwMjMgYXQgNjo0NOKAr1BNIFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+IHdyb3RlOgo+
Pj4gQWRkIGEgbmV3IFBDSWUgZW5kcG9pbnQgZnVuY3Rpb24gZHJpdmVyIHRoYXQgd29ya3MgYXMg
YSBwY2kgdmlydGlvLWNvbnNvbGUKPj4+IGRldmljZS4gVGhlIGNvbnNvbGUgY29ubmVjdCB0byBl
bmRwb2ludCBzaWRlIGNvbnNvbGUuIEl0IGVuYWJsZXMgdG8KPj4+IGNvbW11bmljYXRlIFBDSWUg
aG9zdCBhbmQgZW5kcG9pbnQuCj4+Pgo+Pj4gQXJjaGl0ZWN0dXJlIGlzIGZvbGxvd2luZzoKPj4+
Cj4+PiAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgICAg
IOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkAo+
Pj4gICDilIJ2aXJ0aW9lICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg
4pSCdmlydGlvICAgICAg4pSCCj4+PiAgIOKUgmNvbnNvbGUgZHJ2IOKUgiAgICAgICAgIOKUnOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgIOKUgmNv
bnNvbGUgZHJ2IOKUggo+Pj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilKQgICAgICAgICDilIIodmlydGlvIGNvbnNvbGXilIIgICAgICDilJzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilKQKPj4+ICAg4pSCIHZpcnRpbyBidXMg4pSCICAgICAg
ICAg4pSCIGRldmljZSkgICAgICAg4pSC4peE4pSA4pSA4pSA4pSA4pa64pSCIHZpcnRpbyBidXMg
4pSCCj4+PiAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAg
ICAgIOKUnC0tLS0tLS0tLS0tLS0tLeKUpCAgICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUpAo+Pj4gICDilIIgICAgICAgICAgICDilIIgICAgICAgICDilIIgcGNp
IGVwIHZpcnRpbyDilIIgICAgICAgICAgICAgICAgICAg4pSCCj4+PiAgIOKUgiAgcGNpIGJ1cyAg
IOKUgiAgICAgICAgIOKUgiAgY29uc29sZSBkcnYgIOKUgiAgICAgICAgICAgICAgICAgICDilIIK
Pj4+ICAg4pSCICAgICAgICAgICAg4pSCICBwY2llICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkICAgICAgICAgICAgICAgICAgIOKUggo+Pj4gICDi
lIIgICAgICAgICAgICDilIIg4peE4pSA4pSA4pSA4pSA4pSA4pa6IOKUgiAgcGNpIGVwIEJ1cyAg
IOKUgiAgICAgICAgICAgICAgICAgICDilIIKPj4+ICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSYICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYCj4+PiAgICAgUENJZSBSb290ICAgICAgICAgICAgICBQ
Q0llIEVuZHBvaW50Cj4+Pgo+PiBJIHRoaW5rIGl0IG1pZ2h0IG9ubHkgd29ya3MgZm9yIHBlZXIg
ZGV2aWNlcyBsaWtlOgo+Pgo+PiBuZXQsIGNvbnNvbGUgb3IgdnNvY2suCj4gQ291bGQgeW91IHRl
bGwgbWUgd2hhdCAicGVlciBkZXZpY2VzIiBtZWFucz8KPgo+PiBTbyB0aGVyZSdyZSBtYW55IGNo
b2ljZXMgaGVyZSwgSSdkIGxpa2UgdG8ga25vdyB3aGF0J3MgdGhlIHJlYXNvbiBmb3IKPj4geW91
IHRvIGltcGxlbWVudCBhIG1lZGlhdGlvbi4KPj4KPj4gQW4gYWx0ZXJuYXRpdmUgaXMgdG8gaW1w
bGVtZW50IGEgZGVkaWNhdGVkIG5ldCwgY29uc29sZSBhbmQgdnNvY2sKPj4gZHJpdmVyIGZvciB2
cmluZ2ggKENBSUYgc29tZWhvdyB3b3JrcyBsaWtlIHRoaXMpLiBUaGlzIHdvdWxkIGhhdmUKPj4g
YmV0dGVyIHBlcmZvcm1hbmNlLgo+IERvZXMgaXQgbWVhbiB0aGF0IHRoZSBkcml2ZXIgYWxzbyBm
dW5jdGlvbnMgYXMgYSBuZXR3b3JrIGRyaXZlciBkaXJlY3RseT8KPj4KPj4+IFRoaXMgZHJpdmVy
IGhhcyB0d28gcm9sZXMuIFRoZSBmaXJzdCBpcyBhcyBhIFBDSWUgZW5kcG9pbnQgdmlydGlvIGNv
bnNvbGUKPj4+IGZ1bmN0aW9uLCB3aGljaCBpcyBpbXBsZW1lbnRlZCB1c2luZyB0aGUgUENJZSBl
bmRwb2ludCBmcmFtZXdvcmsgYW5kIFBDSWUKPj4+IEVQIHZpcnRpbyBoZWxwZXJzLiBUaGUgc2Vj
b25kIGlzIGFzIGEgdmlydHVhbCB2aXJ0aW8gY29uc29sZSBkZXZpY2UKPj4+IGNvbm5lY3RlZCB0
byB0aGUgdmlydGlvIGJ1cyBvbiBQQ0llIGVuZHBvaW50IExpbnV4Lgo+Pj4KPj4+IENvbW11bmlj
YXRpb24gYmV0d2VlbiB0aGUgdHdvIGlzIGFjaGlldmVkIGJ5IGNvcHlpbmcgdGhlIHZpcnRxdWV1
ZSBkYXRhCj4+PiBiZXR3ZWVuIFBDSWUgcm9vdCBhbmQgZW5kcG9pbnQsIHJlc3BlY3RpdmVseS4K
Pj4+Cj4+PiBUaGlzIGlzIGEgc2ltcGxlIGltcGxlbWVudGF0aW9uIGFuZCBkb2VzIG5vdCBpbmNs
dWRlIGZlYXR1cmVzIG9mCj4+PiB2aXJ0aW8tY29uc29sZSBzdWNoIGFzIE1VTFRJUE9SVCwgRU1F
UkdfV1JJVEUsIGV0Yy4gQXMgYSByZXN1bHQsIGVhY2gKPj4+IHZpcnRpbyBjb25zb2xlIGRyaXZl
ciBvbmx5IGRpc3BsYXlzIC9kZXYvaHZjMC4KPj4+Cj4+PiBBcyBhbiBleGFtcGxlIG9mIHVzYWdl
LCBieSBzZXR0aW5nIGdldHR5IHRvIC9kZXYvaHZjMCwgaXQgaXMgcG9zc2libGUgdG8KPj4+IGxv
Z2luIHRvIGFub3RoZXIgaG9zdC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBNaWUg
PG1pZUBpZ2VsLmNvLmpwPgo+Pj4gLS0tCj4+PiBDaGFuZ2VzIGZyb20gdjI6Cj4+PiAtIENoYW5n
ZSB0byB1c2UgY29weSBmdW5jdGlvbnMgYmV0d2VlbiBraW92cyBvZiBwY2ktZXBmLXZpcnRpby4K
Pj4+Cj4+PiAgIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnICAgICAgICB8
ICAxMiArCj4+PiAgIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9NYWtlZmlsZSAgICAg
ICB8ICAgMSArCj4+PiAgIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZj
b24uYyB8IDU5NiArKysrKysrKysrKysrKysrKysKPj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2MDkg
aW5zZXJ0aW9ucygrKQo+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9p
bnQvZnVuY3Rpb25zL3BjaS1lcGYtdmNvbi5jCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVu
Y3Rpb25zL0tjb25maWcKPj4+IGluZGV4IGZhMWE2YTU2OWE4Zi4uOWNlMjY5OGI2N2UxIDEwMDY0
NAo+Pj4gLS0tIGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL0tjb25maWcKPj4+ICsr
KyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnCj4+PiBAQCAtNDQsMyAr
NDQsMTUgQEAgY29uZmlnIFBDSV9FUEZfVklSVElPCj4+PiAgICAgICAgICBzZWxlY3QgVkhPU1Rf
UklOR19JT01FTQo+Pj4gICAgICAgICAgaGVscAo+Pj4gICAgICAgICAgICBIZWxwZXJzIHRvIGlt
cGxlbWVudCBQQ0kgdmlydGlvIEVuZHBvaW50IGZ1bmN0aW9uCj4+PiArCj4+PiArY29uZmlnIFBD
SV9FUEZfVkNPTgo+Pj4gKyAgICAgICB0cmlzdGF0ZSAiUENJIEVuZHBvaW50IHZpcml0by1jb25z
b2xlIGRyaXZlciIKPj4+ICsgICAgICAgZGVwZW5kcyBvbiBQQ0lfRU5EUE9JTlQKPj4+ICsgICAg
ICAgc2VsZWN0IFZIT1NUX1JJTkcKPj4+ICsgICAgICAgc2VsZWN0IFBDSV9FUEZfVklSVElPCj4+
PiArICAgICAgIGhlbHAKPj4+ICsgICAgICAgICBQQ0llIEVuZHBvaW50IHZpcnRpby1jb25zb2xl
IGZ1bmN0aW9uIGltcGxlbWVudGF0aW5vLiBUaGlzIG1vZHVsZQo+Pj4gKyAgICAgICAgIGVuYWJs
ZXMgdG8gc2hvdyB0aGUgdmlydGlvLWNvbnNvbGUgYXMgcGNpIGRldmljZSB0byBQQ0llIGhvc3Qg
c2lkZSwgYW5kCj4+PiArICAgICAgICAgYW5vdGhlciB2aXJ0dWFsIHZpcnRpby1jb25zb2xlIGRl
dmljZSByZWdpc3RlcnMgdG8gZW5kcG9pbnQgc3lzdGVtLgo+Pj4gKyAgICAgICAgIFRob3NlIGRl
dmljZXMgYXJlIGNvbm5lY3RlZCB2aXJ0dWFsbHkgYW5kIGNhbiBjb21tdW5pY2F0ZSBlYWNoIG90
aGVyLgo+Pj4gKwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9u
cy9NYWtlZmlsZSBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9NYWtlZmlsZQo+Pj4g
aW5kZXggYTk2ZjEyN2NlOTAwLi5iNDA1NjY4OWNlMzMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUKPj4+ICsrKyBiL2RyaXZlcnMvcGNpL2Vu
ZHBvaW50L2Z1bmN0aW9ucy9NYWtlZmlsZQo+Pj4gQEAgLTcsMyArNyw0IEBAIG9iai0kKENPTkZJ
R19QQ0lfRVBGX1RFU1QpICAgICAgICAgICAgICArPSBwY2ktZXBmLXRlc3Qubwo+Pj4gICBvYmot
JChDT05GSUdfUENJX0VQRl9OVEIpICAgICAgICAgICAgICArPSBwY2ktZXBmLW50Yi5vCj4+PiAg
IG9iai0kKENPTkZJR19QQ0lfRVBGX1ZOVEIpICAgICAgICAgICAgICs9IHBjaS1lcGYtdm50Yi5v
Cj4+PiAgIG9iai0kKENPTkZJR19QQ0lfRVBGX1ZJUlRJTykgICAgICAgICAgICs9IHBjaS1lcGYt
dmlydGlvLm8KPj4+ICtvYmotJChDT05GSUdfUENJX0VQRl9WQ09OKSAgICAgICAgICAgICArPSBw
Y2ktZXBmLXZjb24ubwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0
aW9ucy9wY2ktZXBmLXZjb24uYyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2kt
ZXBmLXZjb24uYwo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uMzFmNDI0N2NkMTBmCj4+PiAtLS0gL2Rldi9udWxsCj4+PiArKysgYi9kcml2ZXJzL3BjaS9l
bmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12Y29uLmMKPj4+IEBAIC0wLDAgKzEsNTk2IEBACj4+
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4+ICsvKgo+Pj4gKyAqIFBD
SSBFbmRwb2ludCBmdW5jdGlvbiBkcml2ZXIgdG8gaW1wbGltZW50IHZpcnRpby1jb25zb2xlIGRl
dmljZQo+Pj4gKyAqIGZ1bmN0aW9uYWxpdHkuCj4+PiArICovCj4+PiArI2luY2x1ZGUgPGxpbnV4
L3BjaS1lcGYuaD4KPj4+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX2lkcy5oPgo+Pj4gKyNpbmNs
dWRlIDxsaW51eC92aXJ0aW9fcGNpLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19jb25z
b2xlLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19yaW5nLmg+Cj4+PiArCj4+PiArI2lu
Y2x1ZGUgInBjaS1lcGYtdmlydGlvLmgiCj4+PiArCj4+PiArc3RhdGljIGludCB2aXJ0aW9fcXVl
dWVfc2l6ZSA9IDB4MTAwOwo+Pj4gK21vZHVsZV9wYXJhbSh2aXJ0aW9fcXVldWVfc2l6ZSwgaW50
LCAwNDQ0KTsKPj4+ICtNT0RVTEVfUEFSTV9ERVNDKHZpcnRpb19xdWV1ZV9zaXplLCAiQSBsZW5n
dGggb2YgdmlydHF1ZXVlIik7Cj4+PiArCj4+PiArc3RydWN0IGVwZl92Y29uIHsKPj4+ICsgICAg
ICAgLyogVG8gYWNjZXNzIHZpcnRxdWV1ZXMgb24gcmVtb3RlIGhvc3QgKi8KPj4+ICsgICAgICAg
c3RydWN0IGVwZl92aXJ0aW8gZXZpbzsKPj4+ICsgICAgICAgc3RydWN0IHZyaW5naF9raW92ICpy
ZGV2X2lvdnM7Cj4+PiArCj4+PiArICAgICAgIC8qIFRvIHJlZ2lzdGVyIGEgbG9jYWwgdmlydGlv
IGJ1cyAqLwo+Pj4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSB2ZGV2Owo+Pj4gKwo+Pj4g
KyAgICAgICAvKiBUbyBhY2Nlc3MgdmlydHF1ZXVzIG9mIGxvY2FsIGhvc3QgZHJpdmVyICovCj4+
PiArICAgICAgIHN0cnVjdCB2cmluZ2ggKnZkZXZfdnJoczsKPj4+ICsgICAgICAgc3RydWN0IHZy
aW5naF9raW92ICp2ZGV2X2lvdnM7Cj4+PiArICAgICAgIHN0cnVjdCB2aXJ0cXVldWUgKip2ZGV2
X3ZxczsKPj4+ICsKPj4+ICsgICAgICAgLyogRm9yIHRyYW5zcG9ydGF0aW9uIGFuZCBub3RpZmlj
YXRpb24gKi8KPj4+ICsgICAgICAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKnRhc2tfd3E7Cj4+
PiArICAgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCByYWlzZV9pcnFfd29yaywgcnhfd29yaywgdHhf
d29yazsKPj4+ICsKPj4+ICsgICAgICAgLyogVG8gcmV0YWluIHZpcnRpbyBmZWF0dXJlcy4gSXQg
aXMgY29tbW9ubHkgdXNlZCBsb2NhbCBhbmQgcmVtb3RlLiAqLwo+Pj4gKyAgICAgICB1NjQgZmVh
dHVyZXM7Cj4+PiArCj4+PiArICAgICAgIC8qIFRvIHNob3cgYSBzdGF0dXMgd2hldGhlciB0aGlz
IGRyaXZlciBpcyByZWFkeSBhbmQgdGhlIHJlbW90ZSBpcyBjb25uZWN0ZWQgKi8KPj4+ICsgICAg
ICAgYm9vbCBjb25uZWN0ZWQ7Cj4+PiArfTsKPj4+ICsKPj4+ICtlbnVtIHsKPj4+ICsgICAgICAg
VkNPTl9WSVJUUVVFVUVfUlgsCj4+PiArICAgICAgIFZDT05fVklSVFFVRVVFX1RYLAo+Pj4gKyAg
ICAgICAvLyBTaG91bGQgYmUgZW5kIG9mIGVudW0KPj4+ICsgICAgICAgVkNPTl9WSVJUUVVFVUVf
TlVNCj4+PiArfTsKPj4gSXQgd291bGQgYmUgYmV0dGVyIGlmIHdlIGNhbiBzcGxpdCB0aGUgY29u
c29sZSBzcGVjaWZpYyB0aGluZyBvdXQsCj4+IHRoZW4gaXQgYWxsb3dzIHVzIHRvIGRvIGV0aGVy
bmV0IGFuZCB2c29jayBpbiB0aGUgZnV0dXJlLgo+IEknbSBwbGFubmluZyB0byBpbXBsZW1lbnQg
ZWFjaCB2aXJ0aW8gZGV2aWNlIGluIGEgc2VwYXJhdGUgZmlsZS4KPiBodHRwczovL2x3bi5uZXQv
QXJ0aWNsZXMvOTIyMTI0Lwo+Cj4KPgo+PiBUaGFua3MKPj4KPiBCZXN0IHJlZ2FyZHMsCj4gU2h1
bnN1a2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
