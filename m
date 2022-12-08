Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FCBC00145
	for <virtualization@archiver.kernel.org>; Thu,  8 Dec 2022 16:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64BE841944;
	Thu,  8 Dec 2022 16:48:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64BE841944
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1NsVi2LP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2lngO_pggXXn; Thu,  8 Dec 2022 16:48:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8DCD41946;
	Thu,  8 Dec 2022 16:48:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8DCD41946
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7292EC0033;
	Thu,  8 Dec 2022 16:48:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE3CCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 16:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6064820BC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 16:48:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6064820BC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=1NsVi2LP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQYyzZ049_X6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 16:48:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B25BE81F38
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B25BE81F38
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 16:48:26 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id d14so1301719ilq.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Dec 2022 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtTytaGK8EscfaX5sQg3WzTsPcFXdf66H/Qr7gq+ZeU=;
 b=1NsVi2LPvryDN0YAtJX6LCnADQ5OzXCjCNF5Oupz+xOmf6Z5HVHcfdWy5625BkIexO
 UPLI6mwR3tRA0ncoREpcYqAmWRjcQO++s0NBr4mWPc8q07+1woGt+JkoS1J4koa/m34i
 0uqh9nyJx6KJSXY6iDolAOLSwXgGMoCDTblFvkDBS2H21bc+5TZR9++P+qymHP87IdDt
 i7mJQ0460G0eqY73I96vwKFYE/SxEdk0GsPXjmjpWsjHfHrlC7okE6rvKSRH8b11sXFc
 xVlDw3S4/ZN0X0BptZoILKvSU0kOzZILD05dplubtfBlkbI340vbh9dQoUMNPKAYX6Eb
 z4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtTytaGK8EscfaX5sQg3WzTsPcFXdf66H/Qr7gq+ZeU=;
 b=lWU1eVDZ0TPVRMU6YaxKu8GpjyQ8fubdBN6b8jlNxqEXJrOmaO8IOEmojgaywzqqJy
 TxGrRspEGuitev32qgtcGc3uX4FlRgmOd0L5IyBVAZZkHihgd2rDZeIwWmClcUVdgbgs
 tzxSUKHNyz7iskkllC1Sb2d0EUP0VjQkxYK25GgscVsyMUGkxczuIimn0wEoPH+7IbQt
 skO2xKKc9kDWCPHBUSDVBtwQUXw4xgk1C+H2keXt/oZpg1BPrKdcbx6LnaNKNTovLyc7
 C3SjqJ62ywImoeuVap4WToJs0T2aD9XAihZpGmcqpjxx75gWZTlYjen6K3LL6ik+Szzv
 dbXA==
X-Gm-Message-State: ANoB5pmasNBatJJ7pqCduevu0odo5PqYrAHfBoCccfZQ8PEZLIkPkPnm
 oUgRwzrqtXvD973XgFbotan2Dw==
X-Google-Smtp-Source: AA0mqf4Zzqp5ZuBvsh/zTJ1XExTv5sm3H2YTh8G90igsKIvVAiQzO0XoCxhbm7fpoFjKEzpIO4+lgQ==
X-Received: by 2002:a6b:8f84:0:b0:6e0:2427:f72e with SMTP id
 r126-20020a6b8f84000000b006e02427f72emr5170180iod.55.1670518105458; 
 Thu, 08 Dec 2022 08:48:25 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a056638110b00b00389d74d7e24sm8752485jal.146.2022.12.08.08.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 08:48:25 -0800 (PST)
Message-ID: <4701aded-0464-791e-8b8c-a34c422e8e62@kernel.dk>
Date: Thu, 8 Dec 2022 09:48:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after
 polling I/O is finished
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
 <Y5EJ+6qtsy8Twe/q@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5EJ+6qtsy8Twe/q@fedora>
Cc: linux-block@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 pbonzini@redhat.com, Suwan Kim <suwan.kim027@gmail.com>
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

