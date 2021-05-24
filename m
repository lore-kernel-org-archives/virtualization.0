Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F5BC04FF3
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 09:10:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4889610C7
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 09:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4889610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AFE8400FB;
	Mon, 24 May 2021 09:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBAu27C-kRzL; Mon, 24 May 2021 09:10:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D86D3400A7;
	Mon, 24 May 2021 09:10:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1AB1C000E;
	Mon, 24 May 2021 09:10:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 566E0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 303C082EB6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lf5sIN34lzAq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:10:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31BB482E54
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621847408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3wSqyBZrZuWAaUg/+zzbLh1KHxQeq+UhWJvXbU1jvM=;
 b=AlKYOTit7QdKTH4xp0I2aUzjmLumLBa9NekYBeAk0C1QQOHlle9RWRIM9lYBM5RzKtl48I
 24E6TH0UAfx/w1JSR0Uu1jKejbFTkjDODNIBw4gCUypFEdY6zpZu4gZOsKhe5bwSh68/pj
 RAF0nL1qEsT+3rbv2hf0aHUQ8AuCe7U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-bv57qokMMu29F3oTz4sb2g-1; Mon, 24 May 2021 05:10:04 -0400
X-MC-Unique: bv57qokMMu29F3oTz4sb2g-1
Received: by mail-wm1-f70.google.com with SMTP id
 g9-20020a1c39090000b029017545f2da89so3760718wma.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=L3wSqyBZrZuWAaUg/+zzbLh1KHxQeq+UhWJvXbU1jvM=;
 b=Vi8S51xCBTvYk5uIBSlznHjARopImddh0NJmJhSDGG5ArivMRGStt16akhl2mJKSga
 eBBuggUAEGJuAefQpWvxHkDDPt9y6h9HZ9lGA2wR/p7j4YDXHhXVdztqPcY++km4c2Gw
 BdqVxS/fbv1Kd2ZWVtL3vd3azmFG+YZkDHPvE0tsLqHUQYlbrXsedtpAH4ZCFBLwFZFv
 9xbDI93QWWP/DO6wb7BSZoepT0oNWSqMz+hULJ32qHi1wCt8ShsdTKk+3qu/l+qXPfSZ
 JyprFypGbfCl+g+l6VU5wqOn91odZ3mMQOs/+MM1Qu8wi79YS0zZlVTFQTVN34jULG9b
 sHfw==
X-Gm-Message-State: AOAM53391Y5ABgLVXkrlSyB+ZKkxbqyjDGtE/SV/F/ylpl9QQT8ENTxu
 H+DssrkS1ijBa2gRBgOrKVJPgTkL8OVy1WghqZODnXQJ+YdnlEo4p60OeJa47PjsbUAh7cDtFuo
 ZhXZ0kKGcENxmsUitXHIABpOdQJD0yV9KeAs2yj/ALQ==
X-Received: by 2002:adf:f04f:: with SMTP id t15mr20315411wro.377.1621847403769; 
 Mon, 24 May 2021 02:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytbecMYMOBl3tQdN/Kb27iSiGCSiu57Cvca61WWGiciWSVF/D85dYw2RXxPRqM5ZPPEiFVYQ==
X-Received: by 2002:adf:f04f:: with SMTP id t15mr20315393wro.377.1621847403598; 
 Mon, 24 May 2021 02:10:03 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
 by smtp.gmail.com with ESMTPSA id w25sm7397924wmk.25.2021.05.24.02.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 02:10:02 -0700 (PDT)
Date: Mon, 24 May 2021 05:10:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: virtio_net: BQL?
Message-ID: <20210524050840-mutt-send-email-mst@kernel.org>
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
 <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
 <CA+FuTSf0Af2RXEG=rCthNNEb5mwKTG37gpEBBZU16qKkvmF=qw@mail.gmail.com>
 <CAA93jw7Vr_pFMsPCrPadqaLGu0BdC-wtCmW2iyHFkHERkaiyWQ@mail.gmail.com>
 <a3a9b036-14d1-2f4f-52e6-f0aa1b187003@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a3a9b036-14d1-2f4f-52e6-f0aa1b187003@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Xianting Tian <xianting.tian@linux.alibaba.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Dave Taht <dave.taht@gmail.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 bloat <bloat@lists.bufferbloat.net>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>
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

