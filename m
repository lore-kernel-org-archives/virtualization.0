Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC3C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 08:58:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB5C60FA0
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 08:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CB5C60FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24381607F8;
	Tue, 17 Aug 2021 08:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-S_FLWOh51W; Tue, 17 Aug 2021 08:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE909607FC;
	Tue, 17 Aug 2021 08:58:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C1A4C0010;
	Tue, 17 Aug 2021 08:58:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1A7C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 044D880F7C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7cnYrhmim89S
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:58:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFC6280EA0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629190686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8+DOjW469z64iWshUFabmhF+EB8X6PV2KwTCK59PbU=;
 b=Ar9Vbp2Hob3UzDOEJuuMoaV6naWkcXrsyGDPBcIb8JZp6aaFyjns0APQQL5LaWTmZDNmqQ
 lxxUv/ZIJ8ybwpbs2L7qT4WpfPRufc7uZVX2d+Vf6mcENYeUQuVL4sT7Xr6O8TJDSYbFv2
 r7wfIoFgU9p+ULHR9lp5s+OBXDFuiPs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-OMbyPxKSPdqWCzhDPqJOOw-1; Tue, 17 Aug 2021 04:58:05 -0400
X-MC-Unique: OMbyPxKSPdqWCzhDPqJOOw-1
Received: by mail-lj1-f197.google.com with SMTP id
 x1-20020a05651c0241b02901b900da420dso4504524ljn.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y8+DOjW469z64iWshUFabmhF+EB8X6PV2KwTCK59PbU=;
 b=pLobo0odpSFqxgdUCP5NF+o6ZtntnPPronlV++FB883WwG4+WGMQ6hdbVXs8cQo5lU
 ITAnND2ssgvKu7b+Jlt4Q+Ktj4U0arqdJ9D+c1sWxT7nISHKjvBkvZZZXJNTD6LWexT1
 GIkzs9eVgPxag26NeiHbygF+xDNFJM5MRczztAUjOmeuNrrQQX/DXvKmycCeaUlkFnvF
 0imYIZi2+EOWhV/lOEokBsic994jCBwVDR+0zMBykfjy0i2l6gD2Hwhx+eqLNnvprcFj
 JjQdVxNhHHiQo54jSFkdR4kJQumpEcSE57Rt7nu4hk1/+msP0CmXZd0YBgoZAl9Agou/
 aVhw==
X-Gm-Message-State: AOAM5322DFe0uXwq2ppKI8t5TAQOiJwHflTUu05GwYAvh2LoROWbPChG
 R7/1ndrQAjQKQB/MbV01XM7QhUuEpce7eMt1k4Gi//IgmmHZfF0p+CtY+rYTq+rDdLO1Xidz7Xy
 jSy8HLQBIELHDd0d92b7x1tyoGL6r89I8tWCoCABtJe5hFoGUiHMoOSi7ZA==
X-Received: by 2002:a2e:bf23:: with SMTP id c35mr2219415ljr.404.1629190683655; 
 Tue, 17 Aug 2021 01:58:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXe9//Ds2teBWSFoULGUoQva+fafiWe75mnGETv8BSSFhd4KHLvRRGXC99fk/bx3uwxWjMODWEv9jbjRNBPKg=
X-Received: by 2002:a2e:bf23:: with SMTP id c35mr2219401ljr.404.1629190683366; 
 Tue, 17 Aug 2021 01:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
 <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
 <PH0PR12MB5481B0AC416186D7B20FCB26DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d54f2e9b-1a04-7118-5c39-c93997eb2afd@redhat.com>
 <20210817052644.GB74703@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEssyoArFmGhHL_sT0mNW_mvd-e9HeJXCMrUnzZggMr8yA@mail.gmail.com>
 <20210817060136.GA75939@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210817060136.GA75939@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Aug 2021 16:57:52 +0800
Message-ID: <CACGkMEtj6KRGSJFdqrSEmEktkDN5RPec9nc46p+SQjjUeLM2sQ@mail.gmail.com>
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

