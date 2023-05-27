Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8F4C77B7E
	for <virtualization@archiver.kernel.org>; Sat, 27 May 2023 12:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10AE360FE0;
	Sat, 27 May 2023 12:35:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10AE360FE0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=AwfeJbB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qsd3RfKkf0OE; Sat, 27 May 2023 12:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C40F60BF0;
	Sat, 27 May 2023 12:35:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C40F60BF0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40B46C0035;
	Sat, 27 May 2023 12:35:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C363AC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DC1C40131
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:35:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DC1C40131
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=AwfeJbB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGngsQF_1V9i
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:35:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62244400EC
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62244400EC
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:35:45 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2af31dc49f9so17802571fa.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685190943; x=1687782943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HH3JkcQQauNz7KukXOkzdyynRXiXt1x0ijLtD/xpm7g=;
 b=AwfeJbB2HWHfDHXNcXulaiLzYHu7UJRrIwYZijFp2G1ylfWY2sRDhIuRb82qL0gz36
 68VC5a9Gk1TR+ZYjXTpmxtGp5O/ju1+Ow/dnfNuUhFLaziJdFWh1wAmJFLSnJQwBNSG1
 HXFuLueAzw/XfpqFdyYvemC8N/GXxsYNIfACkGMWaC663d/nt3WUCxYgXbXrrBWhAf2n
 By9Mzjs76c6Y83B9MfvVz9WM6DhKXZPLCklPOmmI1eLZl4TTJRIXmYzWqBl/2TyY/rsf
 5po8fCjE1IsfBBt0hszNBB8cBKpGqnrRU3Cu3z9++soViPHcYl9UgMJW8GY16fNROsGA
 xoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685190943; x=1687782943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HH3JkcQQauNz7KukXOkzdyynRXiXt1x0ijLtD/xpm7g=;
 b=IkL3Z6fFCkJw+viPNyfDKQFdMjaZsXlQT8CvC6IwW5m6gzmBE1WraOgZum+8LyKk3b
 RXpu6epPVSLDhc9XAqz5W99lhIWN3kmOYAyWQobw8bR7iFSpxrhTpaR+DgsSrXzP/SmN
 H1OLjQ9GE7ChNFjKOmjTVUe+OWbN7hrlE0V/mppkh/Hnqq6ng6XTlylRJ1Kf46D6EmxL
 0Q9mYfqARSC7ainCa3bCjfOMHjo6x5XZ9OsYGzke0WBLSdsQPY7mWzzNWaTM3+v3ud1i
 +G2NoKxchFhzf3RGpT6LmNWpKv/5zTUl5UNjQh49jJVjzkuLBbTialK1ey1YTmMUUcjS
 kH+Q==
X-Gm-Message-State: AC+VfDwaEGTZ2RPUe3CasiHTG/qf2XujSSo+V8IRIVAw2avdrVhDK1rA
 Kfmgl6lkdepSVmI2/XLZR5LbX90TkLSOvrH05qg=
X-Google-Smtp-Source: ACHHUZ62U5Z4wegM5QNY5hw2yPYFqLkSgQphhkY7qkpXtZ2hTwyQ4Wi9GL8lhA/YXAiUWEIXR2XSQnu2Qj6Xb1A2kfU=
X-Received: by 2002:a2e:88d7:0:b0:2ae:e214:482f with SMTP id
 a23-20020a2e88d7000000b002aee214482fmr1602576ljk.52.1685190943003; Sat, 27
 May 2023 05:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-5-liangchen.linux@gmail.com>
 <CACGkMEsrr-3ArBgCksq=c60+5fZ-Xc-i653ix_vdr2f7c7wYfg@mail.gmail.com>
