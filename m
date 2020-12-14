Return-Path: <SRS0=0lGn=FS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA8C4361B
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 03:55:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A1F2389F
	for <virtualization@archiver.kernel.org>; Mon, 14 Dec 2020 03:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A1F2389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E83C871ED;
	Mon, 14 Dec 2020 03:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFuTstq1V6wu; Mon, 14 Dec 2020 03:55:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E54C871AD;
	Mon, 14 Dec 2020 03:55:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 593A0C0893;
	Mon, 14 Dec 2020 03:55:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEBF5C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C4A208698B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fgrf3vtCJ8P
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A43CB86979
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 03:55:37 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id b9so20656080ejy.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Dec 2020 19:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d4TOJ0OhuO8aQINr4ymrDs96mPIyR6ulw4ivnTC1GK0=;
 b=HV27Sistxdj6DbrnPLahKB8aC9AzdKctIUA7IQzRETHqMP5bdprl/0bs+86B1e7FfR
 vx4O6GGYoach9taVZwSRzeh9Gc5eIVGZxlaKE6KiWiko7ujtOU3kBLtLr2nVAj7/5dXZ
 YPk3Qa9UfBK18jH+k/k/0A219ia9BmrdEOET05kxyF4YUHP9Zr7AWnF3edROwPNoMI+a
 PYEE8eJ0/N7VN9nrtC85AQRoKG3QIvU9rubr7LjdX+O6hOsiz8wcADLySBxA24S60iwD
 P0lM7vP7Jx94mjfUspjFOu55ZpGsLw28tT2mfH7NSAdeysgqgUhFW29bGBS+TujWi7v/
 1ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d4TOJ0OhuO8aQINr4ymrDs96mPIyR6ulw4ivnTC1GK0=;
 b=V6WNUNpzn69qYg3pO2HWkgHBET2jFhg0SWgsxC03w+J2e2MHBtDx9V/K3GBHewJN/+
 2aGgTJHU7rwokblKRRO4H4Y9dsMck1du5w+WqYpKM6483UUdrl0FqgqC4uspcnlGyPln
 4XFgiejOBQmqjy+mmhDzX3TsI+mu30UhQdbz85xqAkMdFba3T9yIdmahry9ok4yBZkuX
 yCjOTPaFY0mh3I2T1zUgA28Cl/u6OlEsIJEkW5i+6VQ4gISf7rwTjVSfTpkcgaaPQ5x1
 VY+DXFSieiZiH9cNhZ+/X+E9JYp06QMxxQCTfAEbT1CyHTvNJSg0YbXylN5yP7aZzmzE
 5mHA==
X-Gm-Message-State: AOAM533T2RBvDdjQJmOteLo8KmUcGLqsDcls5oDUJyRGiBv+kZy2N6jX
 2QZ04C6XybuoNDndsb3aMEC6+CQQuidAROXsQec=
X-Google-Smtp-Source: ABdhPJzvPrPpJv94YN3ajoeyIC0cBwCW9IBY1P/wA7dhs00SjshhvOaFHBhVUSiN3JqL4anEOgkVTaUVxvvI//wQDpE=
X-Received: by 2002:a17:906:4348:: with SMTP id
 z8mr21550852ejm.119.1607918135935; 
 Sun, 13 Dec 2020 19:55:35 -0800 (PST)
MIME-Version: 1.0
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
 <1607517703-18472-1-git-send-email-wangyunjian@huawei.com>
 <CA+FuTSfQoDr0jd76xBXSvchhyihQaL2UQXeCR6frJ7hyXxbmVA@mail.gmail.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB6E3B3@dggemm513-mbx.china.huawei.com>
 <CA+FuTSdVJa4JQzzybZ17WDcfokA2RZ043kh5++Zgy5aNNebj0A@mail.gmail.com>
 <CAF=yD-LF+j1vpzKDtBVUi22ZkTCEnMAXgfLfoQTBO+95D6RGRA@mail.gmail.com>
 <75c625df-3ac8-79ba-d1c5-3b6d1f9b108b@redhat.com>
In-Reply-To: <75c625df-3ac8-79ba-d1c5-3b6d1f9b108b@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 13 Dec 2020 22:54:59 -0500
Message-ID: <CAF=yD-+Hcg8cNo2qMfpGOWRORJskZR3cPPEE61neg7xFWkVh8w@mail.gmail.com>
Subject: Re: [PATCH net v2] tun: fix ubuf refcount incorrectly on error path
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 wangyunjian <wangyunjian@huawei.com>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

