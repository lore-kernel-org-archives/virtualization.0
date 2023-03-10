Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B154C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1F3E41163;
	Fri, 10 Mar 2023 09:46:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1F3E41163
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i8sCGw5o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otYOpXW-DdgT; Fri, 10 Mar 2023 09:46:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 626074014E;
	Fri, 10 Mar 2023 09:46:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 626074014E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D24C0035;
	Fri, 10 Mar 2023 09:46:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3CBEC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D001F40374
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D001F40374
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qVbb9bixYp4u
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:46:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F5A44014E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F5A44014E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678441560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EK9itzNwztWEWdddqk8IMFWiym6+vyjgRi28eISez9E=;
 b=i8sCGw5oHBzJ1hPO5xt0Pjo0Q/DFUX395zov0etcLDQEjYUvM4yILpBy1Pm26FPcVLOe+P
 1Pj77p/tqZ4cd6EMu44S2hPh2P5o1OgBKfADqTSfozPTbiGvdUeNZDLXFAJPosYDLdup0G
 RC7kQpdmqSNwAKzRG6IiHq0SEEsywvQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-dkvLXnr0OtKaq8sm0m82eg-1; Fri, 10 Mar 2023 04:45:58 -0500
X-MC-Unique: dkvLXnr0OtKaq8sm0m82eg-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1768297308eso2547610fac.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678441557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EK9itzNwztWEWdddqk8IMFWiym6+vyjgRi28eISez9E=;
 b=ZGW+voCel9oOOLKjbIJ3SVbzzfoQvp5qTCOvxRFVY/KiKZUNihnIFZhei00CeMNqih
 ccJ76xHVaIi2Xkyo6i0V+E5PkG4EQ+EjGttNQeEie1T97uDprQ8KG+itJuaRRy4+ITHk
 +IjSHyZJjON4CVNrZP7gN3bv3ES/x22NLov91inAtXAF4FZawUs7XSAxJg/TurjgJzmP
 6KKzvRPM7XtiYET7NKxdEMHFPvbzhXmv484D2ngy/K3wRH6MRJkAabUQr2EAwZgg95Rk
 vdHb1xautLIE7bnlCDbv6bC8SUi7Ae8FzLEVGT5bqUgHUIo4O0cWw1JvY5NdLcVck7bf
 qdww==
X-Gm-Message-State: AO0yUKUdP9+IDmcKNtd7nSbB+OlUwAcrgZTYEYdZjFfZUuCBFViy87r9
 tVtQeira8cDOoC6fsbuOGURs+Revf2iM251a3bXm5XFMMIOPypgO6KcboN+aVIp5Lwoe/ZKcA3j
 16NmPMs0+kd/hqKHOfgOMAUftz+ODF3IJLWq0F8vH0/VRlWIR/DL/1FW64g==
X-Received: by 2002:a05:6870:703:b0:172:cef0:4549 with SMTP id
 ea3-20020a056870070300b00172cef04549mr8547619oab.9.1678441557608; 
 Fri, 10 Mar 2023 01:45:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8wFTyGoabixP5OFNVzySToAyCse4a2PQn/SiQim9SvqUPTZJzF14tUdNW7G51x0q/0hGPiEqTsuhQVjiiGEfc=
X-Received: by 2002:a05:6870:703:b0:172:cef0:4549 with SMTP id
 ea3-20020a056870070300b00172cef04549mr8547605oab.9.1678441557382; Fri, 10 Mar
 2023 01:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com> <20230217051158-mutt-send-email-mst@kernel.org>
 <Y+92c9us3HVjO2Zq@nvidia.com>
 <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
 <20230310034101-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230310034101-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Mar 2023 17:45:46 +0800
Message-ID: <CACGkMEsr3xSa=1WtU35CepWSJ8CK9g4nGXgmHS_9D09LHi7H8g@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org,
 Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
 netdev@vger.kernel.org, robin.murphy@arm.com, wangrong68@huawei.com
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

