Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA58C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:06:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BC760234
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BC760234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A50A685ABE;
	Tue,  2 Feb 2021 14:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJX2ov4eFj-y; Tue,  2 Feb 2021 14:06:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF3F285A49;
	Tue,  2 Feb 2021 14:06:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C29A6C0174;
	Tue,  2 Feb 2021 14:06:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDBECC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B606A20387
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HUVO6qlYDsv0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:06:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 0A1612037A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612274784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoV6WmzOM8JYFHRnbfZo8tVfL3dwzU/hINcFi1knTHc=;
 b=XdOENgkvd8cmfnUccX7rF6hlKCiuqTtBIxsmDjpZ2YR26jORetIwvgAU7qJnzJ3V2B+arW
 Gnad8E++TJ1An6rtvQIyGM+6Ms32KHnZYeGicV6u07zYVv7zRD3wLBYNJanERucDxmiafM
 hWPZrp+pK2ruN4EzDJEIAyMcdL870Po=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-DhS5mATjNZWF01Ev6rmhSQ-1; Tue, 02 Feb 2021 09:06:22 -0500
X-MC-Unique: DhS5mATjNZWF01Ev6rmhSQ-1
Received: by mail-wm1-f71.google.com with SMTP id y9so1476366wmi.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Feb 2021 06:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HoV6WmzOM8JYFHRnbfZo8tVfL3dwzU/hINcFi1knTHc=;
 b=T1GKQ/UO3ER8mm6TID3fBqqg96nzujIXB0YUmlp99uqb3sjM1BtHFSN0uHLalSSvI3
 hgB4/9LyZJoQcZ7LfkjeP0YCUBMMbCZ/72VxUq+4LDkte2/jtykcle+tm3rzcV6rcHC3
 Jn3hv4NlrI1DRW1Ty3gr63vNryUTshIwJtk1Ae7eCW2eR/8ctEy1o+690SaqIxzbY1y9
 96JqfziohmX6JNJRv+m46Q1ytdN3aaK+rj0U0T+vZ5U3bKwEP1T1y3Pkv67Ls7kGbJVw
 08eFZySzT51fwCRQEERI0HcWr1jKCZssaCHqJqynhrp4roLGeXX6k332vVrfBkdBP2od
 A4bQ==
X-Gm-Message-State: AOAM532louftgiElDrjqFlG04DPpYhDOrJXMp+PMYAmHDf9l/gd98Y+6
 +orvvlYqUBqJzqzpulD4ZUAykZmaSyX1slKBy3117buFR4w+4eShOoYMDTFeGp5gc4sPp0xllyc
 /lmzpttKPeFLItkuTI/SaMbdWwnUNVomOFi03G9KYNA==
X-Received: by 2002:a1c:2d0b:: with SMTP id t11mr3742613wmt.109.1612274781425; 
 Tue, 02 Feb 2021 06:06:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLuu9HSbHaNq2JSTJGYoIuanz10/6LwyOztA42Q7LIGokzZlY2asGRgWOD0wv1yz3mEZn6wA==
X-Received: by 2002:a1c:2d0b:: with SMTP id t11mr3742583wmt.109.1612274781204; 
 Tue, 02 Feb 2021 06:06:21 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id o124sm3431503wmb.5.2021.02.02.06.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 06:06:20 -0800 (PST)
Date: Tue, 2 Feb 2021 09:06:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Avoid unnecessary query virtqueue
Message-ID: <20210202090558-mutt-send-email-mst@kernel.org>
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-2-elic@nvidia.com>
 <CAPWQSg0XtEQ1U5N3a767Ak_naoyPdVF1CeE4r3hmN11a-aoBxg@mail.gmail.com>
 <CAPWQSg3U9DCSK_01Kzuea5B1X+Ef9JB23wBY82A3ss-UXGek_Q@mail.gmail.com>
 <9d6058d6-5ce1-0442-8fd9-5a6fe6a0bc6b@redhat.com>
 <CAPWQSg3KOAypcrs9krW8cGE7EDLTehCUCYFZMUYYNaYPH1oBZQ@mail.gmail.com>
 <20210202070055.GB232587@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210202070055.GB232587@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <siwliu.kernel@gmail.com>, lulu@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>
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

