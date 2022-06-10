Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C144DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Jun 2022 14:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44F1E419B1;
	Fri, 10 Jun 2022 14:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxzNo4rb7wRa; Fri, 10 Jun 2022 14:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 72F4041882;
	Fri, 10 Jun 2022 14:51:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44379C0032;
	Fri, 10 Jun 2022 14:51:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06BD8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 14:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB77140AF1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 14:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ByYifPCOU9UB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 14:51:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1A8E40286
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654872658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1E2m04QqR6a6gqbz6wmTs2vcyhOaf7mtQZL0HkbhaQs=;
 b=QzUi7jrJJ3iF23ZBjY/My8zNK4T3tdrIDf+WmRjrcw1jOA6ge9ZUZpqwDxBqWcxHqMJ2YV
 eSbXpIoLndK7yFqb0e0JvTcmhBLvarrNulXCHQKFTSoF7/czcY/qi06eqVwJ80W/uMFm81
 p11oEkpcuQhuzxVlMmZTPkkVLgcjcXM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-CUO0osnuN9yNnqD1f3poZQ-1; Fri, 10 Jun 2022 10:50:55 -0400
X-MC-Unique: CUO0osnuN9yNnqD1f3poZQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 a4-20020a056402168400b0042dc5b94da6so19290731edv.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 07:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1E2m04QqR6a6gqbz6wmTs2vcyhOaf7mtQZL0HkbhaQs=;
 b=0B4oLpw3aY0wGwvOhyu/gU/c+fpNfEbBZntc1ew6iSWbkwsXTHp8OrirUsSRX0v4tU
 PFjbOfq9eNMVbkmLnbrMbSDIAxmTFxQE8gTb/BK1v4N6LhYqcXsQoRuTCREDwmRH+XQY
 i8bxgstXfogyXe/Y8qOGOAXa78se/vPkIcJAvkvKmZvwgqPfSCWWzbhUIQ9POzrAqKNB
 yrPvHqa8Ez0pW5LZiiuqMwdIaqXDDHYK8JKstRgMScuK6ENwZIPHVeW6O/982ikqyRyl
 4Cyv7hFt0aYV37uQPspTMHFDgxkra4Cb/hfR4lzgowM77o1tvSUp9T1iroz1xgghQMOM
 mVpA==
X-Gm-Message-State: AOAM533Y1HG8z+NhpEgzbu/g/g3lF/t/cDoFHq8onNJ9QYITaZUVa6RN
 vFjG8ViqEAuQMFXei7do5rmd3tRM+fnthoS3Lh0kYLa5G0ADKpd7s1FG+s5rQtdcahCLqFUuWcf
 ZflSSOxOgqWQKIJkm7fZxzW3VetgVJf/w9/f/Tqkvkg==
X-Received: by 2002:a17:907:3d8d:b0:70f:257b:a34f with SMTP id
 he13-20020a1709073d8d00b0070f257ba34fmr35037507ejc.352.1654872654111; 
 Fri, 10 Jun 2022 07:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjGVFDTTos5rQAwvQRO3/94bBGXfBkEeVP2pYAwLYNCYRd5EVvP8nnPlQ6nKOPiwSkjLDw/g==
X-Received: by 2002:a17:907:3d8d:b0:70f:257b:a34f with SMTP id
 he13-20020a1709073d8d00b0070f257ba34fmr35037489ejc.352.1654872653823; 
 Fri, 10 Jun 2022 07:50:53 -0700 (PDT)
Received: from redhat.com ([212.116.178.142]) by smtp.gmail.com with ESMTPSA id
 nd28-20020a170907629c00b00706c50870a0sm3955093ejc.194.2022.06.10.07.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jun 2022 07:50:53 -0700 (PDT)
Date: Fri, 10 Jun 2022 10:50:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "huangjie.albert" <huangjie.albert@bytedance.com>
Subject: Re: [PATCH] virtio_ring : fix vring_packed_desc memory out of bounds
 bug
