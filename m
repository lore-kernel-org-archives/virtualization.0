Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8A7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 04:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E2A060E03;
	Tue, 11 Jan 2022 04:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BdzdidFRmBl2; Tue, 11 Jan 2022 04:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD1D260E0A;
	Tue, 11 Jan 2022 04:47:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF8CC0030;
	Tue, 11 Jan 2022 04:47:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D72BC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23CB581773
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LDrWEf_v-rjZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF675814B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641876418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kvs2RYLn44eYa7XiHQBlAEEyjlfOGEqGUQwD3PUPuX0=;
 b=QVjhfvkNt9q4Y268N4R5DNaWD8FIdokfk8Nm75d1e50oqo4TDBOOi5RVOI2zXWTV3anGyb
 vIksQz41tM26iPAFqxThFfuPb7v3rSF8IOK+8SLpkXLijkAW195iR7ZyXoA7oItPwNI4PP
 kJYR1FE0Pi8ClJIOpAgYPDYPvpgMaqM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-FFMMWjAIOHid28a7YRyViQ-1; Mon, 10 Jan 2022 23:46:52 -0500
X-MC-Unique: FFMMWjAIOHid28a7YRyViQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 n7-20020a056512388700b0042a063bb38cso8041521lft.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 20:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kvs2RYLn44eYa7XiHQBlAEEyjlfOGEqGUQwD3PUPuX0=;
 b=D9ogwx4UTkDe8HoCgrDfVOTPQgf/3H1sMf9QpdpA2ssiB8HmzL7zR6wVuSF0S/6ViM
 fKbb9Q8BwoFTYl5++gPlj2Q55/Rw3by2WosXWfy4n6EeCQ2zqyudBmzrjActnwCO/+/z
 ljDqLxDGKAnwp6A5RJNvlQb5vBWFdiOWAKAEQVLryI1hi0fX5rzfrL0qCyTIVoAUX7wy
 laI9kUZfa5X19OzLEyiZoX4ftb1kWdCZzgpY0mnlayE4BhVG6e+EEVfbxGw8CL5LosLN
 BHnZz+jgicgHf5fOj0H3E7P+g/8BoYqZOM0CdSWQ3OVS/vnwddFhlxtx31+YI95fGpfu
 HooA==
X-Gm-Message-State: AOAM531wd20I0nyryYAZ1ksrjDSbB9HmcHoBrR1oplFrfxGqoJzOCR4L
 Zy4xIu738H+MrPAfWEYTOwV2fkyNxdWqZEOx8nztZZqLcNFuC+m6eRQi8vgWnudRZn/xP/azt36
 UT9zhxk5rLzJjjpZEr5A3E4qLk+S09HV29N4uH7REXiRacefxHrslRNw5Yw==
X-Received: by 2002:a19:760f:: with SMTP id c15mr2087678lff.498.1641876410865; 
 Mon, 10 Jan 2022 20:46:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFMMTvaYh0/AmienL3bhbFUczuGQ0JzPCFuARYz6bb4fEU6d1gxJ7NYUwwryDb7gew1g4CdaHDYvbFLeMkRWI=
X-Received: by 2002:a19:760f:: with SMTP id c15mr2087662lff.498.1641876410643; 
 Mon, 10 Jan 2022 20:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
 <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
 <3af55c17-49ad-bc9f-1b96-0a59b2ba1856@redhat.com>
 <a4fefb05-958b-743c-87da-652420b98e70@oracle.com>
