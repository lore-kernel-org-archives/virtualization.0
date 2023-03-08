Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBDBC64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 05:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D841813BD;
	Wed,  8 Mar 2023 05:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D841813BD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoJQy3zs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J4vNUX2ua1Da; Wed,  8 Mar 2023 05:58:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 05F0D813BF;
	Wed,  8 Mar 2023 05:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05F0D813BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFE5AC0035;
	Wed,  8 Mar 2023 05:58:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B712C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04C0E60F4A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04C0E60F4A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoJQy3zs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0HxFIqm7dtXU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:58:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CBB560EAA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CBB560EAA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678255119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=415+IFDh5rs5GQqAGXXxgGFOeqIMmr1DIQPj9ls6/Ao=;
 b=RoJQy3zsfDxU0hD6+AUr1XSM7g6LQGQO800DBsl32Jtk+rH2jxJMNBj3f/tzgCLMXGs/Uu
 6QR7DKgR7Efdp05IXJGrRHtVB64aW/kOd+lqhpCwIyv7c2+TIzuQYBcjF3ax+8BAPIHGSg
 0B8TvtePHPbSsqQNcSjFS3SYB7BiKPU=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-M_NhvsxnPTO3mTMCVgYu4w-1; Wed, 08 Mar 2023 00:58:36 -0500
X-MC-Unique: M_NhvsxnPTO3mTMCVgYu4w-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-176a9e1e3cfso6218368fac.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 21:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678255115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=415+IFDh5rs5GQqAGXXxgGFOeqIMmr1DIQPj9ls6/Ao=;
 b=1/mtgDiCeipoc2CVpanUtIzo5o8Urxt0MCC3rzLG4G4GcVGFn6BbCw3GC3Zz2Jz3Ww
 xI82tjxdi661MOncOwc9BQl6xpxK9+1vSoKUsWBSB/dJx3GB0ARu2AtXd4sdKiHyetWr
 cCng/SlY/G/02PHDFQvOjn8bW9aBVoGU4S4cMxKMsatZGWhBI/8iV1FuCQ2prNbYKLSF
 ZYYtau7pD5lUQshiNXps8lPKOKu9ec8ItH319t0RTtPS4k+y5scJ0bdSQD+nTJX4b3Qq
 j1yYUoBBfIQwERim2rlqoQig8PixPxdcBW3xa/c9XgxfeZ64fW/KfPwFY2J7LMkRyFcF
 2fTw==
X-Gm-Message-State: AO0yUKUw+Dkq8dgfgOn7aFtuW5FcxqHJ+ehX33KqSh219AdolAZ1W5iB
 h9AOayfvZVCK/Xe+riw/CmoDvsApW7ChTN1Vd1Ikf3UNJVlvIjlJgdt6F8bYrqW0hGL+m8ynvJU
 hQNgAgPJ1eZUq09g9NrGbHmB43Jbbk4QRQ5HGblppNjCWh9S4g374Qtrxpg==
X-Received: by 2002:a05:6830:26c6:b0:68b:e0dc:abc7 with SMTP id
 m6-20020a05683026c600b0068be0dcabc7mr5266418otu.4.1678255115494; 
 Tue, 07 Mar 2023 21:58:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9JC1ZBTPNSYZptZf00lkiXDF+lIRX8mH1iDF+7ErMNvIwYEtrAAwuR2riKdLKuLVnvD5Wkh31pEAodk4MWHwc=
X-Received: by 2002:a05:6830:26c6:b0:68b:e0dc:abc7 with SMTP id
 m6-20020a05683026c600b0068be0dcabc7mr5266409otu.4.1678255115309; Tue, 07 Mar
 2023 21:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
In-Reply-To: <20230307035705.4479-4-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:58:24 +0800
Message-ID: <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
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
Y29tPiB3cm90ZToKPgo+IEFkZCBjb25zdCB0byBtYWtlIHRoZSByZWFkLW9ubHkgcG9pbnRlciBw
YXJhbWV0ZXJzIGNsZWFyLCBzaW1pbGFyIHRvCj4gbWFueSBleGlzdGluZyBmdW5jdGlvbnMuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1i
eTogSmlyaSBQaXJrbyA8amlyaUBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5k
aXQgPHBhcmF2QG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEdhdmluIExpIDxnYXZpbmxAbnZp
ZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogQm9kb25nIFdhbmcgPGJvZG9uZ0BudmlkaWEuY29tPgo+
IC0tLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjUgKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLQo+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgMTIgKysrKysrLS0t
LS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0p
Cj4KClsuLi5dCgo+Cj4gLS8qCj4gLSAqIFRoaXMgc2hvdWxkIHByZXZlbnQgdGhlIGRldmljZSBm
cm9tIGJlaW5nIHVzZWQsIGFsbG93aW5nIGRyaXZlcnMgdG8KPiArLyBUaGlzIHNob3VsZCBwcmV2
ZW50IHRoZSBkZXZpY2UgZnJvbSBiZWluZyB1c2VkLCBhbGxvd2luZyBkcml2ZXJzIHRvCj4gICAq
IHJlY292ZXIuICBZb3UgbWF5IG5lZWQgdG8gZ3JhYiBhcHByb3ByaWF0ZSBsb2NrcyB0byBmbHVz
aC4KPiAgICovCgpBbnkgcmVhc29uIGZvciB0aGlzIGNoYW5nZT8KClRoYW5rcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
