Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D023C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 05:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21C2F60EB9;
	Wed,  9 Feb 2022 05:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SDhlbVwrNC18; Wed,  9 Feb 2022 05:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B1AF60EC0;
	Wed,  9 Feb 2022 05:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 698E5C0011;
	Wed,  9 Feb 2022 05:39:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37DE6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15E5F4011D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vfl7kak1az5L
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E4E4400CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 05:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644385191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdjkngOKMA7bg2oJfUtSkQw+6lC1kyEXHsbHAdltn3U=;
 b=ANg75pESuWBouSB8L2Bf/iBtgXSYfngcuib482Qtof+ArgjH3/Ai/19mUsGkYzhS19Rte7
 YjZE3wd8c66ArtBbbF1nXT4gKePl2wYluZcIfA7hjOOK9cD9qkhpH/LcolRzpjs346om6B
 oeb8QpjAK/fSwAVeGJn7NXpXQ+NCheU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-Ka_cemGpNJKV4JH94RwKXA-1; Wed, 09 Feb 2022 00:39:48 -0500
X-MC-Unique: Ka_cemGpNJKV4JH94RwKXA-1
Received: by mail-lj1-f197.google.com with SMTP id
 m13-20020a2e97cd000000b0023e09d49ce4so625132ljj.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 21:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KdjkngOKMA7bg2oJfUtSkQw+6lC1kyEXHsbHAdltn3U=;
 b=lpfEHHWospG15w2StE1OUZFyU6N1ZVnkvz3ynKcGTgt4W00MzY/OLYsOt5M4wmzOFM
 SWVgTsiAiN1T3V3FFUOdXF61LAd1krILq/z6LV/9wl7BIhOScifEzHuQqRGUjeHS20J3
 PCEXgXXuFRyaBqB3K9jihJHho61VGvEiWuxU9zKLaWZJKA7OahmHj3QIhnP09CxODSt0
 7fmRWb1ozlWKO5sTy99sYMp+tCBPi5A5BuxW6gfSH20o8sxQ+MMCyINb5W0f0fiXfiDV
 aAXoRnSGFtI09YgrBf7URBJEfseleDNriiVAymAPXI0GaAEdy0ocXgE0a5D09pg1UdKB
 074g==
X-Gm-Message-State: AOAM530j3FkvhYfHCYoj9GYgiySWBWLY97ZYtGkbUigWlMoFAXqfo7Kf
 k9v1D/JVst+IqIwwnkb9IGcdbTL2alixGONQoZDaFD7NWD0IJ8lStVA8X8jgwnlS6mCClU7qpMh
 Q9iqSgsXXMVR6z7UD7kfykr8c552tQeVDBh+e86V3OsbRBusLNF+cEJZ1IA==
X-Received: by 2002:a05:6512:3986:: with SMTP id
 j6mr507299lfu.84.1644385186776; 
 Tue, 08 Feb 2022 21:39:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ9V3a+WzslPsO4MNBWqkV/COHINFv3Uj3aM34m0bEvE0naK1G1+iv8ZX11UDJsX92pxLP529TE7r9laOD8mw=
X-Received: by 2002:a05:6512:3986:: with SMTP id
 j6mr507283lfu.84.1644385186483; 
 Tue, 08 Feb 2022 21:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEspyHTmcSaq9fgpU88VCZGzu21Khp9H+fqL-pb5GLdEpA@mail.gmail.com>
 <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
 <7d1e2d5b-a9a1-cbb7-4d80-89df1cb7bf15@redhat.com>
 <1644290085.868939-2-xuanzhuo@linux.alibaba.com>
 <1644306673.8360631-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644306673.8360631-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Feb 2022 13:39:34 +0800
