Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F6FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 05:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E4E561057;
	Wed, 30 Mar 2022 05:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W53kASCSOo2o; Wed, 30 Mar 2022 05:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 245A86104B;
	Wed, 30 Mar 2022 05:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECFBEC002C;
	Wed, 30 Mar 2022 05:22:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36C9EC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1646F8452F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUmrDrpKIZPh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6335684368
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 05:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648617743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73+ha/vkBm7xxOmMxZvMhcq9V/8gU/hzN5hUEp6SUC0=;
 b=VoLB9ziFvKUdp417MWWO2iPYNiBHo6d8/fYmpP1B8YlX9+sGPcxsoRVG/yQqkT6i0HWGSg
 WL5ohowaFo15vQrfLYn+b08h+obSfX7N717LKeCIgZbCgDwg1AVL5vVtF/fW1aycqIvwMJ
 wP0I1/5T5nDPo3zCocYSTiu1ldBF2n8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-NWnYzgMBM_e9zRBkBGt7ng-1; Wed, 30 Mar 2022 01:22:21 -0400
X-MC-Unique: NWnYzgMBM_e9zRBkBGt7ng-1
Received: by mail-wr1-f72.google.com with SMTP id
 j67-20020adf9149000000b00203e6b7d151so5522563wrj.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 22:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=73+ha/vkBm7xxOmMxZvMhcq9V/8gU/hzN5hUEp6SUC0=;
 b=akpjXXSI8u2jNoIRYWv5v5h92/BTwQr5+CPb0YcwY8OgnOaskhWR/cAupyIY3TWtNc
 Wv0VjZvNGV3tn5wWAddmZO7bMV0cwsBl8bj9cNxAhte9/bqVnO6YgGJLIDc8hhqAN4dN
 42M+ZkzBMahORbP/9Zhf7pJdqnaFhhzDJfohNp2mGl0HlA6qMKc0q9xFr6a+bzGeQkuN
 1qlEwtSUDhM/lQIkOcTW1AyrMe53Ltk4pTBbbrI1LTAAwpV4vfqlSkgJ/RhjepGlmKSC
 CQSwHRSFO2QsAr3ahSdIMMrfeMR9GE9ffyECc1L7v0hV+CwhdZj04/B6CORnq8AP0CkW
 y2wQ==
X-Gm-Message-State: AOAM530Bo50jcnvyIpFiM8R+Ld7GCd78ksHoxFL6EllMX1V+OitbA/tq
 Ul/zj4a2smwI4Vn2p3z5aimLpw581Yp6lfvOWMfS75Q0+58cuMkXn2wYKN757d7t+9BFKlA0UoM
 x7p0DjDc7EXER5jvoZYK/aoWdmmuZSD1vsR45Iv74+Q==
X-Received: by 2002:a05:600c:4ec9:b0:38b:f1fd:b6b9 with SMTP id
 g9-20020a05600c4ec900b0038bf1fdb6b9mr2613646wmq.7.1648617740387; 
 Tue, 29 Mar 2022 22:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhZNA71rh4p3gznLJEzepRF8Cf0lFbyruap5Iy8lNQ71ai2JE9ehQlS8ISFWRukJV+gCHPgQ==
X-Received: by 2002:a05:600c:4ec9:b0:38b:f1fd:b6b9 with SMTP id
 g9-20020a05600c4ec900b0038bf1fdb6b9mr2613631wmq.7.1648617740126; 
 Tue, 29 Mar 2022 22:22:20 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 m2-20020a1c2602000000b0038ca9ffac53sm3730095wmm.11.2022.03.29.22.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 22:22:19 -0700 (PDT)
Date: Wed, 30 Mar 2022 01:22:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220330012204-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
 <20220324070612-mutt-send-email-mst@kernel.org>
 <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
 <81381018-9dcd-3fba-becf-183435a5bf6b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81381018-9dcd-3fba-becf-183435a5bf6b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

