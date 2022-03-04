Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A0BC433F5
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 08:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F5A582AAA;
	Fri,  4 Mar 2022 08:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQD05pcioElB; Fri,  4 Mar 2022 08:12:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B9A7282AA7;
	Fri,  4 Mar 2022 08:12:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A5A1C0012;
	Fri,  4 Mar 2022 08:12:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D4A3C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59F7082AB9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 38D7ozUGa23W
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E13982AAA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:34 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id u1so11414152wrg.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=PTdhZ6zTG/wMEQhhzfPXGyXVYLVkCG56MpdGyRnOBVI=;
 b=Pmf2t9u+18kQH7IAPgSpCA8+P+Pr1LWI/Tnym4Tf38VqtV68KuJxIBW4bz4aPRJb7s
 FotOKu54Ei94IvCyVqRrl3FPSfRUncnyiIlnU/gYuZnoq7Lp93cs41oeygcIV6cQWiQL
 3MqAnA5QDBaQ76T9FM4jXL35WVoP0kdTjBo02o5U7BmCPeIfVlgf1fuVY/ZVIo6k/Bvm
 /8rQrxARhXJyy5IhFazUmOWGxxwpnwpYZApUBX1LMBi+4TpzForlhGfpPZ1v06IHBqCo
 vNZme2896fgkl8UDxpGKdaTOhqhgzNRhyfLG+ckucf1XBRWoKrlE9DureanSDGxQXV4j
 0p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PTdhZ6zTG/wMEQhhzfPXGyXVYLVkCG56MpdGyRnOBVI=;
 b=d5B6FySQjFxn9+ycF2PPAKMri1bJJy5mrPvJtU9Br8ChBj7em1EI+PMlol8esBH/Hf
 kw59BtA7sn1/JVhUpv/AjdHHmYHO/41I+QxFY69XF2Pm/osbudIZBF18d5nOUwVHP9zh
 qKAAZmxuOtXL2cWkURmDHxehOkbYd7ffJ4yLUzGuXAQa0AwoZEWM295bnl/53hrUAGxM
 9VE7xgvIjynOamNYooR/Ugq6xFAyzPh7CqH6TL0usBtPNp+/ZwdjHWIcghTHSTk4aeaV
 vvgd8VjWEckn9cpIMBsD9FfIHdjav4VBDCtAMbE1BNBj09aya+r29W/0/xKk46+iXjv8
 UzxA==
X-Gm-Message-State: AOAM533yCREueZE6lYTb3kI2DO6ZMzvaBB6TjPDo57ps+CCQyNabEyxM
 dUVO6vignqpuHlUiK/qPUxJNiA==
X-Google-Smtp-Source: ABdhPJzVw968hxMEIY0q2+bwjpWc6NSOwZs/15JsNkWcbOqqbxojEzQRti0Lz26wnPm3h5o1K7KOTg==
X-Received: by 2002:a05:6000:184e:b0:1f0:3569:ccac with SMTP id
 c14-20020a056000184e00b001f03569ccacmr8266477wri.680.1646381552773; 
 Fri, 04 Mar 2022 00:12:32 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 t9-20020a05600c198900b0037c0342cb62sm13850215wmq.4.2022.03.04.00.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 00:12:32 -0800 (PST)
Date: Fri, 4 Mar 2022 08:12:30 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <YiHJ7qFgkcC7igwq@google.com>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
 <YiETnIcfZCLb63oB@unreal>
 <20220303155645-mutt-send-email-mst@kernel.org>
 <20220304075039.rewrf3gnbbh3sdfl@sgarzare-redhat>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220304075039.rewrf3gnbbh3sdfl@sgarzare-redhat>