T24gVHVlLCBGZWIgMDIsIDIwMjEgYXQgMDk6MDA6NTVBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIE1vbiwgRmViIDAxLCAyMDIxIGF0IDA4OjE1OjI5UE0gLTA4MDAsIFNpLVdlaSBMaXUg
d3JvdGU6Cj4gPiBPbiBNb24sIEZlYiAxLCAyMDIxIGF0IDc6MTMgUE0gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+Cj4gPiA+IE9uIDIwMjEvMi8yIOS4
iuWNiDM6MTcsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBGZWIgMSwgMjAyMSBh
dCAxMDo1MSBBTSBTaS1XZWkgTGl1IDxzaXdsaXUua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4g
PiA+ID4+IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0IDU6NDYgQU0gRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+IHdyb3RlOgo+ID4gPiA+Pj4gc3VzcGVuZF92cSBzaG91bGQgb25seSBzdXNwZW5k
IHRoZSBWUSBvbiBub3Qgc2F2ZSB0aGUgY3VycmVudCBhdmFpbGFibGUKPiA+ID4gPj4+IGluZGV4
LiBUaGlzIGlzIGRvbmUgd2hlbiBhIGNoYW5nZSBvZiBtYXAgb2NjdXJzIHdoZW4gdGhlIGRyaXZl
ciBjYWxscwo+ID4gPiA+Pj4gc2F2ZV9jaGFubmVsX2luZm8oKS4KPiA+ID4gPj4gSG1tbSwgc3Vz
cGVuZF92cSgpIGlzIGFsc28gY2FsbGVkIGJ5IHRlYXJkb3duX3ZxKCksIHRoZSBsYXR0ZXIgb2YK
PiA+ID4gPj4gd2hpY2ggZG9lc24ndCBzYXZlIHRoZSBhdmFpbGFibGUgaW5kZXggYXMgc2F2ZV9j
aGFubmVsX2luZm8oKSBkb2Vzbid0Cj4gPiA+ID4+IGdldCBjYWxsZWQgaW4gdGhhdCBwYXRoIGF0
IGFsbC4gSG93IGRvZXMgaXQgaGFuZGxlIHRoZSBjYXNlIHRoYXQKPiA+ID4gPj4gYWdldF92cV9z
dGF0ZSgpIGlzIGNhbGxlZCBmcm9tIHVzZXJzcGFjZSAoZS5nLiBRRU1VKSB3aGlsZSB0aGUKPiA+
ID4gPj4gaGFyZHdhcmUgVlEgb2JqZWN0IHdhcyB0b3JuIGRvd24sIGJ1dCB1c2Vyc3BhY2Ugc3Rp
bGwgd2FudHMgdG8gYWNjZXNzCj4gPiA+ID4+IHRoZSBxdWV1ZSBpbmRleD8KPiA+ID4gPj4KPiA+
ID4gPj4gUmVmZXIgdG8gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzE2MDE1ODM1MTEt
MTUxMzgtMS1naXQtc2VuZC1lbWFpbC1zaS13ZWkubGl1QG9yYWNsZS5jb20vCj4gPiA+ID4+Cj4g
PiA+ID4+IHZob3N0IFZRIDAgcmluZyByZXN0b3JlIGZhaWxlZDogLTE6IFJlc291cmNlIHRlbXBv
cmFyaWx5IHVuYXZhaWxhYmxlICgxMSkKPiA+ID4gPj4gdmhvc3QgVlEgMSByaW5nIHJlc3RvcmUg
ZmFpbGVkOiAtMTogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUgKDExKQo+ID4gPiA+
Pgo+ID4gPiA+PiBRRU1VIHdpbGwgY29tcGxhaW4gd2l0aCB0aGUgYWJvdmUgd2FybmluZyB3aGls
ZSBWTSBpcyBiZWluZyByZWJvb3RlZAo+ID4gPiA+PiBvciBzaHV0IGRvd24uCj4gPiA+ID4+Cj4g
PiA+ID4+IExvb2tzIHRvIG1lIGVpdGhlciB0aGUga2VybmVsIGRyaXZlciBzaG91bGQgY292ZXIg
dGhpcyByZXF1aXJlbWVudCwgb3IKPiA+ID4gPj4gdGhlIHVzZXJzcGFjZSBoYXMgdG8gYmVhciB0
aGUgYnVyZGVuIGluIHNhdmluZyB0aGUgaW5kZXggYW5kIG5vdCBjYWxsCj4gPiA+ID4+IGludG8g
a2VybmVsIGlmIFZRIGlzIGRlc3Ryb3llZC4KPiA+ID4gPiBBY3R1YWxseSwgdGhlIHVzZXJzcGFj
ZSBkb2Vzbid0IGhhdmUgdGhlIGluc2lnaHRzIHdoZXRoZXIgdmlydCBxdWV1ZQo+ID4gPiA+IHdp
bGwgYmUgZGVzdHJveWVkIGlmIGp1c3QgY2hhbmdpbmcgdGhlIGRldmljZSBzdGF0dXMgdmlhIHNl
dF9zdGF0dXMoKS4KPiA+ID4gPiBMb29raW5nIGF0IG90aGVyIHZkcGEgZHJpdmVyIGluIHRyZWUg
aS5lLiBpZmN2ZiBpdCBkb2Vzbid0IGJlaGF2ZSBsaWtlCj4gPiA+ID4gc28uIEhlbmNlIHRoaXMg
c3RpbGwgbG9va3MgdG8gbWUgdG8gYmUgTWVsbGFub3ggc3BlY2lmaWNzIGFuZAo+ID4gPiA+IG1s
eDVfdmRwYSBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgdGhhdCBzaG91bGRuJ3QgZXhwb3NlIHRvIHVz
ZXJzcGFjZS4KPiA+ID4KPiA+ID4KPiA+ID4gU28gSSB0aGluayB3ZSBjYW4gc2ltcGx5IGRyb3Ag
dGhpcyBwYXRjaD8KPiA+IAo+ID4gWWVwLCBJIHRoaW5rIHNvLiBUbyBiZSBob25lc3QgSSBkb24n
dCBrbm93IHdoeSBpdCBoYXMgYW55dGhpbmcgdG8gZG8KPiA+IHdpdGggdGhlIG1lbW9yeSBob3Rw
bHVnIGlzc3VlLgo+IAo+IE5vIHJlbGF0aW9uLiBUaGF0J3Mgd2h5IEkgcHV0IHRoZW0gaW4gdHdv
IGRpZmZlcmVudCBwYXRjaGVzLiBPbmx5IHRoZQo+IHNlY29uZCBvbmUgaXMgdGhlIGZpeCBhcyBJ
IHN0YXRlZCBpbiB0aGUgY292ZXIgbGV0dGVyLgo+IAo+IEFueXdheSwgbGV0J3MganVzdCB0YWtl
IHRoZSBzZWNvbmQgcGF0Y2guCj4gCj4gTWljaGFlbCwgZG8geW91IG5lZWQgbWUgdG8gc2VuZCBQ
QVRDSCAyIGFnYWluIGFzIGEgc2luZ2xlIHBhdGNoIG9yIGNhbgo+IHlvdSBqdXN0IHRha2UgaXQ/
CgpQbHMgcG9zdCBmaXhlcyBzZXBhcmF0ZWx5LiBUaGFua3MhCgo+IAo+ID4gCj4gPiAtU2l3ZWkK
PiA+IAo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4KPiA+ID4gPj4gLVNpd2VpCj4gPiA+
ID4+Cj4gPiA+ID4+Cj4gPiA+ID4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZp
ZGlhLmNvbT4KPiA+ID4gPj4+IC0tLQo+ID4gPiA+Pj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgfCA4IC0tLS0tLS0tCj4gPiA+ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGRl
bGV0aW9ucygtKQo+ID4gPiA+Pj4KPiA+ID4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiA+ID4gPj4+IGluZGV4IDg4ZGRlMzQ1NWJmZC4uNTQ5ZGVkMDc0ZmYzIDEwMDY0NAo+ID4gPiA+
Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4+PiArKysg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPj4+IEBAIC0xMTQ4LDgg
KzExNDgsNiBAQCBzdGF0aWMgaW50IHNldHVwX3ZxKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxKQo+ID4gPiA+Pj4KPiA+ID4gPj4+ICAg
c3RhdGljIHZvaWQgc3VzcGVuZF92cShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0
IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cSkKPiA+ID4gPj4+ICAgewo+ID4gPiA+Pj4gLSAgICAg
ICBzdHJ1Y3QgbWx4NV92aXJ0cV9hdHRyIGF0dHI7Cj4gPiA+ID4+PiAtCj4gPiA+ID4+PiAgICAg
ICAgICBpZiAoIW12cS0+aW5pdGlhbGl6ZWQpCj4gPiA+ID4+PiAgICAgICAgICAgICAgICAgIHJl
dHVybjsKPiA+ID4gPj4+Cj4gPiA+ID4+PiBAQCAtMTE1OCwxMiArMTE1Niw2IEBAIHN0YXRpYyB2
b2lkIHN1c3BlbmRfdnEoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3Zk
cGFfdmlydHF1ZXVlICptCj4gPiA+ID4+Pgo+ID4gPiA+Pj4gICAgICAgICAgaWYgKG1vZGlmeV92
aXJ0cXVldWUobmRldiwgbXZxLCBNTFg1X1ZJUlRJT19ORVRfUV9PQkpFQ1RfU1RBVEVfU1VTUEVO
RCkpCj4gPiA+ID4+PiAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKCZuZGV2LT5tdmRl
diwgIm1vZGlmeSB0byBzdXNwZW5kIGZhaWxlZFxuIik7Cj4gPiA+ID4+PiAtCj4gPiA+ID4+PiAt
ICAgICAgIGlmIChxdWVyeV92aXJ0cXVldWUobmRldiwgbXZxLCAmYXR0cikpIHsKPiA+ID4gPj4+
IC0gICAgICAgICAgICAgICBtbHg1X3ZkcGFfd2FybigmbmRldi0+bXZkZXYsICJmYWlsZWQgdG8g
cXVlcnkgdmlydHF1ZXVlXG4iKTsKPiA+ID4gPj4+IC0gICAgICAgICAgICAgICByZXR1cm47Cj4g
PiA+ID4+PiAtICAgICAgIH0KPiA+ID4gPj4+IC0gICAgICAgbXZxLT5hdmFpbF9pZHggPSBhdHRy
LmF2YWlsYWJsZV9pbmRleDsKPiA+ID4gPj4+ICAgfQo+ID4gPiA+Pj4KPiA+ID4gPj4+ICAgc3Rh
dGljIHZvaWQgc3VzcGVuZF92cXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gPiA+ID4+
PiAtLQo+ID4gPiA+Pj4gMi4yOS4yCj4gPiA+ID4+Pgo+ID4gPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
