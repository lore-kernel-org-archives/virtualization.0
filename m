Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09FAC001DE
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 11:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FE9960807;
	Wed, 26 Jul 2023 11:38:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FE9960807
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dX0F277j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zFmoYe1MXA9k; Wed, 26 Jul 2023 11:38:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6D276077D;
	Wed, 26 Jul 2023 11:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6D276077D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81DF8C0072;
	Wed, 26 Jul 2023 11:38:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA65FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A169B40448
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:38:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A169B40448
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dX0F277j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PP8gzxLb1ZhF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:38:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9706840533
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:38:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9706840533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690371487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xorJN/SDeKDU05gI5Z3c6dVEpJ3v55zBDQHrXJxgaKI=;
 b=dX0F277jZIgYi9Umc9mMEiz4o0MNuZpO+tLj+cLJu0skwiQge9Kv+uLBiy+3coteoN4UaF
 +uPm0uoq0Maw+Vtr15eHUnDcGKAF4eIJqw+voXnAOCXbrqpkFpvx0v4y09WkqHZUgEZ4pp
 I75MhiLXbxHKSidud33JXdSqtCQfNmc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-uZzKfqXkNvm0KYLYKbTqfQ-1; Wed, 26 Jul 2023 07:38:04 -0400
X-MC-Unique: uZzKfqXkNvm0KYLYKbTqfQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993c24f3246so98099866b.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 04:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690371483; x=1690976283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xorJN/SDeKDU05gI5Z3c6dVEpJ3v55zBDQHrXJxgaKI=;
 b=S5AcTEqAt3HSyFSOZCjG68TnFZYaetNdZHbDuac0Zb6xMnmQUERuTJgQoJECSwc2IN
 hOr4OPNCWxk8IAMSnks1wiUaF8XXqtJ3fpyEJMT4gWKq9mZHv2bn0eBCLSX4Gp+gaUx+
 RYGml52qfQJ/fSz5EQpF50z/ybfFsy2y+ULV+bnNtw8OaWyzFjQxNZqyNy4Xc2mxquQL
 1IbrKm+nmWibDuQz4eCA2VLhcMKoHtMSWlXHyutQElqLpAtB6vDzX96g1xtTW4nRNHTt
 Ec31xUuG7ibQee9jongojYTm1J2H2fOlYo/RMazYgNkA2cy/krjjGl3jO5PpKK1SIYTO
 ZXFg==
X-Gm-Message-State: ABy/qLZ+t1PbiPPW3bcmrDOt9IiT7heIyMuhsPViT7P2nLDwDBF7hZ8b
 doAmBFelskYlb948E1/Rk1oSSMfyN+6GuF1emKU+m58BHFN2oUtzSmtOoAxM0JtlrbF+QSqDvXd
 1sJz4wTHfIm5JqLD7rQcQQr3rT/QHRNrKceOmA8JWfQ==
X-Received: by 2002:a17:907:9625:b0:993:f664:ce25 with SMTP id
 gb37-20020a170907962500b00993f664ce25mr6492990ejc.19.1690371483225; 
 Wed, 26 Jul 2023 04:38:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFYkMeOUHXBWug6XiU5fsOsY8Kp4ZKa+es8U5cNa9A8iPD+KWT7NKkXZCNXoWYMOJrpJOVygQ==
X-Received: by 2002:a17:907:9625:b0:993:f664:ce25 with SMTP id
 gb37-20020a170907962500b00993f664ce25mr6492975ejc.19.1690371482888; 
 Wed, 26 Jul 2023 04:38:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:be95:2796:17af:f46c:dea1])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a17090694c400b009930042510csm9538412ejy.222.2023.07.26.04.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 04:37:49 -0700 (PDT)
Date: Wed, 26 Jul 2023 07:37:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230726073453-mutt-send-email-mst@kernel.org>
References: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
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

