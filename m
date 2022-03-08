Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6FAC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 08:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4612D813FD;
	Tue,  8 Mar 2022 08:10:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6PGWscEVB1i1; Tue,  8 Mar 2022 08:10:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D55EF81410;
	Tue,  8 Mar 2022 08:10:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8BA2C001D;
	Tue,  8 Mar 2022 08:10:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19313C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04D5940936
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-qR_auUy96n
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:10:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A328408ED
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:10:10 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id p9so27100450wra.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 00:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bC4nX/4w2hAp8ne90xPCyTuVT60oAJGeczdCQbo0l3c=;
 b=QmDNjmplj+bPdQf7fQe47SUylL4K0+DMOKwd1ybuiZGCaFLMOK8TYpXB5AN6ao8waC
 3RZ+8T5oBvLk7sE8SOLy3Vz1qthxs76QJ5vxuIzAQn2tIcCjEx/kMREVsJJ8aV8zKTVg
 H+F+0e0ovnAOA9t3tYMnV8ptAl5j9ZBM5bIKWPUDTYj1jx2IDv6Dcp/OPIkhOrvT1Iac
 sB/7dFSog87yqWl1RZnPK5SURyoAx5s88de7qeZCRoVaffTncrbKpLpjju3MFchUQ6KE
 gCpshgv7aHnKpeJNFdT71GJq6SZgRbqKt3YqoJwgKbGm57vDDUhGBEiKEsWqgdR+jPje
 ny/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bC4nX/4w2hAp8ne90xPCyTuVT60oAJGeczdCQbo0l3c=;
 b=JsI5ePCeeA3cq/9Qu2hNf9F1Whb8/RtUapJrJNvurY/FXxOjKP2GndICgQeQ7pOAJD
 FOijMepis2KGrGi9zXQSafzz+ZXG2XGJHFAI/Ys8ns7BfsRV18dRVI6DSyBJRnEY+fJe
 L+ojoM5kZBae4kOVRuPI2EOULTdsHkfgyyV7WJrW35g0kfcErZU1nylWtn3K4wnRF25J
 IUL96N/VePHjI5U9y9niQTl0BTtgHB7MzG02dSZsNmRtIadjLQ3uM98tHDhs4lSU/eTt
 gjbif1bw6J/23NSENxkaKbpKXo8jaUT+GTFoargHlEPrOvkXPAvRBatW4qEffXJXU883
 xUbg==
X-Gm-Message-State: AOAM533OP9jQ/DRxrPtkxUUqFdmy0OqPDljKW/xirWaUSBn6Z5F5FDu0
 SfKg+utgNp2BEk58Y20j/ixIoA==
X-Google-Smtp-Source: ABdhPJzUt2KoS6npL3OLj00DKa4VkVnkLSkI4Qmgp881qSFd1k1FRRraWZrqYUd/ozCf3xX3VYvw8Q==
X-Received: by 2002:adf:dcc2:0:b0:1f0:4c38:d6be with SMTP id
 x2-20020adfdcc2000000b001f04c38d6bemr11263420wrm.79.1646727008778; 
 Tue, 08 Mar 2022 00:10:08 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 f20-20020a05600c4e9400b003898e252cd4sm1555824wmq.12.2022.03.08.00.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 00:10:08 -0800 (PST)
Date: Tue, 8 Mar 2022 08:10:06 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YicPXnNFHpoJHcUN@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiZeB7l49KC2Y5Gz@kroah.com>
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

