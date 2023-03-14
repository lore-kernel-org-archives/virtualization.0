Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD392C6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 03:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CECC8143C;
	Tue, 14 Mar 2023 03:56:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CECC8143C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G8iyA6zo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbOMDgZZqZhK; Tue, 14 Mar 2023 03:56:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBD3581432;
	Tue, 14 Mar 2023 03:56:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBD3581432
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 928DCC0071;
	Tue, 14 Mar 2023 03:56:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA90CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7141C8143C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:56:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7141C8143C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PauwnumqRg2l
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:56:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C741081432
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C741081432
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678766181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUTGoKigOjF7lnPsnySj5O1n6jQabFHTwPAHfAEzD+g=;
 b=G8iyA6zoIJk+7D5kiOqcAOXMLDnjtAq4BXcw9WZ9uXof6vemeot4h2kwJesHIV14DPA0Kz
 dt0HJ6craUDU9OE/CWcTnr3fpXkMEQEjM7GrDR/3hFlQVSQ/IiZ8g5hv9avISpaIgHugQ5
 XlDkNpw7ngTjgzghzIERC78xXURFeh8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-2JLZklXSO1abx0A9xALiEg-1; Mon, 13 Mar 2023 23:56:20 -0400
X-MC-Unique: 2JLZklXSO1abx0A9xALiEg-1
Received: by mail-oo1-f71.google.com with SMTP id
 t3-20020a4a96c3000000b005252e74e78fso3938648ooi.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 20:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678766179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUTGoKigOjF7lnPsnySj5O1n6jQabFHTwPAHfAEzD+g=;
 b=QgJsap9b62pP/P8e9Xfee2MpmJ3dxVQmXQoaQWHE6gC4VJG8lHiGu1iTNXRaMB23l3
 bfs4FMET6Of5bA1ZW//qogNA/scP9dPGQ4oET1SBSaVwX9wMN4K9wTrAk0HuDhfQRd+T
 HNBjUMuDZ0qZXg4xUQVhh+mDszKxw7iX+aAEmCNsu7fvXBcuwetA1u6MtfLhG5vQ1Yv0
 Fb2TibYG2Npg0iPWcrF00gXBnk8VOmoUS10Aqvq5faBpDS+01KfSeuh38BUCAeud5lho
 MI0HyaGUyOFlhYNqI2G6LrRx3if4cbE71SuLqcqTadtZ9ZPeDOYyJpwbAGompsHycDEu
 c09Q==
X-Gm-Message-State: AO0yUKUt0MtE+frQVuDxVkC6TzMbEWqkoetvi3Zc/sEbeEbFMGr6wvje
 2KjXrY1bn/w3K3RRN2GRynu/Fbd4/57UuFSYW3kqqhcmM2iun3flHDTO4isDCRjPoa8az+YjTr0
 CAiALltpdN336nkeLhc1jVZoNPumPvihVmwu1ufRaOv+Zf8GILB2msBpvIw==
X-Received: by 2002:a9d:1984:0:b0:696:46dd:bec7 with SMTP id
 k4-20020a9d1984000000b0069646ddbec7mr491239otk.2.1678766179427; 
 Mon, 13 Mar 2023 20:56:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set/8cD2YJCW/GyAom9yPG1fRPOW6omllIrRCSG8zrwMHOV27MDaBDu6YXAj5Pwq1SwhCEPZrqYs4Ze4SH/NyHBo=
X-Received: by 2002:a9d:1984:0:b0:696:46dd:bec7 with SMTP id
 k4-20020a9d1984000000b0069646ddbec7mr491235otk.2.1678766179150; Mon, 13 Mar
 2023 20:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-4-sgarzare@redhat.com>
