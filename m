Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D73FC433FE
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 10:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1A8260F13;
	Wed,  2 Mar 2022 10:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5odoogWgJ_ri; Wed,  2 Mar 2022 10:08:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 77CDF60E96;
	Wed,  2 Mar 2022 10:08:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5637CC0012;
	Wed,  2 Mar 2022 10:08:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F191BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 10:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D25BD60B3B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 10:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtHImGyymhPp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 10:08:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C01B3608D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 10:07:59 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 n33-20020a05600c3ba100b003832caf7f3aso809984wms.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 02:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=zc2Kxkwq8yRJOIjT0AKi1HEEsJsOWY9kQ95eThh2v70=;
 b=ecAKqbUejfhOR4GBhQMpQI50QgEqRyNg/QnFeZcpReex2f/aKqpIJhK5D5uM8fAKWF
 mMf0G85D4XF9vE0xLxfF7IiVw6iAd7xy76WbrDFUoHm9U2roE5BFSjaD6rDbUu1nyLDs
 TUSLnUg4xns+ak4kN47GRaBDCiJs28GqnYG0nqw5JNZUjyvWuY6qte9Dl5jC9gDq4POq
 DWkEu69p7F7FmjVZ1US0DD/+mB5Qi8VwuedvAKxN2FVzxj5c0H3I9cSDR4Ftpmt/VfAS
 RZWk1CVThRo0jiotRwXIm+yIw9Cz03uAGiiqgwmCgWlCK4jT6bdRalYJSElqXS5X/Rlm
 UEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zc2Kxkwq8yRJOIjT0AKi1HEEsJsOWY9kQ95eThh2v70=;
 b=VQUngaCRYLG8Y/nIYGlb53eur5xtzdWg5FBZev9A8HQ25TWIN4fnQSwZjjAPBIlNLo
 7AddXBoN7hJdFwjtVLXeUhr8h+1oPGcYOycWfngKT7QwO1MXhcATFA15bJQWHzwetpvJ
 SrUw2N8OGGusdHh8mMX9BedGkk77iqv4BKAlr2zXFVZ/N/xh8KhtMGePSjSEo48I7Ixe
 Z3oD6j/JTIzMxPVSdgzbE1mugxx27ajh4BdcXNxPcB9pAPOw+JVqJawWh/H3f6gviuxN
 Xd1wabVZrG3JYnFL+tY4/e6+VHPcATx2z2kIhze7Z+i2jqcl2phJpJrQvgQ65IUItY6p
 V6iA==
X-Gm-Message-State: AOAM532UqaYJRxcn0EolE2ydzRRWPEU6ddD27nE/863/WNS7T/u4X0NL
 rN/uZJfQVbG7wwmVV1X+zhFgVg==
X-Google-Smtp-Source: ABdhPJz8M0JUlRrgQnR37WHwsfOfDjkWNajdAFWhrLUoxOp/RJdiuL9DzgCo0omQgu5pxB9pI/a4/w==
X-Received: by 2002:a05:600c:378b:b0:381:67e7:e20c with SMTP id
 o11-20020a05600c378b00b0038167e7e20cmr10999452wmr.32.1646215677851; 
 Wed, 02 Mar 2022 02:07:57 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 i5-20020a1c3b05000000b00382871cf734sm4075730wma.25.2022.03.02.02.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 02:07:57 -0800 (PST)
Date: Wed, 2 Mar 2022 10:07:55 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yh9B+wKDKXHZ6ly/@google.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gV2VkLCAwMiBNYXIgMjAyMiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgoKPiBPbiBXZWQs
IE1hciAwMiwgMjAyMiBhdCAwNzo1NDoyMUFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiB2
aG9zdF92c29ja19oYW5kbGVfdHhfa2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmlu
ZyBpdHMgY2FsbAo+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3ZSBoYXZlIHRvIGRv
IGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQg
d2UgbWl0aWdhdGUgdGhlIHJlcG9ydGVkIGlzc3Vlcy4KPiA+IAo+ID4gTGluazogaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTI3OTQzMmQzMGQ4MjVlNjNiYTAwCj4gCj4g
VGhpcyBpc3N1ZSBpcyBzaW1pbGFyIHRvIFsxXSB0aGF0IHNob3VsZCBiZSBhbHJlYWR5IGZpeGVk
IHVwc3RyZWFtIGJ5IFsyXS4KPiAKPiBIb3dldmVyIEkgdGhpbmsgdGhpcyBwYXRjaCB3b3VsZCBo
YXZlIHByZXZlbnRlZCBzb21lIGlzc3VlcywgYmVjYXVzZQo+IHZob3N0X3ZxX3Jlc2V0KCkgc2V0
cyB2cS0+cHJpdmF0ZSB0byBOVUxMLCBwcmV2ZW50aW5nIHRoZSB3b3JrZXIgZnJvbQo+IHJ1bm5p
bmcuCj4gCj4gQW55d2F5IEkgdGhpbmsgdGhhdCB3aGVuIHdlIGVudGVyIGluIHZob3N0X2Rldl9j
bGVhbnVwKCkgdGhlIHdvcmtlciBzaG91bGQKPiBiZSBhbHJlYWR5IHN0b3BwZWQsIHNvIGl0IHNo
b3VsZG4ndCBiZSBuZWNlc3NhcnkgdG8gdGFrZSB0aGUgbXV0ZXguIEJ1dCBpbgo+IG9yZGVyIHRv
IHByZXZlbnQgZnV0dXJlIGlzc3VlcyBtYXliZSBpdCdzIGJldHRlciB0byB0YWtlIHRoZW0sIHNv
OgoKCj4gUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNv
bT4KClRoYW5rcyBmb3IgdGhlIGFuYWx5c2lzIGFuZCB0aGUgcmV2aWV3IFN0ZWZhbm8uCgotLSAK
TGVlIEpvbmVzIFvmnY7nkLzmlq9dClByaW5jaXBhbCBUZWNobmljYWwgTGVhZCAtIERldmVsb3Bl
ciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNv
Q3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
