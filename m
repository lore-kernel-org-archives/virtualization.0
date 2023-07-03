Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DF3EB64DC
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 21:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9457A81E65;
	Mon,  3 Jul 2023 21:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9457A81E65
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IERzY9a3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9y8-7YODh9Q9; Mon,  3 Jul 2023 21:45:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C49581831;
	Mon,  3 Jul 2023 21:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C49581831
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1970C0071;
	Mon,  3 Jul 2023 21:45:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CED26C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 21:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9574B608A5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 21:45:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9574B608A5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IERzY9a3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNSgelCL8isN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 21:45:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68570607EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68570607EC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688420716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tARB5Wn5Gx1zOd7JWlq2DBGoUqFTRjKmGP2nqR1fdFE=;
 b=IERzY9a3Y4M9qlmljSd6zTdMNh/O0mvdQ8Gsi/pKkkW3KiFbpa2hbPpp+2hfgULY5G85Nu
 CcTAPcv9RekS5cH4xmSLWKf59367Np4n7CPT/qkVy2ZOtqz08980p15ISfS1ZLEn22VUzD
 D2Wmr990MgbEExYM11gKGDKKqn3GJtY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-vV8Dj4p-OiyqLSAg3XRW0w-1; Mon, 03 Jul 2023 17:45:14 -0400
X-MC-Unique: vV8Dj4p-OiyqLSAg3XRW0w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3141325af78so3324919f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jul 2023 14:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688420713; x=1691012713;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tARB5Wn5Gx1zOd7JWlq2DBGoUqFTRjKmGP2nqR1fdFE=;
 b=Y1Sh/E+UCqf3DYADT5UEnWN8wa3FYoK8axZyU6G1hgh19Suub/4d3lY7rErEG2fxZl
 4S/LI7lzbYm++s2yROPrVctpA+a60Qx34JRawqHlsWxRMmVjuNDavI8vLhPyYfdsaZY9
 HnJMddXy9DbQOee+fOdDC6RV3H5EOpeddoo27+EdeMNfUt2NCuFGDUxtVYqhLtCD7pKv
 /XDKwW7wzskIppzKqPTn2SdgipmKcGlQz5lqXCa31DTwxVWQIatZsRkO/XVhP70ZteV0
 X2xcI9vCxXdxmOqduC6ZTBD36HlPS5xGkXDM4VLiJhKj18RyJUAzPItpi2PBR8AUdNXb
 Bj/w==
X-Gm-Message-State: ABy/qLYC3KMyUgIkzw7JY20/p1QvSK0Fi3qBg7HKXUXV5IBmg5lOZbOi
 RVbr4uU0YhFFr2crM0n3Vj7JagmX00T05Nv8SUfrNJ2HrqkNIqO73ZXGJqyNqGCejHkOpLC3znG
 tNaXO8wGjWg7FipxQeBjf6paw/DU4pxQAGLtGHw4Ogg==
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id
 n2-20020adffe02000000b00313f124aa53mr9386200wrr.45.1688420713231; 
 Mon, 03 Jul 2023 14:45:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwxrKykcKROIp8288hJK2F1DWQTpGg+15j/Wx8NbEXoDCuZbeNevgm5l58+rk/qYWMMQkJGg==
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id
 n2-20020adffe02000000b00313f124aa53mr9386193wrr.45.1688420712899; 
 Mon, 03 Jul 2023 14:45:12 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 z13-20020a056000110d00b003143d80d11dsm611369wrw.112.2023.07.03.14.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 14:45:12 -0700 (PDT)
Date: Mon, 3 Jul 2023 17:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230703174043-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
MIME-Version: 1.0
In-Reply-To: <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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

