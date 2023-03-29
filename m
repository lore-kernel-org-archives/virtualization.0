Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00932C74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 05:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66BBF60BEF;
	Wed, 29 Mar 2023 05:21:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66BBF60BEF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FUZXC4+2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tNYKtKtas7zN; Wed, 29 Mar 2023 05:21:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD68C60BE3;
	Wed, 29 Mar 2023 05:21:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD68C60BE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96F02C0037;
	Wed, 29 Mar 2023 05:21:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24C15C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 062B060BEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:21:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 062B060BEF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w6xKSmtd82lB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:21:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70F7060BE3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70F7060BE3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680067311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpGviQRkMdN9wce+9FcdKHJnUT5elcV+86MUr/viZsA=;
 b=FUZXC4+22ugScg8ITD4C9envEqldQvHq3Q04AuHH92D7So8gOq/6e9PXVUpAr89x3wkHby
 xRwo2HCN7TTi1QP9yYtKOhMo4vssFfX84wXp9OcLNziWQIAYdVsMzHZL0qjXr4D+X6SVSE
 hwkepsef2Qu+bX28fTjdTHvt5u7cBG0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-cjlfq4IhM6yjOPK0uu9zUg-1; Wed, 29 Mar 2023 01:21:47 -0400
X-MC-Unique: cjlfq4IhM6yjOPK0uu9zUg-1
Received: by mail-wm1-f70.google.com with SMTP id
 l18-20020a05600c1d1200b003ef7b61e2fdso1483979wms.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 22:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680067306;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OpGviQRkMdN9wce+9FcdKHJnUT5elcV+86MUr/viZsA=;
 b=Id4TAHeUU1jJOukXNVuRjmqr7SNRjNAIoI9CaBzhhkF1jgy0YeeL4GODCyMB1+E37G
 2CUVdTLL1bz0xj8B1Wr9fCnY7THKodgoYe1lFfEPtFjLfxCMRayeo36VXnyACNrL2ODe
 N3dTQvNFyE2aMx+MSJGKQDtCbGR5J/isIg9FfEFjDIeq0fkZHC5mslxCW0BUA/LP48XL
 ME2XdHe9hTp1rN0iM51BiZll59ESurUYekKeKQrPym3Pp8ynlNQ9tQCk8LQslTpofU26
 NJWgVMmWIiI+v5KyVy36kc/La0BLh05ZZYEMkYAN2bc/UURox64X7zbdBoFYetAAhKwW
 lp2g==
X-Gm-Message-State: AO0yUKWJxD3MBgVboZP/Luj515ACl8XkFgQQXTf94+UywUpInmC3R/u3
 1l9mLhVXwLAbU6w5EJ0tBdXmf0t5QlKRruh1r+mlQVPQF3RJieab5CHh2TGslu3pkHTLcDpzN/k
 wXsOtky8efzswDu/LZCN+JGHgZsUoVmHUWPct3dohRw==
X-Received: by 2002:a7b:cd87:0:b0:3ee:4bd1:39ca with SMTP id
 y7-20020a7bcd87000000b003ee4bd139camr14369620wmj.13.1680067306594; 
 Tue, 28 Mar 2023 22:21:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set/tmTFTti71Jcmt7sCqKWDaOTmwRd2t6ytr8BVNSqDkPDfdxs7xKF1RNBRRGc20wi2FCQRbHw==
X-Received: by 2002:a7b:cd87:0:b0:3ee:4bd1:39ca with SMTP id
 y7-20020a7bcd87000000b003ee4bd139camr14369604wmj.13.1680067306240; 
 Tue, 28 Mar 2023 22:21:46 -0700 (PDT)
Received: from redhat.com ([2.52.18.165]) by smtp.gmail.com with ESMTPSA id
 s2-20020a5d5102000000b002c71b4d476asm29084170wrt.106.2023.03.28.22.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 22:21:45 -0700 (PDT)
