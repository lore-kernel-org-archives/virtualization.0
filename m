Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F4BEB64DD
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 05:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B8A160BB2;
	Wed,  5 Jul 2023 05:48:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B8A160BB2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DF4XqnWo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aWFzT_K6q84b; Wed,  5 Jul 2023 05:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B2D3860B1B;
	Wed,  5 Jul 2023 05:48:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2D3860B1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89001C0071;
	Wed,  5 Jul 2023 05:48:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5478C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF054408F2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:48:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF054408F2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DF4XqnWo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1gQL689W7XGw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:48:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90CA2409AE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90CA2409AE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688536081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmroFXVskoyZWXutVUB2JGgpokOFhXT+2nZZqoGKkeE=;
 b=DF4XqnWoT0ZrZ0AQzmmEBSrAA2/FKs6Y82ZiPbNoDldKdCe3sbxhm4OcyDsCTZZZApRulJ
 B6c2fesrm2CS5UASq0chhbEBDia0islRanfq4Vwpth7ju2lquXC++F7pKkY1oLk/KBgWOY
 Lo+VkpRCzKbYXbdkG88hA4qP8WS+Jnw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-uF99M-3dPhucePOTsmkxSw-1; Wed, 05 Jul 2023 01:48:00 -0400
X-MC-Unique: uF99M-3dPhucePOTsmkxSw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b69dcf0d73so61898631fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 22:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688536079; x=1691128079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmroFXVskoyZWXutVUB2JGgpokOFhXT+2nZZqoGKkeE=;
 b=IXj1vzxBDNdXIuG15C/3rUbAuXFxw3506sg5w6EjfICRzmOj4I98P6JWkHO9R06r2q
 7Bd4x4wXFHb+20mGuls9vhfoVQEfV018xNbohBHMykYfKvdirU3bKpCqVd47gaKe3CUC
 SjscFdtticMg/NCUYDpvytgduSDIg2bJ2UPvM7M4ctePYZdc66Rzt3ZROXP1LipcJscg
 1TYIb958siaUyVgGvXngl1e1kGdYIbdbA5+PaXwcVqnZ3vFsasmICQRNKfit0UH6fBEh
 atdT/mVoYOyNJWNx1uOMV5VPrvFHpj5v2pnVsP5L0I3xjKgpu5oMsAarr2wH/tLiIEL3
 tyug==
X-Gm-Message-State: ABy/qLa/t9pYk6TNIWa/nMg92Qb30eN+R0H+4Ulk6207wsHFfSx0c0nO
 H1vVFtCGA781FojxJEg847A65a+7TwXj4gHli0O8K7wo1kGdWc5X3alyQ0iKYLEssWyyzrF9xmx
 8pgYQ2Tzu7ipw6OvOfWWDB1Lqd4EHhpRH8o9aagw7oYa6NrNjFhhD1EfJ4w==
X-Received: by 2002:a2e:3009:0:b0:2b6:cca1:9760 with SMTP id
 w9-20020a2e3009000000b002b6cca19760mr11268099ljw.27.1688536079034; 
 Tue, 04 Jul 2023 22:47:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJbAcx5OnoQwwCDRsQy35e80ns53wHBT0+rOr5PDRG5BfxOWvyoxtkBwuXWvIM6RmL1kY1Ozn/caXk3lKPNRU=
X-Received: by 2002:a2e:3009:0:b0:2b6:cca1:9760 with SMTP id
 w9-20020a2e3009000000b002b6cca19760mr11268038ljw.27.1688536076088; Tue, 04
 Jul 2023 22:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
 <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
 <20230705012917-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705012917-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 13:47:44 +0800
Message-ID: <CACGkMEtBjTmChSQX_E_n6yvTi9rxH5UrXgfAU5qZsFAF-RZQWw@mail.gmail.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, leiyang@redhat.com
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

