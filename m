Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C766EB64DD
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 05:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 097A981774;
	Wed,  5 Jul 2023 05:32:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 097A981774
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KBFvwunP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f75VBgUxCEum; Wed,  5 Jul 2023 05:32:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B2428145C;
	Wed,  5 Jul 2023 05:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B2428145C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44212C0071;
	Wed,  5 Jul 2023 05:31:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40BADC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13C774023F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13C774023F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KBFvwunP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdXV-XGH6zfv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:31:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4295B400D9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4295B400D9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 05:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688535116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaBreXALaiDujCG9FpTlZRCjnSGLXKmm/+3QKpTX21g=;
 b=KBFvwunP6rJnhZdazFshC9/awbM0bkWAtDssIGbq1cjUac6qd6mvg6t3Qx8ri2cVUIunAK
 pRuJlmytfeyafrqn20Nx/5hm9ywyDYCkbtGlIC57qB+Rs4Qx2FuN9rJAWvNXWeeY8rDHV2
 BJAdO4Z2ZkfI6uEEneU+Tr3M+BFt2/A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-tIF_dLKtMZqAxJIG2JDFoA-1; Wed, 05 Jul 2023 01:31:53 -0400
X-MC-Unique: tIF_dLKtMZqAxJIG2JDFoA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso2456469f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 22:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688535112; x=1691127112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VaBreXALaiDujCG9FpTlZRCjnSGLXKmm/+3QKpTX21g=;
 b=Twh7G14WM8N/Zvxfhh2RcsE9Ihwu/gIwDUCNw/gi2sRwKcmVQ2bCbmoMhfxqtmGZuX
 57Hem2gtQy9Sqy20JAdMq2Mn+cPRYkEN8T9IEmnYT05KO73in3nH1hFS+Aqvv+VC5W5+
 Ikc0O70gaF6ULDt4LHucVlVOjgBfKsKg6v9NHSCRAizVu1ib5/535fO00XVCqk+V1X81
 y7QePL4kVyEho8vMfFVay/CjE+06Gn0si6zhl91ImblYt9a3OlhWLqm7NrYbEDciBC2u
 oJxfDDwjPa8XvcqWmun+t/0hiUzjI+B0WJGGZSXzkOs4N2S6+yDsnody5Zyui8VB/0zk
 LCuA==
X-Gm-Message-State: ABy/qLZJri2jxYTs60n6a2yuTuULOskYj3Ji8jOFBcMei09x8rQBA6cB
 5NK1zsokyrdoTP5NDuau3jdzBgBoy4ZLEW5v7ImoPCh0EuugrDngbx9Y/iNHuhnm/Yky2WnKaMt
 nxraDKw13kHA97jeulLFuHTMfUTrsF5DgBOm++YCgtA==
X-Received: by 2002:adf:fec4:0:b0:313:eeb0:224f with SMTP id
 q4-20020adffec4000000b00313eeb0224fmr11879220wrs.58.1688535112725; 
 Tue, 04 Jul 2023 22:31:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAHNwYr2J9ytwEjWAVzIq67JC/TN9B1i6Wr8FDpQd+zcJTvAZBQ6jJ6R+cPaiD9XqYHfLqog==
X-Received: by 2002:adf:fec4:0:b0:313:eeb0:224f with SMTP id
 q4-20020adffec4000000b00313eeb0224fmr11879203wrs.58.1688535112210; 
 Tue, 04 Jul 2023 22:31:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:91bf:2a8a:e512:df36:67d3])
 by smtp.gmail.com with ESMTPSA id
 k9-20020adff5c9000000b0031411b7087dsm17025358wrp.20.2023.07.04.22.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 22:31:51 -0700 (PDT)
Date: Wed, 5 Jul 2023 01:31:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20230705012917-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
 <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, leiyang@redhat.com
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