T24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgNDo0MeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBGZWIgMjAsIDIwMjMgYXQgMTA6Mzc6MThB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIEZyaSwgRmViIDE3LCAyMDIzIGF0IDg6
NDMgUE0gSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+
IE9uIEZyaSwgRmViIDE3LCAyMDIzIGF0IDA1OjEyOjI5QU0gLTA1MDAsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPiA+ID4gPiBPbiBUaHUsIEZlYiAxNiwgMjAyMyBhdCAwODoxNDo1MFBNIC0w
NDAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gPiA+ID4gPiBPbiBUdWUsIEZlYiAwNywgMjAy
MyBhdCAwODowODo0M1BNICswODAwLCBOYW55b25nIFN1biB3cm90ZToKPiA+ID4gPiA+ID4gRnJv
bTogUm9uZyBXYW5nIDx3YW5ncm9uZzY4QGh1YXdlaS5jb20+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+IE9uY2UgZW5hYmxlIGlvbW11IGRvbWFpbiBmb3Igb25lIGRldmljZSwgdGhlIE1TSQo+ID4g
PiA+ID4gPiB0cmFuc2xhdGlvbiB0YWJsZXMgaGF2ZSB0byBiZSB0aGVyZSBmb3Igc29mdHdhcmUt
bWFuYWdlZCBNU0kuCj4gPiA+ID4gPiA+IE90aGVyd2lzZSwgcGxhdGZvcm0gd2l0aCBzb2Z0d2Fy
ZS1tYW5hZ2VkIE1TSSB3aXRob3V0IGFuCj4gPiA+ID4gPiA+IGlycSBieXBhc3MgZnVuY3Rpb24s
IGNhbiBub3QgZ2V0IGEgY29ycmVjdCBtZW1vcnkgd3JpdGUgZXZlbnQKPiA+ID4gPiA+ID4gZnJv
bSBwY2llLCB3aWxsIG5vdCBnZXQgaXJxcy4KPiA+ID4gPiA+ID4gVGhlIHNvbHV0aW9uIGlzIHRv
IG9idGFpbiB0aGUgTVNJIHBoeSBiYXNlIGFkZHJlc3MgZnJvbQo+ID4gPiA+ID4gPiBpb21tdSBy
ZXNlcnZlZCByZWdpb24sIGFuZCBzZXQgaXQgdG8gaW9tbXUgTVNJIGNvb2tpZSwKPiA+ID4gPiA+
ID4gdGhlbiB0cmFuc2xhdGlvbiB0YWJsZXMgd2lsbCBiZSBjcmVhdGVkIHdoaWxlIHJlcXVlc3Qg
aXJxLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFByb2JhYmx5IG5vdCB3aGF0IGFueW9uZSB3YW50cyB0
byBoZWFyLCBidXQgSSB3b3VsZCBwcmVmZXIgd2Ugbm90IGFkZAo+ID4gPiA+ID4gbW9yZSB1c2Vz
IG9mIHRoaXMgc3R1ZmYuIEl0IGxvb2tzIGxpa2Ugd2UgaGF2ZSB0byBnZXQgcmlkIG9mCj4gPiA+
ID4gPiBpb21tdV9nZXRfbXNpX2Nvb2tpZSgpIDpcCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSdkIGxp
a2UgaXQgaWYgdmRwYSBjb3VsZCBtb3ZlIHRvIGlvbW11ZmQgbm90IGtlZXAgY29weWluZyBzdHVm
ZiBmcm9tCj4gPiA+ID4gPiBpdC4uCj4gPiA+ID4KPiA+ID4gPiBBYnNvbHV0ZWx5IGJ1dCB3aGVu
IGlzIHRoYXQgaGFwcGVuaW5nPwo+ID4gPgo+ID4gPiBEb24ndCBrbm93LCBJIHRoaW5rIGl0IGhh
cyB0byBjb21lIGZyb20gdGhlIFZEUEEgbWFpbnRhaW5lcnMsIE5pY29saW4KPiA+ID4gbWFkZSBz
b21lIGRyYWZ0cyBidXQgd2Fzbid0IGFibGUgdG8gZ2V0IGl0IGJleW9uZCB0aGF0Lgo+ID4KPiA+
IENpbmR5IChjY2VkKSB3aWxsIGNhcnJ5IG9uIHRoZSB3b3JrLgo+ID4KPiA+IFRoYW5rcwo+Cj4g
SG1tIGRpZG4ndCBzZWUgYW55dGhpbmcgeWV0LiBOYW55b25nIFN1biBtYXliZSB5b3UgY2FuIHRh
a2UgYSBsb29rPwoKSnVzdCB0byBjbGFyaWZ5LCBDaW5keSB3aWxsIHdvcmsgb24gdGhlIGlvbW11
ZmQgY29udmVyc2lvbiBmb3IKdmhvc3QtdkRQQSwgdGhlIGNoYW5nZXMgYXJlIG5vbi10cml2aWFs
IGFuZCBtYXkgdGFrZSB0aW1lLiBCZWZvcmUgd2UKYXJlIGFibGUgdG8gYWNoaWV2ZSB0aGF0LCAg
SSB0aGluayB3ZSBzdGlsbCBuZWVkIHNvbWV0aGluZyBsaWtlIHRoaXMKcGF0Y2ggdG8gbWFrZSB2
RFBBIHdvcmsgb24gc29mdHdhcmUgbWFuYWdlZCBNU0kgcGxhdGZvcm1zLgoKTWF5YmUgTmFueW9u
ZyBjYW4gcG9zdCBhIG5ldyB2ZXJzaW9uIHRoYXQgYWRkcmVzc2VzIHRoZSBjb21tZW50IHNvIGZh
cj8KClRoYW5rcwoKPgo+ID4gPgo+ID4gPiBQbGVhc2UgaGF2ZSBwZW9wbGUgd2hvIG5lZWQgbW9y
ZSBpb21tdSBwbGF0Zm9ybSBlbmFibGVtZW50IHRvIHBpY2sgaXQKPiA+ID4gdXAgaW5zdGVhZCBv
ZiBtZXJnaW5nIGhhY2tzIGxpa2UgdGhpcy4uCj4gPiA+Cj4gPiA+IFdlIGFyZSB2ZXJ5IGNsb3Nl
IHRvIGhhdmluZyBuZXN0ZWQgdHJhbnNsYXRpb24gb24gQVJNIHNvIGFueW9uZSB3aG8gaXMKPiA+
ID4gc2VyaW91cyBhYm91dCBWRFBBIG9uIEFSTSBpcyBnb2luZyB0byBuZWVkIGlvbW11ZmQgYW55
aG93Lgo+ID4gPgo+ID4gPiBKYXNvbgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