Cc: Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gRnJpLCAwNCBNYXIgMjAyMiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgoKPiBPbiBUaHUs
IE1hciAwMywgMjAyMiBhdCAwNDowMTowNlBNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiBPbiBUaHUsIE1hciAwMywgMjAyMiBhdCAwOToxNDozNlBNICswMjAwLCBMZW9uIFJv
bWFub3Zza3kgd3JvdGU6Cj4gPiA+IE9uIFRodSwgTWFyIDAzLCAyMDIyIGF0IDAzOjE5OjI5UE0g
KzAwMDAsIExlZSBKb25lcyB3cm90ZToKPiA+ID4gPiBBbGwgd29ya2Vycy91c2VycyBzaG91bGQg
YmUgaGFsdGVkIGJlZm9yZSBhbnkgY2xlYW4tdXAgc2hvdWxkIHRha2UgcGxhY2UuCj4gPiA+ID4K
PiA+ID4gPiBTdWdnZXN0ZWQtYnk6ICBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDMgKysrCj4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+
ID4gPiBpbmRleCBiYmFmZjZhNWUyMWI4Li5kOTM1ZDI1MDY5NjNmIDEwMDY0NAo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYwo+ID4gPiA+IEBAIC02OTMsNiArNjkzLDkgQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChz
dHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPiA+ID4gIAlpbnQgaTsKPiA+ID4gPgo+ID4gPiA+ICAJ
Zm9yIChpID0gMDsgaSA8IGRldi0+bnZxczsgKytpKSB7Cj4gPiA+ID4gKwkJLyogSWRlYWxseSBh
bGwgd29ya2VycyBzaG91bGQgYmUgc3RvcHBlZCBwcmlvciB0byBjbGVhbi11cCAqLwo+ID4gPiA+
ICsJCVdBUk5fT04obXV0ZXhfaXNfbG9ja2VkKCZkZXYtPnZxc1tpXS0+bXV0ZXgpKTsKPiA+ID4g
PiArCj4gPiA+ID4gIAkJbXV0ZXhfbG9jaygmZGV2LT52cXNbaV0tPm11dGV4KTsKPiA+ID4gCj4g
PiA+IEkga25vdyBub3RoaW5nIGFib3V0IHZob3N0LCBidXQgdGhpcyBjb25zdHJ1Y3Rpb24gYW5k
IHBhdGNoIGxvb2tzCj4gPiA+IHN0cmFuZ2UgdG8gbWUuCj4gPiA+IAo+ID4gPiBJZiBhbGwgd29y
a2VycyB3ZXJlIHN0b3BwZWQsIHlvdSB3b24ndCBuZWVkIG11dGV4X2xvY2soKS4gVGhlIG11dGV4
X2xvY2sKPiA+ID4gaGVyZSBzdWdnZXN0cyB0byBtZSB0aGF0IHdvcmtlcnMgY2FuIHN0aWxsIHJ1
biBoZXJlLgo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiAKPiA+IAo+ID4gIklkZWFsbHkiIGhlcmUg
aXMgbWlzbGVhZGluZywgd2UgbmVlZCBhIGJpZ2dlciBkZXRhaWxlZCBjb21tZW50Cj4gPiBhbG9u
ZyB0aGUgbGluZXMgb2Y6Cj4gPiAKPiA+IC8qCj4gPiAqIEJ5IGRlc2lnbiwgbm8gd29ya2VycyBj
YW4gcnVuIGhlcmUuIEJ1dCBpZiB0aGVyZSdzIGEgYnVnIGFuZCB0aGUKPiA+ICogZHJpdmVyIGRp
ZCBub3QgZmx1c2ggYWxsIHdvcmsgcHJvcGVybHkgdGhlbiB0aGV5IG1pZ2h0LCBhbmQgd2UKPiA+
ICogZW5jb3VudGVyZWQgc3VjaCBidWdzIGluIHRoZSBwYXN0LiAgV2l0aCBubyBwcm9wZXIgZmx1
c2ggZ3Vlc3Qgd29uJ3QKPiA+ICogd29yayBjb3JyZWN0bHkgYnV0IGF2b2lkaW5nIGhvc3QgbWVt
b3J5IGNvcnJ1cHRpb24gaW4gdGhpcyBjYXNlCj4gPiAqIHNvdW5kcyBsaWtlIGEgZ29vZCBpZGVh
Lgo+ID4gKi8KPiAKPiBDYW4gd2UgdXNlIHZob3N0X3ZxX2dldF9iYWNrZW5kKCkgdG8gY2hlY2sg
dGhpcyBzaXR1YXRpb24/Cj4gCj4gSUlVQyBhbGwgdGhlIHZob3N0IGRldmljZXMgY2xlYXIgdGhl
IGJhY2tlbmQgdG8gc3RvcCB0aGUgd29ya2Vycy4KPiBUaGlzIGlzIG5vdCByYWN5IChpZiB3ZSBk
byBhZnRlciB0aGUgbXV0ZXhfbG9jaykgYW5kIHNob3VsZCBjb3ZlciBhbGwgY2FzZXMuCgpJIGNh
biBsb29rIGludG8gdGhpcyB0b28gaWYgeW91IGxpa2UuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzm
lq9dClByaW5jaXBhbCBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8u
b3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzog
RmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
