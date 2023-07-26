Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FECC0015E
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 01:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E52E4097D;
	Wed, 26 Jul 2023 01:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E52E4097D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LxGa2Qll
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNRUryYB4Ahp; Wed, 26 Jul 2023 01:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 613E640978;
	Wed, 26 Jul 2023 01:55:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 613E640978
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ADBAC0071;
	Wed, 26 Jul 2023 01:55:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09BAAC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7EEC6117A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7EEC6117A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LxGa2Qll
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0TN7X1ax9IFS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E7CC60F82
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E7CC60F82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690336551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0em5XVVIcyM6KNou+P9LCvLXygArrZQmd/s3crvVHcs=;
 b=LxGa2QllSc70DxKRNgjXuwQPkVNaeG8gbuc2SWkEeM8P8x9uCfMcbLs5HIqc0K7iztcfDu
 bFQnstvmijOQF/1gSrSknZXxN6cAqZC44jqTYEDMt2UfL0tyMTH+zdKNQCEe4jUZEYxQs1
 ljueNjDC+bEfIRi00DAxLjPDJPo2Ehw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-okPEDA4UNA-PhOw6cC-2CQ-1; Tue, 25 Jul 2023 21:55:50 -0400
X-MC-Unique: okPEDA4UNA-PhOw6cC-2CQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9b2fb9770so3374441fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 18:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690336548; x=1690941348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0em5XVVIcyM6KNou+P9LCvLXygArrZQmd/s3crvVHcs=;
 b=fc9EfZH9z7CXuDEuAHZzcnLk79RACh6CjV5ZJsMdbGnrS5Whzrdq2HAn7GLZpuLCYk
 OB0vRHXd8L3AF18W8Uzq03K6GniKEAEYz7/s3ibsulfJzuqUitQQOyPcU1Y1CeoG0LIc
 Nx4WP8uZpGgeIDxB/bp64qjU6Xoq4nhNpWpU41k8BtARtbNMl/oXIxQp3XD2qP/eAa59
 zLw54RCGowiiyadMAq7Db9QRYBZUNEFZKNNkD0dB6HS358/DXu6IEJrJN5fKRkYKELf0
 vaX3An4aKPIGp4SYFnVomwu9uNcIdQJzWqkHoOIllheV+Qwis76L1ZDinWl2lh2PWA2y
 B1sQ==
X-Gm-Message-State: ABy/qLY1RdpErDlS9rK+LSiojPaTBN94FQv/OwtODETE2Dna24wkNrNz
 USCyl0828dtb+nIuP7IRVzUpgRRb22FYOGrMLs2/ZVp6LyxTJqsA+8AlB93QSq3Pi+Exz9URsyl
 rNQWGIaxNuddk0pvQP4GAnFxzVhlk8QVxsxgoFHoi0e8mwvYPixtR1dR8Dw==
X-Received: by 2002:a2e:9d0f:0:b0:2b6:daed:494f with SMTP id
 t15-20020a2e9d0f000000b002b6daed494fmr314024lji.35.1690336548787; 
 Tue, 25 Jul 2023 18:55:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEb2P+4ABxLYFi0inilvrG1ps7zBAn/FmeDid5GoMQIwuWmQTbpZUHaUvKZywmBDEIsiywhW6IQznr6szo/kqs=
X-Received: by 2002:a2e:9d0f:0:b0:2b6:daed:494f with SMTP id
 t15-20020a2e9d0f000000b002b6daed494fmr314017lji.35.1690336548465; Tue, 25 Jul
 2023 18:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230725033506-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 09:55:37 +0800
