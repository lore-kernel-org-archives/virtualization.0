Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9D5EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 03:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED4AF404A8;
	Thu, 10 Aug 2023 03:09:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED4AF404A8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FjCa436K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lfhlUJ_t3thb; Thu, 10 Aug 2023 03:09:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D4D640450;
	Thu, 10 Aug 2023 03:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D4D640450
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C11F2C0072;
	Thu, 10 Aug 2023 03:09:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13B85C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA6A160E80
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:09:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA6A160E80
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FjCa436K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ciIWuLRrnR1t
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:09:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDB5F60BAC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDB5F60BAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691636946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWWq0EGG2u0OCeECE7RLKKScPij7crQyrRfy1wkw++M=;
 b=FjCa436KGJug70RS3ikUjs5eDe0hlVEIEkoOqElm5//fl3HaKXk0GTz/kOCJ/rWl8Lp4l3
 lMNqUpw3g4WsOrPVu0q8GR048qq/F3BRhepAkI0GwvbMsu5TiFLTHC2nI4d495X6GcHahj
 FmcCgujM3/sPZYUWP4WQJQvjxjPbXSo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-M3vS9xN3P_ygiGioTRdO4g-1; Wed, 09 Aug 2023 23:09:05 -0400
X-MC-Unique: M3vS9xN3P_ygiGioTRdO4g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9b2fb9770so4933251fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 20:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691636943; x=1692241743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWWq0EGG2u0OCeECE7RLKKScPij7crQyrRfy1wkw++M=;
 b=hzDe0g8Xs0FD+zGoH1gWP2VZ80oiUm2a/gIGj71Mo/31k0R3wgzyox12f8X3EY6lq4
 4rq0S63fJpmGNwGDKRa5C6SIVMqZNsxuLLr5JJ/PXf0+MZOWeD9x1JcCye3+xZX/z20S
 Hp9ud+qocEcRP6CGJCMaVJEVFyD1f+GJlnSSUj2SdKMXujnPlTR6QqqB2RLHr32IETzx
 u1hiQvq2zjTjchcs7JfopaxlCCawOPG5y/UM/Rusob6uzyFj2KSPbAPpQKqZjq0bJ4bU
 NG+QnYsc1iT2jrEwUCGQ0Du4wFFsPxVncKSVt7fZbll6IA4spZrfdlWG5c5TIsjy7blv
 LNxA==
X-Gm-Message-State: AOJu0Yz/ANzGvmAyTKmDXEOUIu86bNH9mrRB3zLOkuwhDhbXVJJr3a3c
 6I/hbXosY1COcLjwBIds73tIYzxRXutt5nJcNl9ExLrKhDe2sdTX3u34sKzQSieqFtBMtddx5yc
 dGijCM5gVp76TEnkqVOA4sGgA0PoPb672vwm/LaLXbvPhvgtDgiMED+XQVg==
X-Received: by 2002:a2e:8315:0:b0:2b9:dd5d:5d0c with SMTP id
 a21-20020a2e8315000000b002b9dd5d5d0cmr678691ljh.52.1691636943743; 
 Wed, 09 Aug 2023 20:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3LleKV8S+nqPDMYmM7yYYUriCc/nwUKyNw6FhYEbpjQM5dxmqWS6Rz/vfk91WXvDekBuMCs7Ia0hUgiqVC9I=
X-Received: by 2002:a2e:8315:0:b0:2b9:dd5d:5d0c with SMTP id
 a21-20020a2e8315000000b002b9dd5d5d0cmr678680ljh.52.1691636943405; Wed, 09 Aug
 2023 20:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230803143718.GA2330143@fedora>
