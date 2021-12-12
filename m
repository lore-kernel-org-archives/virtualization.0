Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D251C433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 09:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A74FC404CC;
	Sun, 12 Dec 2021 09:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyLZUHWBvabp; Sun, 12 Dec 2021 09:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAD8E40516;
	Sun, 12 Dec 2021 09:26:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9162FC001E;
	Sun, 12 Dec 2021 09:26:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB7BC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A67D85784
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rKQIjEI8XKfB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:26:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BEE1F85780
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639301192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOXcr6pHx2dTcXC87fAYLtq4NSmVsSlQxlt3kaDLk48=;
 b=jSSD+e2fzu5SfmEgg1RvkXO3I+0iSstfCIoyT4MRMqj3yEpOGnkM3f3nh++65mdUqlZLB0
 UipLCEx+mtVqS4gT0+HjZpJWiQFoOK9piBbRHYtR/L9cIIjy89/zsD+ZOJvUrDQJ6uW3Tj
 7rBML6AQQb6EfqRiPN2d9Kpv1dVVSS4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-U_QG9PjaMFWkAVJbgJPejA-1; Sun, 12 Dec 2021 04:26:10 -0500
X-MC-Unique: U_QG9PjaMFWkAVJbgJPejA-1
Received: by mail-wm1-f72.google.com with SMTP id
 138-20020a1c0090000000b00338bb803204so7943620wma.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 01:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=iOXcr6pHx2dTcXC87fAYLtq4NSmVsSlQxlt3kaDLk48=;
 b=xtK8Bu06jcScGvtPDKUzKBKasxYVdm6YRzRz0P6g6Dstqz/zmMhdBxNTiJ7Wc9f+6w
 SSPTi5A20quhoknxgVmDTxwYfnNbSFRwRjfYeDqAp3FPXDr/ufvQQHpXUVDKYqIWstET
 7wGxtV4tGinep01sHiAMycWP+4aMnoAfdAC6c3Brz1NCcY7PF7z4Efl9tLpsSZKSfNxn
 HuK2FW1VpkTfOzt+PN8NampVtf7Z3w2RByrl9rsVB9rEKc/0jZA4oR1v5IYLDCqF6Fw/
 fduVdCQa4aFQx/8VwGDHcI7njRHljz5n7xlb3Xzkiwl+/g+VKLn6I0U4UOU2yrBUQL4u
 R0yw==
X-Gm-Message-State: AOAM533szZCMRz9F77rUsUoJ8XeJQ0Q1u7iJCQvtpBoYcSBIuw8tRk7W
 cNvHytZfpXI/OCP4w7kKQf9pGQehvlS2+qcBSOhoimVq73RhRhvzrxh9EsGz4PxGM/8odmHytdP
 gjtXqJkQ9hTjjFAjpKVY9TkJFotHmYFw/7xPfBAaZIg==
X-Received: by 2002:adf:f352:: with SMTP id e18mr24921184wrp.39.1639301169218; 
 Sun, 12 Dec 2021 01:26:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtqXoz8hDbJjLt2rbzhBOfaD5dc4meh/BYw1JmqhXFGUH5XhglF+PBQQDu4hLMN81ueRNuRg==
X-Received: by 2002:adf:f352:: with SMTP id e18mr24921175wrp.39.1639301169009; 
 Sun, 12 Dec 2021 01:26:09 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107e:eefb:294:6ac8:eff6:22df])
 by smtp.gmail.com with ESMTPSA id 9sm9707263wry.0.2021.12.12.01.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Dec 2021 01:26:08 -0800 (PST)
Date: Sun, 12 Dec 2021 04:26:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Message-ID: <20211212042311-mutt-send-email-mst@kernel.org>
References: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

