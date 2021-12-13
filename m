Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF7EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 23:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12A2A8135C;
	Mon, 13 Dec 2021 23:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3x3uSRH1LRSi; Mon, 13 Dec 2021 23:57:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B479381354;
	Mon, 13 Dec 2021 23:57:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83050C001E;
	Mon, 13 Dec 2021 23:57:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93191C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D264403E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uDdMDPLgM2ok
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:57:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92BDB4013D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639439867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itrWj/FNXzyg2IvEE5KBOWVxQH40piGIDy+/PNdSvak=;
 b=FL/u9IdbQdlicwLzUau6Yhsfntj2AGTFusIcIQB1sq0mfyaD+BwAMdD9TdeahsapgejQHV
 4YHmeIIYH26z91TnUndjZPKPhPniP6w0E95IIvGHEjxC8ysGrsTgP43Ie9S39hEFu2ssi8
 vsw/sxqr/W8ilJs+7taxAkSYhhMEpB4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-2bnRihgSNa-cyAYmom7rCw-1; Mon, 13 Dec 2021 18:57:41 -0500
X-MC-Unique: 2bnRihgSNa-cyAYmom7rCw-1
Received: by mail-wm1-f70.google.com with SMTP id
 a85-20020a1c7f58000000b0033ddc0eacc8so12319682wmd.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 15:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=itrWj/FNXzyg2IvEE5KBOWVxQH40piGIDy+/PNdSvak=;
 b=iBOTSV79TdJSa5m6B6n/Qk5ZUDrR426Mg6kM5Yxllx0OnUJL56brLrHZy0XlAcn5gK
 61sLnZjUK9etsAUzTZgA86teiu6TuCgU83nXDzdzvSEW8yunIJuzvsqTber1HdhuhgcD
 h6kkXXOeO/2kWnS3TR+IWEzC3MqUDuqzdPyHVv8BRSh7gnun/xbFpphr1lrh+0ZZZl7e
 tCuC5fPXh+0PBvfjCKWFTOXnu1qCLDe7v3k2pDDBHCO0YHOC0viPnZdzrKxl8334yIrY
 KFb99hbDigktiyzTDf1RPrlff9p/MyMDvkpSM6VmGmZb+OIisA0q3ruk9n/Vs2JaXefN
 yONg==
X-Gm-Message-State: AOAM531CXE5/A2RG2WY4fBxd7igawSx31bfz/9+N1ce408/iB8opWldy
 +Ql5GutgtQBcxxpQPPA1lq0WR7KSqlvjlL7O13zeKzMzB4jucIVsWW8uRZTckFCXdgvPAgYTEwP
 A1fe1KJDzVmT/TA9nknqYeyp6OS+GmDt7hrvxn2JtLQ==
X-Received: by 2002:adf:e484:: with SMTP id i4mr1813512wrm.49.1639439860255;
 Mon, 13 Dec 2021 15:57:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/Pj4Z/yXyapvNcqdg05CqU9fiI6m5P/+rM1Krrug9bUUnGSeBImkdL/PcJ3lT1z6hNseTtw==
X-Received: by 2002:adf:e484:: with SMTP id i4mr1813502wrm.49.1639439860103;
 Mon, 13 Dec 2021 15:57:40 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207d:b931:2ce5:ef76:2d17:5466])
 by smtp.gmail.com with ESMTPSA id v9sm10203463wrb.107.2021.12.13.15.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 15:57:39 -0800 (PST)
Date: Mon, 13 Dec 2021 18:57:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211213185620-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211213054357-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
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