Message-ID: <CACGkMEsnupEVKukgdom85gUwbGoLcHT8bM9OqR_U11DzGdz1rw@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBGZWIgOCwgMjAyMiBhdCAzOjU2IFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAwOCBGZWIgMjAyMiAxMToxNDo0NSArMDgw
MCwgWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiBPbiBU
dWUsIDggRmViIDIwMjIgMTA6NTk6NDggKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiDlnKggMjAyMi8yLzcg5LiL5Y2IMjowMiwgWHVhbiBa
aHVvIOWGmemBkzoKPiA+ID4gPiBPbiBNb24sIDcgRmViIDIwMjIgMTE6Mzk6MzYgKzA4MDAsIEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+PiBPbiBXZWQsIEph
biAyNiwgMjAyMiBhdCAzOjM1IFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPiA+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+ID4gPj4+IFRo
ZSB2aXJ0aW8gc3BlYyBhbHJlYWR5IHN1cHBvcnRzIHRoZSB2aXJ0aW8gcXVldWUgcmVzZXQgZnVu
Y3Rpb24uIFRoaXMgcGF0Y2ggc2V0Cj4gPiA+ID4+PiBpcyB0byBhZGQgdGhpcyBmdW5jdGlvbiB0
byB0aGUga2VybmVsLiBUaGUgcmVsZXZhbnQgdmlydGlvIHNwZWMgaW5mb3JtYXRpb24gaXMKPiA+
ID4gPj4+IGhlcmU6Cj4gPiA+ID4+Pgo+ID4gPiA+Pj4gICAgICBodHRwczovL2dpdGh1Yi5jb20v
b2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy8xMjQKPiA+ID4gPj4+Cj4gPiA+ID4+PiBBbHNv
IHJlZ2FyZGluZyBNTUlPIHN1cHBvcnQgZm9yIHF1ZXVlIHJlc2V0LCBJIHBsYW4gdG8gc3VwcG9y
dCBpdCBhZnRlciB0aGlzCj4gPiA+ID4+PiBwYXRjaCBpcyBwYXNzZWQuCj4gPiA+ID4+Pgo+ID4g
PiA+Pj4gIzE0LSMxNyBpcyB0aGUgZGlzYWJsZS9lbmFibGUgZnVuY3Rpb24gb2YgcngvdHggcGFp
ciBpbXBsZW1lbnRlZCBieSB2aXJ0aW8tbmV0Cj4gPiA+ID4+PiB1c2luZyB0aGUgbmV3IGhlbHBl
ci4KPiA+ID4gPj4gT25lIHRoaW5nIHRoYXQgY2FtZSB0byBtaW5kIGlzIHRoZSBzdGVlcmluZy4g
RS5nIGlmIHdlIGRpc2FibGUgYW4gUlgsCj4gPiA+ID4+IHNob3VsZCB3ZSBzdG9wIHN0ZWVyaW5n
IHBhY2tldHMgdG8gdGhhdCBxdWV1ZT8KPgo+IFJlZ2FyZGluZyB0aGlzIHNwZWMsIGlmIHRoZXJl
IGFyZSBtdWx0aXBsZSBxdWV1ZXMgZGlzYWJsZWQgYXQgdGhlIHNhbWUgdGltZSwgaXQKPiB3aWxs
IGJlIGEgdHJvdWJsZXNvbWUgcHJvYmxlbSBmb3IgdGhlIGJhY2tlbmQgdG8gc2VsZWN0IHRoZSBx
dWV1ZSwKCkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzLCBmb3Igc3VjaCBhIGtpbmQgb2YgYmFja2Vu
ZCBvciBkZXZpY2UgaXQgY2FuCnNpbXBseSBjbGFpbSBub3QgdG8gc3VwcG9ydCB0aGlzIGZlYXR1
cmUuCgo+IHNvIEkgd2FudCB0bwo+IGRpcmVjdGx5IGRlZmluZSB0aGF0IG9ubHkgb25lIHF1ZXVl
IGlzIGFsbG93ZWQgdG8gcmVzZXQgYXQgdGhlIHNhbWUgdGltZSwgZG8geW91Cj4gdGhpbmsgdGhp
cyBpcyBhcHByb3ByaWF0ZT8KClRoaXMgc291bmRzIHZlcnkgY29tcGxpY2F0ZWQuIEUuZyBob3cg
Y2FuIHdlIGRlZmluZSBhbiBBUEkgdGhhdCBjYW4KcmVzZXQgbW9yZSB0aGFuIG9uZSBxdWV1ZXM/
IChjdXJyZW50bHkgUENJIG9ubHkgc3VwcG9ydCBNTUlPIGFjY2VzcykuCgo+Cj4gSW4gdGVybXMg
b2YgdGhlIGltcGxlbWVudGF0aW9uIG9mIGJhY2tlbmQgcXVldWUgcmVzZWxlY3Rpb24sIGl0IHdv
dWxkIGJlIG1vcmUKPiBjb252ZW5pZW50IHRvIGltcGxlbWVudCBpZiB3ZSBkcm9wIHBhY2tldHMg
ZGlyZWN0bHkuIERvIHlvdSB0aGluayB3ZSBtdXN0Cj4gaW1wbGVtZW50IHRoaXMgcmVzZWxlY3Rp
b24gZnVuY3Rpb24/CgpSZXRoaW5rIG9mIHRoaXMuIEl0IHNob3VsZCBiZSBmaW5lIGFuZCBtdWNo
IHNpbXBsZXIuCgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPiA+ID4gPiBZZXMsIHdlIHNob3VsZCBy
ZXNlbGVjdCBhIHF1ZXVlLgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4gPgo+ID4g
PiBNYXliZSBhIHNwZWMgcGF0Y2ggZm9yIHRoYXQ/Cj4gPgo+ID4gWWVzLCBJIGFsc28gcmVhbGl6
ZWQgdGhpcy4gQWx0aG91Z2ggdmlydGlvLW5ldCdzIGRpc2FibGUvZW5hYmxlIGlzIGltcGxlbWVu
dGVkCj4gPiBiYXNlZCBvbiBxdWV1ZSByZXNldCwgdmlydGlvLW5ldCBzdGlsbCBoYXMgdG8gZGVm
aW5lIGl0cyBvd24gZmxhZyBhbmQgZGVmaW5lCj4gPiBzb21lIG1vcmUgZGV0YWlsZWQgaW1wbGVt
ZW50YXRpb25zLgo+ID4KPiA+IEknbGwgdGhpbmsgYWJvdXQgaXQgYW5kIHBvc3QgYSBzcGVjIHBh
dGNoLgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4+IFRoYW5rcwo+ID4gPiA+Pgo+ID4gPiA+Pj4gVGhpcyBmdW5jdGlvbiBp
cyBub3QgY3VycmVudGx5IHJlZmVyZW5jZWQgYnkgb3RoZXIKPiA+ID4gPj4+IGZ1bmN0aW9ucy4g
SXQgaXMgbW9yZSB0byBzaG93IHRoZSB1c2FnZSBvZiB0aGUgbmV3IGhlbHBlciwgSSBub3Qgc3Vy
ZSBpZiB0aGV5Cj4gPiA+ID4+PiBhcmUgZ29pbmcgdG8gYmUgbWVyZ2VkIHRvZ2V0aGVyLgo+ID4g
PiA+Pj4KPiA+ID4gPj4+IFBsZWFzZSByZXZpZXcuIFRoYW5rcy4KPiA+ID4gPj4+Cj4gPiA+ID4+
PiB2MzoKPiA+ID4gPj4+ICAgIDEuIGtlZXAgdnEsIGlycSB1bnJlbGVhc2VkCj4gPiA+ID4+Pgo+
ID4gPiA+Pj4gWHVhbiBaaHVvICgxNyk6Cj4gPiA+ID4+PiAgICB2aXJ0aW9fcGNpOiBzdHJ1Y3Qg
dmlydGlvX3BjaV9jb21tb25fY2ZnIGFkZCBxdWV1ZV9ub3RpZnlfZGF0YQo+ID4gPiA+Pj4gICAg
dmlydGlvOiBxdWV1ZV9yZXNldDogYWRkIFZJUlRJT19GX1JJTkdfUkVTRVQKPiA+ID4gPj4+ICAg
IHZpcnRpbzogcXVldWVfcmVzZXQ6IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyBhZGQgY2FsbGJh
Y2tzIGZvcgo+ID4gPiA+Pj4gICAgICBxdWV1ZV9yZXNldAo+ID4gPiA+Pj4gICAgdmlydGlvOiBx
dWV1ZV9yZXNldDogYWRkIGhlbHBlcgo+ID4gPiA+Pj4gICAgdnJpdGlvX3Jpbmc6IHF1ZXVlX3Jl
c2V0OiBleHRyYWN0IHRoZSByZWxlYXNlIGZ1bmN0aW9uIG9mIHRoZSB2cSByaW5nCj4gPiA+ID4+
PiAgICB2aXJ0aW9fcmluZzogcXVldWVfcmVzZXQ6IHNwbGl0OiBhZGQgX192cmluZ19pbml0X3Zp
cnRxdWV1ZSgpCj4gPiA+ID4+PiAgICB2aXJ0aW9fcmluZzogcXVldWVfcmVzZXQ6IHNwbGl0OiBz
dXBwb3J0IGVuYWJsZSByZXNldCBxdWV1ZQo+ID4gPiA+Pj4gICAgdmlydGlvX3Jpbmc6IHF1ZXVl
X3Jlc2V0OiBwYWNrZWQ6IHN1cHBvcnQgZW5hYmxlIHJlc2V0IHF1ZXVlCj4gPiA+ID4+PiAgICB2
aXJ0aW9fcmluZzogcXVldWVfcmVzZXQ6IGFkZCB2cmluZ19yZXNldF92aXJ0cXVldWUoKQo+ID4g
PiA+Pj4gICAgdmlydGlvX3BjaTogcXVldWVfcmVzZXQ6IHVwZGF0ZSBzdHJ1Y3QgdmlydGlvX3Bj
aV9jb21tb25fY2ZnIGFuZAo+ID4gPiA+Pj4gICAgICBvcHRpb24gZnVuY3Rpb25zCj4gPiA+ID4+
PiAgICB2aXJ0aW9fcGNpOiBxdWV1ZV9yZXNldDogcmVsZWFzZSB2cSBieSB2cF9kZXYtPnZxcwo+
ID4gPiA+Pj4gICAgdmlydGlvX3BjaTogcXVldWVfcmVzZXQ6IHNldHVwX3ZxIHVzZSB2cmluZ19z
ZXR1cF92aXJ0cXVldWUoKQo+ID4gPiA+Pj4gICAgdmlydGlvX3BjaTogcXVldWVfcmVzZXQ6IHN1
cHBvcnQgVklSVElPX0ZfUklOR19SRVNFVAo+ID4gPiA+Pj4gICAgdmlydGlvX25ldDogdmlydG5l
dF90eF90aW1lb3V0KCkgZml4IHN0eWxlCj4gPiA+ID4+PiAgICB2aXJ0aW9fbmV0OiB2aXJ0bmV0
X3R4X3RpbWVvdXQoKSBzdG9wIHJlZiBzcS0+dnEKPiA+ID4gPj4+ICAgIHZpcnRpb19uZXQ6IHNw
bGl0IGZyZWVfdW51c2VkX2J1ZnMoKQo+ID4gPiA+Pj4gICAgdmlydGlvX25ldDogc3VwcG9ydCBw
YWlyIGRpc2FibGUvZW5hYmxlCj4gPiA+ID4+Pgo+ID4gPiA+Pj4gICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgICAgICAgICAgICAgICB8IDIyMCArKysrKysrKysrKysrKysrKysrKysrLS0tCj4g
PiA+ID4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgICAgIHwgIDYyICsr
KystLS0KPiA+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCAgICAg
fCAgMTEgKy0KPiA+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyAg
ICAgfCAgIDUgKy0KPiA+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4u
YyAgICAgfCAxMjAgKysrKysrKysrKysrKy0KPiA+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCAgMjggKysrKwo+ID4gPiA+Pj4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jICAgICAgICAgICB8IDE0NCArKysrKysrKysrKy0tLS0tCj4gPiA+ID4+
PiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAgICAgICAgIHwgICAxICsKPiA+ID4g
Pj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggICAgICAgICAgfCAgNzUgKysrKysr
KystCj4gPiA+ID4+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaCAgICAgIHwg
ICAyICsKPiA+ID4gPj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fcmluZy5oICAgICAgICAgICAg
fCAgNDIgKysrLS0KPiA+ID4gPj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19jb25maWcu
aCAgICAgfCAgIDcgKy0KPiA+ID4gPj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2ku
aCAgICAgICAgfCAgIDIgKwo+ID4gPiA+Pj4gICAxMyBmaWxlcyBjaGFuZ2VkLCA2MTggaW5zZXJ0
aW9ucygrKSwgMTAxIGRlbGV0aW9ucygtKQo+ID4gPiA+Pj4KPiA+ID4gPj4+IC0tCj4gPiA+ID4+
PiAyLjMxLjAKPiA+ID4gPj4+Cj4gPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+ID4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gPiBW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4gaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