T24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMDk6NTU6MzdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAzOjM24oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQg
MTE6MDc6NDBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gTW9uLCBKdWwgMjQs
IDIwMjMgYXQgMzoxN+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6MDVQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIFNhdCwgSnVsIDIyLCAyMDIzIGF0
IDQ6MTjigK9BTSBNYXhpbWUgQ29xdWVsaW4KPiA+ID4gPiA+IDxtYXhpbWUuY29xdWVsaW5AcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IE9uIDcvMjEvMjMgMTc6MTAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4g
PiA+ID4gPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBhdCAwNDo1ODowNFBNICswMjAwLCBNYXhpbWUg
Q29xdWVsaW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+
ID4+IE9uIDcvMjEvMjMgMTY6NDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+
ID4gPj4+IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDA0OjM3OjAwUE0gKzAyMDAsIE1heGltZSBD
b3F1ZWxpbiB3cm90ZToKPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4g
PiA+ID4+Pj4gT24gNy8yMC8yMyAyMzowMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4g
PiA+ID4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyNjoyMFBNIC0wNzAwLCBT
aGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+ID4gPj4+Pj4+IE9uIDcvMjAvMjMgMTozOCBB
TSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPj4+Pj4+Pgo+ID4gPiA+ID4gPiA+Pj4+
Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxvb3AgZm9y
IGEgYmV0dGVyCj4gPiA+ID4gPiA+ID4+Pj4+Pj4gY28tb3BlcmF0aW9uIHdpdGggdGhlIHNjaGVk
dWxlci4gVGhpcyBhbGxvd3MgdG8gZ2l2ZSBDUFUgYSBicmVhdGggdG8KPiA+ID4gPiA+ID4gPj4+
Pj4+PiBydW4gb3RoZXIgdGFzayh3b3JrcXVldWUpIGluc3RlYWQgb2YgYnVzeSBsb29waW5nIHdo
ZW4gcHJlZW1wdGlvbiBpcwo+ID4gPiA+ID4gPiA+Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2
aWNlIHdob3NlIENWUSBtaWdodCBiZSBzbG93Lgo+ID4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4g
PiA+ID4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KPiA+ID4gPiA+ID4gPj4+Pj4+Cj4gPiA+ID4gPiA+ID4+Pj4+PiBUaGlzIHN0aWxsIGxlYXZl
cyBodW5nIHByb2Nlc3NlcywgYnV0IGF0IGxlYXN0IGl0IGRvZXNuJ3QgcGluIHRoZSBDUFUgYW55
Cj4gPiA+ID4gPiA+ID4+Pj4+PiBtb3JlLiAgVGhhbmtzLgo+ID4gPiA+ID4gPiA+Pj4+Pj4gUmV2
aWV3ZWQtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4gPiA+
ID4gPiA+Pj4+Pj4KPiA+ID4gPiA+ID4gPj4+Pj4KPiA+ID4gPiA+ID4gPj4+Pj4gSSdkIGxpa2Ug
dG8gc2VlIGEgZnVsbCBzb2x1dGlvbgo+ID4gPiA+ID4gPiA+Pj4+PiAxLSBibG9jayB1bnRpbCBp
bnRlcnJ1cHQKPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIHJlbWVtYmVyIGluIHByZXZpb3VzIHZlcnNp
b25zLCB5b3Ugd29ycmllZCBhYm91dCB0aGUgZXh0cmEgTVNJCj4gPiA+ID4gPiB2ZWN0b3IuIChN
YXliZSBJIHdhcyB3cm9uZykuCj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPiA+
ID4+Pj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBhbHNvIGhhdmUgYSB0aW1lb3V0Pwo+ID4gPiA+
ID4gPiA+Pj4+IEFuZCB3aGVuIHRpbWVvdXQgZXhwaXJlcywgc2V0IEZBSUxFRCBiaXQgaW4gZGV2
aWNlIHN0YXR1cz8KPiA+ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+ID4+PiB2aXJ0aW8gc3BlYyBk
b2VzIG5vdCBzZXQgYW55IGxpbWl0cyBvbiB0aGUgdGltaW5nIG9mIHZxCj4gPiA+ID4gPiA+ID4+
PiBwcm9jZXNzaW5nLgo+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+PiBJbmRlZWQsIGJ1dCBJ
IHRob3VnaHQgdGhlIGRyaXZlciBjb3VsZCBkZWNpZGUgaXQgaXMgdG9vIGxvbmcgZm9yIGl0Lgo+
ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+PiBUaGUgaXNzdWUgaXMgd2Uga2VlcCB3YWl0aW5n
IHdpdGggcnRubCBsb2NrZWQsIGl0IGNhbiBxdWlja2x5IG1ha2UgdGhlCj4gPiA+ID4gPiA+ID4+
IHN5c3RlbSB1bnVzYWJsZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IGlmIHRoaXMgaXMg
YSBwcm9ibGVtIHdlIHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0byBrZWVwIHJ0bmwKPiA+ID4gPiA+
ID4gPiBsb2NrZWQgaW5kZWZpbml0ZWx5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFueSBpZGVhcyBv
biB0aGlzIGRpcmVjdGlvbj8gU2ltcGx5IGRyb3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxv
b3AKPiA+ID4gPiA+IHdpbGwgcmVzdWx0IGluIGEgbG90IG9mIHJhY2VzLiBUaGlzIHNlZW1zIHRv
IHJlcXVpcmUgbm9uLXRyaXZpYWwKPiA+ID4gPiA+IGNoYW5nZXMgaW4gdGhlIG5ldHdvcmtpbmcg
Y29yZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICBGcm9tIHRoZSB0ZXN0cyBJ
IGhhdmUgZG9uZSwgSSB0aGluayBpdCBpcy4gV2l0aCBPVlMsIGEgcmVjb25maWd1cmF0aW9uCj4g
PiA+ID4gPiA+IGlzIHBlcmZvcm1lZCB3aGVuIHRoZSBWRFVTRSBkZXZpY2UgaXMgYWRkZWQsIGFu
ZCB3aGVuIGEgTUxYNSBkZXZpY2UgaXMKPiA+ID4gPiA+ID4gaW4gdGhlIHNhbWUgYnJpZGdlLCBp
dCBlbmRzIHVwIGRvaW5nIGFuIGlvY3RsKCkgdGhhdCB0cmllcyB0byB0YWtlIHRoZQo+ID4gPiA+
ID4gPiBydG5sIGxvY2suIEluIHRoaXMgY29uZmlndXJhdGlvbiwgaXQgaXMgbm90IHBvc3NpYmxl
IHRvIGtpbGwgT1ZTIGJlY2F1c2UKPiA+ID4gPiA+ID4gaXQgaXMgc3R1Y2sgdHJ5aW5nIHRvIGFj
cXVpcmUgcnRubCBsb2NrIGZvciBtbHg1IHRoYXQgaXMgaGVsZCBieSB2aXJ0aW8tCj4gPiA+ID4g
PiA+IG5ldC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBZZWFoLCBiYXNpY2FsbHksIGFueSBSVE5MIHVz
ZXJzIHdvdWxkIGJlIGJsb2NrZWQgZm9yZXZlci4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBBbmQgdGhl
IGluZmluaXRlIGxvb3AgaGFzIG90aGVyIHNpZGUgZWZmZWN0cyBsaWtlIGl0IGJsb2NrcyB0aGUg
ZnJlZXplciB0byB3b3JrLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRvIHN1bW1hcml6ZSwgdGhlcmUg
YXJlIHRocmVlIGlzc3Vlcwo+ID4gPiA+ID4KPiA+ID4gPiA+IDEpIGJ1c3kgcG9sbGluZwo+ID4g
PiA+ID4gMikgYnJlYWtzIGZyZWV6ZXIKPiA+ID4gPiA+IDMpIGhvbGQgUlROTCBkdXJpbmcgdGhl
IGxvb3AKPiA+ID4gPiA+Cj4gPiA+ID4gPiBTb2x2aW5nIDMgbWF5IGhlbHAgc29tZWhvdyBmb3Ig
MiBlLmcgc29tZSBwbSByb3V0aW5lIGUuZyB3aXJlZ3VhcmQgb3IKPiA+ID4gPiA+IGV2ZW4gdmly
dG5ldF9yZXN0b3JlKCkgaXRzZWxmIG1heSB0cnkgdG8gaG9sZCB0aGUgbG9jay4KPiA+ID4gPgo+
ID4gPiA+IFllcC4gU28gbXkgZmVlbGluZyBjdXJyZW50bHkgaXMsIHRoZSBvbmx5IHJlYWwgZml4
IGlzIHRvIGFjdHVhbGx5Cj4gPiA+ID4gcXVldWUgdXAgdGhlIHdvcmsgaW4gc29mdHdhcmUuCj4g
PiA+Cj4gPiA+IERvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlOgo+ID4gPgo+ID4gPiBydG5sX2xv
Y2soKTsKPiA+ID4gcXVldWUgdXAgdGhlIHdvcmsKPiA+ID4gcnRubF91bmxvY2soKTsKPiA+ID4g
cmV0dXJuIHN1Y2Nlc3M7Cj4gPiA+Cj4gPiA+ID8KPiA+Cj4gPiB5ZXMKPiAKPiBXZSB3aWxsIGxv
c2UgdGhlIGVycm9yIHJlcG9ydGluZywgaXMgaXQgYSByZWFsIHByb2JsZW0gb3Igbm90PwoKRnVu
ZGFtZW50YWwgaXNuJ3QgaXQ/IE1heWJlIHdlIHdhbnQgYSBwZXItZGV2aWNlIGZsYWcgZm9yIGEg
YXN5bmNoIGNvbW1hbmRzLAphbmQgdmR1c2Ugd2lsbCBzZXQgaXQgd2hpbGUgaGFyZHdhcmUgdmly
dGlvIHdvbid0Lgp0aGlzIHdheSB3ZSBvbmx5IGxvc2UgZXJyb3IgcmVwb3J0aW5nIGZvciB2ZHVz
ZS4KCj4gPgo+ID4KPiA+ID4gPiBJdCdzIG1vc3RseSB0cml2aWFsIHRvIGxpbWl0Cj4gPiA+ID4g
bWVtb3J5IGNvbnN1bXB0aW9uLCB2aWQncyBpcyB0aGUKPiA+ID4gPiBvbmx5IG9uZSB3aGVyZSBp
dCB3b3VsZCBtYWtlIHNlbnNlIHRvIGhhdmUgbW9yZSB0aGFuCj4gPiA+ID4gMSBjb21tYW5kIG9m
IGEgZ2l2ZW4gdHlwZSBvdXRzdGFuZGluZy4KPiA+ID4KPiA+ID4gQW5kIHJ4IG1vZGUgc28gdGhp
cyBpbXBsaWVzIHdlIHdpbGwgZmFpbCBhbnkgY29tbWFuZCBpZiB0aGUgcHJldmlvdXMKPiA+ID4g
d29yayBpcyBub3QgZmluaXNoZWQuCj4gPgo+ID4gZG9uJ3QgZmFpbCBpdCwgc3RvcmUgaXQuCj4g
Cj4gT2suCj4gCj4gVGhhbmtzCj4gCj4gPgo+ID4gPiA+IGhhdmUgYSB0cmVlCj4gPiA+ID4gb3Ig
YSBiaXRtYXAgd2l0aCB2aWRzIHRvIGFkZC9yZW1vdmU/Cj4gPiA+Cj4gPiA+IFByb2JhYmx5Lgo+
ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Pj4+PiAyLSBzdGlsbCBoYW5kbGUgc3VycHJp
c2UgcmVtb3ZhbCBjb3JyZWN0bHkgYnkgd2FraW5nIGluIHRoYXQgY2FzZQo+ID4gPiA+ID4KPiA+
ID4gPiA+IFRoaXMgaXMgYmFzaWNhbGx5IHdoYXQgdmVyc2lvbiAxIGRpZD8KPiA+ID4gPiA+Cj4g
PiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzYwMjZlODAxLTZmZGEtZmVlOS1h
NjliLWQwNmE4MDM2ODYyMUByZWRoYXQuY29tL3QvCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4KPiA+ID4gPiBZZXMgLSBleGNlcHQgdGhlIHRpbWVvdXQgcGFydC4KPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4+
Pj4+Cj4gPiA+ID4gPiA+ID4+Pj4+Pj4gLS0tCj4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAgICBkcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0ICsrKy0KPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4g
Pj4+Pj4+Pgo+ID4gPiA+ID4gPiA+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPj4+Pj4+PiBp
bmRleCA5ZjNiMWQ2YWMzM2QuLmU3NTMzZjI5YjIxOSAxMDA2NDQKPiA+ID4gPiA+ID4gPj4+Pj4+
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPj4+Pj4+PiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPj4+Pj4+PiBAQCAtMjMxNCw4
ICsyMzE0LDEwIEBAIHN0YXRpYyBib29sIHZpcnRuZXRfc2VuZF9jb21tYW5kKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLCB1OCBjbGFzcywgdTggY21kLAo+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAg
ICAgICAgICAqIGludG8gdGhlIGh5cGVydmlzb3IsIHNvIHRoZSByZXF1ZXN0IHNob3VsZCBiZSBo
YW5kbGVkIGltbWVkaWF0ZWx5Lgo+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgICAgICAgICAqLwo+
ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgICAgICAgIHdoaWxlICghdmlydHF1ZXVlX2dldF9idWYo
dmktPmN2cSwgJnRtcCkgJiYKPiA+ID4gPiA+ID4gPj4+Pj4+PiAtICAgICAgICAgICAgICAhdmly
dHF1ZXVlX2lzX2Jyb2tlbih2aS0+Y3ZxKSkKPiA+ID4gPiA+ID4gPj4+Pj4+PiArICAgICAgICAg
ICAgICAhdmlydHF1ZXVlX2lzX2Jyb2tlbih2aS0+Y3ZxKSkgewo+ID4gPiA+ID4gPiA+Pj4+Pj4+
ICsgICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQoKTsKPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAg
ICAgICAgICAgICAgICAgIGNwdV9yZWxheCgpOwo+ID4gPiA+ID4gPiA+Pj4+Pj4+ICsgICAgICAg
fQo+ID4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgcmV0
dXJuIHZpLT5jdHJsLT5zdGF0dXMgPT0gVklSVElPX05FVF9PSzsKPiA+ID4gPiA+ID4gPj4+Pj4+
PiAgICAgIH0KPiA+ID4gPiA+ID4gPj4+Pj4+PiAtLQo+ID4gPiA+ID4gPiA+Pj4+Pj4+IDIuMzku
Mwo+ID4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPiA+ID4+Pj4+Pj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+ID4gPiA+ID4gPj4+Pj4+PiBWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPiA+ID4gPiA+ID4gPj4+Pj4+PiBWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4gPiA+ID4gPiA+Pj4+Pj4+IGh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
Cj4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4+Pgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
