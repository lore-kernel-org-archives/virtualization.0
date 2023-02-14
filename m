Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C9BC636D4
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 03:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B45140A87;
	Tue, 14 Feb 2023 03:24:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B45140A87
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=SH6A/885
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coBc89DlI2s4; Tue, 14 Feb 2023 03:24:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A27A8400D0;
	Tue, 14 Feb 2023 03:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A27A8400D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76947C0033;
	Tue, 14 Feb 2023 03:24:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4E94C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0B0240A5D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0B0240A5D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kj4hnHQs9I7d
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:24:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65B01400D0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65B01400D0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:24:51 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 n20-20020a17090aab9400b00229ca6a4636so19000070pjq.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 19:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YGMqgl5LW97AfsYc7W+xzShnJuseYgX2N3E9oQfC+t8=;
 b=SH6A/885VYHXN9okhjHo8OtXfA1hRSX8gboZgnc4QaxbNQAAEmXLZErOZatPzAH0Ru
 ZMntbixHRtH50YAENZZjrKrQgCrThfbTwJwiwv8LtUKpgqxkXbA03Fpx9wfZBdsdcPzQ
 o/cfSIEX8EH/7aV+FM1k3ZslVTo0BvdOO7B2sDT0txr0UgUAX/bl2z9nY/cEb6ABB5/8
 FS/UIrLLpP4n6cs3bdynndE2bv04sYfMLTxDmrhlxkIBsp1c+175AyY9TqHs5/kmkNCJ
 uvtg7/Be0XVyZQj9Av1wEZGA8rxLu3bMba6NC9bYM4DlpogeWPsEuD8RNBVnwgxTs9Kv
 wR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGMqgl5LW97AfsYc7W+xzShnJuseYgX2N3E9oQfC+t8=;
 b=cntrQAm1VF2ImeTf2bnQhfO72VyMNWTbt2vjnUyYeW6imANgV72+GZIEyKyXUbdRK2
 rKERkmve5E+tIe2xuLjHionzdfQV/+t1i1vOOdEpWfePL+Ay0wagyKjFrJlGrn8E1k7b
 DPsOuyG9mi1dEf4nKvHYoHK47GF0FhJ24G4iWgz6qMDW8txuYGnWExU3KSJWwChUZEgZ
 ljaxVgR84tZplIkKN6/m5rVEZsAt8sdCxbO/fHz5zZx6nTADujWEaVccfrA+oIhSC+WJ
 JBK0+Gr6+1U89Y/5FB437HPSR5zfZ1guq6I4UJhz4bhiaaBkoyBOmUuHLh/YrW8DXERD
 PLAg==
X-Gm-Message-State: AO0yUKXr49sPXSCx1sy922afxvUnyv0w2v8OSidlxUX3/hdq0L/4pw6c
 Y4L0H5KcWmRT0FE15I3n5UQXQw==
X-Google-Smtp-Source: AK7set+n/OQl8f+Pt808/MeY0liwC8YzfyLLbiOQmoBusBO7Lrudi/iQCUkvtjWFIPnPqiprJbvNCQ==
X-Received: by 2002:a17:902:d102:b0:19a:8284:83a2 with SMTP id
 w2-20020a170902d10200b0019a828483a2mr941860plw.10.1676345090397; 
 Mon, 13 Feb 2023 19:24:50 -0800 (PST)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a1709028a9100b00198e663a856sm8898968plo.205.2023.02.13.19.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Feb 2023 19:24:49 -0800 (PST)
Message-ID: <9f781dc0-e4d5-4c14-cad9-483f59b2a315@igel.co.jp>
Date: Tue, 14 Feb 2023 12:24:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
From: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: PCIe RC\EP virtio rdma solution discussion.
To: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev
References: <20230207194527.4071169-1-Frank.Li@nxp.com>
Content-Language: en-US
In-Reply-To: <20230207194527.4071169-1-Frank.Li@nxp.com>
Cc: kishon@kernel.org, kw@linux.com, taki@igel.co.jp, mani@kernel.org,
 linux-pci@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, renzhijie2@huawei.com,
 jdmason@kudzu.us, bhelgaas@google.com, lpieralisi@kernel.org
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