T24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDE6MTE6MzdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEp1bCA0LCAyMDIzIGF0IDY6MTbigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAw
NToyNjowMlBNIC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4gPgo+ID4gPgo+ID4gPiBPbiA3
LzMvMjAyMyA4OjQ2IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gT24gTW9u
LCBKdWwgMDMsIDIwMjMgYXQgMDQ6MjU6MTRQTSArMDIwMCwgRXVnZW5pbyBQw6lyZXogd3JvdGU6
Cj4gPiA+ID4gPiBPZmZlciB0aGlzIGJhY2tlbmQgZmVhdHVyZSBhcyBtbHg1IGlzIGNvbXBhdGli
bGUgd2l0aCBpdC4gSXQgYWxsb3dzIGl0Cj4gPiA+ID4gPiB0byBkbyBsaXZlIG1pZ3JhdGlvbiB3
aXRoIENWUSwgZHluYW1pY2FsbHkgc3dpdGNoaW5nIGJldHdlZW4gcGFzc3Rocm91Z2gKPiA+ID4g
PiA+IGFuZCBzaGFkb3cgdmlydHF1ZXVlLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPiA+IFNhbWUgY29t
bWVudC4KPiA+ID4gdG8gd2hpY2g/Cj4gPiA+Cj4gPiA+IC1TaXdlaQo+ID4KPiA+IFZIT1NUX0JB
Q0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGlzIHRvbyBuYXJyb3cgYSB1c2UtY2FzZSB0
byBjb21taXQgdG8gaXQKPiA+IGFzIGEga2VybmVsL3VzZXJzcGFjZSBBQkk6IHdoYXQgaWYgb25l
IHdhbnRzIHRvIHN0YXJ0IHJpbmdzIGluIHNvbWUKPiA+IG90aGVyIHNwZWNpZmljIG9yZGVyPwo+
IAo+IEp1c3QgZW5hYmxlIGEgcXVldWUgYnkgd3JpdGluZyBlLmcgMSB0byBxdWV1ZV9lbmFibGUg
aW4gYSBzcGVjaWZpYyBvcmRlcj8KCgpCdXQgdGhlbiBhdCBkcml2ZXIgb2sgdGltZSB3ZSBkb24n
dCBrbm93IGhvdyBtYW55IHF1ZXVlcyBhcmUgdGhlcmUuCgo+ID4gQXMgd2FzIGRpc2N1c3NlZCBv
biBsaXN0LCBhIGJldHRlciBwcm9taXNlIGlzIG5vdCB0byBhY2Nlc3MgcmluZwo+ID4gdW50aWwg
dGhlIDFzdCBraWNrLiB2ZHBhIGNhbiB0aGVuIGRvIGEga2ljayB3aGVuIGl0IHdhbnRzCj4gPiB0
aGUgZGV2aWNlIHRvIHN0YXJ0IGFjY2Vzc2luZyByaW5ncy4KPiAKPiBSZXRoaW5rIGFib3V0IHRo
ZSBBQ0NFU1NfQUZURVJfS0lDSywgaXQgc291bmRzIGZ1bmN0aW9uYWwgZXF1aXZhbGVudAo+IHRv
IGFsbG93IHF1ZXVlX2VuYWJsZSBhZnRlciBEUklWRVJfT0ssIGJ1dCBpdCBzZWVtcyB0byBoYXZl
Cj4gZGlzdGFudmFnZXM6Cj4gCj4gQSBidXN5IHBvbGxpbmcgc29mdHdhcmUgZGV2aWNlIG1heSBk
aXNhYmxlIG5vdGlmaWNhdGlvbnMgYW5kIG5ldmVyCj4gcmVzcG9uZCB0byByZWdpc3RlciB0byBh
bnkga2ljayBub3RpZmllcnMuIEFDQ0VTU19BRlRFUl9LSUNLIHdpbGwKPiBpbnRyb2R1Y2Ugb3Zl
cmhlYWQgdG8gdGhvc2UgaW1wbGVtZW50YXRpb25zLgo+IAo+IFRoYW5rcwoKSXQncyBqdXN0IHRo
ZSAxc3Qga2ljaywgdGhlbiB5b3UgY2FuIGRpc2FibGUuIE5vPwoKPiA+Cj4gPiA+ID4KPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA3
ICsrKysrKysKPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+ID4g
PiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+IGluZGV4
IDkxMzhlZjJmYjJjOC4uNWYzMDlhMTZiOWRjIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+IEBAIC03LDYgKzcsNyBAQAo+ID4gPiA+ID4g
ICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+Cj4gPiA+ID4gPiAgICNpbmNsdWRl
IDx1YXBpL2xpbnV4L3ZpcnRpb19pZHMuaD4KPiA+ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGlu
dXgvdmRwYS5oPgo+ID4gPiA+ID4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmg+
Cj4gPiA+ID4gPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gPiA+ID4gPiAg
ICNpbmNsdWRlIDxsaW51eC9hdXhpbGlhcnlfYnVzLmg+Cj4gPiA+ID4gPiAgICNpbmNsdWRlIDxs
aW51eC9tbHg1L2NxLmg+Cj4gPiA+ID4gPiBAQCAtMjQ5OSw2ICsyNTAwLDExIEBAIHN0YXRpYyB2
b2lkIHVucmVnaXN0ZXJfbGlua19ub3RpZmllcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIGZsdXNoX3dvcmtxdWV1ZShuZGV2LT5tdmRldi53
cSk7Cj4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+ICtzdGF0aWMgdTY0IG1seDVfdmRwYV9nZXRfYmFj
a2VuZF9mZWF0dXJlcyhjb25zdCBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gPiA+ID4gPiAr
ewo+ID4gPiA+ID4gKyByZXR1cm4gQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVS
X0RSSVZFUl9PSyk7Cj4gPiA+ID4gPiArfQo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gICBzdGF0aWMg
aW50IG1seDVfdmRwYV9zZXRfZHJpdmVyX2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdTY0IGZlYXR1cmVzKQo+ID4gPiA+ID4gICB7Cj4gPiA+ID4gPiAgICAgICAgICAgc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gPiA+ID4gPiBAQCAtMzE0
MCw2ICszMTQ2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgbWx4NV92
ZHBhX29wcyA9IHsKPiA+ID4gPiA+ICAgICAgICAgICAuZ2V0X3ZxX2FsaWduID0gbWx4NV92ZHBh
X2dldF92cV9hbGlnbiwKPiA+ID4gPiA+ICAgICAgICAgICAuZ2V0X3ZxX2dyb3VwID0gbWx4NV92
ZHBhX2dldF92cV9ncm91cCwKPiA+ID4gPiA+ICAgICAgICAgICAuZ2V0X2RldmljZV9mZWF0dXJl
cyA9IG1seDVfdmRwYV9nZXRfZGV2aWNlX2ZlYXR1cmVzLAo+ID4gPiA+ID4gKyAuZ2V0X2JhY2tl
bmRfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfZ2V0X2JhY2tlbmRfZmVhdHVyZXMsCj4gPiA+ID4gPiAg
ICAgICAgICAgLnNldF9kcml2ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfc2V0X2RyaXZlcl9mZWF0
dXJlcywKPiA+ID4gPiA+ICAgICAgICAgICAuZ2V0X2RyaXZlcl9mZWF0dXJlcyA9IG1seDVfdmRw
YV9nZXRfZHJpdmVyX2ZlYXR1cmVzLAo+ID4gPiA+ID4gICAgICAgICAgIC5zZXRfY29uZmlnX2Ni
ID0gbWx4NV92ZHBhX3NldF9jb25maWdfY2IsCj4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gMi4zOS4z
Cj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
