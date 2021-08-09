Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D24C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:05:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED6C61055
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BED6C61055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A1FA401EC;
	Mon,  9 Aug 2021 07:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H2MVoYm4HRTm; Mon,  9 Aug 2021 07:05:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F3D02401DE;
	Mon,  9 Aug 2021 07:05:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C03DAC0010;
	Mon,  9 Aug 2021 07:05:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E37DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 491546060C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnUIzvVt8kUG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:05:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 174FF605E0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628492746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9OWU+v2+Cdsj4ViviSBcr5XQgotEftgI5tYitF22B8=;
 b=DDnze+adHwcdUz+72PR51aOR119kYVxG+xgMEqjHyCNBj4RrqvdezwUPyEyLue/TBf9EyV
 zGzdKovX+kc1vyKJx4gz5P1OUULXPqpBMHm/8KNrC8dSwo8etiDMsbs+9zcV71wTNzuywg
 gD+tBwifeyF06netS+H2cAgnNtZBa/A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-4p2U4bLnNUCDNbynhEEk6A-1; Mon, 09 Aug 2021 03:05:45 -0400
X-MC-Unique: 4p2U4bLnNUCDNbynhEEk6A-1
Received: by mail-lj1-f199.google.com with SMTP id
 e4-20020a05651c0904b029018bc821fd31so3535472ljq.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 00:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+9OWU+v2+Cdsj4ViviSBcr5XQgotEftgI5tYitF22B8=;
 b=V9oxxHVwssntNnCrLDsftbHm2kXFh2BcemORixYgR5HNxhX4THaars/PiyPsTqgV9v
 f4qg2vzsj4WdIyguW/uMC3SY4AoxY6uclLUk0/KKHgQAmQ3Ej8vM4REA38s5DaB2P62m
 btWqfcC4AEFwQCjMqJhUdgBUSerA7iRNQTisr4d2KVLSIylZgqsa25mluDc46QqCWh85
 HBJbvxLPRRQ/MTh5rHkyrPiDj8mDoPrSEOW5PgJy4+q1Gaxp7MBBeYOhpPVHbRVW0C76
 92CK4npya2lp7tRfDVGksKr0GP9+AKlWpncBjZLf2hE1cHofKtwDTdR/z+lF2hVUHmPL
 1hgA==
X-Gm-Message-State: AOAM531jOu1FCaiK4XC+SDrcDIMtJD6ELqA6F7Rdml1OlQtAwV2QPUQ1
 HlvuV2wPXFMl6f58U3XkqI7AremwyyZymfZof9rfwZL+GFpaR55dYF62CkLMmWsqRb4R/tcO/sO
 8Om5xoZhnh8NBO73pzNMPmGw4n0nsarNoGSsGQAhj2Bc7NW9pkVh5obub1g==
X-Received: by 2002:a19:e00b:: with SMTP id x11mr16493788lfg.436.1628492744147; 
 Mon, 09 Aug 2021 00:05:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLYVl7TPxwZ2OkM3xczK6raJa6TlEJZJw3B4NmfGV5Bf77t5HwEzipJXINGd7JBLqPIdjqVb/k2lQzW3Jj6ds=
X-Received: by 2002:a19:e00b:: with SMTP id x11mr16493712lfg.436.1628492742702; 
 Mon, 09 Aug 2021 00:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
 <20210809052121.GA209158@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481F74DCC09018C476D7262DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809055748.GA210406@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481E4454B3785A40AB8A181DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809060746.GA210718@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB54813DD5B2E36DEF5364C1A5DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54813DD5B2E36DEF5364C1A5DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Aug 2021 15:05:31 +0800
Message-ID: <CACGkMEvqOBL40h7wRq9atZ=L6DwR_CuSE_ZTZ4aMHnuSxNbKSw@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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

