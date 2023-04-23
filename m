Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6133C77B76
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 06:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 838DC60590;
	Sun, 23 Apr 2023 06:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 838DC60590
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3IvQiR3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlsu4ASNO3A4; Sun, 23 Apr 2023 06:38:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A41E606E6;
	Sun, 23 Apr 2023 06:38:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A41E606E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E579FC0037;
	Sun, 23 Apr 2023 06:38:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E577C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 356EF82179
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 356EF82179
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b3IvQiR3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 89AapVUU_ki0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:38:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCA4982178
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCA4982178
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682231898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BPL/olqTUGJQKqQE7xoRpj15Uybwy151IkJPwrg3JE=;
 b=b3IvQiR3urPFhhWh5Owa8YA+J/nl5LFeEz9vw/xBDoqxH+ybDNM87y9W9wP0l/MAgIjrCg
 2/su5QJNcIJgN/nFLvbQmgr2Fw4qNAYWxM0wkH5BXCmS7Yc8Zu51ViWVL8sQzacIeRWFqh
 jfpxRnO4bj+XZJGDAS7lU0WAzLbhymI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-YL7OMlj_M2GRZ3AmHdrcOQ-1; Sun, 23 Apr 2023 02:38:16 -0400
X-MC-Unique: YL7OMlj_M2GRZ3AmHdrcOQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-38def77dd7fso2227687b6e.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Apr 2023 23:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682231896; x=1684823896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BPL/olqTUGJQKqQE7xoRpj15Uybwy151IkJPwrg3JE=;
 b=J9xI4wRdHYivhLl4erHYKrZSEAIw9UMmqH9s8O7Kk0m/NJuNUPNHJYiQHeiX8F35Ln
 Mrt7dPjzsTz/wKN42/tukH3UO2Ysisrfu7nqwHsjuI/SjGzTv58NSKiPnVc1lX4NzdvJ
 leww4y/dhzNOSW88X7sWaRZUnWRe9Hr2g5BhrftRQx7fYwFPrMucWo9Ysx9ZuFEAdKq0
 z46juKlbPRdFijDrZFEyzFOszWMuEGCJdqDrydAlT3si0Sx5edd8jQKefWpKBFCTNpiD
 tgF23iNnpjYyIA/acXm1eUsZsnyHDssnirxF+3pOi6asnjOmWiFUvfMspHz+t72oDyxp
 Pshg==
X-Gm-Message-State: AAQBX9cEZ7mDuDKC5MksPUW3ATc6Ln0+NI0d6DmEF6B6swIyIua96kWm
 e/n9w6zgO64F9GPWtNsVQ6hcCanXgtj1olcDHIXYvyezGqT7uuElKAWtZNHF8DfxEHSHdvnXTPg
 Kr/9mf+bI8XU9gAAM5cBQZx+DtxVKyQogKd+yGVq9uMiv8t1nuc9PkBcu6w==
X-Received: by 2002:a54:4783:0:b0:38e:8ceb:d47a with SMTP id
 o3-20020a544783000000b0038e8cebd47amr3337904oic.26.1682231896063; 
 Sat, 22 Apr 2023 23:38:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z6YqSmKhSieW9FXT/T4WK1UxBcki70dOIOirtWM/xemhs3UGhyEmHEWjo33nvx9jj2k61jFcZP3sqkvaN/u1o=
X-Received: by 2002:a54:4783:0:b0:38e:8ceb:d47a with SMTP id
 o3-20020a544783000000b0038e8cebd47amr3337897oic.26.1682231895862; Sat, 22 Apr
 2023 23:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230421195641.391-1-shannon.nelson@amd.com>
 <20230421195641.391-2-shannon.nelson@amd.com>
In-Reply-To: <20230421195641.391-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 23 Apr 2023 14:38:04 +0800
Message-ID: <CACGkMEu6VzvEg8mEbqetH+yBgWaCzerJ-0w4ZMK_keAxVaa40A@mail.gmail.com>
Subject: Re: [PATCH 1/3] vhost_vdpa: tell vqs about the negotiated
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

T24gU2F0LCBBcHIgMjIsIDIwMjMgYXQgMzo1N+KAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IEFzIGlzIGRvbmUgaW4gdGhlIG5ldCwgaXNjc2ks
IGFuZCB2c29jayB2aG9zdCBzdXBwb3J0LCBsZXQgdGhlIHZkcGEgdnFzCj4ga25vdyBhYm91dCB0
aGUgZmVhdHVyZXMgdGhhdCBoYXZlIGJlZW4gbmVnb3RpYXRlZC4gIFRoaXMgYWxsb3dzIHZob3N0
Cj4gdG8gbW9yZSBzYWZlbHkgbWFrZSBkZWNpc2lvbnMgYmFzZWQgb24gdGhlIGZlYXR1cmVzLCBz
dWNoIGFzIHdoZW4gdXNpbmcKPiBQQUNLRUQgdnMgc3BsaXQgcXVldWVzLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+CgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVy
cy92aG9zdC92ZHBhLmMgfCAxMyArKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4IDdiZTlkOWQ4ZjAxYy4uNTk5YjhjYzIzOGM3IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBh
LmMKPiBAQCAtMzg1LDcgKzM4NSwxMCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9mZWF0
dXJlcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IF9fdXNlciAqZmVhdHVyZXApCj4gIHsKPiAg
ICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gICAgICAgICBjb25z
dCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4gKyAgICAgICBz
dHJ1Y3Qgdmhvc3RfZGV2ICpkID0gJnYtPnZkZXY7Cj4gKyAgICAgICB1NjQgYWN0dWFsX2ZlYXR1
cmVzOwo+ICAgICAgICAgdTY0IGZlYXR1cmVzOwo+ICsgICAgICAgaW50IGk7Cj4KPiAgICAgICAg
IC8qCj4gICAgICAgICAgKiBJdCdzIG5vdCBhbGxvd2VkIHRvIGNoYW5nZSB0aGUgZmVhdHVyZXMg
YWZ0ZXIgdGhleSBoYXZlCj4gQEAgLTQwMCw2ICs0MDMsMTYgQEAgc3RhdGljIGxvbmcgdmhvc3Rf
dmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU2NCBfX3VzZXIgKmZlYXR1
cmVwKQo+ICAgICAgICAgaWYgKHZkcGFfc2V0X2ZlYXR1cmVzKHZkcGEsIGZlYXR1cmVzKSkKPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4KPiArICAgICAgIC8qIGxldCB0aGUgdnFz
IGtub3cgd2hhdCBoYXMgYmVlbiBjb25maWd1cmVkICovCj4gKyAgICAgICBhY3R1YWxfZmVhdHVy
ZXMgPSBvcHMtPmdldF9kcml2ZXJfZmVhdHVyZXModmRwYSk7Cj4gKyAgICAgICBmb3IgKGkgPSAw
OyBpIDwgZC0+bnZxczsgKytpKSB7Cj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92aXJ0
cXVldWUgKnZxID0gZC0+dnFzW2ldOwo+ICsKPiArICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygm
dnEtPm11dGV4KTsKPiArICAgICAgICAgICAgICAgdnEtPmFja2VkX2ZlYXR1cmVzID0gYWN0dWFs
X2ZlYXR1cmVzOwo+ICsgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJnZxLT5tdXRleCk7Cj4g
KyAgICAgICB9Cj4gKwo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+IC0tCj4gMi4xNy4xCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