T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMjowMSBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAwMTo0ODoxN1BNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMToyNiBQTSBFbGkg
Q29oZW4gPGVsaWNAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgQXVnIDE3
LCAyMDIxIGF0IDEyOjE5OjU1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4KPiA+
ID4gPiDlnKggMjAyMS84LzE3IOS4i+WNiDEyOjAzLCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+ID4g
PiA+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4g
PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTcsIDIwMjEgOToyNiBBTQo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAzOjM3IEFNIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+IHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1v
biwgQXVnIDE2LCAyMDIxIGF0IDA3OjU2OjU5UE0gKzAzMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDAxOjU4OjA2UE0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIxLzgvMTYg5LiL5Y2IMTo0
NywgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEF1ZyAxNiwg
MjAyMSBhdCAxMjoxNjoxNFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4g5ZyoIDIwMjEvOC8xMiDkuIvljYg1OjUwLCBFbGkgQ29oZW4g5YaZ6YGTOgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAwMzowNDozNVBNICsw
ODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIx
LzgvMTIg5LiL5Y2IMzowMSwgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDAyOjQ3OjA2UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgQXVnIDEyLCAy
MDIxIGF0IDEyOjU1IFBNIEVsaSBDb2hlbgo+ID4gPiA+ID4gPiA8ZWxpY0BudmlkaWEuY29tPiB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAxMiwgMjAy
MSBhdCAxMToxOToxOUFNICswODAwLCBKYXNvbiBXYW5nCj4gPiA+ID4gPiA+IHdyb3RlOgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjEvOC8xMSDkuIvljYg3OjA0LCBF
bGkgQ29oZW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBX
ZWQsIEF1ZyAxMSwgMjAyMSBhdCAwNDozNzo0NFBNICswODAwLCBKYXNvbgo+ID4gPiA+ID4gPiBX
YW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIx
LzgvMTEg5LiL5Y2IMzo1MywgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gT25lIHRoaW5nIG5lZWQgdG8gc29sdmUgZm9yIG1xIGlzIHRo
YXQgdGhlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgdTE2IGN0cmxfdnFfaWR4KHN0cnVjdAo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICttbHg1X3ZkcGFfZGV2ICpt
dmRldikgewo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAg
IHJldHVybiAyICoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAr
bWx4NV92ZHBhX21heF9xcHMobXZkZXYtPm1heF92cXMpOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IFdlIHNob3VsZCBoYW5kbGUgdGhlIGNhc2Ugd2hlbiBNUSBpcwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBzdXBwb3J0ZWQgYnkgdGhlIGRldmljZSBi
dXQgbm90IHRoZSBkcml2ZXIuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEUuZyBpbiB0aGUg
Y2FzZSB3aGVuIHdlIGhhdmUgMiBxdWV1ZSBwYWlyczoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gV2hlbiBNUSBpcyBlbmFibGVkLCBjdnEgaXMgcXVldWUgNAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBXaGVuIE1RIGlzIG5vdCBlbmFibGVkLCBjdnEgaXMgcXVldWUgMgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gVGhlcmUncyBzb21lIGlzc3VlIHdpdGggdGhpcy4gSSBnZXQKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbGxiYWNrcyB0YXJnZXRpbmcgc3Bl
Y2lmaWMgdmlydHF1ZXVlcyBiZWZvcmUKPiA+ID4gPiA+ID4gZmVhdHVyZXMgbmVnb3RpYXRpb24g
aGFzIGJlZW4gY29tcGxldGVkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gU3BlY2lmaWNhbGx5LCBJIGdldCBzZXRfdnFfY2IoKSBjYWxscy4gQXQKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRoaXMgcG9pbnQgSSBtdXN0IGtub3cgdGhlIGNv
bnRyb2wgdnEgaW5kZXguCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU28g
SSB0aGluayB3ZSBuZWVkIGRvIGJvdGg6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAxKSBBdCBvbmUgaGFu
ZCwgaXQncyBhIGJ1ZyBmb3IgdGhlIHVzZXJzcGFjZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHRvIHVzZSB2cV9pbmRleCBiZWZvcmUgZmVhdHVyZSBpcyBuZWdvdGlhdGVk
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAobG9va3MgbGlrZSBhIGJ1ZyBpbiBteSBjdnEgc2VyaWVzIHRo
YXQgd2lsbAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbGwgU0VUX1ZS
SU5HX0NBTEwgYmVmb3JlIGZlYXR1cmUgaXMgbmVnb3RpYXRlLAo+ID4gPiA+ID4gPiB3aGljaCBJ
IHdpbGwgbG9vaykuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMikgQXQg
dGhlIG90aGVyIGhhbmQsIHRoZSBkcml2ZXIgc2hvdWxkIGJlCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gYWJsZSB0byBkZWFsIHdpdGggdGhhdAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IEFsbCBJIGNhbiBkbyBpcyBkcm9wIGNhbGxiYWNrcyBmb3IgVlFzIGJlZm9yZQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmZWF0dXJlcyBuZWdvdGF0aW9uIGhhcyBiZWVuIGNv
bXBsZXRlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9yIGp1c3QgbGVhdmUg
cXVldWUgaW5kZXggMCwgMSB3b3JrLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpbmNlIGl0IGlzIG5vdCBleHBlY3Rl
ZCB0byBiZSBjaGFuZ2VkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBSaWdodCwgd2lsbCBkby4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
SSB0aGluayB0aGUgQ1ZRIGluZGV4IG11c3Qgbm90IGRlcGVuZCBvbiB0aGUKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5lZ290aWF0ZWQgZmVhdHVyZXMgYnV0IHJhdGhl
ciBkZXBlbmQgb2YgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2
YWx1ZSB0aGUgZGV2aWNlIGRyaXZlciBwcm92aWRlcyBpbiB0aGUgY2FsbCB0bwo+ID4gPiA+ID4g
PiBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBBdCB0aGUgdmlydGlvIGxldmVsLCBpdCdzIHRvbyBsYXRlIHRvIGNoYW5nZQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRoYXQgYW5kIGl0IGJyZWFrcyB0aGUg
YmFja3dhcmQgY29tcGF0aWJpbGl0eS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJ1dCBhdCB0aGUgdkRQ
QSBsZXZlbCwgdGhlIHVuZGVyIGxheWVyIGRldmljZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGNhbiBtYXAgdmlydGlvIGN2cSB0byBhbnkgb2YgaXQncyB2aXJ0cXVldWUu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBFLmcgbWFwIGN2cSAoaW5kZXggMikgdG8gbWx4NSBjdnEgKHRo
ZSBsYXN0KS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIG5vdCBmb2xsb3dpbmcgeW91IGhlcmUuIEkg
c3RpbGwgZG9uJ3Qga25vdyB3aGF0Cj4gPiA+ID4gPiA+IGluZGV4IGlzIGN2cS4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFJpZ2h0LCB3ZSBzdGlsbCBuZWVkIHRvIHdhaXQgZm9y
IHRoZSBmZWF0dXJlIGJlaW5nCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBuZWdv
dGlhdGVkIGluIG9yZGVyIHRvIHByb2NlZWQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNvIHRvIHN1bW1hcmlzZSwgYmVm
b3JlIGZlYXR1cmUgbmVnb3RpYXRpb24KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBj
b21wbGV0ZSwgSSBhY2NlcHQgY2FsbHMgcmVmZXJyaW5nIHRvIFZRcyBvbmx5IGZvciBpbmRpY2Vz
IDAKPiA+ID4gPiA+ID4gYW5kIDEuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWZ0
ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBjb21wbGV0ZSBJIGtub3cgQ1ZRIGluZGV4Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYW5kIHdpbGwgYWNjZXB0IGluZGljZXMgMCB0byBjdnEg
aW5kZXguCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgZ2V0IHRoaXMgImFj
Y2VwdCBpbmRpY2VzIDAgdG8gY3ZxIGluZGV4Ii4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFdoYXQgSSBtZWFudCB0byBzYXkgaXMgdGhhdCB0aGVyZSBhcmUgc2V2ZXJhbCBjYWxsYmFja3MK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRoYXQgcmVmZXIgdG8gc3BlY2lmaWMgdmlydHF1
ZXVlcywgZS5nLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc2V0X3ZxX2FkZHJlc3MoKSwg
c2V0X3ZxX251bSgpIGV0Yy4gVGhleSBhbGwgYWNjZXB0IHZpcnRxdWV1ZQo+ID4gPiA+ID4gPiBp
bmRleCBhcyBhbiBhcmd1bWVudC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoYXQgd2Ug
d2FudCB0byBkbyBpcyB2ZXJpZnkgd2hlYXRoZXIgdGhlIGluZGV4IHByb3ZpZGVkCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBpcyB2YWxpZCBvciBub3QuIElmIGl0IGlzIG5vdCB2YWxpZCwg
ZWl0aGVyIHJldHVybiBlcnJvcgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKGlmIHRoZSBj
YWxsYmFjayBjYW4gcmV0dXJuIGEgdmFsdWUpIG9yIGp1c3QgYXZvaWQKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHByb2Nlc3NpbmcgaXQuIElmIHRoZSBpbmRleCBpcyB2YWxpZCB0aGVuIHdl
IHByb2Nlc3MgaXQgbm9ybWFsbHkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gTm93IHdlIG5lZWQgdG8gZGVjaWRlIHdoaWNoIGluZGV4IGlz
IHZhbGlkIG9yIG5vdC4gV2UKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5lZWQgc29tZXRo
aW5nIGxpa2UgdGhpcyB0byBpZGVudGlmaXkgdmFsaWQgaW5kZXhlcyByYW5nZToKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBDVlEgY2xlYXI6
IDAgYW5kIDEKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENWUSBzZXQsIE1RIGNsZWFyOiAw
LCAxIGFuZCAyIChmb3IgQ1ZRKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENWUSBzZXQs
IE1RIHNldDogMC4ubnZxIHdoZXJlIG52cSBpcyB3aGF0ZXZlciBwcm92aWRlZAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IF92ZHBhX3Jl
Z2lzdGVyX2RldmljZSgpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gWWVzLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFVuZm9ydHVuYXRlbHkgaXQg
ZG9lcyBub3Qgd29yay4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc2V0X3ZxX2NiKCkgZm9yIGFs
bCB0aGUgbXVsdGlxdWV1ZXMgaXMgY2FsbGVkIGJlb2ZyZSBmZWF0dXJlCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IG5lZ290aWF0aW9uLiBJZiBJIGFwcGx5IHRoZSBhYm92ZSBsb2dpYywgSSB3aWxs
IGxvc2UgdGhlc2Ugc2V0dGluZ3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IEkgY2FuIG1ha2UgYW4gZXhjZXB0aW9uIGZvciBzZXRfdnFfY2IoKSwgc2F2
ZSBjYWxsYmFja3MgYW5kCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJlc3RvcmUgdGhlbSBhZnRl
cndhcmRzLiBUaGlzIGxvb2tzIHRvbyBjb252b2x1dGVkIGFuZCBtYXliZQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiB3ZSBzaG91bGQgc2VlayBhbm90aGVyIHNvbHV0aW9uLgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gSSBhZ3JlZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFJldGhpbmsgYWJvdXQgdGhpcyBpc3N1ZS4gSXQgbG9va3Mg
dG8gdGhlIG9ubHkgaXNzdWUgd2UgZmFjZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXMgdGhlIHNl
dF92cV9jYigpLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdp
dGggdGhlIGFzc3VtcHRpb24gdGhhdCB0aGUgdXNlcnNwYWNlIGNhbiB1c2UgdGhlIGluZGV4Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBjb3JyZWN0bHkgKGV2ZW4gYmVmb3JlIHNldF9mZWF0dXJlcyku
IEkgd29uZGVyIHRoZSBmb2xsb3dpbmcgd29ya3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gSW5zdGVhZCBvZiBjaGVja2luZyB3aGV0aGVyIHRoZSBpbmRleCBp
cyBjdnEgaW4gc2V0X3ZxX2NiKCkgaG93Cj4gPiA+ID4gPiA+IGFib3V0Ogo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gMSkgZGVjb3VwbGUgZXZlbnRfY2Igb3V0IG9mIG1seDVfdmRwYV92aXJ0cXVldWUg
YW5kCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBtbHg1X2Nvbmdyb192cQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gMikgaGF2ZSBhIGRlZGljYXRlZCBldmVudF9jYiBhcnJheSBpbiBtbHg1X3ZkcGFfbmV0
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAzKSB0aGVuIHdlIGNhbiBkbwo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5kZXYtPmV2ZW50X2Nic1tpbmRleF0gPSAqY2I7
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFNvIGFjdHVhbGx5IHlv
dSdyZSBzdWdnZXN0aW5nIHRvIHNhdmUgYWxsIHRoZSBjYWxsYWJjawo+ID4gPiA+ID4gPiA+ID4g
PiA+IGNvbmZpZ3VyYXRpb25zIGluIGFuIGFycmF5IGFuZCBldmFsdWF0ZSBjdnEgaW5kZXggYWZ0
ZXIgZmVhdHVyZQo+ID4gPiA+ID4gPiA+ID4gPiA+IG5lZ290aWF0aW9uIGhhcyBiZWVuIGNvbXBs
ZXRlZC4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gWWVzLgo+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgdGhh
dCBjb3VsZCB3b3JrLiBJIHdpbGwgY29kZSB0aGlzIGFuZCB1cGRhdGUuCj4gPiA+ID4gPiA+ID4g
PiBJdCB3b3JrcyBmaW5lIHdoZW4gSSBhbSB3b3JraW5nIHdpdGggeW91ciB2ZXJzaW9uIG9mIHFl
bXUgd2l0aAo+ID4gPiA+ID4gPiA+ID4gc3VwcG9ydCBmb3IgbXVsdGkgcXVldWUuCj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBpdCBpcyBicm9rZW4g
b24gcWVtdSB2Ni4wLjAuIElmIEkgcmVnaXN0ZXIgbXkKPiA+ID4gPiA+ID4gPiA+IHZkcGEgZGV2
aWNlIHdpdGggbW9yZSB0aGFuIDIgZGF0YSB2aXJ0cXVldWVzLCBxZW11IHdvbid0IGV2ZW4gY3Jl
YXRlCj4gPiA+ID4gPiA+ID4gPiBhIG5ldGRldmljZSBpbiB0aGUgVk0uCj4gPiA+ID4gPiA+IFFl
bXUgc2hvdWxkIGhpZGUgTVEgZmVhdHVyZSBpbiB0aGlzIGNhc2UgYnV0IGxvb2tzIGxpa2UgaXQg
ZG9lc24ndC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2lsbCBoYXZlIGEgbG9vay4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IEkgYW0gbm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGlzLiBJ
cyB0aGVyZSBzb21lIGtpbmQgb2YgaW5kaWNhdGlvbiBJCj4gPiA+ID4gPiA+ID4gPiBjYW4gZ2V0
IGFzIHRvIHRoZSB2ZXJzaW9uIG9mIHFlbXUgc28gSSBjYW4gYXZvaWQgdXNpbmcgbXVsdGlxdWV1
ZQo+ID4gPiA+ID4gPiA+ID4gZm9yIHZlcnNpb25zIEkga25vdyBhcmUgcHJvYmxlbWF0aWM/Cj4g
PiA+ID4gPiA+ID4gTm8gdmVyc2lvbnMgOykgVGhpcyBpcyB3aGF0IGZlYXR1cmUgYml0cyBhcmUg
Zm9yIC4uLgo+ID4gPiA+ID4gPiBZZXMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFNvIGRvZXMg
aXQgd29yayBpZiAibXE9b2ZmIiBpcyBzcGVjaWZpZWQgaW4gdGhlIGNvbW1hbmQgbGluZT8KPiA+
ID4gPiA+ID4KPiA+ID4gPiA+IFdlIHNob3VsZCBub3QgYWRkIGRyaXZlciBtb2R1bGUgcGFyYW1l
dGVyLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBOb3RlIHRoYXQsIGl0J3Mgbm90IGEgbW9kdWxl
IHBhcmFtZXRlciBidXQgYSBxZW11IGNvbW1hbmQgbGluZSB0byBkaXNhYmxlIG1xCj4gPiA+ID4g
ZmVhdHVyZS4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBXZSBhbnl3YXkgbmVlZCBudW1iZXIg
b2YgVlFzIHRvIGJlIGRyaXZlbiBieSB0aGUgbnVtYmVyIG9mIHZjcHVzIHVzZWQgYnkgdGhlIFZN
Lgo+ID4gPiA+ID4gU28gd2h5IG5vdCBzcGVjaWZ5IHRoaXMgd2hlbiBjcmVhdGluZyBhIHZkcGEg
ZGV2aWNlPwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBZZXMsIEkgdGhpbmsgaXQgc2hvdWxkIHdv
cmsgYXMgd2VsbC4KPiA+ID4gPgo+ID4gPiA+IFNvIG1hbmFnZW1lbnQgbmVlZCBlaXRoZXI6Cj4g
PiA+ID4KPiA+ID4gPiAxKSBkaXNhYmxlIG11bHRpcXVldWUgdmlhICJtcT1vZmYiCj4gPiA+ID4K
PiA+ID4gPiBvcgo+ID4gPiA+Cj4gPiA+ID4gMikgdXNpbmcgbmV0bGluayBBUEkgdG8gY3JlYXRl
IGEgc2luZ2xlIHF1ZXVlIHBhaXIgZGV2aWNlCj4gPiA+ID4KPiA+ID4gPiBmb3IgdGhlIHFlbXUg
PD02LjEuCj4gPiA+ID4KPiA+ID4KPiA+ID4gV2hpY2ggbWFuYWdlbWVudCBlbnRpdHkgYXJlIHlv
dSByZWZlcnJpbmcgdG8gaGVyZT8KPiA+Cj4gPiBUaGUgb25lIHRoYXQgbGF1bmNoZXMgUWVtdS4g
KEUuZyBsaWJ2aXJ0IG9yIG90aGVyKS4KPiA+Cj4KPiBCdXQgd2Ugd2FudCB0byBmaW5kIGEgc29s
dXRpb24gd2l0aCBleGlzdGluZyBwYWNrYWdlcy4gSWYgbW9kaWZ5aW5nIGNvZGUKPiBleGlzdGlu
ZyBjb2RlIGlzIHRoZSBzb2x1dGlvbiwgd2UgY291bGQgZml4IHFlbXUuCgpSaWdodC4KCj4KPiBB
cyBJIHJlcG9ydGVkIGluIGFub3RoZXIgZW1haWwsIG1xPW9mZiBhdm9pZHMgdGhpcyBwcm9ibGVt
LiBTbyB1c2Vycwo+IHdpbGwgaGF2ZSB0byB1c2UgdGhpcyB3aGVuIHVzaW5nIG5ldyBkcml2ZXIg
d2l0aCBvbGQgcWVtdS4KClllcywgc28gdGhpcyBpcyBhY3R1YWxseSB0aGUgb3B0aW9uIDEpIGFi
b3ZlLgoKVGhhbmtzCgo+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
