Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B297C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 13:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FB9F8143F;
	Wed,  2 Mar 2022 13:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qVY76Exs5Zu8; Wed,  2 Mar 2022 13:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34EA681430;
	Wed,  2 Mar 2022 13:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED0A5C0082;
	Wed,  2 Mar 2022 13:56:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56EAAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4498B4048A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gWAcMva_a2D2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:56:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB34D40184
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:56:39 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id i8so2921220wrr.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=W8D01UtJzG2MACA/9shiZ9rVVg2i2NMp5ocse6f4EOY=;
 b=DSob74kIJdRyA0VbXhRgyMD02C0hMXBzKN/Fhe1vuNvwexgeHsxu1/6cQhFmdIekKj
 NXZ6PvMUfl7oWv0bzCPKv+fo6fihSNCPXKIA76Z5C43Gpb7i2d3ecW8dLwk7pz2rln31
 +wKtzYYIl/l5TqmkbNZ7CeOCoFYnbZV7qC2rDjZ3FWiRcWsVNeJH+THOnH7Ld4gWlSbX
 n3dhyr7AckXvsUx3I5YwQhvskLgWfc8f39bKKB8mufkykzlyGGSAKtPmsQaMn7OldVcv
 zPHVqUGG7osZzohrjoPERFRQTbXak8QgdGKXGl0wo03Oe7LhcET/FBK7t8dI7VKRWsIa
 +DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=W8D01UtJzG2MACA/9shiZ9rVVg2i2NMp5ocse6f4EOY=;
 b=y7WvEvz9y0E4eRviyg605cRs4dVcGXrjGG4Wl751GyBFwQ/b5K584Z6F1uOSIpL4LB
 5M6iy619PFf0XWf1hyjjrAiw60+QhiMFELxzOUIq9psepQmRNxLXE2cGZAAGwKaY4Vgt
 26lcH2seVtZvAYf0keftU2t/Hs3caaoe5sHUT/4gZpFtRkKYKrOHS34X7YsWOcu5jeOf
 Bk4sg2SGfCJSuZ6xEXLlJHd56CtRMVXgAE+timekazv3K4v3zJiLwP6C2V2xOrkH64iN
 pU5MUaBka6SoG6B0OUr9fK1HRQCmp5RdFP0KHPGlzTTDtUDtzuj4bOOnSGModrmE+aps
 Besg==
X-Gm-Message-State: AOAM530A3wIw18HSQIFirJZXFCyILqNvOdI5tnAIJlzGp5NTC4weiu8W
 +wyfmwdhWC2r9lxEQ9aIVw0ZfA==
X-Google-Smtp-Source: ABdhPJxvTB4fYUTHq6Q8F0qC+lDtXJO6IvJq9fq5nJHg1+J4qLgqtVZgkoL1Is298lR5PX1g1c4yUQ==
X-Received: by 2002:adf:a109:0:b0:1ed:c2bd:8a57 with SMTP id
 o9-20020adfa109000000b001edc2bd8a57mr22607510wro.612.1646229397976; 
 Wed, 02 Mar 2022 05:56:37 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 t15-20020adfe44f000000b001edbea974cesm16473010wrm.53.2022.03.02.05.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 05:56:37 -0800 (PST)
Date: Wed, 2 Mar 2022 13:56:35 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yh93k2ZKJBIYQJjp@google.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302082021-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220302082021-mutt-send-email-mst@kernel.org>
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
IE1hciAwMiwgMjAyMiBhdCAwNzo1NDoyMUFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiB2
aG9zdF92c29ja19oYW5kbGVfdHhfa2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmlu
ZyBpdHMgY2FsbAo+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3ZSBoYXZlIHRvIGRv
IGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQg
d2UgbWl0aWdhdGUgdGhlIHJlcG9ydGVkIGlzc3Vlcy4KPiA+IAo+ID4gTGluazogaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTI3OTQzMmQzMGQ4MjVlNjNiYTAwCj4gPiAK
PiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3Qr
YWRjM2NiMzIzODU1ODZiZWM4NTlAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gU2lnbmVk
LW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiA+IC0tLQo+ID4gIGRy
aXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDIgKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2
ZXJzL3Zob3N0L3Zob3N0LmMKPiA+IGluZGV4IDU5ZWRiNWExZmZlMjguLmJiYWZmNmE1ZTIxYjgg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ICsrKyBiL2RyaXZlcnMv
dmhvc3Qvdmhvc3QuYwo+ID4gQEAgLTY5Myw2ICs2OTMsNyBAQCB2b2lkIHZob3N0X2Rldl9jbGVh
bnVwKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+ICAJaW50IGk7Cj4gPiAgCj4gPiAgCWZvciAo
aSA9IDA7IGkgPCBkZXYtPm52cXM7ICsraSkgewo+ID4gKwkJbXV0ZXhfbG9jaygmZGV2LT52cXNb
aV0tPm11dGV4KTsKPiA+ICAJCWlmIChkZXYtPnZxc1tpXS0+ZXJyb3JfY3R4KQo+ID4gIAkJCWV2
ZW50ZmRfY3R4X3B1dChkZXYtPnZxc1tpXS0+ZXJyb3JfY3R4KTsKPiA+ICAJCWlmIChkZXYtPnZx
c1tpXS0+a2ljaykKPiA+IEBAIC03MDAsNiArNzAxLDcgQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51
cChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPiAgCQlpZiAoZGV2LT52cXNbaV0tPmNhbGxfY3R4
LmN0eCkKPiA+ICAJCQlldmVudGZkX2N0eF9wdXQoZGV2LT52cXNbaV0tPmNhbGxfY3R4LmN0eCk7
Cj4gPiAgCQl2aG9zdF92cV9yZXNldChkZXYsIGRldi0+dnFzW2ldKTsKPiA+ICsJCW11dGV4X3Vu
bG9jaygmZGV2LT52cXNbaV0tPm11dGV4KTsKPiA+ICAJfQo+IAo+IFNvIHRoaXMgaXMgYSBtaXRp
Z2F0aW9uIHBsYW4gYnV0IHRoZSBidWcgaXMgc3RpbGwgdGhlcmUgdGhvdWdoCj4gd2UgZG9uJ3Qg
a25vdyBleGFjdGx5IHdoYXQgaXQgaXMuICBJIHdvdWxkIHByZWZlciBhZGRpbmcgc29tZXRoaW5n
IGxpa2UKPiBXQVJOX09OKG11dGV4X2lzX2xvY2tlZCh2cXNbaV0tPm11dGV4KSBoZXJlIC0gZG9l
cyB0aGlzIG1ha2Ugc2Vuc2U/CgpBcyBhIHJld29yayB0byB0aGlzLCBvciBhcyBhIHN1YnNlcXVl
bnQgcGF0Y2g/CgpKdXN0IGJlZm9yZSB0aGUgZmlyc3QgbG9jayBJIGFzc3VtZT8KCi0tIApMZWUg
Sm9uZXMgW+adjueQvOaWr10KUHJpbmNpcGFsIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNl
cnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpG
b2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
