Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C96EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 06:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51A3041F28;
	Thu, 27 Jul 2023 06:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51A3041F28
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cULvxet3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2VIDupj5mEI; Thu, 27 Jul 2023 06:10:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 103C441F32;
	Thu, 27 Jul 2023 06:10:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 103C441F32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D97CDC0072;
	Thu, 27 Jul 2023 06:10:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE9AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67987417BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:10:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67987417BD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cULvxet3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-AGFfClrS93
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:10:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00EF4401A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00EF4401A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690438236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Md4SRid1hDg9nGCkfKo1X89jQCVvHHyaEAACgzafNkc=;
 b=cULvxet3r1ESEMfE7B7XX56gmtmHKmF+AYa0LojDENOTBPdoU2a68+UCJNfXlvn+otTaI5
 xOghi9BT+TY5G9hBqYBharCSfkcK7KCdepDx5iaJMwKox2cluZwMUul+ogQZBRJhcy/gaA
 0XOXrPt0XY50GWGWztrsETOYO3RryZ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-GoIH5700Pg-sU4LK-GjffA-1; Thu, 27 Jul 2023 02:10:33 -0400
X-MC-Unique: GoIH5700Pg-sU4LK-GjffA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fd2e59bc53so3030115e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 23:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690438232; x=1691043032;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Md4SRid1hDg9nGCkfKo1X89jQCVvHHyaEAACgzafNkc=;
 b=UnhCVW55t8uVofA4p+j4xidlbSSHaHo/LVkvA/b5wPWEJ1KtsBdI1xFQRjEic1YXSn
 PlQBw4z8TVhp2cXo6FYnDmhgbSlOOx0AwPjsdaPp+uqk6FQj1T8yMuCwVH4EYXiOlaVW
 PJu521F6sfME98N+CHvulULMQsjTiZAc39iXCTJOxVW6GmJvJGEqcTugxoPrm+GFQH24
 wJuiltDdSV7ysVS052sto177XkwjTZAyQW/4du24aGFT9E39ICtiokbmmkhDLBK8XE6i
 bRXsq++JJPpZVTuSuqPf1oGPeywEG+0qL4QAJtwWrJ6cjcP7ULvN8YxFRNYFWW3gCFjd
 lZYg==
X-Gm-Message-State: ABy/qLZDIteEU1LQ+WocTWJKzgQWK47ZFrzgEXpL8wYGPBI0pFNgK1ZX
 AgVf/mX9qCoS0Do5L3AKVfCukkJMEcHiBVpLyHyxCJee9YzH5crrMENnbh9DkWC3dF1kAxDeajB
 BRWtsHMQDUItYfp9e6LikKY55eZWEH2ZJnmH5dBUpWA==
X-Received: by 2002:a1c:4c0f:0:b0:3fd:2f8e:2c69 with SMTP id
 z15-20020a1c4c0f000000b003fd2f8e2c69mr833441wmf.32.1690438232198; 
 Wed, 26 Jul 2023 23:10:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWUV7J6CiJBzfD+xPifRyv8cgXYmKJozN4Bl5HrvqQlHyOWlIxZSJGr1lK4NMKNUKNcejm0Q==
X-Received: by 2002:a1c:4c0f:0:b0:3fd:2f8e:2c69 with SMTP id
 z15-20020a1c4c0f000000b003fd2f8e2c69mr833433wmf.32.1690438231845; 
 Wed, 26 Jul 2023 23:10:31 -0700 (PDT)
Received: from redhat.com ([31.187.78.131]) by smtp.gmail.com with ESMTPSA id
 l23-20020a7bc457000000b003fc02219081sm880016wmi.33.2023.07.26.23.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 23:10:31 -0700 (PDT)
