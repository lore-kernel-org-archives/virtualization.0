Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB434C7618A
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 09:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62B9C815CA;
	Mon, 20 Mar 2023 09:31:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62B9C815CA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AW5ZzyIQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQFH4SwXL1bl; Mon, 20 Mar 2023 09:31:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EA02381584;
	Mon, 20 Mar 2023 09:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA02381584
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF50BC0035;
	Mon, 20 Mar 2023 09:31:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 571D5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 325F060C2C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 325F060C2C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AW5ZzyIQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jc5xG9Kv2cQM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:31:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 618CC60C15
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 618CC60C15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679304702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZX3eaTeGESwliREyoFlZikVNeBe1KovW4PqQ67m4Eo=;
 b=AW5ZzyIQT75Beg/4k7R25dVMaBoNx+X94PWcstRcwTnLAcghGwBeLmuYcFKyUYZO0S5RaE
 JRyQpBWANCfn09mxLdOtaqNYDBubXT8GA0Zl6aTkNYv/Jgmb4pcTYdxOrulduoZQx5fmzo
 bNON5VfaKyAZWEXXSNl3BjL0HTocNmE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-0LLYuCs5MIiVpYSSZsfE0w-1; Mon, 20 Mar 2023 05:31:41 -0400
X-MC-Unique: 0LLYuCs5MIiVpYSSZsfE0w-1
Received: by mail-ot1-f72.google.com with SMTP id
 y14-20020a056830208e00b006943ddbfb7eso5365541otq.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 02:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679304700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZX3eaTeGESwliREyoFlZikVNeBe1KovW4PqQ67m4Eo=;
 b=ZL635kbobGDyoBt9vHlc9xv21U011PW9abG6WkLlp7KCqLO+brb1o+BT4c+FdUyD3o
 PazyigxOi5vOhNW4jzdaMc81wt7ks4PJU3CnYzu/M4GGkh5QIOggV14GrhCwf+jjAYi/
 9nDqXzj11UAg8OzD7MVc9OwNyc72yNNCmjw2oNRXJjXUrxsUHLTaL9Kiq5F7CBP/xKrK
 ggkziJMTp5lWU4Ar2pr0ksGpKqTEEB/Km9+glaZ38dkOt+TFa299JPYby2n1E9Ckt1Cl
 5W/igm/TWioRFP83rN/EDhQgnnX5vRI4aXi+cuiKDM+pwsFWKORiCS5xmWcmTrilU38K
 3hUw==
X-Gm-Message-State: AO0yUKW0tGJuweGUvLjwIqL+SMlx2CdfVJQO+cQUfozLr5izu1McCw0L
 SAk5Y2s4NRQHvA+f0oNJFtZUBCQ/vgjnMIRIfRpU+M6sgu7nbOGrPb0IfWRh9042ktCUtiJpfX1
 Ppftce/cY7s+oJX8F66YY6/y31LNIGm31gRPxwffZ2xx7sktUSjnNYUtx9w==
X-Received: by 2002:a05:6870:13d1:b0:17a:d3d2:dc75 with SMTP id
 17-20020a05687013d100b0017ad3d2dc75mr1627754oat.3.1679304700243; 
 Mon, 20 Mar 2023 02:31:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set/AzSlQ1b+GDVzES3em9nxy5zseXTLWqkB/LLpnFsI/CCnMLxmsP3+gER2yMh5adqsgAxzYfOQku/yQeDGq+48=
X-Received: by 2002:a05:6870:13d1:b0:17a:d3d2:dc75 with SMTP id
 17-20020a05687013d100b0017ad3d2dc75mr1627748oat.3.1679304700009; Mon, 20 Mar
 2023 02:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-4-xieyongji@bytedance.com>
 <CACGkMEvmV7xKc7VnaZT+DGcN2hg64ksGHxRAihW2f=RpXydZoQ@mail.gmail.com>
 <CACycT3t+n4MXzva7w_yh-iTmzU0M--O4RNXDPxumpY-LmPb6Zg@mail.gmail.com>
In-Reply-To: <CACycT3t+n4MXzva7w_yh-iTmzU0M--O4RNXDPxumpY-LmPb6Zg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Mar 2023 17:31:29 +0800
Message-ID: <CACGkMEuMSo+wjD1tiT8agbbwymXL9Od+ayQWmMKLXd627YWvMg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] vdpa: Add set_irq_affinity callback in
 vdpa_config_ops
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

