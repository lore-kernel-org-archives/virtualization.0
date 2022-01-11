Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FE4C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 11:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B572B60C09;
	Tue, 11 Jan 2022 11:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6WK9T5QYqiV; Tue, 11 Jan 2022 11:52:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 547E360AF0;
	Tue, 11 Jan 2022 11:52:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27815C0030;
	Tue, 11 Jan 2022 11:52:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 039D3C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D79848148E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SRnXVHe2nrbh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:52:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 182B3813F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641901943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E31hZYFQcW+4o6U46docQzadWaoFYJuACIqYHgH7CS0=;
 b=Lzm4NFA30KF4eJmNuBdJswnH1k92PYXkmlewX4pd7CmCr4D+82MsD3txX6TLPhEnWueetj
 GX3/s6Ja9IdCy3R648ZP3gYP9o1ymy/Q9j9TT56XbwKHpzoyDuR3SBjC5R4N7QcLtZwzd8
 Z4EjfE88LrkWFtDzqjTgQ2w61oLUoXQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-4GQGd_IIN7SZALu6-CvhEQ-1; Tue, 11 Jan 2022 06:52:22 -0500
X-MC-Unique: 4GQGd_IIN7SZALu6-CvhEQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 m15-20020a7bce0f000000b003473d477618so1398035wmc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 03:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=E31hZYFQcW+4o6U46docQzadWaoFYJuACIqYHgH7CS0=;
 b=GbpXkfMe99s8elAB8jx9M++1vBzClwcIucxgf1sqhF7cBeybwP7PLxpXjZY+n376qN
 c8L4NqJ7iq5U5acX6wk9irvbWqgcDTE+4JmcqueXQ+IChSEQRcMNhF+y+FMd6c4VeI3r
 iH/XGZRWJftN4XQSp3TemsPGwtlKmRrQfFECIwaywwCY6SdDbwDp8XjLK+knWIcdmSxQ
 0tgbFEgSpPcpTo1Ah3S6V7oPAWhyTA6Q7mwWY2cDNarAE8C70p+pCRel3XSv2GvmwX6C
 1RJOhjQhlry/jQ+RlKXSoKY4zw+L6mLysJV+ksrhttgg6+aeOQvMnN3l+b2x3HWrRf+w
 aWCw==
X-Gm-Message-State: AOAM5337FVIvSpLrHmBKd8Iz/SeJfPzqE9Fs5Zv6lMpLOTJZB3QHtwPY
 olOW9e+yn4Wvbn7DIKWqM8MXvy0Ci3vlVR8G/6B/kOqHI5ZT6tZAKv0nzFkyYdcWNFiBcu7dgCM
 LBbuwm2VCpGRwKQVa/h7sMz7pF2A65EeaJp/JOvmqdA==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr2213614wmj.56.1641901941339; 
 Tue, 11 Jan 2022 03:52:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8n6FfOAwkWyYM7OljIHJJOBJHfRQiGCE6/GSFcIYglr5BcpFEwtehF5B/LALF7+cSmwk+Ig==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr2213593wmj.56.1641901941092; 
 Tue, 11 Jan 2022 03:52:21 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id o15sm9550668wro.70.2022.01.11.03.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 03:52:20 -0800 (PST)
Date: Tue, 11 Jan 2022 06:52:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220111065033-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_7A45E1E967F13AE14B061269@qq.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMTE6MzY6NDJBTSArMDgwMCwg5p2O5Lic5Y2HIHdyb3Rl
Ogo+IFdoZW4gdmlydGlvIHZkcGEgZGV2aWNlIHJlbW92ZWQsIHRoZSBhYm5vcm1hbCBkYW1hZ2Ug
b2YgdGhlIGRldmljZSBjYW5ub3QgYmUKPiBwZXJjZWl2ZWQgbm9ybWFsbHksIHdoaWNoIHdpbGwg
Y2F1c2UgcHJvYmxlbXMgc2ltaWxhciB0bzoKPiAKPiA0M2JiNDBjNWI5MjYKCgpTaG91bGQgaW5j
bHVkZSB0aGUgc3ViamVjdCBvZiB0aGUgcGF0Y2ggdG9vLgoKPiBIZW5jZSwgYWRkIHRoZSBhYmls
aXR5IHRvIGFib3J0IHRoZSBjb21tYW5kIG9uIHN1cnByaXNlIHJlbW92YWwKPiAKPiBTaWduZWQt
b2ZmLWJ5OiBkb25nc2hlbmcgbGkgPGxpZG9uZ3NoZW5nQGRheXVkcHUuY29tPgoKV2hlbiByZW1v
dmluZyBncmFjZWZ1bGx5LApJIGFtIG5vdCBzdXJlIHdlIHNob3VsZCBicmVhayBkZXZpY2UgdW5j
b25kaXRpb25hbGx5IGxpa2UgdGhpcwpiZWZvcmUgZ2l2aW5nIGRyaXZlcnMgYSBjaGFuY2UgdG8g
Y2xlYW4gdXAuClNob3VsZCB3ZSBqdXN0IGRvIGl0IGZvciBzdXJwcmlzZSByZW1vdmFsPwoKPiAt
LS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiBpbmRleCA0YTlkZGI0NGIy
YTcuLmZkOTMwNDA5ZDE5MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRw
YS5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IEBAIC0zNzQsNiArMzc0
LDcgQEAgc3RhdGljIHZvaWQgdmlydGlvX3ZkcGFfcmVtb3ZlKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYSkKPiAgewo+ICAgc3RydWN0IHZpcnRpb192ZHBhX2RldmljZSAqdmRfZGV2ID0gdmRwYV9n
ZXRfZHJ2ZGF0YSh2ZHBhKTsKPiAKPiArIHZpcnRpb19icmVha19kZXZpY2UodmRfZGV2LT52ZGV2
KTsKPiAgIHVucmVnaXN0ZXJfdmlydGlvX2RldmljZSgmdmRfZGV2LT52ZGV2KTsKPiAgfQo+IAo+
IC0tCj4gMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
