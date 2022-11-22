Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65519C4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 11:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2CDF41679;
	Tue, 22 Nov 2022 11:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2CDF41679
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WnSu24ji
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FwCg8ff6rcW4; Tue, 22 Nov 2022 11:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 15B9541675;
	Tue, 22 Nov 2022 11:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15B9541675
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB7CEC0032;
	Tue, 22 Nov 2022 11:12:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0717FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 11:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFE8B81F3D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 11:12:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFE8B81F3D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WnSu24ji
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R0EwNtS-J-aO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 11:12:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9E5B81F57
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9E5B81F57
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669115567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HP9F+p2dxhYIWKllV/OXz0HrddctUZTEtcHm3XsSMgM=;
 b=WnSu24jifckS0zbOgVdcQuUU7F76bGoY/5b5pN4bIJZn79Onii5ussVAQcijE72WriINKi
 WVqekYXNrlbx6xnvKNVP5YvpqrH4niBBSTbSiaonixHo6dmeAO+xWWTt3sx7X+9yqd1u+O
 Tn89Y+B5ckPPmKQf8eZga55wfse/u5o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-mCS0WyJAMea8r94jVv7vHQ-1; Tue, 22 Nov 2022 06:12:46 -0500
X-MC-Unique: mCS0WyJAMea8r94jVv7vHQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 m34-20020a05600c3b2200b003cf549cb32bso10849424wms.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 03:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HP9F+p2dxhYIWKllV/OXz0HrddctUZTEtcHm3XsSMgM=;
 b=zzL9wjgnu+Jfc9pniEoEdZszwSjd7WAE2Zd/jsehTRBNk7zvifmXV8opz8s7GmaOHQ
 8Yst+qXU9aNVKUioUZabq0f1krpVzbn3unSS+3zPkJdC5X3tEyJSV3u8kM17gGn1q/ur
 tPFvjhslrepJ2HNTKMxH3YJEShUrIre0oe4xPywOnE+WZsx8IlmrnO8ICytcnL+iEPhI
 sH/u5n41YqEdqkcDjwgYzqbCwqX6PIu+Lc2ZAOm9fRQKU53XnYY/0BwYnPeXjvmSS+qF
 4EqhXuuFiyRkbOgjSGINExhp8WJWsbgGBy8g7sBbDy+5deisgrkWpXD+Y/sgDlcyVXBT
 0CjQ==
X-Gm-Message-State: ANoB5pmLjyx7rrNHc4V2IJ1H4E5uloV6pbIjiVjo0cpraOoo46ep4TbE
 FZdA90GAHWhQAGxK5FhVvT7mAd8CPzpV//2hnfq3d5+lr85AUbZsgWKjC0pjz8hM/rG5hMp1QhA
 2rf1NOcG5wpPEOLw/9ZZ4P/X4/Lhm25Xc4/XYny0hzw==
X-Received: by 2002:a5d:5611:0:b0:241:cfa5:20d9 with SMTP id
 l17-20020a5d5611000000b00241cfa520d9mr7264586wrv.451.1669115565192; 
 Tue, 22 Nov 2022 03:12:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4eHGBO4afRVPkSMaHqn1MkFLLySojli4V6rwYgdetBBdrXxXXecoWGsZzXevC5M5FqgjMGiA==
X-Received: by 2002:a5d:5611:0:b0:241:cfa5:20d9 with SMTP id
 l17-20020a5d5611000000b00241cfa520d9mr7264571wrv.451.1669115564924; 
 Tue, 22 Nov 2022 03:12:44 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-176-72.web.vodafone.de.
 [109.43.176.72]) by smtp.gmail.com with ESMTPSA id
 x2-20020a1c7c02000000b003b4935f04a4sm19134166wmc.5.2022.11.22.03.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Nov 2022 03:12:44 -0800 (PST)
Message-ID: <81612d82-7fc1-e2be-38a2-0db8314248cc@redhat.com>
Date: Tue, 22 Nov 2022 12:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Amit Shah <amit@kernel.org>
References: <20221114173811.1977367-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for virtual
 console numbers
In-Reply-To: <20221114173811.1977367-1-clg@kaod.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
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

