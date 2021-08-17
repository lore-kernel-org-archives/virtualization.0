Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A10C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 05:47:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71D860F39
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 05:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A71D860F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BBD6404BB;
	Tue, 17 Aug 2021 05:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cuFKOIOvLBD1; Tue, 17 Aug 2021 05:47:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF8B34049A;
	Tue, 17 Aug 2021 05:47:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE5EDC001A;
	Tue, 17 Aug 2021 05:47:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCA4C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84FD38102D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCBXL7LVDMDS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:47:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8266481029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629179266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7k4/KCH6zm5fkdOzuJvLKeNr5M8V0xvts3/MIExgEWQ=;
 b=DxPjtvqh+pdT2Wx6bpcuOJGRq8CTcA6oGhb+y0kSvHayEbI5mJidkkcjImuEZp2WxTD99H
 amJi1T4mOat/NwJoIavyMJ2dYsiUc4IDRJFJ32t8CdCjADGtzTHOPOCVONgE7Eey7coyLj
 RDg1BTh6LXDIHo4O1mL7NSlwUugflEE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-10BzALt8NGOALkvSwYg7Hg-1; Tue, 17 Aug 2021 01:47:44 -0400
X-MC-Unique: 10BzALt8NGOALkvSwYg7Hg-1
Received: by mail-lj1-f200.google.com with SMTP id
 l12-20020a2ea80c0000b02900f5b2b52da7so6907906ljq.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 22:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7k4/KCH6zm5fkdOzuJvLKeNr5M8V0xvts3/MIExgEWQ=;
 b=RdtIbMwF17dU9omV3r3TpwhsN3S7CU9jYrlNjAwLTn67ucaIXv3i8tsLN3LjQxBW+Z
 5sOyQU9QQzwGTYNik72aRWy8TAZ9lT3Xw9DgzxydNt3K0vOl812AiTTX165HPK+CjyFj
 b9CyB7XNCayUnnbq+vCZzef6aEUSZOd9EDK3f9os7lFLpqjsiPOZ330q+lhsTz/zQMfS
 ithwPZYCzpGEL4BAeA8VCmwN/FuCwg8BiWWTRefjHvlqY260eXYVbc+HS+vQQzBMGGT+
 COYCX3B175Wy/YJMXzeaWkPfdwf5aBiH4pmgxbkWmQwbYsNTgU3VtDysznxifNYu6hip
 7L0g==
X-Gm-Message-State: AOAM533Q3p2iStZI4ANEccNIKPxQgOvXsxlZZz1iugACRVtwtZR6YqU5
 nEXHLh7Zonkgpxm2OTN1chEfsS0A9lC6iXbiGrRXMGCVqdIlWXeffzz1Wc8qn3vn0rct1+bI6M8
 hBlem9dMyaCfL9Oj0AiHK6L4/tgJ04L2Sph7jEcjrd5JtO0YAcr48G6kNYg==
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr1122650lfr.312.1629179263043; 
 Mon, 16 Aug 2021 22:47:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEfDy9dEBGVJY81gARucYHYlabqpgsbPlqdBfp94b5SKJRjoH1bxbR+3ZkEXRQaFBRVdEXLC4ZnLk0qFAy8ys=
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr1122638lfr.312.1629179262823; 
 Mon, 16 Aug 2021 22:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
 <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
 <20210817052406.GA74703@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210817052406.GA74703@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Aug 2021 13:47:31 +0800
