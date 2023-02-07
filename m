Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01DFC6379F
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 17:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F15140A93;
	Tue,  7 Feb 2023 17:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F15140A93
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GBOSdL5W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1lkf8oMh8VB; Tue,  7 Feb 2023 17:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7CA6408A3;
	Tue,  7 Feb 2023 17:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7CA6408A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 780F3C0033;
	Tue,  7 Feb 2023 17:39:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CBCBC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E86A81E8B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E86A81E8B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GBOSdL5W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CYWo8UdyEtNC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:39:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BE9081E8A
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BE9081E8A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:39:09 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 822E460F91
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E888BC433A0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675791547;
 bh=KZlrxH/j0b90gVF45TsrOX41MvrLcj8pAItg6Xzoxdo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GBOSdL5WJf/wN4rUEjZiQTaQ87SKc9knmDdocyN27DLgtcevcjewUvlju5pPYTDDF
 gCq8LBxzDYG063ZTo2GufKunfjMbvUZMsQ8GEEvTA5aYOo1Wf+Cp1hAGOp0gSjnVRA
 WjBDtIfBbWnW6ehmUX7ZjHqVWfaGQgvebPk/XdfFHM1wqqWl2gpkCUaG5Z5bufAYk5
 ix6av/JK0kWbmRBrF2Au+1HmRQRILDLzlNgEMMUazQ9UvqwRlNuQm13T3uqk868Y3u
 +0FRgWRoArOJP4UmEZKs6B0uPGSJOLn6MZ7G+llBisOq+AIzaVhprre2nlOppjD/Aw
 EHW4b6ffFruMA==
Received: by mail-vs1-f47.google.com with SMTP id p10so17098966vsu.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 09:39:07 -0800 (PST)
X-Gm-Message-State: AO0yUKXwlk1r21XTma4iVM6Uwk/X4OxZ2oXOJc/IJEkGKAGTsp8jv0hn
 X8jvJF6PIrs+ULAkbchBOUxIneizqY0+Yq/YWA==
X-Google-Smtp-Source: AK7set8he/v5HFsA1kt1CzDG53fUn4W/mqRZFX4p6+6jCqlvPfny4Lqp0rVvcs5fJmGGKMoqWTO9zOzlppsHceLljxs=
X-Received: by 2002:a67:7206:0:b0:3ea:c8c:48a5 with SMTP id
 n6-20020a677206000000b003ea0c8c48a5mr815523vsc.53.1675791546831; Tue, 07 Feb
 2023 09:39:06 -0800 (PST)
MIME-Version: 1.0
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
 <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201174638.GA3872117-robh@kernel.org>
 <20230203173616.GA8582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230203173616.GA8582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Feb 2023 11:38:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKWWg=nL5C1Hz7GQ6YCbc0ssUP71Be6kcn57v5240GQew@mail.gmail.com>
Message-ID: <CAL_JsqKWWg=nL5C1Hz7GQ6YCbc0ssUP71Be6kcn57v5240GQew@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, ssengar@microsoft.com,
 mikelley@microsoft.com, linux-hyperv@vger.kernel.org, haiyangz@microsoft.com,
 daniel.lezcano@linaro.org, decui@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, krzysztof.kozlowski+dt@linaro.org,
 tglx@linutronix.de
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