T24gU3VuLCBEZWMgMTMsIDIwMjAgYXQgMTA6MzAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IE9uIDIwMjAvMTIvMTQg5LiK5Y2IOTozMiwgV2lsbGVtIGRl
IEJydWlqbiB3cm90ZToKPiA+IE9uIFNhdCwgRGVjIDEyLCAyMDIwIGF0IDc6MTggUE0gV2lsbGVt
IGRlIEJydWlqbgo+ID4gPHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOgo+
ID4+Pj4+IGFmdGVyd2FyZHMsIHRoZSBlcnJvciBoYW5kbGluZyBpbiB2aG9zdCBoYW5kbGVfdHgo
KSB3aWxsIHRyeSB0bwo+ID4+Pj4+IGRlY3JlYXNlIHRoZSBzYW1lIHJlZmNvdW50IGFnYWluLiBU
aGlzIGlzIHdyb25nIGFuZCBmaXggdGhpcyBieSBkZWxheQo+ID4+Pj4+IGNvcHlpbmcgdWJ1Zl9p
bmZvIHVudGlsIHdlJ3JlIHN1cmUgdGhlcmUncyBubyBlcnJvcnMuCj4gPj4+PiBJIHRoaW5rIHRo
ZSByaWdodCBhcHByb2FjaCBpcyB0byBhZGRyZXNzIHRoaXMgaW4gdGhlIGVycm9yIHBhdGhzLCBy
YXRoZXIgdGhhbgo+ID4+Pj4gY29tcGxpY2F0ZSB0aGUgbm9ybWFsIGRhdGFwYXRoLgo+ID4+Pj4K
PiA+Pj4+IElzIGl0IHN1ZmZpY2llbnQgdG8gc3VwcHJlc3MgdGhlIGNhbGwgdG8gdmhvc3RfbmV0
X3VidWZfcHV0IGluIHRoZSBoYW5kbGVfdHgKPiA+Pj4+IHNlbmRtc2cgZXJyb3IgcGF0aCwgZ2l2
ZW4gdGhhdCB2aG9zdF96ZXJvY29weV9jYWxsYmFjayB3aWxsIGJlIGNhbGxlZCBvbgo+ID4+Pj4g
a2ZyZWVfc2tiPwo+ID4+PiBXZSBjYW4gbm90IGNhbGwga2ZyZWVfc2tiKCkgdW50aWwgdGhlIHNr
YiB3YXMgY3JlYXRlZC4KPiA+Pj4KPiA+Pj4+IE9yIGFsdGVybmF0aXZlbHkgY2xlYXIgdGhlIGRl
c3RydWN0b3IgaW4gZHJvcDoKPiA+Pj4gVGhlIHVhcmctPmNhbGxiYWNrKCkgaXMgY2FsbGVkIGlt
bWVkaWF0ZWx5IGFmdGVyIHdlIGRlY2lkZSBkbyBkYXRhY29weQo+ID4+PiBldmVuIGlmIGNhbGxl
ciB3YW50IHRvIGRvIHplcm9jb3B5LiBJZiBhbm90aGVyIGVycm9yIG9jY3VycyBsYXRlciwgdGhl
IHZob3N0Cj4gPj4+IGhhbmRsZV90eCgpIHdpbGwgdHJ5IHRvIGRlY3JlYXNlIGl0IGFnYWluLgo+
ID4+IE9oIHJpZ2h0LCBJIG1pc3NlZCB0aGUgZWxzZSBicmFuY2ggaW4gdGhpcyBwYXRoOgo+ID4+
Cj4gPj4gICAgICAgICAgLyogY29weSBza2JfdWJ1Zl9pbmZvIGZvciBjYWxsYmFjayB3aGVuIHNr
YiBoYXMgbm8gZXJyb3IgKi8KPiA+PiAgICAgICAgICBpZiAoemVyb2NvcHkpIHsKPiA+PiAgICAg
ICAgICAgICAgICAgIHNrYl9zaGluZm8oc2tiKS0+ZGVzdHJ1Y3Rvcl9hcmcgPSBtc2dfY29udHJv
bDsKPiA+PiAgICAgICAgICAgICAgICAgIHNrYl9zaGluZm8oc2tiKS0+dHhfZmxhZ3MgfD0gU0tC
VFhfREVWX1pFUk9DT1BZOwo+ID4+ICAgICAgICAgICAgICAgICAgc2tiX3NoaW5mbyhza2IpLT50
eF9mbGFncyB8PSBTS0JUWF9TSEFSRURfRlJBRzsKPiA+PiAgICAgICAgICB9IGVsc2UgaWYgKG1z
Z19jb250cm9sKSB7Cj4gPj4gICAgICAgICAgICAgICAgICBzdHJ1Y3QgdWJ1Zl9pbmZvICp1YXJn
ID0gbXNnX2NvbnRyb2w7Cj4gPj4gICAgICAgICAgICAgICAgICB1YXJnLT5jYWxsYmFjayh1YXJn
LCBmYWxzZSk7Cj4gPj4gICAgICAgICAgfQo+ID4+Cj4gPj4gU28gaWYgaGFuZGxlX3R4X3plcm9j
b3B5IGNhbGxzIHR1bl9zZW5kbXNnIHdpdGggdWJ1Zl9pbmZvIChhbmQgdGh1cyBhCj4gPj4gcmVm
ZXJlbmNlIHRvIHJlbGVhc2UpLCB0aGVyZSBhcmUgdGhlc2UgZml2ZSBvcHRpb25zOgo+ID4+Cj4g
Pj4gMS4gdHVuX3NlbmRtc2cgc3VjY2VlZHMsIHVidWZfaW5mbyBpcyBhc3NvY2lhdGVkIHdpdGgg
c2tiLgo+ID4+ICAgICAgIHJlZmVyZW5jZSByZWxlYXNlZCBmcm9tIGtmcmVlX3NrYiBjYWxsaW5n
IHZob3N0X3plcm9jb3B5X2NhbGxiYWNrIGxhdGVyCj4gPj4KPiA+PiAyLiB0dW5fc2VuZG1zZyBz
dWNjZWVkcywgdWJ1Zl9pbmZvIGlzIHJlbGVhc2VkIGltbWVkaWF0ZWx5LCBhcyBza2IgaXMKPiA+
PiBub3QgemVyb2NvcHkuCj4gPj4KPiA+PiAzLiB0dW5fc2VuZG1zZyBmYWlscyBiZWZvcmUgY3Jl
YXRpbmcgc2tiLCBoYW5kbGVfdHhfemVyb2NvcHkgY29ycmVjdGx5Cj4gPj4gY2xlYW5zIHVwIG9u
IHJlY2VpdmluZyBlcnJvciBmcm9tIHR1bl9zZW5kbXNnLgo+ID4+Cj4gPj4gNC4gdHVuX3NlbmRt
c2cgZmFpbHMgYWZ0ZXIgY3JlYXRpbmcgc2tiLCBidXQgd2l0aCBjb3B5aW5nOiBkZWNyZW1lbnRl
ZAo+ID4+IGF0IGJyYW5jaCBzaG93biBhYm92ZSArIGFnYWluIGluIGhhbmRsZV90eF96ZXJvY29w
eQo+ID4+Cj4gPj4gNS4gdHVuX3NlbmRtc2cgZmFpbHMgYWZ0ZXIgY3JlYXRpbmcgc2tiLCB3aXRo
IHplcm9jb3B5OiBkZWNyZW1lbnRlZCBhdAo+ID4+IGtmcmVlX3NrYiBpbiBkcm9wOiArIGFnYWlu
IGluIGhhbmRsZV90eF96ZXJvY29weQo+ID4+Cj4gPj4gU2luY2UgaGFuZGxlX3R4X3plcm9jb3B5
IGhhcyBubyBpZGVhIHdoZXRoZXIgb24gZXJyb3IgMywgNCBvciA1Cj4gPj4gb2NjdXJyZWQsCj4g
PiBBY3R1YWxseSwgaXQgZG9lcy4gSWYgc2VuZG1zZyByZXR1cm5zIGFuIGVycm9yLCBpdCBjYW4g
dGVzdCB3aGV0aGVyCj4gPiB2cS0+aGVhZHNbbnZxLT51cGVuZF9pZHhdLmxlbiAhPSBWSE9TVF9E
TUFfSU5fUFJPR1JFU1MuCj4KPgo+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB0aGlz
LiBBbnkgcmVhc29uIGZvciBpdCBjYW4ndCBiZQo+IFZIT1NUX0RNQV9JTl9QUk9HUkVTUyBoZXJl
PwoKSXQgY2FuIGJlLCBhbmQgaXQgd2lsbCBiZSBpZiB0dW5fc2VuZG1zZyByZXR1cm5zIEVJTlZB
TCBiZWZvcmUKYXNzaWduaW5nIHRoZSBza2IgZGVzdHJ1Y3Rvci4KCk9ubHkgaWYgdHVuX3NlbmRt
c2cgcmVsZWFzZWQgdGhlIHplcm9jb3B5IHN0YXRlIHRocm91Z2gKa2ZyZWVfc2tiLT52aG9zdF96
ZXJvY29weV9jYWxsYmFjayB3aWxsIGl0IGhhdmUgYmVlbiB1cGRhdGVkIHRvClZIT1NUX0RNQV9E
T05FX0xFTi4gQW5kIG9ubHkgdGhlbiBtdXN0IHRoZSBjYWxsZXIgbm90IHRyeSB0byByZWxlYXNl
CnRoZSBzdGF0ZSBhZ2Fpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
