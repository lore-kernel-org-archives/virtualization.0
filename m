Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897AEC43219
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 10:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 354868131E;
	Tue,  8 Mar 2022 10:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28hQdB7cSrJo; Tue,  8 Mar 2022 10:08:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AFCEB80BDA;
	Tue,  8 Mar 2022 10:08:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E769C001D;
	Tue,  8 Mar 2022 10:08:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E617C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 484E760F26
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:08:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HHtPfPYLeD2P
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:08:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05AA260ACF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:08:51 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 bg31-20020a05600c3c9f00b00381590dbb33so1126838wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 02:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=SkUfNfh3Db7trPuKU1cr1xzPGmDu+V01w8HeZZrfZF4=;
 b=TcEZ7SnCqx+88Ek0cWwzw0I0uG+pFNYXYTSd6/FUBFUNJcDZChkJJ7aym8/zsrh9wP
 0WJgPgrTgga9nbrft6Qq3nPhOdr+MPh3ve1ACFwiAtZ1rDXFoxerrnct9JfMVDD9vNBu
 OVt7YNvg58Lpaq4XSGltz3TE2P1VPLaSGGWj0ekHuYkbs1y0QLp2/q2TKPBPjgaBgYZm
 FndSCehbwzLESjJjkPoLr143+oqKI3+53ODsNc2UrDsJ7JxHh88NLirt+Z0q4CIxGxz3
 Vghz+IB7ZlQCNmZ0+SdIERYZwTdCaLnVmvnqMTFRhkSMoqNHWVB32uO4XfMp6DyYlqXs
 OZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SkUfNfh3Db7trPuKU1cr1xzPGmDu+V01w8HeZZrfZF4=;
 b=kTK/UhuEUfbgV0FSTuR8X9ceVGXl5g/UTGCmIK5/Ah9V71XSPsOfNlZhlo6qzFulCh
 X3l0QpBint9zdDDKSXcmazCp9w1adtyYzrySPb0g7K3eL2hSmMl2tNCbnq64gh7HNYrg
 C1lj0ARyzyFt38xk941LWFVA2B/amCKWj7dDmnXb+FnEUIi8qSr2stIxEVxvWgXiQnni
 po6GdhQarJc0m9UteeEiAnrJLy3bg0HjMYMVLNfJlTkM5CICGdwPz2GKFPIzd4RqNDNx
 k0mPA97zJy3JURFPG+E2CjYggiOsLTo7++lwFtGcOmGn+h7ZITzJkjW5S9Mpxc9CA9lw
 9KoA==
X-Gm-Message-State: AOAM533uQrNg1fAIj3btR5ZZu7Zct7V8EsFH8fUCHlQVzhjdbg31v8/P
 W6ofmwlmlMjrY/ufYIpT44Y3fg==
X-Google-Smtp-Source: ABdhPJyrzL3jGMmbS7hVKMZbspK5xUkBY1M3etbicBcGEMsABnOdM650d1NvL9CixlA6YyPMGo+S2Q==
X-Received: by 2002:a1c:6a08:0:b0:388:73a2:1548 with SMTP id
 f8-20020a1c6a08000000b0038873a21548mr2868053wmc.163.1646734130240; 
 Tue, 08 Mar 2022 02:08:50 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 u14-20020adfed4e000000b001e3323611e5sm12978222wro.26.2022.03.08.02.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 02:08:49 -0800 (PST)
