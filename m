Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26053C433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 14:25:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8AF23124
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 14:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8AF23124
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3DFAF8614E;
	Tue, 22 Dec 2020 14:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V06FKDGh3Oot; Tue, 22 Dec 2020 14:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AED5681E4F;
	Tue, 22 Dec 2020 14:25:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 968EBC1825;
	Tue, 22 Dec 2020 14:25:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C49EDC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 14:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8BA212284F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 14:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6UPMVJe6YtH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 14:25:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by silver.osuosl.org (Postfix) with ESMTPS id C5CED2034F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 14:25:30 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id n26so18474238eju.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 06:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w0ZoW1YtNnNvY2+areMW2gfi6KMKObUc38gUPhTuopQ=;
 b=f+FnVZOBPLtOTEXet8hkD/XtcWq4kPOPWi9OBffjf+DJ1F47c9ynXidjBvNV2Q/cfh
 Kwje3xDXmlwnibGTNuyx8wCVSyaIEU/jzI69kga59ByaqtcDd7pNKym44ICggoE2L8A7
 BjWJj0PLZoELkv2/VTeznojSHc78xZGGxzy5rygLlyhCV8pIzf/UjmJg1k89P+HWFzFY
 seUZ/yaMmzsNFMao4CCbvqpMGfQjyC2Q75u0fQ7RUT9tVk5I+Xad6q0jv0HfJ7vt8BPY
 7rKOxNX7609a+UIVxNocXzWP13r4nhLRtjU8i5MFKYlOcCXm6udTn+zT89xFizG4Xwtf
 HAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w0ZoW1YtNnNvY2+areMW2gfi6KMKObUc38gUPhTuopQ=;
 b=EiDFIPbwPbnjNqpcT6d1CGjTF7a9W2SEOuG/aBTAlbrNlPc0rZT/8yFwWtVZ3BFhtq
 I+OtImrYVlqD1IMaCjNPQzQvhXAtkWv+SXiZHRRqcMZ7kfyCm3/pPVaA9V3VDKj2SZwU
 tuloeKhHcejI/e2qSfRhtiAnHNVmolzktD9i8r4VIytm0QuYmbELkVXHH0soj5upuFgf
 tsSMDap11709PvkE1dVG4vKYXBqkHhdESC+QqaVBZMJsUAkUsOQ6Nuho0RMxPNVuEtft
 w2yNGI69j88qNOW0XTIGBV3m4E6IxFu7E9pmZRBW05PrMUdal1wxU5bnWG8+hE1pBmW7
 JSOA==
X-Gm-Message-State: AOAM532suTY0X65ixD0RUPxXRNsoHmmvQ+zkEIIFzynnY5Pj16TWYrvb
 ti9h4+7v2YYnjw85B5uK7pT2Iw9F7X3WVpRm/mA=
X-Google-Smtp-Source: ABdhPJxzwTJ6k3Z63MMFK8Crq80JHefJXNDH11QJGkVz82rtNyFtQcidVrk6WPbfnx0XZXXJ8RLBzRd/nthPLuCQoIs=
X-Received: by 2002:a17:906:aeda:: with SMTP id
 me26mr19812860ejb.11.1608647129124; 
 Tue, 22 Dec 2020 06:25:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
 <CAF=yD-K6EM3zfZtEh=305P4Z6ehO6TzfQC4cxp5+gHYrxEtXSg@mail.gmail.com>
 <acebdc23-7627-e170-cdfb-b7656c05e5c5@redhat.com>
In-Reply-To: <acebdc23-7627-e170-cdfb-b7656c05e5c5@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 22 Dec 2020 09:24:53 -0500
Message-ID: <CAF=yD-KCs5x1oX-02aDM=5JyLP=BaA7_Jg7Wxt3=JmK8JBnyiA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] vhost_net: fix high cpu load when sendmsg fails
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 wangyunjian <wangyunjian@huawei.com>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

