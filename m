Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6641C77B7F
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 445A083B8C;
	Mon,  8 May 2023 06:16:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 445A083B8C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTmaaGx5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X_SOg7dgFF0H; Mon,  8 May 2023 06:16:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B97F583B8E;
	Mon,  8 May 2023 06:15:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B97F583B8E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0E97C0037;
	Mon,  8 May 2023 06:15:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63575C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DB564048D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DB564048D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTmaaGx5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNMdACSvNSrp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:15:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55DD040111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55DD040111
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683526556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a16qsR25aXRVKPUMu4eumPHJGCumyCFazBn+gGGgB/I=;
 b=BTmaaGx5fM8fSV7T6M4PGxV0DP4lmPVdMazd2LioY3iTkplKJJdkgpCC6Q3K8zPZF1V7xp
 q3FRJWhM98lFsuok1ICqnm7ucAg0BTCj/jXjDxYdCFJe4cu8Cn379VkUD4EDRQfn59vCws
 ShjWvkw1hQBasn2hFgVID4CtxngmUhQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-_BgKyrFONAmgTFL3B8w3pA-1; Mon, 08 May 2023 02:15:52 -0400
X-MC-Unique: _BgKyrFONAmgTFL3B8w3pA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so2528463f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 23:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683526551; x=1686118551;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a16qsR25aXRVKPUMu4eumPHJGCumyCFazBn+gGGgB/I=;
 b=ePOsT8xSNq4vtbLwaMZJyGcn656M4eL1r1DDJjiT4iwJieXCYD5C6JxPf+4KmcW2EE
 kDpW4mA5sE6E08N8C4Rm6C3gLyA8PrSC0rxStN8jILe8p2qtvwoObrbVc/b6rVNaWQfC
 CFs8jl6/UhiSidO48kRHeWY1H2Braak8/mL95b9EhKaui+xNDRGVb6RlEz88Lh/voJCV
 exPlaTWCxzuuC7aInrBqfjQHxg6HakUbEz9zHBMiZTeI/H5rylSuqixqAG4w25K00ZYe
 /g8LVD9XfUCQGI94jtVOH2Mn+sYhNSjCyfAyazzclYwX8i2Nv5IrkkHbCPFRIDXM2dPC
 b33A==
X-Gm-Message-State: AC+VfDxcvhM7yM++PwOLnjQP8UczD3HaQaBO/wcz7WKzv4h+LC47Dg5j
 /UQpNI0RGFsI0XqeT9wyQBdICUrJ/aXQdAiLcKcZnYCDp4ZkEkEUA2GvRLLxXx0nKMSCnUwNMrn
 /5QoQo7xr9s9ASC7X37vys+CRZoPAjgTm0NlKSGLZ5w==
X-Received: by 2002:adf:fccd:0:b0:2f5:7e67:9c68 with SMTP id
 f13-20020adffccd000000b002f57e679c68mr6231386wrs.30.1683526551627; 
 Sun, 07 May 2023 23:15:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51aIif9Zzf71VSyESMCs9ojU26BNYa4ExPKWLDuG2PEVBUuxy/OQj9y3Xq+EYvx0RZfh2HcQ==
X-Received: by 2002:adf:fccd:0:b0:2f5:7e67:9c68 with SMTP id
 f13-20020adffccd000000b002f57e679c68mr6231373wrs.30.1683526551304; 
 Sun, 07 May 2023 23:15:51 -0700 (PDT)
