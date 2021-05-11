Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8F2C433ED
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:24:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183336193F
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183336193F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9970E405AF;
	Tue, 11 May 2021 08:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fV9KxhDX7uw; Tue, 11 May 2021 08:24:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FD84405B6;
	Tue, 11 May 2021 08:24:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 565B1C000D;
	Tue, 11 May 2021 08:24:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7F84C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A156960703
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hEmDy8tf63t5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2DA16064A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:03 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 d3-20020a9d29030000b029027e8019067fso16792509otb.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8c3iY9QRs+Fk/AUUgLxZIXmDXwT2HDilLt2LH9nAQ6U=;
 b=SqBwnwM/kJAFlwEGwiDXj9c7Ma91fjZu8ayYoELqm6GAIraQZAPdhEQs9Hoyl60W7M
 9Ce+tx+Gq0OFiKUjBDFbh8nmAsNk3mVX8aqVUZ/0OUYvPd6aP9FxVuD8qcxKLUJqcJFj
 puE3BNalWBDmjJhF+s/HUDKh2qdbsPyxeVVBrifg/Hfyf/Ctj6UoSwML0EHIFaxkD+QY
 gm+xTm6+/oSes6XIfdyECwuy1wC3CzjtM0nDX3ec/4ay5/DjTSzzkuiH7noGXBu/Z66t
 4Pbpacn7kC8sS5PNmMjh0yzrPmqbjG8KPdHgYw9ca0CNg+In5D9zM8//YMnN6E18QQmV
 TvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8c3iY9QRs+Fk/AUUgLxZIXmDXwT2HDilLt2LH9nAQ6U=;
 b=MF9SkfgCLMKEz44BSU5qA1TxYMQKq5nMVNYIat+4b5HEoKRgcep0WANG0w+PAb9oQW
 rauxKQbEZdJfj0jUwJTHuCm/hBjznYwhywdpNYJL0qXTV3PXewjEXXqvbHKKI3+WzzxS
 uPjONvTXLHo3qxswVp/IH7tSnOGuMd+Y1ZjVQgkdzlm7QDczpZaMvxBlGxDA1AlHWGV0
 uGaVxxl03LJa/kLngZJiVcX+yGLngS2kzSkKAny9jPCO6+1ch/ruQQ9llBbuReZfGzGp
 EFX6b5G9FgN8rDXL/LJda5m+SKO9fweg8Suw6skETE01w9BiIhXbHVa1zrwvvDZHVZsv
 R8AA==
X-Gm-Message-State: AOAM532cd/ygy7BECLZDDyAxa6wE7oLANDN7xPTZv+WoK7jYBEPN46JN
 7dSKJi9EF2+sPPkWX9ViAhN1J+TXHScdhHXHpcI17g==
X-Google-Smtp-Source: ABdhPJyzEzyAj7Z5kcPuJk020RtLC8q4XOzVGi2sBCvpkZMkNcD6BbF/QWJXnNothiQ8DxWnWDUczdozPrAwgSSS7bA=
X-Received: by 2002:a05:6830:4103:: with SMTP id
 w3mr20687928ott.27.1620721442871; 
 Tue, 11 May 2021 01:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
 <0e31ea70-f12a-070e-c72b-6e1d337a89bc@redhat.com>
