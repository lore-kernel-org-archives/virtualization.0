Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1305AC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 09:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AEA27400FF;
	Tue,  8 Mar 2022 09:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3VtedchTKik; Tue,  8 Mar 2022 09:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8531408E2;
	Tue,  8 Mar 2022 09:15:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD0EEC0012;
	Tue,  8 Mar 2022 09:15:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E576C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 09:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 363D884155
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 09:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EF-0_356-VeJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 09:15:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECCD68414C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 09:15:31 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id i8so27363825wrr.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 01:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=A67AlhskYiiSCgOgMfxOM8VtIq/AZbd8NuTpwj7+O9E=;
 b=ru0ZMHr+H3SzWxJ5c6z+akoloC2eYUtrZZDP/bO0aM7LsTlONsVtFwFb/M0zFfOyf8
 ElYyllP0vUy0v0lbdXhcPYe4WzX7ped6as7iO4g3cCmAJaWF+VZOQBy9ug42T440YpRF
 GUNi+yilLEuh339WAnK2G0QLo/WGwWiiz6vZ/8lCD4bCmK0TFsJdNrkLS30iJ3WFSL83
 SnRbArDjmbspkK6+UFofwFDjTRmpVBG0W/hwgBdGn/4koeWXQAPzHE106Pho9SQPGPFW
 5I7zM7fAiaC+9DyvnsQWd0h5V5zBpL4P1Hkpp1YpcllRm9Tk5tHYCkPE7/0BSdXqV9ip
 lg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=A67AlhskYiiSCgOgMfxOM8VtIq/AZbd8NuTpwj7+O9E=;
 b=GFKbHP0S3+GvIZuEjtn3bKHyXTm44VFMs6lR2jyubRUJbkVZeY24xM2JOQn+yl9cx0
 pCoLiCPC8bBM7YK5XFg+9UWvLqXjYP43u77B+/mvWQivdw8qNYCNH3CGKkiq/abjBkMw
 J159QXMg+HgFTFgprwapf5nRZvWtU9Yco2vBoAJctb/k9wZ407auSW6s+aEIs52KAM7p
 JfLhPI0Nt9bRUDmVumTpwTHY5R5RNfHM6sC8hztIajMPIggMLHu66yaD7NNTsLs51Uuh
 BdIjoaHElh1bpCStGP2jpn61t+4vRe8kzHHmBAsc3a4ddC1U19XYwhqxFzQ4JSdUqSgs
 q7cg==
X-Gm-Message-State: AOAM533xjyOpje83Gqg7SBpEqhDWDbXDf0QwXT5SwbTxyR04s3VL7GAu
 M9pjOHLKh1F9CMbiOE4h8Pl1yA==
X-Google-Smtp-Source: ABdhPJy9FjH8HkL7B/j6ELLmslkDBEpsnA6isr76dWseTv/sIBWInh7Ka7q7NHwbZ1Go3z4nK7Q0BQ==
X-Received: by 2002:adf:e448:0:b0:1ea:c7b6:782 with SMTP id
 t8-20020adfe448000000b001eac7b60782mr11302842wrm.29.1646730930092; 
 Tue, 08 Mar 2022 01:15:30 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 h13-20020adff18d000000b001f1de9f930esm15425518wro.81.2022.03.08.01.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 01:15:29 -0800 (PST)
Date: Tue, 8 Mar 2022 09:15:27 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yicer3yGg5rrdSIs@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yicalf1I6oBytbse@kroah.com>
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