T24gTW9uLCAwNyBNYXIgMjAyMiwgR3JlZyBLSCB3cm90ZToKCj4gT24gTW9uLCBNYXIgMDcsIDIw
MjIgYXQgMDc6MTc6NTdQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gdmhvc3RfdnNvY2tf
aGFuZGxlX3R4X2tpY2soKSBhbHJlYWR5IGhvbGRzIHRoZSBtdXRleCBkdXJpbmcgaXRzIGNhbGwK
PiA+IHRvIHZob3N0X2dldF92cV9kZXNjKCkuICBBbGwgd2UgaGF2ZSB0byBkbyBoZXJlIGlzIHRh
a2UgdGhlIHNhbWUgbG9jawo+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQgd2UgbWl0
aWdhdGUgdGhlIHJlcG9ydGVkIGlzc3Vlcy4KPiA+IAo+ID4gQWxzbyBXQVJOKCkgYXMgYSBwcmVj
YXV0aW9uYXJ5IG1lYXN1cmUuICBUaGUgcHVycG9zZSBvZiB0aGlzIGlzIHRvCj4gPiBjYXB0dXJl
IHBvc3NpYmxlIGZ1dHVyZSByYWNlIGNvbmRpdGlvbnMgd2hpY2ggbWF5IHBvcCB1cCBvdmVyIHRp
bWUuCj4gPiAKPiA+IExpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRp
ZD0yNzk0MzJkMzBkODI1ZTYzYmEwMAo+ID4gCj4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc+Cj4gPiBSZXBvcnRlZC1ieTogc3l6Ym90K2FkYzNjYjMyMzg1NTg2YmVjODU5QHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20KPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxMCArKysr
KysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+
ID4gaW5kZXggNTllZGI1YTFmZmUyOC4uZWY3ZTM3MWUzZTY0OSAxMDA2NDQKPiA+IC0tLSBhL2Ry
aXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiBA
QCAtNjkzLDYgKzY5MywxNSBAQCB2b2lkIHZob3N0X2Rldl9jbGVhbnVwKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldikKPiA+ICAJaW50IGk7Cj4gPiAgCj4gPiAgCWZvciAoaSA9IDA7IGkgPCBkZXYtPm52
cXM7ICsraSkgewo+ID4gKwkJLyogTm8gd29ya2VycyBzaG91bGQgcnVuIGhlcmUgYnkgZGVzaWdu
LiBIb3dldmVyLCByYWNlcyBoYXZlCj4gPiArCQkgKiBwcmV2aW91c2x5IG9jY3VycmVkIHdoZXJl
IGRyaXZlcnMgaGF2ZSBiZWVuIHVuYWJsZSB0byBmbHVzaAo+ID4gKwkJICogYWxsIHdvcmsgcHJv
cGVybHkgcHJpb3IgdG8gY2xlYW4tdXAuICBXaXRob3V0IGEgc3VjY2Vzc2Z1bAo+ID4gKwkJICog
Zmx1c2ggdGhlIGd1ZXN0IHdpbGwgbWFsZnVuY3Rpb24sIGJ1dCBhdm9pZGluZyBob3N0IG1lbW9y
eQo+ID4gKwkJICogY29ycnVwdGlvbiBpbiB0aG9zZSBjYXNlcyBkb2VzIHNlZW0gcHJlZmVyYWJs
ZS4KPiA+ICsJCSAqLwo+ID4gKwkJV0FSTl9PTihtdXRleF9pc19sb2NrZWQoJmRldi0+dnFzW2ld
LT5tdXRleCkpOwo+IAo+IFNvIHlvdSBhcmUgdHJhZGluZyBvbmUgc3l6Ym90IHRyaWdnZXJlZCBp
c3N1ZSBmb3IgYW5vdGhlciBvbmUgaW4gdGhlCj4gZnV0dXJlPyAgOikKPiAKPiBJZiB0aGlzIGV2
ZXIgY2FuIGhhcHBlbiwgaGFuZGxlIGl0LCBidXQgZG9uJ3QgbG9nIGl0IHdpdGggYSBXQVJOX09O
KCkgYXMKPiB0aGF0IHdpbGwgdHJpZ2dlciB0aGUgcGFuaWMtb24td2FybiBib3hlcywgYXMgd2Vs
bCBhcyBzeXpib3QuICBVbmxlc3MKPiB5b3Ugd2FudCB0aGF0IHRvIGhhcHBlbj8KCk5vLCBTeXpi
b3QgZG9lc24ndCByZXBvcnQgd2FybmluZ3MsIG9ubHkgQlVHcyBhbmQgbWVtb3J5IGNvcnJ1cHRp
b24uCgo+IEFuZCB3aGF0IGhhcHBlbnMgaWYgdGhlIG11dGV4IGlzIGxvY2tlZCBfUklHSFRfIGFm
dGVyIHlvdSBjaGVja2VkIGl0Pwo+IFlvdSBzdGlsbCBoYXZlIGEgcmFjZS4uLgoKTm8sIHdlIG1p
c3MgYSB3YXJuaW5nIHRoYXQgb25lIHRpbWUuICBNZW1vcnkgaXMgc3RpbGwgcHJvdGVjdGVkLgoK
LS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpQcmluY2lwYWwgVGVjaG5pY2FsIExlYWQgLSBEZXZl
bG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFy
bSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
