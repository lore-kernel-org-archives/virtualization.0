Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08347C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 09:29:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582D764EA4
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 09:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582D764EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E90536F496;
	Wed,  3 Mar 2021 09:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VsG2oMc6FEOF; Wed,  3 Mar 2021 09:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A11CC605E5;
	Wed,  3 Mar 2021 09:29:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82E4FC000A;
	Wed,  3 Mar 2021 09:29:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 376FAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1AEEA400AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uw8DfuOyL6W5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:29:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F9E6400C3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614763766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQ5HWFqCt6l/tZL52G902MPl7/JbF2jYnfDG3OTQT9w=;
 b=P/d7XpDMxdNqEJdqLv47zNshdsvdrVnw15ISpRqme48mKOX75aE8leOVX7EoJ2CxXtcA0V
 gxtjs59T03bcw2boFWeD8Mjzx7yINV6fli3sMFKcPCeyh8hMOzUd1etWF66TcLhsqVeeeV
 Vkw6RQ4X/f6OH2+WvF2C+1OxwX3MSFM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-cwxutNNBM0i0dyaT_PveVA-1; Wed, 03 Mar 2021 04:29:25 -0500
X-MC-Unique: cwxutNNBM0i0dyaT_PveVA-1
Received: by mail-ed1-f72.google.com with SMTP id u2so11808681edj.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 01:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FQ5HWFqCt6l/tZL52G902MPl7/JbF2jYnfDG3OTQT9w=;
 b=neZ3MXPgqxBrwg7QoQtLpMFQlyMji0C1UfM/o2oFiHCgjt2TmexEELTXvqIup1C7/s
 YElswiAYpfRf2Jq/nQ9M1I6sF9INkA4/OXhaqKMtgW2tTcshF84PFLkHc1aXlgVJM73L
 HSaXmaxBbngElwYSEGFi4ic16tyEXFTC8MC8XdbGvwqUSe+MxfX6XT3atYWOno1/WNuM
 sS/BXAf/+u1kP2fgolEzWdvT1I7Ax3TpTAkRyn6gylirfFPunKfd71o8LvOISn4qmIkj
 sekOo/IVFibkYPaaFb5dYbdsyJZfxwrqBg6bANqB0Ecf2+W4Ydv4z4itjXqHpyvenuDX
 LZwg==
X-Gm-Message-State: AOAM530UoDu8cw1x8bFLcRS+K5pl5jH0hVz85649Cn+PPEE092RJhWD9
 XPhbaqWoYZfdeokglX7RsSaq0GyaE1Ni/oxKZlni7uD1DwNUd/JygutwVP3QczkiIq1Mq21vZv+
 STFzy7hzA6BdJcNOvMdApyFPz60X1NRNI6Xvt4EcF3A==
X-Received: by 2002:a05:6402:10cd:: with SMTP id
 p13mr23729429edu.22.1614763763975; 
 Wed, 03 Mar 2021 01:29:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/zkW4jZfHTJiJ+HE8o7tDJmTdWE2L8rrYR6SkRVLVPJYoQVyaK9S6dXlzWrNPBfnye5eBPw==
X-Received: by 2002:a05:6402:10cd:: with SMTP id
 p13mr23729421edu.22.1614763763807; 
 Wed, 03 Mar 2021 01:29:23 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id c26sm18211231edx.22.2021.03.03.01.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 01:29:23 -0800 (PST)
Date: Wed, 3 Mar 2021 04:29:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated
 random MAC address
Message-ID: <20210303042750-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
 <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
 <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
 <20210301080731-mutt-send-email-mst@kernel.org>
 <20210301131951.GA196924@mtl-vdi-166.wap.labs.mlnx>
 <20210301110937-mutt-send-email-mst@kernel.org>
 <20210302053919.GB227464@mtl-vdi-166.wap.labs.mlnx>
 <DM6PR12MB43302B0E28AEFDD8A1620D11DC989@DM6PR12MB4330.namprd12.prod.outlook.com>
 <20210303063350.GA29123@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210303063350.GA29123@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBNYXIgMDMsIDIwMjEgYXQgMDg6MzM6NTBBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIFdlZCwgTWFyIDAzLCAyMDIxIGF0IDA1OjU5OjUwQU0gKzAyMDAsIFBhcmF2IFBhbmRp
