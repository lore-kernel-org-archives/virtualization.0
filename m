Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C91C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 14:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E27A360F00;
	Wed,  2 Mar 2022 14:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lcvUKY5ICWtj; Wed,  2 Mar 2022 14:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A5E060EFD;
	Wed,  2 Mar 2022 14:57:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13082C0012;
	Wed,  2 Mar 2022 14:57:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5419C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B53C74035D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gTWTjI0yla2q
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:57:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A69C402F9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:57:33 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id 19so1028897wmy.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=wGGyr8F/4yesRnDkleDkSeBi9/XbD7YGJTcIBLykmxo=;
 b=YAWW5HKlB7Eey/hbn/tEyKoY+Ej9P8bjmKwFJpG4WIH2K/pus2hP+RvzIjDv6V3z5p
 k6x5v3LHFzzK0yNYVc3/6rqsj7QQzSFP9PqTvboq8Gd2h2U5akBPL3gjR8Gis5rXW7a5
 f5Wj0QWjydNWVbiao3cyHkss6w5fRltrK3+kbwT6yAe/CdOFs42vPOp9Mksavp1FhfDg
 b+8kmdCZBXU7N1sbqbnIx9h7JeO+bMDEWXRboAhQXSO6FrQS9Y2kIONVMIQBVPZeWrO0
 GsIgMsxoTCsl6Mtqj6TTCwunX0DqqFgLwCazwzkBeT0HF1oYRmofMt0ZOyXz8dF5vh/a
 nxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wGGyr8F/4yesRnDkleDkSeBi9/XbD7YGJTcIBLykmxo=;
 b=Z0dQ2KuhOyK9UA0Y5kyTTHeP2U6rKlNCTO3VqAWk8UVsqtJCGqtFRNmNfuU//ttILd
 xww6QIWtoswL+R7pynzWh37r5+uydB1IIUVf1Gfh8HbVSmiG5KGRrdcvHkdhAbxTA2H2
 8y+1FItghCWNH5OjrLbC/yfEm+fLu6gABFxFNZlZEw5rMnMHgIdUo4NR4+Uw3J+LOW7x
 u2rRZq57XFaXf6Jg8Lf38A4o5SlLt0moGT9Z1xbBbdFpFx5yM8VVevxslzg9TqHck+gF
 sdVUVi0GcJIUPky7/JhPRcYvk+5DSvD9VRbmhugTili4crKHIC66Hngq4tBBPxu2kAk2
 vaMQ==
X-Gm-Message-State: AOAM530ok78pL49yenT0pBgefNAJCpinfInoHAXxcfny35onNUzaxp0y
 txZgPPO2xRrCqlJbYTd2of6VPQ==
X-Google-Smtp-Source: ABdhPJxDjgY35zlNFNM4bX0OTXrJd0JfiswPqCzf7heVkctOxPWyBqq7cmIrMgVAjnLfYiYdzW+RlQ==
X-Received: by 2002:a05:600c:40cf:b0:381:1f87:84c4 with SMTP id
 m15-20020a05600c40cf00b003811f8784c4mr102404wmh.181.1646233051757; 
 Wed, 02 Mar 2022 06:57:31 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 o204-20020a1ca5d5000000b0038331f2f951sm4751221wme.0.2022.03.02.06.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 06:57:31 -0800 (PST)
Date: Wed, 2 Mar 2022 14:57:26 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yh+F1gkCGoYF2lMV@google.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
 <Yh93k2ZKJBIYQJjp@google.com>
 <20220302095045-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220302095045-mutt-send-email-mst@kernel.org>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCAwMiBNYXIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBXZWQs
IE1hciAwMiwgMjAyMiBhdCAwMTo1NjozNVBNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBP
biBXZWQsIDAyIE1hciAyMDIyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiAKPiA+ID4g
T24gV2VkLCBNYXIgMDIsIDIwMjIgYXQgMDc6NTQ6MjFBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+ID4gPiA+IHZob3N0X3Zzb2NrX2hhbmRsZV90eF9raWNrKCkgYWxyZWFkeSBob2xkcyB0aGUg
bXV0ZXggZHVyaW5nIGl0cyBjYWxsCj4gPiA+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFs
bCB3ZSBoYXZlIHRvIGRvIGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gPiA+IGR1cmluZyB2aXJ0
cXVldWUgY2xlYW4tdXAgYW5kIHdlIG1pdGlnYXRlIHRoZSByZXBvcnRlZCBpc3N1ZXMuCj4gPiA+
ID4gCj4gPiA+ID4gTGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlk
PTI3OTQzMmQzMGQ4MjVlNjNiYTAwCj4gPiA+ID4gCj4gPiA+ID4gQ2M6IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPgo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3QrYWRjM2NiMzIzODU1ODZiZWM4
NTlAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMv
dmhvc3Qvdmhvc3QuYyB8IDIgKysKPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQo+ID4gPiA+IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMg
Yi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gPiBpbmRleCA1OWVkYjVhMWZmZTI4Li5iYmFm
ZjZhNWUyMWI4IDEwMDY0NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+IEBAIC02OTMsNiArNjkzLDcg
QEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPiA+ID4g
IAlpbnQgaTsKPiA+ID4gPiAgCj4gPiA+ID4gIAlmb3IgKGkgPSAwOyBpIDwgZGV2LT5udnFzOyAr
K2kpIHsKPiA+ID4gPiArCQltdXRleF9sb2NrKCZkZXYtPnZxc1tpXS0+bXV0ZXgpOwo+ID4gPiA+
ICAJCWlmIChkZXYtPnZxc1tpXS0+ZXJyb3JfY3R4KQo+ID4gPiA+ICAJCQlldmVudGZkX2N0eF9w
dXQoZGV2LT52cXNbaV0tPmVycm9yX2N0eCk7Cj4gPiA+ID4gIAkJaWYgKGRldi0+dnFzW2ldLT5r
aWNrKQo+ID4gPiA+IEBAIC03MDAsNiArNzAxLDcgQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChz
dHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPiA+ID4gIAkJaWYgKGRldi0+dnFzW2ldLT5jYWxsX2N0
eC5jdHgpCj4gPiA+ID4gIAkJCWV2ZW50ZmRfY3R4X3B1dChkZXYtPnZxc1tpXS0+Y2FsbF9jdHgu
Y3R4KTsKPiA+ID4gPiAgCQl2aG9zdF92cV9yZXNldChkZXYsIGRldi0+dnFzW2ldKTsKPiA+ID4g
PiArCQltdXRleF91bmxvY2soJmRldi0+dnFzW2ldLT5tdXRleCk7Cj4gPiA+ID4gIAl9Cj4gPiA+
IAo+ID4gPiBTbyB0aGlzIGlzIGEgbWl0aWdhdGlvbiBwbGFuIGJ1dCB0aGUgYnVnIGlzIHN0aWxs
IHRoZXJlIHRob3VnaAo+ID4gPiB3ZSBkb24ndCBrbm93IGV4YWN0bHkgd2hhdCBpdCBpcy4gIEkg
d291bGQgcHJlZmVyIGFkZGluZyBzb21ldGhpbmcgbGlrZQo+ID4gPiBXQVJOX09OKG11dGV4X2lz
X2xvY2tlZCh2cXNbaV0tPm11dGV4KSBoZXJlIC0gZG9lcyB0aGlzIG1ha2Ugc2Vuc2U/Cj4gPiAK
PiA+IEFzIGEgcmV3b3JrIHRvIHRoaXMsIG9yIGFzIGEgc3Vic2VxdWVudCBwYXRjaD8KPiAKPiBD
YW4gYmUgYSBzZXBhcmF0ZSBwYXRjaC4KPiAKPiA+IEp1c3QgYmVmb3JlIHRoZSBmaXJzdCBsb2Nr
IEkgYXNzdW1lPwo+IAo+IEkgZ3Vlc3Mgc28sIHllcy4KCk5vIHByb2JsZW0uICBQYXRjaCB0byBm
b2xsb3cuCgpJJ20gYWxzbyBnb2luZyB0byBhdHRlbXB0IHRvIGRlYnVnIHRoZSByb290IGNhdXNl
LCBidXQgSSdtIG5ldyB0byB0aGlzCnN1YnN5c3RlbSB0byBpdCBtaWdodCB0YWtlIGEgd2hpbGUg
Zm9yIG1lIHRvIGdldCBteSBoZWFkIGFyb3VuZC4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10K
UHJpbmNpcGFsIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg
4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNl
Ym9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
