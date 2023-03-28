Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754F6C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 03:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1AF740B4F;
	Tue, 28 Mar 2023 03:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1AF740B4F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TrPFjw0M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7GIdox-023c; Tue, 28 Mar 2023 03:53:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E911A40129;
	Tue, 28 Mar 2023 03:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E911A40129
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC7F0C007C;
	Tue, 28 Mar 2023 03:53:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EBD1C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7302460E44
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:53:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7302460E44
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TrPFjw0M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1nDyf0V5njv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B80566059D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B80566059D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679975602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap2W7rICg75yU+OVQdWf7kfBcx1hCk4Lyy4ZTxBSTOg=;
 b=TrPFjw0MFiZzP9MGIhCptZ8KWpmV6FLDTqqpnDdZlEXqpKgJrh2nHFmikRAC1um/HRNEf2
 JxLJKzUfksT+H5B6ZRh1vUXJnLwjylPfximbG7CoMDo4ZSHmnyOYq/zrkrArzxnKHRlVIu
 UiOi3OrRJts8jl4iaYh9NTPLl0f9BGg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80--4f0ZaUnPSu6w0zxPdJcng-1; Mon, 27 Mar 2023 23:53:20 -0400
X-MC-Unique: -4f0ZaUnPSu6w0zxPdJcng-1
Received: by mail-ot1-f72.google.com with SMTP id
 m12-20020a9d608c000000b006a1461bc5cdso1394699otj.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 20:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679975599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ap2W7rICg75yU+OVQdWf7kfBcx1hCk4Lyy4ZTxBSTOg=;
 b=kHu8zqROyru9RlYfgBRIoVQHFXS+bws3nQ0wIu5itrBIi9zi9UY0uZha97X64gq2c1
 sUtgmD3tvHMxD+dW0kP3V5tm0tBNIJDDjOA/mIcNbniXew3ed5yBzHLoomm9OtK6AOR9
 ApG1P8TOD7oNCHL8Lfebl18tGcWw9NOZxHmgAiLR7xVZTOY/HL+ZsAqpEOvvJwz1eC5Y
 DoteOhpG4iRaOEiMlTBK8rKIRE6pKE67YusKjJCQ1o3FXFn6YXgGyAhk/4IOyYL01zl0
 mZtnKPFyAKQLVr1rBLV6Gnk4ERfM+GWeTN1faE6CaxB1jvSTfU56hPzPen+Dz/PPMp2F
 s8vA==
X-Gm-Message-State: AAQBX9eoGMLemWGYd37t9JM5HIw/R/QS2+xIzcVkKOaveJ31lyMRRwg0
 s9xsC3/3cxOBqq1biJjoRlsnVxiJcy2nJbQoUu02sxidgiF+KgOGpyMIaAjAbvE9NxAbqAlZxu4
 ejIYX3rREOfTCJaN59m2HYUEjwK6c1YStyP9wsWw+AFXn/q8lUTU1bJFQug==
X-Received: by 2002:a05:6808:f12:b0:389:4edd:deb8 with SMTP id
 m18-20020a0568080f1200b003894edddeb8mr650899oiw.9.1679975599698; 
 Mon, 27 Mar 2023 20:53:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350YReprdYf6cd/1IwBzLSwvTjjoTN4no5pRuxYfL6LUkxj0OTHXmA/1f8lsroZgUVcz4EsWQTsu+XCDM1p8SiTw=
X-Received: by 2002:a05:6808:f12:b0:389:4edd:deb8 with SMTP id
 m18-20020a0568080f1200b003894edddeb8mr650895oiw.9.1679975599494; Mon, 27 Mar
 2023 20:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230322191038.44037-1-shannon.nelson@amd.com>
 <20230322191038.44037-7-shannon.nelson@amd.com>
 <CACGkMEvacgachSZK8J4zpSXAYaCBkyJrqp8_rYV7-k1O7arC7Q@mail.gmail.com>
 <efa1bda9-6b12-54c1-8d98-7838469cee03@amd.com>