T24gVHVlLCAwOCBNYXIgMjAyMiwgR3JlZyBLSCB3cm90ZToKCj4gT24gVHVlLCBNYXIgMDgsIDIw
MjIgYXQgMDg6MTA6MDZBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24gTW9uLCAwNyBN
YXIgMjAyMiwgR3JlZyBLSCB3cm90ZToKPiA+IAo+ID4gPiBPbiBNb24sIE1hciAwNywgMjAyMiBh
dCAwNzoxNzo1N1BNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+ID4gdmhvc3RfdnNvY2tf
aGFuZGxlX3R4X2tpY2soKSBhbHJlYWR5IGhvbGRzIHRoZSBtdXRleCBkdXJpbmcgaXRzIGNhbGwK
PiA+ID4gPiB0byB2aG9zdF9nZXRfdnFfZGVzYygpLiAgQWxsIHdlIGhhdmUgdG8gZG8gaGVyZSBp
cyB0YWtlIHRoZSBzYW1lIGxvY2sKPiA+ID4gPiBkdXJpbmcgdmlydHF1ZXVlIGNsZWFuLXVwIGFu
ZCB3ZSBtaXRpZ2F0ZSB0aGUgcmVwb3J0ZWQgaXNzdWVzLgo+ID4gPiA+IAo+ID4gPiA+IEFsc28g
V0FSTigpIGFzIGEgcHJlY2F1dGlvbmFyeSBtZWFzdXJlLiAgVGhlIHB1cnBvc2Ugb2YgdGhpcyBp
cyB0bwo+ID4gPiA+IGNhcHR1cmUgcG9zc2libGUgZnV0dXJlIHJhY2UgY29uZGl0aW9ucyB3aGlj
aCBtYXkgcG9wIHVwIG92ZXIgdGltZS4KPiA+ID4gPiAKPiA+ID4gPiBMaW5rOiBodHRwczovL3N5
emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9Mjc5NDMyZDMwZDgyNWU2M2JhMDAKPiA+ID4g
PiAKPiA+ID4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Cj4gPiA+ID4gUmVwb3J0ZWQt
Ynk6IHN5emJvdCthZGMzY2IzMjM4NTU4NmJlYzg1OUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29t
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4K
PiA+ID4gPiAtLS0KPiA+ID4gPiAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTAgKysrKysrKysr
Kwo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+ID4gPiA+IAo+ID4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zo
b3N0LmMKPiA+ID4gPiBpbmRleCA1OWVkYjVhMWZmZTI4Li5lZjdlMzcxZTNlNjQ5IDEwMDY0NAo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
dmhvc3Qvdmhvc3QuYwo+ID4gPiA+IEBAIC02OTMsNiArNjkzLDE1IEBAIHZvaWQgdmhvc3RfZGV2
X2NsZWFudXAoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ID4gPiA+ICAJaW50IGk7Cj4gPiA+ID4g
IAo+ID4gPiA+ICAJZm9yIChpID0gMDsgaSA8IGRldi0+bnZxczsgKytpKSB7Cj4gPiA+ID4gKwkJ
LyogTm8gd29ya2VycyBzaG91bGQgcnVuIGhlcmUgYnkgZGVzaWduLiBIb3dldmVyLCByYWNlcyBo
YXZlCj4gPiA+ID4gKwkJICogcHJldmlvdXNseSBvY2N1cnJlZCB3aGVyZSBkcml2ZXJzIGhhdmUg
YmVlbiB1bmFibGUgdG8gZmx1c2gKPiA+ID4gPiArCQkgKiBhbGwgd29yayBwcm9wZXJseSBwcmlv
ciB0byBjbGVhbi11cC4gIFdpdGhvdXQgYSBzdWNjZXNzZnVsCj4gPiA+ID4gKwkJICogZmx1c2gg
dGhlIGd1ZXN0IHdpbGwgbWFsZnVuY3Rpb24sIGJ1dCBhdm9pZGluZyBob3N0IG1lbW9yeQo+ID4g
PiA+ICsJCSAqIGNvcnJ1cHRpb24gaW4gdGhvc2UgY2FzZXMgZG9lcyBzZWVtIHByZWZlcmFibGUu
Cj4gPiA+ID4gKwkJICovCj4gPiA+ID4gKwkJV0FSTl9PTihtdXRleF9pc19sb2NrZWQoJmRldi0+
dnFzW2ldLT5tdXRleCkpOwo+ID4gPiAKPiA+ID4gU28geW91IGFyZSB0cmFkaW5nIG9uZSBzeXpi
b3QgdHJpZ2dlcmVkIGlzc3VlIGZvciBhbm90aGVyIG9uZSBpbiB0aGUKPiA+ID4gZnV0dXJlPyAg
OikKPiA+ID4gCj4gPiA+IElmIHRoaXMgZXZlciBjYW4gaGFwcGVuLCBoYW5kbGUgaXQsIGJ1dCBk
b24ndCBsb2cgaXQgd2l0aCBhIFdBUk5fT04oKSBhcwo+ID4gPiB0aGF0IHdpbGwgdHJpZ2dlciB0
aGUgcGFuaWMtb24td2FybiBib3hlcywgYXMgd2VsbCBhcyBzeXpib3QuICBVbmxlc3MKPiA+ID4g
eW91IHdhbnQgdGhhdCB0byBoYXBwZW4/Cj4gPiAKPiA+IE5vLCBTeXpib3QgZG9lc24ndCByZXBv
cnQgd2FybmluZ3MsIG9ubHkgQlVHcyBhbmQgbWVtb3J5IGNvcnJ1cHRpb24uCj4gCj4gSGFzIGl0
IGNoYW5nZWQ/ICBMYXN0IEkgbG9va2VkLCBpdCBkaWQgdHJpZ2dlciBvbiBXQVJOXyogY2FsbHMs
IHdoaWNoCj4gaGFzIHJlc3VsdGVkIGluIGEgaHVnZSBudW1iZXIgb2Yga2VybmVsIGZpeGVzIGJl
Y2F1c2Ugb2YgdGhhdC4KCkV2ZXJ5dGhpbmcgaXMgY3VzdG9taXNhYmxlIGluIHN5emthbGxlciwg
c28gbWF5YmUgdGhlcmUgYXJlIHNwZWNpZmljCmJ1aWxkcyB3aGljaCBwYW5pY19vbl93YXJuIGVu
YWJsZWQsIGJ1dCBub25lIHRoYXQgSSdtIGludm9sdmVkIHdpdGgKZG8uCgpIZXJlIGZvbGxvd3Mg
YSB0b3BpY2FsIGV4YW1wbGUuICBUaGUgcmVwb3J0IGFib3ZlIGluIHRoZSBMaW5rOiB0YWcKY29t
ZXMgd2l0aCBhIGNyYXNobG9nIFswXS4gIEluIHRoZXJlIHlvdSBjYW4gc2VlIHRoZSBXQVJOKCkg
YXQgdGhlCmJvdHRvbSBvZiB2aG9zdF9kZXZfY2xlYW51cCgpIHRyaWdnZXIgbWFueSB0aW1lcyBk
dWUgdG8gYSBwb3B1bGF0ZWQKKG5vbi1mbHVzaGVkKSB3b3JrZXIgbGlzdCwgYmVmb3JlIGZpbmFs
bHkgdHJpcHBpbmcgdGhlIEJVRygpIHdoaWNoCnRyaWdnZXJzIHRoZSByZXBvcnQ6CgpbMF0gaHR0
cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vdGV4dD90YWc9Q3Jhc2hMb2cmeD0xNmE2MWZjZTcw
MDAwMAoKPiA+ID4gQW5kIHdoYXQgaGFwcGVucyBpZiB0aGUgbXV0ZXggaXMgbG9ja2VkIF9SSUdI
VF8gYWZ0ZXIgeW91IGNoZWNrZWQgaXQ/Cj4gPiA+IFlvdSBzdGlsbCBoYXZlIGEgcmFjZS4uLgo+
ID4gCj4gPiBObywgd2UgbWlzcyBhIHdhcm5pbmcgdGhhdCBvbmUgdGltZS4gIE1lbW9yeSBpcyBz
dGlsbCBwcm90ZWN0ZWQuCj4gCj4gVGhlbiBkb24ndCB3YXJuIG9uIHNvbWV0aGluZyB0aGF0IGRv
ZXNuJ3QgbWF0dGVyLiAgVGhpcyBsaW5lIGNhbiBiZQo+IGRyb3BwZWQgYXMgdGhlcmUncyBub3Ro
aW5nIGFueW9uZSBjYW4gZG8gYWJvdXQgaXQsIHJpZ2h0PwoKWW91J2xsIGhhdmUgdG8gdGFrZSB0
aGF0IHBvaW50IHVwIHdpdGggTWljaGFlbC4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KUHJp
bmNpcGFsIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSC
IE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9v
ayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