T24gRnJpLCBNYXIgMjUsIDIwMjIgYXQgMTE6MDU6MjJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi8zLzI0IOS4i+WNiDc6MzEsIFN0ZWZhbm8gR2FyemFyZWxsYSDlhpnp
gZM6Cj4gPiBPbiBUaHUsIE1hciAyNCwgMjAyMiBhdCAwNzowNzowOUFNIC0wNDAwLCBNaWNoYWVs
IFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0IDEyOjAzOjA3
UE0gKzAxMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4gPiBPbiBUaHUsIE1hciAy
NCwgMjAyMiBhdCAwNjo0ODowNUFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4g
PiA+ID4gPiBPbiBUaHUsIE1hciAyNCwgMjAyMiBhdCAwNDo0MDowMlBNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiA+ID4gPiBGcm9tOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJl
QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoaXMgYXZvaWRzIHNldHRpbmcg
RFJJVkVSX09LIHR3aWNlIGZvciB0aG9zZSBkcml2ZXJzIHRoYXQgY2FsbAo+ID4gPiA+ID4gPiB2
aXJ0aW9fZGV2aWNlX3JlYWR5KCkgaW4gdGhlIC5yZXN0b3JlCj4gPiA+ID4gPgo+ID4gPiA+ID4g
SXMgdGhpcyB0cnlpbmcgdG8gc2F5IGl0J3MgZmFzdGVyPwo+ID4gPiA+IAo+ID4gPiA+IE5vcGUs
IEkgbWVhbiwgd2hlbiBJIHdyb3RlIHRoZSBvcmlnaW5hbCB2ZXJzaW9uLCBJIG1lYW50IHRvIGRv
IHRoZSBzYW1lCj4gPiA+ID4gdGhpbmdzIHRoYXQgd2UgZG8gaW4gdmlydGlvX2Rldl9wcm9iZSgp
IHdoZXJlIHdlIGNhbGxlZAo+ID4gPiA+IHZpcnRpb19kZXZpY2VfcmVhZHkoKSB3aGljaCBub3Qg
b25seSBzZXQgdGhlIHN0YXRlLCBidXQgYWxzbyBjYWxsZWQKPiA+ID4gPiAuZW5hYmxlX2NicyBj
YWxsYmFjay4KPiA+ID4gPiAKPiA+ID4gPiBXYXMgdGhpcyBhIHNpZGUgZWZmZWN0IGFuZCBtYXli
ZSBtb3JlIGNvbXBsaWFudCB3aXRoIHRoZSBzcGVjPwo+ID4gPiAKPiA+ID4gCj4gPiA+IFNvcnJ5
IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24uIGl0IHNheXMgImF2b2lkcyBzZXR0aW5n
Cj4gPiA+IERSSVZFUl9PSyB0d2ljZSIgLQo+ID4gPiB3aHkgaXMgdGhhdCBhZHZhbnRhZ2VvdXMg
YW5kIHdvcnRoIGNhbGxpbmcgb3V0IGluIHRoZSBjb21taXQgbG9nPwo+ID4gCj4gPiBJIGp1c3Qg
d2FudGVkIHRvIHNheSB0aGF0IGl0IHNlZW1zIHN0cmFuZ2UgdG8gc2V0IERSSVZFUl9PSyB0d2lj
ZSBpZiB3ZQo+ID4gcmVhZCB0aGUgc3BlYy4gSSBkb24ndCB0aGluayBpdCdzIHdyb25nLCBidXQg
d2VpcmQuCj4gPiAKPiA+IFllcywgbWF5YmUgd2Ugc2hvdWxkIHJld3JpdGUgdGhlIGNvbW1pdCBt
ZXNzYWdlIHNheWluZyB0aGF0IHdlIHdhbnQgdG8KPiA+IHVzZSB2aXJ0aW9fZGV2aWNlX3JlYWR5
KCkgZXZlcnl3aGVyZSB0byBjb21wbGV0ZSB0aGUgc2V0dXAgYmVmb3JlCj4gPiBzZXR0aW5nIERS
SVZFUl9PSyBzbyB3ZSBjYW4gZG8gYWxsIHRoZSBuZWNlc3Nhcnkgb3BlcmF0aW9ucyBpbnNpZGUg
KGxpa2UKPiA+IGluIHBhdGNoIDMgb3IgY2FsbCBlbmFibGVfY2JzKS4KPiA+IAo+ID4gSmFzb24g
cmV3cm90ZSB0aGUgY29tbWl0IGxvZywgc28gSSBkb24ndCBrbm93IGlmIGhlIGFncmVlcy4KPiA+
IAo+ID4gVGhhbmtzLAo+ID4gU3RlZmFubwo+IAo+IAo+IEkgYWdyZWUsIEkgd2lsbCB0d2VhayB0
aGUgbG9nIGluIFYyLgo+IAo+IFRoYW5rcwoKU3RpbGwgd2FpdGluZyBmb3IgdGhhdCB2Mi4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