In-Reply-To: <efa1bda9-6b12-54c1-8d98-7838469cee03@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 11:53:08 +0800
Message-ID: <CACGkMEvOF7Qb-d61+GG5c5-QnrM2qsRe7Z-6Q+S-vNOdic3Law@mail.gmail.com>
Subject: Re: [PATCH v3 virtio 6/8] pds_vdpa: add support for vdpa and vdpamgmt
 interfaces
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gU2F0LCBNYXIgMjUsIDIwMjMgYXQgODoyN+KAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IE9uIDMvMjIvMjMgMTA6MTggUE0sIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCAzOjEx4oCvQU0gU2hhbm5vbiBO
ZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gVGhpcyBpcyB0
aGUgdkRQQSBkZXZpY2Ugc3VwcG9ydCwgd2hlcmUgd2UgYWR2ZXJ0aXNlIHRoYXQgd2UgY2FuCj4g
Pj4gc3VwcG9ydCB0aGUgdmlydGlvIHF1ZXVlcyBhbmQgZGVhbCB3aXRoIHRoZSBjb25maWd1cmF0
aW9uIHdvcmsKPiA+PiB0aHJvdWdoIHRoZSBwZHNfY29yZSdzIGFkbWlucS4KPiA+Pgo+ID4+IFNp
Z25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4+
IC0tLQo+ID4+ICAgZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMgIHwgIDE1ICsKPiA+PiAgIGRy
aXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5oICB8ICAgMSArCj4gPj4gICBkcml2ZXJzL3ZkcGEvcGRz
L2RlYnVnZnMuYyAgfCAyNjAgKysrKysrKysrKysrKysrKysKPiA+PiAgIGRyaXZlcnMvdmRwYS9w
ZHMvZGVidWdmcy5oICB8ICAxMCArCj4gPj4gICBkcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMg
fCA1NjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gPj4gICA1IGZpbGVz
IGNoYW5nZWQsIDg0NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPj4KPiA+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMgYi9kcml2ZXJzL3ZkcGEvcGRzL2F1
eF9kcnYuYwo+ID4+IGluZGV4IDhmM2FlMzMyNjg4NS4uZTU0ZjAzNzFjNjBlIDEwMDY0NAo+ID4+
IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5jCj4gPj4gKysrIGIvZHJpdmVycy92ZHBh
L3Bkcy9hdXhfZHJ2LmMKPiA+Cj4gPiBbLi4uXQo+ID4KPiA+PiArCj4gPj4gK3N0YXRpYyBzdHJ1
Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYQo+ID4+ICtwZHNfdmRwYV9nZXRfdnFfbm90aWZpY2F0
aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUxNiBxaWQpCj4gPj4gK3sKPiA+PiAr
ICAgICAgIHN0cnVjdCBwZHNfdmRwYV9kZXZpY2UgKnBkc3YgPSB2ZHBhX3RvX3Bkc3YodmRwYV9k
ZXYpOwo+ID4+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqdmRfbWRl
djsKPiA+PiArICAgICAgIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIGFyZWE7Cj4gPj4g
Kwo+ID4+ICsgICAgICAgYXJlYS5hZGRyID0gcGRzdi0+dnFzW3FpZF0ubm90aWZ5X3BhOwo+ID4+
ICsKPiA+PiArICAgICAgIHZkX21kZXYgPSAmcGRzdi0+dmRwYV9hdXgtPnZkX21kZXY7Cj4gPj4g
KyAgICAgICBpZiAoIXZkX21kZXYtPm5vdGlmeV9vZmZzZXRfbXVsdGlwbGllcikKPiA+PiArICAg
ICAgICAgICAgICAgYXJlYS5zaXplID0gUERTX1BBR0VfU0laRTsKPiA+Cj4gPiBUaGlzIGhhc24n
dCBiZWVuIGRlZmluZWQgc28gZmFyPyBPdGhlcnMgbG9vayBnb29kLgo+Cj4gU29ycnksIEkgZG9u
J3QgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uLgo+IHNsbgoKSSBtZWFuIEkgZG9uJ3Qgc2VlIHRo
ZSBkZWZpbml0aW9uIG9mIFBEU19QQUdFX1NJWkUgc28gZmFyLgoKVGhhbmtzCgo+Cj4KPiA+Cj4g
PiBUaGFua3MKPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
