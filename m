Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2AFC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 08:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 979FC41743;
	Tue,  8 Mar 2022 08:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jI9ljkVbgUK; Tue,  8 Mar 2022 08:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BF8341719;
	Tue,  8 Mar 2022 08:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A5E8C001D;
	Tue,  8 Mar 2022 08:11:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18544C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12F254173F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o36c9cQKd-CJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:11:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E70941719
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:11:20 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id u10so25495396wra.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bUuwvQrXybXChtd344tucDAbC/YGVngRcc0ZDqCkqCM=;
 b=FOX5owV8RzTydaOm10xlR8P5JUbvjo/CFb/kM+h+EE4rb0970CllcVu7OwT3YZnsxM
 3wwkCScMrKpT6xVdU36PV5QVUpwnWNlUmeSgoTOVJfdhW4Vbvf66w9jQXdKrukZ5wxCO
 mKx01a+tMEzg/o21jrzYQQwpxbzT/QycYJxfu+ezOnNif28TjumqmoZxUDrlqQmckKHd
 7IqibmDYyuIugCo+VrhnhGPNf/jA6nRjHtYLD9y0lTybOcGB2GDHLhmN7qzudFV2Ajn1
 zMB9KGQ/pVrEDXg4+5gMMG7rZXtPWCS2W/5JOW/hwY+QgfQylJ7+SNNm8R/MurItEKbQ
 zDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bUuwvQrXybXChtd344tucDAbC/YGVngRcc0ZDqCkqCM=;
 b=5iOZEuprzV9bEgnwT1yWU7Wj1Qu5CCm+NC6J+xZ2sXneef7gfW9HHWUMgRWvpoW+Oj
 Qurjh+shozuXdM/9rQQxu/yhHCSDJ75k45inzvugPiXUIIMaY0iQMxdF92jaewq9iVGk
 P+Y7i+16Hb0Td7XhViaiy2Wj370PdP/wJGY9Ew4ySKlSzF8GFfpZllE9QnJUR/iHm4RC
 K5C6GgOCfVZCs+YBGtK15WqxI0m5f25GUJ3ah7CnUU/Lyb0cAJ5eiJRDpaN0qd5jzOVT
 bunetLECvNJ1yKtiNPo0VNgbmWpnA7PAhd3D+R8xtIh4H12OIVqHPTKJ90iXC5dwEFjS
 TnVw==
X-Gm-Message-State: AOAM532eki3g95yfC3olSZ1tPvYHjv/8X4UoVmf4YP9MhytVfez1b8H8
 zH9SniLgOLI/Vyi3KamZ7v8W1Q==
X-Google-Smtp-Source: ABdhPJyhnQawWRN2eaq4CHOTm2Mk+XURsNwuQaphypHckXVzl4v3Ff4oimUI6+a7e/f2RNB++zpv0w==
X-Received: by 2002:a5d:69d0:0:b0:1f1:fd05:e863 with SMTP id
 s16-20020a5d69d0000000b001f1fd05e863mr5423384wrw.223.1646727078277; 
 Tue, 08 Mar 2022 00:11:18 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 p22-20020a1c5456000000b00389a558670fsm1446399wmi.11.2022.03.08.00.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 00:11:17 -0800 (PST)
Date: Tue, 8 Mar 2022 08:11:15 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YicPo5YmyzOvBNP2@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YicPXnNFHpoJHcUN@google.com>
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

