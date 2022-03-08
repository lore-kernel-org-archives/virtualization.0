Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69961C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 13:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAB5D41780;
	Tue,  8 Mar 2022 13:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRYc62UjLKIb; Tue,  8 Mar 2022 13:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 653E3415DB;
	Tue,  8 Mar 2022 13:17:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31AD7C0012;
	Tue,  8 Mar 2022 13:17:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A33ADC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DE358414F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EOGtKuuI3bnj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:17:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1153384148
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:17:07 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id h15so4144804wrc.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=DlKhxu+LqVz17YluSD/2WMyqg3I/bzdDeK8Xd5lH4Nc=;
 b=tUpT+l/kDbEnrxwoPe0cSlkoHFeIwcOIW34nEeAfTPLzg9g3X3m+2wb+kf6CF5WruS
 0uHfQcbl0j3HUZrgH5zNoEOadjHjWWZTyypxkET0RXrAYoWU0Jt3Pjv8KbMxMvpb3KVR
 glykef1q0jt6Zr/UshpSLSB5H5CAsbcCvI9ZGfV21RY3q4jb1xdUew2vLy55dsDZ2dlc
 m47imykZZVCdCkiLfI+A7NccsHLepDUnd3nnTWnCLXuKfrtxE+P8Uv5OeWTBry+vJB7z
 9Mi2D4JmgdpMQ82s+1oeuJaLQRSx5zs4EUGATFnb4xNMQ6XQwISOyNY7NOI1gjPJpyeK
 uTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DlKhxu+LqVz17YluSD/2WMyqg3I/bzdDeK8Xd5lH4Nc=;
 b=IzPuLZ8iLXnxiaWzt4VVYJPX1shQtr56Qe5CZl7D8vwlMLP9ykhArOHZp5CnAIc5LY
 WhrmCmapXOeIsVp1bDcG90q88d7fUEqVTxszr1GRn4Eg/KLkqt5MG3wUQ6ci8jJ6CgNs
 HNWv3z7vK73kxc7zVVCfV8OxSt4JK00+aM5ZEyUtABYgP7uiT3dm8bQwxlbf69Fq1oa6
 C2vvkWM7Hb2KoxbzOlNaRYdISa/RgWiZ6JFM4Q7CypP6Ul9wig0wJC5FWe2ZmeMuKsB4
 rYcCvRZlHHPUJiZWOFSUckLHycnlchLFd3qIewzeS+SNIEqc/T8pALx+RkauIStrQqS9
 zDgA==
X-Gm-Message-State: AOAM533Ka2FoVjceT741xyPTEYkF5xY3onXDuHnmk1p49cVP/euchYP4
 1/BoWKZ/RmmINjatPi6DrS2L5DP/mFzGpnn+
X-Google-Smtp-Source: ABdhPJwbgYMOFPI4IWRNj/NoVcAezAtsLTQB67NBB/7Wxh6IySHxoNz1f7HejTNRMpjkOwC4T7R9yw==
X-Received: by 2002:a05:6000:1acf:b0:1f0:5e62:9b28 with SMTP id
 i15-20020a0560001acf00b001f05e629b28mr11817701wry.448.1646745426018; 
 Tue, 08 Mar 2022 05:17:06 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6806000000b002036515dda7sm2022427wru.33.2022.03.08.05.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 05:17:05 -0800 (PST)
Date: Tue, 8 Mar 2022 13:17:03 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YidXT6zP1QN5KZUs@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com> <Yicer3yGg5rrdSIs@google.com>
 <YicolvcbY9VT6AKc@kroah.com>
 <20220308055003-mutt-send-email-mst@kernel.org>
 <YidBz7SxED2ii1Lh@kroah.com>
 <20220308071718-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220308071718-mutt-send-email-mst@kernel.org>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
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

T24gVHVlLCAwOCBNYXIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBUdWUs
IE1hciAwOCwgMjAyMiBhdCAxMjo0NToxOVBNICswMTAwLCBHcmVnIEtIIHdyb3RlOgo+ID4gT24g
VHVlLCBNYXIgMDgsIDIwMjIgYXQgMDU6NTU6NThBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gPiBPbiBUdWUsIE1hciAwOCwgMjAyMiBhdCAxMDo1Nzo0MkFNICswMTAwLCBH
cmVnIEtIIHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgTWFyIDA4LCAyMDIyIGF0IDA5OjE1OjI3QU0g
KzAwMDAsIExlZSBKb25lcyB3cm90ZToKPiA+ID4gPiA+IE9uIFR1ZSwgMDggTWFyIDIwMjIsIEdy
ZWcgS0ggd3JvdGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gT24gVHVlLCBNYXIgMDgsIDIwMjIg
YXQgMDg6MTA6MDZBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1v
biwgMDcgTWFyIDIwMjIsIEdyZWcgS0ggd3JvdGU6Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiBPbiBNb24sIE1hciAwNywgMjAyMiBhdCAwNzoxNzo1N1BNICswMDAwLCBMZWUgSm9uZXMg
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IHZob3N0X3Zzb2NrX2hhbmRsZV90eF9raWNrKCkgYWxy
ZWFkeSBob2xkcyB0aGUgbXV0ZXggZHVyaW5nIGl0cyBjYWxsCj4gPiA+ID4gPiA+ID4gPiA+IHRv
IHZob3N0X2dldF92cV9kZXNjKCkuICBBbGwgd2UgaGF2ZSB0byBkbyBoZXJlIGlzIHRha2UgdGhl
IHNhbWUgbG9jawo+ID4gPiA+ID4gPiA+ID4gPiBkdXJpbmcgdmlydHF1ZXVlIGNsZWFuLXVwIGFu
ZCB3ZSBtaXRpZ2F0ZSB0aGUgcmVwb3J0ZWQgaXNzdWVzLgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiA+ID4gQWxzbyBXQVJOKCkgYXMgYSBwcmVjYXV0aW9uYXJ5IG1lYXN1cmUuICBU
aGUgcHVycG9zZSBvZiB0aGlzIGlzIHRvCj4gPiA+ID4gPiA+ID4gPiA+IGNhcHR1cmUgcG9zc2li
bGUgZnV0dXJlIHJhY2UgY29uZGl0aW9ucyB3aGljaCBtYXkgcG9wIHVwIG92ZXIgdGltZS4KPiA+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IExpbms6IGh0dHBzOi8vc3l6a2FsbGVy
LmFwcHNwb3QuY29tL2J1Zz9leHRpZD0yNzk0MzJkMzBkODI1ZTYzYmEwMAo+ID4gPiA+ID4gPiA+
ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+ID4g
PiA+ID4gPiA+ID4gPiBSZXBvcnRlZC1ieTogc3l6Ym90K2FkYzNjYjMyMzg1NTg2YmVjODU5QHN5
emthbGxlci5hcHBzcG90bWFpbC5jb20KPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4g
PiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxMCArKysrKysrKysrCj4g
PiA+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+ID4gPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qv
dmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA1
OWVkYjVhMWZmZTI4Li5lZjdlMzcxZTNlNjQ5IDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92
aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4gPiA+IEBAIC02OTMsNiArNjkzLDE1IEBAIHZvaWQg
dmhvc3RfZGV2X2NsZWFudXAoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ID4gPiA+ID4gPiA+ID4g
PiAgCWludCBpOwo+ID4gPiA+ID4gPiA+ID4gPiAgCj4gPiA+ID4gPiA+ID4gPiA+ICAJZm9yIChp
ID0gMDsgaSA8IGRldi0+bnZxczsgKytpKSB7Cj4gPiA+ID4gPiA+ID4gPiA+ICsJCS8qIE5vIHdv
cmtlcnMgc2hvdWxkIHJ1biBoZXJlIGJ5IGRlc2lnbi4gSG93ZXZlciwgcmFjZXMgaGF2ZQo+ID4g
PiA+ID4gPiA+ID4gPiArCQkgKiBwcmV2aW91c2x5IG9jY3VycmVkIHdoZXJlIGRyaXZlcnMgaGF2
ZSBiZWVuIHVuYWJsZSB0byBmbHVzaAo+ID4gPiA+ID4gPiA+ID4gPiArCQkgKiBhbGwgd29yayBw
cm9wZXJseSBwcmlvciB0byBjbGVhbi11cC4gIFdpdGhvdXQgYSBzdWNjZXNzZnVsCj4gPiA+ID4g
PiA+ID4gPiA+ICsJCSAqIGZsdXNoIHRoZSBndWVzdCB3aWxsIG1hbGZ1bmN0aW9uLCBidXQgYXZv
aWRpbmcgaG9zdCBtZW1vcnkKPiA+ID4gPiA+ID4gPiA+ID4gKwkJICogY29ycnVwdGlvbiBpbiB0
aG9zZSBjYXNlcyBkb2VzIHNlZW0gcHJlZmVyYWJsZS4KPiA+ID4gPiA+ID4gPiA+ID4gKwkJICov
Cj4gPiA+ID4gPiA+ID4gPiA+ICsJCVdBUk5fT04obXV0ZXhfaXNfbG9ja2VkKCZkZXYtPnZxc1tp
XS0+bXV0ZXgpKTsKPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gU28geW91IGFyZSB0
cmFkaW5nIG9uZSBzeXpib3QgdHJpZ2dlcmVkIGlzc3VlIGZvciBhbm90aGVyIG9uZSBpbiB0aGUK
PiA+ID4gPiA+ID4gPiA+IGZ1dHVyZT8gIDopCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiA+IElmIHRoaXMgZXZlciBjYW4gaGFwcGVuLCBoYW5kbGUgaXQsIGJ1dCBkb24ndCBsb2cgaXQg
d2l0aCBhIFdBUk5fT04oKSBhcwo+ID4gPiA+ID4gPiA+ID4gdGhhdCB3aWxsIHRyaWdnZXIgdGhl
IHBhbmljLW9uLXdhcm4gYm94ZXMsIGFzIHdlbGwgYXMgc3l6Ym90LiAgVW5sZXNzCj4gPiA+ID4g
PiA+ID4gPiB5b3Ugd2FudCB0aGF0IHRvIGhhcHBlbj8KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiBObywgU3l6Ym90IGRvZXNuJ3QgcmVwb3J0IHdhcm5pbmdzLCBvbmx5IEJVR3MgYW5kIG1l
bW9yeSBjb3JydXB0aW9uLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSGFzIGl0IGNoYW5nZWQ/
ICBMYXN0IEkgbG9va2VkLCBpdCBkaWQgdHJpZ2dlciBvbiBXQVJOXyogY2FsbHMsIHdoaWNoCj4g
PiA+ID4gPiA+IGhhcyByZXN1bHRlZCBpbiBhIGh1Z2UgbnVtYmVyIG9mIGtlcm5lbCBmaXhlcyBi
ZWNhdXNlIG9mIHRoYXQuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEV2ZXJ5dGhpbmcgaXMgY3VzdG9t
aXNhYmxlIGluIHN5emthbGxlciwgc28gbWF5YmUgdGhlcmUgYXJlIHNwZWNpZmljCj4gPiA+ID4g
PiBidWlsZHMgd2hpY2ggcGFuaWNfb25fd2FybiBlbmFibGVkLCBidXQgbm9uZSB0aGF0IEknbSBp
bnZvbHZlZCB3aXRoCj4gPiA+ID4gPiBkby4KPiA+ID4gPiAKPiA+ID4gPiBNYW55IHN5c3RlbXMg
cnVuIHdpdGggcGFuaWMtb24td2FybiAoaS5lLiB0aGUgY2xvdWQpLCBhcyB0aGV5IHdhbnQgdG8K
PiA+ID4gPiBkcm9wIGEgYm94IGFuZCByZXN0YXJ0IGl0IGlmIGFueXRoaW5nIGdvZXMgd3Jvbmcu
Cj4gPiA+ID4gCj4gPiA+ID4gVGhhdCdzIHdoeSBzeXpib3QgcmVwb3J0cyBvbiBXQVJOXyogY2Fs
bHMuICBUaGV5IHNob3VsZCBuZXZlciBiZQo+ID4gPiA+IHJlYWNoYWJsZSBieSB1c2Vyc3BhY2Ug
YWN0aW9ucy4KPiA+ID4gPiAKPiA+ID4gPiA+IEhlcmUgZm9sbG93cyBhIHRvcGljYWwgZXhhbXBs
ZS4gIFRoZSByZXBvcnQgYWJvdmUgaW4gdGhlIExpbms6IHRhZwo+ID4gPiA+ID4gY29tZXMgd2l0
aCBhIGNyYXNobG9nIFswXS4gIEluIHRoZXJlIHlvdSBjYW4gc2VlIHRoZSBXQVJOKCkgYXQgdGhl
Cj4gPiA+ID4gPiBib3R0b20gb2Ygdmhvc3RfZGV2X2NsZWFudXAoKSB0cmlnZ2VyIG1hbnkgdGlt
ZXMgZHVlIHRvIGEgcG9wdWxhdGVkCj4gPiA+ID4gPiAobm9uLWZsdXNoZWQpIHdvcmtlciBsaXN0
LCBiZWZvcmUgZmluYWxseSB0cmlwcGluZyB0aGUgQlVHKCkgd2hpY2gKPiA+ID4gPiA+IHRyaWdn
ZXJzIHRoZSByZXBvcnQ6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IFswXSBodHRwczovL3N5emthbGxl
ci5hcHBzcG90LmNvbS90ZXh0P3RhZz1DcmFzaExvZyZ4PTE2YTYxZmNlNzAwMDAwCj4gPiA+ID4g
Cj4gPiA+ID4gT2ssIHNvIGJvdGggaGFwcGVucyBoZXJlLiAgQnV0IGRvbid0IGFkZCBhIHdhcm5p
bmcgZm9yIHNvbWV0aGluZyB0aGF0Cj4gPiA+ID4gY2FuJ3QgaGFwcGVuLiAgSnVzdCBoYW5kbGUg
aXQgYW5kIG1vdmUgb24uICBJdCBsb29rcyBsaWtlIHlvdSBhcmUKPiA+ID4gPiBoYW5kbGluZyBp
dCBpbiB0aGlzIGNvZGUsIHNvIHBsZWFzZSBkcm9wIHRoZSBXQVJOX09OKCkuCj4gPiA+ID4gCj4g
PiA+ID4gdGhhbmtzLAo+ID4gPiA+IAo+ID4gPiA+IGdyZWcgay1oCj4gPiA+IAo+ID4gPiBIbW0u
IFdlbGwgdGhpcyB3aWxsIG1lYW4gaWYgd2UgZXZlciByZWludHJvZHVjZSB0aGUgYnVnIHRoZW4K
PiA+ID4gc3l6a2FsbGVyIHdpbGwgbm90IGNhdGNoIGl0IGZvciB1cyA6KCBBbmQgdGhlIGJ1ZyBp
cyB0aGVyZSwKPiA+ID4gaXQganVzdCByZXN1bHRzIGluIGEgaGFyZCB0byByZXByb2R1Y2UgZXJy
b3IgZm9yIHVzZXJzcGFjZS4KPiA+IAo+ID4gSXMgdGhpcyBhbiBlcnJvciB5b3UgY2FuIHJlY292
ZXIgZnJvbSBpbiB0aGUga2VybmVsPwo+ID4gIFdoYXQgaXMgdXNlcnNwYWNlCj4gPiBzdXBwb3Nl
ZCB0byBrbm93IHdpdGggdGhpcyBpbmZvcm1hdGlvbiB3aGVuIGl0IHNlZXMgaXQ/Cj4gCj4gSUlV
QyB3ZSBhcmUgdGFsa2luZyBhYm91dCBhIHVzZSBhZnRlciBmcmVlIGhlcmUgc2luY2Ugd2Ugc29t
ZWhvdwo+IG1hbmFnZWQgdG8gaGF2ZSBhIHBvaW50ZXIgdG8gdGhlIGRldmljZSBpbiBhIHdvcmtl
ciB3aGlsZQo+IGRldmljZSBpcyBiZWluZyBkZXN0cm95ZWQuCj4gCj4gVGhhdCdzIHRoZSBwb2lu
dCBvZiB0aGUgd2FybmluZyBhcyB1c2UgYWZ0ZXIgZnJlZSBpcyBoYXJkIHRvIGRlYnVnLiBZb3UK
PiBhc2sgY2FuIHdlIHJlY292ZXIgZnJvbSBhIHVzZSBhZnRlciBmcmVlPyAKPiAKPiBBcyByZWdh
cmRzIHRvIHRoZSBhZGRlZCBsb2NrLCBJSVVDIGl0IGtpbmQgb2Ygc2hpZnRzIHRoZSB1c2UgYWZ0
ZXIgZnJlZQo+IHdpbmRvdyB0byBsYXRlciBhbmQgc2luY2Ugd2UgemVybyBvdXQgc29tZSBvZiB0
aGUgbWVtb3J5IGp1c3QgYmVmb3JlIHdlCj4gZnJlZSBpdCwgaXQncyBhIGJpdCBtb3JlIGxpa2Vs
eSB0byByZWNvdmVyLiAgSSB3b3VsZCBzdGlsbCBsaWtlIHRvIHNlZQo+IHNvbWUgbW9yZSBhbmFs
eXNpcyBvbiB3aHkgdGhlIHNpdHVhdGlvbiBpcyBhbHdheXMgYmV0dGVyIHRoYW4gaXQgd2FzCj4g
YmVmb3JlIHRob3VnaC4KCldpdGggdGhlIGxvY2tzIGluIHBsYWNlLCB0aGUgVUFGIHNob3VsZCBu
b3Qgb2NjdXIuCgpUaGUgaXNzdWUgaGVyZSBpcyB0aGF0IHlvdSBoYXZlIDIgZGlmZmVyZW50IHRh
c2tzIHByb2Nlc3NpbmcgdGhlCnNhbWUgYXJlYSBvZiBtZW1vcnkgKHZpYSBwb2ludGVycyB0byBz
dHJ1Y3RzKS4gIEluIHRoZXNlIHNjZW5hcmlvcyB5b3UKc2hvdWxkIGFsd2F5cyBwcm92aWRlIGxv
Y2tpbmcgYW5kL29yIHJlZmVyZW5jZSBjb3VudGluZyB0byBwcmV2ZW50Cm1lbW9yeSBjb3JydXB0
aW9uIG9yIFVBRi4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KUHJpbmNpcGFsIFRlY2huaWNh
bCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNv
ZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBC
bG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