In-Reply-To: <a4fefb05-958b-743c-87da-652420b98e70@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jan 2022 12:46:39 +0800
Message-ID: <CACGkMEvgQ-Qq36Ldgu7aNBaZ85ERQbaFfW4CY0i3so8NzpcAGA@mail.gmail.com>
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgOTozMCBBTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9y
YWNsZS5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDEvOS8yMDIyIDEwOjA1IFBNLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIyLzEvOCDkuIrljYg5OjIzLCBTaS1XZWkgTGl1IOWGmemB
kzoKPiA+Pgo+ID4+Cj4gPj4gT24gMS82LzIwMjIgOTowOCBQTSwgSmFzb24gV2FuZyB3cm90ZToK
PiA+Pj4KPiA+Pj4g5ZyoIDIwMjIvMS83IOS4iuWNiDg6MzMsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+
ID4+Pj4KPiA+Pj4+Cj4gPj4+PiBPbiAxLzUvMjAyMiAzOjQ2IEFNLCBFbGkgQ29oZW4gd3JvdGU6
Cj4gPj4+Pj4gQWRkIHdyYXBwZXJzIHRvIGdldC9zZXQgc3RhdHVzIGFuZCBwcm90ZWN0IHRoZXNl
IG9wZXJhdGlvbnMgd2l0aAo+ID4+Pj4+IGNmX211dGV4IHRvIHNlcmlhbGl6ZSB0aGVzZSBvcGVy
YXRpb25zIHdpdGggcmVzcGVjdCB0byBnZXQvc2V0IGNvbmZpZwo+ID4+Pj4+IG9wZXJhdGlvbnMu
Cj4gPj4+Pj4KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4KPiA+Pj4+PiAtLS0KPiA+Pj4+PiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgICAgICAgICAgfCAx
OSArKysrKysrKysrKysrKysrKysrCj4gPj4+Pj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAg
ICAgIHwgIDcgKysrLS0tLQo+ID4+Pj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8
ICAzICstLQo+ID4+Pj4+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICB8ICAzICsrKwo+
ID4+Pj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQo+ID4+Pj4+Cj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2
ZXJzL3ZkcGEvdmRwYS5jCj4gPj4+Pj4gaW5kZXggNDJkNzFkNjBkNWRjLi41MTM0YzgzYzRhMjIg
MTAwNjQ0Cj4gPj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+ID4+Pj4+ICsrKyBiL2Ry
aXZlcnMvdmRwYS92ZHBhLmMKPiA+Pj4+PiBAQCAtMjEsNiArMjEsMjUgQEAgc3RhdGljIExJU1Rf
SEVBRChtZGV2X2hlYWQpOwo+ID4+Pj4+ICAgc3RhdGljIERFRklORV9NVVRFWCh2ZHBhX2Rldl9t
dXRleCk7Cj4gPj4+Pj4gICBzdGF0aWMgREVGSU5FX0lEQSh2ZHBhX2luZGV4X2lkYSk7Cj4gPj4+
Pj4gICArdTggdmRwYV9nZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiA+Pj4+
PiArewo+ID4+Pj4+ICsgICAgdTggc3RhdHVzOwo+ID4+Pj4+ICsKPiA+Pj4+PiArICAgIG11dGV4
X2xvY2soJnZkZXYtPmNmX211dGV4KTsKPiA+Pj4+PiArICAgIHN0YXR1cyA9IHZkZXYtPmNvbmZp
Zy0+Z2V0X3N0YXR1cyh2ZGV2KTsKPiA+Pj4+PiArICAgIG11dGV4X3VubG9jaygmdmRldi0+Y2Zf
bXV0ZXgpOwo+ID4+Pj4+ICsgICAgcmV0dXJuIHN0YXR1czsKPiA+Pj4+PiArfQo+ID4+Pj4+ICtF
WFBPUlRfU1lNQk9MKHZkcGFfZ2V0X3N0YXR1cyk7Cj4gPj4+Pj4gKwo+ID4+Pj4+ICt2b2lkIHZk
cGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPiA+Pj4+
PiArewo+ID4+Pj4+ICsgICAgbXV0ZXhfbG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+ID4+Pj4+ICsg
ICAgdmRldi0+Y29uZmlnLT5zZXRfc3RhdHVzKHZkZXYsIHN0YXR1cyk7Cj4gPj4+Pj4gKyAgICBt
dXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4KTsKPiA+Pj4+PiArfQo+ID4+Pj4+ICtFWFBPUlRf
U1lNQk9MKHZkcGFfc2V0X3N0YXR1cyk7Cj4gPj4+Pj4gKwo+ID4+Pj4+ICAgc3RhdGljIHN0cnVj
dCBnZW5sX2ZhbWlseSB2ZHBhX25sX2ZhbWlseTsKPiA+Pj4+PiAgICAgc3RhdGljIGludCB2ZHBh
X2Rldl9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkKQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4+Pj4gaW5kZXggZWJhYTM3
M2U5YjgyLi5kOWQ0OTk0NjVlMmUgMTAwNjQ0Cj4gPj4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92
ZHBhLmMKPiA+Pj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4+Pj4+IEBAIC0xNDIs
MTAgKzE0Miw5IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2RldmljZV9pZChzdHJ1Y3QK
PiA+Pj4+PiB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKmFyZ3ApCj4gPj4+Pj4gICBzdGF0aWMg
bG9uZyB2aG9zdF92ZHBhX2dldF9zdGF0dXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU4Cj4gPj4+
Pj4gX191c2VyICpzdGF0dXNwKQo+ID4+Pj4+ICAgewo+ID4+Pj4+ICAgICAgIHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gPj4+Pj4gLSAgICBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4gPj4+Pj4gICAgICAgdTggc3RhdHVzOwo+
ID4+Pj4+ICAgLSAgICBzdGF0dXMgPSBvcHMtPmdldF9zdGF0dXModmRwYSk7Cj4gPj4+Pj4gKyAg
ICBzdGF0dXMgPSB2ZHBhX2dldF9zdGF0dXModmRwYSk7Cj4gPj4+PiBOb3Qgc3VyZSB3aHkgd2Ug
bmVlZCB0byB0YWtlIGNmX211dGV4IGhlcmUuIEFwcGVhcnMgdG8gbWUgb25seQo+ID4+Pj4gc2V0
dGVycyAoc2V0X3N0YXR1cyBhbmQgcmVzZXQpIG5lZWQgdG8gdGFrZSB0aGUgbG9jayBpbiB0aGlz
IGZ1bmN0aW9uLgo+ID4+Pgo+ID4+Pgo+ID4+PiBZb3UgbWF5IGJlIHJpZ2h0IGJ1dCBpdCBkb2Vz
bid0IGhhcm0gYW5kIGl0IGlzIGd1YXJhbnRlZWQgdG8gYmUKPiA+Pj4gY29ycmVjdCBpZiB3ZSBw
cm90ZWN0IGl0IHdpdGggbXV0ZXggaGVyZS4KPiA+PiBJcyBpdCBtb3JlIGZvciBmdXR1cmUgcHJv
b2Y/Cj4gPgo+ID4KPiA+IEkgdGhpbmsgc28uCj4KPiBJIGd1ZXNzIGluIHRoaXMgc2l0dWF0aW9u
IGl0IHdvdWxkIGJlIGJldHRlciBkZWZlciB0byB0aGUgZnV0dXJlIHBhdGNoCj4gdG8gYWRkIHN1
Y2ggbG9ja2luZyBvciB3cmFwcGVyLCBhbHRob3VnaCByaWdodCBub3cgdGhlcmUgYXJlIGp1c3Qg
dHdvCj4gYWRkaXRpb25hbCBjYWxscyB0YWtpbmcgdGhlIGxvY2sgbmVlZGxlc3NseSB3aGVuIHZo
b3N0X3ZkcGFfZ2V0X3N0YXR1cwo+IGlzIGNhbGxlZC4gTWF5YmUgaXQncyBqdXN0IG1lIGJ1dCBJ
J20gd29ycmllZCBzb21lIGZ1dHVyZSBwYXRjaCBtYXkKPiBjYWxscyB0aGUgbG9ja2VkIEFQSSB3
cmFwcGVyIHRob3VzYW5kcyBvZiB0aW1lcyB1bmludGVuZGVkbHksIHRoZW4gdGhlCj4gb3Zlcmhl
YWQgYmVjb21lcyBxdWl0ZSBvYnZpb3VzLgoKSSdtIGZpbmUgdG8gcmVtb3ZlIHRoaXMgaWYgb3Ro
ZXJzIGFncmVlIG9uIHRoaXMuCgo+Cj4gPgo+ID4KPiA+PiBPaywgYnV0IElNSE8gaXQgbWlnaHQg
YmUgYmV0dGVyIHRvIGdldCBzb21lIGNvbW1lbnQgaGVyZSwgb3RoZXJ3aXNlCj4gPj4gaXQncyBx
dWl0ZSBjb25mdXNpbmcgd2h5IHRoZSBsb2NrIG5lZWRzIHRvIGJlIGhlbGQuIHZob3N0X3ZkcGEg
aGFkCj4gPj4gZG9uZSBpdHMgb3duIHNlcmlhbGl6YXRpb24gaW4gdmhvc3RfdmRwYV91bmxvY2tl
ZF9pb2N0bCgpIHRocm91Z2gKPiA+PiB2aG9zdF9kZXZgbXV0ZXguCj4gPgo+ID4KPiA+IFJpZ2h0
LCBidXQgdGhleSBhcmUgZG9uZSBmb3IgZGlmZmVyZW50IGxldmVscywgb25lIGlzIGZvciB2aG9z
dF9kZXYKPiA+IGFudG9oZXIgaXMgZm9yIHZkcGFfZGV2Lgo+IFRoZSBjZl9tdXRleCBpcyBpbnRy
b2R1Y2VkIHRvIHNlcmlhbGl6ZSB0aGUgY29tbWFuZCBsaW5lIGNvbmZpZ3VyZQo+IHRocmVhZCAo
dmlhIG5ldGxpbmspIGFuZCB0aGUgdXBzdHJlYW0gZHJpdmVyIGNhbGxzIGZyb20gZWl0aGVyIHRo
ZQo+IHZob3N0X2RldiBvciB2aXJ0aW9fZGV2LiBJIGRvbid0IHNlZSBhIGNhc2UsIGV2ZW4gaW4g
ZnV0dXJlLCB3aGVyZSB0aGUKPiBuZXRsaW5rIHRocmVhZCBuZWVkcyB0byB1cGRhdGUgdGhlIHZp
cnRpbyBzdGF0dXMgb24gdGhlIGZseS4gQ2FuIHlvdQo+IGVubGlnaHRlbiBtZSB3aHkgdGhhdCBp
cyBhdCBhbGwgcG9zc2libGU/CgpBZnRlciBzb21lIHRob3VnaHQgSSBkb24ndCBzZWUgYSBjYXNl
LiBJIGNhbiB0aGluayBvZiBORUVEU19SRVNFVCBidXQKaXQgc2hvdWxkIGNvbWUgd2l0aCBhIGNv
bmZpZyBpbnRlcnJ1cHQgc28gd2UncmUgcHJvYmFibHkgZmluZSB3aXRob3V0CnRoZSBtdXRleCBo
ZXJlLgoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+IC1TaXdlaQo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+
Cj4gPj4KPiA+PiAtU2l3ZWkKPiA+Pgo+ID4+Pgo+ID4+PiBUaGFua3MKPiA+Pj4KPiA+Pj4KPiA+
Pj4+Cj4gPj4+Pj4gICAgICAgICBpZiAoY29weV90b191c2VyKHN0YXR1c3AsICZzdGF0dXMsIHNp
emVvZihzdGF0dXMpKSkKPiA+Pj4+PiAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7Cj4gPj4+Pj4g
QEAgLTE2NCw3ICsxNjMsNyBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9zdGF0dXMoc3Ry
dWN0Cj4gPj4+Pj4gdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ID4+Pj4+ICAg
ICAgIGlmIChjb3B5X2Zyb21fdXNlcigmc3RhdHVzLCBzdGF0dXNwLCBzaXplb2Yoc3RhdHVzKSkp
Cj4gPj4+Pj4gICAgICAgICAgIHJldHVybiAtRUZBVUxUOwo+ID4+Pj4+ICAgLSAgICBzdGF0dXNf
b2xkID0gb3BzLT5nZXRfc3RhdHVzKHZkcGEpOwo+ID4+Pj4+ICsgICAgc3RhdHVzX29sZCA9IHZk
cGFfZ2V0X3N0YXR1cyh2ZHBhKTsKPiA+Pj4+IERpdHRvLgo+ID4+Pj4KPiA+Pj4+PiAgICAgICAg
IC8qCj4gPj4+Pj4gICAgICAgICogVXNlcnNwYWNlIHNob3VsZG4ndCByZW1vdmUgc3RhdHVzIGJp
dHMgdW5sZXNzIHJlc2V0IHRoZQo+ID4+Pj4+IEBAIC0xODIsNyArMTgxLDcgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdAo+ID4+Pj4+IHZob3N0X3ZkcGEgKnYsIHU4
IF9fdXNlciAqc3RhdHVzcCkKPiA+Pj4+PiAgICAgICAgICAgaWYgKHJldCkKPiA+Pj4+PiAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7Cj4gPj4+Pj4gICAgICAgfSBlbHNlCj4gPj4+Pj4gLSAgICAg
ICAgb3BzLT5zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4gPj4+Pj4gKyAgICAgICAgdmRwYV9z
ZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4gPj4+PiBUaGUgcmVzZXQoKSBjYWxsIGluIHRoZSBp
ZiBicmFuY2ggYWJvdmUgbmVlZHMgdG8gdGFrZSB0aGUgY2ZfbXV0ZXgsCj4gPj4+PiB0aGUgc2Ft
ZSB3YXkgYXMgdGhhdCBmb3Igc2V0X3N0YXR1cygpLiBUaGUgcmVzZXQoKSBpcyBlZmZlY3RpdmVs
eQo+ID4+Pj4gc2V0X3N0YXR1cyh2ZHBhLCAwKS4KPiA+Pj4+Cj4gPj4+PiBUaGFua3MsCj4gPj4+
PiAtU2l3ZWkKPiA+Pj4+Cj4gPj4+Pj4gICAgICAgICBpZiAoKHN0YXR1cyAmIFZJUlRJT19DT05G
SUdfU19EUklWRVJfT0spICYmICEoc3RhdHVzX29sZCAmCj4gPj4+Pj4gVklSVElPX0NPTkZJR19T
X0RSSVZFUl9PSykpCj4gPj4+Pj4gICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBudnFzOyBpKysp
Cj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+Pj4+
PiBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+Pj4+PiBpbmRleCBhODRiMDRiYTMx
OTUuLjc2NTA0NTU5YmMyNSAxMDA2NDQKPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fdmRwYS5jCj4gPj4+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4+
Pj4+IEBAIC05MSw5ICs5MSw4IEBAIHN0YXRpYyB1OCB2aXJ0aW9fdmRwYV9nZXRfc3RhdHVzKHN0
cnVjdAo+ID4+Pj4+IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPj4+Pj4gICBzdGF0aWMgdm9pZCB2
aXJ0aW9fdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4+Pj4+
IHU4IHN0YXR1cykKPiA+Pj4+PiAgIHsKPiA+Pj4+PiAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEgPSB2ZF9nZXRfdmRwYSh2ZGV2KTsKPiA+Pj4+PiAtICAgIGNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiA+Pj4+PiAgIC0gICAgcmV0dXJuIG9w
cy0+c2V0X3N0YXR1cyh2ZHBhLCBzdGF0dXMpOwo+ID4+Pj4+ICsgICAgcmV0dXJuIHZkcGFfc2V0
X3N0YXR1cyh2ZHBhLCBzdGF0dXMpOwo+ID4+Pj4+ICAgfQo+ID4+Pj4+ICAgICBzdGF0aWMgdm9p
ZCB2aXJ0aW9fdmRwYV9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+Pj4+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
ID4+Pj4+IGluZGV4IDljYzQyOTFhNzliMy4uYWUwNDdmYWUyNjAzIDEwMDY0NAo+ID4+Pj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBh
LmgKPiA+Pj4+PiBAQCAtNDA4LDYgKzQwOCw5IEBAIHZvaWQgdmRwYV9nZXRfY29uZmlnKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwKPiA+Pj4+PiB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ID4+Pj4+
ICAgICAgICAgICAgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbik7Cj4gPj4+Pj4gICB2
b2lkIHZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKmRldiwgdW5zaWduZWQgaW50
IG9mZnNldCwKPiA+Pj4+PiAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpidWYsIHVuc2lnbmVk
IGludCBsZW5ndGgpOwo+ID4+Pj4+ICt1OCB2ZHBhX2dldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2KTsKPiA+Pj4+PiArdm9pZCB2ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2LCB1OCBzdGF0dXMpOwo+ID4+Pj4+ICsKPiA+Pj4+PiAgIC8qKgo+ID4+Pj4+ICAg
ICogc3RydWN0IHZkcGFfbWdtdGRldl9vcHMgLSB2ZHBhIGRldmljZSBvcHMKPiA+Pj4+PiAgICAq
IEBkZXZfYWRkOiBBZGQgYSB2ZHBhIGRldmljZSB1c2luZyBhbGxvYyBhbmQgcmVnaXN0ZXIKPiA+
Pj4+Cj4gPj4+Cj4gPj4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
