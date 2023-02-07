Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBEBC636D3
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 01:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B92981BFA;
	Tue,  7 Feb 2023 01:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B92981BFA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=FIb1Zpiz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pxFZdCOo8m15; Tue,  7 Feb 2023 01:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF4108148F;
	Tue,  7 Feb 2023 01:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF4108148F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0490C0032;
	Tue,  7 Feb 2023 01:43:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14F9FC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 01:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA9C360DB2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 01:43:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA9C360DB2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=FIb1Zpiz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmyjbMq8dyv4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 01:43:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3FF360D9D
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3FF360D9D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 01:43:12 +0000 (UTC)
Received: by mail-ua1-x92c.google.com with SMTP id q19so2511662uac.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Feb 2023 17:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slsYSnRG5tB09fuwlP7s4BX6R5bETrWg46OL4k8XjfA=;
 b=FIb1ZpizHlfoN7P6ayp4RRvAysVicTtpBF8SISJSMocofSSaEeNXiWDOkOk/ERjo2F
 nCl3fmX+2ft4CQd0usAWBuT+OtaI5bjNpWVwb04gbe3keaY/AnxlDtjBpc6GrqXj3WJn
 kuKrBCHf+SgG1h4ohgrlSox048Ka9Iy2htkG8/X4LCIfOEHFeOVQv5C8A8is+bh/ni+R
 5hS2haTeNeNBHCj1vCIYqbF3v2lFirAYbda00jqHTxTUZtDevJdrGkoSQq0vi4IzEmjt
 ZSOahb3cu3MhXriD28SUBqe82dQ1abDBSrmywldNO+08HTs3ZoNnc3PK3x5p3n5zX2sc
 WvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slsYSnRG5tB09fuwlP7s4BX6R5bETrWg46OL4k8XjfA=;
 b=Ih3EHkzWzX7avjZnlo8LaesopUsWI5LdRW5/1cLqy9rCv7C2hqvLYenUE4Xi+w2e17
 X5HfbzK1CXxoNAFSaFoHdu+eFfZoxvyPiG4KfUpifSiQ6QA0gSaJPpx73JWaH3ZVYWE4
 2L7FT7cARsHDPAuZoGmJHnWtZVOYBjkewwbuPN2kNwVrObg48iZXz80jKsQJh1V+LhEl
 zOSW1nMJvb4g6ndAyTZt/Hq0OCU5MrRXye3r8zwt4IK2+Vm4cJ+9ciedbyz4FtYTGmkI
 fZ43Am2wv0Xzs2VmK2cEWb1Ivds1R+rajX/G48gb9Vj3thwnVeZLQ0FzS0HbuzHFna7O
 TK0g==
X-Gm-Message-State: AO0yUKVfm9N3dkkMrjPI9i0OYr0ZlN8+d7u6U3sLiwGH8YvMapdG+FNb
 BJhP61MUvVEoQd7gBJE3vbSazdkHSV+vfrKDIrDbPg==
X-Google-Smtp-Source: AK7set+171qFNiP3BgyEC1MS/cg3RppIvueqeqqZzIW6EdlKC5IDXHn7wwlPVkgdwbOW5B+xl/8Ahe36nt0AaY6uYbA=
X-Received: by 2002:ab0:660f:0:b0:670:ff15:7f5f with SMTP id
 r15-20020ab0660f000000b00670ff157f5fmr287912uam.16.1675734190964; Mon, 06 Feb
 2023 17:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331582DC0401DFA4EB5540C88D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB2331582DC0401DFA4EB5540C88D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 7 Feb 2023 10:43:00 +0900
Message-ID: <CANXvt5pCnC=7DaPkFi4v1WUbzrgETVL03aAi=aq-uBFFxqhTyA@mail.gmail.com>
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

MjAyM+W5tDLmnIg05pelKOWcnykgNjo0OCBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT46Cj4K
PiA+IGZvdW5kYXRpb24ub3JnCj4gPiBTdWJqZWN0OiBbRVhUXSBbUkZDIFBBVENIIDAvNF0gUENJ
OiBlbmRwb2ludDogSW50cm9kdWNlIGEgdmlydGlvLW5ldCBFUAo+ID4gZnVuY3Rpb24KPiA+Cj4K
PiBUaGUgZGVwZW5kZW50IEVETUEgcGF0Y2ggY2FuJ3QgYmUgYXBwbGllZCBhdCBsYXN0IGxpbnV4
LW5leHQuCj4gQ2FuIHlvdSBwcm92aWRlIGEgZ2l0IGxpbms/IFNvIEkgY2FuIHRyeSBkaXJlY3Rs
eS4KU29ycnksIEkndmUgbWlzc2VkIGl0LiBUaGUgZW1iZWRkZWQgRE1BJ3MgcGF0Y2hzZXQgaXMK
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjMwMTEzMTcxNDA5LjMwNDcwLTEt
U2VyZ2V5LlNlbWluQGJhaWthbGVsZWN0cm9uaWNzLnJ1LwphbmQsIG1lcmdlZCB0byBhIHBjaS9k
d2MgYnJhbmNoIG9uIGtlcm5lbC9naXQvbHBpZXJhbGlzaS9wY2kuZ2l0IC4gVGhlCmxpbmsgaXMg
aGVyZToKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbHBp
ZXJhbGlzaS9wY2kuZ2l0L2NvbW1pdC8/aD1wY2kvZHdjCgpJJ2xsIGFkZCB0aGUgaW5mb3JtYXRp
b24gdG8gYSBjb3ZlciBsZXR0ZXIgZnJvbSB0aGUgbmV4dCBzdWJtaXNzaW9uLgo+IEZyYW5rCj4K
PiA+Cj4gPiBBYm91dCB0aGlzIHBhdGNoc2V0IGhhcyA0IHBhdGNoZXMuIFRoZSBmaXJzdCBvZiB0
d28gcGF0Y2ggaXMgbGl0dGxlIGNoYW5nZXMKPiA+IHRvIHZpcnRpby4gVGhlIHRoaXJkIHBhdGNo
IGFkZCBBUElzIHRvIGVhc2lseSBhY2Nlc3MgdmlydGlvIGRhdGEgc3RydWN0dXJlCj4gPiBvbiBQ
Q0llIEhvc3Qgc2lkZSBtZW1vcnkuIFRoZSBsYXN0IG9uZSBpbnRyb2R1Y2UgYSB2aXJ0aW8tbmV0
IEVQIGRldmljZQo+ID4gZnVuY3Rpb24uIERldGFpbHMgYXJlIGluIGNvbW1pdCByZXNwZWN0aXZl
bHkuCj4gPgo+CkJlc3QsClNodW5zdWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