Date: Thu, 27 Jul 2023 02:10:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230727020930-mutt-send-email-mst@kernel.org>
References: <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMDI6MDM6NTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCA3OjM44oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQg
MDk6NTU6MzdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gVHVlLCBKdWwgMjUs
IDIwMjMgYXQgMzozNuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTE6MDc6NDBBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDI0LCAyMDIzIGF0
IDM6MTfigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6MDVQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBTYXQsIEp1bCAyMiwgMjAy
MyBhdCA0OjE44oCvQU0gTWF4aW1lIENvcXVlbGluCj4gPiA+ID4gPiA+ID4gPG1heGltZS5jb3F1
ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIDcvMjEvMjMgMTc6MTAsIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCBKdWwgMjEsIDIwMjMg
YXQgMDQ6NTg6MDRQTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+PiBPbiA3LzIxLzIzIDE2
OjQ1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gT24gRnJp
LCBKdWwgMjEsIDIwMjMgYXQgMDQ6Mzc6MDBQTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3Rl
Ogo+ID4gPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+
ID4gPj4+PiBPbiA3LzIwLzIzIDIzOjAyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyNjoyMFBNIC0wNzAw
LCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4+Pj4+PiBPbiA3LzIwLzIz
IDE6MzggQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+
ID4gPiA+ID4gPiA+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3
YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IGNvLW9wZXJh
dGlvbiB3aXRoIHRoZSBzY2hlZHVsZXIuIFRoaXMgYWxsb3dzIHRvIGdpdmUgQ1BVIGEgYnJlYXRo
IHRvCj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IHJ1biBvdGhlciB0YXNrKHdvcmtxdWV1ZSkgaW5z
dGVhZCBvZiBidXN5IGxvb3Bpbmcgd2hlbiBwcmVlbXB0aW9uIGlzCj4gPiA+ID4gPiA+ID4gPiA+
Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdob3NlIENWUSBtaWdodCBiZSBzbG93Lgo+
ID4gPiA+ID4gPiA+ID4gPj4+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPj4+
Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4gVGhpcyBzdGlsbCBsZWF2ZXMgaHVuZyBwcm9jZXNz
ZXMsIGJ1dCBhdCBsZWFzdCBpdCBkb2Vzbid0IHBpbiB0aGUgQ1BVIGFueQo+ID4gPiA+ID4gPiA+
ID4gPj4+Pj4+IG1vcmUuICBUaGFua3MuCj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4gUmV2aWV3ZWQt
Ynk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4gPiA+ID4gPiA+
ID4gPj4+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4gSSdk
IGxpa2UgdG8gc2VlIGEgZnVsbCBzb2x1dGlvbgo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4gMS0gYmxv
Y2sgdW50aWwgaW50ZXJydXB0Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIHJlbWVtYmVy
IGluIHByZXZpb3VzIHZlcnNpb25zLCB5b3Ugd29ycmllZCBhYm91dCB0aGUgZXh0cmEgTVNJCj4g
PiA+ID4gPiA+ID4gdmVjdG9yLiAoTWF5YmUgSSB3YXMgd3JvbmcpLgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+IFdvdWxkIGl0IG1ha2Ugc2Vu
c2UgdG8gYWxzbyBoYXZlIGEgdGltZW91dD8KPiA+ID4gPiA+ID4gPiA+ID4+Pj4gQW5kIHdoZW4g
dGltZW91dCBleHBpcmVzLCBzZXQgRkFJTEVEIGJpdCBpbiBkZXZpY2Ugc3RhdHVzPwo+ID4gPiA+
ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+ID4gPiA+Pj4gdmlydGlvIHNwZWMgZG9lcyBub3Qgc2V0
IGFueSBsaW1pdHMgb24gdGhlIHRpbWluZyBvZiB2cQo+ID4gPiA+ID4gPiA+ID4gPj4+IHByb2Nl
c3NpbmcuCj4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPj4gSW5kZWVkLCBidXQg
SSB0aG91Z2h0IHRoZSBkcml2ZXIgY291bGQgZGVjaWRlIGl0IGlzIHRvbyBsb25nIGZvciBpdC4K
PiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+PiBUaGUgaXNzdWUgaXMgd2Uga2Vl
cCB3YWl0aW5nIHdpdGggcnRubCBsb2NrZWQsIGl0IGNhbiBxdWlja2x5IG1ha2UgdGhlCj4gPiA+
ID4gPiA+ID4gPiA+PiBzeXN0ZW0gdW51c2FibGUuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+IGlmIHRoaXMgaXMgYSBwcm9ibGVtIHdlIHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0
byBrZWVwIHJ0bmwKPiA+ID4gPiA+ID4gPiA+ID4gbG9ja2VkIGluZGVmaW5pdGVseS4KPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFueSBpZGVhcyBvbiB0aGlzIGRpcmVjdGlvbj8gU2ltcGx5
IGRyb3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxvb3AKPiA+ID4gPiA+ID4gPiB3aWxsIHJl
c3VsdCBpbiBhIGxvdCBvZiByYWNlcy4gVGhpcyBzZWVtcyB0byByZXF1aXJlIG5vbi10cml2aWFs
Cj4gPiA+ID4gPiA+ID4gY2hhbmdlcyBpbiB0aGUgbmV0d29ya2luZyBjb3JlLgo+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gIEZyb20gdGhlIHRlc3RzIEkgaGF2
ZSBkb25lLCBJIHRoaW5rIGl0IGlzLiBXaXRoIE9WUywgYSByZWNvbmZpZ3VyYXRpb24KPiA+ID4g
PiA+ID4gPiA+IGlzIHBlcmZvcm1lZCB3aGVuIHRoZSBWRFVTRSBkZXZpY2UgaXMgYWRkZWQsIGFu
ZCB3aGVuIGEgTUxYNSBkZXZpY2UgaXMKPiA+ID4gPiA+ID4gPiA+IGluIHRoZSBzYW1lIGJyaWRn
ZSwgaXQgZW5kcyB1cCBkb2luZyBhbiBpb2N0bCgpIHRoYXQgdHJpZXMgdG8gdGFrZSB0aGUKPiA+
ID4gPiA+ID4gPiA+IHJ0bmwgbG9jay4gSW4gdGhpcyBjb25maWd1cmF0aW9uLCBpdCBpcyBub3Qg
cG9zc2libGUgdG8ga2lsbCBPVlMgYmVjYXVzZQo+ID4gPiA+ID4gPiA+ID4gaXQgaXMgc3R1Y2sg
dHJ5aW5nIHRvIGFjcXVpcmUgcnRubCBsb2NrIGZvciBtbHg1IHRoYXQgaXMgaGVsZCBieSB2aXJ0
aW8tCj4gPiA+ID4gPiA+ID4gPiBuZXQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBZZWFo
LCBiYXNpY2FsbHksIGFueSBSVE5MIHVzZXJzIHdvdWxkIGJlIGJsb2NrZWQgZm9yZXZlci4KPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFuZCB0aGUgaW5maW5pdGUgbG9vcCBoYXMgb3RoZXIg
c2lkZSBlZmZlY3RzIGxpa2UgaXQgYmxvY2tzIHRoZSBmcmVlemVyIHRvIHdvcmsuCj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBUbyBzdW1tYXJpemUsIHRoZXJlIGFyZSB0aHJlZSBpc3N1ZXMK
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IDEpIGJ1c3kgcG9sbGluZwo+ID4gPiA+ID4gPiA+
IDIpIGJyZWFrcyBmcmVlemVyCj4gPiA+ID4gPiA+ID4gMykgaG9sZCBSVE5MIGR1cmluZyB0aGUg
bG9vcAo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gU29sdmluZyAzIG1heSBoZWxwIHNvbWVo
b3cgZm9yIDIgZS5nIHNvbWUgcG0gcm91dGluZSBlLmcgd2lyZWd1YXJkIG9yCj4gPiA+ID4gPiA+
ID4gZXZlbiB2aXJ0bmV0X3Jlc3RvcmUoKSBpdHNlbGYgbWF5IHRyeSB0byBob2xkIHRoZSBsb2Nr
Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBZZXAuIFNvIG15IGZlZWxpbmcgY3VycmVudGx5IGlz
LCB0aGUgb25seSByZWFsIGZpeCBpcyB0byBhY3R1YWxseQo+ID4gPiA+ID4gPiBxdWV1ZSB1cCB0
aGUgd29yayBpbiBzb2Z0d2FyZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBEbyB5b3UgbWVhbiBzb21l
dGhpbmcgbGlrZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBydG5sX2xvY2soKTsKPiA+ID4gPiA+IHF1
ZXVlIHVwIHRoZSB3b3JrCj4gPiA+ID4gPiBydG5sX3VubG9jaygpOwo+ID4gPiA+ID4gcmV0dXJu
IHN1Y2Nlc3M7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPwo+ID4gPiA+Cj4gPiA+ID4geWVzCj4gPiA+
Cj4gPiA+IFdlIHdpbGwgbG9zZSB0aGUgZXJyb3IgcmVwb3J0aW5nLCBpcyBpdCBhIHJlYWwgcHJv
YmxlbSBvciBub3Q/Cj4gPgo+ID4gRnVuZGFtZW50YWwgaXNuJ3QgaXQ/IE1heWJlIHdlIHdhbnQg
YSBwZXItZGV2aWNlIGZsYWcgZm9yIGEgYXN5bmNoIGNvbW1hbmRzLAo+ID4gYW5kIHZkdXNlIHdp
bGwgc2V0IGl0IHdoaWxlIGhhcmR3YXJlIHZpcnRpbyB3b24ndC4KPiA+IHRoaXMgd2F5IHdlIG9u
bHkgbG9zZSBlcnJvciByZXBvcnRpbmcgZm9yIHZkdXNlLgo+IAo+IFRoaXMgcHJvYmxlbSBpcyBu
b3QgVkRVU0Ugc3BlY2lmaWMsIERQVXMvdkRQQSBtYXkgc3VmZmVyIGZyb20gdGhpcyBhcwo+IHdl
bGwuIFRoaXMgbWlnaHQgcmVxdWlyZSBtb3JlIHRob3VnaHRzLgo+IAo+IFRoYW5rcwoKVGhleSBy
ZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8KcHJvZ3JhbSB3
aWxsIGNyZWF0ZSBpc3N1ZXMgaW4gdGhlIG5ldHdvcmtpbmcgc3RhY2suCkJ1dCBpZiB0aGV5IGRv
IHRoZXkgY2FuIGFsd2F5cyBzZXQgdGhpcyBmbGFnIHRvby4KCj4gPgo+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+ID4gSXQncyBtb3N0bHkgdHJpdmlhbCB0byBsaW1pdAo+ID4gPiA+ID4gPiBtZW1v
cnkgY29uc3VtcHRpb24sIHZpZCdzIGlzIHRoZQo+ID4gPiA+ID4gPiBvbmx5IG9uZSB3aGVyZSBp
dCB3b3VsZCBtYWtlIHNlbnNlIHRvIGhhdmUgbW9yZSB0aGFuCj4gPiA+ID4gPiA+IDEgY29tbWFu
ZCBvZiBhIGdpdmVuIHR5cGUgb3V0c3RhbmRpbmcuCj4gPiA+ID4gPgo+ID4gPiA+ID4gQW5kIHJ4
IG1vZGUgc28gdGhpcyBpbXBsaWVzIHdlIHdpbGwgZmFpbCBhbnkgY29tbWFuZCBpZiB0aGUgcHJl
dmlvdXMKPiA+ID4gPiA+IHdvcmsgaXMgbm90IGZpbmlzaGVkLgo+ID4gPiA+Cj4gPiA+ID4gZG9u
J3QgZmFpbCBpdCwgc3RvcmUgaXQuCj4gPiA+Cj4gPiA+IE9rLgo+ID4gPgo+ID4gPiBUaGFua3MK
PiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gPiBoYXZlIGEgdHJlZQo+ID4gPiA+ID4gPiBvciBhIGJp
dG1hcCB3aXRoIHZpZHMgdG8gYWRkL3JlbW92ZT8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBQcm9iYWJs
eS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPj4+Pj4gMi0gc3RpbGwgaGFuZGxlIHN1cnByaXNlIHJlbW92YWwgY29ycmVj
dGx5IGJ5IHdha2luZyBpbiB0aGF0IGNhc2UKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRo
aXMgaXMgYmFzaWNhbGx5IHdoYXQgdmVyc2lvbiAxIGRpZD8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNjAyNmU4MDEtNmZkYS1mZWU5LWE2
OWItZDA2YTgwMzY4NjIxQHJlZGhhdC5jb20vdC8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBZZXMgLSBleGNlcHQgdGhlIHRpbWVvdXQg
cGFydC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+
ID4gPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4+
Pj4+Pj4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIHwgNCArKystCj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+
Pgo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+
IGluZGV4IDlmM2IxZDZhYzMzZC4uZTc1MzNmMjliMjE5IDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4g
Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPiA+ID4+
Pj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPiA+Pj4+
Pj4+IEBAIC0yMzE0LDggKzIzMTQsMTAgQEAgc3RhdGljIGJvb2wgdmlydG5ldF9zZW5kX2NvbW1h
bmQoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHU4IGNsYXNzLCB1OCBjbWQsCj4gPiA+ID4gPiA+
ID4gPiA+Pj4+Pj4+ICAgICAgICAgICAgICAqIGludG8gdGhlIGh5cGVydmlzb3IsIHNvIHRoZSBy
ZXF1ZXN0IHNob3VsZCBiZSBoYW5kbGVkIGltbWVkaWF0ZWx5Lgo+ID4gPiA+ID4gPiA+ID4gPj4+
Pj4+PiAgICAgICAgICAgICAgKi8KPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAg
d2hpbGUgKCF2aXJ0cXVldWVfZ2V0X2J1Zih2aS0+Y3ZxLCAmdG1wKSAmJgo+ID4gPiA+ID4gPiA+
ID4gPj4+Pj4+PiAtICAgICAgICAgICAgICAhdmlydHF1ZXVlX2lzX2Jyb2tlbih2aS0+Y3ZxKSkK
PiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgICAgICAgIXZpcnRxdWV1ZV9pc19icm9r
ZW4odmktPmN2cSkpIHsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGNv
bmRfcmVzY2hlZCgpOwo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICAgICAgICAg
IGNwdV9yZWxheCgpOwo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiArICAgICAgIH0KPiA+ID4gPiA+
ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgcmV0dXJu
IHZpLT5jdHJsLT5zdGF0dXMgPT0gVklSVElPX05FVF9PSzsKPiA+ID4gPiA+ID4gPiA+ID4+Pj4+
Pj4gICAgICB9Cj4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IC0tCj4gPiA+ID4gPiA+ID4gPiA+Pj4+
Pj4+IDIuMzkuMwo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gPiA+
ID4gPiA+ID4gPj4+Pj4+PiBWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPiA+ID4gPiA+ID4g
PiA+ID4+Pj4+Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiA+
ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+
ID4gPiA+ID4gPiA+Pj4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
