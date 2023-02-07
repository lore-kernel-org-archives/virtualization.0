Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58DFC636CD
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 10:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55253405D8;
	Tue,  7 Feb 2023 10:29:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55253405D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=cRO+42/d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJ5sAingo3bt; Tue,  7 Feb 2023 10:29:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B842B4056D;
	Tue,  7 Feb 2023 10:29:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B842B4056D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77B3CC0032;
	Tue,  7 Feb 2023 10:29:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43B1EC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17C6F813D9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17C6F813D9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=cRO+42/d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ux0QM933X3uZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:29:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04C63813CE
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04C63813CE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:29:18 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id ch22so430447uab.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UommVTJaXxWIOJAZoy5o/EUG5Ks0hfVT9tU2NEiYwdg=;
 b=cRO+42/de4Uh+pv3kGZRiBlNDQQKw1ggRGvdLr4DzdWX8ivcamZ816SOkZdGPE7K+k
 qAa5EsnzSgpxuxOU67xVCuJaKaOPlOF6ugte1Ho2+BEgHMOh+VQ3mdtAtHXWVK5UWVdy
 F0jNhXPJokBM000pywFXhmPQoxWNIloTyvnaVpAQQjkpxYSJCIVs/dE+Qvuq8FwYpqO7
 OByedRC3nPh5LZwhIAWELfTxyPc03qEu1Kd2oBinjuplsn4FtI3Et4kzu64Uqlzam+gK
 SsfiPlsJSLCpO+it5mCwJlh1vzQHzQQmOrz1fyZFrh9H6x/Y26kjZ1BFpNpbVUT/5xJm
 5FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UommVTJaXxWIOJAZoy5o/EUG5Ks0hfVT9tU2NEiYwdg=;
 b=xmTVvYBQiA/mFVAOfVL2rz2K/TulzC4ft303fRI9+yZWcQSTTtZO8FMDPtJ4gtRmO3
 KUspv+yk7yisNq1SXLNDuE+kQqizUqsrbAYYfheSg4j1T6AgshlKXUDkW6Sd+9FPvJ9z
 YGtBZ10b6CgKB4zz05lmau+GzBND9armDJbEFD+3wed9K2lxtATkQRuTvVLaoby/zxXQ
 foW5Z9TM3dojh+NNKalaUTFIEP4kuzTDbbTx4dWppUIOAlUTCwE7fWiM26H/YFNONxlq
 gGLDEt4r3RbtdLLDUgZZdSE2FtyM92AijHciyYFcruuC/T/HZ/Lxm5hWzH2qFxwYlDF4
 Qllg==
X-Gm-Message-State: AO0yUKXWRcXcbPWN12dJAeacAfPCJ3cgqV4T4NZObJIYtHQX+2+XMM+/
 KVXn1SzYkCvQw9IzEaVWGnS7XT4zYwJXyavwWuuaAg==
X-Google-Smtp-Source: AK7set+vtrzOIUPt3cNy80cmjiPZQoeNH2N8CM9SSDLoBn+2JNI5eWx2e2HNyMEkuQbDC+qeDS5zvamAOgoG3U7qoDs=
X-Received: by 2002:ab0:3749:0:b0:669:f7f:882f with SMTP id
 i9-20020ab03749000000b006690f7f882fmr446807uat.54.1675765757774; Tue, 07 Feb
 2023 02:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 7 Feb 2023 19:29:06 +0900
Message-ID: <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
To: Frank Li <frank.li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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

