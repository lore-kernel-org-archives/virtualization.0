Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D40C433FE
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 07:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E164A40B52;
	Thu, 27 Jan 2022 07:47:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hjTWsic44IK; Thu, 27 Jan 2022 07:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46BB940B41;
	Thu, 27 Jan 2022 07:47:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C054C001A;
	Thu, 27 Jan 2022 07:47:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86208C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 07:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8155540B52
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 07:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jlb055IMIGKk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 07:47:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A7DB40B41
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 07:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643269666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkdPq4yx3Zwg5TsWMNJ53xqznx4G+wL2Z4oOgHdThh4=;
 b=PISJsT6YXN2SVQafay7k7/wwTiOuudoxOnV9p/erCEsJ4vqghq28KiTx3bWr3b3bI0gjOZ
 yKZyMgPMWIBUPt3pueN31G+So+ceRP4f3qnkCWgw6R88htSMGt1gdi55OohlfiW+bo3Ge5
 SKXNtiQ4zl4wZJ1joWAP64NCfRicB4A=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-Z3HC-6hKNxaHw0qmUFOfTQ-1; Thu, 27 Jan 2022 02:47:45 -0500
X-MC-Unique: Z3HC-6hKNxaHw0qmUFOfTQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 ik14-20020a170902ab0e00b0014c84153eb0so602912plb.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 23:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xkdPq4yx3Zwg5TsWMNJ53xqznx4G+wL2Z4oOgHdThh4=;
 b=GtTwEk5XQouyjiMZonpN5GPZ9cYwVSpFRSRtLVy9UmDvqdlV+XBLOSDzSo2CbGsw6e
 9fW1bKzic7v/3/S7QD9uJSFkHkGsALL5dxnyF5C9Q3moatbkEz3qUyqbd6h6pp6C4h5i
 bCHNSEajvkhUPX2+YyIcVLF8GlMXVCUL5kpvvikEExnrG13FYERAN0sAvfUNI3pIJCjh
 YfQf/74TweCIadRnRFjq1JBkuPWt7Y8qjboq+k1a+S0zAwe674S/krpISZv2PXXGjLTI
 OWfndP18fGW0QNKPa0tctu0TUS15P+ze8oPYXU9bAoZrvAKByBOY8cSgta/JuTXtvkMs
 iFrQ==
X-Gm-Message-State: AOAM532y7XNLsaVVXnHRYId/1f8lXX2X82qHHuvwIaFUuL3olVq9yEg4
 axky9p/Sa40o2syUXJN1HeFnqWYkm+kyHJbMPAL4GnFW0ETagpLeVMHE8fyO775vGi7R6mbbFIm
 LKaJYp9vScEtAOf/VeGemABttNuYT6vvSRkeH65teAQ==
X-Received: by 2002:a63:7d0b:: with SMTP id y11mr1940255pgc.402.1643269664470; 
 Wed, 26 Jan 2022 23:47:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhkb6CFMMrOoWSQ7BaMpDPFHK9eL1ryoIoea8/zX+wWjUvBqsI5uIZGY8tiftBLWLZZexr9w==
X-Received: by 2002:a63:7d0b:: with SMTP id y11mr1940238pgc.402.1643269664195; 
 Wed, 26 Jan 2022 23:47:44 -0800 (PST)
Received: from [10.72.13.149] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 25sm5282463pje.22.2022.01.26.23.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jan 2022 23:47:43 -0800 (PST)
Message-ID: <acef3625-566b-6438-61a8-49d4363a148a@redhat.com>
Date: Thu, 27 Jan 2022 15:47:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] drivers/net/virtio_net: Fixed padded vheader to
 use v1 with hash.
To: Andrew Melnychenko <andrew@daynix.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, mst@redhat.com
References: <20220117080009.3055012-1-andrew@daynix.com>
 <20220117080009.3055012-2-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220117080009.3055012-2-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvMTcg5LiL5Y2INDowMCwgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBU
aGUgaGVhZGVyIHYxIHByb3ZpZGVzIGFkZGl0aW9uYWwgaW5mbyBhYm91dCBSU1MuCj4gQWRkZWQg
Y2hhbmdlcyB0byBjb21wdXRpbmcgcHJvcGVyIGhlYWRlciBsZW5ndGguCj4gSW4gdGhlIG5leHQg
cGF0Y2hlcywgdGhlIGhlYWRlciBtYXkgY29udGFpbiBSU1MgaGFzaCBpbmZvCj4gZm9yIHRoZSBo
YXNoIHBvcHVsYXRpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTWVsbnljaGVua28gPGFu
ZHJld0BkYXluaXguY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA5ICsrKysrLS0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiBpbmRleCA1NjllZWNmYmMyY2QuLjA1ZmU1YmEzMjE4NyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiBAQCAtMjQyLDEzICsyNDIsMTMgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gICB9Owo+ICAg
Cj4gICBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAtCXN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9t
cmdfcnhidWYgaGRyOwo+ICsJc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hhc2ggaGRyOwo+ICAg
CS8qCj4gICAJICogaGRyIGlzIGluIGEgc2VwYXJhdGUgc2cgYnVmZmVyLCBhbmQgZGF0YSBzZyBi
dWZmZXIgc2hhcmVzIHNhbWUgcGFnZQo+ICAgCSAqIHdpdGggdGhpcyBoZWFkZXIgc2cuIFRoaXMg
cGFkZGluZyBtYWtlcyBuZXh0IHNnIDE2IGJ5dGUgYWxpZ25lZAo+ICAgCSAqIGFmdGVyIHRoZSBo
ZWFkZXIuCj4gICAJICovCj4gLQljaGFyIHBhZGRpbmdbNF07Cj4gKwljaGFyIHBhZGRpbmdbMTJd
Owo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiBA
QCAtMTI2Niw3ICsxMjY2LDggQEAgc3RhdGljIHVuc2lnbmVkIGludCBnZXRfbWVyZ2VhYmxlX2J1
Zl9sZW4oc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLAo+ICAgCQkJCQkgIHN0cnVjdCBld21hX3Br
dF9sZW4gKmF2Z19wa3RfbGVuLAo+ICAgCQkJCQkgIHVuc2lnbmVkIGludCByb29tKQo+ICAgewo+
IC0JY29uc3Qgc2l6ZV90IGhkcl9sZW4gPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfaGRyX21y
Z19yeGJ1Zik7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IHJxLT52cS0+dmRldi0+cHJp
djsKPiArCWNvbnN0IHNpemVfdCBoZHJfbGVuID0gdmktPmhkcl9sZW47Cj4gICAJdW5zaWduZWQg
aW50IGxlbjsKPiAgIAo+ICAgCWlmIChyb29tKQo+IEBAIC0yODUxLDcgKzI4NTIsNyBAQCBzdGF0
aWMgdm9pZCB2aXJ0bmV0X2RlbF92cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICAgKi8K
PiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgbWVyZ2VhYmxlX21pbl9idWZfbGVuKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiAgIHsKPiAtCWNvbnN0IHVuc2ln
bmVkIGludCBoZHJfbGVuID0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYp
Owo+ICsJY29uc3QgdW5zaWduZWQgaW50IGhkcl9sZW4gPSB2aS0+aGRyX2xlbjsKPiAgIAl1bnNp
Z25lZCBpbnQgcnFfc2l6ZSA9IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2cSk7Cj4gICAJdW5z
aWduZWQgaW50IHBhY2tldF9sZW4gPSB2aS0+YmlnX3BhY2tldHMgPyBJUF9NQVhfTVRVIDogdmkt
PmRldi0+bWF4X210dTsKPiAgIAl1bnNpZ25lZCBpbnQgYnVmX2xlbiA9IGhkcl9sZW4gKyBFVEhf
SExFTiArIFZMQU5fSExFTiArIHBhY2tldF9sZW47CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