Message-ID: <CACGkMEvBn0oLtnS6E080FC1ouN+eEdAnY1HqYfQURPB3keL6KQ@mail.gmail.com>
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMToyNCBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAxMTo1NTo0MkFNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMzozNyBBTSBNaWNo
YWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gTW9u
LCBBdWcgMTYsIDIwMjEgYXQgMDc6NTY6NTlQTSArMDMwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4g
PiA+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDAxOjU4OjA2UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g5ZyoIDIwMjEvOC8xNiDkuIvljYgxOjQ3LCBFbGkg
Q29oZW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiBPbiBNb24sIEF1ZyAxNiwgMjAyMSBhdCAxMjoxNjox
NFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+IOWcqCAyMDIxLzgvMTIg
5LiL5Y2INTo1MCwgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgQXVn
IDEyLCAyMDIxIGF0IDAzOjA0OjM1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4g
PiA+ID4gPiA+IOWcqCAyMDIxLzgvMTIg5LiL5Y2IMzowMSwgRWxpIENvaGVuIOWGmemBkzoKPiA+
ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAwMjo0NzowNlBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBBdWcgMTIs
IDIwMjEgYXQgMTI6NTUgUE0gRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+IHdyb3RlOgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAxMToxOToxOUFNICsw
ODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIx
LzgvMTEg5LiL5Y2INzowNCwgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IE9uIFdlZCwgQXVnIDExLCAyMDIxIGF0IDA0OjM3OjQ0UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIxLzgvMTEg5LiL
5Y2IMzo1MywgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IE9uZSB0aGluZyBuZWVkIHRvIHNvbHZlIGZvciBtcSBpcyB0aGF0IHRoZToKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArc3RhdGljIHUxNiBjdHJsX3Zx
X2lkeChzdHJ1Y3QgIG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAg
ICByZXR1cm4gMiAqICBtbHg1X3ZkcGFfbWF4X3FwcyhtdmRldi0+bWF4X3Zxcyk7Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBXZSBzaG91bGQgaGFuZGxlIHRoZSBjYXNlIHdoZW4gTVEgaXMgc3VwcG9ydGVkIGJ5
IHRoZSBkZXZpY2UgYnV0IG5vdCB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IGRyaXZlci4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBFLmcgaW4gdGhlIGNhc2Ugd2hlbiB3ZSBoYXZlIDIgcXVldWUg
cGFpcnM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gV2hlbiBNUSBpcyBlbmFibGVkLCBjdnEgaXMgcXVldWUgNAo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IFdoZW4gTVEgaXMgbm90IGVuYWJsZWQsIGN2cSBpcyBxdWV1ZSAyCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRo
ZXJlJ3Mgc29tZSBpc3N1ZSB3aXRoIHRoaXMuIEkgZ2V0IGNhbGxiYWNrcyB0YXJnZXRpbmcgc3Bl
Y2lmaWMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2aXJ0cXVldWVzIGJlZm9yZSBm
ZWF0dXJlcyBuZWdvdGlhdGlvbiBoYXMgYmVlbiBjb21wbGV0ZWQuCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTcGVjaWZpY2Fs
bHksIEkgZ2V0IHNldF92cV9jYigpIGNhbGxzLiBBdCB0aGlzIHBvaW50IEkgbXVzdCBrbm93IHRo
ZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbnRyb2wgdnEgaW5kZXguCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNvIEkgdGhpbmsgd2UgbmVlZCBkbyBib3RoOgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAx
KSBBdCBvbmUgaGFuZCwgaXQncyBhIGJ1ZyBmb3IgdGhlIHVzZXJzcGFjZSB0byB1c2UgdnFfaW5k
ZXggYmVmb3JlIGZlYXR1cmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXMgbmVnb3Rp
YXRlZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAobG9va3MgbGlrZSBhIGJ1ZyBpbiBteSBjdnEgc2VyaWVzIHRoYXQgd2lsbCBjYWxs
IFNFVF9WUklOR19DQUxMIGJlZm9yZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmZWF0
dXJlIGlzIG5lZ290aWF0ZSwgd2hpY2ggSSB3aWxsIGxvb2spLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAyKSBBdCB0aGUgb3RoZXIg
aGFuZCwgdGhlIGRyaXZlciBzaG91bGQgYmUgYWJsZSB0byBkZWFsIHdpdGggdGhhdAo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWxsIEkg
Y2FuIGRvIGlzIGRyb3AgY2FsbGJhY2tzIGZvciBWUXMgYmVmb3JlIGZlYXR1cmVzIG5lZ290YXRp
b24gaGFzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiZWVuIGNvbXBsZXRlZC4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBPciBqdXN0IGxlYXZlIHF1ZXVlIGluZGV4IDAsIDEgd29yay4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpbmNl
IGl0IGlzIG5vdCBleHBlY3RlZCB0byBiZSBjaGFuZ2VkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFJpZ2h0LCB3aWxsIGRvLgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgdGhlIENW
USBpbmRleCBtdXN0IG5vdCBkZXBlbmQgb24gdGhlIG5lZ290aWF0ZWQgZmVhdHVyZXMgYnV0Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmF0aGVyIGRlcGVuZCBvZiB0aGUgdmFsdWUg
dGhlIGRldmljZSBkcml2ZXIgcHJvdmlkZXMgaW4gdGhlIGNhbGwgdG8KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKS4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gQXQgdGhlIHZpcnRpbyBsZXZlbCwgaXQncyB0b28gbGF0ZSB0byBjaGFu
Z2UgdGhhdCBhbmQgaXQgYnJlYWtzIHRoZSBiYWNrd2FyZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBjb21wYXRpYmlsaXR5Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBCdXQgYXQgdGhlIHZEUEEgbGV2ZWwsIHRoZSB1bmRl
ciBsYXllciBkZXZpY2UgY2FuIG1hcCB2aXJ0aW8gY3ZxIHRvIGFueSBvZgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBpdCdzIHZpcnRxdWV1ZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRS5nIG1hcCBjdnEgKGluZGV4IDIp
IHRvIG1seDUgY3ZxICh0aGUgbGFzdCkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIG5vdCBmb2xsb3dpbmcgeW91IGhlcmUuIEkg
c3RpbGwgZG9uJ3Qga25vdyB3aGF0IGluZGV4IGlzIGN2cS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBSaWdodCwgd2Ugc3RpbGwgbmVlZCB0byB3YWl0IGZvciB0aGUgZmVhdHVyZSBiZWluZyBu
ZWdvdGlhdGVkIGluIG9yZGVyIHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcHJvY2VlZC4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTbyB0byBz
dW1tYXJpc2UsIGJlZm9yZSBmZWF0dXJlIG5lZ290aWF0aW9uIGNvbXBsZXRlLCBJIGFjY2VwdCBj
YWxscwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiByZWZlcnJpbmcgdG8gVlFzIG9ubHkgZm9yIGlu
ZGljZXMgMCBhbmQgMS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWZ0ZXIgZmVhdHVyZSBuZWdv
dGlhdGlvbiBjb21wbGV0ZSBJIGtub3cgQ1ZRIGluZGV4IGFuZCB3aWxsIGFjY2VwdAo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBpbmRpY2VzIDAgdG8gY3ZxIGluZGV4Lgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gSSBkb24ndCBnZXQgdGhpcyAiYWNjZXB0IGluZGljZXMgMCB0byBjdnEgaW5kZXgiLgo+
ID4gPiA+ID4gPiA+ID4gPiA+IFdoYXQgSSBtZWFudCB0byBzYXkgaXMgdGhhdCB0aGVyZSBhcmUg
c2V2ZXJhbCBjYWxsYmFja3MgdGhhdCByZWZlciB0bwo+ID4gPiA+ID4gPiA+ID4gPiA+IHNwZWNp
ZmljIHZpcnRxdWV1ZXMsIGUuZy4gc2V0X3ZxX2FkZHJlc3MoKSwgc2V0X3ZxX251bSgpIGV0Yy4g
VGhleSBhbGwKPiA+ID4gPiA+ID4gPiA+ID4gPiBhY2NlcHQgdmlydHF1ZXVlIGluZGV4IGFzIGFu
IGFyZ3VtZW50Lgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gV2hhdCB3
ZSB3YW50IHRvIGRvIGlzIHZlcmlmeSB3aGVhdGhlciB0aGUgaW5kZXggcHJvdmlkZWQgaXMgdmFs
aWQgb3IKPiA+ID4gPiA+ID4gPiA+ID4gPiBub3QuIElmIGl0IGlzIG5vdCB2YWxpZCwgZWl0aGVy
IHJldHVybiBlcnJvciAoaWYgdGhlIGNhbGxiYWNrIGNhbiByZXR1cm4KPiA+ID4gPiA+ID4gPiA+
ID4gPiBhIHZhbHVlKSBvciBqdXN0IGF2b2lkIHByb2Nlc3NpbmcgaXQuIElmIHRoZSBpbmRleCBp
cyB2YWxpZCB0aGVuIHdlCj4gPiA+ID4gPiA+ID4gPiA+ID4gcHJvY2VzcyBpdCBub3JtYWxseS4K
PiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IE5vdyB3ZSBuZWVkIHRvIGRl
Y2lkZSB3aGljaCBpbmRleCBpcyB2YWxpZCBvciBub3QuIFdlIG5lZWQgc29tZXRoaW5nCj4gPiA+
ID4gPiA+ID4gPiA+ID4gbGlrZSB0aGlzIHRvIGlkZW50aWZpeSB2YWxpZCBpbmRleGVzIHJhbmdl
Ogo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQ1ZRIGNsZWFyOiAwIGFu
ZCAxCj4gPiA+ID4gPiA+ID4gPiA+ID4gQ1ZRIHNldCwgTVEgY2xlYXI6IDAsIDEgYW5kIDIgKGZv
ciBDVlEpLgo+ID4gPiA+ID4gPiA+ID4gPiA+IENWUSBzZXQsIE1RIHNldDogMC4ubnZxIHdoZXJl
IG52cSBpcyB3aGF0ZXZlciBwcm92aWRlZCB0bwo+ID4gPiA+ID4gPiA+ID4gPiA+IF92ZHBhX3Jl
Z2lzdGVyX2RldmljZSgpCj4gPiA+ID4gPiA+ID4gPiA+IFllcy4KPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+IFVuZm9ydHVuYXRlbHkgaXQgZG9lcyBub3Qgd29yay4KPiA+ID4gPiA+
ID4gPiA+IHNldF92cV9jYigpIGZvciBhbGwgdGhlIG11bHRpcXVldWVzIGlzIGNhbGxlZCBiZW9m
cmUgZmVhdHVyZQo+ID4gPiA+ID4gPiA+ID4gbmVnb3RpYXRpb24uIElmIEkgYXBwbHkgdGhlIGFi
b3ZlIGxvZ2ljLCBJIHdpbGwgbG9zZSB0aGVzZSBzZXR0aW5ncy4KPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiBJIGNhbiBtYWtlIGFuIGV4Y2VwdGlvbiBmb3Igc2V0X3ZxX2NiKCksIHNh
dmUgY2FsbGJhY2tzIGFuZCByZXN0b3JlCj4gPiA+ID4gPiA+ID4gPiB0aGVtIGFmdGVyd2FyZHMu
IFRoaXMgbG9va3MgdG9vIGNvbnZvbHV0ZWQgYW5kIG1heWJlIHdlIHNob3VsZCBzZWVrCj4gPiA+
ID4gPiA+ID4gPiBhbm90aGVyIHNvbHV0aW9uLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
SSBhZ3JlZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBMZXQg
bWUga25vdyB3aGF0IHlvdSB0aGluay4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFJldGhp
bmsgYWJvdXQgdGhpcyBpc3N1ZS4gSXQgbG9va3MgdG8gdGhlIG9ubHkgaXNzdWUgd2UgZmFjZSBp
cyB0aGUKPiA+ID4gPiA+ID4gPiBzZXRfdnFfY2IoKS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+IFdpdGggdGhlIGFzc3VtcHRpb24gdGhhdCB0aGUgdXNlcnNwYWNlIGNhbiB1c2UgdGhlIGlu
ZGV4IGNvcnJlY3RseSAoZXZlbgo+ID4gPiA+ID4gPiA+IGJlZm9yZSBzZXRfZmVhdHVyZXMpLiBJ
IHdvbmRlciB0aGUgZm9sbG93aW5nIHdvcmtzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
SW5zdGVhZCBvZiBjaGVja2luZyB3aGV0aGVyIHRoZSBpbmRleCBpcyBjdnEgaW4gc2V0X3ZxX2Ni
KCkgaG93IGFib3V0Ogo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gMSkgZGVjb3VwbGUgZXZl
bnRfY2Igb3V0IG9mIG1seDVfdmRwYV92aXJ0cXVldWUgYW5kIG1seDVfY29uZ3JvX3ZxCj4gPiA+
ID4gPiA+ID4gMikgaGF2ZSBhIGRlZGljYXRlZCBldmVudF9jYiBhcnJheSBpbiBtbHg1X3ZkcGFf
bmV0Cj4gPiA+ID4gPiA+ID4gMykgdGhlbiB3ZSBjYW4gZG8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IG5kZXYtPmV2ZW50X2Nic1tpbmRleF0gPSAqY2I7Cj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gU28gYWN0dWFsbHkgeW91J3JlIHN1Z2dlc3RpbmcgdG8gc2F2ZSBhbGwgdGhlIGNhbGxh
YmNrIGNvbmZpZ3VyYXRpb25zIGluCj4gPiA+ID4gPiA+IGFuIGFycmF5IGFuZCBldmFsdWF0ZSBj
dnEgaW5kZXggYWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBoYXMgYmVlbgo+ID4gPiA+ID4gPiBj
b21wbGV0ZWQuCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFllcy4KPiA+ID4gPiA+Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIHRoaW5rIHRoYXQgY291bGQgd29yay4g
SSB3aWxsIGNvZGUgdGhpcyBhbmQgdXBkYXRlLgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEl0
IHdvcmtzIGZpbmUgd2hlbiBJIGFtIHdvcmtpbmcgd2l0aCB5b3VyIHZlcnNpb24gb2YgcWVtdSB3
aXRoIHN1cHBvcnQKPiA+ID4gPiBmb3IgbXVsdGkgcXVldWUuCj4gPiA+ID4KPiA+ID4gPiBUaGUg
cHJvYmxlbSBpcyB0aGF0IGl0IGlzIGJyb2tlbiBvbiBxZW11IHY2LjAuMC4gSWYgSSByZWdpc3Rl
ciBteSB2ZHBhCj4gPiA+ID4gZGV2aWNlIHdpdGggbW9yZSB0aGFuIDIgZGF0YSB2aXJ0cXVldWVz
LCBxZW11IHdvbid0IGV2ZW4gY3JlYXRlIGEKPiA+ID4gPiBuZXRkZXZpY2UgaW4gdGhlIFZNLgo+
ID4KPiA+IFFlbXUgc2hvdWxkIGhpZGUgTVEgZmVhdHVyZSBpbiB0aGlzIGNhc2UgYnV0IGxvb2tz
IGxpa2UgaXQgZG9lc24ndC4KPiA+Cj4KPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgd2hhdCBkbyB5
b3UgdGhpbmsgaXMgZXhwZWN0ZWQgZnJvbSBxZW11LiBUaGUKPiBkZXZpY2UgcHVibGlzaGVzIE1R
LCBxZW11IHNob3VsZCBlaXRoZXIgYWNjZXB0IG9yIGRlY2xpbmUuCgpQcm9iYWJseSBub3QuIEl0
IHdvcmtzIGxpa2UgZGlzYWJsZSBNUSBzaWxlbnRseSAod2l0aG91dCBjbGkpIGluIHFlbXUuCgpU
aGFua3MKCj4KPiA+IFdpbGwgaGF2ZSBhIGxvb2suCj4gPgo+ID4gPiA+Cj4gPiA+ID4gSSBhbSBu
b3Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoaXMuIElzIHRoZXJlIHNvbWUga2luZCBvZiBpbmRpY2F0
aW9uIEkgY2FuCj4gPiA+ID4gZ2V0IGFzIHRvIHRoZSB2ZXJzaW9uIG9mIHFlbXUgc28gSSBjYW4g
YXZvaWQgdXNpbmcgbXVsdGlxdWV1ZSBmb3IKPiA+ID4gPiB2ZXJzaW9ucyBJIGtub3cgYXJlIHBy
b2JsZW1hdGljPwo+ID4gPgo+ID4gPiBObyB2ZXJzaW9ucyA7KSBUaGlzIGlzIHdoYXQgZmVhdHVy
ZSBiaXRzIGFyZSBmb3IgLi4uCj4gPgo+ID4gWWVzLgo+ID4KPiA+IFNvIGRvZXMgaXQgd29yayBp
ZiAibXE9b2ZmIiBpcyBzcGVjaWZpZWQgaW4gdGhlIGNvbW1hbmQgbGluZT8KPiA+Cj4gPiBUaGFu
a3MKPiA+Cj4gPgo+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IGluIG1seDVfdmRwYV9zZXRfdnFfY2Io
KQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gNCkgaW4gdGhlIG1seDVfY3ZxX2tpY2tfaGFu
ZGxlcigpLCB3ZSBrbm93IHRoZSBmZWF0dXJlIGlzIG5lZ290aWF0ZWQgYW5kIHdlCj4gPiA+ID4g
PiA+ID4gY2FuIHVzZSB0aGUgY29ycmVjdCBpbmRleCB0aGVyZS4KPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IEluIHRoZSBtZWFuIHRpbWUsIEkgd2lsbCBsb29rIGF0IFFlbXUgY29kZSB0byBz
ZWUgaWYgd2UgY2FuIGd1YXJhbnRlZSB0aGF0Cj4gPiA+ID4gPiA+ID4gc2V0X2ZlYXR1cmVzIGlz
IGNhbGxlZCBiZWZvcmUgc2V0X3ZxX2NhbGxiYWNrLiAoQXQgZmlyc3QgZ2xhbmNlLCBpdCdzIG5v
dAo+ID4gPiA+ID4gPiA+IHRyaXZpYWwgYnV0IGxldCdzIHNlZSkuCj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gQW5kIHdoaWxlIHdyaXRpbmcgdGhpcywgSSB0aGluayB0aGlzIGxvZ2ljIGRvZXMg
bm90IGJlbG9nIGluIG1seDVfdmRwYQo+ID4gPiA+ID4gPiA+ID4gPiA+IGJ1dCBwcm9iYWJseSBp
biB2ZHBhLmMKPiA+ID4gPiA+ID4gPiA+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCB2ZHBhIHNob3Vs
ZCBiZSB1bmF3YXJlIG9mIGEgc3BlY2lmaWMgZGV2aWNlIHR5cGUuIEUuZwo+ID4gPiA+ID4gPiA+
ID4gPiB0aGUgYWJvdmUgaW5kaWNlcyBtYXkgd29yayBvbmx5IGZvciB2aXJ0aW8tbmV0IGJ1dCBu
b3Qgb3RoZXIuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
