Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFFBC38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 08:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C54D641C94;
	Fri, 27 Jan 2023 08:22:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C54D641C94
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ObUwNRFP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rd3sYX9DDzaJ; Fri, 27 Jan 2023 08:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB48241C80;
	Fri, 27 Jan 2023 08:22:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB48241C80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8677BC0032;
	Fri, 27 Jan 2023 08:22:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3677BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0ACA84176E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:22:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0ACA84176E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ObUwNRFP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PktxXCJtYWV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:22:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 546E9414E6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 546E9414E6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 08:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674807745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDjl4klenBNtl/PLFSbWMzoXaIOyzFKf0hXB3Iobp5g=;
 b=ObUwNRFPJwOJlY3fwEUj3vc/vMfwPgasxdY1yzXNDHmwXTjNrWDBUtV1unXLmgm+p+ynp8
 O5Wji+x7XzmXqHxloihi9k0/W3s1gVHDYaAAlf+hdSD3HcdhoZZ03dO58Pi+RDQiwS8bU8
 Hf63/YED1SsKupdkQ/PrSW/miMEa0GU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-rsSK0yLlPfq68KqtY82iYw-1; Fri, 27 Jan 2023 03:22:23 -0500
X-MC-Unique: rsSK0yLlPfq68KqtY82iYw-1
Received: by mail-ua1-f70.google.com with SMTP id
 o43-20020ab0596e000000b0038421e4c7deso1597813uad.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 00:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aDjl4klenBNtl/PLFSbWMzoXaIOyzFKf0hXB3Iobp5g=;
 b=S1CNOgdnZ8nBJlXJYViDL7zLSX3icACssN4o77cfvBaSs9X4m3kYq80DmCPFSFr8XK
 gzHHJX3F0wxaKYQWkvDmw2sWmiQOKkDqd+Gl/8M51yrkyQMyiVOMRb8+4zn7sxjW8wD0
 U5mWjiUsGhtbMjLr0VpsOpaC7EUejBtsA8bLqWW6cYR3rypdJBrrLLR5gUVYsk4tsL3e
 X+SyKyIB4mEIx7zKZMkD3YEPvTjdMBz6g/dUez0GcJPNM39O88nXGEYpRWMMChaR7YUP
 GxUGACVpOZ+gDeotUtaw7qyQIHS8EpW7X8KNyCP3ZowmWogbM0qRqKR9NXlj1klALCKJ
 eQIw==
X-Gm-Message-State: AO0yUKWZwbFfVHcdfcapeRdxBdy79dRu2M6e5iStulHCR0UYH+Q4AEsk
 FzfgVH2NnGZsRebg+VGfwdW0yTQDh/Q0oXPp25b62q0GCrF75nVxHBq3+xDFa2W4BDSKAet7nmf
 nZuTpGpLoS9DQ5hwaoR2aUeWH4m5Dobv7VB085D8KEw==
X-Received: by 2002:a1f:a846:0:b0:3e6:2734:7602 with SMTP id
 r67-20020a1fa846000000b003e627347602mr5111680vke.1.1674807743440; 
 Fri, 27 Jan 2023 00:22:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9iRj9arz3CD4aqIKW6gnt+cnTuOdlvDcBZLcVWFqllfMd02qFwImS0F1+FxuC3fl0sIaIUCA==
X-Received: by 2002:a1f:a846:0:b0:3e6:2734:7602 with SMTP id
 r67-20020a1fa846000000b003e627347602mr5111676vke.1.1674807743221; 
 Fri, 27 Jan 2023 00:22:23 -0800 (PST)
Received: from redhat.com ([37.19.199.113]) by smtp.gmail.com with ESMTPSA id
 s8-20020a05612204c800b003e25aef33f5sm254005vkn.9.2023.01.27.00.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 00:22:22 -0800 (PST)
Date: Fri, 27 Jan 2023 03:22:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20230127032039-mutt-send-email-mst@kernel.org>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org>
 <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBEZWMgMTksIDIwMjIgYXQgMDU6MzY6MDJQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiBPbiBNb24sIERlYyAxOSwgMjAyMiBhdCAzOjMzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgRGVjIDA1LCAyMDIyIGF0IDA0
