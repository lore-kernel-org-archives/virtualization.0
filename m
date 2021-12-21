Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7477C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 07:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5EB454016B;
	Tue, 21 Dec 2021 07:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wWiEkxkYRFr; Tue, 21 Dec 2021 07:57:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC70540129;
	Tue, 21 Dec 2021 07:57:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE32C002F;
	Tue, 21 Dec 2021 07:57:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DFF4C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7447C4016B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tcOER_WzF5Eo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:57:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 200F440129
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640073459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPSX1B74dOBSm2QQh+ZtnWdL9JfRFM0lHxd7mCOj3tg=;
 b=FASjznG4xZF2SKjmqT265yYe6J+0ax9fL+GjaCIq184P0vPi2WDiYPPTnDD/mrdJYUQ+PF
 RQg3ypU9qg2m1ZUitJP+7vPfPlOZ8LbL/KH+5XPEvZVenNt/wWeniDiS/qgGMAhx+PrqlX
 2pKKWuAwxEtP8mQB+RGiHijdPwzzFVQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-wQuC59y2OkmEziNa-ptZQw-1; Tue, 21 Dec 2021 02:57:35 -0500
X-MC-Unique: wQuC59y2OkmEziNa-ptZQw-1
Received: by mail-lf1-f70.google.com with SMTP id
 o2-20020a198c02000000b00425d146a32bso2451711lfd.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cPSX1B74dOBSm2QQh+ZtnWdL9JfRFM0lHxd7mCOj3tg=;
 b=gADyO6MTjMS5FH3dSyFOWx/vkGlFBbjJfxJ5YKMgIiIXJr/JtQfsQKW6XY3WOYFehe
 hox2A1XPA32Tw2YLlSpFbypEGay4mVmTX06bhQq/eifrRL20s6VJ+wXIEsYMGIYBwNgS
 d+YtQoX+H5KSS9HrKYNm324nW3L1aq+QSd6gqVaKbTATnnmPhtoBd9z6t9USQ6GRfgzT
 FPk+i1YTKIY5mNWwFBXMHLHtX1+c3JYg1/67vTzMn8zWySOi1D5JUhtI5RtlVSTaZ4LZ
 D6INH7cLYtU7cf19IiJZL57fgvf+VdErQgdNl0rwMiQ6yH9LHklh8Xa7BwNO1FzLQCQU
 yKhQ==
X-Gm-Message-State: AOAM533Pqwt+267O71lUO6ziUgehVxTuJg9Ly/AmJN8+N8x6pwEB9V69
 B0cXs4ynkjQoGeQAl/uzaKwRmbO7syYCAYz/2Zu75RVaQmDgx+YrXMH/NRMYsMPe6jNRSVCsMrA
 13B94wzW8eSHqJmdpikkuhdT5dUY8wUpLfYANtBKaYbHSJIfmQIKJba1OtA==
X-Received: by 2002:a05:6512:22d6:: with SMTP id
 g22mr2064629lfu.199.1640073454091; 
 Mon, 20 Dec 2021 23:57:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy7c7BHYLS4RfUmmqO5xLAoF6PKUX3nfIUUwfIaw9zqtnExZ/L6NvfASAspRcuGzBWama8EBp3996ehmZB5lc=
X-Received: by 2002:a05:6512:22d6:: with SMTP id
 g22mr2064606lfu.199.1640073453889; 
 Mon, 20 Dec 2021 23:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-10-elic@nvidia.com>
 <81b998f6-fa36-7d44-19ef-b6c0d055fa28@redhat.com>
 <20211221062336.GC165503@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211221062336.GC165503@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 15:57:22 +0800
Message-ID: <CACGkMEtebmG0mWsXpV2M_i2ROTWdM+LeFegSDnXec0eTko7HWg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] vdpa/mlx5: Configure max supported virtqueues
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

