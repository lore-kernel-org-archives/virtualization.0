Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A12FC6FD1C
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 03:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67DA941814;
	Tue, 21 Mar 2023 03:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67DA941814
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MjCWE73T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZP6JVUIDLDcm; Tue, 21 Mar 2023 03:23:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EEDCA41813;
	Tue, 21 Mar 2023 03:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEDCA41813
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF21DC0035;
	Tue, 21 Mar 2023 03:23:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30B57C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 03:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0089240A07
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 03:23:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0089240A07
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MjCWE73T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NQRHMATWHZy9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 03:22:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEED040160
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEED040160
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679368978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCYwKMX6R5Iz/9INjQhW9FwPJith15Ixurg+CWqlfdo=;
 b=MjCWE73TjW0zTHvHKmRdXgbJ09ZbUFARpYzymk0iIn0IokmYM4RA7amxA78uoX+6tBj0S6
 gy0cfvLKMLLUgfPsWjwvnBXTI8C9tTD2pZVDwtHdrho+aYrstxqwppDZUHzSnifQdMh/GZ
 0Mlp43dg9S0aVgac1Ii6p+eMkfrBtPo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-xCQ4ByOjMcyPWKzPELoEJQ-1; Mon, 20 Mar 2023 23:22:56 -0400
X-MC-Unique: xCQ4ByOjMcyPWKzPELoEJQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 bh14-20020a056808180e00b00364c7610c6aso5936356oib.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 20:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679368976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCYwKMX6R5Iz/9INjQhW9FwPJith15Ixurg+CWqlfdo=;
 b=BN/OBi0atakkXxaYeeDKIxCa5DmS8mu/Y5sZZ+ANtVbJOcxDMK6Ltj0TlQi9W7f519
 7cex1BQWMtERGtqaeyMYvIxFh5xe1fRZs5FtNfqsJG8OaHhALlXPjeJs0FCkbkO2dlbl
 0hV7zwuyzD7Z4/886hLdmCQ44vLCgG/EbOE22gRTIa4KCrCUN5uencAR7QbRuVD3Yvn5
 VjPswe8bEiRppvY4TcitqUznQoh9/9+6g8G5WzVn7z07vK3JdRejpBWU4n5zoxDxPLJX
 A2w52fQUNrLEWBSba8oq/OhcTdBwnjo7XESa0ZIkosc25SUUKX1HFOn7njnN2ZPawIqv
 6Hdg==
X-Gm-Message-State: AO0yUKXqZwhMtNtNAeMHx+SFK9biaHv0UV6rUJ+dU8vZqTArsS4dhFCU
 TPxA4D8bTE0F+/vgZXd7ekJtSpmgHqh+yux81r1l40zJpoC3a4zrgMDnVI83OBalT5mZCUmBb7Z
 RD24nKZuSFXLAVLxL/hwBGSGys70G94OCNDuzYurPzlqcNNpWMD9/qJnuCw==
X-Received: by 2002:a9d:7e8e:0:b0:69b:1bd:7f9e with SMTP id
 m14-20020a9d7e8e000000b0069b01bd7f9emr319918otp.2.1679368976251; 
 Mon, 20 Mar 2023 20:22:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set/p3KEMq77nh4v5oN/RK5vsNfyMXy68x1G+Wmh6kAflAKKs3DfTUtzT7KlhYYK7O64rkwt9MS0DQX0cD9rroBU=
X-Received: by 2002:a9d:7e8e:0:b0:69b:1bd:7f9e with SMTP id
 m14-20020a9d7e8e000000b0069b01bd7f9emr319908otp.2.1679368975993; Mon, 20 Mar
 2023 20:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230312084137.2300100-1-elic@nvidia.com>
 <CACGkMEsgyOMmVcj-5eEBtHMKqR5Z03tiuHbUK3opZQ_93tSbBw@mail.gmail.com>
 <0be81bfe-401c-6c2e-ed24-28b152a5ba7c@nvidia.com>
 <CACGkMEuQmH8FrOMyAo5YFkCi6ptavmY+HUvterWJsU_a95+QbQ@mail.gmail.com>
 <08acd652-c6f7-3099-c955-52051e10846b@nvidia.com>