Message-ID: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMzozNuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTE6MDc6NDBB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIE1vbiwgSnVsIDI0LCAyMDIzIGF0IDM6
MTfigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6MDVQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBPbiBTYXQsIEp1bCAyMiwgMjAyMyBhdCA0OjE44oCvQU0gTWF4aW1l
IENvcXVlbGluCj4gPiA+ID4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIDcvMjEvMjMgMTc6MTAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gT24gRnJpLCBKdWwgMjEsIDIwMjMg
YXQgMDQ6NTg6MDRQTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+ID4gPiA+ID4gPj4K
PiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+PiBPbiA3LzIxLzIzIDE2OjQ1LCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+Pj4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDQ6Mzc6
MDBQTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+
ID4gPj4+Pgo+ID4gPiA+ID4gPj4+PiBPbiA3LzIwLzIzIDIzOjAyLCBNaWNoYWVsIFMuIFRzaXJr
aW4gd3JvdGU6Cj4gPiA+ID4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyNjoy
MFBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+ID4+Pj4+PiBPbiA3LzIw
LzIzIDE6MzggQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4g
PiA+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxv
b3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4gPiA+Pj4+Pj4+IGNvLW9wZXJhdGlvbiB3aXRoIHRoZSBz
Y2hlZHVsZXIuIFRoaXMgYWxsb3dzIHRvIGdpdmUgQ1BVIGEgYnJlYXRoIHRvCj4gPiA+ID4gPiA+
Pj4+Pj4+IHJ1biBvdGhlciB0YXNrKHdvcmtxdWV1ZSkgaW5zdGVhZCBvZiBidXN5IGxvb3Bpbmcg
d2hlbiBwcmVlbXB0aW9uIGlzCj4gPiA+ID4gPiA+Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2
aWNlIHdob3NlIENWUSBtaWdodCBiZSBzbG93Lgo+ID4gPiA+ID4gPj4+Pj4+Pgo+ID4gPiA+ID4g
Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
ID4gPiA+ID4gPj4+Pj4+Cj4gPiA+ID4gPiA+Pj4+Pj4gVGhpcyBzdGlsbCBsZWF2ZXMgaHVuZyBw
cm9jZXNzZXMsIGJ1dCBhdCBsZWFzdCBpdCBkb2Vzbid0IHBpbiB0aGUgQ1BVIGFueQo+ID4gPiA+
ID4gPj4+Pj4+IG1vcmUuICBUaGFua3MuCj4gPiA+ID4gPiA+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFNo
YW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4gPiA+ID4gPj4+Pj4+Cj4g
PiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPj4+Pj4gSSdkIGxpa2UgdG8gc2VlIGEgZnVsbCBzb2x1
dGlvbgo+ID4gPiA+ID4gPj4+Pj4gMS0gYmxvY2sgdW50aWwgaW50ZXJydXB0Cj4gPiA+ID4KPiA+
ID4gPiBJIHJlbWVtYmVyIGluIHByZXZpb3VzIHZlcnNpb25zLCB5b3Ugd29ycmllZCBhYm91dCB0
aGUgZXh0cmEgTVNJCj4gPiA+ID4gdmVjdG9yLiAoTWF5YmUgSSB3YXMgd3JvbmcpLgo+ID4gPiA+
Cj4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPiA+Pj4+IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gYWxz
byBoYXZlIGEgdGltZW91dD8KPiA+ID4gPiA+ID4+Pj4gQW5kIHdoZW4gdGltZW91dCBleHBpcmVz
LCBzZXQgRkFJTEVEIGJpdCBpbiBkZXZpY2Ugc3RhdHVzPwo+ID4gPiA+ID4gPj4+Cj4gPiA+ID4g
PiA+Pj4gdmlydGlvIHNwZWMgZG9lcyBub3Qgc2V0IGFueSBsaW1pdHMgb24gdGhlIHRpbWluZyBv
ZiB2cQo+ID4gPiA+ID4gPj4+IHByb2Nlc3NpbmcuCj4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPj4g
SW5kZWVkLCBidXQgSSB0aG91Z2h0IHRoZSBkcml2ZXIgY291bGQgZGVjaWRlIGl0IGlzIHRvbyBs
b25nIGZvciBpdC4KPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+PiBUaGUgaXNzdWUgaXMgd2Uga2Vl
cCB3YWl0aW5nIHdpdGggcnRubCBsb2NrZWQsIGl0IGNhbiBxdWlja2x5IG1ha2UgdGhlCj4gPiA+
ID4gPiA+PiBzeXN0ZW0gdW51c2FibGUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IGlmIHRoaXMg
aXMgYSBwcm9ibGVtIHdlIHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0byBrZWVwIHJ0bmwKPiA+ID4g
PiA+ID4gbG9ja2VkIGluZGVmaW5pdGVseS4KPiA+ID4gPgo+ID4gPiA+IEFueSBpZGVhcyBvbiB0
aGlzIGRpcmVjdGlvbj8gU2ltcGx5IGRyb3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxvb3AK
PiA+ID4gPiB3aWxsIHJlc3VsdCBpbiBhIGxvdCBvZiByYWNlcy4gVGhpcyBzZWVtcyB0byByZXF1
aXJlIG5vbi10cml2aWFsCj4gPiA+ID4gY2hhbmdlcyBpbiB0aGUgbmV0d29ya2luZyBjb3JlLgo+
ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gIEZyb20gdGhlIHRlc3RzIEkgaGF2ZSBkb25lLCBJ
IHRoaW5rIGl0IGlzLiBXaXRoIE9WUywgYSByZWNvbmZpZ3VyYXRpb24KPiA+ID4gPiA+IGlzIHBl
cmZvcm1lZCB3aGVuIHRoZSBWRFVTRSBkZXZpY2UgaXMgYWRkZWQsIGFuZCB3aGVuIGEgTUxYNSBk
ZXZpY2UgaXMKPiA+ID4gPiA+IGluIHRoZSBzYW1lIGJyaWRnZSwgaXQgZW5kcyB1cCBkb2luZyBh
biBpb2N0bCgpIHRoYXQgdHJpZXMgdG8gdGFrZSB0aGUKPiA+ID4gPiA+IHJ0bmwgbG9jay4gSW4g
dGhpcyBjb25maWd1cmF0aW9uLCBpdCBpcyBub3QgcG9zc2libGUgdG8ga2lsbCBPVlMgYmVjYXVz
ZQo+ID4gPiA+ID4gaXQgaXMgc3R1Y2sgdHJ5aW5nIHRvIGFjcXVpcmUgcnRubCBsb2NrIGZvciBt
bHg1IHRoYXQgaXMgaGVsZCBieSB2aXJ0aW8tCj4gPiA+ID4gPiBuZXQuCj4gPiA+ID4KPiA+ID4g
PiBZZWFoLCBiYXNpY2FsbHksIGFueSBSVE5MIHVzZXJzIHdvdWxkIGJlIGJsb2NrZWQgZm9yZXZl
ci4KPiA+ID4gPgo+ID4gPiA+IEFuZCB0aGUgaW5maW5pdGUgbG9vcCBoYXMgb3RoZXIgc2lkZSBl
ZmZlY3RzIGxpa2UgaXQgYmxvY2tzIHRoZSBmcmVlemVyIHRvIHdvcmsuCj4gPiA+ID4KPiA+ID4g
PiBUbyBzdW1tYXJpemUsIHRoZXJlIGFyZSB0aHJlZSBpc3N1ZXMKPiA+ID4gPgo+ID4gPiA+IDEp
IGJ1c3kgcG9sbGluZwo+ID4gPiA+IDIpIGJyZWFrcyBmcmVlemVyCj4gPiA+ID4gMykgaG9sZCBS
VE5MIGR1cmluZyB0aGUgbG9vcAo+ID4gPiA+Cj4gPiA+ID4gU29sdmluZyAzIG1heSBoZWxwIHNv
bWVob3cgZm9yIDIgZS5nIHNvbWUgcG0gcm91dGluZSBlLmcgd2lyZWd1YXJkIG9yCj4gPiA+ID4g
ZXZlbiB2aXJ0bmV0X3Jlc3RvcmUoKSBpdHNlbGYgbWF5IHRyeSB0byBob2xkIHRoZSBsb2NrLgo+
ID4gPgo+ID4gPiBZZXAuIFNvIG15IGZlZWxpbmcgY3VycmVudGx5IGlzLCB0aGUgb25seSByZWFs
IGZpeCBpcyB0byBhY3R1YWxseQo+ID4gPiBxdWV1ZSB1cCB0aGUgd29yayBpbiBzb2Z0d2FyZS4K
PiA+Cj4gPiBEbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlrZToKPiA+Cj4gPiBydG5sX2xvY2soKTsK
PiA+IHF1ZXVlIHVwIHRoZSB3b3JrCj4gPiBydG5sX3VubG9jaygpOwo+ID4gcmV0dXJuIHN1Y2Nl
c3M7Cj4gPgo+ID4gPwo+Cj4geWVzCgpXZSB3aWxsIGxvc2UgdGhlIGVycm9yIHJlcG9ydGluZywg
aXMgaXQgYSByZWFsIHByb2JsZW0gb3Igbm90PwoKPgo+Cj4gPiA+IEl0J3MgbW9zdGx5IHRyaXZp
YWwgdG8gbGltaXQKPiA+ID4gbWVtb3J5IGNvbnN1bXB0aW9uLCB2aWQncyBpcyB0aGUKPiA+ID4g
b25seSBvbmUgd2hlcmUgaXQgd291bGQgbWFrZSBzZW5zZSB0byBoYXZlIG1vcmUgdGhhbgo+ID4g
PiAxIGNvbW1hbmQgb2YgYSBnaXZlbiB0eXBlIG91dHN0YW5kaW5nLgo+ID4KPiA+IEFuZCByeCBt
b2RlIHNvIHRoaXMgaW1wbGllcyB3ZSB3aWxsIGZhaWwgYW55IGNvbW1hbmQgaWYgdGhlIHByZXZp
b3VzCj4gPiB3b3JrIGlzIG5vdCBmaW5pc2hlZC4KPgo+IGRvbid0IGZhaWwgaXQsIHN0b3JlIGl0
LgoKT2suCgpUaGFua3MKCj4KPiA+ID4gaGF2ZSBhIHRyZWUKPiA+ID4gb3IgYSBiaXRtYXAgd2l0
aCB2aWRzIHRvIGFkZC9yZW1vdmU/Cj4gPgo+ID4gUHJvYmFibHkuCj4gPgo+ID4gVGhhbmtzCj4g
Pgo+ID4gPgo+ID4gPgo+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4+Pj4+
IDItIHN0aWxsIGhhbmRsZSBzdXJwcmlzZSByZW1vdmFsIGNvcnJlY3RseSBieSB3YWtpbmcgaW4g
dGhhdCBjYXNlCj4gPiA+ID4KPiA+ID4gPiBUaGlzIGlzIGJhc2ljYWxseSB3aGF0IHZlcnNpb24g
MSBkaWQ/Cj4gPiA+ID4KPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzYwMjZl
ODAxLTZmZGEtZmVlOS1hNjliLWQwNmE4MDM2ODYyMUByZWRoYXQuY29tL3QvCj4gPiA+ID4KPiA+
ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4gWWVzIC0gZXhjZXB0IHRoZSB0aW1lb3V0IHBhcnQuCj4g
PiA+Cj4gPiA+Cj4gPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPj4+Pj4KPiA+ID4gPiA+ID4+Pj4+
Cj4gPiA+ID4gPiA+Pj4+Pj4+IC0tLQo+ID4gPiA+ID4gPj4+Pj4+PiAgICAgIGRyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyB8IDQgKysrLQo+ID4gPiA+ID4gPj4+Pj4+PiAgICAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4+Pj4+Pj4KPiA+
ID4gPiA+ID4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPj4+Pj4+PiBpbmRleCA5ZjNiMWQ2YWMz
M2QuLmU3NTMzZjI5YjIxOSAxMDA2NDQKPiA+ID4gPiA+ID4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+ID4gPiA+ID4gPj4+Pj4+PiBAQCAtMjMxNCw4ICsyMzE0LDEwIEBAIHN0YXRpYyBi
b29sIHZpcnRuZXRfc2VuZF9jb21tYW5kKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCB1OCBjbGFz
cywgdTggY21kLAo+ID4gPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICAgKiBpbnRvIHRoZSBoeXBl
cnZpc29yLCBzbyB0aGUgcmVxdWVzdCBzaG91bGQgYmUgaGFuZGxlZCBpbW1lZGlhdGVseS4KPiA+
ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgICovCj4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgICAg
ICAgIHdoaWxlICghdmlydHF1ZXVlX2dldF9idWYodmktPmN2cSwgJnRtcCkgJiYKPiA+ID4gPiA+
ID4+Pj4+Pj4gLSAgICAgICAgICAgICAgIXZpcnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpCj4g
PiA+ID4gPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgICF2aXJ0cXVldWVfaXNfYnJva2VuKHZpLT5j
dnEpKSB7Cj4gPiA+ID4gPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQoKTsK
PiA+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICBjcHVfcmVsYXgoKTsKPiA+ID4g
PiA+ID4+Pj4+Pj4gKyAgICAgICB9Cj4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPiA+Pj4+Pj4+
ICAgICAgICAgICAgIHJldHVybiB2aS0+Y3RybC0+c3RhdHVzID09IFZJUlRJT19ORVRfT0s7Cj4g
PiA+ID4gPiA+Pj4+Pj4+ICAgICAgfQo+ID4gPiA+ID4gPj4+Pj4+PiAtLQo+ID4gPiA+ID4gPj4+
Pj4+PiAyLjM5LjMKPiA+ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+ID4+Pj4+Pj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+ID4gPiA+ID4+Pj4+Pj4g
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gPiA+ID4gPiA+Pj4+Pj4+IFZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gPiA+ID4gPiA+Pj4+Pj4+IGh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
Cj4gPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