T24gTW9uLCBBdWcgOSwgMjAyMSBhdCAyOjEwIFBNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4KPgo+Cj4gPiBGcm9tOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4K
PiA+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDksIDIwMjEgMTE6MzggQU0KPiA+Cj4gPiBPbiBNb24s
IEF1ZyAwOSwgMjAyMSBhdCAwOTowMTo0OEFNICswMzAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4g
PiA+Cj4gPiA+Cj4gPiA+ID4gRnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gPiA+
ID4gU2VudDogTW9uZGF5LCBBdWd1c3QgOSwgMjAyMSAxMToyOCBBTQo+ID4gPiA+Cj4gPiA+ID4g
T24gTW9uLCBBdWcgMDksIDIwMjEgYXQgMDg6NDI6NThBTSArMDMwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEZyb206IEVsaSBDb2hlbiA8ZWxp
Y0BudmlkaWEuY29tPgo+ID4gPiA+ID4gPiBTZW50OiBNb25kYXksIEF1Z3VzdCA5LCAyMDIxIDEw
OjUxIEFNCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIE1vbiwgQXVnIDA5LCAyMDIxIGF0IDEx
OjA3OjUwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiDlnKggMjAyMS84LzYg5LiL5Y2INDo1NSwgUGFyYXYgUGFuZGl0IOWGmemBkzoKPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDYsIDIw
MjEgMjoxMiBQTQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiAgIGVudW0gdmRw
YV9hdHRyIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMzMsNiArMzQsMTYgQEAgZW51bSB2ZHBh
X2F0dHIgewo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIFZEUEFfQVRUUl9ERVZfTUFYX1ZRUywg
ICAgICAgICAgICAgICAgICAvKiB1MzIgKi8KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBWRFBB
X0FUVFJfREVWX01BWF9WUV9TSVpFLCAgICAgICAgICAgICAgLyogdTE2ICovCj4gPiA+ID4gPiA+
ID4gPiA+ID4gKyAgICAgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIsCj4gPiAgICAgICAv
Kgo+ID4gPiA+ID4gPiBiaW5hcnkgKi8KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICBWRFBBX0FU
VFJfREVWX05FVF9TVEFUVVMsICAgICAgICAgICAgICAgLyogdTgKPiA+ICovCj4gPiA+ID4gPiA+
ID4gPiA+ID4gKyAgICAgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsCj4gPiAgICAgICAv
Kgo+ID4gPiA+ID4gPiB1MTYgKi8KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICBWRFBBX0FUVFJf
REVWX05FVF9DRkdfTVRVLCAgICAgICAgICAgICAgLyoKPiA+IHUxNiAqLwo+ID4gPiA+ID4gPiA+
ID4gPiA+ICsgICAgIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19TUEVFRCwgICAgICAgICAgICAvKgo+
ID4gdTE2ICovCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZH
X0RVUExFWCwgICAgICAgICAgIC8qCj4gPiB1MTYgKi8KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAg
ICBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01BWF9LRVlfTEVOLAo+ID4gICAgICAgLyogdTgK
PiA+ID4gPiA+ID4gKi8KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICBWRFBBX0FUVFJfREVWX05F
VF9DRkdfUlNTX01BWF9JVF9MRU4sCj4gPiAgICAgICAvKgo+ID4gPiA+ID4gPiB1MTYgKi8KPiA+
ID4gPiA+ID4gPiA+ID4gPiArICAgICBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX0hBU0hfVFlQ
RVMsCj4gPiAgICAgICAvKgo+ID4gPiA+ID4gPiB1MzIgKi8KPiA+ID4gPiA+ID4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgLyogbmV3IGF0dHJpYnV0ZXMgbXVzdCBiZSBhZGRl
ZCBhYm92ZSBoZXJlICovCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgVkRQQV9BVFRSX01BWCwK
PiA+ID4gPiA+ID4gPiA+ID4gPiAgIH07Cj4gPiA+ID4gPiA+ID4gPiA+IFRoZSBwb2ludCBpcyB0
byB0cnkgYW5kIG5vdCByZWludmVudCBhIGRlZGljYXRlZCB2cGRhCj4gPiA+ID4gPiA+ID4gPiA+
IGludGVyZmFjZSB3aGVyZSBhIGdlbmVyaWMgb25lIGV4aXRzLgo+ID4gPiA+ID4gPiA+ID4gPiBF
LmcuIGZvciBwaHkgdGhpbmdzIHN1Y2ggYXMgbWFjIHNwZWVkIGV0YywgSSB0aGluayBtb3N0Cj4g
PiA+ID4gPiA+ID4gPiA+IHBlb3BsZSBhcmUgdXNpbmcgZXRodG9vbCB0aGluZ3MgcmlnaHQ/Cj4g
PiA+ID4gPiA+ID4gPiBBcyB5b3Uga25vdyB2ZHBhIGlzIHRoZSBiYWNrZW5kIGRldmljZSBmb3Ig
dGhlIGZyb250LWVuZAo+ID4gPiA+ID4gPiA+ID4gbmV0ZGV2aWNlCj4gPiA+ID4gPiA+IGFjY2Vz
c2VkIGJ5IHRoZSBldGh0b29sLgo+ID4gPiA+ID4gPiA+ID4gdmRwYSBtYW5hZ2VtZW50IHRvb2wg
aGVyZSBpcyBjb21wb3NpbmcgdGhlIHZkcGEgZGV2aWNlLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IEZvciBleGFtcGxlIGNyZWF0b3IgKGh5cGVydmlzb3IpIG9mIHRoZSB2ZHBhIGRl
dmljZXMga25vd3MKPiA+ID4gPiA+ID4gPiA+IHRoYXQgYSBndWVzdCBWTSBpcyBnaXZlbiA0IHZj
cHVzLCBTbyBoeXBlcnZpc29yIGNyZWF0ZXMgYQo+ID4gPiA+ID4gPiA+ID4gdmRwYSBkZXZpY2Vz
IHdpdGggY29uZmlnIHNwYWNlIGxheW91dCBhcywgbWF4X3ZpcnRxdWV1ZV9wYWlycyA9Cj4gPiA0
Lgo+ID4gPiA+ID4gPiA+ID4gQW5kIHRoZSBNQUMgYWRkcmVzcyBjaG9zZW4gYnkgaHlwZXJ2aXNv
ciBpbiBtYWNbNl0uCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gR3Vlc3QgVk0gZXRo
dG9vbCBjYW4gc3RpbGwgY2hvc2UgdG8gdXNlIGxlc3MgbnVtYmVyIG9mIGNoYW5uZWxzLgo+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFR5cGljYWxseSwKPiA+ID4gPiA+ID4gPiA+IGV0
aHRvb2wgaXMgZm9yIGd1ZXN0IFZNLgo+ID4gPiA+ID4gPiA+ID4gdmRwYSBkZXZpY2UgaXMgaW4g
aHlwZXZpc29yLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEhvdyBjYW4gaHlwZXJ2
aXNvciBjb21wb3NlIGEgdmRwYSBkZXZpY2Ugd2l0aG91dCBhbnkgdG9vbD8KPiA+ID4gPiA+ID4g
PiA+IEhvdyBjYW4gaXQgdGVsbCBldGh0b29sLCB3aGF0IGlzIHN1cHBvcnRlZCBhbmQgd2hhdCBh
cmUgdGhlCj4gPiBkZWZhdWx0cz8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gUmVyZWFkIHRoZSBjb3ZlciBsZXR0ZXI6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiAiCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGlzIHBhdGNoc2V0IGVuYWJsZXMgdXNl
cnMgdG8gc2V0IHRoZSBtYWMgYWRkcmVzcyBhbmQgbXR1IG9mCj4gPiA+ID4gPiA+ID4gdGhlIHZk
cGEgZGV2aWNlIG9uY2UgdGhlIGRldmljZSBpcyBjcmVhdGVkLgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gIgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSXQgbG9va3MgdG8gbWUgdGhl
IG1lY2hhbmlzbSB0aGF0IGludHJvZHVjZWQgaW4gdGhlIHNlcmllcyBpcwo+ID4gPiA+ID4gPiA+
IG5vdCBmb3IgcHJvdmlzaW9uaW5nIGJ1dCBmb3IgcG9zdC1jcmVhdGlvbiBjb25maWd1cmF0aW9u
Pwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoZSBkaWZmZXJlbmNlIGlz
IHN1YnRsZS4gSW4gYm90aCBjYXNlcyB5b3UgcHJvdmlkZSBjb25maWd1cmF0aW9uLgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gSSBtdXN0IGJlIG1pc3VuZGVyc3RhbmRpbmcgeW91ciBjb21tZW50IGFib3V0IGV0aHRv
b2wuCj4gPiA+ID4gPiA+ID4gPiBDYW4geW91IHBsZWFzZSBleHBsYWluPwo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIGd1ZXNzIHRoZSBtZWFuaW5nIGlzIHRoYXQs
IGlmIHRoZSB2RFBBIGlzIGFzc2lnbmVkIHRvIGd1ZXN0LAo+ID4gPiA+ID4gPiA+IGl0J3MgdGhl
IGNoYXJnZSBvZiBndWVzdCB0byBjb25maWd1cmUgdGhlIE1UVS9NQUMvUlNTIHZpYSB0aGUKPiA+
ID4gPiA+ID4gPiBleGlzdGluZyBtYW5hZ2VtZW50IGludGVyZmFjZSBsaWtlIGV0aHRvb2wvaXBy
b3V0ZTIgbmV0bGluawo+ID4gPiA+ID4gPiA+IHByb3RvY29sLiBUaGUgY29udHJvbCB2aXJ0cXVl
dWUgaXMgZGVzaWduZWQgZm9yIHRoaXMuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gSSB3YXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCB3ZSB3YW50IHNvbWVob3cgdG8g
Y29udHJvbCB0aGUKPiA+ID4gPiA+ID4gY2FwYWJsaXR5IGlmIHRoZSBndWVzdCB0byB1c2UgYXJi
aXRyYXJ5IE1BQyBhZGRyZXNzZXMuCj4gPiA+ID4gPiA+IElmIHRoaXMgaXMgaXMgbm90IHJlcXVp
cmVkIHRoYW4gSSB0aGluayBjb250cm9sIFZRIGlzIHRoZSBtZWNoYW5pc20gdG8KPiA+IHVzZS4K
PiA+ID4gPiA+IEhvdyBkb2VzIHRoZSBndWVzdCBWTSBpZGVudGlmeSB3aGljaCB1bmlxdWUgbWFj
IGFkZHJlc3MgdG8gc2V0IG9uCj4gPiA+ID4gPiB0aGlzCj4gPiA+ID4gdmlydGlvIG5ldCBkZXZp
Y2Ugd2hlbiB0aGlzIGlzIHRoZSBvbmx5IGRldmljZSBpbiB0aGUgVk0/Cj4gPiA+ID4gPiBVc3Vh
bGx5IGh5cGVydmlzb3Iga25vd3Mgd2hhdCBtYWMgdG8gc2V0IGZvciBhIFZNLgo+ID4gPiA+Cj4g
PiA+ID4gWW91IGRvbid0IG5lZWQgdG8ga25vdy4gWW91IGNvdWxkIHVzZSBhbnkgTUFDIHlvdSB3
YW50LCBpZiBubyBvbmUKPiA+ID4gPiBlbHNlIGlzIHVzaW5nIGl0IGluIHlvdXIgc3VibmV0LCBh
bmQgZXZlcnl0aGluZyB3aWxsIHdvcmsgZmluZS4gVGhlCj4gPiA+ID4gcG9pbnQgaXMgZG8geW91
IHdhbnQgdG8gYWxsb3cgdGhlIGd1ZXN0IHRvIGNob29zZSBpdHMgTUFDLiBUaGlzIGhhcwo+ID4g
aW1wbGljYXRpb25zIG9mIHNlY3VyaXR5Lgo+ID4gPiA+Cj4gPiA+IExldHMgYXNzdW1lIGZvciBh
IG1vbWVudCB0aGF0IGEgZ3Vlc3QgVk0gaXMgYWJsZSB0byBwcm9ncmFtIGEgTUFDIG9mCj4gPiBu
ZXRkZXZpY2Ugb2YgdmlydGlvX2RldmljZSBvZiBuZXQgdHlwZS4KPiA+ID4gSG93IGRvZXMgYSBW
TSBrbm93IHRoYXQgYSByYW5kb21seSBjaG9zZW4gbWFjIGlzIG5vdCB1c2VkIGluIG5ldHdvcmsK
PiA+IHdoZW4gdGhpcyBWTSBkb2VzbuKAmXQgaGF2ZSBhbnkgZXh0ZXJuYWwgY29ubmVjdGl2aXR5
Pwo+ID4KPiA+IFRoZXJlJ3Mgbm8gZ3VyYW50ZWUKPiBIZW5jZSBhIFZGIHVzZXJzLCByZWxpZXMg
b24gdGhlIGh5cGVydmlzb3IgdG8gc2V0dXAgYSB1bmlxdWUgTUFDIGluIHRoZSBuZXR3b3JrLgo+
Cj4gQW5kIGFkdmFuY2UgZ3Vlc3QgVk0gd2hvIGhhcyBhIGRldmljZSBjYXBhYmxlIHRvIG1vZGlm
eSB0aGUgTUFDIChmb3IgYm9uZGluZyBhbmQgb3RoZXIgdXNlKSBjYW4gb3ZlcnJpZGUgdGhlIG1h
Yy4KPgo+IFNvIEkgZG9u4oCZdCBzZWUgdGhlbSBhcyBtdXR1YWxseSBleGNsdXNpdmUgY2FwYWJp
bGl0eS4KClllcywgd2UgcHJvYmFibHkgbmVlZCBib3RoLgoKQ1ZRIGZvciBwb3N0IGNyZWF0aW9u
IGNvbmZpZ3VyYXRpb24gYW5kIG5ldGxpbmsgQVBJIGZvciBwcm92aXNpb25pbmcuCgo+Cj4gPiBi
dXQgaXQncyBiZWluZyB1c2VkIGFsbCBvdmVyIGFuZCBMaW51eCBoYXMgYSBzcGVjaWZpYyBBUEkg
dG8KPiA+IGdlbmVyYXRlIHJhbmRvbSBNQUMgYWRkcmVzc2VzOiBldGhfaHdfYWRkcl9yYW5kb20o
KS4KClllcywgYnV0IGl0IHVzZXMgbG9jYWwgYXNzaWdubWVudCBiaXQsIG1hbmFnZW1lbnQgbWF5
IHdhbnQgdXNlIG90aGVycy4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