T24gVHVlLCAwOCBNYXIgMjAyMiwgTGVlIEpvbmVzIHdyb3RlOgoKPiBPbiBNb24sIDA3IE1hciAy
MDIyLCBHcmVnIEtIIHdyb3RlOgo+IAo+ID4gT24gTW9uLCBNYXIgMDcsIDIwMjIgYXQgMDc6MTc6
NTdQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gPiB2aG9zdF92c29ja19oYW5kbGVfdHhf
a2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmluZyBpdHMgY2FsbAo+ID4gPiB0byB2
aG9zdF9nZXRfdnFfZGVzYygpLiAgQWxsIHdlIGhhdmUgdG8gZG8gaGVyZSBpcyB0YWtlIHRoZSBz
YW1lIGxvY2sKPiA+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQgd2UgbWl0aWdhdGUg
dGhlIHJlcG9ydGVkIGlzc3Vlcy4KPiA+ID4gCj4gPiA+IEFsc28gV0FSTigpIGFzIGEgcHJlY2F1
dGlvbmFyeSBtZWFzdXJlLiAgVGhlIHB1cnBvc2Ugb2YgdGhpcyBpcyB0bwo+ID4gPiBjYXB0dXJl
IHBvc3NpYmxlIGZ1dHVyZSByYWNlIGNvbmRpdGlvbnMgd2hpY2ggbWF5IHBvcCB1cCBvdmVyIHRp
bWUuCj4gPiA+IAo+ID4gPiBMaW5rOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/
ZXh0aWQ9Mjc5NDMyZDMwZDgyNWU2M2JhMDAKPiA+ID4gCj4gPiA+IENjOiA8c3RhYmxlQHZnZXIu
a2VybmVsLm9yZz4KPiA+ID4gUmVwb3J0ZWQtYnk6IHN5emJvdCthZGMzY2IzMjM4NTU4NmJlYzg1
OUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy92aG9zdC92
aG9zdC5jIHwgMTAgKysrKysrKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9k
cml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gaW5kZXggNTllZGI1YTFmZmUyOC4uZWY3ZTM3MWUz
ZTY0OSAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ICsrKyBi
L2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiBAQCAtNjkzLDYgKzY5MywxNSBAQCB2b2lkIHZo
b3N0X2Rldl9jbGVhbnVwKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+ID4gIAlpbnQgaTsKPiA+
ID4gIAo+ID4gPiAgCWZvciAoaSA9IDA7IGkgPCBkZXYtPm52cXM7ICsraSkgewo+ID4gPiArCQkv
KiBObyB3b3JrZXJzIHNob3VsZCBydW4gaGVyZSBieSBkZXNpZ24uIEhvd2V2ZXIsIHJhY2VzIGhh
dmUKPiA+ID4gKwkJICogcHJldmlvdXNseSBvY2N1cnJlZCB3aGVyZSBkcml2ZXJzIGhhdmUgYmVl
biB1bmFibGUgdG8gZmx1c2gKPiA+ID4gKwkJICogYWxsIHdvcmsgcHJvcGVybHkgcHJpb3IgdG8g
Y2xlYW4tdXAuICBXaXRob3V0IGEgc3VjY2Vzc2Z1bAo+ID4gPiArCQkgKiBmbHVzaCB0aGUgZ3Vl
c3Qgd2lsbCBtYWxmdW5jdGlvbiwgYnV0IGF2b2lkaW5nIGhvc3QgbWVtb3J5Cj4gPiA+ICsJCSAq
IGNvcnJ1cHRpb24gaW4gdGhvc2UgY2FzZXMgZG9lcyBzZWVtIHByZWZlcmFibGUuCj4gPiA+ICsJ
CSAqLwo+ID4gPiArCQlXQVJOX09OKG11dGV4X2lzX2xvY2tlZCgmZGV2LT52cXNbaV0tPm11dGV4
KSk7Cj4gPiAKPiA+IFNvIHlvdSBhcmUgdHJhZGluZyBvbmUgc3l6Ym90IHRyaWdnZXJlZCBpc3N1
ZSBmb3IgYW5vdGhlciBvbmUgaW4gdGhlCj4gPiBmdXR1cmU/ICA6KQo+ID4gCj4gPiBJZiB0aGlz
IGV2ZXIgY2FuIGhhcHBlbiwgaGFuZGxlIGl0LCBidXQgZG9uJ3QgbG9nIGl0IHdpdGggYSBXQVJO
X09OKCkgYXMKPiA+IHRoYXQgd2lsbCB0cmlnZ2VyIHRoZSBwYW5pYy1vbi13YXJuIGJveGVzLCBh
cyB3ZWxsIGFzIHN5emJvdC4gIFVubGVzcwo+ID4geW91IHdhbnQgdGhhdCB0byBoYXBwZW4/Cj4g
Cj4gTm8sIFN5emJvdCBkb2Vzbid0IHJlcG9ydCB3YXJuaW5ncywgb25seSBCVUdzIGFuZCBtZW1v
cnkgY29ycnVwdGlvbi4KPiAKPiA+IEFuZCB3aGF0IGhhcHBlbnMgaWYgdGhlIG11dGV4IGlzIGxv
Y2tlZCBfUklHSFRfIGFmdGVyIHlvdSBjaGVja2VkIGl0Pwo+ID4gWW91IHN0aWxsIGhhdmUgYSBy
YWNlLi4uCj4gCj4gTm8sIHdlIG1pc3MgYSB3YXJuaW5nIHRoYXQgb25lIHRpbWUuICBNZW1vcnkg
aXMgc3RpbGwgcHJvdGVjdGVkLgoKSSBkaWRuJ3QgbWVhbiB0aG9zZSAibm8icyB0byBzb3VuZCBz
byBuZWdhdGl2ZSwgc29ycnkuIDopCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClByaW5jaXBh
bCBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVu
IHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBU
d2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