T24gMTQvMTEvMjAyMiAxOC4zOCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6Cj4gV2hlbiBhIHZp
cnRpbyBjb25zb2xlIHBvcnQgaXMgaW5pdGlhbGl6ZWQsIGl0IGlzIHJlZ2lzdGVyZWQgYXMgYW4g
aHZjCj4gY29uc29sZSB1c2luZyBhIHZpcnR1YWwgY29uc29sZSBudW1iZXIuIElmIGEgS1ZNIGd1
ZXN0IGlzIHN0YXJ0ZWQgd2l0aAo+IG11bHRpcGxlIHZpcnRpbyBjb25zb2xlIGRldmljZXMsIHRo
ZSBzYW1lIHZ0ZXJtbm8gKG9yIHZpcnR1YWwgY29uc29sZQo+IG51bWJlcikgY2FuIGJlIHVzZWQg
dG8gYWxsb2NhdGUgZGlmZmVyZW50IGh2YyBjb25zb2xlcywgd2hpY2ggbGVhZHMgdG8KPiB2YXJp
b3VzIGNvbW11bmljYXRpb24gcHJvYmxlbXMgbGF0ZXIgb24uCj4gCj4gVGhpcyBpcyBhbHNvIHJl
cG9ydGVkIGluIGRlYnVnZnMgOgo+IAo+ICAgICMgZ3JlcCB2dGVybW5vIC9zeXMva2VybmVsL2Rl
YnVnL3ZpcnRpby1wb3J0cy8qCj4gICAgL3N5cy9rZXJuZWwvZGVidWcvdmlydGlvLXBvcnRzL3Zw
b3J0MXAxOmNvbnNvbGVfdnRlcm1ubzogMQo+ICAgIC9zeXMva2VybmVsL2RlYnVnL3ZpcnRpby1w
b3J0cy92cG9ydDJwMTpjb25zb2xlX3Z0ZXJtbm86IDEKPiAgICAvc3lzL2tlcm5lbC9kZWJ1Zy92
aXJ0aW8tcG9ydHMvdnBvcnQzcDE6Y29uc29sZV92dGVybW5vOiAyCj4gICAgL3N5cy9rZXJuZWwv
ZGVidWcvdmlydGlvLXBvcnRzL3Zwb3J0NHAxOmNvbnNvbGVfdnRlcm1ubzogMwo+IAo+IFJlcGxh
Y2UgdGhlIG5leHRfdnRlcm1ubyBnbG9iYWwgd2l0aCBhbiBJRCBhbGxvY2F0b3IgYW5kIHN0YXJ0
IHRoZQo+IGFsbG9jYXRpb24gYXQgMSBhcyBpdCBpcyB0b2RheS4gQWxzbyByZWN5Y2xlIElEcyB3
aGVuIGEgY29uc29sZSBwb3J0Cj4gaXMgcmVtb3ZlZC4KClNvdW5kcyBsaWtlIGEgZ29vZCBpZGVh
IQoKPiBAQCAtMTI0NCw4ICsxMjM2LDExIEBAIHN0YXRpYyBpbnQgaW5pdF9wb3J0X2NvbnNvbGUo
c3RydWN0IHBvcnQgKnBvcnQpCj4gICAJICogcG9pbnRlcnMuICBUaGUgZmluYWwgYXJndW1lbnQg
aXMgdGhlIG91dHB1dCBidWZmZXIgc2l6ZTogd2UKPiAgIAkgKiBjYW4gZG8gYW55IHNpemUsIHNv
IHdlIHB1dCBQQUdFX1NJWkUgaGVyZS4KPiAgIAkgKi8KPiAtCXBvcnQtPmNvbnMudnRlcm1ubyA9
IHBkcnZkYXRhLm5leHRfdnRlcm1ubzsKPiArCXJldCA9IGlkYV9hbGxvY19yYW5nZSgmdnRlcm1u
b19pZGEsIDEsIH4wLCBHRlBfS0VSTkVMKTsKCkp1c3QgY29zbWV0aWNzOiBJIHRoaW5rIHlvdSBj
b3VsZCB1c2UgaWRhX2FsbG9jX21pbigpIGluc3RlYWQuCgo+ICsJaWYgKHJldCA8IDApCj4gKwkJ
cmV0dXJuIHJldDsKPiAgIAo+ICsJcG9ydC0+Y29ucy52dGVybW5vID0gcmV0Owo+ICAgCXBvcnQt
PmNvbnMuaHZjID0gaHZjX2FsbG9jKHBvcnQtPmNvbnMudnRlcm1ubywgMCwgJmh2X29wcywgUEFH
RV9TSVpFKTsKPiAgIAlpZiAoSVNfRVJSKHBvcnQtPmNvbnMuaHZjKSkgewo+ICAgCQlyZXQgPSBQ
VFJfRVJSKHBvcnQtPmNvbnMuaHZjKTsKCldoYXQgaWYgdGhpcyBpZiAoSVNfRVJSKCkpIGVycm9y
IGhhcHBlbnM/IFRoZSBjb2RlIHNlZW1zIHRvIHJldHVybiBlYXJseSBpbiAKdGhpcyBjYXNlIC0g
c2hvdWxkbid0IHRoZSBJRCBiZSBmcmVlZCBhZ2FpbiBpbiB0aGlzIGNhc2U/CgogIFRob21hcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
