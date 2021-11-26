Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCD5C433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 18:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 046CC8291D;
	Fri, 26 Nov 2021 18:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8dsokKUZVLBq; Fri, 26 Nov 2021 18:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E7F4828EF;
	Fri, 26 Nov 2021 18:47:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56309C0012;
	Fri, 26 Nov 2021 18:47:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20815C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 18:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF9E0828F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 18:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79QEag6OxnwN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 18:47:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB846828EF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637952442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWDeeCs6w2CC5ZKfNeNUVbJNLFuouzSfCCh6tg3KdiQ=;
 b=KTz+8s9/ncwJdU1QQsCHFOrtgrdXw5JlkSKsePHGOZLexuA4sx3xN5hPZMO1UwECMGmGnk
 sQ+6TqWFgWQyt84spXLTQ3pcj33Q1J4tEANJHHbR7AtEElmIzBXhIu+j1xEim0Ie9sFVQc
 0LklPE3QC4LsPaMP1K0PL0ClUlZIRsQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-DI60QpzPNfe5puWHMOaFfA-1; Fri, 26 Nov 2021 13:47:21 -0500
X-MC-Unique: DI60QpzPNfe5puWHMOaFfA-1
Received: by mail-ed1-f71.google.com with SMTP id
 v1-20020aa7cd41000000b003e80973378aso8603024edw.14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 10:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O6rbfWik1xYZrbAijVAfDmHvfjyDH76LNjEVf+e9aLQ=;
 b=IIgNREmMgXvTGRMp6itoe90CRYd0MaVq/Heffmfb9WTFJK2nH99ifmO4DLeEZxRdQf
 D9g/fG4lGfT4bEF0sXcth+c2Ly81Uof/+rSLyjqYLR2ClBa6XLcL9Y9eiUBTz6LPj+Ba
 WFz3tt7kjd5SeEq/shpexpnQGwn3tXC0Uz9RRqEaaFMTkvt9d0Sa9KDooJW6A44PfVt3
 r6weWyUQARZMx18C1hQqleQwztRQIoZfm9ZJVtlhGFTLSCBAuuR1DIiaUFPru8IKYbqw
 LobgRJtcFqDqbLIlrPxfZhi5jlevnB9DfEyI01LyB81653m4zJAtea1mCMsPgTwjj4Qq
 KLjA==
X-Gm-Message-State: AOAM531P8JKvbgUSzShFW9ioHschLnKiERUhdJxukxWp66CR9dCMIuyN
 TBWNpYYTdLu9n46m/rWQBulyjBhB+JISn4hJWdjBgcLkdSgo3eoeMqabP5wkxfvx6Ij7YeJzGdL
 XbS6CwEC50jWMWmiEWsPv1byev5q5rhldAQkWxcjMUg==
X-Received: by 2002:a50:f09b:: with SMTP id v27mr50640024edl.53.1637952439508; 
 Fri, 26 Nov 2021 10:47:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysqEUXaashQMp696tzO9iR2R9x+kWsok2AbHg4/IoknOktCZ+sa6SV7IRItNNVUIbLVIF90Q==
X-Received: by 2002:a50:f09b:: with SMTP id v27mr50639967edl.53.1637952439132; 
 Fri, 26 Nov 2021 10:47:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
 by smtp.gmail.com with ESMTPSA id z6sm4779036edc.76.2021.11.26.10.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 10:47:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
 id EB3281802A0; Fri, 26 Nov 2021 19:47:17 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 net-next 21/26] ice: add XDP and XSK generic
 per-channel statistics
In-Reply-To: <20211126100611.514df099@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-22-alexandr.lobakin@intel.com>
 <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net>
 <87bl28bga6.fsf@toke.dk>
 <20211125170708.127323-1-alexandr.lobakin@intel.com>
 <20211125094440.6c402d63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211125204007.133064-1-alexandr.lobakin@intel.com>
 <87sfvj9k13.fsf@toke.dk>
 <20211126100611.514df099@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 26 Nov 2021 19:47:17 +0100
Message-ID: <87ee72ah56.fsf@toke.dk>
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
 Daniel Borkmann <daniel@iogearbox.net>, David Arinzon <darinzon@amazon.com>,
 David Ahern <dsahern@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
 netdev@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
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

SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gd3JpdGVzOgoKPiBPbiBGcmksIDI2IE5v
diAyMDIxIDEzOjMwOjE2ICswMTAwIFRva2UgSMO4aWxhbmQtSsO4cmdlbnNlbiB3cm90ZToKPj4g
Pj4gVEJIIEkgd2Fzbid0IGZvbGxvd2luZyB0aGlzIHRocmVhZCB0b28gY2xvc2VseSBzaW5jZSBJ
IHNhdyBEYW5pZWwKPj4gPj4gbmFja2VkIGl0IGFscmVhZHkuIEkgZG8gcHJlZmVyIHJ0bmwgeHN0
YXRzLCBJJ2QganVzdCByZXBvcnQgdGhlbSAKPj4gPj4gaW4gLXMgaWYgdGhleSBhcmUgbm9uLXpl
cm8uIEJ1dCBkb2Vzbid0IHNvdW5kIGxpa2Ugd2UgaGF2ZSBhbiBhZ3JlZW1lbnQKPj4gPj4gd2hl
dGhlciB0aGV5IHNob3VsZCBleGlzdCBvciBub3QuICAKPj4gPgo+PiA+IFJpZ2h0LCBqdXN0IC1z
IGlzIGZpbmUsIGlmIHdlIGRyb3AgdGhlIHBlci1jaGFubmVsIGFwcHJvYWNoLiAgCj4+IAo+PiBJ
IGFncmVlIHRoYXQgYWRkaW5nIHRoZW0gdG8gLXMgaXMgZmluZSAoYW5kIHRoYXQgcmVzb2x2ZXMg
bXkgIm5vIG9uZQo+PiB3aWxsIGZpbmQgdGhlbSIgY29tcGxhaW4gYXMgd2VsbCkuIElmIGl0IGNy
b3dkcyB0aGUgb3V0cHV0IHdlIGNvdWxkIGFsc28KPj4gZGVmYXVsdCB0byBvbmx5IG91dHB1dCdp
bmcgYSBzdWJzZXQsIGFuZCBoYXZlIHRoZSBtb3JlIGRldGFpbGVkCj4+IHN0YXRpc3RpY3MgaGlk
ZGVuIGJlaGluZCBhIHZlcmJvc2Ugc3dpdGNoIChvciBldmVuIGp1c3QgaW4gdGhlIEpTT04KPj4g
b3V0cHV0KT8KPj4gCj4+ID4+IENhbiB3ZSB0aGluayBvZiBhbiBhcHByb2FjaCB3aGljaCB3b3Vs
ZCBtYWtlIGNsb3VkZmxhcmUgYW5kIGNpbGl1bQo+PiA+PiBoYXBweT8gRmVlbHMgbGlrZSB3ZSdy
ZSB0cnlpbmcgdG8gbWFrZSB0aGUgc2xpZ2h0bHkgaHlwb3RoZXRpY2FsIAo+PiA+PiBhZG1pbiBo
YXBweSB3aGlsZSBpZ25vcmluZyBvYmplY3Rpb25zIG9mIHZlcnkgcmVhbCB1c2Vycy4gIAo+PiA+
Cj4+ID4gVGhlIGluaXRpYWwgaWRlYSB3YXMgdG8gb25seSB1bmlmb3JtIHRoZSBkcml2ZXJzLiBC
dXQgaW4gZ2VuZXJhbAo+PiA+IHlvdSBhcmUgcmlnaHQsIDEwIGRyaXZlcnMgaGF2aW5nIHNvbWV0
aGluZyBkb2Vzbid0IG1lYW4gaXQncwo+PiA+IHNvbWV0aGluZyBnb29kLiAgCj4+IAo+PiBJIGRv
bid0IHRoaW5rIGl0J3MgYWNjdXJhdGUgdG8gY2FsbCB0aGUgYWRtaW4gdXNlIGNhc2UgImh5cG90
aGV0aWNhbCIuCj4+IFdlJ3JlIGV4cGVuZGluZyBhIHNpZ25pZmljYW50IGVmZm9ydCBleHBsYWlu
aW5nIHRvIHBlb3BsZSB0aGF0IFhEUCBjYW4KPj4gImVhdCIgeW91ciBwYWNrZXRzLCBhbmQgbm90
IGhhdmluZyBhbnkgc3RhbmRhcmQgc3RhdGlzdGljcyBtYWtlcyB0aGlzCj4+IHdheSBoYXJkZXIu
IFdlIHNob3VsZCBhYnNvbHV0ZWx5IGNhdGVyIHRvIG91ciAiZWFybHkgYWRvcHRlcnMiLCBidXQg
aWYKPj4gd2Ugd2FudCBYRFAgdG8gc2VlIHdpZGVyIGFkb3B0aW9uLCBtYWtpbmcgaXQgImxlc3Mg
d2VpcmQiIGlzIGNyaXRpY2FsIQo+Cj4gRmFpci4gSW4gYWxsIGhvbmVzdHkgSSBzYWlkIHRoYXQg
aG9waW5nIHRvIHB1c2ggZm9yIGEgbW9yZSBmbGV4aWJsZQo+IGFwcHJvYWNoIGhpZGRlbiBlbnRp
cmVseSBpbiBCUEYsIGFuZCBub3QgaW52b2x2aW5nIGRyaXZlciBjaGFuZ2VzLgo+IEFzc3VtaW5n
IHRoZSBYRFAgcHJvZ3JhbSBoYXMgbW9yZSBmaW5lIGdyYWluZWQgc3RhdHMgd2Ugc2hvdWxkIGJl
IGFibGUKPiB0byBleHRyYWN0IHRob3NlIGluc3RlYWQgb2YgZG91YmxlLWNvdW50aW5nLiBIZW5j
ZSBteSB2YWd1ZSAibGV0J3Mgd29yawo+IHdpdGggYXBwcyIgY29tbWVudC4KPgo+IEZvciBleGFt
cGxlIHRvIGEgcGVyc29uIGZhbWlsaWFyIHdpdGggdGhlIHdvcmtsb2FkIGl0J2QgYmUgdXNlZnVs
IHRvCj4ga25vdyBpZiBwcm9ncmFtIHJldHVybmVkIFhEUF9EUk9QIGJlY2F1c2Ugb2YgY29uZmln
dXJlZCBwb2xpY3kgb3IKPiBmYWlsdXJlIHRvIHBhcnNlIGEgcGFja2V0LiBJIGRvbid0IHRoaW5r
IHRoYXQgc29ydCBkaXN0aW5jdGlvbiBpcwo+IGFjaGlldmFibGUgYXQgdGhlIGxldmVsIG9mIHN0
YW5kYXJkIHN0YXRzLgo+Cj4gVGhlIGluZm9ybWF0aW9uIHJlcXVpcmVkIGJ5IHRoZSBhZG1pbiBp
cyBoaWdoZXIgbGV2ZWwuIEFzIHlvdSBzYXkgdGhlCj4gcHJpbWFyeSBjb25jZXJuIHRoZXJlIGlz
ICJob3cgbWFueSBwYWNrZXRzIGRpZCBYRFAgZWF0Ii4KClJpZ2h0LCBzdXJlLCBJIGFtIGFsc28g
dG90YWxseSBmaW5lIHdpdGggaGF2aW5nIG9ubHkgYSBzb21ld2hhdApyZXN0cmljdGVkIHN1YnNl
dCBvZiBzdGF0cyBhdmFpbGFibGUgYXQgdGhlIGludGVyZmFjZSBsZXZlbCBhbmQgbWFrZQpldmVy
eXRoaW5nIGVsc2UgYmUgQlBGLWJhc2VkLiBJJ20gaG9waW5nIHdlIGNhbiBjb252ZXJnZSBvZiBh
IGNvbW1vbgp1bmRlcnN0YW5kaW5nIG9mIHdoYXQgdGhpcyAibWluaW1hbCBzZXQiIHNob3VsZCBi
ZSA6KQoKPiBTcGVha2luZyBvZiB3aGljaCwgb25lIHRoaW5nIHRoYXQgYmFkbHkgbmVlZHMgY2xh
cmlmaWNhdGlvbiBpcyBvdXIKPiBleHBlY3RhdGlvbiBhcm91bmQgWERQIHBhY2tldHMgZ2V0dGlu
ZyBjb3VudGVkIHRvd2FyZHMgdGhlIGludGVyZmFjZQo+IHN0YXRzLgoKQWdyZWVkLiBNeSBpbW1l
ZGlhdGUgdGhvdWdodCBpcyB0aGF0ICJYRFAgcGFja2V0cyBhcmUgaW50ZXJmYWNlIHBhY2tldHMi
CmJ1dCB0aGF0IGlzIGNlcnRhaW5seSBub3Qgd2hhdCB3ZSBkbyB0b2RheSwgc28gbm90IHN1cmUg
aWYgY2hhbmdpbmcgaXQKYXQgdGhpcyBwb2ludCB3b3VsZCBicmVhayB0aGluZ3M/Cgo+PiA+IE1h
Y2llaiwgSSB0aGluayB5b3Ugd2VyZSB0YWxraW5nIGFib3V0IENpbGl1bSBhc2tpbmcgZm9yIHRo
b3NlIHN0YXRzCj4+ID4gaW4gSW50ZWwgZHJpdmVycz8gQ291bGQgeW91IG1heWJlIHByb3ZpZGUg
dGhlaXIgZXhhY3QgdXNlY2FzZXMvbmVlZHMKPj4gPiBzbyBJJ2xsIG9yaWVudCBteXNlbGY/IEkg
Y2VydGFpbmx5IHJlbWVtYmVyIGFib3V0IFhTSyBUeCBwYWNrZXRzIGFuZAo+PiA+IGJ5dGVzLgo+
PiA+IEFuZCBzcGVha2luZyBvZiBYU0sgVHgsIHdlIGhhdmUgcGVyLXNvY2tldCBzdGF0cywgaXNu
J3QgdGhhdCBlbm91Z2g/ICAKPj4gCj4+IElNTywgYXMgbG9uZyBhcyB0aGUgcGFja2V0cyBhcmUg
YWNjb3VudGVkIGZvciBpbiB0aGUgcmVndWxhciBYRFAgc3RhdHMsCj4+IGhhdmluZyBhIHdob2xl
IHNlcGFyYXRlIHNldCBvZiBzdGF0cyBvbmx5IGZvciBYU0sgaXMgbGVzcyBpbXBvcnRhbnQuCj4+
IAo+PiA+PiBQbGVhc2UgbGVhdmUgdGhlIHBlci1jaGFubmVsIHN0YXRzIG91dC4gVGhleSBtYWtl
IGEgcHJlY2VkZW50IGZvcgo+PiA+PiBjaGFubmVsIHN0YXRzIHdoaWNoIHNob3VsZCBiZSBhbiBh
dHRyaWJ1dGUgb2YgYSBjaGFubmVsLiBXb3JraW5nIGZvciAKPj4gPj4gYSBsYXJnZSBYRFAgdXNl
ciBmb3IgYSBjb3VwbGUgb2YgeWVhcnMgbm93IEkgY2FuIHRlbGwgeW91IGZyb20gbXkgb3duCj4+
ID4+IGV4cGVyaWVuY2UgSSd2ZSBub3Qgb25jZSBmb3VuZCB0aGVtIHVzZWZ1bC4gSW4gZmFjdCBw
ZXItcXVldWUgc3RhdHMgYXJlCj4+ID4+IGEgbWFqb3IgUElUQSBhcyB0aGV5IGNyb3dkIHRoZSBv
dXRwdXQuICAKPj4gPgo+PiA+IE9oIG9rYXkuIE15IHZlcnkgZmlyc3QgaXRlcmF0aW9ucyB3ZXJl
IHdpdGhvdXQgdGhpcywgYnV0IHRoZW4gSQo+PiA+IGZvdW5kIG1vc3Qgb2YgdGhlIGRyaXZlcnMg
ZXhwb3NlIHRoZWlyIFhEUCBzdGF0cyBwZXItY2hhbm5lbC4gU2luY2UKPj4gPiBJIGRpZG4ndCBw
bGFuIHRvIGRlZ3JhZGUgdGhlIGZ1bmN0aW9uYWxpdHksIHRoZXkgd2VudCB0aGF0IHdheS4gIAo+
PiAKPj4gSSBwZXJzb25hbGx5IGZpbmQgdGhlIHBlci1jaGFubmVsIHN0YXRzIHF1aXRlIHVzZWZ1
bC4gT25lIG9mIHRoZSBwcmltYXJ5Cj4+IHJlYXNvbnMgZm9yIG5vdCBhY2hpZXZpbmcgZnVsbCBw
ZXJmb3JtYW5jZSB3aXRoIFhEUCBpcyBicm9rZW4KPj4gY29uZmlndXJhdGlvbiBvZiBwYWNrZXQg
c3RlZXJpbmcgdG8gQ1BVcywgYW5kIGhhdmluZyBwZXItY2hhbm5lbCBzdGF0cwo+PiBpcyBhIG5p
Y2Ugd2F5IG9mIHNlZWluZyB0aGlzLgo+Cj4gUmlnaHQsIHRoYXQncyBhYm91dCB0aGUgb25seSB0
aGluZyBJIHVzZSBpdCBmb3IgYXMgd2VsbC4gIklzIHRoZSBsb2FkCj4gZXZlbmx5IGRpc3RyaWJ1
dGVkPyIgIEJ1dCB0aGF0J3Mgbm90IFhEUCBzcGVjaWZpYyBhbmQgbm90IHdvcnRoCj4gc3RhbmRh
cmRpemluZyBmb3IsIHlldCwgSU1PLCBiZWNhdXNlLi4KPgo+PiBJIGNhbiBzZWUgdGhlIHBvaW50
IGFib3V0IHRoZW0gYmVpbmcgd2F5IHRvbyB2ZXJib3NlIGluIHRoZSBkZWZhdWx0Cj4+IG91dHB1
dCwgdGhvdWdoLCBhbmQgSSBkbyBnZW5lcmFsbHkgZmlsdGVyIHRoZSBvdXRwdXQgYXMgd2VsbCB3
aGVuCj4+IHZpZXdpbmcgdGhlbS4gQnV0IHNlZSBteSBwb2ludCBhYm92ZSBhYm91dCBvbmx5IHBy
aW50aW5nIGEgc3Vic2V0IG9mCj4+IHRoZSBzdGF0cyBieSBkZWZhdWx0OyBwZXItY2hhbm5lbCBz
dGF0cyBjb3VsZCBiZSBKU09OLW9ubHksIGZvcgo+PiBpbnN0YW5jZT8KPgo+IHdlIGRvbid0IGV2
ZW4ga25vdyB3aGF0IGNvbnN0aXR1dGVzIGEgY2hhbm5lbCB0b2RheS4gQW5kIHRoYXQgd2lsbAo+
IGJlY29tZSBpbmNyZWFzaW5nbHkgcHJvYmxlbWF0aWMgYXMgaW1wb3J0YW5jZSBvZiBhcHBsaWNh
dGlvbiBzcGVjaWZpYwo+IHF1ZXVlcyBpbmNyZWFzZXMgKHpjdGFwIGV0YykuIElNTyB1bnRpbCB0
aGUgb250b2xvZ2ljYWwgZ2FwcyBhcm91bmQKPiBxdWV1ZXMgYXJlIGZpbGxlZCB3ZSBzaG91bGQg
bGVhdmUgcGVyLXF1ZXVlIHN0YXRzIGluIGV0aHRvb2wgLVMuCgpIbW0sIHJpZ2h0LCBJIHNlZS4g
SSBzdXBwb3NlIHRoYXQgYXMgbG9uZyBhcyB0aGUgWERQIHBhY2tldHMgc2hvdyB1cCBpbgpvbmUg
b2YgdGhlIGludGVyZmFjZSBjb3VudGVycyBpbiBldGh0b29sIC1TLCBpdCdzIHBvc3NpYmxlIHRv
IGFuc3dlciB0aGUKbG9hZCBkaXN0cmlidXRpb24gaXNzdWUsIGFuZCBhbnkgZnVydGhlciBkZWJ1
Z2dpbmcgKHNheSwgWERQIGRyb3BzIG9uIGEKY2VydGFpbiBxdWV1ZSBkdWUgdG8gQ1BVLWJhc2Vk
IHF1ZXVlIGluZGV4aW5nIG9uIFRYKSBjYW4gYmUgZGVsZWdhdGVkIHRvCkJQRi1iYXNlZCB0b29s
cy4uLgoKLVRva2UKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
