Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9139AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 11:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D1FE4028D;
	Mon, 29 Nov 2021 11:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 503gSi1Vd-h3; Mon, 29 Nov 2021 11:51:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 539004016D;
	Mon, 29 Nov 2021 11:51:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15D0AC0012;
	Mon, 29 Nov 2021 11:51:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33EBFC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 11:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F5614016D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 11:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wbEcczb6nzNI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 11:51:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C298940003
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 11:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638186692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGuS+B5NMXrDIsbQZdq6bzRf8ETb6q8qzKSr/oEECDw=;
 b=WG67LdrvJTcr3OY4kqwiLwuOrQcoMs87rRTTPLPV3y5m0RYb2g5p6jIJWPuR7uWY3X+fWh
 nmyzqPlNMPgQ5xRQAROMtA9NEyUGr5QVVVwze0Yhh7fvsd5N0g2dvnz2hjP9SwoN3F0MhH
 2vSkJ4CGBmkXwYdcpIulRJsJ4WxRpB0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-z6Q3P63FPdCu_25lESJhNA-1; Mon, 29 Nov 2021 06:51:29 -0500
X-MC-Unique: z6Q3P63FPdCu_25lESJhNA-1
Received: by mail-ed1-f72.google.com with SMTP id
 m12-20020a056402430c00b003e9f10bbb7dso13461162edc.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 03:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=o1hbT83UZyzEpMcYnWEfjfHejJ/ev9mdgbjpKbK1VxE=;
 b=PuyRnPY0OrMw55NNM3KjC1g1sox8PaZsIMLa4mhq9z/O3a03m+l/tdwVZJ3dFc5jED
 wPWRvm9kSlKpuetvjevYoI0CyHEpBHj3aGYcqUj8JX+wtJITJQw3SpWICyRKHvi04ZKk
 bJ56OxFjwf6wfh9WCYj+xKR2Qz39hPJai54RDHGM0mT6ZBGTZghPdn7kX7c6pTxhP189
 dLBaoUbxF/fvh/RNmemxhcNrs/j6rgk1M7FhKSeA0XkWupJQQjhm1SlM3AaOddYnu2C8
 xtaLUiwoUUIalapbfg7VmlniXSQaAbPCOQpZEPGjxBsw3nGr86Yiwof7DzE9XHCtzBbq
 D5sg==
X-Gm-Message-State: AOAM532GecYMS93BxyldnFox0IuHgpGSD0Xs4cgtGK2jD1WZZ/NwKMAy
 VSwvQxY8SG224qODmR67RTSsh/rJSMc786wH5bJwhwephwnX080k8WThuehUj6arFVFEpI8/D1U
 aSTtRpg7v+t+dVAj0/7/asISgEk8lykNA+8f/tiPwuw==
X-Received: by 2002:a05:6402:90c:: with SMTP id
 g12mr72820089edz.36.1638186688002; 
 Mon, 29 Nov 2021 03:51:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy//h6DqzMZ3cIjns1ItOPHoyCEI8XwGnDfYQ/w255YG7ez18OJaBJc76mESug2RLwzmhwD5w==
X-Received: by 2002:a05:6402:90c:: with SMTP id
 g12mr72820014edz.36.1638186687643; 
 Mon, 29 Nov 2021 03:51:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
 by smtp.gmail.com with ESMTPSA id z1sm9056421edq.54.2021.11.29.03.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Nov 2021 03:51:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
 id 6858F1802A0; Mon, 29 Nov 2021 12:51:26 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 net-next 21/26] ice: add XDP and XSK generic
 per-channel statistics
In-Reply-To: <871ae82a-3d5b-2693-2f77-7c86d725a056@iogearbox.net>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-22-alexandr.lobakin@intel.com>
 <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net>
 <87bl28bga6.fsf@toke.dk>
 <20211125170708.127323-1-alexandr.lobakin@intel.com>
 <20211125094440.6c402d63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211125204007.133064-1-alexandr.lobakin@intel.com>
 <87sfvj9k13.fsf@toke.dk>
 <20211126100611.514df099@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <871ae82a-3d5b-2693-2f77-7c86d725a056@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Nov 2021 12:51:26 +0100
Message-ID: <878rx79o3l.fsf@toke.dk>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=toke@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Andrei Vagin <avagin@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Noam Dagan <ndagan@amazon.com>,
 Cong Wang <cong.wang@bytedance.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Yonghong Song <yhs@fb.com>,
 Shay Agroskin <shayagr@amazon.com>, Marcin Wojtas <mw@semihalf.com>,
 David Arinzon <darinzon@amazon.com>, David Ahern <dsahern@kernel.org>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
 Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
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

RGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4gd3JpdGVzOgoKPiBPbiAxMS8y
Ni8yMSA3OjA2IFBNLCBKYWt1YiBLaWNpbnNraSB3cm90ZToKPj4gT24gRnJpLCAyNiBOb3YgMjAy
MSAxMzozMDoxNiArMDEwMCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gd3JvdGU6Cj4+Pj4+IFRC
SCBJIHdhc24ndCBmb2xsb3dpbmcgdGhpcyB0aHJlYWQgdG9vIGNsb3NlbHkgc2luY2UgSSBzYXcg
RGFuaWVsCj4+Pj4+IG5hY2tlZCBpdCBhbHJlYWR5LiBJIGRvIHByZWZlciBydG5sIHhzdGF0cywg
SSdkIGp1c3QgcmVwb3J0IHRoZW0KPj4+Pj4gaW4gLXMgaWYgdGhleSBhcmUgbm9uLXplcm8uIEJ1
dCBkb2Vzbid0IHNvdW5kIGxpa2Ugd2UgaGF2ZSBhbiBhZ3JlZW1lbnQKPj4+Pj4gd2hldGhlciB0
aGV5IHNob3VsZCBleGlzdCBvciBub3QuCj4+Pj4KPj4+PiBSaWdodCwganVzdCAtcyBpcyBmaW5l
LCBpZiB3ZSBkcm9wIHRoZSBwZXItY2hhbm5lbCBhcHByb2FjaC4KPj4+Cj4+PiBJIGFncmVlIHRo
YXQgYWRkaW5nIHRoZW0gdG8gLXMgaXMgZmluZSAoYW5kIHRoYXQgcmVzb2x2ZXMgbXkgIm5vIG9u
ZQo+Pj4gd2lsbCBmaW5kIHRoZW0iIGNvbXBsYWluIGFzIHdlbGwpLiBJZiBpdCBjcm93ZHMgdGhl
IG91dHB1dCB3ZSBjb3VsZCBhbHNvCj4+PiBkZWZhdWx0IHRvIG9ubHkgb3V0cHV0J2luZyBhIHN1
YnNldCwgYW5kIGhhdmUgdGhlIG1vcmUgZGV0YWlsZWQKPj4+IHN0YXRpc3RpY3MgaGlkZGVuIGJl
aGluZCBhIHZlcmJvc2Ugc3dpdGNoIChvciBldmVuIGp1c3QgaW4gdGhlIEpTT04KPj4+IG91dHB1
dCk/Cj4+Pgo+Pj4+PiBDYW4gd2UgdGhpbmsgb2YgYW4gYXBwcm9hY2ggd2hpY2ggd291bGQgbWFr
ZSBjbG91ZGZsYXJlIGFuZCBjaWxpdW0KPj4+Pj4gaGFwcHk/IEZlZWxzIGxpa2Ugd2UncmUgdHJ5
aW5nIHRvIG1ha2UgdGhlIHNsaWdodGx5IGh5cG90aGV0aWNhbAo+Pj4+PiBhZG1pbiBoYXBweSB3
aGlsZSBpZ25vcmluZyBvYmplY3Rpb25zIG9mIHZlcnkgcmVhbCB1c2Vycy4KPj4+Pgo+Pj4+IFRo
ZSBpbml0aWFsIGlkZWEgd2FzIHRvIG9ubHkgdW5pZm9ybSB0aGUgZHJpdmVycy4gQnV0IGluIGdl
bmVyYWwKPj4+PiB5b3UgYXJlIHJpZ2h0LCAxMCBkcml2ZXJzIGhhdmluZyBzb21ldGhpbmcgZG9l
c24ndCBtZWFuIGl0J3MKPj4+PiBzb21ldGhpbmcgZ29vZC4KPj4+Cj4+PiBJIGRvbid0IHRoaW5r
IGl0J3MgYWNjdXJhdGUgdG8gY2FsbCB0aGUgYWRtaW4gdXNlIGNhc2UgImh5cG90aGV0aWNhbCIu
Cj4+PiBXZSdyZSBleHBlbmRpbmcgYSBzaWduaWZpY2FudCBlZmZvcnQgZXhwbGFpbmluZyB0byBw
ZW9wbGUgdGhhdCBYRFAgY2FuCj4+PiAiZWF0IiB5b3VyIHBhY2tldHMsIGFuZCBub3QgaGF2aW5n
IGFueSBzdGFuZGFyZCBzdGF0aXN0aWNzIG1ha2VzIHRoaXMKPj4+IHdheSBoYXJkZXIuIFdlIHNo
b3VsZCBhYnNvbHV0ZWx5IGNhdGVyIHRvIG91ciAiZWFybHkgYWRvcHRlcnMiLCBidXQgaWYKPj4+
IHdlIHdhbnQgWERQIHRvIHNlZSB3aWRlciBhZG9wdGlvbiwgbWFraW5nIGl0ICJsZXNzIHdlaXJk
IiBpcyBjcml0aWNhbCEKPj4gCj4+IEZhaXIuIEluIGFsbCBob25lc3R5IEkgc2FpZCB0aGF0IGhv
cGluZyB0byBwdXNoIGZvciBhIG1vcmUgZmxleGlibGUKPj4gYXBwcm9hY2ggaGlkZGVuIGVudGly
ZWx5IGluIEJQRiwgYW5kIG5vdCBpbnZvbHZpbmcgZHJpdmVyIGNoYW5nZXMuCj4+IEFzc3VtaW5n
IHRoZSBYRFAgcHJvZ3JhbSBoYXMgbW9yZSBmaW5lIGdyYWluZWQgc3RhdHMgd2Ugc2hvdWxkIGJl
IGFibGUKPj4gdG8gZXh0cmFjdCB0aG9zZSBpbnN0ZWFkIG9mIGRvdWJsZS1jb3VudGluZy4gSGVu
Y2UgbXkgdmFndWUgImxldCdzIHdvcmsKPj4gd2l0aCBhcHBzIiBjb21tZW50Lgo+PiAKPj4gRm9y
IGV4YW1wbGUgdG8gYSBwZXJzb24gZmFtaWxpYXIgd2l0aCB0aGUgd29ya2xvYWQgaXQnZCBiZSB1
c2VmdWwgdG8KPj4ga25vdyBpZiBwcm9ncmFtIHJldHVybmVkIFhEUF9EUk9QIGJlY2F1c2Ugb2Yg
Y29uZmlndXJlZCBwb2xpY3kgb3IKPj4gZmFpbHVyZSB0byBwYXJzZSBhIHBhY2tldC4gSSBkb24n
dCB0aGluayB0aGF0IHNvcnQgZGlzdGluY3Rpb24gaXMKPj4gYWNoaWV2YWJsZSBhdCB0aGUgbGV2
ZWwgb2Ygc3RhbmRhcmQgc3RhdHMuCj4KPiBBZ3JlZSBvbiB0aGUgYWRkaXRpb25hbCBjb250ZXh0
LiBIb3cgb2Z0ZW4gaGF2ZSB5b3UgbG9va2VkIGF0IHRjIGNsc2FjdAo+IC9kcm9wcGVkLyBzdGF0
cyBzcGVjaWZpY2FsbHkgd2hlbiB5b3UgZGVidWcgYSBtb3JlIGNvbXBsZXggQlBGIHByb2dyYW0K
PiB0aGVyZT8KPgo+ICAgICMgdGMgLXMgcWRpc2Mgc2hvdyBjbHNhY3QgZGV2IGZvbwo+ICAgIHFk
aXNjIGNsc2FjdCBmZmZmOiBwYXJlbnQgZmZmZjpmZmYxCj4gICAgIFNlbnQgNjgwMCBieXRlcyAx
MjAgcGt0IChkcm9wcGVkIDAsIG92ZXJsaW1pdHMgMCByZXF1ZXVlcyAwKQo+ICAgICBiYWNrbG9n
IDBiIDBwIHJlcXVldWVzIDAKPgo+IFNpbWlsYXJseSwgWERQX1BBU1MgY291bnRlcnMgbWF5IGJl
IG9mIGxpbWl0ZWQgdXNlIGFzIHdlbGwgZm9yIHNhbWUgcmVhc29uCj4gKGFuZCBJIHRoaW5rIHdl
IG1pZ2h0IG5vdCBldmVuIGhhdmUgYSB0YyBjb3VudGVyIGVxdWl2YWxlbnQgZm9yIGl0KS4KPgo+
PiBUaGUgaW5mb3JtYXRpb24gcmVxdWlyZWQgYnkgdGhlIGFkbWluIGlzIGhpZ2hlciBsZXZlbC4g
QXMgeW91IHNheSB0aGUKPj4gcHJpbWFyeSBjb25jZXJuIHRoZXJlIGlzICJob3cgbWFueSBwYWNr
ZXRzIGRpZCBYRFAgZWF0Ii4KPgo+IEFncmVlLiBBYm92ZSBzYWlkLCBmb3IgWERQX0RST1AgSSB3
b3VsZCBzZWUgb25lIHVzZSBjYXNlIHdoZXJlIHlvdSBjb21wYXJlCj4gZGlmZmVyZW50IGRyaXZl
cnMgb3IgYm9uZCB2cyBubyBib25kIGFzIHdlIGRpZCBpbiB0aGUgcGFzdCBpbiBbMF0gd2hlbgo+
IHRlc3RpbmcgYWdhaW5zdCBhIHBhY2tldCBnZW5lcmF0b3IgKGFsdGhvdWdoIEkgZG9uJ3Qgc2Vl
IGJvbmQgZHJpdmVyIGNvdmVyZWQKPiBpbiB0aGlzIHNlcmllcyBoZXJlIHlldCB3aGVyZSBpdCBh
Z2dyZWdhdGVzIHRoZSBYRFAgc3RhdHMgZnJvbSBhbGwgYm9uZCBzbGF2ZQo+IGRldnMpLgo+Cj4g
T24gYSBoaWdoZXItbGV2ZWwgd3J0ICJob3cgbWFueSBwYWNrZXRzIGRpZCBYRFAgZWF0IiwgaXQg
d291bGQgbWFrZSBzZW5zZQo+IHRvIGhhdmUgdGhlIHN0YXRzIGZvciBzdWNjZXNzZnVsIFhEUF97
VFgsUkVESVJFQ1R9IGdpdmVuIHRoZXNlIGFyZSBvdXQKPiBvZiByZWFjaCBmcm9tIGEgQlBGIHBy
b2cgUG9WIC0gd2UgY2FuIG9ubHkgY291bnQgdGhlcmUgaG93IG1hbnkgdGltZXMgd2UKPiByZXR1
cm5lZCB3aXRoIFhEUF9UWCBidXQgbm90IHdoZXRoZXIgdGhlIHBrdCAvc3VjY2Vzc2Z1bGx5IG1h
ZGUgaXQvLgo+Cj4gSW4gdGVybXMgb2YgZXJyb3IgY2FzZXMsIGNvdWxkIHdlIGp1c3Qgc3RhbmRh
cmRpemUgYWxsIGRyaXZlcnMgb24gdGhlIGJlaGF2aW9yCj4gb2YgZS5nLiBtbHg1ZV94ZHBfaGFu
ZGxlKCksIG1lYW5pbmcsIGEgZmFpbHVyZSBmcm9tIFhEUF97VFgsUkVESVJFQ1R9IHdpbGwKPiBo
aXQgdGhlIHRyYWNlX3hkcF9leGNlcHRpb24oKSBhbmQgdGhlbiBmYWxsdGhyb3VnaCB0byBidW1w
IGEgZHJvcCBjb3VudGVyCj4gKHNhbWUgYXMgd2UgYnVtcCBpbiBYRFBfRFJPUCB0aGVuKS4gU28g
dGhlIGRyb3AgY291bnRlciB3aWxsIGFjY291bnQgZm9yCj4gcHJvZ3JhbSBkcm9wcyBidXQgYWxz
byBkcml2ZXItcmVsYXRlZCBkcm9wcy4KPgo+IEF0IHNvbWUgbGF0ZXIgcG9pbnQgdGhlIHRyYWNl
X3hkcF9leGNlcHRpb24oKSBjb3VsZCBiZSBleHRlbmRlZCB3aXRoIGFuIGVycm9yCj4gY29kZSB0
aGF0IHRoZSBkcml2ZXIgd291bGQgcHJvcGFnYXRlIChnaXZlbiBzb21lIG9mIHRoZW0gbG9vayBx
dWl0ZSBzaW1pbGFyCj4gYWNyb3NzIGRyaXZlcnMsIGZ3aXcpLCBhbmQgdGhlbiB3aG9ldmVyIHdh
bnRzIHRvIGRvIGZ1cnRoZXIgcHJvY2Vzc2luZyB3aXRoCj4gdGhlbSBjYW4gZG8gc28gdmlhIGJw
ZnRyYWNlIG9yIG90aGVyIHRvb2xpbmcuCj4KPiBTbyBvdmVyYWxsIHdydCB0aGlzIHNlcmllczog
ZnJvbSB0aGUgbHJzdGF0cyB3ZSdkIGJlIC9kcm9wcGluZy8gdGhlIHBhc3MsCj4gdHhfZXJyb3Jz
LCByZWRpcmVjdF9lcnJvcnMsIGludmFsaWQsIGFib3J0ZWQgY291bnRlcnMuIEFuZCB3ZSdkIGJl
IC9rZWVwaW5nLwo+IGJ5dGVzICYgcGFja2V0cyBjb3VudGVycyB0aGF0IFhEUCBzZWVzLCAoZHJp
dmVyLSlzdWNjZXNzZnVsIHR4ICYgcmVkaXJlY3QKPiBjb3VudGVycyBhcyB3ZWxsIGFzIGRyb3Ag
Y291bnRlci4gQWxzbywgWERQIGJ5dGVzICYgcGFja2V0cyBjb3VudGVycyBzaG91bGQKPiBub3Qg
YmUgY291bnRlZCB0d2ljZSB3cnQgZXRodG9vbCBzdGF0cy4KClRoaXMgc291bmRzIHJlYXNvbmFi
bGUgdG8gbWUsIGFuZCBJIGFsc28gbGlrZSB0aGUgZXJyb3IgY29kZSB0bwp0cmFjZXBvaW50IGlk
ZWEgOikKCi1Ub2tlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