dCB3cm90ZToKPiA+IEhpIEVsaSwKPiA+IAo+ID4gPiBGcm9tOiBFbGkgQ29oZW4gPGVsaWNAbnZp
ZGlhLmNvbT4KPiA+ID4gU2VudDogVHVlc2RheSwgTWFyY2ggMiwgMjAyMSAxMTowOSBBTQo+ID4g
PiAKPiA+ID4gT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMTE6MTI6MzNBTSAtMDUwMCwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDAzOjE5
OjUxUE0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgTWFyIDAxLCAy
MDIxIGF0IDA4OjA5OjQ4QU0gLTA1MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4g
PiA+ID4gT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDk6MDg6MjhBTSArMDIwMCwgRWxpIENvaGVu
IHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDA1OjExOjIzUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
T24gMjAyMS8yLzI0IDI6MTgg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+ID4gPiA+
ID4gPiA+IEZyb206IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiBVc2UgYSByYW5kb21seSBnZW5lcmF0ZWQgTUFDIGFkZHJlc3Mg
dG8gYmUgYXBwbGllZCBpbiBjYXNlCj4gPiA+ID4gPiA+ID4gPiA+IGl0IGlzIG5vdCBjb25maWd1
cmVkIGJ5IG1hbmFnZW1lbnQgdG9vbC4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gVGhlIHZhbHVlIHF1ZXJpZWQgdGhyb3VnaCBtbHg1X3F1ZXJ5X25pY192cG9ydF9tYWNfYWRk
cmVzcygpCj4gPiA+ID4gPiA+ID4gPiA+IGlzIG5vdCByZWxlbGF2bnQgdG8gdmRwYSBzaW5jZSBp
dCBpcyB0aGUgbWFjIHRoYXQgc2hvdWxkIGJlCj4gPiA+ID4gPiA+ID4gPiA+IHVzZWQgYnkgdGhl
IHJlZ3VsYXIgTklDIGRyaXZlci4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gPiA+ID4gPiA+ID4g
PiA+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYyB8IDUgKy0tLS0KPiA+ID4gPiA+ID4gPiA+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPiA+ID4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXggYjY3YmJhNTgxZGZkLi5lY2UyMTgzZTdiMjAg
MTAwNjQ0Cj4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYwo+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTIwMDUsMTAgKzIwMDUsNyBAQCBzdGF0aWMg
aW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdAo+ID4gPiB2ZHBhX21nbXRfZGV2ICp2X21kZXYs
IGNvbnN0IGNoYXIgKm5hbWUpCj4gPiA+ID4gPiA+ID4gPiA+ICAgCWlmIChlcnIpCj4gPiA+ID4g
PiA+ID4gPiA+ICAgCQlnb3RvIGVycl9tdHU7Cj4gPiA+ID4gPiA+ID4gPiA+IC0JZXJyID0gbWx4
NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MobWRldiwgMCwgMCwgY29uZmlnLQo+ID4gPiA+
bWFjKTsKPiA+ID4gPiA+ID4gPiA+ID4gLQlpZiAoZXJyKQo+ID4gPiA+ID4gPiA+ID4gPiAtCQln
b3RvIGVycl9tdHU7Cj4gPiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4gPiA+ID4gKwlldGhf
cmFuZG9tX2FkZHIoY29uZmlnLT5tYWMpOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSSB0
aGluayB0aGlzIHBhdGNoIGlzIG1pc3Npbmcgc2V0dGluZyBWSVJUSU9fTkVUX0ZfTVRVLiBJIHdp
bGwKPiA+ID4gPiA+ID4gPiBwb3N0IHYyIHdpdGggdGhlIG90aGVyIGZpeGVzIGluIHRoaXMgc2Vy
aWVzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHdo
eSB0aGlzIGlzIGEgZ29vZCBpZGVhLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJZiB1c2Vyc3Bh
Y2Ugd2FudHMgYSByYW5kb20gbWFjIGl0IGNhbiBzZXQgaXQsIHdpdGggdGhpcyBwYXRjaCBpdAo+
ID4gPiA+ID4gPiBpcyBpbXBvc3NpYmxlIHRvIGtub3cgd2hldGhlciB0aGUgbWFjIGlzIGEgaGFy
ZHdhcmUgb25lICh3aGljaAo+ID4gPiA+ID4gPiB3aWxsIGJlIHBlcnNpc3RlbnQgZS5nLiBhY3Jv
c3MgcmVib290cykgb3IgYSByYW5kb20gb25lLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
PiA+IFlvdSBjYW4gc3RpbGwgZ2V0IGEgcGVyc2lzdGVudCBNQUMgc2V0IGJ5IHRoZSB2ZHBhIHRv
b2wuIGUuZwo+ID4gPiA+ID4KPiA+ID4gPiA+IHZkcGEgZGV2IGNvbmZpZyBzZXQgdmRwYTAgbWFj
IDAwOjExOjIyOjMzOjQ0OjU1Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSWYgeW91IGRvbid0IHVzZSB2
ZHBhIHRvb2wsIHRoZSBkZXZpY2UgYXNzaWducyBhIHJhbmRvbSBNQUMuIFRoaXMKPiA+ID4gPiA+
IE1BQyBpcyB1c2VkIHRvIGZpbHRlciBpbWNvbWluZyB1bmljYXN0IHRyYWZmaWMgKGRvbmUgaW4g
YSBzdWJzZXF1ZW50Cj4gPiA+IHBhdGNoKS4KPiA+ID4gPgo+ID4gPiA+IFdlbGwgcHJldmlvdXNs
eSBkZXZpY2UgbGVhcm5lZCB0aGUgTUFDIGZyb20gb3V0Z29pbmcgdHJhZmZpYyBhbmQgdXNlZAo+
ID4gPiA+IHRoYXQgZm9yIHRoZSBmaWx0ZXIuCj4gPiA+IAo+ID4gPiBObywgd2FzIGlzIGFkZGVk
IG9ubHkgaW4gdGhlIGxhc3Qgc2VyaWVzIHRoYXQgUGFyYXYgc2VuZC4gQmVmb3JlIHRoYXQgdGhl
Cj4gPiA+IGRldmljZSBkaWQgbm90IGZpbHRlciBhbmQgZm9yd2FyZGVkIGFueSBwYWNrZXQgdGhh
dCB3YXMgZm9yd2FyZGVkIHRvIGl0IGJ1eQo+ID4gPiB0aGUgZXN3aXRjaC4KPiA+ID4gCj4gPiA+
ID4gSXMgY2hhbmdpbmcgdGhhdCB0byBhIHJhbmRvbSB2YWx1ZSByZWFsbHkgYWxsIHRoYXQgdXNl
ZnVsIGFzIGEKPiA+ID4gPiBkZWZhdWx0PyAgV2h5IG5vdCBkbyB0aGUgcmFuZG9taXphdGlvbiBp
biB1c2Vyc3BhY2U/Cj4gPiA+ID4KPiA+ID4gCj4gPiA+IEkgdGhpbmsgd2Ugd2FudCBtYW5hZ2Vt
ZW50IGVudGl0eSB0byBzZXQgdGhlIE1BQywgdGhhdCdzIHRoZSBWRFBBIHRvb2wuCj4gPiA+IFNv
IGFzIHRoaW5ncyBhcmUgcmlnaHQgbm93ICh3aXRoIHRoZSBsYXN0IHNlcmllcyBhcHBsaWVkKSwg
dGhlIHZkcGEgdG9vbCBpcyB0aGUKPiA+ID4gdG9vbCB0byBhc3NpZ24gTUFDIGFkZHJlc3NlcyBh
bmQgaWYgaXQgZG9lc24ndCwgYSBkZXZpY2UgcmFuZG9tbHkgZ2VuZXJhdGVkCj4gPiA+IE1BQyBh
cHBsaWVzLiBDdXJyZW50bHkgTUFDIGFkZHJlc3NlcyBzZXQgYnkgcWVtdSBjb21tYW5kIGxpbmUg
YXJlCj4gPiA+IGlnbm9yZWQgKHNldF9jb25maWcgaXMgbm90IGltcGxlbWVudGQpLiBXZSBjYW4g
YWxsb3cgdGhpcyBidXQgdGhpcyB3aWxsCj4gPiA+IG92ZXJyaWRlIHZkcGEgdG9vbCBjb25maWd1
cmF0aW9uLgo+ID4gCj4gPiBJIGJlbGlldmUgaXRzIGluY29ycmVjdCB0byBhbHdheXMgZG8gcmFu
ZG9tIGdlbmVyYXRlZCBtYWMgYXMgb2YgdGhpcyBwYXRjaC4KPiA+IFRoaXMgaXMgYmVjYXVzZSwg
ZG9pbmcgc28gaWdub3JlcyBhbnkgYWRtaW4gY29uZmlnIGRvbmUgYnkgdGhlIHN5c2FkbWluIG9u
IHRoZSBzd2l0Y2ggKG92cyBzaWRlKSB1c2luZyBbMV0uCj4gPiAKPiBXZWxsLCB3aGVuIHRoaXMg
cGF0Y2ggd2FzIHNlbnQsIHdlIHN0aWxsIGhhZCB0aG91Z2h0cyB0byBsZXQgbWx4NWUgTklDCj4g
YW5kIHRoZSBWRFBBIHRvIGNvLWV4aXN0IG9uIHRoZSBzYW1lIGZ1bmN0aW9uIChWRiBvciBTRiku
IE5vdyB0aGF0IHdlJ3JlCj4gb2ZmIHRoaXMgaWRlYSB5b3UgY2FuIGJlY29tZSB0ZW1wdGVkIHRv
IHVzZSB0aGUgTUFDIGFkZHJlc3MgY29uZmlndXJlZAo+IGZvciB0aGUgTklDIGJ1dCBJIGRvbid0
IHRoaW5rIGl0J3MgYSBnb29kIGlkZWEuIFdlIGFscmVhZHkgaGF2ZSBhCj4gZGVkaWNhdGVkIHRv
b2wgdG8gY29uZmlndXJlIE1BQyBmb3IgVkRQQSBzbyBsZXQncyB1c2UgaXQuCgpSaWdodC4gQW5k
IHVzZXJzIGNhbiBkZWNpZGUgdG8gcmV1c2UgdGhlIGhhcmR3YXJlIE1BQyBpZiB0aGV5IHdhbnQg
dG8uCgo+ID4gU28gaWYgdXNlciBjaG9vc2UgdG8gY29uZmlndXJlIHVzaW5nIGVzd2l0Y2ggY29u
ZmlnLCBtbHg1X3ZuZXQgdG8gaG9ub3IgdGhhdC4KPiA+IEFuZCBpZiB1c2VyIHByZWZlcnMgdG8g
b3ZlcnJpZGUgaXMgdXNpbmcgdmRwYSB0b29sIG9yIHNldF9jb25maWcgZnJvbSBRRU1VIHNpZGUs
IHNvIGJlIGl0Lgo+IAo+IEkgYWdyZWUgdGhhdCB3ZSBzaG91bGQgbGV0IHRoZSB1c2VyIHRvIGNv
bmZpZ3VyZSB0aGUgTUFDIHRocm91Z2ggcWVtdQo+IGFyZ3VtZW50IHdoZW4gYm9vdGluZyB0aGUg
Vk0uIFNvIEknbGwgYWRkIHRoaXMgZm9yIHRoZSBuZXh0IHNwaW4gb2YgdGhpcwo+IHNlcmllcy4K
Ck9LIHNvCi0gaWYgTUFDIGlzIGNvbmZpZ3VyZWQgaXQgaXMgdXNlZAotIGlmIG5vdCBjb25maWd1
cmVkIDAgaXMgcmVwb3J0ZWQgdG8gdXNlcnNwYWNlCgpmYWlyIHN1bW1hcnk/Cgo+ID4gSGVuY2Us
IGluc3RlYWQgb2YgcmVwb3J0aW5nIGFsbCB6ZXJvcywgbWx4NSBzaG91bGQgcXVlcnkgb3duIHZw
b3J0IGNvbnRleHQgYW5kIHB1Ymxpc2ggdGhhdCBtYWMgaW4gdGhlIGNvbmZpZyBsYXlvdXQgYW5k
IHJ4IHN0ZWVyaW5nIHNpZGUuCj4gPiAKPiA+IElmIHVzZXIgY2hvb3NlIHRvIG92ZXJyaWRlIGl0
LCBjb25maWcgbGF5b3V0IGFuZCByeCBydWxlcyB3aWxsIGhhdmUgdG8gdXBkYXRlZCBvbiBzdWNo
IGNvbmZpZy4KPiA+IAo+ID4gWzFdIGRldmxpbmsgcG9ydCBmdW5jdGlvbiBzZXQgcGNpLzAwMDA6
MDM6MDAuMC88cG9ydF9pZF9vZl9zZi92Zj4vIGh3X2FkZHIgMDA6MTE6MjI6MzM6NDQ6NTUKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