T24gVHVlLCBEZWMgMjEsIDIwMjEgYXQgMjoyMyBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4KPiBPbiBUdWUsIERlYyAyMSwgMjAyMSBhdCAwMjowNDozOVBNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIxLzEyLzE5IOS4i+WNiDEwOjAyLCBFbGkg
Q29oZW4g5YaZ6YGTOgo+ID4gPiBDb25maWd1cmUgbWF4IHN1cHBvcnRlZCB2aXJ0cXVldWVzIG9u
IHRoZSBtYW5hZ2VtZW50IGRldmljZS4gVGhpcyBpbmZvCj4gPiA+IGNhbiBiZSByZXRyaWV2ZWQg
dXNpbmc6Cj4gPiA+Cj4gPiA+ICQgdmRwYSBkZXYgc2hvdwo+ID4gPiB2ZHBhLWE6IHR5cGUgbmV0
d29yayBtZ210ZGV2IGF1eGlsaWFyeS9tbHg1X2NvcmUuc2YuMSB2ZW5kb3JfaWQgNTU1NSBcCj4g
PiA+ICAgICBtYXhfdnFwIDMgbWF4X3ZxX3NpemUgMjU2IG1heF9zdXBwb3J0ZWRfdnFzIDI1Ngo+
ID4KPiA+Cj4gPiBJIHN0aWxsIHRoaW5rIHdlIHNob3VsZCByZXBvcnQgMjU3IGhlcmUgdG8gYmUg
YWxpZ25lZCB3aXRoIHRoZSBzcGVjIGV2ZW4gaWYKPiA+IHdlIGtub3cgY3ZxIGlzIHByb2JhYmx5
IGVtdWxhdGVkLgo+Cj4gT0ssIHlvdSBtZWFuIHJlcG9ydCAyNTcgZm9yIG1heF9zdXBwb3J0ZWRf
dnFzPwoKWWVzLgoKPiA+Cj4gPgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4g
PGVsaWNAbnZpZGlhLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jIHwgMSArCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
Cj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gaW5kZXggNzJlZDVl
ZmJlMzVkLi42OGRiZGRhZGRlOTMgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiA+ID4gQEAgLTI2ODksNiArMjY4OSw3IEBAIHN0YXRpYyBpbnQgbWx4NXZfcHJvYmUo
c3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXYsCj4gPiA+ICAgICBtZ3RkZXYtPm1ndGRldi5p
ZF90YWJsZSA9IGlkX3RhYmxlOwo+ID4gPiAgICAgbWd0ZGV2LT5tZ3RkZXYuY29uZmlnX2F0dHJf
bWFzayA9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpIHwKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZEUEFfQVRUUl9ERVZf
TkVUX0NGR19NQVhfVlFQKTsKPiA+ID4gKyAgIG1ndGRldi0+bWd0ZGV2Lm1heF9zdXBwb3J0ZWRf
dnFzID0gTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG1kZXYsIG1heF9udW1fdmlydGlvX3F1
ZXVlcyk7Cj4gPgo+ID4KPiA+IERvIHdlIG5lZWQgdG8gY2hhbmdlIG90aGVyIHZkcGEgcGFyZW50
IGxpa2UgdGhlIHNpbXVsYXRvciBhbmQgaWZjdmY/Cj4gPgo+Cj4gSSBjYW4gY2hhbmdlIGZvciB0
aGUgc2ltdWxhdG9yIGJ1dCBub3Qgc3VyZSBJIGtub3cgaG93IHRvIGRvIGl0IGZvcgo+IGlmY3Zm
IG9yIG90aGVyIGRyaXZlcnMuCgpBZGRpbmcgTGluZ1NoYW4gdG8gYW5zd2VyIHRoaXMgcXVlc3Rp
b24uCgpBbmQgd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IGVuaSBhbmQgdnBfdmRwYSBub3cg
c2luY2UgdGhleSBkb24ndApzdXBwb3J0IG1nbXQgZGV2aWNlcyB5ZXQuCgpUaGFua3MKCj4KPiA+
IFRoYW5rcwo+ID4KPiA+Cj4gPiA+ICAgICBtZ3RkZXYtPm1hZGV2ID0gbWFkZXY7Cj4gPiA+ICAg
ICBlcnIgPSB2ZHBhX21nbXRkZXZfcmVnaXN0ZXIoJm1ndGRldi0+bWd0ZGV2KTsKPiA+Cj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