Message-ID: <20220610103905-mutt-send-email-mst@kernel.org>
References: <20220610103314.61577-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220610103314.61577-1-huangjie.albert@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMDY6MzM6MTRQTSArMDgwMCwgaHVhbmdqaWUuYWxiZXJ0
IHdyb3RlOgo+IGtzb2Z0aXJxZCBtYXkgY29uc3VtZSB0aGUgcGFja2V0IGFuZCBpdCB3aWxsIGNh
bGw6Cj4gdmlydG5ldF9wb2xsCj4gCS0tPnZpcnRuZXRfcmVjZWl2ZQo+IAkJLS0+dmlydHF1ZXVl
X2dldF9idWZfY3R4Cj4gCQkJLS0+dmlydHF1ZXVlX2dldF9idWZfY3R4X3BhY2tlZAo+IGFuZCBp
biB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfcGFja2VkOgo+IAo+IHZxLT5sYXN0X3VzZWRfaWR4ICs9
IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubnVtOwo+IGlmICh1bmxpa2VseSh2cS0+bGFzdF91
c2VkX2lkeCA+PSB2cS0+cGFja2VkLnZyaW5nLm51bSkpIHsKPiAgICAgICAgICB2cS0+bGFzdF91
c2VkX2lkeCAtPSB2cS0+cGFja2VkLnZyaW5nLm51bTsKPiAgICAgICAgICB2cS0+cGFja2VkLnVz
ZWRfd3JhcF9jb3VudGVyIF49IDE7Cj4gfQo+IAo+IGlmIGF0IHRoZSBzYW1lIHRpbWUsIHRoZXJl
IGNvbWVzIGEgdnJpbmcgaW50ZXJydXB077yMaW4gdnJpbmdfaW50ZXJydXB0Ogo+IHdlIHdpbGwg
Y2FsbDoKPiB2cmluZ19pbnRlcnJ1cHQKPiAJLS0+bW9yZV91c2VkCj4gCQktLT5tb3JlX3VzZWRf
cGFja2VkCj4gCQkJLS0+aXNfdXNlZF9kZXNjX3BhY2tlZAo+IGluIGlzX3VzZWRfZGVzY19wYWNr
ZWQsIHRoZSBsYXN0X3VzZWRfaWR4IG1heWJlID49IHZxLT5wYWNrZWQudnJpbmcubnVtLgo+IHNv
IHRoaXMgY291bGQgY2FzZSBhIG1lbW9yeSBvdXQgb2YgYm91bmRzIGJ1Zy4KPiAKPiB0aGlzIHBh
dGNoIGlzIHRvIGZpeCB0aGlzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IGh1YW5namllLmFsYmVydCA8
aHVhbmdqaWUuYWxiZXJ0QGJ5dGVkYW5jZS5jb20+CgoKVGhpcyBwYXR0ZXJuIHdhcyBhbHdheXMg
aWZmeSwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlIHBhdGNoCmltcHJvdmVzIHRoZSBzaXR1YXRpb24g
bXVjaC4gbGFzdF91c2VkX2lkeCBhbmQgdnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlciAKY2Fu
IHN0aWxsIGdldCBvdXQgb2Ygc3luYy4KCk1heWJlIHJlZmFjdG9yIGNvZGUgdG8ga2VlcCBldmVy
eXRoaW5nIGluIHZxLT5sYXN0X3VzZWRfaWR4PwoKSmFzb24gd2hhdCBpcyB5b3VyIHRha2U/CgoK
CgoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDMgKysrCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCAx
M2E3MzQ4Y2VkZmYuLmQyYWJiYjNhODE4NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0x
Mzk3LDYgKzEzOTcsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfdXNlZF9kZXNjX3BhY2tlZChj
b25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAgCWJvb2wgYXZhaWwsIHVzZWQ7Cj4g
IAl1MTYgZmxhZ3M7Cj4gIAo+ICsJaWYgKGlkeCA+PSB2cS0+cGFja2VkLnZyaW5nLm51bSkKPiAr
CQlyZXR1cm4gZmFsc2U7Cj4gKwo+ICAJZmxhZ3MgPSBsZTE2X3RvX2NwdSh2cS0+cGFja2VkLnZy
aW5nLmRlc2NbaWR4XS5mbGFncyk7Cj4gIAlhdmFpbCA9ICEhKGZsYWdzICYgKDEgPDwgVlJJTkdf
UEFDS0VEX0RFU0NfRl9BVkFJTCkpOwo+ICAJdXNlZCA9ICEhKGZsYWdzICYgKDEgPDwgVlJJTkdf
UEFDS0VEX0RFU0NfRl9VU0VEKSk7Cj4gLS0gCj4gMi4yNy4wCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
