Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A8C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 15:33:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0689064DD2
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 15:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0689064DD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD2C943040;
	Mon,  1 Mar 2021 15:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ouxn0S19RPQ; Mon,  1 Mar 2021 15:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A5CA4304D;
	Mon,  1 Mar 2021 15:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 456C2C000D;
	Mon,  1 Mar 2021 15:33:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80E2DC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 764554F28A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b77yCaxSMNOA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:33:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 215E24F22B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614612801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VycDxHHozAmz/oN9S6Q+COAL5WKvN1P0hQASaQTZUyM=;
 b=hcvk9BxeDthBsHekRwSbT98PsGoZU7GBjAktvtvMxzs3jtKVFL1T6auX83BpFMSrB3k3BX
 asxh9xpDyMv+Pt6YH+j8+2oPA5MHRgR9CygPYPTcR9cNZLpsoE8vu4bFeTjIpaVCMQ0jR7
 2bLxMOdapeswR2FnDAdMk+wfpnV9BxI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-HBLQOiROMnihu95dpxqlqQ-1; Mon, 01 Mar 2021 10:33:20 -0500
X-MC-Unique: HBLQOiROMnihu95dpxqlqQ-1
Received: by mail-ed1-f69.google.com with SMTP id k8so574190edn.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 07:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VycDxHHozAmz/oN9S6Q+COAL5WKvN1P0hQASaQTZUyM=;
 b=TfwbIp482kgo80MRBzOaafXRRQOZuTdFOgL7BR+eBcilJHMtHJsI/XzNYogpXmJWSj
 gRh91VBVNjtOn4TXPB2swFDm/ewBdl8BF/3MsU46b6DdqWZT4lcRJEviY0dvRHaCKhVs
 WO1wjoUf6VuS4oP+VwObHpcRmQvmSrubfZ0l/LDxd9MGgLZKAKmfL5Nv7Q7tVq6g6ET3
 LsEcUPLyCKUsEWNMbgBNXuUCytk/OsoLepcKp7QTCJvYDKejN4k3A7SNrLOidkrX/xqW
 6TbYvpO93xLs6bC8gbRfh8UsJEhJTSj1Petf5znIl3HypV6IqhlCb69jhuINJdoUdeXa
 D9hg==
X-Gm-Message-State: AOAM533vG6d5ewodAm994jR12L5IR+eKDFXdzBnM78NoqWQOUP9Ppocs
 ddxugKw/POVkgXON5TuPbEWK2JNSlImN3sm6HuAJGEstRDov5QDlX/wfH4PQRgSFWFs3/GDW2eS
 to0t2c+hpz38hL77EsGxcNzOQLzcJbEH+LdnkKTkiVQ==
X-Received: by 2002:a17:907:3da5:: with SMTP id
 he37mr16735471ejc.300.1614612798837; 
 Mon, 01 Mar 2021 07:33:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvuA2uuZPGE6wZF6LgEHxqlvnFOzgtkmNcH1tdkTEnC0QemOod2QRaCHxR1Jk8clxbToGX/w==
X-Received: by 2002:a17:907:3da5:: with SMTP id
 he37mr16735461ejc.300.1614612798727; 
 Mon, 01 Mar 2021 07:33:18 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id bx24sm731233ejc.88.2021.03.01.07.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 07:33:18 -0800 (PST)
Date: Mon, 1 Mar 2021 10:33:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix wrong use of bit numbers
Message-ID: <20210301103214-mutt-send-email-mst@kernel.org>
References: <20210301062817.39331-1-elic@nvidia.com>
 <959916f2-5fc9-bdb4-31ca-632fe0d98979@redhat.com>
MIME-Version: 1.0
In-Reply-To: <959916f2-5fc9-bdb4-31ca-632fe0d98979@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDM6NTI6NDVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzMvMSAyOjI4IOS4i+WNiCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gVklS
VElPX0ZfVkVSU0lPTl8xIGlzIGEgYml0IG51bWJlci4gVXNlIEJJVF9VTEwoKSB3aXRoIG1hc2sK
PiA+IGNvbmRpdGlvbmFscy4KPiA+IAo+ID4gQWxzbywgaW4gbWx4NV92ZHBhX2lzX2xpdHRsZV9l
bmRpYW4oKSB1c2UgQklUX1VMTCBmb3IgY29uc2lzdGVuY3kgd2l0aAo+ID4gdGhlIHJlc3Qgb2Yg
dGhlIGNvZGUuCj4gPiAKPiA+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBW
RFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gPiBTaWduZWQtb2ZmLWJ5
OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAKPiAKPiBBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCkFuZCBDQyBzdGFibGUgSSBndWVzcz8KCj4gCj4gPiAt
LS0KPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNCArKy0tCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+IGluZGV4IGRjNzAzMTEzMmZmZi4uN2QyMWI4
NTdhOTRhIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+IEBAIC04MjEs
NyArODIxLDcgQEAgc3RhdGljIGludCBjcmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPiA+ICAgCU1MWDVfU0VUKHZpcnRp
b19xLCB2cV9jdHgsIGV2ZW50X3Fwbl9vcl9tc2l4LCBtdnEtPmZ3cXAubXFwLnFwbik7Cj4gPiAg
IAlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4LCBxdWV1ZV9zaXplLCBtdnEtPm51bV9lbnQpOwo+
ID4gICAJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgdmlydGlvX3ZlcnNpb25fMV8wLAo+ID4g
LQkJICEhKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyAmIFZJUlRJT19GX1ZFUlNJT05fMSkp
Owo+ID4gKwkJICEhKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElP
X0ZfVkVSU0lPTl8xKSkpOwo+ID4gICAJTUxYNV9TRVQ2NCh2aXJ0aW9fcSwgdnFfY3R4LCBkZXNj
X2FkZHIsIG12cS0+ZGVzY19hZGRyKTsKPiA+ICAgCU1MWDVfU0VUNjQodmlydGlvX3EsIHZxX2N0
eCwgdXNlZF9hZGRyLCBtdnEtPmRldmljZV9hZGRyKTsKPiA+ICAgCU1MWDVfU0VUNjQodmlydGlv
X3EsIHZxX2N0eCwgYXZhaWxhYmxlX2FkZHIsIG12cS0+ZHJpdmVyX2FkZHIpOwo+ID4gQEAgLTE1
NzgsNyArMTU3OCw3IEBAIHN0YXRpYyB2b2lkIHRlYXJkb3duX3ZpcnRxdWV1ZXMoc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXYpCj4gPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBtbHg1X3ZkcGFfaXNf
bGl0dGxlX2VuZGlhbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4gPiAgIHsKPiA+ICAg
CXJldHVybiB2aXJ0aW9fbGVnYWN5X2lzX2xpdHRsZV9lbmRpYW4oKSB8fAo+ID4gLQkJKG12ZGV2
LT5hY3R1YWxfZmVhdHVyZXMgJiAoMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEpKTsKPiA+ICsJ
CShtdmRldi0+YWN0dWFsX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpKTsK
PiA+ICAgfQo+ID4gICBzdGF0aWMgX192aXJ0aW8xNiBjcHVfdG9fbWx4NXZkcGExNihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYsIHUxNiB2YWwpCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
