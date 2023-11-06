Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F41DC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 04:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9A8B821B1;
	Mon,  6 Nov 2023 04:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9A8B821B1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VCuVcozK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vCT-cc5kdpbq; Mon,  6 Nov 2023 04:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED7FA821A1;
	Mon,  6 Nov 2023 04:11:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED7FA821A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4B30C0039;
	Mon,  6 Nov 2023 04:11:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 318D0C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 04:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA0E141BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 04:11:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA0E141BD1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VCuVcozK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6UWVuKNgh8u
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 04:11:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A99841BCD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 04:11:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A99841BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699243912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHrLb4zEBqMuGuzN6XAqFfCIg5Eok44Njld/JJN4sJk=;
 b=VCuVcozKi//IH9w+rr4S8Xx6xqqz8ZXGugX2DYE4SEJiCA2d3yohwhmuMDR1MN9Xy11NQ3
 08PlbLPLK4i0wcHc0YdoOyMh4GfsZExDbXGbzeDn+hCHS01HXcM6oHE5BY5WbrbTY7ILU+
 1e6JaK9xLrrKI/253Ev3lEd0V35TQNA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-AsCTKbmqOuedWhASM4ijug-1; Sun, 05 Nov 2023 23:11:48 -0500
X-MC-Unique: AsCTKbmqOuedWhASM4ijug-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5090b916b7fso4453864e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Nov 2023 20:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699243907; x=1699848707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHrLb4zEBqMuGuzN6XAqFfCIg5Eok44Njld/JJN4sJk=;
 b=jO4nEg9w1OGOwKxMy6HlsqqDCUKOYjKU3QsjP8JiQxksmx8IhF6xk6dUavfXs8+jqn
 NspaPCwAG7mcHNMkUiHLSK4Fe0Nn/jFtaP3e1imWuqQ5RsH2LBS9t0HMYGeR3Iddi8Ty
 SB3Jn/Wp9cWeNu6QTfy5zedjbqEP6phzMisXaC2vX3bd+LVFWKuhvSixM1xkD4O75MY4
 jsj0uMQuRJSGmNKR9dpvX/8k3NHZi1Qs0hNqVtBoD0sn274LdnzTrtYJQ0eAsynqvEuW
 fCNErTPz/l6VCuDZmHGSdLOQAw5p7l6yqXKjhjGjFZLE1E5x959iQaOeQqO5xttXZs8H
 /tlg==
X-Gm-Message-State: AOJu0Yw1FHMeZEgnGzFbyCWp4M1uZAJz//lI39a61K3aiisH7+iMbrFD
 FIHF7ThuP93RYk13/5k1mr4Ktpb6LYeil62JCNBrlZZrg0HaMjgEROVauEs0+e3WMhU95+0b3tw
 bdiyephYgD8/dwT/tDbyVFnMqykQknRISF8xQubn9aWmeIdKAKX0l2VESdQ==
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id
 y10-20020a19914a000000b0050797012700mr21479176lfj.20.1699243907021; 
 Sun, 05 Nov 2023 20:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUWUi5tZ6aymenvsU8IcDkUX50MvzvLjsi++9vXhsqQouRpjAkVN6Zt+HPX/ts88NcBPPpX+/TSiAt8ldNrfw=
X-Received: by 2002:a19:914a:0:b0:507:9701:2700 with SMTP id
 y10-20020a19914a000000b0050797012700mr21479160lfj.20.1699243906677; Sun, 05
 Nov 2023 20:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 12:11:35 +0800
Message-ID: <CACGkMEvaKw9g0EmNdFh3=iZm3rD-mo_BtaBA3F5bwqNq4NV3Dw@mail.gmail.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: yi.l.liu@intel.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jgg@nvidia.com
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

