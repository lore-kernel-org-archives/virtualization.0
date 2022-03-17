Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E597C433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 02:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E500C40AEA;
	Thu, 17 Mar 2022 02:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwNUzdIvOz5J; Thu, 17 Mar 2022 02:20:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4EDB340111;
	Thu, 17 Mar 2022 02:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31BE7C001A;
	Thu, 17 Mar 2022 02:20:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95837C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 02:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8415561247
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 02:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 56SsMRf2uK5o
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 02:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A413260769
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 02:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647483619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPCfzxyjMhxLP4qSRwQ+hURc5goubZq4R+xZPtQNplE=;
 b=FZh+BFUO7Y9ZW6k1zK66mexuOBvAvp8u5RtYhqLoIK+dmTm8rraxj/QdjA6OLGlwBNE5qJ
 kv0DBo6XlO6dlM8W+WEfcq7YzLSBI1VgblRFkhuc3jHy8+ux4RZ7xhv4cDeIcY8cW9+nF5
 0GvrynipnkP1OxvGPGZobaw3nT+XwJg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-ZNXNu6F7PKqxZU38gfuKjg-1; Wed, 16 Mar 2022 22:20:18 -0400
X-MC-Unique: ZNXNu6F7PKqxZU38gfuKjg-1
Received: by mail-lj1-f197.google.com with SMTP id
 o8-20020a2e9448000000b00246133c54deso1567214ljh.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nPCfzxyjMhxLP4qSRwQ+hURc5goubZq4R+xZPtQNplE=;
 b=dDMGOLGn2UEQ1eApexwALCW68rNCIM9QmT6vrbN6NkF91Vy8R0+275+ASr4CBH38M9
 B+PE+EG8aMFG4Pm9ve/fXeavc6XauM7UdGKZ0QO98HCG/WSUqjJ5/ABuDJx47XlMTMef
 R+0d6s47sxl1xR57nvzpuXWBs3qxJMfHvBW+MGj1ZKARDlwzpv6gOH6ytUtWmSu3is4F
 hLADMCnEw4eY5FvYy9TK0ejgD/kQ8hgbvqZ12vop1QQY+ingimnAycrIuE1rP8BMbUxN
 9WoUURR7emyp90oWk0Yl5JrWFJL3daD8HXJ4bXF8HczH4AFrNCZMR/iKVz1xpP4BBkbb
 WNkw==
X-Gm-Message-State: AOAM532y5b4B+8HRarvDLp1fNCjzV7rZQZeha5qrLXybV0NNhTsq9BAq
 zzKzUyweDwKiXIuTijOB6JYvDPVgLMmAvgox9HDQ5wWpNuFjlOi717ypDhWBsJa8hqSjZijfSWl
 lmZy8w31xQkul04bTXvk+T8QjivTLkzmaI8gnNm6uSGf8WnCrE6SWAD8W1g==
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id
 b35-20020a05651c0b2300b00247ee17e9edmr1466188ljr.243.1647483616427; 
 Wed, 16 Mar 2022 19:20:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBCg7wlhjy6Rcdi31sE5bb7ELPAmbhPDTsbU5Jc7PjWTT/34HozDuP3hNEXZTNkG2RGvy9B9CMVr5KB2Cun9k=
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id
 b35-20020a05651c0b2300b00247ee17e9edmr1466175ljr.243.1647483616214; Wed, 16
 Mar 2022 19:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
 <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
 <YjIDIjUwuwkfRS2d@localhost.localdomain>
In-Reply-To: <YjIDIjUwuwkfRS2d@localhost.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Mar 2022 10:20:05 +0800
Message-ID: <CACGkMEu8T8_9gJMGybMZVCT9zCrw+OaTtbhtvnUNUORNmYKw-A@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
To: Suwan Kim <suwan.kim027@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 pbonzini <pbonzini@redhat.com>
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