T24gV2VkLCBKdWwgNSwgMjAyMyBhdCAxOjMx4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwMToxMTozN1BN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCA2OjE2
4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA1OjI2OjAyUE0gLTA3MDAsIFNpLVdlaSBMaXUg
d3JvdGU6Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IE9uIDcvMy8yMDIzIDg6NDYgQU0sIE1pY2hh
ZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA0
OjI1OjE0UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4gPiBPZmZlciB0
aGlzIGJhY2tlbmQgZmVhdHVyZSBhcyBtbHg1IGlzIGNvbXBhdGlibGUgd2l0aCBpdC4gSXQgYWxs
b3dzIGl0Cj4gPiA+ID4gPiA+IHRvIGRvIGxpdmUgbWlncmF0aW9uIHdpdGggQ1ZRLCBkeW5hbWlj
YWxseSBzd2l0Y2hpbmcgYmV0d2VlbiBwYXNzdGhyb3VnaAo+ID4gPiA+ID4gPiBhbmQgc2hhZG93
IHZpcnRxdWV1ZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5p
byBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiBTYW1lIGNvbW1lbnQuCj4g
PiA+ID4gdG8gd2hpY2g/Cj4gPiA+ID4KPiA+ID4gPiAtU2l3ZWkKPiA+ID4KPiA+ID4gVkhPU1Rf
QkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0sgaXMgdG9vIG5hcnJvdyBhIHVzZS1jYXNl
IHRvIGNvbW1pdCB0byBpdAo+ID4gPiBhcyBhIGtlcm5lbC91c2Vyc3BhY2UgQUJJOiB3aGF0IGlm
IG9uZSB3YW50cyB0byBzdGFydCByaW5ncyBpbiBzb21lCj4gPiA+IG90aGVyIHNwZWNpZmljIG9y
ZGVyPwo+ID4KPiA+IEp1c3QgZW5hYmxlIGEgcXVldWUgYnkgd3JpdGluZyBlLmcgMSB0byBxdWV1
ZV9lbmFibGUgaW4gYSBzcGVjaWZpYyBvcmRlcj8KPgo+Cj4gQnV0IHRoZW4gYXQgZHJpdmVyIG9r
IHRpbWUgd2UgZG9uJ3Qga25vdyBob3cgbWFueSBxdWV1ZXMgYXJlIHRoZXJlLgoKVGhlcmUgc2hv
dWxkIGJlIGEgZGV2aWNlIHNwZWNpZmljIGludGVyZmFjZSBmb3IgdGhpcywgZm9yIGV4YW1wbGUs
Cm51bV9xdWV1ZV9wYXJpcy4gU28gdGhlIGRldmljZSBrbm93cyBhdCBtb3N0IGhvdyBtYW55IHF1
ZXVlcyB0aGVyZQphcmUuIE9yIGFueXRoaW5nIEkgbWlzcz8KCj4KPiA+ID4gQXMgd2FzIGRpc2N1
c3NlZCBvbiBsaXN0LCBhIGJldHRlciBwcm9taXNlIGlzIG5vdCB0byBhY2Nlc3MgcmluZwo+ID4g
PiB1bnRpbCB0aGUgMXN0IGtpY2suIHZkcGEgY2FuIHRoZW4gZG8gYSBraWNrIHdoZW4gaXQgd2Fu
dHMKPiA+ID4gdGhlIGRldmljZSB0byBzdGFydCBhY2Nlc3NpbmcgcmluZ3MuCj4gPgo+ID4gUmV0
aGluayBhYm91dCB0aGUgQUNDRVNTX0FGVEVSX0tJQ0ssIGl0IHNvdW5kcyBmdW5jdGlvbmFsIGVx
dWl2YWxlbnQKPiA+IHRvIGFsbG93IHF1ZXVlX2VuYWJsZSBhZnRlciBEUklWRVJfT0ssIGJ1dCBp
dCBzZWVtcyB0byBoYXZlCj4gPiBkaXN0YW52YWdlczoKPiA+Cj4gPiBBIGJ1c3kgcG9sbGluZyBz
b2Z0d2FyZSBkZXZpY2UgbWF5IGRpc2FibGUgbm90aWZpY2F0aW9ucyBhbmQgbmV2ZXIKPiA+IHJl
c3BvbmQgdG8gcmVnaXN0ZXIgdG8gYW55IGtpY2sgbm90aWZpZXJzLiBBQ0NFU1NfQUZURVJfS0lD
SyB3aWxsCj4gPiBpbnRyb2R1Y2Ugb3ZlcmhlYWQgdG8gdGhvc2UgaW1wbGVtZW50YXRpb25zLgo+
ID4KPiA+IFRoYW5rcwo+Cj4gSXQncyBqdXN0IHRoZSAxc3Qga2ljaywgdGhlbiB5b3UgY2FuIGRp
c2FibGUuIE5vPwoKWWVzLCBidXQ6CgoxKSBhZGRpbmcgaG9va3MgZm9yIHF1ZXVlX2VuYWJsZQoy
KSBhZGRpbmcgbmV3IGNvZGVzIHRvIHJlZ2lzdGVyIGV2ZW50IG5vdGlmaWVyIGFuZCB0b2dnbGUg
dGhlIG5vdGlmaWVyCgoxKSBzZWVtcyBtdWNoIGVhc2llcj8gT3IgZm9yIG1vc3QgZGV2aWNlcywg
aXQgYWxyZWFkeSBiZWhhdmVzIGxpa2UgdGhpcy4KClRoYW5rcwoKPgo+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jIHwgNyArKysrKysrCj4gPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4gPiA+ID4gPiA+IGluZGV4IDkxMzhlZjJmYjJjOC4uNWYzMDlhMTZiOWRjIDEwMDY0NAo+ID4g
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+
ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+IEBA
IC03LDYgKzcsNyBAQAo+ID4gPiA+ID4gPiAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19u
ZXQuaD4KPiA+ID4gPiA+ID4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9faWRzLmg+Cj4g
PiA+ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmRwYS5oPgo+ID4gPiA+ID4gPiArI2lu
Y2x1ZGUgPHVhcGkvbGludXgvdmhvc3RfdHlwZXMuaD4KPiA+ID4gPiA+ID4gICAjaW5jbHVkZSA8
bGludXgvdmlydGlvX2NvbmZpZy5oPgo+ID4gPiA+ID4gPiAgICNpbmNsdWRlIDxsaW51eC9hdXhp
bGlhcnlfYnVzLmg+Cj4gPiA+ID4gPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21seDUvY3EuaD4KPiA+
ID4gPiA+ID4gQEAgLTI0OTksNiArMjUwMCwxMSBAQCBzdGF0aWMgdm9pZCB1bnJlZ2lzdGVyX2xp
bmtfbm90aWZpZXIoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgIGZsdXNoX3dvcmtxdWV1ZShuZGV2LT5tdmRldi53cSk7Cj4gPiA+ID4gPiA+
ICAgfQo+ID4gPiA+ID4gPiArc3RhdGljIHU2NCBtbHg1X3ZkcGFfZ2V0X2JhY2tlbmRfZmVhdHVy
ZXMoY29uc3Qgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ID4gPiA+ID4gPiArewo+ID4gPiA+
ID4gPiArIHJldHVybiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVS
X09LKTsKPiA+ID4gPiA+ID4gK30KPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiAgIHN0YXRpYyBp
bnQgbWx4NV92ZHBhX3NldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
LCB1NjQgZmVhdHVyZXMpCj4gPiA+ID4gPiA+ICAgewo+ID4gPiA+ID4gPiAgICAgICAgICAgc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gPiA+ID4gPiA+IEBA
IC0zMTQwLDYgKzMxNDYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBt
bHg1X3ZkcGFfb3BzID0gewo+ID4gPiA+ID4gPiAgICAgICAgICAgLmdldF92cV9hbGlnbiA9IG1s
eDVfdmRwYV9nZXRfdnFfYWxpZ24sCj4gPiA+ID4gPiA+ICAgICAgICAgICAuZ2V0X3ZxX2dyb3Vw
ID0gbWx4NV92ZHBhX2dldF92cV9ncm91cCwKPiA+ID4gPiA+ID4gICAgICAgICAgIC5nZXRfZGV2
aWNlX2ZlYXR1cmVzID0gbWx4NV92ZHBhX2dldF9kZXZpY2VfZmVhdHVyZXMsCj4gPiA+ID4gPiA+
ICsgLmdldF9iYWNrZW5kX2ZlYXR1cmVzID0gbWx4NV92ZHBhX2dldF9iYWNrZW5kX2ZlYXR1cmVz
LAo+ID4gPiA+ID4gPiAgICAgICAgICAgLnNldF9kcml2ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFf
c2V0X2RyaXZlcl9mZWF0dXJlcywKPiA+ID4gPiA+ID4gICAgICAgICAgIC5nZXRfZHJpdmVyX2Zl
YXR1cmVzID0gbWx4NV92ZHBhX2dldF9kcml2ZXJfZmVhdHVyZXMsCj4gPiA+ID4gPiA+ICAgICAg
ICAgICAuc2V0X2NvbmZpZ19jYiA9IG1seDVfdmRwYV9zZXRfY29uZmlnX2NiLAo+ID4gPiA+ID4g
PiAtLQo+ID4gPiA+ID4gPiAyLjM5LjMKPiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
