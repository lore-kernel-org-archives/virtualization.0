Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959DCC4332F
	for <virtualization@archiver.kernel.org>; Tue,  4 Jan 2022 06:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC94760B68;
	Tue,  4 Jan 2022 06:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDiTrDbRZK62; Tue,  4 Jan 2022 06:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91D1560B57;
	Tue,  4 Jan 2022 06:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B91DC002F;
	Tue,  4 Jan 2022 06:18:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2265C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 06:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2CE982521
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 06:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8WjK-uWNMRlC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 06:18:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC41E81773
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 06:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641277106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yme3gthvDotqdj2BSsfSfVFe7NbjzfhJz1GZIqOQqEM=;
 b=QB4nXUVzfjG6YqP+lCa0hO/5TjCqdEyyrLEndxeqFAIQXTtEiRN+C96cpjI+HqOMDH4yux
 KRA+hk9H7mil39z1Ts5jcczCB2yjZMb4HDYdvXPkE1Uv4xg/kLj8HvDyfeQxdRHAvVGJ7y
 4Zgi0s8Rg5gp64lQjm7kceiboFcQMB8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-mFi6Zt6AOruAc7PmIEE_Yg-1; Tue, 04 Jan 2022 01:18:25 -0500
X-MC-Unique: mFi6Zt6AOruAc7PmIEE_Yg-1
Received: by mail-lf1-f72.google.com with SMTP id
 b5-20020a196445000000b0042659f2a17cso6467340lfj.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jan 2022 22:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yme3gthvDotqdj2BSsfSfVFe7NbjzfhJz1GZIqOQqEM=;
 b=k4f+dgrsvjd/IvhjVH80dR6C1bGpJpDBdh7/w12rTtAykEmKxCdeQZlJ/5kH+AtNnU
 kfV1LMaZqxLNwsi0rI2zpjn7oTtZiXwXQOGy8uIwkkxvIvesBZvAdosA+Iqo3arbJsfg
 Nf05gxzfat8Qq21nQa0erWTC5qZ7BIqhZ24zGVRoT7fj3vonxXyo5ZBsvrDliiMzAoO+
 sQTdqI8EJ+T5e4HvAAXBfAiDvyqWIyoxXp/DIWdOov5Bc4gmbdqiwr0prBWM9a7sC8iQ
 7+7HdSlWr5wFuPn0dc52AbjpVZ23nbBAKeKFf/Ybp88kH/MB9hpQmOPArg4wZCJ/vUum
 0dGw==
X-Gm-Message-State: AOAM531TBHgGBxcPiLl7siVNtglE8woPjYJ8aWuH9f15AdQQNA1wlrmO
 62FZ0LWDjOY6G6h4vZBy9X0x16vLwjDLKh8Od0LyLsqNAxsx23gm0femaiWXhoa6zB1A3wNW3W4
 FYDIoGEHFQ0ENdpqWaKupuuDdZXhVZE6p9t6x6/3jlo7C63PYJd7fPx8K4Q==
X-Received: by 2002:a2e:8543:: with SMTP id u3mr34747336ljj.307.1641277104106; 
 Mon, 03 Jan 2022 22:18:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdVkCgMnSgDfuPSVLPjfswxLwrUCNR4yJjqO1BySzqljdsSTjORg+r3nl0SUZygKiwSfOCt8RtgFoPS9zZDwA=
X-Received: by 2002:a2e:8543:: with SMTP id u3mr34747331ljj.307.1641277103953; 
 Mon, 03 Jan 2022 22:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20211228030924.3468439-1-xianting.tian@linux.alibaba.com>
 <8a7f84b6-8d63-0005-754b-cfd158c8952e@linux.alibaba.com>
In-Reply-To: <8a7f84b6-8d63-0005-754b-cfd158c8952e@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Jan 2022 14:18:12 +0800
Message-ID: <CACGkMEsA+b_YSa7ASww7qDM3f-4q39qGEa0Gyu5qXTvTeW-odg@mail.gmail.com>
Subject: Re: [PATCH] vhost/test: fix memory leak of vhost virtqueues
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 mst <mst@redhat.com>
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

T24gVHVlLCBKYW4gNCwgMjAyMiBhdCAxOjU5IFBNIFhpYW50aW5nIFRpYW4KPHhpYW50aW5nLnRp
YW5AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gaGkKPgo+IENvdWxkIEkgZ2V0IHlvdXIg
Y29tbWVudHMgZm9yIHRoaXMgcGF0Y2g/ICBpdCBmaXhlZCB0aGUgbWVtbGVhayBpc3N1ZS4KPgo+
IOWcqCAyMDIxLzEyLzI4IOS4iuWNiDExOjA5LCBYaWFudGluZyBUaWFuIOWGmemBkzoKPiA+IFdl
IG5lZWQgZnJlZSB0aGUgdnFzIGluIC5yZWxlYXNlKCksIHdoaWNoIGFyZSBhbGxvY2F0ZWQgaW4g
Lm9wZW4oKS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50
aWFuQGxpbnV4LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+Cgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmhvc3QvdGVzdC5jIHwgMSArCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3Rlc3QuYyBiL2RyaXZlcnMvdmhvc3QvdGVzdC5jCj4gPiBpbmRleCBhMDlkZWRj
NzkuLjA1NzQwY2JhMSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdGVzdC5jCj4gPiAr
KysgYi9kcml2ZXJzL3Zob3N0L3Rlc3QuYwo+ID4gQEAgLTE2Niw2ICsxNjYsNyBAQCBzdGF0aWMg
aW50IHZob3N0X3Rlc3RfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAq
ZikKPiA+ICAgICAgIC8qIFdlIGRvIGFuIGV4dHJhIGZsdXNoIGJlZm9yZSBmcmVlaW5nIG1lbW9y
eSwKPiA+ICAgICAgICAqIHNpbmNlIGpvYnMgY2FuIHJlLXF1ZXVlIHRoZW1zZWx2ZXMuICovCj4g
PiAgICAgICB2aG9zdF90ZXN0X2ZsdXNoKG4pOwo+ID4gKyAgICAga2ZyZWUobi0+ZGV2LnZxcyk7
Cj4gPiAgICAgICBrZnJlZShuKTsKPiA+ICAgICAgIHJldHVybiAwOwo+ID4gICB9Cj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