In-Reply-To: <20230803143718.GA2330143@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 11:08:52 +0800
Message-ID: <CACGkMEvjrs17TMH2=b+mwm7qGFqEWV3jHydLyK7=Aj8spBNthw@mail.gmail.com>
Subject: Re: Unbinding virtio_pci_modern does not release BAR4 in Linux
 6.5.0-rc4
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBBdWcgMywgMjAyMyBhdCAxMDozN+KAr1BNIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBIaSwKPiBBZnRlciBydW5uaW5nICJkcml2ZXJjdGwg
LS1ub3NhdmUgc2V0LW92ZXJyaWRlIDAwMDA6MDE6MDAuMCB2ZmlvLXBjaSIgb24KPiBhIHZpcnRp
by1ibGstcGNpIGRldmljZSwgL3Byb2MvaW9tZW0gc2hvd3MgdGhhdCBCQVI0IGlzIHN0aWxsIG93
bmVkIGJ5Cj4gdmlydGlvX3BjaV9tb2Rlcm4gZXZlbiB0aG91Z2ggdGhlIHZmaW8tcGNpIGRyaXZl
ciBpcyBub3cgYm91bmQgdG8gdGhlCj4gUENJIGRldmljZS4KPgo+IFRoaXMgcmVncmVzc2lvbiB3
YXMgaW50cm9kdWNlZCBhZnRlciA2LjQuNyBidXQgSSBkb24ndCBzZWUgdGhlIGN1bHByaXQKPiBp
biB0aGUgZ2l0IGxvZ3MuCj4KPiBVbmZvcnR1bmF0ZWx5IEkgZG9uJ3QgaGF2ZSB0aW1lIHRvIGlu
dmVzdGlnYXRlIGZ1cnRoZXIgcmlnaHQgbm93IGJ1dAo+IEkndmUgaW5jbHVkZWQgaW5zdHJ1Y3Rp
b25zIG9uIGhvdyB0byByZXByb2R1Y2UgdGhpcyBiZWxvdy4KPgo+IENhbiBhbnlvbmUgZWxzZSBy
ZXByb2R1Y2UgdGhpcyBhbmQgY2FuIHdlIHN0aWxsIGZpeCBpdCBmb3IgdGhlIHVwY29taW5nCj4g
TGludXggNi41PwoKVGhpcyBzZWVtcyB0byBiZSBmaXhlZCBieToKCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMzA3MjAxMzE0MjMtbXV0dC1zZW5kLWVtYWlsLW1zdEBrZXJuZWwub3Jn
L1QvCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gU3RlZmFuCj4gLS0tCj4gJCBxZW11LXN5c3RlbS14
ODZfNjQgXAo+ICAgICAtTSBxMzUsYWNjZWw9a3ZtLGtlcm5lbC1pcnFjaGlwPXNwbGl0IFwKPiAg
ICAgLWNwdSBob3N0IFwKPiAgICAgLW0gMUcgXAo+ICAgICAtZGV2aWNlIGludGVsLWlvbW11LGlu
dHJlbWFwPW9uLGRldmljZS1pb3RsYj1vbiBcCj4gICAgIC0tYmxvY2tkZXYgZmlsZSxmaWxlbmFt
ZT10ZXN0LmltZyxjYWNoZS5kaXJlY3Q9b24sbm9kZS1uYW1lPWRyaXZlMCBcCj4gICAgIC0tZGV2
aWNlIHZpcnRpby1ibGstcGNpLGRyaXZlPWRyaXZlMCBcCj4gICAgIC1ibG9ja2RldiBmaWxlLGZp
bGVuYW1lPXRlc3QyLmltZyxjYWNoZS5kaXJlY3Q9b24sbm9kZS1uYW1lPWRyaXZlMiBcCj4gICAg
IC0tZGV2aWNlIGlvaDM0MjAsaWQ9cGNpZS4xLGNoYXNzaXM9MSBcCj4gICAgIC0tZGV2aWNlIHZp
cnRpby1ibGstcGNpLGRpc2FibGUtbGVnYWN5PW9uLGRpc2FibGUtbW9kZXJuPW9mZixkcml2ZT1k
cml2ZTIsaW9tbXVfcGxhdGZvcm09b24sYXRzPW9uLGJ1cz1wY2llLjEKPgo+IChndWVzdCkjIGRy
aXZlcmN0bCAtLW5vc2F2ZSBzZXQtb3ZlcnJpZGUgMDAwMDowMTowMC4wIHZmaW8tcGNpCj4gKGd1
ZXN0KSMgY2F0IC9wcm9jL2lvbWVtCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
