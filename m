Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D72AC433ED
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:17:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB9F611B0
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB9F611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3A79605EE;
	Mon,  3 May 2021 08:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0F2B_2cv_61; Mon,  3 May 2021 08:17:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FD68605B2;
	Mon,  3 May 2021 08:17:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53555C000D;
	Mon,  3 May 2021 08:17:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA387C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AF2C40465
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:17:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mp7yhm1pUiA8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9BB2400D0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620029848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfawQKRvown06amibYWUjSz6pHPc1TD9YuoP34dEXPs=;
 b=eAvL4bWTGN/LxMst5RSjve+VFmqD3V3izl2IHNQuu1OwnijmB6tMHgRUWiwZOLhBcTMsm9
 DG/XLVby4TvOY//S5dq9uIzQX8l0rFmbQktazJJqN5X0zdOJzPJ3+QwN9D8neW18Yq4L/Q
 vUGMOBfiuL4omSphkhdtspbe0/ljsoA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Qnoz_E5ROFi7mI0ba1G2kw-1; Mon, 03 May 2021 04:17:26 -0400
X-MC-Unique: Qnoz_E5ROFi7mI0ba1G2kw-1
Received: by mail-wm1-f70.google.com with SMTP id
 y184-20020a1ce1c10000b0290143299f39d7so2163173wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 01:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sfawQKRvown06amibYWUjSz6pHPc1TD9YuoP34dEXPs=;
 b=a0EdrQhRpk4Hpvxf4az3pbNokyLrmdaDi+6QBwSlZ88+47BA3xat+9KQ8AD0VRCBeb
 CgDMz7FX8X/gUNTnmFfvnr32UhGu/G9I201FPz2kWQ5wqh1tSXOigGucIM4/xQ/JlL39
 fucOwfgjnZ2C4BldxJa3E0nqcDB525sNUAsclpIcPKuREdUX1907BNaOEoYVX3A//Mai
 toj2OdcD4A9dQ+gL7XBkGK9ZPqrQW2TP5tgRhbP/SRet1hl4Xsso8H5q4RIO/Uab1sD8
 TL1/M6Q0PqmUVjgM9s0OCUleBvjxgBBPBLFGFBbVufmnV3WLskp47bmXe5K/wMLF2ks3
 ovHQ==
X-Gm-Message-State: AOAM531UckhNlChDQIgPK4DxNmCiQZcexJzews5oD8gCi8RpTvCHStyz
 UsJ/eaZhnoX5W2oTCKJf9QPv4nzfS2PV1NclyZ2DqsTER+gC8/I8JyGW2ymvs30fvsPPLH5cZaa
 sIGpgfe6q7BLVkAmVVFuGaxLnB8gTQh2SDJvqzwBuEQ==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr5318718wrn.362.1620029845876; 
 Mon, 03 May 2021 01:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2jIadbtWNDtdJWbgmNINTRv6VVe2MQ37HEigOuGnTWAK1m/4RJyWkDCR4ie4nJHk26lNs4A==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr5318707wrn.362.1620029845686; 
 Mon, 03 May 2021 01:17:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-133-9.red.bezeqint.net. [79.178.133.9])
 by smtp.gmail.com with ESMTPSA id
 p10sm11997977wre.84.2021.05.03.01.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 01:17:25 -0700 (PDT)
Date: Mon, 3 May 2021 04:17:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: boolean values to a bool variable
Message-ID: <20210503041706-mutt-send-email-mst@kernel.org>
References: <1610704825-17724-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <1d311c25-9051-ddcd-e7e1-5adbb8a913f9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1d311c25-9051-ddcd-e7e1-5adbb8a913f9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
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

T24gTW9uLCBKYW4gMTgsIDIwMjEgYXQgMTA6NTc6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzEvMTUg5LiL5Y2INjowMCwgSmlhcGVuZyBaaG9uZyB3cm90ZToKPiA+
IEZpeCB0aGUgZm9sbG93aW5nIGNvY2NpY2hlY2sgd2FybmluZ3M6Cj4gPiAKPiA+IC4vZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYzoxNjM3OjEtMjk6IFdBUk5JTkc6IEFzc2lnbm1lbnQgb2YK
PiA+IDAvMSB0byBib29sIHZhcmlhYmxlLgo+ID4gCj4gPiAuL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmM6MTYzNjoxLTMwOiBXQVJOSU5HOiBBc3NpZ25tZW50IG9mCj4gPiAwLzEgdG8gYm9v
bCB2YXJpYWJsZS4KPiA+IAo+ID4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51
eC5hbGliYWJhLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEppYXBlbmcgWmhvbmcgPGFiYWNpLWJ1
Z2ZpeEBsaW51eC5hbGliYWJhLmNvbT4KPiAKPiAKPiBJdCBsb29rcyB0byBtZSBpdCdzIG5vdCB0
aGUgb25seSBwbGFjZXM6Cj4gCj4gZ2l0IGdyZXAgYXZhaWxfd3JhcF9jb3VudGVyCj4gZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYm9vbCBhdmFpbF93cmFwX2NvdW50ZXI7Cj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YzogdnEtPnBhY2tlZC5hdmFpbF93cmFwX2NvdW50ZXIgXj0gMTsKPiBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jOiB2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRlciBePSAxOwo+IGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6wqDCoCBpZiAod3JhcF9jb3VudGVyICE9Cj4gdnEtPnBh
Y2tlZC5hdmFpbF93cmFwX2NvdW50ZXIpCj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzrC
oMKgIHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyID0gMTsKPiAKPiBUaGFua3MKCgpBZ3Jl
ZWQgaWYgd2UgYXJlIGRvaW5nIHRoaXMgbGV0J3MgY2hhbmdlIHRoZW0gYWxsLgoKPiAKPiA+IC0t
LQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNCArKy0tCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ID4gaW5kZXggNzFlMTZiNS4uNWFkYjM2MSAxMDA2NDQKPiA+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+IEBAIC0xNjMzLDggKzE2MzMsOCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1
ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gPiAgIAl2cS0+cGFja2VkLnZyaW5n
LmRldmljZSA9IGRldmljZTsKPiA+ICAgCXZxLT5wYWNrZWQubmV4dF9hdmFpbF9pZHggPSAwOwo+
ID4gLQl2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRlciA9IDE7Cj4gPiAtCXZxLT5wYWNrZWQu
dXNlZF93cmFwX2NvdW50ZXIgPSAxOwo+ID4gKwl2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRl
ciA9IHRydWU7Cj4gPiArCXZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIgPSB0cnVlOwo+ID4g
ICAJdnEtPnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cgPSAwOwo+ID4gICAJdnEtPnBhY2tlZC5h
dmFpbF91c2VkX2ZsYWdzID0gMSA8PCBWUklOR19QQUNLRURfREVTQ19GX0FWQUlMOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