T24gTW9uLCBNYXkgMjQsIDIwMjEgYXQgMTA6NTM6MDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS81LzE4IOS4iuWNiDU6NDgsIERhdmUgVGFodCDlhpnpgZM6Cj4gPiBP
biBNb24sIE1heSAxNywgMjAyMSBhdCAxOjIzIFBNIFdpbGxlbSBkZSBCcnVpam4KPiA+IDx3aWxs
ZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCBNYXkgMTcs
IDIwMjEgYXQgMjo0NCBQTSBEYXZlIFRhaHQgPGRhdmUudGFodEBnbWFpbC5jb20+IHdyb3RlOgo+
ID4gPiA+IE5vdCByZWFsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLCBidXQgaXMgdGhlcmUgc29t
ZSByZWFzb24gd2h5IHZpcnRpbwo+ID4gPiA+IGhhcyBubyBzdXBwb3J0IGZvciBCUUw/Cj4gPiA+
IFRoZXJlIGhhdmUgYmVlbiBhIGZldyBhdHRlbXB0cyB0byBhZGQgaXQgb3ZlciB0aGUgeWVhcnMu
Cj4gPiA+IAo+ID4gPiBNb3N0IHJlY2VudGx5LCBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMTgxMjA1MjI1MzIzLjEyNTU1LTItbXN0QHJlZGhhdC5jb20vCj4gPiA+IAo+ID4gPiBUaGF0
IHRocmVhZCBoYXMgYSBsb25nIGRpc2N1c3Npb24uIEkgdGhpbmsgdGhlIGtleSBvcGVuIGlzc3Vl
IHJlbWFpbnMKPiA+ID4gCj4gPiA+ICJUaGUgdHJpY2t5IHBhcnQgaXMgdGhlIG1vZGUgc3dpdGNo
aW5nIGJldHdlZW4gbmFwaSBhbmQgbm8gbmFwaS4iCj4gPiBPeSwgdmV5Lgo+ID4gCj4gPiBJIGRp
ZG4ndCBwYXkgYW55IGF0dGVudGlvbiB0byB0aGF0IGRpc2N1c3Npb24sIHNhZGx5IGVub3VnaC4K
PiA+IAo+ID4gSXQncyBiZWVuIGFib3V0IHRoYXQgbG9uZyAoMjAxOCkgc2luY2UgSSBwYWlkIGFu
eSBhdHRlbnRpb24gdG8KPiA+IGJ1ZmZlcmJsb2F0IGluIHRoZSBjbG91ZCBhbmQgbXkgY2xvdWR5
IHByb3ZpZGVyIChsaW5vZGUpIHN3aXRjaGVkIHRvCj4gPiB1c2luZyB2aXJ0aW8gd2hlbiBJIHdh
c24ndCBsb29raW5nLiBGb3Igb3ZlciBhIHllYXIgbm93LCBJJ2QgYmVlbgo+ID4gZ2V0dGluZyBy
ZXBvcnRzIHNheWluZyB0aGF0IGNvbWNhc3QncyBwaWUgcm9sbG91dCB3YXNuJ3Qgd29ya2luZyBh
cwo+ID4gd2VsbCBhcyBleHBlY3RlZCwgdGhhdCBldmVucm91dGUncyBpbXBsZW1lbnRhdGlvbiBv
ZiBzY2hfY2FrZSBhbmQgc3FtCj4gPiBvbiBpbmJvdW5kIHdhc24ndCB3b3JraW5nIHJpZ2h0LCBu
b3IgcGZfc2Vuc2UncyBhbmQgbnVtZXJvdXMgb3RoZXIKPiA+IGlzc3VlcyBhdCBJbnRlcm5ldCBz
Y2FsZS4KPiA+IAo+ID4gTGFzdCB3ZWVrIEkgcmFuIGEgc3RyaW5nIG9mIGJlbmNobWFya3MgYWdh
aW5zdCBzdGFybGluaydzIG5ldyBzZXJ2aWNlcwo+ID4gYW5kIHdhcyByZWFsbHkgYWdoYXN0IGF0
IHdoYXQgSSBmb3VuZCB0aGVyZSwgdG9vLiBidXQgdGhlIHByb2JsZW0KPiA+IHNlZW1lZCBkZWVw
ZXIgdGhhbiBpbiBqdXN0IHRoZSBkaXNoeS4uLgo+ID4gCj4gPiBXaXRob3V0IEJRTCwgdGhlcmUn
cyBubyBiYWNrcHJlc3N1cmUgZm9yIGZxX2NvZGVsIHRvIGRvIGl0cyB0aGluZy4KPiA+IE5vbmUu
IE15IG1lYXN1cmVtZW50IHNlcnZlcnMgYXJlbid0IEZRLWNvZGVsaW5nCj4gPiBubyBtYXR0ZXIg
aG93IG11Y2ggbG9hZCBJIHB1dCBvbiB0aGVtLiBTaW5jZSB0aGF0IHFkaXNjIGlzIHRoZSBkZWZh
dWx0Cj4gPiBub3cgaW4gbW9zdCBsaW51eCBkaXN0cmlidXRpb25zLCBJIGltYWdpbmUgdGhhdCB0
aGUgYnVsayBvZiB0aGUgY2xvdWQKPiA+IGlzIG5vdyBiZWhhdmluZyBhcyBlcnJhdGljYWxseSBh
cyBsaW51eCB3YXMgaW4gMjAxMSB3aXRoIGVub3Jtb3VzCj4gPiBzd2luZ3MgaW4gdGhyb3VnaHB1
dCBhbmQgbGF0ZW5jeSBmcm9tIEdTTy9UU08gaGl0dGluZyBvdmVybGFyZ2UgcngvdHgKPiA+IHJp
bmdzLCBbMV0sIGJyZWFraW5nIHZhcmlvdXMgcmF0ZSBlc3RpbWF0b3JzIGluIGNvZGVsLCBwaWUg
YW5kIHRoZSB0Y3AKPiA+IHN0YWNrIGl0c2VsZi4KPiA+IAo+ID4gU2VlOgo+ID4gCj4gPiBodHRw
Oi8vZnJlbW9udC5zdGFybGluay50YWh0Lm5ldC9+ZC92aXJ0aW9fbm9icWwvcnJ1bF8tX2V2ZW5y
b3V0ZV92M19zZXJ2ZXJfZnFfY29kZWwucG5nCj4gPiAKPiA+IFNlZSB0aGUgc3dpbmdzIGluIGxh
dGVuY3kgdGhlcmU/IHRoYXQncyBzeW1wdG9tYXRpYyBvZiB0eC9yeCByaW5ncwo+ID4gZmlsbGlu
ZyBhbmQgZW1wdHlpbmcuCj4gPiAKPiA+IGl0IHdhc24ndCB1bnRpbCBJIHN3aXRjaGVkIG15IG1l
YXN1cmVtZW50IHNlcnZlciB0ZW1wb3JhcmlseSBvdmVyIHRvCj4gPiBzY2hfZnEgdGhhdCBJIGdv
dCBhIHJydWwgcmVzdWx0IHRoYXQgd2FzIGNsb3NlIHRvIHRoZSByZXN1bHRzIHdlIHVzZWQKPiA+
IHRvIGdldCBmcm9tIHRoZSB2aXJ0dWFsaXplZCBlMTAwMGUgZHJpdmVycyB3ZSB3ZXJlIHVzaW5n
IGluIDIwMTQuCj4gPiAKPiA+IGh0dHA6Ly9mcmVtb250LnN0YXJsaW5rLnRhaHQubmV0L35kL3Zp
cnRpb19ub2JxbC9ycnVsXy1fZXZlbnJvdXRlX3YzX3NlcnZlcl9mcS5wbmcKPiA+IAo+ID4gV2hp
bGUgSSBoYXZlIGxvbmcgc3VwcG9ydGVkIHRoZSB1c2Ugb2Ygc2NoX2ZxIGZvciB0Y3AtaGVhdnkg
d29ya2xvYWRzLAo+ID4gaXQgc3RpbGwgYmVoYXZlcyBiZXR0ZXIgd2l0aCBicWwgaW4gcGxhY2Us
IGFuZCBmcV9jb2RlbCBpcyBiZXR0ZXIgZm9yCj4gPiBnZW5lcmljIHdvcmtsb2Fkcy4uLiBidXQg
bmVlZHMgYnFsIGJhc2VkIGJhY2twcmVzc3VyZSB0byBraWNrIGluLgo+ID4gCj4gPiBbMV0gSSBy
ZWFsbHkgaG9wZSBJJ20gb3ZlcnJlYWN0aW5nIGJ1dCwgdW0sIGVyLCBjb3VsZCBzb21lb25lKHMp
IHNwaW4KPiA+IHVwIGEgbmV3IHBhdGNoIHRoYXQgZG9lcyBicWwgaW4gc29tZSB3YXkgZXZlbiBo
YWxmIHJpZ2h0IGZvciB0aGlzCj4gPiBkcml2ZXIgYW5kIGhlbHAgdGVzdCBpdD8gSSBoYXZlbid0
IGJ1aWx0IGEga2VybmVsIGluIGEgd2hpbGUuCj4gCj4gCj4gSSB0aGluayBpdCdzIHRpbWUgdG8g
b2Jzb2xldGUgc2tiX29ycGhhbigpIGZvciB2aXJ0aW8tbmV0IHRvIGdldCByaWQgb2YgYQo+IGJy
dW5jaCBvZiB0cmlja3kgY29kZXMgaW4gdGhlIGN1cnJlbnQgdmlydGlvLW5ldCBkcml2ZXIuCj4g
Cj4gVGhlbiB3ZSBjYW4gZG8gQlFMIG9uIHRvcC4KPiAKPiBJIHdpbGwgcHJlcGFyZSBzb21lIHBh
dGNoZXMgdG8gZG8gdGhpcyAocHJvYmFibHkgd2l0aCBNaWNoYWVsJ3MgQlFMIHBhdGNoKS4KPiAK
PiBUaGFua3MKCkZpcnN0IHN0ZXAgd291bGQgYmUgdG8gZml4IHVwIGFuZCB0ZXN0IHRoZSBCUUwg
cGFydC4KSUlSQyBpdCBkaWRuJ3Qgc2VlbSB0byBoZWxwIHBlcmZvcm1hbmNlIGluIG91ciBiZW5j
aG1hcmtpbmcsCmFuZCBFcmljIHNlZW1zIHRvIHNheSB0aGF0J3MgZXhwZWN0ZWQgLi4uCgoKPiAK
PiA+IAo+ID4gCj4gPiA+ID4gT24gTW9uLCBNYXkgMTcsIDIwMjEgYXQgMTE6NDEgQU0gWGlhbnRp
bmcgVGlhbgo+ID4gPiA+IDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToK
PiA+ID4gPiA+IEJVR19PTigpIHVzZXMgdW5saWtlbHkgaW4gaWYoKSwgd2hpY2ggY2FuIGJlIG9w
dGltaXplZCBhdCBjb21waWxlIHRpbWUuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+
ID4gPiAtLS0KPiA+ID4gPiA+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUgKystLS0K
PiA+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCj4gPiA+ID4gPiAKPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+IGluZGV4IGM5MjFlYmYz
YWU4Mi4uMjEyZDUyMjA0ODg0IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4g
PiA+IEBAIC0xNjQ2LDEwICsxNjQ2LDkgQEAgc3RhdGljIGludCB4bWl0X3NrYihzdHJ1Y3Qgc2Vu
ZF9xdWV1ZSAqc3EsIHN0cnVjdAo+ID4gPiA+ID4gc2tfYnVmZiAqc2tiKQo+ID4gPiA+ID4gICAg
ICAgICAgZWxzZQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICBoZHIgPSBza2Jfdm5ldF9oZHIo
c2tiKTsKPiA+ID4gPiA+IAo+ID4gPiA+ID4gLSAgICAgICBpZiAodmlydGlvX25ldF9oZHJfZnJv
bV9za2Ioc2tiLCAmaGRyLT5oZHIsCj4gPiA+ID4gPiArICAgICAgIEJVR19PTih2aXJ0aW9fbmV0
X2hkcl9mcm9tX3NrYihza2IsICZoZHItPmhkciwKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2aXJ0aW9faXNfbGl0dGxlX2VuZGlhbih2aS0+dmRldiksIGZh
bHNlLAo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCkpCj4g
PiA+ID4gPiAtICAgICAgICAgICAgICAgQlVHKCk7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAwKSk7Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ICAgICAgICAgIGlm
ICh2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMpCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIGhkci0+
bnVtX2J1ZmZlcnMgPSAwOwo+ID4gPiA+ID4gLS0KPiA+ID4gPiA+IDIuMTcuMQo+ID4gPiA+ID4g
Cj4gPiA+ID4gCj4gPiA+ID4gLS0KPiA+ID4gPiBMYXRlc3QgUG9kY2FzdDoKPiA+ID4gPiBodHRw
czovL3d3dy5saW5rZWRpbi5jb20vZmVlZC91cGRhdGUvdXJuOmxpOmFjdGl2aXR5OjY3OTEwMTQy
ODQ5MzY3ODU5MjAvCj4gPiA+ID4gCj4gPiA+ID4gRGF2ZSBUw6RodCBDVE8sIFRla0xpYnJlLCBM
TEMKPiA+IAo+ID4gCj4gPiAtLQo+ID4gTGF0ZXN0IFBvZGNhc3Q6Cj4gPiBodHRwczovL3d3dy5s
aW5rZWRpbi5jb20vZmVlZC91cGRhdGUvdXJuOmxpOmFjdGl2aXR5OjY3OTEwMTQyODQ5MzY3ODU5
MjAvCj4gPiAKPiA+IERhdmUgVMOkaHQgQ1RPLCBUZWtMaWJyZSwgTExDCj4gPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
