Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEC7C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 03:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E4EAE405AD;
	Tue, 28 Mar 2023 03:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4EAE405AD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Znh9byUZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wW8I-3AePvSm; Tue, 28 Mar 2023 03:14:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6327E400EC;
	Tue, 28 Mar 2023 03:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6327E400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 227BAC007C;
	Tue, 28 Mar 2023 03:14:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FED6C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E7BF8191E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E7BF8191E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Znh9byUZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fV8g4ZfEnYds
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4459C81E91
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4459C81E91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679973264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfSd4iprB6xpdvDd+tF+/DbujSEekae1K8j4YlTNtK0=;
 b=Znh9byUZV/IVjJQXCDv5ZbPe+BJTX/zKPuTmQPosQcC4gwIWcPSN2FGlAj/g+uopgd0qox
 klhypw7ZXLasJW1sAZJ6DS9U+yg7B21rOOByXXxMpLmtL8//rmbNjWxzyp1Pj7ayC+o+10
 Wy/O3BYria6U4fEWiut+8WNEP8MYq0U=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-cf3Yv0gHPq2jYMivt7PUeQ-1; Mon, 27 Mar 2023 23:14:22 -0400
X-MC-Unique: cf3Yv0gHPq2jYMivt7PUeQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 z133-20020a4a498b000000b0053b5c4e33c5so2642369ooa.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 20:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679973262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfSd4iprB6xpdvDd+tF+/DbujSEekae1K8j4YlTNtK0=;
 b=hzCGoRK4QrGOquB7BBqrqOStCQhtG6bRQgjnchDE1m0BOFDo1+MyDdoWg4tpXwdJ8f
 67WaXB35CAuAuUpEQl/GdwY4/7B5poOu5QXfpSj8fQ46NKRsJ2dpvgy23l+vCW64OgOK
 HUhtzjKTGVnYaH23B5hrGQLknKi9MdmAHUXSptDiVz0wBahKRKqRoXdDQ4FLkSF8SEJC
 oPNNZByOYCXiu31vgXZVjLuLIrLTrAfFjFjZ4DhQfaLnNrRxXEJxxPkiVTbZsskCLESw
 TbKOfjOtTLwtoIpqrLqL+NHAhE2sFh7rNwd02+NVkNhMM4rtEO8ndOJ4cV8u75kTtrDg
 sYLA==
X-Gm-Message-State: AO0yUKUXFFKwYmaNl9U+0mi5V745KqYT8OZjJPLZzp9cO1WBcFMh7nVa
 TLZcZM7ehutgpcA3v4B1Nl44YNDJSh48oT+eAmtx/Sh1qsPiMc17lSPCeCZMsXJbvKEE/t+lD5Z
 PwLi1JWLqPiVcAS/s/ex07HY2wLp0gVWFFNUXCmIPvJRoHxId9hzyC91FEA==
X-Received: by 2002:a05:6871:4983:b0:17e:e3b2:6d99 with SMTP id
 tx3-20020a056871498300b0017ee3b26d99mr3938745oab.9.1679973262033; 
 Mon, 27 Mar 2023 20:14:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set83X5uRalp/q1Az1aXoaYAcjZMuoq/FCcOLJr4KBwApiTagb5if8djVQwLei3LjA/chntfq8CUYDDNtc/l5cAA=
X-Received: by 2002:a05:6871:4983:b0:17e:e3b2:6d99 with SMTP id
 tx3-20020a056871498300b0017ee3b26d99mr3938742oab.9.1679973261812; Mon, 27 Mar
 2023 20:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
