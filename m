Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00620C64E8A
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 12:15:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4043822206
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 12:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4043822206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 952462038D;
	Thu,  3 Dec 2020 12:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKIkLTKpO6XJ; Thu,  3 Dec 2020 12:15:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BE3B7203D2;
	Thu,  3 Dec 2020 12:15:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B506C0FA8;
	Thu,  3 Dec 2020 12:15:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF4EFC0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 12:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BE54287B53
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 12:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZufyI1dzviV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 12:15:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3297087AE2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606997746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dv989P1CZtRRl41OCLQYNKxYCvCFS0Q8rKdLF2QSMic=;
 b=WQtJw8DXGT4xkFCedgnATrdMpJKW8kLMKLoH5kR2H635OhuyRjCs6QumLORGbkxdb1E3YU
 eFXMdSM/448yps8qt13OIwzdzPWJltCR4IHHHgBylUKl5q3ihVsvMX3g/pHsPv/ra5rF77
 tBKa9/O59BsvFlwsbUr/Kq3SpCM4guI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-hudVaFIhM0SOAh5gZuGeYg-1; Thu, 03 Dec 2020 07:15:42 -0500
X-MC-Unique: hudVaFIhM0SOAh5gZuGeYg-1
Received: by mail-wr1-f72.google.com with SMTP id w17so1175266wrl.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Dec 2020 04:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Dv989P1CZtRRl41OCLQYNKxYCvCFS0Q8rKdLF2QSMic=;
 b=dnLGcl7SmayVEB6NOXfTgV3eTJBnf+s7jPjpXiNPKlnyBmuAHP/iYTm6mdKcGkWzrf
 CLpK1Y/7LIK/jBfajgVSAf4f9pxCQS/w2d9nuoZJbOQlgTStHYXu2S1HrWnUohW6m/DF
 e7IsaWRlzCXxJTSj0CwiccQzVyKwGcGZLFI7yaM7UBWP7udZevPNO98Tw9sOuJaXV6nd
 gW9IdGBt1KOzDTJQW6PYcnZsjB0MYuim30Rie0LjiDI9ldM0np5LMgeBW+uMIvHmR8Be
 p/eGzYsmepUazr5BwIoFscenKs5Ee8/FaL2WeGxD/7JcGk2sI+cqfylrsfTuUSMqEjNw
 DqGQ==
X-Gm-Message-State: AOAM530VNiD2irejU8uyMuJBfkEDmUVzH+6a1yI+GraKrweYnNPc+7yj
 gWCh86Ac/GA+2Y4oOY6iyfYJe1YgqKOF3DuphFo/rM7/qXKpMbifohCANQPlNpy2ws42iIh7Ibv
 re/qSTq1F5CwdC7Ts64pu11ZBdzcd3d5OFVKGO5VCTA==
X-Received: by 2002:a1c:810c:: with SMTP id c12mr3086992wmd.96.1606997741059; 
 Thu, 03 Dec 2020 04:15:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza8hZZny/iCFLZbf13T7T+/P5rfHVgXHh/cSBZIhWZH/GIMCPPSCrnXcxv5ZGQg4++jJf31Q==
X-Received: by 2002:a1c:810c:: with SMTP id c12mr3086964wmd.96.1606997740737; 
 Thu, 03 Dec 2020 04:15:40 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id t184sm1377556wmt.13.2020.12.03.04.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Dec 2020 04:15:39 -0800 (PST)
Date: Thu, 3 Dec 2020 07:15:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201203071414-mutt-send-email-mst@kernel.org>
References: <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
 <20201202165932-mutt-send-email-mst@kernel.org>
 <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
 <20201203054330-mutt-send-email-mst@kernel.org>
 <20201203120929.GA38007@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201203120929.GA38007@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMDI6MDk6MjlQTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIFRodSwgRGVjIDAzLCAyMDIwIGF0IDA1OjQ0OjE3QU0gLTA1MDAsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+IE9uIFRodSwgRGVjIDAzLCAyMDIwIGF0IDA4OjQ5OjI4QU0gKzAy
MDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gT24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDU6MDA6
MjJQTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+IE9uIFdlZCwgRGVj
IDAyLCAyMDIwIGF0IDA5OjQ4OjI1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4g
PiAKPiA+ID4gPiA+IE9uIDIwMjAvMTIvMiDkuIvljYg1OjIzLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFdlZCwgRGVjIDAyLCAyMDIwIGF0IDA3OjU3OjE0QU0gKzAy
MDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBXZWQsIERlYyAwMiwgMjAyMCBh
dCAxMjoxODozNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24g
MjAyMC8xMi8xIOS4i+WNiDU6MjMsIENpbmR5IEx1IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBP
biBNb24sIE5vdiAzMCwgMjAyMCBhdCAxMTozMyBQTSBNaWNoYWVsIFMuIFRzaXJraW48bXN0QHJl
ZGhhdC5jb20+ICB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAy
MCBhdCAwNjo0MTo0NVBNICswODAwLCBDaW5keSBMdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDU6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luPG1z
dEByZWRoYXQuY29tPiAgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgTm92
IDMwLCAyMDIwIGF0IDExOjI3OjU5QU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwNDowMDo1MUFNIC0wNTAw
LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBP
biBNb24sIE5vdiAzMCwgMjAyMCBhdCAwODoyNzo0NkFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFN1biwgTm92IDI5LCAyMDIwIGF0IDAz
OjA4OjIyUE0gLTA1MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBPbiBTdW4sIE5vdiAyOSwgMjAyMCBhdCAwODo0Mzo1MUFNICswMjAw
LCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZSBz
aG91bGQgbm90IHRyeSB0byB1c2UgdGhlIFZGIE1BQyBhZGRyZXNzIGFzIHRoYXQgaXMgdXNlZCBi
eSB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJlZ3VsYXIgKGUuZy4gbWx4
NV9jb3JlKSBOSUMgaW1wbGVtZW50YXRpb24uIEluc3RlYWQsIHVzZSBhIHJhbmRvbQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZ2VuZXJhdGVkIE1BQyBhZGRyZXNzLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBTdWdnZXN0ZWQgYnk6IENpbmR5IEx1PGx1bHVAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFk
ZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW48ZWxpY0BudmlkaWEu
Y29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZGlkbid0IHJlYWxpc2UgaXQn
cyBwb3NzaWJsZSB0byB1c2UgVkYgaW4gdHdvIHdheXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiB3aXRoIGFuZCB3aXRob3V0IHZkcGEuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFVzaW5nIGEgVkYgeW91IGNhbiBjcmVhdGUgcXVpdGUgYSBmZXcgcmVzb3VyY2VzLCBlLmcu
IHNlbmQgcXVldWVzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJlY2lldmUgcXVldWVz
LCB2aXJ0aW9fbmV0IHF1ZXVlcyBldGMuIFNvIHlvdSBjYW4gcG9zc2libHkgY3JlYXRlCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNldmVyYWwgaW5zdGFuY2VzIG9mIHZkcGEgbmV0IGRl
dmljZXMgYW5kIG5pYyBuZXQgZGV2aWNlcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ291bGQgeW91IGluY2x1ZGUgYSBiaXQg
bW9yZSBkZXNjcmlwdGlvbiBvbiB0aGUgZmFpbHVyZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IG1vZGU/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdlbGwsIHVzaW5nIHRo
ZSBNQUMgYWRkcmVzcyBvZiB0aGUgbmljIHZwb3J0IGlzIHdyb25nIHNpbmNlIHRoYXQgaXMgdGhl
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE1BQyBvZiB0aGUgcmVndWxhciBOSUMgaW1w
bGVtZW50YXRpb24gb2YgbWx4NV9jb3JlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gUmln
aHQgYnV0IEFUTSBpdCBkb2Vzbid0IGNvZXhpc3Qgd2l0aCB2ZHBhIHNvIHdoYXQncyB0aGUgcHJv
YmxlbT8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFRoaXMgY2FsbCBpcyB3cm9uZzogIG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNz
KCkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBJcyBzd2l0Y2hpbmcgdG8gYSByYW5kb20gbWFjIGZvciBzdWNoIGFuIHVudXN1YWwKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjb25maWd1cmF0aW9uIHJlYWxseSBqdXN0aWZp
ZWQ/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpbmNlIEkgY2FuJ3QgdXNlIHRoZSBO
SUMncyBNQUMgYWRkcmVzcywgSSBoYXZlIHR3byBvcHRpb25zOgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAxLiBUbyBnZXQgdGhlIE1BQyBhZGRyZXNzIGFzIHdhcyBjaG9zZW4gYnkgdGhl
IHVzZXIgYWRtaW5pc3RlcmluZyB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICBOSUMuIFRoaXMgc2hvdWxkIGludm9rZSB0aGUgc2V0X2NvbmZpZyBjYWxsYmFjay4gVW5mb3J0
dW5hdGVseSB0aGlzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgaXMgbm90IGlt
cGxlbWVudGVkIHlldC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IDIuIFVzZSBhIHJhbmRvbSBNQUMgYWRkcmVzcy4gVGhpcyBpcyBP
SyBzaW5jZSBpZiAoMSkgaXMgaW1wbGVtZW50ZWQgaXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gICAgICBjYW4gYWx3YXlzIG92ZXJyaWRlIHRoaXMgcmFuZG9tIGNvbmZpZ3VyYXRpb24u
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IEl0IGxvb2tzIGxpa2UgY2hhbmdpbmcgYSBNQUMgY291bGQgYnJlYWsgc29tZSBndWVz
dHMsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2FuIGl0IG5vdD8KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTm8s
IGl0IHdpbGwgbm90LiBUaGUgY3VycmVudCB2ZXJzaW9uIG9mIG1seDUgVkRQQSBkb2VzIG5vdCBh
bGxvdyByZWd1bGFyCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE5JQyBkcml2ZXIgYW5k
IFZEUEEgdG8gY28tZXhpc3QuIEkgaGF2ZSBwYXRjaGVzIHJlYWR5IHRoYXQgZW5hYmxlIHRoYXQK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZnJvbSBzdGVlcmluZyBwb2ludCBvZiB2aWV3
LiBJIHdpbGwgcG9zdCB0aGVtIGhlcmUgb25jZSBvdGhlciBwYXRjaGVzIG9uCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IHdoaWNoIHRoZXkgZGVwZW5kIHdpbGwgYmUgbWVyZ2VkLgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGRldi9wYXRjaC8yMDIwMTEy
MDIzMDMzOS42NTE2MDktMTItc2FlZWRtQG52aWRpYS5jb20vCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBDb3VsZCB5b3UgYmUgbW9yZSBleHBsaWNpdCBvbiB0aGUgZm9sbG93aW5nIHBvaW50
czoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0gd2hpY2ggY29uZmlndXJhdGlvbiBpcyBi
cm9rZW4gQVRNIChhcyBpbiwgdHdvIGRldmljZSBoYXZlIGlkZW50aWNhbAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gICAgIG1hY3M/IGFueSBvdGhlciBpc3N1ZXMpPwo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IFRoZSBvbmx5IHdyb25nIHRoaW5nIGlzIHRoZSBjYWxsIHRvICBtbHg1X3F1
ZXJ5X25pY192cG9ydF9tYWNfYWRkcmVzcygpLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEl0
J3Mgbm90IGJyZWFraW5nIGFueXRoaW5nIHlldCBpcyB3cm9uZy4gVGhlIHJhbmRvbSBNQUMgYWRk
cmVzcyBzZXR0aW5nCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXMgcmVxdWlyZWQgZm9yIHRo
ZSBzdGVlcmluZyBwYXRjaGVzLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPa2F5IHNvIEknbSBu
b3Qgc3VyZSB0aGUgRml4ZXMgdGFnIGF0IGxlYXN0IGlzIGFwcHJvcHJpYXRlIGlmIGl0J3MgYQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkZXBlbmRlbmN5IG9mIGEgbmV3IGZlYXR1cmUuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLSB3aHkgd29u
J3QgZGV2aWNlIE1BQyBjaGFuZ2UgZnJvbSBndWVzdCBwb2ludCBvZiB2aWV3Pwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSXQncyBsYWNrIG9m
IGltcGxlbWVudGF0aW9uIGluIHFlbXUgYXMgZmFyIGFzIEkga25vdy4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gU29ycnkgbm90IHN1cmUgSSB1bmRlcnN0YW5kLiBXaGF0J3Mgbm90IGltcGxlbWVu
dGVkIGluIFFFTVU/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gSEkgTWljaGFlbCwgdGhlcmUgYXJlIHNvbWUgYnVnIGluIHFlbXUgdG8gc2V0X2NvbmZpZywg
dGhpcyB3aWxsIGZpeCBpbiBmdXR1cmUsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBCdXQgdGhpcyBw
YXRjaCBpcyBzdGlsbCBuZWVkZWQsIGJlY2F1c2Ugd2l0aG91dCB0aGlzIHBhdGNoIHRoZSBtbHgK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRyaXZlciB3aWxsIGdpdmUgYW4gMCBtYWMgYWRkcmVzcyB0
byBxZW11Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhbmQgcWVtdSB3aWxsIG92ZXJ3cml0ZSB0aGUg
ZGVmYXVsdCBtYWMgYWRkcmVzcy4gIFRoaXMgd2lsbCBjYXVzZSB0cmFmZmljIGRvd24uCj4gPiA+
ID4gPiA+ID4gPiA+ID4gSG1tIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBzYXlzIFZGIG1hYyBhZGRy
ZXNzLCBub3QgMCBhZGRyZXNzLiBDb25mdXNlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiBJZiB0aGVy
ZSdzIG5vIG1hYyB3ZSBjYW4gY2xlYXIgVklSVElPX05FVF9GX01BQyBhbmQgaGF2ZSBndWVzdAo+
ID4gPiA+ID4gPiA+ID4gPiA+IHVzZSBhIHJhbmRvbSB2YWx1ZSAuLi4KPiA+ID4gPiA+ID4gPiA+
IEknbSBub3Qgc3VyZSB0aGlzIGNhbiB3b3JrIGZvciBhbGwgdHlwZXMgb2YgdkRQQSAoZS5nIGl0
IGNvdWxkIG5vdCBiZSBhCj4gPiA+ID4gPiA+ID4gPiBsZWFybmluZyBicmlkZ2UgaW4gdGhlIHN3
dGljaCkuCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4g
PiBoaSBNaWNoYWVs77yMCj4gPiA+ID4gPiA+ID4gPiA+IEkgaGF2ZSB0cmllZCBhcyB5b3VyIHN1
Z2dlc3Rpb24sIHNlZW1zIGV2ZW4gcmVtb3ZlIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiBWSVJUSU9f
TkVUX0ZfTUFDIHRoZSBxZW11IHdpbGwgc3RpbGwgY2FsbCBnZXRfY2luZmlnIGFuZCBvdmVyd3Jp
dGUgdGhlCj4gPiA+ID4gPiA+ID4gPiA+IGRlZmF1bHQgYWRkcmVzcyBpbiAgVk0sCj4gPiA+ID4g
PiA+ID4gPiBUaGlzIGxvb2tzIGEgYnVnIGluIHFlbXUsIGluIGd1ZXN0IGRyaXZlciB3ZSBoYWQ6
Cj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqAgLyogQ29uZmlndXJhdGlv
biBtYXkgc3BlY2lmeSB3aGF0IE1BQyB0byB1c2UuwqAgT3RoZXJ3aXNlIHJhbmRvbS4gKi8KPiA+
ID4gPiA+ID4gPiA+ICDCoMKgwqAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9f
TkVUX0ZfTUFDKSkKPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqAgwqDCoMKgIHZpcnRpb19jcmVhZF9i
eXRlcyh2ZGV2LAo+ID4gPiA+ID4gPiA+ID4gIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgbWFjKSwKPiA+ID4gPiA+ID4g
PiA+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoCBkZXYtPmRldl9hZGRyLCBkZXYt
PmFkZHJfbGVuKTsKPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqAgZWxzZQo+ID4gPiA+ID4gPiA+ID4g
IMKgwqDCoCDCoMKgwqAgZXRoX2h3X2FkZHJfcmFuZG9tKGRldik7Cj4gPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiB0aGlzIHByb2Nlc3MgaXMgbGlrZQo+
ID4gPiA+ID4gPiA+ID4gPiB2ZHBhIF9pbml0IC0tPnFlbXUgY2FsbCBnZXRfY29uZmlnIC0+bWx4
IGRyaXZlciB3aWxsIGdpdmUgIGFuIG1hYwo+ID4gPiA+ID4gPiA+ID4gPiBhZGRyZXNzIHdpdGgg
YWxsIDAtLT4KPiA+ID4gPiA+ID4gPiA+ID4gcWVtdSB3aWxsIG5vdCBjaGVjayB0aGlzIG1hYyBh
ZGRyZXNzIGFuZCB1c2UgaXQgLS0+IG92ZXJ3cml0ZSB0aGUgbWFjCj4gPiA+ID4gPiA+ID4gPiA+
IGFkZHJlc3MgaW4gcWVtdQo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gU28g
Zm9yIG15IHVuZGVyc3RhbmRpbmcgdGhlcmUgYXJlIHNldmVyYWwgbWV0aG9kIHRvIGZpeCB0aGlz
IHByb2JsZW0KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IDEsIHFlbXUgY2hl
Y2sgdGhlIG1hYyBhZGRyZXNzLCBpZiB0aGUgbWFjIGFkZHJlc3MgaXMgYWxsIDAsIHFlbXUgd2ls
bAo+ID4gPiA+ID4gPiA+ID4gPiBpZ25vcmUgaXQgYW5kIHNldCB0aGUgcmFuZG9tIG1hYyBhZGRy
ZXNzIHRvIG1seCBkcml2ZXIuCj4gPiA+ID4gPiA+ID4gPiBTbyBteSB1bmRlcnN0YW5kaW5nIGlz
IHRoYXQsIGlmIG1hYyBhZGRyZXNzIGlzIGFsbCAwLCB2RFBBIHBhcmVudCBzaG91bGQgbm90Cj4g
PiA+ID4gPiA+ID4gPiBhZHZlcnRpc2UgVklSVElPX05FVF9GX01BQy4gQW5kIHFlbXUgc2hvdWxk
IGVtdWxhdGUgdGhpcyBmZWF0dXJlIGFzIHlvdSBkaWQ6Cj4gPiA+ID4gPiA+ID4gVGhpbmtpbmcg
aXQgb3ZlciwgYXQgbGVhc3QgaW4gbWx4NSwgSSBzaG91bGQgYWx3YXlzIGFkdmVydGlzZQo+ID4g
PiA+ID4gPiA+IFZJUlRJT19ORVRfRl9NQUMgYW5kIHNldCBhIG5vbiB6ZXJvIE1BQyB2YWx1ZS4g
VGhlIHNvdXJjZSBvZiB0aGUgTUFDIGNhbgo+ID4gPiA+ID4gPiA+IGJlIGVpdGhlciByYW5kb21s
eSBnZW5lcmF0ZWQgdmFsdWUgYnkgbWx4NV92ZHBhIG9yIGJ5IGEgbWFuYWdlbWVudCB0b29sLgo+
ID4gPiA+ID4gPiA+IFRoaXMgaXMgaW1wb3J0YW50IGJlY2F1YXNlIHdlIHNob3VsZCBub3QgbGV0
IHRoZSBWTSBtb2RpZnkgdGhlIE1BQy4gSWYKPiA+ID4gPiA+ID4gPiB3ZSBkbyBpdCBjYW4gc2V0
IGEgTUFDIHZhbHVlIGlkZW50aWNhbCB0byB0aGUgbWx4NSBOSUMgZHJpdmVyIGFuZCBjYW4KPiA+
ID4gPiA+ID4gPiBraWRuYXAgdHJhZmZpYyB0aGF0IHdhcyBub3QgZGVzdGluZWQgdG8gaXQuCj4g
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gSW4gYWRkaXRpb24sIHdoZW4gVklSVElPX05FVF9G
X01BQyBpcyBwdWJsaXNoZWQsIGF0dGVtcHRzIHRvIGNoYW5nZSB0aGUKPiA+ID4gPiA+ID4gPiBN
QUMgYWRkcmVzcyBmcm9tIHRoZSBWTSBzaG91bGQgcmVzdWx0IGluIGVycm9yLgo+ID4gPiA+ID4g
PiBUaGF0IGlzIG5vdCB3aGF0IHRoZSBzcGVjIHNheXMgdGhvdWdoLgo+ID4gPiA+ID4gPiBWSVJU
SU9fTkVUX0ZfTUFDIG9ubHkgc2F5cyB3aGV0aGVyIG1hYyBpcyB2YWxpZCBpbiB0aGUgY29uZmln
IHNwYWNlLgo+ID4gPiA+ID4gPiBXaGV0aGVyIGd1ZXN0IGNhbiBjb250cm9sIHRoYXQgZGVwZW5k
cyBvbiBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUjoKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IAlUaGUgVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBjb21tYW5kIGlzIHVzZWQgdG8gc2V0
IHRoZSBkZWZhdWx0IE1BQyBhZGRyZXNzIHdoaWNoIHJ4Cj4gPiA+ID4gPiA+IAlmaWx0ZXJpbmcg
YWNjZXB0cyAoYW5kIGlmIFZJUlRJT19ORVRfRl9NQUNfQUREUiBoYXMgYmVlbiBuZWdvdGlhdGVk
LCB0aGlzIHdpbGwgYmUgcmVmbGVjdGVkIGluIG1hYyBpbgo+ID4gPiA+ID4gPiAJY29uZmlnIHNw
YWNlKS4KPiA+ID4gPiA+ID4gCVRoZSBjb21tYW5kLXNwZWNpZmljLWRhdGEgZm9yIFZJUlRJT19O
RVRfQ1RSTF9NQUNfQUREUl9TRVQgaXMgdGhlIDYtYnl0ZSBNQUMgYWRkcmVzcy4KPiA+ID4gPiA+
IAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBDb25zaWRlciBWSVJUSU9fTkVUX0NUUkxfTUFDX0FERFJf
U0VUIGlzIG5vdCBzdXBwb3J0ZWQgbm93LiBXaGF0IEVsaQo+ID4gPiA+ID4gcHJvcG9zZWQgaGVy
ZSBzaG91bGQgd29yaz8KPiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiAKPiA+
ID4gPiAKPiA+ID4gPiBXZSBjYW4gaGF2ZSBtYW5hZ2VtZW50IHNldCBhIE1BQyBhZGRyZXNzLiBS
YW5kb21pemluZyBpdCBpbiBrZXJuZWwKPiA+ID4gPiBkb2VzIG5vdCBzZWVtIGxpa2UgYSByZWFz
b25hYmxlIHBvbGljeSB0byBtZSAuLi4KPiA+ID4gPiAKPiA+ID4gCj4gPiA+IFRoaXMgbWFuYW5n
ZW1lbnQgc2hvdWxkIGJlIHRoZSBWRFBBIHRvb2wgdGhhdCBQYXJhdiBpcyBwdXNoaW5nLiBXZSBj
YW4KPiA+ID4gdXNlIGl0IHRvIHNldCBhIE1BQyBjaG9zZW4gYnkgdGhlIHVzZXIuIFRoZSBtbHg1
IHZkcGEgZHJpdmVyIGNhbiB0aGVuCj4gPiA+IHVzZSB0aGF0IE1BQyBpbnN0ZWFkIG9mIHJhbmRv
bWl6aW5nIGEgdmFsdWUuIElmIG5vIGFkbWluIHZhbHVlIGlzIGdpdmVuCj4gPiA+IHdlIGNhbiB1
c2UgYSByYW5kb20gTUFDLgo+ID4gCj4gPiBJSVVDIGluIHRoaXMgbW9kZWwgZGV2aWNlcyBhcmUg
Y3JlYXRlZCBieSB0aGlzIHRvb2wsIHJpZ2h0Pwo+ID4gV2h5IG5vdCByZXF1aXJlIHRoZSBNQUMg
d2hlbiBkZXZpY2UgaXMgY3JlYXRlZD8KPiA+IAo+IAo+IEl0IGlzIG1lbnRpb25lZCBpbiBQYXJh
didzIHBhdGNoc2V0IHRoYXQgdGhpcyB3aWxsIGJlIGNvbWluZyBpbiBhCj4gc3Vic2VxdWVudCBw
YXRjaCB0byBoaXMgdmRwYSB0b29sLiAKClNvIEkgdGhpbmsga2VybmVsIGhhcyB0d28gb3B0aW9u
czoKLSByZXF1aXJlIGEgbWFjIHdoZW4gZGV2aWNlIGlzIGNyZWF0ZWQsIHdlIHN1cHBseSBpdCB0
byBndWVzdAotIGFsbG93IGd1ZXN0IHRvIHNldCBhIG1hYwoKaXQncyBvayB0byBzdXBwb3J0IGJv
dGggLi4uCgoKCj4gPiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+IAo+ID4gPiA+IAo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
