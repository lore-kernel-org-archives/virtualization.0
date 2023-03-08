Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64406C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 05:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D64F5401C5;
	Wed,  8 Mar 2023 05:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D64F5401C5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvWLitRP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cc6D7fg7-J1b; Wed,  8 Mar 2023 05:53:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E603A401BD;
	Wed,  8 Mar 2023 05:53:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E603A401BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C50CEC0035;
	Wed,  8 Mar 2023 05:53:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E820C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52319401BC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52319401BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4Rsj2BMdBpe
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:53:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0181A401A3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0181A401A3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678254776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwvx+c4bDp4m3SItXQ2onjTQuLtXP9NDhlntQEzW88A=;
 b=JvWLitRPR+D7czyK++i4fOpBkT4d1KX/2lqpgFI7eGtchTCQ19t+lxV/UV9bQ/iPW2Fh8w
 pVNkKHiHfTaLVxOCZDNxsgv3S2E+YRA4ts1VRENo5CagdCZgMaCUiiBjaz6P/ksQvZ2nxz
 XX7kLb2867A837A9xwZFa6j7bEx/N0A=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-0k8nM8yxNkuG4rZX3pcXGQ-1; Wed, 08 Mar 2023 00:52:55 -0500
X-MC-Unique: 0k8nM8yxNkuG4rZX3pcXGQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 s10-20020a056808208a00b0038445b695f9so6572744oiw.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 21:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678254775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwvx+c4bDp4m3SItXQ2onjTQuLtXP9NDhlntQEzW88A=;
 b=kgUKpomnHKX5taRc8YexxsHM/7pDAxbaOo8PgUIEy4EyC+AlV9wsymha2AmJHvqQbs
 wA8dUEV3hIkYChEvpBhflHVt+64k9r4DOw87vLuT4Um33/QI8beuIZIbIv9QXX8lDz5B
 lwTMFKLMMw/vEVe2ukSVSdf3NR6bw0od5W0MyHvPW5YMQOiDNkt/68gBJ/FfwfWob8ng
 NFbRptRKiwgTMiaxNQ5qDMtVhJduQ7b9zUbEbHL9UNLcnu5f4F11Zmhm77jCrrxu0Ui5
 kQxgYmZNnK942GfCgYQ+vgxtNWtXrImSbMeyusgi7MmiRk2aMyJo/xXITiz4Pdfei4bX
 y5ww==
X-Gm-Message-State: AO0yUKVr3Z+EK2mTgdrG/RlAQ7mNpKCiIzV0M7mX+gjL6H8o8F3rt/kc
 2mUjzX2lTnJRlVd/lsh7EAM2eOfiCBbrVg6sRlLWC2qUxo9iBlQX995qApPX9pKQhVwqX6Ry+MQ
 OA186G35FxpWeDDZDfXDwGXA8K45QeU3CBD9TQaVcaM7zqrTaZovPKLkHdQ==
X-Received: by 2002:a54:4810:0:b0:384:4e2d:81ea with SMTP id
 j16-20020a544810000000b003844e2d81eamr5508021oij.9.1678254775149; 
 Tue, 07 Mar 2023 21:52:55 -0800 (PST)
X-Google-Smtp-Source: AK7set90e1/I+IoXF8tiJGUCdxyPnky5a3MPuYoIVwLZVKTSwe7zVYII3StMWYGY8Hit/L31zPaKkNhBMEe/2anOxRo=
X-Received: by 2002:a54:4810:0:b0:384:4e2d:81ea with SMTP id
 j16-20020a544810000000b003844e2d81eamr5508014oij.9.1678254774902; Tue, 07 Mar
 2023 21:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-2-feliu@nvidia.com>
In-Reply-To: <20230307035705.4479-2-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:52:43 +0800
Message-ID: <CACGkMEsrnd_iLM97RZrPnjLTeU4WGFDbPF97826Pj7nx7rUj7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio_pci_modern: Remove unnecessary num zero check
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

T24gVHVlLCBNYXIgNywgMjAyMyBhdCAxMTo1N+KAr0FNIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPiB3cm90ZToKPgo+IGlzX3Bvd2VyX29mXzIoKSBhbHJlYWR5IHBlcmZvcm1zIHRoZSB6ZXJv
IGNoZWNrLiBIZW5jZSBhdm9pZCBkdXBsaWNhdGUKPiBjaGVjay4gV2hpbGUgYXQgaXQsIG1vdmUg
dGhlIHF1ZXJ5IG9mIHNpemUgY2hlY2sgYWxzbyBhZGphY2VudCB0byB3aGVyZQo+IGl0cyB1c2Vk
IGZvciB0aGUgZGlzYWJsZWQgdnEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBGZW5nIExpdSA8ZmVsaXVA
bnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amlyaUBudmlkaWEuY29tPgo+
IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQt
Ynk6IEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogQm9kb25nIFdh
bmcgPGJvZG9uZ0BudmlkaWEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X21vZGVybi5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9t
b2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiBpbmRleCA5ZTQ5
NmUyODhjZmEuLjNkNzE0NGY4Zjk1OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX21vZGVybi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4u
Ywo+IEBAIC0zMDYsMTAgKzMwNiwxMCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBf
dnEoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYsCj4gICAgICAgICAgICAgICAgIHJl
dHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+Cj4gICAgICAgICAvKiBDaGVjayBpZiBxdWV1ZSBpcyBl
aXRoZXIgbm90IGF2YWlsYWJsZSBvciBhbHJlYWR5IGFjdGl2ZS4gKi8KPiAtICAgICAgIG51bSA9
IHZwX21vZGVybl9nZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCk7Cj4gLSAgICAgICBpZiAoIW51
bSB8fCB2cF9tb2Rlcm5fZ2V0X3F1ZXVlX2VuYWJsZShtZGV2LCBpbmRleCkpCj4gKyAgICAgICBp
ZiAodnBfbW9kZXJuX2dldF9xdWV1ZV9lbmFibGUobWRldiwgaW5kZXgpKQo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKClNwZWMgYWxsb3dzIG5vbiBwb3dlciBvZiAy
IHNpemUgZm9yIHBhY2tlZCB2aXJ0cXVldWUsIHNvIEkgdGhpbmsgd2UKc2hvdWxkIGZpeCBpdCBp
biB0aGlzIHdheS4KCiIiIgpRdWV1ZSBTaXplIGNvcnJlc3BvbmRzIHRvIHRoZSBtYXhpbXVtIG51
bWJlciBvZiBkZXNjcmlwdG9ycyBpbiB0aGUKdmlydHF1ZXVlNS4gVGhlIFF1ZXVlIFNpemUgdmFs
dWUgZG9lcyBub3QgaGF2ZSB0byBiZSBhIHBvd2VyIG9mIDIuCiIiIgoKVGhhbmtzCgo+Cj4gKyAg
ICAgICBudW0gPSB2cF9tb2Rlcm5fZ2V0X3F1ZXVlX3NpemUobWRldiwgaW5kZXgpOwo+ICAgICAg
ICAgaWYgKCFpc19wb3dlcl9vZl8yKG51bSkpIHsKPiAgICAgICAgICAgICAgICAgZGV2X3dhcm4o
JnZwX2Rldi0+cGNpX2Rldi0+ZGV2LCAiYmFkIHF1ZXVlIHNpemUgJXUiLCBudW0pOwo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPiAtLQo+IDIuMzQuMQo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