Date: Wed, 29 Mar 2023 01:21:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
Message-ID: <20230329012038-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
 <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eric Van Hensbergen <ericvh@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 v9fs-developer@lists.sourceforge.net
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTE6Mzk6NTlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIE1hciAyOCwgMjAyMyBhdCAxMTowOeKAr0FNIOm7hOadsCA8aHVhbmdqaWUu
YWxiZXJ0QGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+ID4KPiA+IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IOS6jjIwMjPlubQz5pyIMjjml6XlkajkuowgMTA6NTnlhpnpgZPvvJoKPiA+
ID4KPiA+ID4gT24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTA6MTPigK9BTSBEb21pbmlxdWUgTWFy
dGluZXQKPiA+ID4gPGFzbWFkZXVzQGNvZGV3cmVjay5vcmc+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+
ID4gSGkgTWljaGFlbCwgQWxiZXJ0LAo+ID4gPiA+Cj4gPiA+ID4gQWxiZXJ0IEh1YW5nIHdyb3Rl
IG9uIFNhdCwgTWFyIDI1LCAyMDIzIGF0IDA2OjU2OjMzUE0gKzA4MDA6Cj4gPiA+ID4gPiBpbiB2
aXJ0aW9fbmV0LCBpZiB3ZSBkaXNhYmxlIHRoZSBuYXBpX3R4LCB3aGVuIHdlIHRyaWdlciBhIHR4
IGludGVycnVwdCwKPiA+ID4gPiA+IHRoZSB2cS0+ZXZlbnRfdHJpZ2dlcmVkIHdpbGwgYmUgc2V0
IHRvIHRydWUuIEl0IHdpbGwgbm8gbG9uZ2VyIGJlIHNldCB0bwo+ID4gPiA+ID4gZmFsc2UuIFVu
bGVzcyB3ZSBleHBsaWNpdGx5IGNhbGwgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkIG9yCj4g
PiA+ID4gPiB2aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUuCj4gPiA+ID4KPiA+ID4gPiBUaGlz
IHBhdGNoIChjb21taXRlZCBhcyAzNTM5NTc3MGY4MDMgKCJ2aXJ0aW9fcmluZzogZG9uJ3QgdXBk
YXRlIGV2ZW50Cj4gPiA+ID4gaWR4IG9uIGdldF9idWYiKSBpbiBuZXh0LTIwMjMwMzI3IGFwcGFy
ZW50bHkgYnJlYWtzIDlwLCBhcyByZXBvcnRlZCBieQo+ID4gPiA+IEx1aXMgaW4gaHR0cHM6Ly9s
a21sLmtlcm5lbC5vcmcvci9aQ0krN1dnNU9jbFNsRThjQGJvbWJhZGlsLmluZnJhZGVhZC5vcmcK
PiA+ID4gPgo+ID4gPiA+IEkndmUganVzdCBoaXQgaGFkIGEgbG9vayBhdCByZWNlbnQgcGF0Y2hl
c1sxXSBhbmQgcmV2ZXJ0ZWQgdGhpcyB0byB0ZXN0Cj4gPiA+ID4gYW5kIEkgY2FuIG1vdW50IGFn
YWluLCBzbyBJJ20gcHJldHR5IHN1cmUgdGhpcyBpcyB0aGUgY3VscHJpdCwgYnV0IEkKPiA+ID4g
PiBkaWRuJ3QgbG9vayBhdCB0aGUgY29udGVudCBhdCBhbGwgeWV0IHNvIGNhbm5vdCBhZHZpc2Ug
ZnVydGhlci4KPiA+ID4gPiBJdCBtaWdodCB2ZXJ5IHdlbGwgYmUgdGhhdCB3ZSBuZWVkIHNvbWUg
ZXh0cmEgaGFuZGxpbmcgZm9yIDlwCj4gPiA+ID4gc3BlY2lmaWNhbGx5IHRoYXQgY2FuIGJlIGFk
ZGVkIHNlcGFyYXRlbHkgaWYgcmVxdWlyZWQuCj4gPiA+ID4KPiA+ID4gPiBbMV0gZ2l0IGxvZyAw
ZWM1N2NmYTcyMWZiZDM2YjRjNGMwZDljY2M1ZDc4YTc4ZjdmYTM1Li5IRUFEIGRyaXZlcnMvdmly
dGlvLwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGlzIGNhbiBiZSByZXByb2R1Y2VkIHdpdGgg
YSBzaW1wbGUgbW91bnQsIHJ1biBxZW11IHdpdGggc29tZSAtdmlydGZzCj4gPiA+ID4gYXJndW1l
bnQgYW5kIGBtb3VudCAtdCA5cCAtbyBkZWJ1Zz02NTUzNSB0YWcgbW91bnRwb2ludGAgd2lsbCBo
YW5nIGFmdGVyCj4gPiA+ID4gdGhlc2UgbWVzc2FnZXM6Cj4gPiA+ID4gOXBuZXQ6IC0tIHA5X3Zp
cnRpb19yZXF1ZXN0ICg4Myk6IDlwIGRlYnVnOiB2aXJ0aW8gcmVxdWVzdAo+ID4gPiA+IDlwbmV0
OiAtLSBwOV92aXJ0aW9fcmVxdWVzdCAoODMpOiB2aXJ0aW8gcmVxdWVzdCBraWNrZWQKPiA+ID4g
Pgo+ID4gPiA+IFNvIEkgc3VzcGVjdCB3ZSdyZSBqdXN0IG5vdCBnZXR0aW5nIGEgY2FsbGJhY2su
Cj4gPiA+Cj4gPiA+IEkgdGhpbmsgc28uIFRoZSBwYXRjaCBhc3N1bWVzIHRoZSBkcml2ZXIgd2ls
bCBjYWxsCj4gPiA+IHZpcnRxdWV1ZV9kaXNhYmxlL2VuYWJsZV9jYigpIHdoaWNoIGlzIG5vdCB0
aGUgY2FzZSBvZiB0aGUgOXAgZHJpdmVyLgo+ID4gPgo+ID4gPiBTbyBhZnRlciB0aGUgZmlyc3Qg
aW50ZXJydXB0LCBldmVudF90cmlnZ2VyZWQgd2lsbCBiZSBzZXQgdG8gdHJ1ZSBmb3JldmVyLgo+
ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+Cj4gPiBIaTogV2FuZwo+ID4KPiA+IFllcywgIFRo
aXMgcGF0Y2ggYXNzdW1lcyB0aGF0IGFsbCB2aXJ0aW8tcmVsYXRlZCBkcml2ZXJzIHdpbGwgY2Fs
bAo+ID4gdmlydHF1ZXVlX2Rpc2FibGUvZW5hYmxlX2NiKCkuCj4gPiBUaGFuayB5b3UgZm9yIHJh
aXNpbmcgdGhpcyBpc3N1ZS4KPiA+Cj4gPiBJdCBzZWVtcyB0aGF0IG5hcGlfdHggaXMgb25seSBy
ZWxhdGVkIHRvIHZpcnR1ZV9uZXQuIEknbSB0aGlua2luZyBpZgo+ID4gd2UgbmVlZCB0byByZWZh
Y3Rvcgo+ID4gbmFwaV90eCBpbnN0ZWFkIG9mIGltcGxlbWVudGluZyBpdCBpbnNpZGUgdmlydGlv
X3JpbmcuCj4gCj4gV2UgY2FuIGhlYXIgZnJvbSBvdGhlcnMuCj4gCj4gSSB0aGluayBpdCdzIGJl
dHRlciBub3QgdG8gd29ya2Fyb3VuZCB2aXJ0aW9fcmluZyBpc3N1ZXMgaW4gYSBzcGVjaWZpYwo+
IGRyaXZlci4gSXQgbWlnaHQganVzdCBhZGQgbW9yZSBoYWNrcy4gV2Ugc2hvdWxkIGNvcnJlY3Rs
eSBzZXQKPiBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCwKCkkgYW0gc3RpbGwgc3R1Y2sgdHJ5
aW5nIHRvIHVuZGVyc3RhbmQgd2h5IHdlIGRvbid0IHNldCBpdC4KSG93IGRvZXMgZXZlbnRfdHJp
Z2dlcmVkIGVuZCB1cCBnZXR0aW5nIHNldCB3aXRob3V0CmV2ZW50IGluZGV4IHN1cHBvcnQ/CgpU
aGFua3MhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
