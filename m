Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DBFC433F5
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 08:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C42141755;
	Wed,  4 May 2022 08:21:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uB7evYlH1vzj; Wed,  4 May 2022 08:21:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0B6BC41747;
	Wed,  4 May 2022 08:21:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD9E2C0039;
	Wed,  4 May 2022 08:21:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA2C3C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3C146079E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:21:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X4pcRCtYaJlc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:21:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C67A60768
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:21:45 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id p4so879260edx.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 May 2022 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=VDdx6SnTBc/x3hqSqeoZ0OfihXfqmRqnu+owhp1Pk7I=;
 b=kXpJCcqnJXYo6DFxpZt2zaSYdj84Z1DsaCnLwkmK08s6KqjJZdJtLXR3x8+xemf0rt
 kagg3meDbbs7FjgKS5jV/iwys9PwikMXkATlAt7yil8+zr6dSRgtgJjUq0rFTrtrT/fV
 IfB3lxf+nPGsdcygoRYzCtKb71OXk73EAk734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=VDdx6SnTBc/x3hqSqeoZ0OfihXfqmRqnu+owhp1Pk7I=;
 b=lrjadM2Usxle0sGHuautzJk4jVPdHkjBA5SZiDrBC7GrciVr6LI3T21hCtnqYwGptU
 12qufmFsk3bDiVc/5GdQaFma3D5TrCoDInpsK+DfHJkcJJewvDcGEwKAVM1Bf6rQt0KV
 9QON9m54BcB0mkFUjuxdIJFtYaAHp6qB/FIWqzUhtTkDCZ4viGSG7Swdz1mUpMBR85fm
 JSmSNBVSJw/0zKQ1cpWP8+ImZIjYXdQbnwofrHBGusBvL6Tas1cHci0UyFPdzg8l93lC
 S84anVn+q1rshI9tt1Hv+H+dKiB1pUKgP+ngT5U9L8A6gv0quhm5mccEwnQdMhnRNQQA
 oMag==
X-Gm-Message-State: AOAM533BvdZxBuB5qsePbOhgEUwqttYVnoIV+RiTYHnlm3fNVbCyBDj4
 ioO0ptMODU9Gj0SmSfUPPmZXdA==
X-Google-Smtp-Source: ABdhPJzDbGmxFILJU2oICyGZqcgGQFia6s4oybWBirwH1Joi8kUfhsVPZ4FaGStFNnYRj6Z0sKsRqg==
X-Received: by 2002:a05:6402:5205:b0:427:b431:e0ed with SMTP id
 s5-20020a056402520500b00427b431e0edmr18026088edd.186.1651652503231; 
 Wed, 04 May 2022 01:21:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 cf4-20020a0564020b8400b00426488dce1dsm6209549edb.25.2022.05.04.01.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 01:21:42 -0700 (PDT)