T24gU2F0LCBOb3YgNCwgMjAyMyBhdCAxOjE24oCvQU0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPgo+IEhpIEFsbAo+IFRoaXMgY29kZSBwcm92aWRlcyB0aGUgaW9tbXVmZCBz
dXBwb3J0IGZvciB2ZHBhIGRldmljZQo+IFRoaXMgY29kZSBmaXhlcyB0aGUgYnVncyBmcm9tIHRo
ZSBsYXN0IHZlcnNpb24gYW5kIGFsc28gYWRkIHRoZSBhc2lkIHN1cHBvcnQuIHJlYmFzZSBvbiBr
ZXJuZWwKPiB2Niw2LXJjMwo+IFRlc3QgcGFzc2VkIGluIHRoZSBwaHlzaWNhbCBkZXZpY2UgKHZw
X3ZkcGEpLCBidXQgIHRoZXJlIGFyZSBzdGlsbCBzb21lIHByb2JsZW1zIGluIHRoZSBlbXVsYXRl
ZCBkZXZpY2UgKHZkcGFfc2ltX25ldCksCj4gSSB3aWxsIGNvbnRpbnVlIHdvcmtpbmcgb24gaXQK
Pgo+IFRoZSBrZXJuZWwgY29kZSBpcwo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9sdWx1Ni92aG9zdC8t
L3RyZWUvaW9tbXVmZFJGQ192MQo+Cj4gU2lnbmVkLW9mZi1ieTogQ2luZHkgTHUgPGx1bHVAcmVk
aGF0LmNvbT4KCkl0IHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGEgY2hhbmdlIHN1bW1hcnkgaGVy
ZS4KClRoYW5rcwoKPgo+Cj4gQ2luZHkgTHUgKDgpOgo+ICAgdmhvc3QvaW9tbXVmZDogQWRkIHRo
ZSBmdW5jdGlvbnMgc3VwcG9ydCBpb21tdWZkCj4gICBLY29uZmlnOiBBZGQgdGhlIG5ldyBmaWxl
IHZob3N0L2lvbW11ZmQKPiAgIHZob3N0OiBBZGQgMyBuZXcgdWFwaSB0byBzdXBwb3J0IGlvbW11
ZmQKPiAgIHZkcGE6IEFkZCBuZXcgdmRwYV9jb25maWdfb3BzIHRvIHN1cHBvcnQgaW9tbXVmZAo+
ICAgdmRwYV9zaW0gOkFkZCBzdXBwb3J0IGZvciBpb21tdWZkCj4gICB2ZHBhOiBjaGFuZ2UgdGhl
IG1hcC91bm1hcCBwcm9jZXNzIHRvIHN1cHBvcnQgaW9tbXVmZAo+ICAgdnBfdmRwYTo6QWRkIHN1
cHBvcnQgZm9yIGlvbW11ZmQKPiAgIGlvbW11OiBleHBvc2UgdGhlIGZ1bmN0aW9uIGlvbW11X2Rl
dmljZV91c2VfZGVmYXVsdF9kb21haW4KPgo+ICBkcml2ZXJzL2lvbW11L2lvbW11LmMgICAgICAg
ICAgICAgfCAgIDIgKwo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgfCAgIDgg
KysKPiAgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIHwgICA0ICsKPiAgZHJpdmVy
cy92aG9zdC9LY29uZmlnICAgICAgICAgICAgIHwgICAxICsKPiAgZHJpdmVycy92aG9zdC9NYWtl
ZmlsZSAgICAgICAgICAgIHwgICAxICsKPiAgZHJpdmVycy92aG9zdC9pb21tdWZkLmMgICAgICAg
ICAgIHwgMTc4ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiAgZHJpdmVycy92aG9zdC92ZHBh
LmMgICAgICAgICAgICAgIHwgMjEwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICBk
cml2ZXJzL3Zob3N0L3Zob3N0LmggICAgICAgICAgICAgfCAgMjEgKysrCj4gIGluY2x1ZGUvbGlu
dXgvdmRwYS5oICAgICAgICAgICAgICB8ICAzOCArKysrKy0KPiAgaW5jbHVkZS91YXBpL2xpbnV4
L3Zob3N0LmggICAgICAgIHwgIDY2ICsrKysrKysrKysKPiAgMTAgZmlsZXMgY2hhbmdlZCwgNTI1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3Zob3N0L2lvbW11ZmQuYwo+Cj4gLS0KPiAyLjM0LjMKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