OjQxOjE3UE0gKzA4MDAsIFhpZSBZb25namkgd3JvdGU6Cj4gPiA+IEV4cG9ydCBpcnFfY3JlYXRl
X2FmZmluaXR5X21hc2tzKCkgc28gdGhhdCBzb21lIG1vZHVsZXMKPiA+ID4gY2FuIG1ha2UgdXNl
IG9mIGl0IHRvIGltcGxlbWVudCBpbnRlcnJ1cHQgYWZmaW5pdHkKPiA+ID4gc3ByZWFkaW5nIG1l
Y2hhbmlzbS4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2pp
QGJ5dGVkYW5jZS5jb20+Cj4gPgo+ID4gU28gdGhpcyBnb3QgbmFja2VkLCB3aGF0J3MgdGhlIHBs
YW4gbm93Pwo+ID4KPiAKPiBJ4oCYZCBsaWtlIHRvIGNoZWNrIHdpdGggQ2hyaXN0b3BoIGFnYWlu
IGZpcnN0Lgo+IAo+IEhpIENocmlzdG9waCwKPiAKPiBKYXNvbiB3aWxsIHBvc3Qgc29tZSBwYXRj
aGVzIHRvIGdldCByaWQgb2YgdGhlIERNQSBBUEkgZm9yIHZEUEEKPiBzaW11bGF0b3JzLiBBbmQg
dGhlIGlycSBhZmZpbml0eSBhbGdvcml0aG0gaXMgaW5kZXBlbmRlbnQgb2YgdGhlIElSUQo+IHN1
YnN5c3RlbSBJSVVDLiBTbyBjb3VsZCB5b3UgYWxsb3cgdGhpcyBwYXRjaCBzbyB0aGF0IHdlIGNh
biByZXVzZSB0aGUKPiBhbGdvcml0aG0gdG8gc2VsZWN0IHRoZSBiZXN0IENQVSAocGVyLWNwdSBh
ZmZpbml0eSBpZiBwb3NzaWJsZSwgb3IgYXQKPiBsZWFzdCBwZXItbm9kZSkgdG8gcnVuIHRoZSB2
aXJ0cXVldWUncyBpcnEgY2FsbGJhY2suCj4gCj4gVGhhbmtzLAo+IFlvbmdqaQoKSSB0aGluayB5
b3UgbmVlZCB0byBleHBsYWluIHdoeSB5b3UgYXJlIGJ1aWxkaW5nIGxvdyBsZXZlbAphZmZpbml0
eSBtYXNrcy4gIHdoYXQncyB0aGUgcGxhbiBub3c/Cgo+ID4gPiAtLS0KPiA+ID4gIGtlcm5lbC9p
cnEvYWZmaW5pdHkuYyB8IDEgKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
Cj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvaXJxL2FmZmluaXR5LmMgYi9rZXJuZWwv
aXJxL2FmZmluaXR5LmMKPiA+ID4gaW5kZXggZDlhNWMxZDY1YTc5Li5mMDc0YTc3MDdjNmQgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2tlcm5lbC9pcnEvYWZmaW5pdHkuYwo+ID4gPiArKysgYi9rZXJuZWwv
aXJxL2FmZmluaXR5LmMKPiA+ID4gQEAgLTQ4Nyw2ICs0ODcsNyBAQCBpcnFfY3JlYXRlX2FmZmlu
aXR5X21hc2tzKHVuc2lnbmVkIGludCBudmVjcywgc3RydWN0IGlycV9hZmZpbml0eSAqYWZmZCkK
PiA+ID4KPiA+ID4gICAgICAgcmV0dXJuIG1hc2tzOwo+ID4gPiAgfQo+ID4gPiArRVhQT1JUX1NZ
TUJPTF9HUEwoaXJxX2NyZWF0ZV9hZmZpbml0eV9tYXNrcyk7Cj4gPiA+Cj4gPiA+ICAvKioKPiA+
ID4gICAqIGlycV9jYWxjX2FmZmluaXR5X3ZlY3RvcnMgLSBDYWxjdWxhdGUgdGhlIG9wdGltYWwg
bnVtYmVyIG9mIHZlY3RvcnMKPiA+ID4gLS0KPiA+ID4gMi4yMC4xCj4gPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