MjAyM+W5tDLmnIg05pelKOWcnykgMTo0NSBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT46Cj4K
Pgo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gRnJvbTogU2h1bnN1a2UgTWll
IDxtaWVAaWdlbC5jby5qcD4KPiA+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMywgMjAyMyA0OjA0
IEFNCj4gPiBUbzogTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz4KPiA+
IENjOiBLcnp5c3p0b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IE1hbml2YW5uYW4gU2Fk
aGFzaXZhbQo+ID4gPG1hbmlAa2VybmVsLm9yZz47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtp
c2hvbkBrZXJuZWwub3JnPjsgQmpvcm4KPiA+IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+
OyBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsKPiA+IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+OyBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPjsKPiA+IEZy
YW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgSm9uIE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPjsg
UmVuIFpoaWppZQo+ID4gPHJlbnpoaWppZTJAaHVhd2VpLmNvbT47IFRha2FuYXJpIEhheWFtYSA8
dGFraUBpZ2VsLmNvLmpwPjsgbGludXgtCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC0KPiA+IGZv
dW5kYXRpb24ub3JnCj4gPiBTdWJqZWN0OiBbRVhUXSBbUkZDIFBBVENIIDAvNF0gUENJOiBlbmRw
b2ludDogSW50cm9kdWNlIGEgdmlydGlvLW5ldCBFUAo+ID4gZnVuY3Rpb24KPiA+Cj4gPiBDYXV0
aW9uOiBFWFQgRW1haWwKPiA+Cj4gPiBUaGlzIHBhdGNoc2V0IGludHJvZHVjZSBhIHZpcnRpby1u
ZXQgRVAgZGV2aWNlIGZ1bmN0aW9uLiBJdCBwcm92aWRlcyBhCj4gPiBuZXcgb3B0aW9uIHRvIGNv
bW11bmlhdGUgYmV0d2VlbiBQQ0llIGhvc3QgYW5kIGVuZHBvaW50IG92ZXIgSVAuCj4gPiBBZHZh
bnRhZ2Ugb2YgdGhpcyBvcHRpb24gaXMgdGhhdCB0aGUgZHJpdmVyIGZ1bGx5IHVzZXMgYSBQQ0ll
IGVtYmVkZGVkIERNQS4KPiA+IEl0IGlzIHVzZWQgdG8gdHJhbnNwb3J0IGRhdGEgYmV0d2VlbiB2
aXJ0aW8gcmluZyBkaXJlY3RseSBlYWNoIG90aGVyLiBJdAo+ID4gY2FuIGJlIGV4cGVjdGVkIHRv
IGJldHRlciB0aHJvdWdocHV0Lgo+Cj4gVGhhbmtzLCBiYXNpYyB0aGF0J3Mgd2hhdCBJIHdhbnQu
ICBJIGFtIHRyeWluZyB1c2UgUkRNQS4KPiBCdXQgSSB0aGluayB2aXJ0aW8tbmV0IHN0aWxsIGJl
IGdvb2Qgc29sdXRpb24uCldlIHByb2plY3QgZXh0ZW5kaW5nIHRoaXMgbW9kdWxlIHRvIHN1cHBv
cnQgUkRNQS4gVGhlIHBsYW4gaXMgYmFzZWQgb24KdmlydGlvLXJkbWFbMV0uCkl0IGV4dGVuZHMg
dGhlIHZpcnRpby1uZXQgYW5kIHdlIGFyZSBwbGFuIHRvIGltcGxlbWVudCB0aGUgcHJvcG9zZWQK
c3BlYyBiYXNlZCBvbiB0aGlzIHBhdGNoLgpbMV0gdmlydGlvLXJkbWEKLSBwcm9wb3NhbDoKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNTExMDk1OTAwLjM0My0xLXhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tL1QvCi0gcHJlc2VudGF0aW9uIG9uIGt2bSBmb3J1bToKaHR0cHM6Ly95b3V0
dS5iZS9Rcmh2NmhDX1lLNAoKUGxlYXNlIGZlZWwgZnJlZSB0byBjb21tZW50IGFuZCBzdWdnZXN0
Lgo+IEZyYW5rIExpCj4KPiA+Cj4gPiBUbyByZWFsaXplIHRoZSBmdW5jdGlvbiwgdGhpcyBwYXRj
aHNldCBoYXMgZmV3IGNoYW5nZXMgYW5kIGludHJvZHVjZXMgYQo+ID4gbmV3IEFQSXMgdG8gUENJ
IEVQIGZyYW1ld29yayByZWxhdGVkIHRvIHZpcnRpby4gRnVydGhlcm1vcmUsIGl0IGRldmljZQo+
ID4gZGVwZW5kcyBvbiB0aGUgc29tZSBwYXRjaHRlcyB0aGF0IGlzIGRpc2N1c3NpbmcuIFRob3Nl
IGRlcGVuZGVkIHBhdGNoc2V0Cj4gPiBhcmUgZm9sbG93aW5nOgo+ID4gLSBbUEFUQ0ggMS8yXSBk
bWFlbmdpbmU6IGR3LWVkbWE6IEZpeCB0byBjaGFuZ2UgZm9yIGNvbnRpbnVvdXMgdHJhbnNmZXIK
PiA+IGxpbms6Cj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmsKPiA+IGVybmVsLm9yZyUyRmRtYWVuZ2luZSUy
RjIwMjIxMjIzMDIyNjA4LjU1MDY5Ny0xLQo+ID4gbWllJTQwaWdlbC5jby5qcCUyRiZkYXRhPTA1
JTdDMDElN0NGcmFuay5MaSU0MG54cC5jb20lN0NhYzU3YTYyZDQKPiA+IDEwYjQ1OGE1YmE0MDhk
YjA1Y2UwYTRlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJQo+ID4gN0Mw
JTdDNjM4MTEwMTU0NzIyOTQ1MzgwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
Cj4gPiB3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMzAwMCU3Cj4gPiBDJTdDJTdDJnNkYXRhPXRJbjBNSHpFdnJkeGFDNEtLVHZUUnZZWEJ6
UTZNeXJGYTJHWHBhM2VQdjAlM0QmCj4gPiByZXNlcnZlZD0wCj4gPiAtIFtSRkMgUEFUQ0ggMC8z
XSBEZWFsIHdpdGggYWxpZ25tZW50IHJlc3RyaWN0aW9uIG9uIEVQIHNpZGUKPiA+IGxpbms6Cj4g
PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLmsKPiA+IGVybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjIwMjMwMTEzMDkw
MzUwLjExMDM0OTQtMS0KPiA+IG1pZSU0MGlnZWwuY28uanAlMkYmZGF0YT0wNSU3QzAxJTdDRnJh
bmsuTGklNDBueHAuY29tJTdDYWM1N2E2MmQ0Cj4gPiAxMGI0NThhNWJhNDA4ZGIwNWNlMGE0ZSU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCUKPiA+IDdDMCU3QzYzODExMDE1
NDcyMjk0NTM4MCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNAo+ID4gd0xqQXdN
REFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAl
Nwo+ID4gQyU3QyU3QyZzZGF0YT1STHBuRGlMd2ZxUWQ1UU1YZGlReVBWQ2tmT2o4cTJBeVZlWk93
V0h2bHNNJTMKPiA+IEQmcmVzZXJ2ZWQ9MAo+ID4gLSBbUkZDIFBBVENIIHYyIDAvN10gSW50cm9k
dWNlIGEgdnJpbmdoIGFjY2Vzc29yIGZvciBJTyBtZW1vcnkKPiA+IGxpbms6Cj4gPiBodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZsb3JlLmsKPiA+IGVybmVsLm9yZyUyRnZpcnR1YWxpemF0aW9uJTJGMjAyMzAyMDIwOTA5MzQu
NTQ5NTU2LTEtCj4gPiBtaWUlNDBpZ2VsLmNvLmpwJTJGJmRhdGE9MDUlN0MwMSU3Q0ZyYW5rLkxp
JTQwbnhwLmNvbSU3Q2FjNTdhNjJkNAo+ID4gMTBiNDU4YTViYTQwOGRiMDVjZTBhNGUlN0M2ODZl
YTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlCj4gPiA3QzAlN0M2MzgxMTAxNTQ3MjI5
NDUzODAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzQKPiA+IHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTcKPiA+
IEMlN0MlN0Mmc2RhdGE9NmpnWTc2Qk1TYnZhbWIlMkZsM1VyanQ0R2NpemVxb24lMkJaRTVuUHNz
YzJrREElCj4gPiAzRCZyZXNlcnZlZD0wCj4gPgo+ID4gQWJvdXQgdGhpcyBwYXRjaHNldCBoYXMg
NCBwYXRjaGVzLiBUaGUgZmlyc3Qgb2YgdHdvIHBhdGNoIGlzIGxpdHRsZSBjaGFuZ2VzCj4gPiB0
byB2aXJ0aW8uIFRoZSB0aGlyZCBwYXRjaCBhZGQgQVBJcyB0byBlYXNpbHkgYWNjZXNzIHZpcnRp
byBkYXRhIHN0cnVjdHVyZQo+ID4gb24gUENJZSBIb3N0IHNpZGUgbWVtb3J5LiBUaGUgbGFzdCBv
bmUgaW50cm9kdWNlIGEgdmlydGlvLW5ldCBFUCBkZXZpY2UKPiA+IGZ1bmN0aW9uLiBEZXRhaWxz
IGFyZSBpbiBjb21taXQgcmVzcGVjdGl2ZWx5Lgo+ID4KPiA+IEN1cnJlbnRseSB0aG9zZSBuZXR3
b3JrIGRldmljZXMgYXJlIHRlc3RkIHVzaW5nIHBpbmcgb25seS4gSSdsbCBhZGQgYQo+ID4gcmVz
dWx0IG9mIHBlcmZvcm1hbmNlIGV2YWx1YXRpb24gdXNpbmcgaXBlcmYgYW5kIGV0YyB0byB0aGUg
ZnV0dXJlIHZlcnNpb24KPiA+IG9mIHRoaXMgcGF0Y2hzZXQuCj4gPgo+ID4gU2h1bnN1a2UgTWll
ICg0KToKPiA+ICAgdmlydGlvX3BjaTogYWRkIGEgZGVmaW5pdGlvbiBvZiBxdWV1ZSBmbGFnIGlu
IElTUgo+ID4gICB2aXJ0aW9fcmluZzogcmVtb3ZlIGNvbnN0IGZyb20gdnJpbmcgZ2V0dGVyCj4g
PiAgIFBDSTogZW5kcG9pbnQ6IEludHJvZHVjZSB2aXJ0aW8gbGlicmFyeSBmb3IgRVAgZnVuY3Rp
b25zCj4gPiAgIFBDSTogZW5kcG9pbnQ6IGZ1bmN0aW9uOiBBZGQgRVAgZnVuY3Rpb24gZHJpdmVy
IHRvIHByb3ZpZGUgdmlydGlvIG5ldAo+ID4gICAgIGRldmljZQo+ID4KPiA+ICBkcml2ZXJzL3Bj
aS9lbmRwb2ludC9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDcgKwo+ID4gIGRyaXZlcnMv
cGNpL2VuZHBvaW50L01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArCj4gPiAgZHJpdmVy
cy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL0tjb25maWcgICAgICAgIHwgIDEyICsKPiA+ICBkcml2
ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUgICAgICAgfCAgIDEgKwo+ID4gIC4u
Li9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm5ldC1lcC5jICB8IDM0MyArKysrKysr
KysrCj4gPiAgLi4uL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bmV0LXJjLmMgIHwg
NjM1ICsrKysrKysrKysrKysrKysrKwo+ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9u
cy9wY2ktZXBmLXZuZXQuYyB8IDM4NyArKysrKysrKysrKwo+ID4gIGRyaXZlcnMvcGNpL2VuZHBv
aW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZuZXQuaCB8ICA2MiArKwo+ID4gIGRyaXZlcnMvcGNpL2Vu
ZHBvaW50L3BjaS1lcGYtdmlydGlvLmMgICAgICAgICB8IDExMyArKysrCj4gPiAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICAgICAgICAgICAgIHwgICAyICstCj4gPiAgaW5jbHVk
ZS9saW51eC9wY2ktZXBmLXZpcnRpby5oICAgICAgICAgICAgICAgIHwgIDI1ICsKPiA+ICBpbmNs
dWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiA+ICBp
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oICAgICAgICAgICAgICAgfCAgIDIgKwo+ID4g
IDEzIGZpbGVzIGNoYW5nZWQsIDE1OTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1l
cGYtdm5ldC1lcC5jCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50
L2Z1bmN0aW9ucy9wY2ktZXBmLXZuZXQtcmMuYwo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bmV0LmMKPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm5ldC5oCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50L3BjaS1lcGYtdmlydGlv
LmMKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9wY2ktZXBmLXZpcnRpby5o
Cj4gPgo+ID4gLS0KPiA+IDIuMjUuMQo+CkJlc3QsClNodW5zdWtlCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