In-Reply-To: <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 11:14:10 +0800
Message-ID: <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTE6MDPigK9BTSBZb25namkgWGllIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCAyOjI44oCv
UE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVGh1
LCBNYXIgMjMsIDIwMjMgYXQgMTozMeKAr1BNIFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFu
Y2UuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gVG8gc3VwcG9ydCBpbnRlcnJ1cHQgYWZmaW5pdHkg
c3ByZWFkaW5nIG1lY2hhbmlzbSwKPiA+ID4gdGhpcyBtYWtlcyB1c2Ugb2YgZ3JvdXBfY3B1c19l
dmVubHkoKSB0byBjcmVhdGUKPiA+ID4gYW4gaXJxIGNhbGxiYWNrIGFmZmluaXR5IG1hc2sgZm9y
IGVhY2ggdmlydHF1ZXVlCj4gPiA+IG9mIHZkcGEgZGV2aWNlLiBUaGVuIHdlIHdpbGwgdW5pZnkg
c2V0X3ZxX2FmZmluaXR5Cj4gPiA+IGNhbGxiYWNrIHRvIHBhc3MgdGhlIGFmZmluaXR5IHRvIHRo
ZSB2ZHBhIGRldmljZSBkcml2ZXIuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25n
amkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+ID4KPiA+IFRoaW5raW5nIGhhcmQgb2YgYWxs
IHRoZSBsb2dpY3MsIEkgdGhpbmsgSSd2ZSBmb3VuZCBzb21ldGhpbmcgaW50ZXJlc3RpbmcuCj4g
Pgo+ID4gQ29tbWl0IGFkNzE0NzNkOWM0MzcgKCJ2aXJ0aW9fYmxrOiB1c2UgdmlydGlvIElSUSBh
ZmZpbml0eSIpIHRyaWVzIHRvCj4gPiBwYXNzIGlycV9hZmZpbml0eSB0byB0cmFuc3BvcnQgc3Bl
Y2lmaWMgZmluZF92cXMoKS4gIFRoaXMgc2VlbXMgYQo+ID4gbGF5ZXIgdmlvbGF0aW9uIHNpbmNl
IGRyaXZlciBoYXMgbm8ga25vd2xlZGdlIG9mCj4gPgo+ID4gMSkgd2hldGhlciBvciBub3QgdGhl
IGNhbGxiYWNrIGlzIGJhc2VkIG9uIGFuIElSUQo+ID4gMikgd2hldGhlciBvciBub3QgdGhlIGRl
dmljZSBpcyBhIFBDSSBvciBub3QgKHRoZSBkZXRhaWxzIGFyZSBoaWRlZCBieQo+ID4gdGhlIHRy
YW5zcG9ydCBkcml2ZXIpCj4gPiAzKSBob3cgbWFueSB2ZWN0b3JzIGNvdWxkIGJlIHVzZWQgYnkg
YSBkZXZpY2UKPiA+Cj4gPiBUaGlzIG1lYW5zIHRoZSBkcml2ZXIgY2FuJ3QgYWN0dWFsbHkgcGFz
cyBhIHJlYWwgYWZmaW5pdHkgbWFza3Mgc28gdGhlCj4gPiBjb21taXQgcGFzc2VzIGEgemVybyBp
cnEgYWZmaW5pdHkgc3RydWN0dXJlIGFzIGEgaGludCBpbiBmYWN0LCBzbyB0aGUKPiA+IFBDSSBs
YXllciBjYW4gYnVpbGQgYSBkZWZhdWx0IGFmZmluaXR5IGJhc2VkIHRoYXQgZ3JvdXBzIGNwdXMg
ZXZlbmx5Cj4gPiBiYXNlZCBvbiB0aGUgbnVtYmVyIG9mIE1TSS1YIHZlY3RvcnMgKHRoZSBjb3Jl
IGxvZ2ljIGlzIHRoZQo+ID4gZ3JvdXBfY3B1c19ldmVubHkpLiBJIHRoaW5rIHdlIHNob3VsZCBm
aXggdGhpcyBieSByZXBsYWNpbmcgdGhlCj4gPiBpcnFfYWZmaW5pdHkgc3RydWN0dXJlIHdpdGgK
PiA+Cj4gPiAxKSBhIGJvb2xlYW4gbGlrZSBhdXRvX2NiX3NwcmVhZGluZwo+ID4KPiA+IG9yCj4g
Pgo+ID4gMikgcXVldWUgdG8gY3B1IG1hcHBpbmcKPiA+Cj4KPiBCdXQgb25seSB0aGUgZHJpdmVy
IGtub3dzIHdoaWNoIHF1ZXVlcyBhcmUgdXNlZCBpbiB0aGUgY29udHJvbCBwYXRoCj4gd2hpY2gg
ZG9uJ3QgbmVlZCB0aGUgYXV0b21hdGljIGlycSBhZmZpbml0eSBhc3NpZ25tZW50LgoKSXMgdGhp
cyBrbm93bGVkZ2UgYXdhcmRlZCBieSB0aGUgdHJhbnNwb3J0IGRyaXZlciBub3c/CgpFLmcgdmly
dGlvLWJsayB1c2VzOgoKICAgICAgICBzdHJ1Y3QgaXJxX2FmZmluaXR5IGRlc2MgPSB7IDAsIH07
CgpBdGxlYXN0IHdlIGNhbiB0ZWxsIHRoZSB0cmFuc3BvcnQgZHJpdmVyIHdoaWNoIHZxIHJlcXVp
cmVzIGF1dG9tYXRpYwppcnEgYWZmaW5pdHkuCgo+IFNvIEkgdGhpbmsgdGhlCj4gaXJxX2FmZmlu
aXR5IHN0cnVjdHVyZSBjYW4gb25seSBiZSBjcmVhdGVkIGJ5IGRldmljZSBkcml2ZXJzIGFuZAo+
IHBhc3NlZCB0byB0aGUgdmlydGlvLXBjaS92aXJ0aW8tdmRwYSBkcml2ZXIuCgpUaGlzIGNvdWxk
IGJlIG5vdCBlYXN5IHNpbmNlIHRoZSBkcml2ZXIgZG9lc24ndCBldmVuIGtub3cgaG93IG1hbnkK
aW50ZXJydXB0cyB3aWxsIGJlIHVzZWQgYnkgdGhlIHRyYW5zcG9ydCBkcml2ZXIsIHNvIGl0IGNh
bid0IGJ1aWx0IHRoZQphY3R1YWwgYWZmaW5pdHkgc3RydWN0dXJlLgoKPgo+ID4gU28gZWFjaCB0
cmFuc3BvcnQgY2FuIGRvIGl0cyBvd24gbG9naWMgYmFzZWQgb24gdGhhdC4gVGhlbiB2aXJ0aW8t
dkRQQQo+ID4gY2FuIHBhc3MgdGhhdCBwb2xpY3kgdG8gVkRVU0Ugd2hlcmUgd2Ugb25seSBuZWVk
IGEgZ3JvdXBfY3B1c19ldmVubHkoKQo+ID4gYW5kIGF2b2lkIGR1cGxpY2F0aW5nIGlycV9jcmVh
dGVfYWZmaW5pdHlfbWFza3MoKT8KPiA+Cj4KPiBJIGRvbid0IGdldCB3aHkgd2Ugd291bGQgaGF2
ZSBkdXBsaWNhdGVkIGlycV9jcmVhdGVfYWZmaW5pdHlfbWFza3MoKS4KCkkgbWVhbnQgdGhlIGNy
ZWF0ZV9hZmZpbml0eV9tYXNrcygpIGluIHBhdGNoIDMgc2VlbXMgYSBkdXBsaWNhdGlvbiBvZgpp
cnFfY3JlYXRlX2FmZmluaXR5X21hc2tzKCkuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gWW9uZ2pp
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