T24gRnJpLCBEZWMgMTAsIDIwMjEgYXQgMDU6NDQ6MTVQTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiBTb3JyeSBmb3IgcmV2aXZpbmcgdGhpcyBhbmNpZW50IHRocmVhZC4gSSB3YXMga2luZGEg
bG9zdCBmb3IgdGhlIGNvbmNsdXNpb24KPiBpdCBlbmRlZCB1cCB3aXRoLiBJIGhhdmUgdGhlIGZv
bGxvd2luZyBxdWVzdGlvbnMsCj4gCj4gMS4gbGVnYWN5IGd1ZXN0IHN1cHBvcnQ6IGZyb20gdGhl
IHBhc3QgY29udmVyc2F0aW9ucyBpdCBkb2Vzbid0IHNlZW0gdGhlCj4gc3VwcG9ydCB3aWxsIGJl
IGNvbXBsZXRlbHkgZHJvcHBlZCBmcm9tIHRoZSB0YWJsZSwgaXMgbXkgdW5kZXJzdGFuZGluZwo+
IGNvcnJlY3Q/IEFjdHVhbGx5IHdlJ3JlIGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyB2aXJ0aW8g
djAuOTUgZ3Vlc3QgZm9yIHg4NiwKPiB3aGljaCBpcyBiYWNrZWQgYnkgdGhlIHNwZWMgYXQKPiBo
dHRwczovL296bGFicy5vcmcvfnJ1c3R5L3ZpcnRpby1zcGVjL3ZpcnRpby0wLjkuNS5wZGYuIFRo
b3VnaCBJJ20gbm90IHN1cmUKPiBpZiB0aGVyZSdzIHJlcXVlc3QvbmVlZCB0byBzdXBwb3J0IHdp
bGRlciBsZWdhY3kgdmlydGlvIHZlcnNpb25zIGVhcmxpZXIKPiBiZXlvbmQuCgpJIHBlcnNvbmFs
bHkgZmVlbCBpdCdzIGxlc3Mgd29yayB0byBhZGQgaW4ga2VybmVsIHRoYW4gdHJ5IHRvCndvcmsg
YXJvdW5kIGl0IGluIHVzZXJzcGFjZS4gSmFzb24gZmVlbHMgZGlmZmVyZW50bHkuCk1heWJlIHBv
c3QgdGhlIHBhdGNoZXMgYW5kIHRoaXMgd2lsbCBwcm92ZSB0byBKYXNvbiBpdCdzIG5vdAp0b28g
dGVycmlibGU/Cgo+IDIuIHN1cHBvc2Ugc29tZSBmb3JtIG9mIGxlZ2FjeSBndWVzdCBzdXBwb3J0
IG5lZWRzIHRvIGJlIHRoZXJlLCBob3cgZG8gd2UKPiBkZWFsIHdpdGggdGhlIGJvZ3VzIGFzc3Vt
cHRpb24gYmVsb3cgaW4gdmRwYV9nZXRfY29uZmlnKCkgaW4gdGhlIHNob3J0IHRlcm0/Cj4gSXQg
bG9va3Mgb25lIG9mIHRoZSBpbnR1aXRpdmUgZml4IGlzIHRvIG1vdmUgdGhlIHZkcGFfc2V0X2Zl
YXR1cmVzIGNhbGwgb3V0Cj4gb2YgdmRwYV9nZXRfY29uZmlnKCkgdG8gdmRwYV9zZXRfY29uZmln
KCkuCj4gCj4gwqDCoMKgwqDCoMKgwqAgLyoKPiDCoMKgwqDCoMKgwqDCoMKgICogQ29uZmlnIGFj
Y2Vzc2VzIGFyZW4ndCBzdXBwb3NlZCB0byB0cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBhcmUKPiBz
ZXQuCj4gwqDCoMKgwqDCoMKgwqDCoCAqIElmIGl0IGRvZXMgaGFwcGVuIHdlIGFzc3VtZSBhIGxl
Z2FjeSBndWVzdC4KPiDCoMKgwqDCoMKgwqDCoMKgICovCj4gwqDCoMKgwqDCoMKgwqAgaWYgKCF2
ZGV2LT5mZWF0dXJlc192YWxpZCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmRw
YV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gwqDCoMKgwqDCoMKgwqAgb3BzLT5nZXRfY29uZmln
KHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+IAo+IEkgY2FuIHBvc3QgYSBwYXRjaCB0byBmaXgg
MikgaWYgdGhlcmUncyBjb25zZW5zdXMgYWxyZWFkeSByZWFjaGVkLgo+IAo+IFRoYW5rcywKPiAt
U2l3ZWkKCkknbSBub3Qgc3VyZSBob3cgaW1wb3J0YW50IGl0IGlzIHRvIGNoYW5nZSB0aGF0LgpJ
biBhbnkgY2FzZSBpdCBvbmx5IGFmZmVjdHMgdHJhbnNpdGlvbmFsIGRldmljZXMsIHJpZ2h0PwpM
ZWdhY3kgb25seSBzaG91bGQgbm90IGNhcmUgLi4uCgoKPiBPbiAzLzIvMjAyMSAyOjUzIEFNLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gCj4gPiBPbiAyMDIxLzMvMiA1OjQ3IOS4i+WNiCwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAxMTo1Njo1
MEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+IE9uIDIwMjEvMy8xIDU6MzQg5LiK
5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQsIEZlYiAyNCwg
MjAyMSBhdCAxMDoyNDo0MUFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4gPiA+ID4gPiA+
IERldGVjdGluZyBpdCBpc24ndCBlbm91Z2ggdGhvdWdoLCB3ZSB3aWxsIG5lZWQgYSBuZXcgaW9j
dGwgdG8gbm90aWZ5Cj4gPiA+ID4gPiA+ID4gdGhlIGtlcm5lbCB0aGF0IGl0J3MgYSBsZWdhY3kg
Z3Vlc3QuIFVnaCA6KAo+ID4gPiA+ID4gPiBXZWxsLCBhbHRob3VnaCBJIHRoaW5rIGFkZGluZyBh
biBpb2N0bCBpcyBkb2FibGUsIG1heSBJCj4gPiA+ID4gPiA+IGtub3cgd2hhdCB0aGUgdXNlCj4g
PiA+ID4gPiA+IGNhc2UgdGhlcmUgd2lsbCBiZSBmb3Iga2VybmVsIHRvIGxldmVyYWdlIHN1Y2gg
aW5mbwo+ID4gPiA+ID4gPiBkaXJlY3RseT8gSXMgdGhlcmUgYQo+ID4gPiA+ID4gPiBjYXNlIFFF
TVUgY2FuJ3QgZG8gd2l0aCBkZWRpY2F0ZSBpb2N0bHMgbGF0ZXIgaWYgdGhlcmUncyBpbmRlZWQK
PiA+ID4gPiA+ID4gZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBtb2Rlcm4pIG5lZWRlZD8K
PiA+ID4gPiA+IEJUVyBhIGdvb2QgQVBJIGNvdWxkIGJlCj4gPiA+ID4gPiAKPiA+ID4gPiA+ICNk
ZWZpbmUgVkhPU1RfU0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+ID4gPiA+
ID4gI2RlZmluZSBWSE9TVF9HRVRfRU5ESUFOIF9JT1coVkhPU1RfVklSVElPLCA/LCBpbnQpCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IHdlIGRpZCBpdCBwZXIgdnJpbmcgYnV0IG1heWJlIHRoYXQgd2Fz
IGEgbWlzdGFrZSAuLi4KPiA+ID4gPiAKPiA+ID4gPiBBY3R1YWxseSwgSSB3b25kZXIgd2hldGhl
ciBpdCdzIGdvb2QgdGltZSB0byBqdXN0IG5vdCBzdXBwb3J0Cj4gPiA+ID4gbGVnYWN5IGRyaXZl
cgo+ID4gPiA+IGZvciB2RFBBLiBDb25zaWRlcjoKPiA+ID4gPiAKPiA+ID4gPiAxKSBJdCdzIGRl
ZmluaXRpb24gaXMgbm8tbm9ybWF0aXZlCj4gPiA+ID4gMikgQSBsb3Qgb2YgYnVkcmVuIG9mIGNv
ZGVzCj4gPiA+ID4gCj4gPiA+ID4gU28gcWVtdSBjYW4gc3RpbGwgcHJlc2VudCB0aGUgbGVnYWN5
IGRldmljZSBzaW5jZSB0aGUgY29uZmlnCj4gPiA+ID4gc3BhY2Ugb3Igb3RoZXIKPiA+ID4gPiBz
dHVmZnMgdGhhdCBpcyBwcmVzZW50ZWQgYnkgdmhvc3QtdkRQQSBpcyBub3QgZXhwZWN0ZWQgdG8g
YmUKPiA+ID4gPiBhY2Nlc3NlZCBieQo+ID4gPiA+IGd1ZXN0IGRpcmVjdGx5LiBRZW11IGNhbiBk
byB0aGUgZW5kaWFuIGNvbnZlcnNpb24gd2hlbiBuZWNlc3NhcnkKPiA+ID4gPiBpbiB0aGlzCj4g
PiA+ID4gY2FzZT8KPiA+ID4gPiAKPiA+ID4gPiBUaGFua3MKPiA+ID4gPiAKPiA+ID4gT3ZlcmFs
bCBJIHdvdWxkIGJlIGZpbmUgd2l0aCB0aGlzIGFwcHJvYWNoIGJ1dCB3ZSBuZWVkIHRvIGF2b2lk
IGJyZWFraW5nCj4gPiA+IHdvcmtpbmcgdXNlcnNwYWNlLCBxZW11IHJlbGVhc2VzIHdpdGggdmRw
YSBzdXBwb3J0IGFyZSBvdXQgdGhlcmUgYW5kCj4gPiA+IHNlZW0gdG8gd29yayBmb3IgcGVvcGxl
LiBBbnkgY2hhbmdlcyBuZWVkIHRvIHRha2UgdGhhdCBpbnRvIGFjY291bnQKPiA+ID4gYW5kIGRv
Y3VtZW50IGNvbXBhdGliaWxpdHkgY29uY2VybnMuCj4gPiAKPiA+IAo+ID4gQWdyZWUsIGxldCBt
ZSBjaGVjay4KPiA+IAo+ID4gCj4gPiA+IMKgIEkgbm90ZSB0aGF0IGFueSBoYXJkd2FyZQo+ID4g
PiBpbXBsZW1lbnRhdGlvbiBpcyBhbHJlYWR5IGJyb2tlbiBmb3IgbGVnYWN5IGV4Y2VwdCBvbiBw
bGF0Zm9ybXMgd2l0aAo+ID4gPiBzdHJvbmcgb3JkZXJpbmcgd2hpY2ggbWlnaHQgYmUgaGVscGZ1
bCBpbiByZWR1Y2luZyB0aGUgc2NvcGUuCj4gPiAKPiA+IAo+ID4gWWVzLgo+ID4gCj4gPiBUaGFu
a3MKPiA+IAo+ID4gCj4gPiA+IAo+ID4gPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