T24gRnJpLCBGZWIgMywgMjAyMyBhdCAxMTozNiBBTSBTYXVyYWJoIFNpbmdoIFNlbmdhcgo8c3Nl
bmdhckBsaW51eC5taWNyb3NvZnQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgRmViIDAxLCAyMDIz
IGF0IDExOjQ2OjM4QU0gLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOgo+ID4gT24gV2VkLCBGZWIg
MDEsIDIwMjMgYXQgMDg6NTE6MzNBTSAtMDgwMCwgU2F1cmFiaCBTaW5naCBTZW5nYXIgd3JvdGU6
Cj4gPiA+IE9uIFR1ZSwgSmFuIDMxLCAyMDIzIGF0IDAyOjEyOjUzUE0gLTA2MDAsIFJvYiBIZXJy
aW5nIHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgSmFuIDMxLCAyMDIzIGF0IDEyOjEwIFBNIFNhdXJh
YmggU2VuZ2FyCj4gPiA+ID4gPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gVXBkYXRlIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCBkZXZpY2UgdHJl
ZSBib290IGFzIHdlbGwgYWxvbmcgd2l0aCBBQ1BJLgo+ID4gPiA+ID4gQXQgcHJlc2VudCB0aGUg
ZGV2aWNlIHRyZWUgcGFyc2luZyBvbmx5IHByb3ZpZGVzIHRoZSBtbWlvIHJlZ2lvbiBpbmZvCj4g
PiA+ID4gPiBhbmQgaXMgbm90IHRoZSBleGFjdCBjb3B5IG9mIEFDUEkgcGFyc2luZy4gVGhpcyBp
cyBzdWZmaWNpZW50IHRvIGNhdGVyCj4gPiA+ID4gPiBhbGwgdGhlIGN1cnJlbnQgZGV2aWNlIHRy
ZWUgdXNlY2FzZXMgZm9yIFZNQnVzLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFNhdXJhYmggU2VuZ2FyIDxzc2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb20+Cj4gPiA+ID4gPiAt
LS0KPiA+ID4gPiA+ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIHwgNzUgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDcz
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jCj4g
PiA+ID4gPiBpbmRleCA0OTAzMGU3NTZiOWYuLjE3NDFmMTM0OGY5ZiAxMDA2NDQKPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaHYv
dm1idXNfZHJ2LmMKPiA+ID4gPiA+IEBAIC0yMTUyLDcgKzIxNTIsNyBAQCB2b2lkIHZtYnVzX2Rl
dmljZV91bnJlZ2lzdGVyKHN0cnVjdCBodl9kZXZpY2UgKmRldmljZV9vYmopCj4gPiA+ID4gPiAg
ICAgICAgIGRldmljZV91bnJlZ2lzdGVyKCZkZXZpY2Vfb2JqLT5kZXZpY2UpOwo+ID4gPiA+ID4g
IH0KPiAoLi4uKQo+ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldjsKPiA+ID4g
PiA+IEBAIC0yNDQyLDYgKzI0NDMsNyBAQCB2b2lkIHZtYnVzX2ZyZWVfbW1pbyhyZXNvdXJjZV9z
aXplX3Qgc3RhcnQsIHJlc291cmNlX3NpemVfdCBzaXplKQo+ID4gPiA+ID4gIH0KPiA+ID4gPiA+
ICBFWFBPUlRfU1lNQk9MX0dQTCh2bWJ1c19mcmVlX21taW8pOwo+ID4gPiA+ID4KPiA+ID4gPiA+
ICsjaWZkZWYgQ09ORklHX0FDUEkKPiA+ID4gPgo+ID4gPiA+IEl0J3MgYmV0dGVyIHRvIHB1dCBD
ICdpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0FDUEkpJyBjb2RlIGluIHRoZQo+ID4gPgo+ID4gPiBJ
IHdhbnRlZCB0byBoYXZlIHNlcGFyYXRlIGZ1bmN0aW9uIGZvciBBQ1BJIGFuZCBkZXZpY2UgdHJl
ZSBmbG93LCB3aGljaAo+ID4gPiBjYW4gYmUgZWFzaWx5IG1haW50YWluZWQgd2l0aCAjaWZkZWYu
IFBsZWFzZSBsZXQgbWUga25vdyBpZiBpdHMgZmluZS4KPiA+Cj4gPiBZZXMsIHlvdSBjYW4gaGF2
ZSBzZXBhcmF0ZSBmdW5jdGlvbnM6Cj4gPgo+ID4gc3RhdGljIGludCB2bWJ1c19hY3BpX2FkZChz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gewo+ID4gICAgICAgaWYgKCFJU19FTkFC
TEVEKENPTkZJR19BQ1BJKSkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7Cj4gPgo+
ID4gICAgICAgLi4uCj4gPiB9Cj4gPgo+ID4gVGhlIGNvbXBpbGVyIHdpbGwgdGhyb3cgYXdheSB0
aGUgZnVuY3Rpb24gaW4gdGhlIGVuZCBpZiBDT05GSUdfQUNQSSBpcwo+ID4gbm90IGVuYWJsZWQu
Cj4gPgo+ID4gVGhhdCBpcyBlYXNpZXIgZm9yIHVzIHRvIG1haW50YWluIGJlY2F1c2UgaXQgcmVk
dWNlcyB0aGUgY29tYmluYXRpb25zIHRvCj4gPiBidWlsZC4KPiA+Cj4KPiBJIHRyaWVkIHJlbW92
aW5nICNpZmRlZiBDT05GSUdfQUNQSSBhbmQgdXNlIEMncyBpZighSVNfRU5BQkxFRChDT05GSUdf
QUNQSSkpIGJ1dCBsb29rcwo+IGNvbXBpbGVyIGlzIG5vdCBvcHRpbWl6aW5nIG91dCB0aGUgcmVz
dCBvZiBmdW5jdGlvbiwgaXQgc3RpbGwgdGhyb3dpbmcgZXJyb3JzCj4gZm9yIGFjcGkgZnVuY3Rp
b25zLiBUaGlzIGRvZXNuJ3QgbG9vayAxOjEgcmVwbGFjZW1lbnQgdG8gbWUuCj4gUGxlYXNlIGxl
dCBtZSBrbm93IGlmIEkgaGF2ZSBtaXNzdW5kZXJzdG9vZCBhbnkgb2YgeW91ciBzdWdnZXN0aW9u
Lgo+Cj4gZHJpdmVycy9odi92bWJ1c19kcnYuYzoyMTc1Ojg6IGVycm9yOiBpbXBsaWNpdCBkZWNs
YXJhdGlvbiBvZiBmdW5jdGlvbiDigJhhY3BpX2Rldl9yZXNvdXJjZV9pbnRlcnJ1cHTigJkgWy1X
ZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tCgpUaGF0J3MgYSBmYWlsdXJlIG9mIHRoZSBBQ1BJIGhl
YWRlcnMgbm90IGhhdmluZyBlbXB0eSBmdW5jdGlvbgpkZWNsYXJhdGlvbnMuIFRoZSBEVCBmdW5j
dGlvbnMgZG8uLi4KCkFsc28sIHRoaXMgaXMganVzdCBhIGJyb2tlbiBhc3N1bXB0aW9uOgoKI2lm
ZGVmIENPTkZJR19BQ1BJCgojZWxzZQovLyBBc3N1bWUgRFQKI2VuZGlmCgpCb3RoIEFDUEkgYW5k
IERUIGNhbiBiZSBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWUuIFRoZXkgbWF5IGJlIG11dHVhbGx5
CmV4Y2x1c2l2ZSBmb3IgYSBwbGF0Zm9ybSwgYnV0IG5vdCB0aGUga2VybmVsLiBGb3IgZGlzdHJv
IGtlcm5lbHMsIGJvdGgKd2lsbCBiZSBlbmFibGVkIHR5cGljYWxseSBpZiB0aGUgYXJjaCBzdXBw
b3J0cyBib3RoLiBPbiBhcm02NCwgRFQgaXMKbmV2ZXIgZGlzYWJsZWQgYmVjYXVzZSB0aGUgYm9v
dCBpbnRlcmZhY2UgaXMgYWx3YXlzIERULgoKRnVydGhlcm1vcmUsIHRoaXMgbWFrZXMgY29tcGls
ZSB0ZXN0aW5nIHlvdXIgY29kZSBkaWZmaWN1bHQuIFRoZSBhcm02NApkZWZjb25maWcsIGFsbG1v
ZGNvbmZpZyBhbmQgYWxseWVzY29uZmlnIGFsbCB3aWxsIG5vdCBidWlsZCB0aGUgRFQKY29kZS4g
VGhlIHNhbWUgZm9yIHg4Ni4gVGhpcyBtZWFucyBhbGwgdGhlIENJIGJ1aWxkcyB0aGF0IGhhcHBl
biBjYW4ndApidWlsZCB0ZXN0IHRoaXMuCgpSb2IKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