Date: Tue, 8 Mar 2022 10:08:47 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YicrL1RXZhXXsA6t@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com> <Yicer3yGg5rrdSIs@google.com>
 <YicolvcbY9VT6AKc@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YicolvcbY9VT6AKc@kroah.com>
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
MjIgYXQgMDk6MTU6MjdBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24gVHVlLCAwOCBN
YXIgMjAyMiwgR3JlZyBLSCB3cm90ZToKPiA+IAo+ID4gPiBPbiBUdWUsIE1hciAwOCwgMjAyMiBh
dCAwODoxMDowNkFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCAwNyBN
YXIgMjAyMiwgR3JlZyBLSCB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiA+IE9uIE1vbiwgTWFyIDA3
LCAyMDIyIGF0IDA3OjE3OjU3UE0gKzAwMDAsIExlZSBKb25lcyB3cm90ZToKPiA+ID4gPiA+ID4g
dmhvc3RfdnNvY2tfaGFuZGxlX3R4X2tpY2soKSBhbHJlYWR5IGhvbGRzIHRoZSBtdXRleCBkdXJp
bmcgaXRzIGNhbGwKPiA+ID4gPiA+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3ZSBo
YXZlIHRvIGRvIGhlcmUgaXMgdGFrZSB0aGUgc2FtZSBsb2NrCj4gPiA+ID4gPiA+IGR1cmluZyB2
aXJ0cXVldWUgY2xlYW4tdXAgYW5kIHdlIG1pdGlnYXRlIHRoZSByZXBvcnRlZCBpc3N1ZXMuCj4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBBbHNvIFdBUk4oKSBhcyBhIHByZWNhdXRpb25hcnkgbWVh
c3VyZS4gIFRoZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8KPiA+ID4gPiA+ID4gY2FwdHVyZSBwb3Nz
aWJsZSBmdXR1cmUgcmFjZSBjb25kaXRpb25zIHdoaWNoIG1heSBwb3AgdXAgb3ZlciB0aW1lLgo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gTGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPTI3OTQzMmQzMGQ4MjVlNjNiYTAwCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Cj4gPiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBz
eXpib3QrYWRjM2NiMzIzODU1ODZiZWM4NTlAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+
ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDEwICsr
KysrKysrKysKPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5j
IGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+IGluZGV4IDU5ZWRiNWExZmZlMjgu
LmVmN2UzNzFlM2U2NDkgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gPiA+ID4g
QEAgLTY5Myw2ICs2OTMsMTUgQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYpCj4gPiA+ID4gPiA+ICAJaW50IGk7Cj4gPiA+ID4gPiA+ICAKPiA+ID4gPiA+ID4g
IAlmb3IgKGkgPSAwOyBpIDwgZGV2LT5udnFzOyArK2kpIHsKPiA+ID4gPiA+ID4gKwkJLyogTm8g
d29ya2VycyBzaG91bGQgcnVuIGhlcmUgYnkgZGVzaWduLiBIb3dldmVyLCByYWNlcyBoYXZlCj4g
PiA+ID4gPiA+ICsJCSAqIHByZXZpb3VzbHkgb2NjdXJyZWQgd2hlcmUgZHJpdmVycyBoYXZlIGJl
ZW4gdW5hYmxlIHRvIGZsdXNoCj4gPiA+ID4gPiA+ICsJCSAqIGFsbCB3b3JrIHByb3Blcmx5IHBy
aW9yIHRvIGNsZWFuLXVwLiAgV2l0aG91dCBhIHN1Y2Nlc3NmdWwKPiA+ID4gPiA+ID4gKwkJICog
Zmx1c2ggdGhlIGd1ZXN0IHdpbGwgbWFsZnVuY3Rpb24sIGJ1dCBhdm9pZGluZyBob3N0IG1lbW9y
eQo+ID4gPiA+ID4gPiArCQkgKiBjb3JydXB0aW9uIGluIHRob3NlIGNhc2VzIGRvZXMgc2VlbSBw
cmVmZXJhYmxlLgo+ID4gPiA+ID4gPiArCQkgKi8KPiA+ID4gPiA+ID4gKwkJV0FSTl9PTihtdXRl
eF9pc19sb2NrZWQoJmRldi0+dnFzW2ldLT5tdXRleCkpOwo+ID4gPiA+ID4gCj4gPiA+ID4gPiBT
byB5b3UgYXJlIHRyYWRpbmcgb25lIHN5emJvdCB0cmlnZ2VyZWQgaXNzdWUgZm9yIGFub3RoZXIg
b25lIGluIHRoZQo+ID4gPiA+ID4gZnV0dXJlPyAgOikKPiA+ID4gPiA+IAo+ID4gPiA+ID4gSWYg
dGhpcyBldmVyIGNhbiBoYXBwZW4sIGhhbmRsZSBpdCwgYnV0IGRvbid0IGxvZyBpdCB3aXRoIGEg
V0FSTl9PTigpIGFzCj4gPiA+ID4gPiB0aGF0IHdpbGwgdHJpZ2dlciB0aGUgcGFuaWMtb24td2Fy
biBib3hlcywgYXMgd2VsbCBhcyBzeXpib3QuICBVbmxlc3MKPiA+ID4gPiA+IHlvdSB3YW50IHRo
YXQgdG8gaGFwcGVuPwo+ID4gPiA+IAo+ID4gPiA+IE5vLCBTeXpib3QgZG9lc24ndCByZXBvcnQg
d2FybmluZ3MsIG9ubHkgQlVHcyBhbmQgbWVtb3J5IGNvcnJ1cHRpb24uCj4gPiA+IAo+ID4gPiBI
YXMgaXQgY2hhbmdlZD8gIExhc3QgSSBsb29rZWQsIGl0IGRpZCB0cmlnZ2VyIG9uIFdBUk5fKiBj
YWxscywgd2hpY2gKPiA+ID4gaGFzIHJlc3VsdGVkIGluIGEgaHVnZSBudW1iZXIgb2Yga2VybmVs
IGZpeGVzIGJlY2F1c2Ugb2YgdGhhdC4KPiA+IAo+ID4gRXZlcnl0aGluZyBpcyBjdXN0b21pc2Fi
bGUgaW4gc3l6a2FsbGVyLCBzbyBtYXliZSB0aGVyZSBhcmUgc3BlY2lmaWMKPiA+IGJ1aWxkcyB3
aGljaCBwYW5pY19vbl93YXJuIGVuYWJsZWQsIGJ1dCBub25lIHRoYXQgSSdtIGludm9sdmVkIHdp
dGgKPiA+IGRvLgo+IAo+IE1hbnkgc3lzdGVtcyBydW4gd2l0aCBwYW5pYy1vbi13YXJuIChpLmUu
IHRoZSBjbG91ZCksIGFzIHRoZXkgd2FudCB0bwo+IGRyb3AgYSBib3ggYW5kIHJlc3RhcnQgaXQg
aWYgYW55dGhpbmcgZ29lcyB3cm9uZy4KPiAKPiBUaGF0J3Mgd2h5IHN5emJvdCByZXBvcnRzIG9u
IFdBUk5fKiBjYWxscy4gIFRoZXkgc2hvdWxkIG5ldmVyIGJlCj4gcmVhY2hhYmxlIGJ5IHVzZXJz
cGFjZSBhY3Rpb25zLgo+IAo+ID4gSGVyZSBmb2xsb3dzIGEgdG9waWNhbCBleGFtcGxlLiAgVGhl
IHJlcG9ydCBhYm92ZSBpbiB0aGUgTGluazogdGFnCj4gPiBjb21lcyB3aXRoIGEgY3Jhc2hsb2cg
WzBdLiAgSW4gdGhlcmUgeW91IGNhbiBzZWUgdGhlIFdBUk4oKSBhdCB0aGUKPiA+IGJvdHRvbSBv
ZiB2aG9zdF9kZXZfY2xlYW51cCgpIHRyaWdnZXIgbWFueSB0aW1lcyBkdWUgdG8gYSBwb3B1bGF0
ZWQKPiA+IChub24tZmx1c2hlZCkgd29ya2VyIGxpc3QsIGJlZm9yZSBmaW5hbGx5IHRyaXBwaW5n
IHRoZSBCVUcoKSB3aGljaAo+ID4gdHJpZ2dlcnMgdGhlIHJlcG9ydDoKPiA+IAo+ID4gWzBdIGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3RleHQ/dGFnPUNyYXNoTG9nJng9MTZhNjFmY2U3
MDAwMDAKPiAKPiBPaywgc28gYm90aCBoYXBwZW5zIGhlcmUuICBCdXQgZG9uJ3QgYWRkIGEgd2Fy
bmluZyBmb3Igc29tZXRoaW5nIHRoYXQKPiBjYW4ndCBoYXBwZW4uICBKdXN0IGhhbmRsZSBpdCBh
bmQgbW92ZSBvbi4gIEl0IGxvb2tzIGxpa2UgeW91IGFyZQo+IGhhbmRsaW5nIGl0IGluIHRoaXMg
Y29kZSwgc28gcGxlYXNlIGRyb3AgdGhlIFdBUk5fT04oKS4KCkhhcHB5IHRvIG9ibGlnZS4KCkxl
dCdzIGdpdmUgTWljaGVhbCBhIGNoYW5jZSB0byBzcGVhaywgdGhlbiBJJ2xsIGZpeC11cCBpZiBo
ZSBhZ3JlZXMuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClByaW5jaXBhbCBUZWNobmljYWwg
TGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0
d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxv
ZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