VGhhbmtzIGZvciBvcmdhbml6aW5nIHRoZSBkaXNjdXNzaW9uLgoKT24gMjAyMy8wMi8wOCA0OjQ1
LCBGcmFuayBMaSB3cm90ZToKPiBGcm9tOiBGcmFuayBMaTxGcmFuay5saUBueHAuY29tPgo+Cj4g
UmVjZW50bHkgbW9yZSBhbmQgbW9yZSBwZW9wbGUgYXJlIGludGVyZXN0ZWQgaW4gUENJIFJDIGFu
ZCBFUCBjb25uZWN0aW9uLAo+IGVzcGVjaWFsbHkgbmV0d29yayB1c2FnZSBjYXNlcy4gSSB1cHN0
cmVhbWVkIGEgdm50YiBzb2x1dGlvbiBsYXN0IHllYXIuCj4gQnV0IHRoZSB0cmFuc2ZlciBzcGVl
ZCBpcyBub3QgZ29vZCBlbm91Z2guIEkgaW5pdGlhbGl6ZWQgYSBkaXNjdXNzaW9uCj4gYXRodHRw
czovL2xvcmUua2VybmVsLm9yZy9pbXgvZDA5OGE2MzEtOTkzMC0yNmQzLTQ4ZjMtOGY5NTM4NmM4
ZTUwQHRpLmNvbS9ULyN0CkkndmUgaW52ZXN0aWdhdGVkIHRoZSB2bnRiICsgbnRibmV0IGRldmlj
ZSB0aGF0IHVzZXMgbnRiIHRyYW5zZmVyLiBJcyBpdApkaWZmaWN1bHQgdG8gYWRhcHQgdGhlIGVE
TUEgdG8gdGhlIG50YiB0cmFuc2Zlcj8gSXQgaXMgbGlrZWx5IG9uZSBvZiB0aGUKc29sdXRpb25z
IGZvciB0aGUgcGVyZm9ybWFuY2UgcHJvYmxlbS4KPiAgIAo+ICAgIOKUjOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkAo+ICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAg4pSCCj4gICAg4pSCICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAg4pSCICAg4pSCICAgICAgICAgICAgICDilIIKPiAgICDilIIg
ICBWaXJ0UXVldWUgICAgICAgICAgICAgUlggICAgICDilIIgICDilIIgIFZpcnRRdWV1ZSAgIOKU
ggo+ICAgIOKUgiAgICAgVFggICAgICAgICAgICAgICAgIOKUjOKUgOKUgOKUkCAgICAg4pSCICAg
4pSCICAgIFRYICAgICAgICDilIIKPiAgICDilIIgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUkCAgICAgICAgICAg4pSCICDilIIgICAgIOKUgiAgIOKUgiDilIzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilJAgIOKUggo+ICAgIOKUgiAg4pSCIFNSQyBMRU4g4pSc4pSA4pSA4pSA
4pSA4pSA4pSQICDilIzilIDilIDilKQgIOKUguKXhOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKU
vOKUgOKUpCBTUkMgTEVOIOKUgiAg4pSCCj4gICAg4pSCICDilJzilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilKQgICAgIOKUgiAg4pSCICDilIIgIOKUgiAgICAg4pSCICAg4pSCIOKUnOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAg4pSCCj4gICAg4pSCICDilIIgICAgICAgICDilIIg
ICAgIOKUgiAg4pSCICDilIIgIOKUgiAgICAg4pSCICAg4pSCIOKUgiAgICAgICAgIOKUgiAg4pSC
Cj4gICAg4pSCICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgIOKUgiAg4pSC
ICDilIIgIOKUgiAgICAg4pSCICAg4pSCIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
pCAg4pSCCj4gICAg4pSCICDilIIgICAgICAgICDilIIgICAgIOKUgiAg4pSCICDilIIgIOKUgiAg
ICAg4pSCICAg4pSCIOKUgiAgICAgICAgIOKUgiAg4pSCCj4gICAg4pSCICDilJTilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilJggICAgIOKUgiAg4pSCICDilJTilIDilIDilJggICAgIOKUgiAg
IOKUgiDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilJggIOKUggo+ICAgIOKUgiAgICAg
ICAgICAgICAgICAgIOKUgiAg4pSCICAgICAgICAgICDilIIgICDilIIgICAgICAgICAgICAgIOKU
ggo+ICAgIOKUgiAgICAgUlggICAgICAg4pSM4pSA4pSA4pSA4pS84pSA4pSA4pSYICAgVFggICAg
ICDilIIgICDilIIgICAgUlggICAgICAgIOKUggo+ICAgIOKUgiAg4pSM4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSQIOKUgiAgIOKUgiAgICAg4pSM4pSA4pSA4pSQICAgICDilIIgICDilIIg
4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICDilIIKPiAgICDilIIgIOKUgiAgICAg
ICAgIOKUguKXhOKUmCAgIOKUlOKUgOKUgOKUgOKUgOKWuuKUgiAg4pSc4pSA4pSA4pSA4pSA4pSA
4pS84pSA4pSA4pSA4pS84pSA4pSkICAgICAgICAg4pSCICDilIIKPiAgICDilIIgIOKUnOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgICAg4pSCICDilIIgICAgIOKUgiAgIOKU
giDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgIOKUggo+ICAgIOKUgiAg4pSCICAg
ICAgICAg4pSCICAgICAgICAgICDilIIgIOKUgiAgICAg4pSCICAg4pSCIOKUgiAgICAgICAgIOKU
giAg4pSCCj4gICAg4pSCICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAg
ICAgIOKUgiAg4pSCICAgICDilIIgICDilIIg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkICDilIIKPiAgICDilIIgIOKUgiAgICAgICAgIOKUgiAgICAgICAgICAg4pSCICDilIIgICAg
IOKUgiAgIOKUgiDilIIgICAgICAgICDilIIgIOKUggo+ICAgIOKUgiAg4pSU4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSYICAgICAgICAgICDilIIgIOKUgiAgICAg4pSCICAg4pSCIOKUlOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAg4pSCCj4gICAg4pSCICAgdmlydGlvX25ldCAg
ICAgICAgICAg4pSU4pSA4pSA4pSYICAgICDilIIgICDilIIgdmlydGlvX25ldCAgIOKUggo+ICAg
IOKUgiAgVmlydHVhbCBQQ0kgQlVTICAgRURNQSBRdWV1ZSAgIOKUgiAgIOKUgiAgICAgICAgICAg
ICAg4pSCCj4gICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkICAg4pSCICAgICAgICAgICAgICDilIIKPiAgICDilIIgIFBDSSBFUCBDb250cm9sbGVyIHdp
dGggZURNQSAgICDilIIgICDilIIgIFBDSSBIb3N0ICAgIOKUggo+ICAgIOKUlOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAgIOKUlOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmAo+Cj4gQmFzaWMgaWRlYSBpcwo+IAkxLglCb3Ro
IEVQIGFuZCBob3N0IHByb2JlIHZpcnRpb19uZXQgZHJpdmVyCj4gCTIuCVRoZXJlIGFyZSB0d28g
cXVldWVzLCAgb25lIGlzIHRoZSBFUCBzaWRlKEVRKSwgIHRoZSBvdGhlciBpcyB0aGUgSG9zdCBz
aWRlLgo+IAkzLglFUCBzaWRlIGVwZiBkcml2ZXIgbWFwIEhvc3Qgc2lkZeKAmXMgcXVldWUgaW50
byBFUOKAmXMgc3BhY2UuIENhbGxlZCBIUS4KPiAJNC4JT25lIHdvcmtpbmcgdGhyZWFkCj4gCTUu
CXBpY2sgb25lIFRYIGZyb20gRVEgYW5kIFJYIGZyb20gSFEsIGNvbWJpbmUgYW5kIGdlbmVyYXRl
IEVETUEgcmVxdWVzdHMsCj4gYW5kIHB1dCBpbnRvIHRoZSBETUEgVFggcXVldWUuCj4gCTYuCVBp
Y2sgb25lIFJYIGZyb20gRVEgYW5kIFRYIGZyb20gSFEsIGNvbWJpbmUgYW5kIGdlbmVyYXRlIEVE
TUEgcmVxdWVzdHMsCj4gYW5kIHB1dCBpbnRvIHRoZSBETUEgUlggcXVldWUuCj4gCTcuCUVETUEg
ZG9uZSBpcnEgd2lsbCBtYXJrIHJlbGF0ZWQgaXRlbSBpbiBFUCBhbmQgSFEgZmluaXNoZWQuCj4K
PiBUaGUgd2hvbGUgdHJhbnNmZXIgaXMgemVybyBjb3BpZWQgYW5kIHVzZXMgYSBETUEgcXVldWUu
Cj4KPiBUaGUgU2h1bnN1a2UgTWllIGltcGxlbWVudGVkIHRoZSBhYm92ZSBpZGVhLgo+ICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpL0NBTlh2dDVxX3FnTHVBZkY3ZHh4cnFVaXJU
X0xkNEI9UE9DcThKY0I5dVBSdkNHRGlLZ0BtYWlsLmdtYWlsLmNvbS9ULyN0Cj4KPgo+IFNpbWls
YXIgc29sdXRpb24gcG9zdGVkIGF0IDIwMTksIGV4Y2VwdCB1c2UgbWVtY3B5IGZyb20vdG8gUENJ
IEVQIG1hcCB3aW5kb3dzLgo+IFVzaW5nIERNQSBzaG91bGQgYmUgc2ltcGxlciBiZWNhdXNlIEVE
TUEgY2FuIGFjY2VzcyB0aGUgd2hvbGUgSE9TVFxFUCBzaWRlIG1lbW9yeSBzcGFjZS4KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvOWY4ZTU5NmYtYjYwMS03Zjk3LWE5OGEtMTEx
NzYzZjk2NmQxQHRpLmNvbS9ULwo+Cj4gU29sdXRpb24gMSAoQmFzZWQgb24gc2h1bnN1a2UpOgo+
Cj4gQm90aCBFUCBhbmQgSG9zdCBzaWRlIHVzZSB2aXJ0aW8uCj4gVXNpbmcgRURNQSB0byBzaW1w
bGlmeSBkYXRhIHRyYW5zZmVyIGFuZCBpbXByb3ZlIHRyYW5zZmVyIHNwZWVkLgo+IFJETUEgaW1w
bGVtZW50IGJhc2VkIG9uIFJvQ0UKPiAtIHByb3Bvc2FsOmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIyMDUxMTA5NTkwMC4zNDMtMS14aWV5b25namlAYnl0ZWRhbmNlLmNvbS9ULwo+IC0g
cHJlc2VudGF0aW9uIG9uIGt2bSBmb3J1bTpodHRwczovL3lvdXR1LmJlL1FyaHY2aENfWUs0Cj4K
PiBTb2x1dGlvbiAyKDIwMjAsIEtpc2hvbikKPgo+IFByZXZpb3VzaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtcGNpLzIwMjAwNzAyMDgyMTQzLjI1MjU5LTEta2lzaG9uQHRpLmNvbS8KPiBF
UCBzaWRlIHVzZSB2aG9zdCwgUkMgc2lkZSB1c2UgdmlydGlvLgo+IEkgZG9u4oCZdCB0aGluayBh
bnlvbmUgd29ya3Mgb24gdGhpcyB0aHJlYWQgbm93Lgo+IElmIHVzaW5nIGVETUEsIGl0IG5lZWRz
IGJvdGggc2lkZXMgdG8gaGF2ZSBhIHRyYW5zZmVyIHF1ZXVlLgo+IEkgZG9uJ3Qga25vdyBob3cg
dG8gZWFzaWx5IGltcGxlbWVudCBpdCBvbiB0aGUgdmhvc3Qgc2lkZS4KV2UgaGFkIGltcGxlbWVu
dGVkIHRoaXMgc29sdXRpb24gYXQgdGhlIGRlc2lnbiBzdGFnZSBvZiBvdXIgcHJvcG9zYWwuClRo
aXMgc29sdXRpb24gaGFzIHRvIHByZXBhcmUgYSBuZXR3b3JrIGRldmljZSBhbmQgcmVnaXN0ZXIg
dG8gdGhlIGtlcm5lbApmcm9tIHNjcmF0Y2ggZm9yIHRoZSBlbmRwb2ludC4gVGhlcmUgaXMgYSBs
b3Qgb2YgZHVwbGljYXRlZCBjb2RlLCBzbyB3ZQp0aGluayB0aGUgc29sdXRpb24gMSBpcyBiZXR0
ZXIsIGFzIEZyYW5rIHNhaWQuCj4gU29sdXRpb24gMyhJIGFtIHdvcmtpbmcgb24pCj4KPiBJbXBs
ZW1lbnQgaW5maW5pYmFuZCByZG1hIGRyaXZlciBhdCBib3RoIEVQIGFuZCBSQyBzaWRlLgo+IEVQ
IHNpZGUgYnVpbGQgRURNQSBoYXJkd2FyZSBxdWV1ZSBiYXNlZCBvbiBFUC9SQyBzaWRl4oCZcyBz
ZW5kIGFuZCByZWNlaXZlCj4gcXVldWUgYW5kIHdoZW4gZURNQSBmaW5pc2hlZCwgd3JpdGUgc3Rh
dHVzIHRvIGNvbXBsZXRlIHF1ZXVlIGZvciBib3RoIEVQL1JDCj4gc2lkZS4gVXNlIGlwb2liIGlt
cGxlbWVudCBuZXR3b3JrIHRyYW5zZmVyLgpUaGUgbmV3IEluZmluaUJhbmQgZGV2aWNlIGhhcyB0
byBpbXBsZW1lbnQgYW4gSW5maW5pQmFuZCBuZXR3b3JrIGxheWVyLgpJIHRoaW5rIGl0IGlzIG92
ZXJlbmdpbmVlcmVkIGZvciB0aGlzIHBlZXItdG8tcGVlciBjb21tdW5pY2F0aW9uLiBJbgphZGRp
dGlvbiwgdGhlIGRyaXZlciBvZiB0aGUgSW5maW5pQmFuZCBkZXZpY2Ugc2hvdWxkIGJlIGltcGxl
bWVudGVkIG9yCmVtdWxhdGUgdGhlIGV4aXN0aW5nIEluZmluaUJhbmQgZGV2aWNlIHRvIHVzZSB0
aGUgdXBzdHJlYW0gZHJpdmVyLiBXZQp3YW50IHRvIHJlZHVjZSB0aGUgY29zdCBvZiBpbXBsZW1l
bnRhdGlvbiBhbmQgbWFpbnRlbmFuY2UuCj4gVGhlIHdob2xlIHVwc3RyZWFtIGVmZm9ydCBpcyBx
dWl0ZSBodWdlIGZvciB0aGVzZS4gSSBkb27igJl0IHdhbnQgdG8gd2FzdGUKPiB0aW1lIGFuZCBl
ZmZvcnRzIGJlY2F1c2UgZGlyZWN0aW9uIGlzIHdyb25nLgo+Cj4gSSB0aGluayBTb2x1dGlvbiAx
IGlzIGFuIGVhc3kgcGF0aC4KPgo+Cj4KQmVzdCwKClNodW5zdWtlLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