T24gMTIvNy8yMiAyOjQ34oCvUE0sIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToKPiBPbiBUdWUsIERl
YyAwNiwgMjAyMiBhdCAxMToxMToyNFBNICswOTAwLCBTdXdhbiBLaW0gd3JvdGU6Cj4+IERyaXZl
ciBzaG91bGQgc2V0IHJlcS0+c3RhdGUgdG8gTVFfUlFfQ09NUExFVEUgYWZ0ZXIgaXQgZmluaXNo
ZXMgdG8gcHJvY2Vzcwo+PiByZXEuIEJ1dCB2aXJ0aW8tYmxrIGRvZXNuJ3Qgc2V0IE1RX1JRX0NP
TVBMRVRFIGFmdGVyIHZpcnRibGtfcG9sbCgpIGhhbmRsZXMKPj4gcmVxIGFuZCByZXEtPnN0YXRl
IHN0aWxsIHJlbWFpbnMgTVFfUlFfSU5fRkxJR0hULiBGb3J0dW5hdGVseSBzbyBmYXIgdGhlcmUK
Pj4gaXMgbm8gaXNzdWUgYWJvdXQgaXQgYmVjYXVzZSBibGtfbXFfZW5kX3JlcXVlc3RfYmF0Y2go
KSBzZXRzIHJlcS0+c3RhdGUgdG8KPj4gTVFfUlFfSURMRS4gVGhpcyBwYXRjaCBwcm9wZXJseSBz
ZXRzIHJlcS0+c3RhdGUgYWZ0ZXIgcG9sbGluZyBJL08gaXMgZmluaXNoZWQuCj4+Cj4+IEZpeGVz
OiA0ZTA0MDA1MjU2OTEgKCJ2aXJ0aW8tYmxrOiBzdXBwb3J0IHBvbGxpbmcgSS9PIikKPj4gU2ln
bmVkLW9mZi1ieTogU3V3YW4gS2ltIDxzdXdhbi5raW0wMjdAZ21haWwuY29tPgo+PiAtLS0KPj4g
IGRyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIHwgMSArCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5j
IGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPj4gaW5kZXggMTlkYTVkZWZkNzM0Li5jZjY0
ZDI1Njc4N2UgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4+ICsr
KyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4+IEBAIC04MzksNiArODM5LDcgQEAgc3Rh
dGljIHZvaWQgdmlydGJsa19jb21wbGV0ZV9iYXRjaChzdHJ1Y3QgaW9fY29tcF9iYXRjaCAqaW9i
KQo+PiAgCXJxX2xpc3RfZm9yX2VhY2goJmlvYi0+cmVxX2xpc3QsIHJlcSkgewo+PiAgCQl2aXJ0
YmxrX3VubWFwX2RhdGEocmVxLCBibGtfbXFfcnFfdG9fcGR1KHJlcSkpOwo+PiAgCQl2aXJ0Ymxr
X2NsZWFudXBfY21kKHJlcSk7Cj4+ICsJCWJsa19tcV9zZXRfcmVxdWVzdF9jb21wbGV0ZShyZXEp
Owo+PiAgCX0KPj4gIAlibGtfbXFfZW5kX3JlcXVlc3RfYmF0Y2goaW9iKTsKPj4gIH0KPiAKPiBU
aGUgZG9jIGNvbW1lbnQgZm9yIGJsa19tcV9zZXRfcmVxdWVzdF9jb21wbGV0ZSgpIG1lbnRpb25z
IHRoaXMgYmVpbmcKPiB1c2VkIGluIC0+cXVldWVfcnEoKSwgYnV0IHRoYXQncyBub3QgdGhlIGNh
c2UgaGVyZS4gRG9lcyB0aGUgZG9jIGNvbW1lbnQKPiBuZWVkIHRvIGJlIHVwZGF0ZWQgaWYgd2Un
cmUgdXNpbmcgdGhlIGZ1bmN0aW9uIGluIGEgZGlmZmVyZW50IHdheT8KCkxvb2tzIGxpa2UgaXQn
cyBhIGJpdCBvdXRkYXRlZC4uLgoKPiBJJ20gbm90IGZhbWlsaWFyIGVub3VnaCB3aXRoIHRoZSBM
aW51eCBibG9jayBBUElzLCBidXQgdGhpcyBmZWVscyB3ZWlyZAo+IHRvIG1lLiBTaG91bGRuJ3Qg
YmxrX21xX2VuZF9yZXF1ZXN0X2JhdGNoKGlvYikgdGFrZSBjYXJlIG9mIHRoaXMgZm9yIHVzPwo+
IFdoeSBkb2VzIGl0IHNldCB0aGUgc3RhdGUgdG8gSURMRSBpbnN0ZWFkIG9mIENPTVBMRVRFPwo+
IAo+IEkgdGhpbmsgSmVucyBjYW4gY29uZmlybSB3aGV0aGVyIHdlIHJlYWxseSB3YW50IGFsbCBk
cml2ZXJzIHRoYXQgdXNlCj4gcG9sbGluZyBhbmQgaW9fY29tcF9iYXRjaCB0byBtYW51YWxseSBj
YWxsCj4gYmxrX21xX3NldF9yZXF1ZXN0X2NvbXBsZXRlKCkuCgpTaG91bGQgbm90IGJlIGEgbmVl
ZCB0byBjYWxsIGJsa19tcV9zZXRfcmVxdWVzdF9jb21wbGV0ZSgpIGRpcmVjdGx5IGluCnRoZSBk
cml2ZXIgZm9yIHRoaXMuCgotLSAKSmVucyBBeGJvZQoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