In-Reply-To: <CACGkMEsrr-3ArBgCksq=c60+5fZ-Xc-i653ix_vdr2f7c7wYfg@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 27 May 2023 20:35:31 +0800
Message-ID: <CAKhg4tKcQi4-G8oGWtzTBZztvNKzLP7Q=GGHS=ccH-DgKDCJig@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: Implement DMA pre-handler
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMzowNuKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMTo0N+KAr1BNIExp
YW5nIENoZW4gPGxpYW5nY2hlbi5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IEFkZGlu
ZyBhIERNQSBwcmUtaGFuZGxlciB0aGF0IHV0aWxpemVzIHBhZ2UgcG9vbCBmb3IgbWFuYWdpbmcg
RE1BIG1hcHBpbmdzLgo+ID4gV2hlbiBJT01NVSBpcyBlbmFibGVkLCB0dXJuaW5nIG9uIHRoZSBw
YWdlX3Bvb2xfZG1hX21hcCBtb2R1bGUgcGFyYW1ldGVyIHRvCj4gPiBzZWxlY3QgcGFnZSBwb29s
IGZvciBETUEgbWFwcGluZyBtYW5hZ2VtZW50IGdpdmVzIGEgc2lnbmlmaWNhbnQgcmVkdWN0aW9u
Cj4gPiBpbiB0aGUgb3ZlcmhlYWQgY2F1c2VkIGJ5IERNQSBtYXBwaW5ncy4KPiA+Cj4gPiBJbiB0
ZXN0aW5nIGVudmlyb25tZW50cyB3aXRoIGEgc2luZ2xlIGNvcmUgdm0gYW5kIHFlbXUgZW11bGF0
ZWQgSU9NTVUsCj4gPiBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMgY2FuIGJl
IG9ic2VydmVkOgo+ID4gICBVcHN0cmVhbSBjb2RlYmFzZTogMS43NiBHYml0cy9zZWMKPiA+ICAg
VXBzdHJlYW0gY29kZWJhc2Ugd2l0aCBwYWdlIHBvb2wgZnJhZ21lbnRhdGlvbiBzdXBwb3J0OiAx
LjgxIEdiaXRzL3NlYwo+ID4gICBVcHN0cmVhbSBjb2RlYmFzZSB3aXRoIHBhZ2UgcG9vbCBmcmFn
bWVudGF0aW9uIGFuZCBETUEgc3VwcG9ydDogMTkuMwo+ID4gICBHYml0cy9zZWMKPiA+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBMaWFuZyBDaGVuIDxsaWFuZ2NoZW4ubGludXhAZ21haWwuY29tPgo+ID4g
LS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNTUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25z
KCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gaW5kZXggYWM0MGI4YzY2YzU5Li43M2NjNGY5ZmU0ZmEg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gQEAgLTIyLDYgKzIyLDcgQEAKPiA+ICAjaW5jbHVkZSA8
bmV0L3JvdXRlLmg+Cj4gPiAgI2luY2x1ZGUgPG5ldC94ZHAuaD4KPiA+ICAjaW5jbHVkZSA8bmV0
L25ldF9mYWlsb3Zlci5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9pb21tdS5oPgo+ID4KPiA+ICBz
dGF0aWMgaW50IG5hcGlfd2VpZ2h0ID0gTkFQSV9QT0xMX1dFSUdIVDsKPiA+ICBtb2R1bGVfcGFy
YW0obmFwaV93ZWlnaHQsIGludCwgMDQ0NCk7Cj4gPiBAQCAtMzMsOCArMzQsMTAgQEAgbW9kdWxl
X3BhcmFtKG5hcGlfdHgsIGJvb2wsIDA2NDQpOwo+ID4KPiA+ICBzdGF0aWMgYm9vbCBwYWdlX3Bv
b2xfZW5hYmxlZDsKPiA+ICBzdGF0aWMgYm9vbCBwYWdlX3Bvb2xfZnJhZzsKPiA+ICtzdGF0aWMg
Ym9vbCBwYWdlX3Bvb2xfZG1hX21hcDsKPiA+ICBtb2R1bGVfcGFyYW0ocGFnZV9wb29sX2VuYWJs
ZWQsIGJvb2wsIDA0MDApOwo+ID4gIG1vZHVsZV9wYXJhbShwYWdlX3Bvb2xfZnJhZywgYm9vbCwg
MDQwMCk7Cj4gPiArbW9kdWxlX3BhcmFtKHBhZ2VfcG9vbF9kbWFfbWFwLCBib29sLCAwNDAwKTsK
PiA+Cj4gPiAgLyogRklYTUU6IE1UVSBpbiBjb25maWcuICovCj4gPiAgI2RlZmluZSBHT09EX1BB
Q0tFVF9MRU4gKEVUSF9ITEVOICsgVkxBTl9ITEVOICsgRVRIX0RBVEFfTEVOKQo+ID4gQEAgLTM4
MzAsNiArMzgzMyw0OSBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2RlbF92cXMoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmkpCj4gPiAgICAgICAgIHZpcnRuZXRfZnJlZV9xdWV1ZXModmkpOwo+ID4gIH0K
PiA+Cj4gPiArc3RhdGljIGRtYV9hZGRyX3QgdmlydG5ldF9wcF9kbWFfbWFwX3BhZ2Uoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgcGFnZSAqcGFnZSwKPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgb2Zmc2V0LCBzaXplX3Qgc2l6ZSwK
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gZG1hX2Rh
dGFfZGlyZWN0aW9uIGRpciwgdW5zaWduZWQgbG9uZyBhdHRycykKPiA+ICt7Cj4gPiArICAgICAg
IHN0cnVjdCBwYWdlICpoZWFkX3BhZ2U7Cj4gPiArCj4gPiArICAgICAgIGlmIChkaXIgIT0gRE1B
X0ZST01fREVWSUNFKQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gKwo+ID4gKyAg
ICAgICBoZWFkX3BhZ2UgPSBjb21wb3VuZF9oZWFkKHBhZ2UpOwo+ID4gKyAgICAgICByZXR1cm4g
cGFnZV9wb29sX2dldF9kbWFfYWRkcihoZWFkX3BhZ2UpCj4gPiArICAgICAgICAgICAgICAgKyAo
cGFnZSAtIGhlYWRfcGFnZSkgKiBQQUdFX1NJWkUKPiA+ICsgICAgICAgICAgICAgICArIG9mZnNl
dDsKPgo+IFNvIGl0J3Mgbm90IGEgbWFwLCBpdCBpcyBqdXN0IGEgcXVlcnkgZnJvbSB0aGUgZG1h
IGFkZHJlc3MgZnJvbSB0aGUgcG9vbC4KPgo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgYm9vbCB2
aXJ0bmV0X3BwX2RtYV91bm1hcF9wYWdlKHN0cnVjdCBkZXZpY2UgKmRldiwgZG1hX2FkZHJfdCBk
bWFfaGFuZGxlLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
X3Qgc2l6ZSwgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLAo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGF0dHJzKQo+ID4gK3sKPiA+ICsg
ICAgICAgcGh5c19hZGRyX3QgcGh5czsKPiA+ICsKPiA+ICsgICAgICAgLyogSGFuZGxlIG9ubHkg
dGhlIFJYIGRpcmVjdGlvbiwgYW5kIHN5bmMgdGhlIERNQSBtZW1vcnkgb25seSBpZiBpdCdzIG5v
dAo+ID4gKyAgICAgICAgKiBhIERNQSBjb2hlcmVudCBhcmNoaXRlY3R1cmUuCj4gPiArICAgICAg
ICAqLwo+ID4gKyAgICAgICBpZiAoZGlyICE9IERNQV9GUk9NX0RFVklDRSkKPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7Cj4gPiArCj4gPiArICAgICAgIGlmIChkZXZfaXNfZG1hX2Nv
aGVyZW50KGRldikpCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4gPiArCj4gPiAr
ICAgICAgIHBoeXMgPSBpb21tdV9pb3ZhX3RvX3BoeXMoaW9tbXVfZ2V0X2RtYV9kb21haW4oZGV2
KSwgZG1hX2hhbmRsZSk7Cj4KPiBUaGlzIHdvdWxkIGJlIHNvbWVob3cgc2xvdy4gSWYgd2UgdHJh
Y2sgdGhlIG1hcHBpbmcgYnkgZHJpdmVyLCBpdAo+IHdvdWxkIGJlIG11Y2ggZmFzdGVyLgo+Cj4g
TW9yZSBjb3VsZCBiZSBzZWVuIGhlcmU6Cj4KPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvcGlwZXJtYWlsL3ZpcnR1YWxpemF0aW9uLzIwMjMtTWF5LzA2Njc3OC5odG1sCj4KPiBU
aGFua3MKPgoKVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uIEkgYWdyZWUgd2l0aCB5b3VyIHN1
Z2dlc3Rpb24sIGFuZCBJIHdpbGwKZHJvcCB0aGUgbGFzdCB0d28gcGF0Y2hlcyBvbiB2MiBhbmQg
d2FpdCBmb3IgWHVhbidzIHBhdGNoIHRvIGxhbmQgZm9yCmRtYSBtYXBwaW5nIG1hbmFnZW1lbnQu
CgoKCgo+ID4gKyAgICAgICBpZiAoV0FSTl9PTighcGh5cykpCj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOwo+ID4gKwo+ID4gKyAgICAgICBhcmNoX3N5bmNfZG1hX2Zvcl9jcHUocGh5
cywgc2l6ZSwgZGlyKTsKPiA+ICsgICAgICAgcmV0dXJuIHRydWU7Cj4gPiArfQo+ID4gKwo+ID4g
K3N0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlX3ByZV9kbWFfb3BzIHZpcnRuZXRfcHBfcHJlX2RtYV9v
cHMgPSB7Cj4gPiArICAgICAgIC5tYXBfcGFnZSA9IHZpcnRuZXRfcHBfZG1hX21hcF9wYWdlLAo+
ID4gKyAgICAgICAudW5tYXBfcGFnZSA9IHZpcnRuZXRfcHBfZG1hX3VubWFwX3BhZ2UsCj4gPiAr
fTsKPiA+ICsKPiA+ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X2FsbG9jX3BhZ2VfcG9vbChzdHJ1Y3Qg
cmVjZWl2ZV9xdWV1ZSAqcnEpCj4gPiAgewo+ID4gICAgICAgICBzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiA9IHJxLT52cS0+dmRldjsKPiA+IEBAIC0zODQ1LDYgKzM4OTEsMTUgQEAgc3RhdGlj
IHZvaWQgdmlydG5ldF9hbGxvY19wYWdlX3Bvb2woc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxKQo+
ID4gICAgICAgICBpZiAocGFnZV9wb29sX2ZyYWcpCj4gPiAgICAgICAgICAgICAgICAgcHBfcGFy
YW1zLmZsYWdzIHw9IFBQX0ZMQUdfUEFHRV9GUkFHOwo+ID4KPiA+ICsgICAgICAgLyogQ29uc2lk
ZXIgdXNpbmcgcGFnZSBwb29sIERNQSBzdXBwb3J0IG9ubHkgd2hlbiBETUEgQVBJIGlzIHVzZWQu
ICovCj4gPiArICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfQUND
RVNTX1BMQVRGT1JNKSAmJgo+ID4gKyAgICAgICAgICAgcGFnZV9wb29sX2RtYV9tYXApIHsKPiA+
ICsgICAgICAgICAgICAgICBwcF9wYXJhbXMuZmxhZ3MgfD0gUFBfRkxBR19ETUFfTUFQIHwgUFBf
RkxBR19ETUFfU1lOQ19ERVY7Cj4gPiArICAgICAgICAgICAgICAgcHBfcGFyYW1zLmRtYV9kaXIg
PSBETUFfRlJPTV9ERVZJQ0U7Cj4gPiArICAgICAgICAgICAgICAgcHBfcGFyYW1zLm1heF9sZW4g
PSBQQUdFX1NJWkUgPDwgcHBfcGFyYW1zLm9yZGVyOwo+ID4gKyAgICAgICAgICAgICAgIHZpcnRx
dWV1ZV9yZWdpc3Rlcl9wcmVfZG1hX29wcyhycS0+dnEsICZ2aXJ0bmV0X3BwX3ByZV9kbWFfb3Bz
KTsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gICAgICAgICBycS0+cGFnZV9wb29sID0gcGFnZV9w
b29sX2NyZWF0ZSgmcHBfcGFyYW1zKTsKPiA+ICAgICAgICAgaWYgKElTX0VSUihycS0+cGFnZV9w
b29sKSkgewo+ID4gICAgICAgICAgICAgICAgIGRldl93YXJuKCZ2ZGV2LT5kZXYsICJwYWdlIHBv
b2wgY3JlYXRpb24gZmFpbGVkOiAlbGRcbiIsCj4gPiAtLQo+ID4gMi4zMS4xCj4gPgo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