T24gTW9uLCBEZWMgMjEsIDIwMjAgYXQgMTE6NDEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IE9uIDIwMjAvMTIvMjIg5LiK5Y2INzowNywgV2lsbGVtIGRl
IEJydWlqbiB3cm90ZToKPiA+IE9uIFdlZCwgRGVjIDE2LCAyMDIwIGF0IDM6MjAgQU0gd2FuZ3l1
bmppYW48d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4gIHdyb3RlOgo+ID4+IEZyb206IFl1bmppYW4g
V2FuZzx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+ID4+Cj4gPj4gQ3VycmVudGx5IHdlIGJyZWFr
IHRoZSBsb29wIGFuZCB3YWtlIHVwIHRoZSB2aG9zdF93b3JrZXIgd2hlbgo+ID4+IHNlbmRtc2cg
ZmFpbHMuIFdoZW4gdGhlIHdvcmtlciB3YWtlcyB1cCBhZ2Fpbiwgd2UnbGwgbWVldCB0aGUKPiA+
PiBzYW1lIGVycm9yLgo+ID4gVGhlIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRo
YXQgc3VjaCBlcnJvciBjYXNlcyBhbHdheXMKPiA+IHJldHVybiBFQUdBSU4uIENhbiBpdCBub3Qg
YWxzbyBiZSBFTk9NRU0sIHN1Y2ggYXMgZnJvbSB0dW5fYnVpbGRfc2tiPwo+ID4KPiA+PiBUaGlz
IHdpbGwgY2F1c2UgaGlnaCBDUFUgbG9hZC4gVG8gZml4IHRoaXMgaXNzdWUsCj4gPj4gd2UgY2Fu
IHNraXAgdGhpcyBkZXNjcmlwdGlvbiBieSBpZ25vcmluZyB0aGUgZXJyb3IuIFdoZW4gd2UKPiA+
PiBleGNlZWRzIHNuZGJ1ZiwgdGhlIHJldHVybiB2YWx1ZSBvZiBzZW5kbXNnIGlzIC1FQUdBSU4u
IEluCj4gPj4gdGhlIGNhc2Ugd2UgZG9uJ3Qgc2tpcCB0aGUgZGVzY3JpcHRpb24gYW5kIGRvbid0
IGRyb3AgcGFja2V0Lgo+ID4gdGhlIC0+IHRoYXQKPiA+Cj4gPiBoZXJlIGFuZCBhYm92ZTogZGVz
Y3JpcHRpb24gLT4gZGVzY3JpcHRvcgo+ID4KPiA+IFBlcmhhcHMgc2xpZ2h0bHkgcmV2aXNlIHRv
IG1vcmUgZXhwbGljaXRseSBzdGF0ZSB0aGF0Cj4gPgo+ID4gMS4gaW4gdGhlIGNhc2Ugb2YgcGVy
c2lzdGVudCBmYWlsdXJlIChpLmUuLCBiYWQgcGFja2V0KSwgdGhlIGRyaXZlcgo+ID4gZHJvcHMg
dGhlIHBhY2tldAo+ID4gMi4gaW4gdGhlIGNhc2Ugb2YgdHJhbnNpZW50IGZhaWx1cmUgKGUuZywu
IG1lbW9yeSBwcmVzc3VyZSkgdGhlIGRyaXZlcgo+ID4gc2NoZWR1bGVzIHRoZSB3b3JrZXIgdG8g
dHJ5IGFnYWluIGxhdGVyCj4KPgo+IElmIHdlIHdhbnQgdG8gZ28gd2l0aCB0aGlzIHdheSwgd2Ug
bmVlZCBhIGJldHRlciB0aW1lIHRvIHdha2V1cCB0aGUKPiB3b3JrZXIuIE90aGVyd2lzZSBpdCBq
dXN0IHByb2R1Y2VzIG1vcmUgc3RyZXNzIG9uIHRoZSBjcHUgdGhhdCBpcyB3aGF0Cj4gdGhpcyBw
YXRjaCB0cmllcyB0byBhdm9pZC4KClBlcmhhcHMgSSBtaXN1bmRlcnN0b29kIHRoZSBwdXJwb3Nl
IG9mIHRoZSBwYXRjaDogaXMgaXQgdG8gZHJvcApldmVyeXRoaW5nLCByZWdhcmRsZXNzIG9mIHRy
YW5zaWVudCBvciBwZXJzaXN0ZW50IGZhaWx1cmUsIHVudGlsIHRoZQpyaW5nIHJ1bnMgb3V0IG9m
IGRlc2NyaXB0b3JzPwoKSSBjYW4gdW5kZXJzdGFuZCBib3RoIGEgYmxvY2tpbmcgYW5kIGRyb3Ag
c3RyYXRlZ3kgZHVyaW5nIG1lbW9yeQpwcmVzc3VyZS4gQnV0IHBhcnRpYWwgZHJvcCBzdHJhdGVn
eSB1bnRpbCBleGNlZWRpbmcgcmluZyBjYXBhY2l0eQpzZWVtcyBsaWtlIGEgcGVjdWxpYXIgaHli
cmlkPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