Date: Wed, 4 May 2022 10:21:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <YnI3lE0TxLfZaQjE@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Clark <robdclark@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-11-dmitry.osipenko@collabora.com>
 <248083d2-b8f2-a4d7-099d-70a7e7859c11@suse.de>
 <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
 <YmlYHNlcmNMfOeyy@phenom.ffwll.local>
 <8f932ab0-bb72-8fea-4078-dc59e9164bd4@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8f932ab0-bb72-8fea-4078-dc59e9164bd4@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Robin Murphy <robin.murphy@arm.com>
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMDk6MzE6MDBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IEhlbGxvIERhbmllbCwKPiAKPiAyNy4wNC4yMDIyIDE3OjUwLCBEYW5pZWwgVmV0
dGVyINC/0LjRiNC10YI6Cj4gPiBPbiBNb24sIEFwciAxOCwgMjAyMiBhdCAxMDoxODo1NFBNICsw
MzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4gPj4gSGVsbG8sCj4gPj4KPiA+PiBPbiA0LzE4
LzIyIDIxOjM4LCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToKPiA+Pj4gSGkKPiA+Pj4KPiA+Pj4g
QW0gMTguMDQuMjIgdW0gMDA6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gPj4+PiBSZXBs
YWNlIGRybV9nZW1fc2htZW0gbG9ja3Mgd2l0aCB0aGUgcmVzZXJ2YXRpb24gbG9jayB0byBtYWtl
IEdFTQo+ID4+Pj4gbG9ja2luZ3MgbW9yZSBjb25zaXN0ZW50Lgo+ID4+Pj4KPiA+Pj4+IFByZXZp
b3VzbHkgZHJtX2dlbV9zaG1lbV92bWFwKCkgYW5kIGRybV9nZW1fc2htZW1fZ2V0X3BhZ2VzKCkg
d2VyZQo+ID4+Pj4gcHJvdGVjdGVkIGJ5IHNlcGFyYXRlIGxvY2tzLCBub3cgaXQncyB0aGUgc2Ft
ZSBsb2NrLCBidXQgaXQgZG9lc24ndAo+ID4+Pj4gbWFrZSBhbnkgZGlmZmVyZW5jZSBmb3IgdGhl
IGN1cnJlbnQgR0VNIFNITUVNIHVzZXJzLiBPbmx5IFBhbmZyb3N0Cj4gPj4+PiBhbmQgTGltYSBk
cml2ZXJzIHVzZSB2bWFwKCkgYW5kIHRoZXkgZG8gaXQgaW4gdGhlIHNsb3cgY29kZSBwYXRocywK
PiA+Pj4+IGhlbmNlIHRoZXJlIHdhcyBubyBwcmFjdGljYWwganVzdGlmaWNhdGlvbiBmb3IgdGhl
IHVzYWdlIG9mIHNlcGFyYXRlCj4gPj4+PiBsb2NrIGluIHRoZSB2bWFwKCkuCj4gPj4+Pgo+ID4+
Pj4gU3VnZ2VzdGVkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gPj4+PiBT
aWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEu
Y29tPgo+ID4+Pj4gLS0tCj4gPj4gLi4uCj4gPj4+PiDCoCBAQCAtMzEwLDcgKzMwNiw3IEBAIHN0
YXRpYyBpbnQgZHJtX2dlbV9zaG1lbV92bWFwX2xvY2tlZChzdHJ1Y3QKPiA+Pj4+IGRybV9nZW1f
c2htZW1fb2JqZWN0ICpzaG1lbSwKPiA+Pj4+IMKgwqDCoMKgwqAgfSBlbHNlIHsKPiA+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBwZ3Byb3RfdCBwcm90ID0gUEFHRV9LRVJORUw7Cj4gPj4+PiDCoCAt
wqDCoMKgwqDCoMKgwqAgcmV0ID0gZHJtX2dlbV9zaG1lbV9nZXRfcGFnZXMoc2htZW0pOwo+ID4+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGRybV9nZW1fc2htZW1fZ2V0X3BhZ2VzX2xvY2tlZChz
aG1lbSk7Cj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiA+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3plcm9fdXNlOwo+ID4+Pj4gwqAgQEAgLTM2MCwx
MSArMzU2LDExIEBAIGludCBkcm1fZ2VtX3NobWVtX3ZtYXAoc3RydWN0Cj4gPj4+PiBkcm1fZ2Vt
X3NobWVtX29iamVjdCAqc2htZW0sCj4gPj4+PiDCoCB7Cj4gPj4+PiDCoMKgwqDCoMKgIGludCBy
ZXQ7Cj4gPj4+PiDCoCAtwqDCoMKgIHJldCA9IG11dGV4X2xvY2tfaW50ZXJydXB0aWJsZSgmc2ht
ZW0tPnZtYXBfbG9jayk7Cj4gPj4+PiArwqDCoMKgIHJldCA9IGRtYV9yZXN2X2xvY2tfaW50ZXJy
dXB0aWJsZShzaG1lbS0+YmFzZS5yZXN2LCBOVUxMKTsKPiA+Pj4+IMKgwqDCoMKgwqAgaWYgKHJl
dCkKPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4+Pj4gwqDCoMKgwqDC
oCByZXQgPSBkcm1fZ2VtX3NobWVtX3ZtYXBfbG9ja2VkKHNobWVtLCBtYXApOwo+ID4+Pgo+ID4+
PiBXaXRoaW4gZHJtX2dlbV9zaG1lbV92bWFwX2xvY2tlZCgpLCB0aGVyZSdzIGEgY2FsbCB0byBk
bWFfYnVmX3ZtYXAoKSBmb3IKPiA+Pj4gaW1wb3J0ZWQgcGFnZXMuIElmIHRoZSBleHBvcnRlciBz
aWRlIGFsc28gaG9sZHMvYWNxdWlyZXMgdGhlIHNhbWUKPiA+Pj4gcmVzZXJ2YXRpb24gbG9jayBh
cyBvdXIgb2JqZWN0LCB0aGUgd2hvbGUgdGhpbmcgY2FuIGRlYWRsb2NrLiBXZSBjYW5ub3QKPiA+
Pj4gbW92ZSBkbWFfYnVmX3ZtYXAoKSBvdXQgb2YgdGhlIENTLCBiZWNhdXNlIHdlIHN0aWxsIG5l
ZWQgdG8gaW5jcmVtZW50Cj4gPj4+IHRoZSByZWZlcmVuY2UgY291bnRlci4gSSBob25lc3RseSBk
b24ndCBrbm93IGhvdyB0byBlYXNpbHkgZml4IHRoaXMKPiA+Pj4gcHJvYmxlbS4gVGhlcmUncyBh
IFRPRE8gaXRlbSBhYm91dCByZXBsYWNpbmcgdGhlc2UgbG9ja3MgYXQgWzFdLiBBcwo+ID4+PiBE
YW5pZWwgc3VnZ2VzdGVkIHRoaXMgcGF0Y2gsIHdlIHNob3VsZCB0YWxrIHRvIGhpbSBhYm91dCB0
aGUgaXNzdWUuCj4gPj4+Cj4gPj4+IEJlc3QgcmVnYXJkcwo+ID4+PiBUaG9tYXMKPiA+Pj4KPiA+
Pj4gWzFdCj4gPj4+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2dwdS90
b2RvLmh0bWwjbW92ZS1idWZmZXItb2JqZWN0LWxvY2tpbmctdG8tZG1hLXJlc3YtbG9jawo+ID4+
Cj4gPj4gSW5kZWVkLCBnb29kIGNhdGNoISBQZXJoYXBzIHdlIGNvdWxkIHNpbXBseSB1c2UgYSBz
ZXBhcmF0ZSBsb2NrIGZvciB0aGUKPiA+PiB2bWFwcGluZyBvZiB0aGUgKmltcG9ydGVkKiBHRU1z
PyBUaGUgdm1hcF91c2VfY291bnQgaXMgdXNlZCBvbmx5IGJ5Cj4gPj4gdm1hcC92dW5tYXAsIHNv
IGl0IGRvZXNuJ3QgbWF0dGVyIHdoaWNoIGxvY2sgaXMgdXNlZCBieSB0aGVzZSBmdW5jdGlvbnMK
PiA+PiBpbiB0aGUgY2FzZSBvZiBpbXBvcnRlZCBHRU1zIHNpbmNlIHdlIG9ubHkgbmVlZCB0byBw
cm90ZWN0IHRoZQo+ID4+IHZtYXBfdXNlX2NvdW50Lgo+ID4gCj4gPiBBcG9sb2dpZXMgZm9yIHRo
ZSBsYXRlIHJlcGx5LCBJJ20gZmxvb2RlZC4KPiA+IAo+ID4gSSBkaXNjdXNzZWQgdGhpcyB3aXRo
IERhbmllbCBTdG9uZSBsYXN0IHdlZWsgaW4gYSBjaGF0LCByb3VnaGx5IHdoYXQgd2UKPiA+IG5l
ZWQgdG8gZG8gaXM6Cj4gPiAKPiA+IDEuIFBpY2sgYSBmdW5jdGlvbiBmcm9tIHNobWVtIGhlbHBl
cnMuCj4gPiAKPiA+IDIuIEdvIHRocm91Z2ggYWxsIGRyaXZlcnMgdGhhdCBjYWxsIHRoaXMsIGFu
ZCBtYWtlIHN1cmUgdGhhdCB3ZSBhY3F1aXJlCj4gPiBkbWFfcmVzdl9sb2NrIGluIHRoZSB0b3Ag
bGV2ZWwgZHJpdmVyIGVudHJ5IHBvaW50IGZvciB0aGlzLgo+ID4gCj4gPiAzLiBPbmNlIGFsbCBk
cml2ZXIgY29kZSBwYXRocyBhcmUgY29udmVydGVkLCBhZGQgYSBkbWFfcmVzdl9hc3NlcnRfaGVs
ZCgpCj4gPiBjYWxsIHRvIHRoYXQgZnVuY3Rpb24gdG8gbWFrZSBzdXJlIHlvdSBoYXZlIGl0IGFs
bCBjb3JyZWN0bHkuCj4gPiA0LiBSZXBlYXRlIDEtMyB1bnRpbCBhbGwgc2htZW0gaGVscGVyIGZ1
bmN0aW9ucyBhcmUgY29udmVydGVkIG92ZXIuCj4gU29tZWhvdyBJIGRpZG4ndCBub3RpY2UgdGhl
IGV4aXN0ZW5jZSBvZiBkbWFfcmVzdl9hc3NlcnRfaGVsZCgpLCB0aGFuawo+IHlvdSBmb3IgdGhl
IHN1Z2dlc3Rpb24gOikKPiAKPiA+IAo+ID4gNS4gRGl0Y2ggdGhlIDMgZGlmZmVyZW50IHNobWVt
IGhlbHBlciBsb2Nrcy4KPiA+IAo+ID4gVGhlIHRyb3VibGUgaXMgdGhhdCBJIGZvcmdvdCB0aGF0
IHZtYXAgaXMgYSB0aGluZywgc28gdGhhdCBuZWVkcyBtb3JlCj4gPiB3b3JrLiBJIHRoaW5rIHRo
ZXJlJ3MgdHdvIGFwcHJvYWNoZXMgaGVyZToKPiA+IC0gRG8gdGhlIHZtYXAgYXQgaW1wb3J0IHRp
bWUuIFRoaXMgaXMgdGhlIHRyaWNrIHdlIHVzZWQgdG8gdW50YW5nbGUgdGhlCj4gPiAgIGRtYV9y
ZXN2X2xvY2sgaXNzdWVzIGFyb3VuZCBkbWFfYnVmX2F0dGFjaG1lbnRfbWFwKCkKPiAKPiA+IC0g
Q2hhbmdlIHRoZSBkbWFfYnVmX3ZtYXAgcnVsZXMgdGhhdCBjYWxsZXJzIG11c3QgaG9sZCB0aGUg
ZG1hX3Jlc3ZfbG9jay4KPiAKPiBJJ2xsIGNvbnNpZGVyIHRoaXMgb3B0aW9uIGZvciB2NiwgdGhh
bmsgeW91Lgo+IAo+IEkgc2VlIG5vdyB0aGF0IHlvdSBhY3R1YWxseSB3YW50IHRvIGRlZmluZSB0
aGUgbmV3IHJ1bGVzIGZvciB0aGUKPiBkbWEtYnVmcyBpbiBnZW5lcmFsIGFuZCBub3Qgb25seSBp
biB0aGUgY29udGV4dCBvZiB0aGUgRFJNIGNvZGUsIHRoaXMKPiBub3cgbWFrZXMgbXVjaCBtb3Jl
IHNlbnNlIHRvIG1lLgoKWWVhaCBkbWEtYnVmIGlzIGEgY3Jvc3MgZHJpdmVyIGludGVyZmFjZSwg
c28gd2Ugc2hvdWxkIHRyeSB0byBiZQpjb25zaXN0ZW50IGhlcmUuIFdlIGRpZG4ndCBkbyB0aGlz
IGluIHRoZSBwYXN0LCB3aGVyZSB0aGUgb25seSByZWFzb24geW91CmRpZG4ndCBnZXQgbG9ja2Rl
cCBzcGxhdHMgd2FzIGJlY2F1c2UgeW91IG5vcm1hbGx5IGRpZG4ndCBydW4gYWxsIHBvc3NpYmxl
CmNvbWJpbmF0aW9ucyBvZiBkcml2ZXJzIGFuZCBpbXBvcnRlci9leHBvcnRlciByZWxhdGlvbnNo
aXBzIGluIG9uZSBzeXN0ZW0uCkJ1dCB0aGF0IG1lYW5zIGl0IGJlY29tZXMgdmVyeSB0cmlja3kg
dG8gcmVhc29uIGFib3V0IGhvdyBkbWEtYnVmIHJlYWxseQp3b3Jrcy4KCj4gPiAtIE1heWJlIGFs
c28gZG8gd2hhdCB5b3Ugc3VnZ2VzdCBhbmQga2VlcCBhIHNlcGFyYXRlIGxvY2sgZm9yIHRoaXMs
IGJ1dAo+ID4gICB0aGUgZnVuZGFtZW50YWwgaXNzdWUgaXMgdGhhdCB0aGlzIGRvZXNuJ3QgcmVh
bGx5IHdvcmsgLSBpZiB5b3Ugc2hhcmUKPiA+ICAgYnVmZmVycyBib3RoIHdheXMgd2l0aCB0d28g
ZHJpdmVycyB1c2luZyBzaG1lbSBoZWxwZXJzLCB0aGVuIHRoZQo+ID4gICBvcmRlcmluZyBvZiB0
aGlzIHZtYXBfY291bnRfbXV0ZXggdnMgZG1hX3Jlc3ZfbG9jayBpcyBpbmNvbnNpc3RlbnQgYW5k
Cj4gPiAgIHlvdSBjYW4gZ2V0IHNvbWUgbmljZSBkZWFkbG9ja3MuIFNvIG5vdCBhIGdyZWF0IGFw
cHJvYWNoIChhbmQgYWxzbyB0aGUKPiA+ICAgcmVhc29uIHdoeSB3ZSByZWFsbHkgbmVlZCB0byBn
ZXQgZXZlcnlvbmUgdG8gbW92ZSB0b3dhcmRzIGRtYV9yZXN2X2xvY2sKPiA+ICAgYXMgX3RoZV8g
YnVmZmVyIG9iamVjdCBsb2NrLCBzaW5jZSBvdGhlcndpc2Ugd2UnbGwgbmV2ZXIgZ2V0IGEKPiA+
ICAgY29uc2lzdGVudCBsb2NrIG5lc3RpbmcgaGllcmFyY2h5KS4KPiAKPiBUaGUgc2VwYXJhdGUg
bG9ja3Mgc2hvdWxkIHdvcmsgb2theSBiZWNhdXNlIGl0IHdpbGwgYmUgYWx3YXlzIHRoZQo+IGV4
cG9ydGVyIHRoYXQgdGFrZXMgdGhlIGRtYV9yZXN2X2xvY2suIEJ1dCBJIGFncmVlIHRoYXQgaXQn
cyBsZXNzIGlkZWFsCj4gdGhhbiBkZWZpbmluZyB0aGUgbmV3IHJ1bGVzIGZvciBkbWEtYnVmcyBz
aW5jZSBzb21ldGltZSB5b3Ugd2lsbCB0YWtlCj4gdGhlIHJlc3YgbG9jayBhbmQgc29tZXRpbWUg
bm90LCBwb3RlbnRpYWxseSBoaWRpbmcgYnVncyByZWxhdGVkIHRvIGxvY2tpbmdzLgoKVGhhdCdz
IHRoZSBpc3N1ZSwgc29tZSBpbXBvcnRlcnMgbmVlZCB0byB0YWtlIHRoZSBkbWFfcmVzdl9sb2Nr
IGZvcgpkbWFfYnVmX3ZtYXAgdG9vIChlLmcuIHRvIGZpcnN0IG5haWwgdGhlIGJ1ZmZlciBpbiBw
bGFjZSB3aGVuIGl0J3MgYQpkeW5hbWljIG1lbW9yeSBtYW5hZ2VyKS4gSW4gcHJhY3RpY2UgaXQn
bGwgd29yayBhcyB3ZWxsIGFzIHdoYXQgd2UgaGF2ZQpjdXJyZW50bHksIHdoaWNoIGlzIHNpbWls
YXJseSBpbmNvbnNpc3RlbnQsIGV4Y2VwdCB3aXRoIHBlci1kcml2ZXIgbG9ja3MKaW5zdGVhZCBv
ZiBzaGFyZWQgbG9ja3MgZnJvbSBzaG1lbSBoZWxwZXJzIG9yIGRtYS1idWYsIHNvIGxlc3Mgb2J2
aW91cwp0aGF0IHRoaW5ncyBhcmUgaW5jb25zaXN0ZW50LgoKU28geWVhaCBpZiBpdCdzIHRvbyBt
ZXNzeSBtYXliZSB0aGUgYXBwcm9hY2ggaXMgdG8gaGF2ZSBhIHNlcGFyYXRlIGxvY2sKZm9yIHZt
YXAgZm9yIG5vdywgbGFuZCB0aGluZ3MsIGFuZCB0aGVuIGZpeCB1cCBkbWFfYnVmX3ZtYXAgaW4g
YSBmb2xsb3cgdXAKc2VyaWVzLgotRGFuaWVsCgo+ID4gVGhlIHRyb3VibGUgaGVyZSBpcyB0aGF0
IHRyeWluZyB0byBiZSBjbGV2ZXIgYW5kIGRvaW5nIHRoZSBjb252ZXJzaW9uIGp1c3QKPiA+IGlu
IHNobWVtIGhlbHBlcnMgd29udCB3b3JrLCBiZWNhdXNlIHRoZXJlJ3MgYSBsb3Qgb2YgY2FzZXMg
d2hlcmUgdGhlCj4gPiBkcml2ZXJzIGFyZSBhbGwga2luZHMgb2YgaW5jb25zaXN0ZW50IHdpdGgg
dGhlaXIgbG9ja2luZy4KPiA+IAo+ID4gQWRkaW5nIERhbmllbCBTLCBhbHNvIG1heWJlIGZvciBx
dWVzdGlvbnMgaXQnZCBiZSBmYXN0ZXN0IHRvIGNoYXQgb24gaXJjPwo+IAo+IE15IG5pY2tuYW1l
IGlzIGRpZ2V0eCBvbiB0aGUgI2RyaS1kZXZlbCBjaGFubmVsLCBmZWVsIGZyZWUgdG8gcGluZyBt
ZSBpZgo+IG5lZWRlZC4gUmlnaHQgbm93IHlvdXJzIHN1Z2dlc3Rpb25zIGFyZSBjbGVhciB0byBt
ZSwgaGVuY2Ugbm8gZXh0cmEKPiBxdWVzdGlvbnMuCj4gCj4gVGhhbmsgeW91IGZvciB0aGUgcmV2
aWV3LgoKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0
aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