In-Reply-To: <0e31ea70-f12a-070e-c72b-6e1d337a89bc@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 11 May 2021 11:23:50 +0300
Message-ID: <CAOEp5Ofi52eCV1R261afkC2Oqgn5v8V6w3QQP8tHWcEiLmsUSQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgOTo0NyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8xMSDkuIvljYgxMjo0MiwgWXVyaSBCZW5k
aXRvdmljaCDlhpnpgZM6Cj4gPiBMYXJnZSBVRFAgcGFja2V0IHByb3ZpZGVkIGJ5IHRoZSBndWVz
dCB3aXRoIEdTTyB0eXBlIHNldCB0bwo+ID4gVklSVElPX05FVF9IRFJfR1NPX1VEUF9MNCB3aWxs
IGJlIGRpdmlkZWQgdG8gc2V2ZXJhbCBVRFAKPiA+IHBhY2tldHMgYWNjb3JkaW5nIHRvIHRoZSBn
c29fc2l6ZSBmaWVsZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZdXJpIEJlbmRpdG92aWNoIDx5
dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20+Cj4gPiAtLS0KPiA+ICAgaW5jbHVkZS9saW51eC92
aXJ0aW9fbmV0LmggfCA1ICsrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmggYi9pbmNs
dWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+ID4gaW5kZXggYjQ2NWY4ZjNlNTU0Li40ZWNmOWExY2E5
MTIgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgKPiA+IEBAIC01MSw2ICs1MSwxMSBAQCBzdGF0aWMg
aW5saW5lIGludCB2aXJ0aW9fbmV0X2hkcl90b19za2Ioc3RydWN0IHNrX2J1ZmYgKnNrYiwKPiA+
ICAgICAgICAgICAgICAgICAgICAgICBpcF9wcm90byA9IElQUFJPVE9fVURQOwo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIHRobGVuID0gc2l6ZW9mKHN0cnVjdCB1ZHBoZHIpOwo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gKyAgICAgICAgICAgICBjYXNlIFZJUlRJT19ORVRf
SERSX0dTT19VRFBfTDQ6Cj4gPiArICAgICAgICAgICAgICAgICAgICAgZ3NvX3R5cGUgPSBTS0Jf
R1NPX1VEUF9MNDsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBpcF9wcm90byA9IElQUFJPVE9f
VURQOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHRobGVuID0gc2l6ZW9mKHN0cnVjdCB1ZHBo
ZHIpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+Cj4KPiBUaGlzIGlzIG9ubHkg
Zm9yIHJ4LCBob3cgYWJvdXQgdHg/CgpJbiB0ZXJtcyBvZiB0aGUgZ3Vlc3QgdGhpcyBpcyBvbmx5
IGZvciBUWC4KR3Vlc3QgUlggaXMgYSBkaWZmZXJlbnQgdGhpbmcsIHRoaXMgaXMgYWN0dWFsbHkg
Y29hbGVzY2luZyBvZgpzZWdtZW50ZWQgVURQIHBhY2tldHMgaW50byBhIGxhcmdlIG9uZS4KVGhp
cyBmZWF0dXJlIGlzIG5vdCBkZWZpbmVkIGluIHRoZSB2aXJ0aW8gc3BlYyB5ZXQgYW5kIHRoZSBz
dXBwb3J0IG9mCml0IGZpcnN0IG9mIGFsbCBkZXBlbmRzIG9uIHRoZSBPUy4KRm9yIGV4YW1wbGU6
IFRDUCBMU08gKGd1ZXN0IFRYKSBpcyBzdXBwb3J0ZWQgYWxtb3N0IGJ5IGFsbCB0aGUKdmVyc2lv
bnMgb2YgV2luZG93cy4KVENQIFJTQyAoY29hbGVzY2luZyBvZiBUQ1Agc2VnbWVudHMpIGlzIHN1
cHBvcnRlZCBieSBXaW4gOCAvIFNlcnZlciAyMDEyIGFuZCB1cC4KVURQIHNlZ21lbnRhdGlvbiBp
cyBzdXBwb3J0ZWQgYnkgV2luZG93cyBrZXJuZWxzIDE5MDMrClVEUCBjb2FsZXNjaW5nIGlzIGRl
ZmluZWQgYnkgV2luZG93cyBrZXJuZWxzIDIwMDQrIGFuZCBub3Qgc3VwcG9ydGVkCmJ5IHRoZSBk
cml2ZXIgeWV0LgoKPgo+IFRoYW5rcwo+Cj4KPgo+ID4gICAgICAgICAgICAgICBkZWZhdWx0Ogo+
ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gICAgICAgICAgICAg
ICB9Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