T24gV2VkLCBNYXIgMTYsIDIwMjIgYXQgMTE6MzMgUE0gU3V3YW4gS2ltIDxzdXdhbi5raW0wMjdA
Z21haWwuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgTWFyIDE2LCAyMDIyIGF0IDEwOjAyOjEzQU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIE1hciAxNSwgMjAyMiBhdCAxMDo0
MyBQTSBTdXdhbiBLaW0gPHN1d2FuLmtpbTAyN0BnbWFpbC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBUdWUsIE1hciAxNSwgMjAyMiBhdCAwNDo1OToyM1BNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIE1vbiwgTWFyIDE0LCAyMDIyIGF0IDg6MzMgUE0gU3V3YW4gS2ltIDxz
dXdhbi5raW0wMjdAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+ID4gT24gTW9uLCBN
YXIgMTQsIDIwMjIgYXQgMDI6MTQ6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4g5ZyoIDIwMjIvMy8xMSDkuIvljYgxMToyOCwgU3V3YW4gS2ltIOWG
memBkzoKPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRp
b19ibGsuaAo+ID4gPiA+ID4gYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2Jsay5oCj4gPiA+
ID4gPiA+ID4gaW5kZXggZDg4OGYwMTNkOWZmLi4zZmNhZjkzN2FmZTEgMTAwNjQ0Cj4gPiA+ID4g
PiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaAo+ID4gPiA+ID4gPiA+
ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmgKPiA+ID4gPiA+ID4gPiBAQCAt
MTE5LDggKzExOSw5IEBAIHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyB7Cj4gPiA+ID4gPiA+ID4g
ICAgICAqIGRlYWxsb2NhdGlvbiBvZiBvbmUgb3IgbW9yZSBvZiB0aGUgc2VjdG9ycy4KPiA+ID4g
PiA+ID4gPiAgICAgICovCj4gPiA+ID4gPiA+ID4gICAgIF9fdTggd3JpdGVfemVyb2VzX21heV91
bm1hcDsKPiA+ID4gPiA+ID4gPiArICAgX191OCB1bnVzZWQxOwo+ID4gPiA+ID4gPiA+IC0gICBf
X3U4IHVudXNlZDFbM107Cj4gPiA+ID4gPiA+ID4gKyAgIF9fdmlydGlvMTYgbnVtX3BvbGxfcXVl
dWVzOwo+ID4gPiA+ID4gPiA+ICAgfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhpcyBsb29rcyBsaWtlIGEgaW1wbGVtZW50YXRp
b24gc3BlY2lmaWMgKHZpcnRpby1ibGstcGNpKSBvcHRpbWl6YXRpb24sCj4gPiA+ID4gPiBob3cK
PiA+ID4gPiA+ID4gYWJvdXQgb3RoZXIgaW1wbGVtZW50YXRpb24gbGlrZSB2aG9zdC11c2VyLWJs
az8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIGRpZG7igJl0IGNvbnNpZGVyIHZob3N0LXVzZXItYmxr
IHlldC4gQnV0IGRvZXMgdmhvc3QtdXNlci1ibGsgYWxzbwo+ID4gPiA+ID4gdXNlIHZyaXRpb19i
bGtfY29uZmlnIGFzIGtlcm5lbC1xZW11IGludGVyZmFjZT8KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiBZZXMsIGJ1dCBzZWUgYmVsb3cuCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
PiA+IERvZXMgdmhvc3QtdXNlci1ibGsgbmVlZCBhZGRpdGlvbmFsIG1vZGlmaWNhdGlvbiB0byBz
dXBwb3J0IHBvbGxpbmcKPiA+ID4gPiA+IGluIGtlcm5lbCBzaWRlPwo+ID4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gTm8sIGJ1dCB0aGUgaXNzdWUgaXMsIHRoaW5ncyBsaWtlIHBvbGxp
bmcgbG9va3Mgbm90IGEgZ29vZCBjYW5kaWRhdGUgZm9yCj4gPiA+ID4gdGhlIGF0dHJpYnV0ZXMg
YmVsb25naW5nIHRvIHRoZSBkZXZpY2UgYnV0IHRoZSBkcml2ZXIuIFNvIEkgaGF2ZSBtb3JlCj4g
PiA+ID4gcXVlc3Rpb25zOgo+ID4gPiA+Cj4gPiA+ID4gMSkgd2hhdCBkb2VzIGl0IHJlYWxseSBt
ZWFuIGZvciBoYXJkd2FyZSB2aXJ0aW8gYmxvY2sgZGV2aWNlcz8KPiA+ID4gPiAyKSBEb2VzIGRy
aXZlciBwb2xsaW5nIGhlbHAgZm9yIHRoZSBxZW11IGltcGxlbWVudGF0aW9uIHdpdGhvdXQgcG9s
bGluZz8KPiA+ID4gPiAzKSBVc2luZyBibGtfY29uZmlnIG1lYW5zIHdlIGNhbiBvbmx5IGdldCB0
aGUgYmVuZWZpdCBmcm9tIHRoZSBuZXcgZGV2aWNlCj4gPiA+Cj4gPiA+IDEpIHdoYXQgZG9lcyBp
dCByZWFsbHkgbWVhbiBmb3IgaGFyZHdhcmUgdmlydGlvIGJsb2NrIGRldmljZXM/Cj4gPiA+IDMp
IFVzaW5nIGJsa19jb25maWcgbWVhbnMgd2UgY2FuIG9ubHkgZ2V0IHRoZSBiZW5lZml0IGZyb20g
dGhlIG5ldyBkZXZpY2UKPiA+ID4KPiA+ID4gVGhpcyBwYXRjaCBhZGRzIGRlZGljYXRlZCBIVyBx
dWV1ZSBmb3IgcG9sbGluZyBwdXJwb3NlIHRvIHZpcnRpbwo+ID4gPiBibG9jayBkZXZpY2UuCj4g
PiA+Cj4gPiA+IFNvIEkgdGhpbmsgaXQgY2FuIGJlIGEgbmV3IGh3IGZlYXR1cmUuIEFuZCBpdCBj
YW4gYmUgYSBuZXcgZGV2aWNlCj4gPiA+IHRoYXQgc3VwcG9ydHMgaHcgcG9sbCBxdWV1ZS4KPiA+
Cj4gPiBPbmUgcG9zc2libGUgaXNzdWUgaXMgdGhhdCB0aGUgInBvbGwiIGxvb2tzIG1vcmUgbGlr
ZSBhCj4gPiBzb2Z0d2FyZS9kcml2ZXIgY29uY2VwdCBvdGhlciB0aGFuIHRoZSBkZXZpY2UvaGFy
ZHdhcmUuCj4gPgo+ID4gPgo+ID4gPiBCVFcsIEkgaGF2ZSBvdGhlciBpZGVhIGFib3V0IGl0Lgo+
ID4gPgo+ID4gPiBIb3cgYWJvdXQgYWRkaW5nIOKAnG51bS1wb2xsLXF1ZXVlcyIgcHJvcGVydHkg
YXMgYSBkcml2ZXIgcGFyYW1ldGVyCj4gPiA+IGxpa2UgTlZNZSBkcml2ZXIsIG5vdCB0byBRRU1V
IHZpcnRpby1ibGstcGNpIHByb3BlcnR5Pwo+ID4KPiA+IEl0IHNob3VsZCBiZSBmaW5lLCBidXQg
d2UgbmVlZCB0byBsaXN0ZW4gdG8gb3RoZXJzLgo+Cj4gVG8gTWljaGFlbCwgU3RlZmFuLCBNYXgK
Pgo+IEhvdyBhYm91dCB1c2luZyBkcml2ZXIgcGFyYW1ldGVyIGluc3RlYWQgb2YgdmlyaW9fYmxr
X2NvbmZpZz8KCkkgYWdyZWUuCgpUaGFua3MKCj4KPiBSZWdhcmRzLAo+IFN1d2FuIEtpbQo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