T24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMDU6NDQ6MTNBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIFRodSwgRGVjIDA5LCAyMDIxIGF0IDA0OjIyOjU4UE0gLTA1MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+IE9uIFRodSwgTm92IDI1LCAyMDIxIGF0IDA5OjAy
OjAxUE0gKzAxMDAsIE1hcmNlbCBIb2x0bWFubiB3cm90ZToKPiA+ID4gSGkgTWljaGFlbCwKPiA+
ID4gCj4gPiA+ID4gRGV2aWNlIHJlbW92YWwgaXMgY2xlYXJseSBvdXQgb2YgdmlydGlvIHNwZWM6
IGl0IGF0dGVtcHRzIHRvIHJlbW92ZQo+ID4gPiA+IHVudXNlZCBidWZmZXJzIGZyb20gYSBWUSBi
ZWZvcmUgaW52b2tpbmcgZGV2aWNlIHJlc2V0LiBUbyBmaXgsIG1ha2UKPiA+ID4gPiBvcGVuL2Ns
b3NlIE5PUHMgYW5kIGRvIGFsbCBjbGVhbnVwL3NldHVwIGluIHByb2JlL3JlbW92ZS4KPiA+ID4g
Cj4gPiA+IHNvIHRoZSB2aXJ0YnRfe29wZW4sY2xvc2V9IGFzIE5PUCBpcyBub3QgcmVhbGx5IHdo
YXQgYSBkcml2ZXIgaXMgc3VwcG9zZQo+ID4gPiB0byBiZSBkb2luZy4gVGhlc2UgYXJlIHRyYW5z
cG9ydCBlbmFibGUvZGlzYWJsZSBjYWxsYmFja3MgZnJvbSB0aGUgQlQKPiA+ID4gQ29yZSB0b3dh
cmRzIHRoZSBkcml2ZXIuIEl0IG1hcHMgdG8gYSBkZXZpY2UgYmVpbmcgZW5hYmxlZC9kaXNhYmxl
ZCBieQo+ID4gPiBzb21ldGhpbmcgbGlrZSBibHVldG9vdGhkIGZvciBleGFtcGxlLiBTbyBpZiBk
aXNhYmxlZCwgSSBleHBlY3QgdGhhdCBubwo+ID4gPiByZXNvdXJjZXMvcXVldWVzIGFyZSBpbiB1
c2UuCj4gPiA+IAo+ID4gPiBNYXliZSBJIG1pc3VuZGVyc3RhbmQgdGhlIHZpcnRpbyBzcGVjIGlu
IHRoYXQgcmVnYXJkLCBidXQgSSB3b3VsZCBsaWtlCj4gPiA+IHRvIGtlZXAgdGhpcyBmdW5kYW1l
bnRhbCBjb25jZXB0IG9mIGEgQmx1ZXRvb3RoIGRyaXZlci4gSXQgZG9lcyB3b3JrCj4gPiA+IHdp
dGggYWxsIG90aGVyIHRyYW5zcG9ydHMgbGlrZSBVU0IsIFNESU8sIFVBUlQgZXRjLgo+ID4gPiAK
PiA+ID4gPiBUaGUgY29zdCBoZXJlIGlzIGEgc2luZ2xlIHNrYiB3YXN0ZWQgb24gYW4gdW51c2Vk
IGJ0IGRldmljZSAtIHdoaWNoCj4gPiA+ID4gc2VlbXMgbW9kZXN0Lgo+ID4gPiAKPiA+ID4gVGhl
cmUgc2hvdWxkIGJlIG5vIGJ1ZmZlciB1c2VkIGlmIHRoZSBkZXZpY2UgaXMgcG93ZXJlZCBvZmYu
IFdlIGFsc28gZG9u4oCZdAo+ID4gPiBoYXZlIGFueSBVU0IgVVJCcyBpbi1mbGlnaHQgaWYgdGhl
IHRyYW5zcG9ydCBpcyBub3QgYWN0aXZlLgo+ID4gPiAKPiA+ID4gPiBOQjogd2l0aCB0aGlzIGZp
eCBpbiBwbGFjZSBkcml2ZXIgc3RpbGwgc3VmZmVycyBmcm9tIGEgcmFjZSBjb25kaXRpb24gaWYK
PiA+ID4gPiBhbiBpbnRlcnJ1cHQgdHJpZ2dlcnMgd2hpbGUgZGV2aWNlIGlzIGJlaW5nIHJlc2V0
LiBXb3JrIG9uIGEgZml4IGZvcgo+ID4gPiA+IHRoYXQgaXNzdWUgaXMgaW4gcHJvZ3Jlc3MuCj4g
PiA+IAo+ID4gPiBJbiB0aGUgdmlydGJ0X2Nsb3NlKCkgY2FsbGJhY2sgd2Ugc2hvdWxkIGRlYWN0
aXZhdGUgYWxsIGludGVycnVwdHMuCj4gPiA+IAo+ID4gPiBSZWdhcmRzCj4gPiA+IAo+ID4gPiBN
YXJjZWwKPiA+IAo+ID4gU28gTWFyY2VsLCBkbyBJIHJlYWQgaXQgcmlnaHQgdGhhdCB5b3UgYXJl
IHdvcmtpbmcgb24gYSBmaXgKPiA+IGFuZCBJIGNhbiBkcm9wIHRoaXMgcGF0Y2ggZm9yIG5vdz8K
PiAKPiBwaW5nCgoKSWYgSSBkb24ndCBoZWFyIG90aGVyd2lzZSBJJ2xsIHF1ZXVlIG15IHZlcnNp
b24gLSBpdCBtaWdodCBub3QKYmUgaWRlYWwgYnV0IGl0IGF0IGxlYXN0IGRvZXMgbm90IHZpb2xh
dGUgdGhlIHNwZWMuCldlIGNhbiB3b3JrIG9uIG5vdCBhbGxvY2F0aW5nL2ZyZWVpbmcgYnVmZmVy
cyBsYXRlcgphcyBhcHByb3ByaWF0ZS4KCj4gPiAtLSAKPiA+IE1TVAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