T24gRnJpLCBNYXIgMTcsIDIwMjMgYXQgMzo0NeKAr1BNIFlvbmdqaSBYaWUgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgTWFyIDE2LCAyMDIzIGF0IDEyOjAz4oCv
UE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVl
LCBGZWIgMjgsIDIwMjMgYXQgNTo0MuKAr1BNIFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFu
Y2UuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gVGhpcyBpbnRyb2R1Y2VzIHNldF9pcnFfYWZmaW5p
dHkgY2FsbGJhY2sgaW4KPiA+ID4gdmRwYV9jb25maWdfb3BzIHNvIHRoYXQgdmRwYSBkZXZpY2Ug
ZHJpdmVyIGNhbgo+ID4gPiBnZXQgdGhlIGludGVycnVwdCBhZmZpbml0eSBoaW50IGZyb20gdGhl
IHZpcnRpbwo+ID4gPiBkZXZpY2UgZHJpdmVyLiBUaGUgaW50ZXJydXB0IGFmZmluaXR5IGhpbnQg
d291bGQKPiA+ID4gYmUgbmVlZGVkIGJ5IHRoZSBpbnRlcnJ1cHQgYWZmaW5pdHkgc3ByZWFkaW5n
Cj4gPiA+IG1lY2hhbmlzbS4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8
eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYyB8IDQgKysrKwo+ID4gPiAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAg
ICB8IDkgKysrKysrKysrCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykK
PiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiA+IGluZGV4IGY3MjY5NmI0YzFjMi4uOWVl
ZThhZmFiZGE4IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5j
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ID4gQEAgLTI4Miw5
ICsyODIsMTMgQEAgc3RhdGljIGludCB2aXJ0aW9fdmRwYV9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlv
X2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IG52cXMsCj4gPiA+ICAgICAgICAgc3RydWN0IHZp
cnRpb192ZHBhX2RldmljZSAqdmRfZGV2ID0gdG9fdmlydGlvX3ZkcGFfZGV2aWNlKHZkZXYpOwo+
ID4gPiAgICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHZkX2dldF92ZHBhKHZkZXYp
Owo+ID4gPiAgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEt
PmNvbmZpZzsKPiA+ID4gKyAgICAgICBzdHJ1Y3QgaXJxX2FmZmluaXR5IGRlZmF1bHRfYWZmZCA9
IHsgMCB9Owo+ID4gPiAgICAgICAgIHN0cnVjdCB2ZHBhX2NhbGxiYWNrIGNiOwo+ID4gPiAgICAg
ICAgIGludCBpLCBlcnIsIHF1ZXVlX2lkeCA9IDA7Cj4gPiA+Cj4gPiA+ICsgICAgICAgaWYgKG9w
cy0+c2V0X2lycV9hZmZpbml0eSkKPiA+ID4gKyAgICAgICAgICAgICAgIG9wcy0+c2V0X2lycV9h
ZmZpbml0eSh2ZHBhLCBkZXNjID8gZGVzYyA6ICZkZWZhdWx0X2FmZmQpOwo+ID4gPiArCj4gPiA+
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IG52cXM7ICsraSkgewo+ID4gPiAgICAgICAgICAgICAg
ICAgaWYgKCFuYW1lc1tpXSkgewo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB2cXNbaV0g
PSBOVUxMOwo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRl
L2xpbnV4L3ZkcGEuaAo+ID4gPiBpbmRleCBkNjFmMzY5ZjljZDYuLjEwYmQyMjM4NzI3NiAxMDA2
NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC92ZHBhLmgKPiA+ID4gQEAgLTI1OSw2ICsyNTksMTMgQEAgc3RydWN0IHZkcGFfbWFwX2Zp
bGUgewo+ID4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRl
dmljZQo+ID4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBpZHg6IHZpcnRxdWV1
ZSBpbmRleAo+ID4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgdGhl
IGlycSBhZmZpbml0eSBtYXNrCj4gPiA+ICsgKiBAc2V0X2lycV9hZmZpbml0eTogICAgICAgICAg
UGFzcyB0aGUgaXJxIGFmZmluaXR5IGhpbnQgKGJlc3QgZWZmb3J0KQo+ID4KPiA+IE5vdGUgdGhh
dCB0aGlzIGNvdWxkIGVhc2lseSBjb25mdXNlIHRoZSB1c2Vycy4gSSB3b25kZXIgaWYgd2UgY2Fu
Cj4gPiB1bmlmeSBpdCB3aXRoIHNldF9pcnFfYWZmaW5pdHkuIExvb2tpbmcgYXQgdmR1c2UncyBp
bXBsZW1lbnRhdGlvbiwgaXQKPiA+IHNob3VsZCBiZSBwb3NzaWJsZS4KPiA+Cj4KPiBEbyB5b3Ug
bWVhbiB1bmlmeSBzZXRfaXJxX2FmZmluaXR5KCkgd2l0aCBzZXRfdnFfYWZmaW5pdHkoKT8gQWN0
dWFsbHkKPiBJIGRpZG4ndCBnZXQgaG93IHRvIGFjaGlldmUgdGhhdC4gVGhlIHNldF92cV9hZmZp
bml0eSgpIGNhbGxiYWNrIGlzCj4gY2FsbGVkIGJ5IHZpcnRpb19jb25maWdfb3BzLnNldF92cV9h
ZmZpbml0eSgpIGJ1dCB0aGUgc2V0X2lycV9hZmZpbml0eQo+IGlzIGNhbGxlZCBieSB2aXJ0aW9f
Y29uZmlnX29wcy5maW5kX3ZxcygpLCBJIGRvbid0IGtub3cgd2hlcmUgdG8gY2FsbAo+IHRoZSB1
bmlmaWVkIGNhbGxiYWNrLgoKSSBtZWFudCwgY2FuIHdlIHN0aWNrIGEgc2luZ2xlIHBlciB2cSBh
ZmZpbml0eSBjb25maWcgb3BzIHRoZW4gdXNlCnRoYXQgaW4gdmlydGlvLXZwZGEncyBmaW5kX3Zx
cygpIGJ5IHNvbWV0aGluZyBsaWtlOgoKbWFza3MgPSBjcmVhdGVfYWZmaW5pdHlfbWFza3MoZGV2
LT52cV9udW0sIGRlc2MpOwpmb3IgKGkgPSAwOyBpIDwgZGV2LT52cV9udW07IGkrKykKICAgICAg
ICBjb25maWctPnNldF92cV9hZmZpbml0eSgpCi4uLgoKPwoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+
IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