T24gTW9uLCBKdWwgMDMsIDIwMjMgYXQgMDk6NDM6NDlBTSArMDIwMCwgTWF4aW1lIENvcXVlbGlu
IHdyb3RlOgo+IAo+IE9uIDcvMy8yMyAwODo0NCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFN1
biwgSnVsIDIsIDIwMjMgYXQgOTozN+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiAKPiA+ID4gT24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMDE6MzY6
NTBQTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+ID4gPiA+IFRoaXMgc21hbGwgc2Vy
aWVzIGVuYWJsZXMgdmlydGlvLW5ldCBkZXZpY2UgdHlwZSBpbiBWRFVTRS4KPiA+ID4gPiBXaXRo
IGl0LCBiYXNpYyBvcGVyYXRpb24gaGF2ZSBiZWVuIHRlc3RlZCwgYm90aCB3aXRoCj4gPiA+ID4g
dmlydGlvLXZkcGEgYW5kIHZob3N0LXZkcGEgdXNpbmcgRFBESyBWaG9zdCBsaWJyYXJ5IHNlcmll
cwo+ID4gPiA+IGFkZGluZyBWRFVTRSBzdXBwb3J0IHVzaW5nIHNwbGl0IHJpbmdzIGxheW91dCAo
bWVyZ2VkIGluCj4gPiA+ID4gRFBESyB2MjMuMDctcmMxKS4KPiA+ID4gPiAKPiA+ID4gPiBDb250
cm9sIHF1ZXVlIHN1cHBvcnQgKGFuZCBzbyBtdWx0aXF1ZXVlKSBoYXMgYWxzbyBiZWVuCj4gPiA+
ID4gdGVzdGVkLCBidXQgcmVxdWlyZXMgYSBLZXJuZWwgc2VyaWVzIGZyb20gSmFzb24gV2FuZwo+
ID4gPiA+IHJlbGF4aW5nIGNvbnRyb2wgcXVldWUgcG9sbGluZyBbMV0gdG8gZnVuY3Rpb24gcmVs
aWFibHkuCj4gPiA+ID4gCj4gPiA+ID4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
L0NBQ0drTUV0Z3J4TjNQUHdzRG80b09zbnNTTEpmRW1CRVowV3ZqR1JyM3doVStRYXNVZ0BtYWls
LmdtYWlsLmNvbS9ULwo+ID4gPiAKPiA+ID4gSmFzb24gcHJvbWlzZWQgdG8gcG9zdCBhIG5ldyB2
ZXJzaW9uIG9mIHRoYXQgcGF0Y2guCj4gPiA+IFJpZ2h0IEphc29uPwo+ID4gCj4gPiBZZXMuCj4g
PiAKPiA+ID4gRm9yIG5vdyBsZXQncyBtYWtlIHN1cmUgQ1ZRIGZlYXR1cmUgZmxhZyBpcyBvZmY/
Cj4gPiAKPiA+IFdlIGNhbiBkbyB0aGF0IGFuZCByZWxheCBvbiB0b3Agb2YgbXkgcGF0Y2guCj4g
Cj4gSSBhZ3JlZT8gRG8geW91IHByZWZlciBhIGZlYXR1cmVzIG5lZ290aWF0aW9uLCBvciBmYWls
aW5nIGluaXQgKGxpa2UKPiBkb25lIGZvciBWRVJTSU9OXzEpIGlmIHRoZSBWRFVTRSBhcHBsaWNh
dGlvbiBhZHZlcnRpc2VzIENWUT8KPiAKPiBUaGFua3MsCj4gTWF4aW1lCgpVbmZvcnR1bmF0ZWx5
IGd1ZXN0cyBmYWlsIHByb2JlIGlmIGZlYXR1cmUgc2V0IGlzIGluY29uc2lzdGVudC4KU28gSSBk
b24ndCB0aGluayBwYXNzaW5nIHRocm91Z2ggZmVhdHVyZXMgaXMgYSBnb29kIGlkZWEsCnlvdSBu
ZWVkIGEgbGlzdCBvZiBsZWdhbCBiaXRzLiBBbmQgd2hlbiBkb2luZyB0aGlzLApjbGVhciBDVlEg
YW5kIGV2ZXJ5dGhpbmcgdGhhdCBkZXBlbmRzIG9uIGl0LgoKCgo+ID4gVGhhbmtzCj4gPiAKPiA+
ID4gCj4gPiA+ID4gUkZDIC0+IHYxIGNoYW5nZXM6Cj4gPiA+ID4gPT09PT09PT09PT09PT09PT09
Cj4gPiA+ID4gLSBGYWlsIGRldmljZSBpbml0IGlmIGl0IGRvZXMgbm90IHN1cHBvcnQgVkVSU0lP
Tl8xIChKYXNvbikKPiA+ID4gPiAKPiA+ID4gPiBNYXhpbWUgQ29xdWVsaW4gKDIpOgo+ID4gPiA+
ICAgIHZkdXNlOiB2YWxpZGF0ZSBibG9jayBmZWF0dXJlcyBvbmx5IHdpdGggYmxvY2sgZGV2aWNl
cwo+ID4gPiA+ICAgIHZkdXNlOiBlbmFibGUgVmlydGlvLW5ldCBkZXZpY2UgdHlwZQo+ID4gPiA+
IAo+ID4gPiA+ICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDE1ICsrKysr
KysrKysrLS0tLQo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4gLS0KPiA+ID4gPiAyLjQxLjAKPiA+ID4gCj4g
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