In-Reply-To: <20230302113421.174582-4-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 11:56:08 +0800
Message-ID: <CACGkMEs6cW7LdpCdWQnX4Pif2gGOu=f3bjNeYQ6MVcdQe=X--Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] vringh: replace kmap_atomic() with
 kmap_local_page()
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjM04oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IGttYXBfYXRvbWljKCkgaXMgZGVwcmVjYXRlZCBp
biBmYXZvciBvZiBrbWFwX2xvY2FsX3BhZ2UoKS4KCkl0J3MgYmV0dGVyIHRvIG1lbnRpb24gdGhl
IGNvbW1pdCBvciBjb2RlIHRoYXQgaW50cm9kdWNlcyB0aGlzLgoKPgo+IFdpdGgga21hcF9sb2Nh
bF9wYWdlKCkgdGhlIG1hcHBpbmdzIGFyZSBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGNhbiB0YWtl
Cj4gcGFnZS1mYXVsdHMsIGFuZCBjYW4gYmUgY2FsbGVkIGZyb20gYW55IGNvbnRleHQgKGluY2x1
ZGluZyBpbnRlcnJ1cHRzKS4KPiBGdXJ0aGVybW9yZSwgdGhlIHRhc2tzIGNhbiBiZSBwcmVlbXB0
ZWQgYW5kLCB3aGVuIHRoZXkgYXJlIHNjaGVkdWxlZCB0bwo+IHJ1biBhZ2FpbiwgdGhlIGtlcm5l
bCB2aXJ0dWFsIGFkZHJlc3NlcyBhcmUgcmVzdG9yZWQgYW5kIHN0aWxsIHZhbGlkLgo+Cj4ga21h
cF9hdG9taWMoKSBpcyBpbXBsZW1lbnRlZCBsaWtlIGEga21hcF9sb2NhbF9wYWdlKCkgd2hpY2gg
YWxzbyBkaXNhYmxlcwo+IHBhZ2UtZmF1bHRzIGFuZCBwcmVlbXB0aW9uICh0aGUgbGF0dGVyIG9u
bHkgZm9yICFQUkVFTVBUX1JUIGtlcm5lbHMsCj4gb3RoZXJ3aXNlIGl0IG9ubHkgZGlzYWJsZXMg
bWlncmF0aW9uKS4KPgo+IFRoZSBjb2RlIHdpdGhpbiB0aGUgbWFwcGluZ3MvdW4tbWFwcGluZ3Mg
aW4gZ2V0dTE2X2lvdGxiKCkgYW5kCj4gcHV0dTE2X2lvdGxiKCkgZG9uJ3QgZGVwZW5kIG9uIHRo
ZSBhYm92ZS1tZW50aW9uZWQgc2lkZSBlZmZlY3RzIG9mCj4ga21hcF9hdG9taWMoKSwKCk5vdGUg
d2UgdXNlZCB0byB1c2Ugc3BpbmxvY2sgdG8gcHJvdGVjdCBzaW11bGF0b3JzIChhdCBsZWFzdCB1
bnRpbApwYXRjaCA3LCBzbyB3ZSBwcm9iYWJseSBuZWVkIHRvIHJlLW9yZGVyIHRoZSBwYXRjaGVz
IGF0IGxlYXN0KSBzbyBJCnRoaW5rIHRoaXMgaXMgb25seSB2YWxpZCB3aGVuOgoKVGhlIHZyaW5n
aCBJT1RMQiBoZWxwZXJzIGFyZSBub3QgdXNlZCBpbiBhdG9taWMgY29udGV4dCAoZS5nIHNwaW5s
b2NrLAppbnRlcnJ1cHRzKS4KCklmIHllcywgc2hvdWxkIHdlIGRvY3VtZW50IHRoaXM/IChPciBz
aG91bGQgd2UgaW50cm9kdWNlIGEgYm9vbGVhbiB0bwpzYXkgd2hldGhlciBhbiBJT1RMQiB2YXJp
YW50IGNhbiBiZSB1c2VkIGluIGFuIGF0b21pYyBjb250ZXh0KT8KClRoYW5rcwoKPiBzbyB0aGF0
IG1lcmUgcmVwbGFjZW1lbnRzIG9mIHRoZSBvbGQgQVBJIHdpdGggdGhlIG5ldyBvbmUKPiBpcyBh
bGwgdGhhdCBpcyByZXF1aXJlZCAoaS5lLiwgdGhlcmUgaXMgbm8gbmVlZCB0byBleHBsaWNpdGx5
IGFkZCBjYWxscwo+IHRvIHBhZ2VmYXVsdF9kaXNhYmxlKCkgYW5kL29yIHByZWVtcHRfZGlzYWJs
ZSgpKS4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVk
aGF0LmNvbT4KPiAtLS0KPgo+IE5vdGVzOgo+ICAgICB2MjoKPiAgICAgLSBhZGRlZCB0aGlzIHBh
dGNoIHNpbmNlIGNoZWNrcGF0Y2gucGwgY29tcGxhaW5lZCBhYm91dCBkZXByZWNhdGlvbgo+ICAg
ICAgIG9mIGttYXBfYXRvbWljKCkgdG91Y2hlZCBieSBuZXh0IHBhdGNoCj4KPiAgZHJpdmVycy92
aG9zdC92cmluZ2guYyB8IDggKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5n
aC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+IGluZGV4IGExZTI3ZGE1NDQ4MS4uMGJhM2Vm
ODA5ZTQ4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiArKysgYi9kcml2
ZXJzL3Zob3N0L3ZyaW5naC5jCj4gQEAgLTEyMjAsMTAgKzEyMjAsMTAgQEAgc3RhdGljIGlubGlu
ZSBpbnQgZ2V0dTE2X2lvdGxiKGNvbnN0IHN0cnVjdCB2cmluZ2ggKnZyaCwKPiAgICAgICAgIGlm
IChyZXQgPCAwKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+Cj4gLSAgICAgICBrYWRk
ciA9IGttYXBfYXRvbWljKGlvdi5idl9wYWdlKTsKPiArICAgICAgIGthZGRyID0ga21hcF9sb2Nh
bF9wYWdlKGlvdi5idl9wYWdlKTsKPiAgICAgICAgIGZyb20gPSBrYWRkciArIGlvdi5idl9vZmZz
ZXQ7Cj4gICAgICAgICAqdmFsID0gdnJpbmdoMTZfdG9fY3B1KHZyaCwgUkVBRF9PTkNFKCooX192
aXJ0aW8xNiAqKWZyb20pKTsKPiAtICAgICAgIGt1bm1hcF9hdG9taWMoa2FkZHIpOwo+ICsgICAg
ICAga3VubWFwX2xvY2FsKGthZGRyKTsKPgo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPiBAQCAt
MTI0MSwxMCArMTI0MSwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBwdXR1MTZfaW90bGIoY29uc3Qg
c3RydWN0IHZyaW5naCAqdnJoLAo+ICAgICAgICAgaWYgKHJldCA8IDApCj4gICAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7Cj4KPiAtICAgICAgIGthZGRyID0ga21hcF9hdG9taWMoaW92LmJ2X3Bh
Z2UpOwo+ICsgICAgICAga2FkZHIgPSBrbWFwX2xvY2FsX3BhZ2UoaW92LmJ2X3BhZ2UpOwo+ICAg
ICAgICAgdG8gPSBrYWRkciArIGlvdi5idl9vZmZzZXQ7Cj4gICAgICAgICBXUklURV9PTkNFKCoo
X192aXJ0aW8xNiAqKXRvLCBjcHVfdG9fdnJpbmdoMTYodnJoLCB2YWwpKTsKPiAtICAgICAgIGt1
bm1hcF9hdG9taWMoa2FkZHIpOwo+ICsgICAgICAga3VubWFwX2xvY2FsKGthZGRyKTsKPgo+ICAg
ICAgICAgcmV0dXJuIDA7Cj4gIH0KPiAtLQo+IDIuMzkuMgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