Received: from redhat.com ([2.52.158.28]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600010cd00b00306299be5a2sm10289776wrx.72.2023.05.07.23.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 May 2023 23:15:50 -0700 (PDT)
Date: Mon, 8 May 2023 02:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230508020953-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: zy@yusur.tech, Hao Chen <chenh@yusur.tech>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, hengqi@linux.alibaba.com,
 huangml@yusur.tech, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMTA6MDE6NTlBTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIFN1biwgNyBNYXkgMjAyMyAwNDo1ODo1OCAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtp
biIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+IE9uIFNhdCwgTWF5IDA2LCAyMDIzIGF0IDA0
OjU2OjM1UE0gKzA4MDAsIEhhbyBDaGVuIHdyb3RlOgo+ID4gPgo+ID4gPgo+ID4gPiDlnKggMjAy
My81LzYgMTA6NTAsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gT24gU2F0LCAgNiBNYXkgMjAy
MyAxMDoxNToyOSArMDgwMCwgSGFvIENoZW4gPGNoZW5oQHl1c3VyLnRlY2g+IHdyb3RlOgo+ID4g
PiA+ID4gV2hlbiBWSVJUSU9fTkVUX0ZfTVRVKDMpIERldmljZSBtYXhpbXVtIE1UVSByZXBvcnRp
bmcgaXMgc3VwcG9ydGVkLgo+ID4gPiA+ID4gSWYgb2ZmZXJlZCBieSB0aGUgZGV2aWNlLCBkZXZp
Y2UgYWR2aXNlcyBkcml2ZXIgYWJvdXQgdGhlIHZhbHVlIG9mIGl0cwo+ID4gPiA+ID4gbWF4aW11
bSBNVFUuIElmIG5lZ290aWF0ZWQsIHRoZSBkcml2ZXIgdXNlcyBtdHUgYXMgdGhlIG1heGltdW0K
PiA+ID4gPiA+IE1UVSB2YWx1ZS4gQnV0IHRoZXJlIHRoZSBkcml2ZXIgYWxzbyB1c2VzIGl0IGFz
IGRlZmF1bHQgbXR1LAo+ID4gPiA+ID4gc29tZSBkZXZpY2VzIG1heSBoYXZlIGEgbWF4aW11bSBN
VFUgZ3JlYXRlciB0aGFuIDE1MDAsIHRoaXMgbWF5Cj4gPiA+ID4gPiBjYXVzZSBzb21lIGxhcmdl
IHBhY2thZ2VzIHRvIGJlIGRpc2NhcmRlZCwKPiA+ID4gPgo+ID4gPiA+IFlvdSBtZWFuIHR4IHBh
Y2tldD8KPiA+ID4gWWVzLgo+ID4gPiA+Cj4gPiA+ID4gSWYgeWVzLCBJIGRvIG5vdCB0aGluayB0
aGlzIGlzIHRoZSBwcm9ibGVtIG9mIGRyaXZlci4KPiA+ID4gPgo+ID4gPiA+IE1heWJlIHlvdSBz
aG91bGQgZ2l2ZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIGRpc2NhcmQuCj4gPiA+ID4KPiA+ID4g
SW4gdGhlIGN1cnJlbnQgY29kZSwgaWYgdGhlIG1heGltdW0gTVRVIHN1cHBvcnRlZCBieSB0aGUg
dmlydGlvIG5ldCBoYXJkd2FyZQo+ID4gPiBpcyA5MDAwLCB0aGUgZGVmYXVsdCBNVFUgb2YgdGhl
IHZpcnRpbyBuZXQgZHJpdmVyIHdpbGwgYWxzbyBiZSBzZXQgdG8gOTAwMC4KPiA+ID4gV2hlbiBz
ZW5kaW5nIHBhY2tldHMgdGhyb3VnaCAicGluZyAtcyA1MDAwIiwgaWYgdGhlIHBlZXIgcm91dGVy
IGRvZXMgbm90Cj4gPiA+IHN1cHBvcnQgbmVnb3RpYXRpbmcgYSBwYXRoIE1UVSB0aHJvdWdoIElD
TVAgcGFja2V0cywgdGhlIHBhY2tldHMgd2lsbCBiZQo+ID4gPiBkaXNjYXJkZWQuIElmIHRoZSBw
ZWVyIHJvdXRlciBzdXBwb3J0cyBuZWdvdGlhdGluZyBwYXRoIG10dSB0aHJvdWdoIElDTVAKPiA+
ID4gcGFja2V0cywgdGhlIGhvc3Qgc2lkZSB3aWxsIHBlcmZvcm0gcGFja2V0IHNoYXJkaW5nIHBy
b2Nlc3NpbmcgYmFzZWQgb24gdGhlCj4gPiA+IG5lZ290aWF0ZWQgcGF0aCBtdHUsIHdoaWNoIGlz
IGdlbmVyYWxseSB3aXRoaW4gMTUwMC4KPiA+ID4gVGhpcyBpcyBub3QgYSBidWdmaXggcGF0Y2gs
IEkgdGhpbmsgc2V0dGluZyB0aGUgZGVmYXVsdCBtdHUgdG8gd2l0aGluIDE1MDAKPiA+ID4gd291
bGQgYmUgbW9yZSBzdWl0YWJsZSBoZXJlLlRoYW5rcy4KPiA+Cj4gPiBJIGRvbid0IHRoaW5rIFZJ
UlRJT19ORVRfRl9NVFUgaXMgYXBwcm9wcmlhdGUgZm9yIHN1cHBvcnQgZm9yIGp1bWJvIHBhY2tl
dHMuCj4gPiBUaGUgc3BlYyBzYXlzOgo+ID4gCVRoZSBkZXZpY2UgTVVTVCBmb3J3YXJkIHRyYW5z
bWl0dGVkIHBhY2tldHMgb2YgdXAgdG8gbXR1IChwbHVzIGxvdyBsZXZlbCBldGhlcm5ldCBoZWFk
ZXIgbGVuZ3RoKSBzaXplIHdpdGgKPiA+IAlnc29fdHlwZSBOT05FIG9yIEVDTiwgYW5kIGRvIHNv
IHdpdGhvdXQgZnJhZ21lbnRhdGlvbiwgYWZ0ZXIgVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBz
dWNjZXNzLQo+ID4gCWZ1bGx5IG5lZ290aWF0ZWQuCj4gPiBWSVJUSU9fTkVUX0ZfTVRVIGhhcyBi
ZWVuIGRlc2lnbmVkIGZvciBhbGwga2luZCBvZiB0dW5uZWxpbmcgZGV2aWNlcywKPiA+IGFuZCB0
aGlzIGlzIHdoeSB3ZSBzZXQgbXR1IHRvIG1heCBieSBkZWZhdWx0Lgo+ID4KPiA+IEZvciB0aGlu
Z3MgbGlrZSBqdW1ibyBmcmFtZXMgd2hlcmUgTVRVIG1pZ2h0IG9yIG1pZ2h0IG5vdCBiZSBhdmFp
bGFibGUsCj4gPiBhIG5ldyBmZWF0dXJlIHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUuCj4gCj4g
Cj4gU28gZm9yIGp1bWJvIGZyYW1lLCB3aGF0IGlzIHRoZSBwcm9ibGVtPwo+IAo+IFdlIGFyZSB0
cnlpbmcgdG8gZG8gdGhpcy4gQEhlbmcKPiAKPiBUaGFua3MuCgpJdCBpcyBub3QgYSBwcm9ibGVt
IGFzIHN1Y2guIEJ1dCBWSVJUSU9fTkVUX0ZfTVRVIHdpbGwgc2V0IHRoZQpkZWZhdWx0IE1UVSBu
b3QganVzdCB0aGUgbWF4aW11bSBvbmUsIGJlY2F1c2Ugc3BlYyBzZWVtcyB0bwpzYXkgaXQgY2Fu
LgoKCj4gCj4gPgo+ID4gPiA+ID4gc28gSSBjaGFuZ2VkIHRoZSBNVFUgdG8gYSBtb3JlCj4gPiA+
ID4gPiBnZW5lcmFsIDE1MDAgd2hlbiAnRGV2aWNlIG1heGltdW0gTVRVJyBiaWdnZXIgdGhhbiAx
NTAwLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhbyBDaGVuIDxjaGVuaEB5
dXN1ci50ZWNoPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyB8IDUgKysrKy0KPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+IGlu
ZGV4IDhkODAzODUzOGZjNC4uZTcxYzdkMWI1ZjI5IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiA+ID4gPiA+IEBAIC00MDQwLDcgKzQwNDAsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gICAJCQlnb3RvIGZy
ZWU7Cj4gPiA+ID4gPiAgIAkJfQo+ID4gPiA+ID4KPiA+ID4gPiA+IC0JCWRldi0+bXR1ID0gbXR1
Owo+ID4gPiA+ID4gKwkJaWYgKG10dSA+IDE1MDApCj4gPiA+ID4KPiA+ID4gPiBzLzE1MDAvRVRI
X0RBVEFfTEVOLwo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+Cj4gPiA+ID4gPiArCQkJ
ZGV2LT5tdHUgPSAxNTAwOwo+ID4gPiA+ID4gKwkJZWxzZQo+ID4gPiA+ID4gKwkJCWRldi0+bXR1
ID0gbXR1Owo+ID4gPiA+ID4gICAJCWRldi0+bWF4X210dSA9IG10dTsKPiA+ID4gPiA+ICAgCX0K
PiA+ID4gPiA+Cj4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gMi4yNy4wCj4gPiA+ID4gPgo+ID4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