In-Reply-To: <08acd652-c6f7-3099-c955-52051e10846b@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Mar 2023 11:22:45 +0800
Message-ID: <CACGkMEvfco3-MRCUwfmPTjOb26ULTZCTrPLgU8me1VRRSgQ_bw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Remove debugfs file after device unregister
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 parav@mellanox.com, mst@redhat.com
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

T24gTW9uLCBNYXIgMjAsIDIwMjMgYXQgNTozNeKAr1BNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPiB3cm90ZToKPgo+Cj4gT24gMjAvMDMvMjAyMyAxMToyOCwgSmFzb24gV2FuZyB3cm90ZToK
PiA+IE9uIE1vbiwgTWFyIDIwLCAyMDIzIGF0IDU6MDfigK9QTSBFbGkgQ29oZW4gPGVsaWNAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4gPj4gT24gMTcvMDMvMjAyMyA1OjMyLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4+PiBPbiBTdW4sIE1hciAxMiwgMjAyMyBhdCA0OjQx4oCvUE0gRWxpIENvaGVuIDxlbGlj
QG52aWRpYS5jb20+IHdyb3RlOgo+ID4+Pj4gV2hlbiBkZWxldGluZyB0aGUgdmRwYSBkZXZpY2Us
IHRoZSBkZWJ1Z2ZzIGZpbGVzIG5lZWQgdG8gYmUgcmVtb3ZlZCBzbwo+ID4+Pj4gbmVlZCB0byBy
ZW1vdmUgZGVidWdmcyBhZnRlciB0aGUgZGV2aWNlIGhhcyBiZWVuIHVucmVnaXN0ZXJlZC4KPiA+
Pj4+Cj4gPj4+PiBUaGlzIGZpeGVzIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSB3aGVuIHNvbWVv
bmUgZGVsZXRlcyB0aGUgZGV2aWNlCj4gPj4+PiBhZnRlciBkZWJ1Z2ZzIGhhcyBiZWVuIHBvcHVs
YXRlZC4KPiA+Pj4+Cj4gPj4+PiBGaXhlczogMjk0MjIxMDA0MzIyICgidmRwYS9tbHg1OiBBZGQg
ZGVidWdmcyBzdWJ0cmVlIikKPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgo+ID4+Pj4gLS0tCj4gPj4+PiAgICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgfCA0ICsrLS0KPiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4gPj4+Pgo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ID4+Pj4gaW5kZXggMzg1OGJhMWU4OTc1Li4zZjYxNDlmMmZmZDQgMTAwNjQ0Cj4gPj4+PiAt
LS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+Pj4+ICsrKyBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4+Pj4gQEAgLTMzMjIsOCArMzMyMiw2IEBA
IHN0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21k
ZXYsIHN0cnVjdCB2ZHBhX2RldmljZSAqCj4gPj4+PiAgICAgICAgICAgc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gPj4+PiAgICAgICAgICAg
c3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKndxOwo+ID4+Pj4KPiA+Pj4+IC0gICAgICAgbWx4NV92
ZHBhX3JlbW92ZV9kZWJ1Z2ZzKG5kZXYtPmRlYnVnZnMpOwo+ID4+Pj4gLSAgICAgICBuZGV2LT5k
ZWJ1Z2ZzID0gTlVMTDsKPiA+Pj4+ICAgICAgICAgICBpZiAobmRldi0+bmJfcmVnaXN0ZXJlZCkg
ewo+ID4+Pj4gICAgICAgICAgICAgICAgICAgbmRldi0+bmJfcmVnaXN0ZXJlZCA9IGZhbHNlOwo+
ID4+Pj4gICAgICAgICAgICAgICAgICAgbWx4NV9ub3RpZmllcl91bnJlZ2lzdGVyKG12ZGV2LT5t
ZGV2LCAmbmRldi0+bmIpOwo+ID4+Pj4gQEAgLTMzMzIsNiArMzMzMCw4IEBAIHN0YXRpYyB2b2lk
IG1seDVfdmRwYV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIHN0cnVjdCB2
ZHBhX2RldmljZSAqCj4gPj4+PiAgICAgICAgICAgbXZkZXYtPndxID0gTlVMTDsKPiA+Pj4+ICAg
ICAgICAgICBkZXN0cm95X3dvcmtxdWV1ZSh3cSk7Cj4gPj4+PiAgICAgICAgICAgX3ZkcGFfdW5y
ZWdpc3Rlcl9kZXZpY2UoZGV2KTsKPiA+Pj4gV2hhdCBpZiB0aGUgdXNlciB0cmllcyB0byBhY2Nl
c3MgZGVidWdmcyBhZnRlciBfdmRwYV91bnJlZ2lzdGVyX2RldmljZSgpPwo+ID4+IEkgZG9uJ3Qg
c2VlIGFuIGlzc3VlIHdpdGggdGhhdC4gRHVyaW5nIHRoZSBwcm9jZXNzIG9mIGRlbGV0aW5nIGEg
ZGV2aWNlLAo+ID4+IHRoZSByZXNvdXJjZXMgYXJlIGRlc3Ryb3llZCBhbmQgdGhlaXIgY29ycmVz
cG9uZGluZyBkZWJ1Z2ZzIGZpbGVzIGFyZQo+ID4+IGFsc28gZGVzdHJveWVkIGp1c3QgcHJpb3Ig
dG8gZGVzdHJveWluZyB0aGUgcmVzb3VyY2UuCj4gPiBGb3IgZXhhbXBsZSwgcnhfZmxvd190YWJs
ZV9zaG93KCkgcmVxdWlyZXMgdGhlIHN0cnVjdHVyZSBtbHg1X3ZkcGFfbmV0Cj4gPiBhbGl2ZSwg
YnV0IGl0IHNlZW1zIHRoZSBzdHJ1Y3R1cmUgaGFzIGJlZW4gZnJlZWQgYWZ0ZXIKPiA+IF92ZHBh
X3VucmVnaXN0ZXJfZGV2aWNlKCkuCj4gQnV0IGluIHRoaXMgY2FzZSwgcnhfZmxvd190YWJsZV9z
aG93KCkgZ2V0cyBjYWxsZWQgZmlyc3QsIHNvIHRoZSBmaWxlCj4gd2lsbCBiZSByZW1vdmVkIGZy
b20gdGhlIGRlYnVnZnMgYmVmb3JlCj4KPiBtbHg1X3ZkcGFfbmV0IGdldHMgcmVsZWFzZWQuCgpK
dXN0IHRvIG1ha2Ugc3VyZSB3ZSBhcmUgYXQgdGhlIHNhbWUgcGFnZS4gSSBtZWFudDoKCltDUFUg
MF0gX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UoZGV2KTsKW0NQVSAxXSByeF9mbG93X3RhYmxlX3No
b3coKQpbQ1BVIDBdIG1seDVfdmRwYV9yZW1vdmVfZGVidWdmcygpCgpTbyB3aGVuIENQVSAxIHRy
aWVzIHRvIGFjY2VzcyB0aGUgZmxvdyB0YWJsZSwgdGhlIG5kZXYgaGFzIGJlZW4KcmVsZWFzZWQg
YnkgQ1BVMCBpbiBfdmRwYV91bnJlZ2lzdGVyX2RldmljZSgpPwoKVGhhbmtzCgo+Cj4gPgo+ID4g
SWYgYSB1c2VyIHRyaWVzIHRvIGFjY2VzcyB0aGF0IGZpbGUgYWZ0ZXIgX3ZkcGFfdW5yZWdpc3Rl
cl9kZXZpY2UoKQo+ID4gYnV0IGJlZm9yZSBtbHg1X3ZkcGFfcmVtb3ZlX2RlYnVnZnMoKSwgd2ls
bCB3ZSBlbmQgdXAgd2l0aAo+ID4gdXNlLWFmdGVyLWZyZWU/Cj4gPgo+ID4gVGhhbmtzCj4gPgo+
ID4KPiA+Pj4gVGhhbmtzCj4gPj4+Cj4gPj4+PiArICAgICAgIG1seDVfdmRwYV9yZW1vdmVfZGVi
dWdmcyhuZGV2LT5kZWJ1Z2ZzKTsKPiA+Pj4+ICsgICAgICAgbmRldi0+ZGVidWdmcyA9IE5VTEw7
Cj4gPj4+PiAgICAgICAgICAgbWd0ZGV2LT5uZGV2ID0gTlVMTDsKPiA+Pj4+ICAgIH0KPiA+Pj4+
Cj4gPj4+PiAtLQo+ID4+Pj4gMi4zOC4xCj4gPj4+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
