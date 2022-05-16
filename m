Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7C4C433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 09:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 782FE41796;
	Mon, 16 May 2022 09:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIuSR7Qp9Pnt; Mon, 16 May 2022 09:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C766B41734;
	Mon, 16 May 2022 09:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9CB5C0039;
	Mon, 16 May 2022 09:14:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C95F9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B243E40B19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_omWleBWXmC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:14:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9984740AF1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652692448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9K9R6QhUrFoVx+JV+/dSMLovTFHWKyZbpLw+GMIGnEA=;
 b=GD+tr+iFzeXzXRpg1fbrPOv5etleOpZ3DQKzwHCKcN+5dJOtUww7dpCHB3ZGhozgwrEs9j
 jfOe7CxN8YA5TqZTlSP2vZJMbnBHwk9yxkAb1S8UzEjJhJWan04FVxZvYWBFKPIXk8bdq4
 Y1gSnAqXHS+zv5Uwd9rN6SrjDT2J8M0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-bSsn9XE2MDqZhfycgivbNw-1; Mon, 16 May 2022 05:14:07 -0400
X-MC-Unique: bSsn9XE2MDqZhfycgivbNw-1
Received: by mail-pj1-f71.google.com with SMTP id
 oj9-20020a17090b4d8900b001df6cd6813cso619761pjb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 02:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9K9R6QhUrFoVx+JV+/dSMLovTFHWKyZbpLw+GMIGnEA=;
 b=kxBXZNx30T4V9IgbUbfJdwTyn3NNITtYTl/XKPofCGXlbH0wf/EalfDoGBGa8QXCNI
 rquQ1RES/jynHwaqFERq9tW3jL3NYvgSMPbfqthO1B+PWhP02O1/udYnWyAF7iuHop2+
 2MuiZWSUPZSxHqnXCHacz7TlKvyURJm26/qFxRHffK9nYA9b45id7GQTnXsgxKyS3np0
 FuOi5Gxi1N8IDBihZzwzI6jn1aKUeyyZ1pvsqHieMY6uXaUhAhix6JcZNc0iuVdNukef
 DN+Yfc/1d94rUzJkLjtB/jsp+QdJxGaIQFjtCS3/+tLgOjYAaqlISqnIs9RyH4Y0otJi
 gB9g==
X-Gm-Message-State: AOAM530F/anWbr90DLKZZh2J6NWcsRwCDDBp6s3iLWP9GoOZh7fJfvP8
 aUGLbJwAOdgBF9W8zpwO1PDP0wdPdlYgLhemdsbVyv7S39tKExUk6F1ZMvqOLKeNGXJixfvXkhc
 q8vUcKqmarLU4HNXqiPfZUlfUqErE/52y+LrhGd2pVQ==
X-Received: by 2002:a65:49c1:0:b0:3db:6979:ca6f with SMTP id
 t1-20020a6549c1000000b003db6979ca6fmr14417175pgs.76.1652692445962; 
 Mon, 16 May 2022 02:14:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX68j9a2dSvHFfMtguvE8LxZ2Uoh0cGJa7d4S13blhh4ckJuq3X0WC/+BBcus1M8F1m7nwzw==
X-Received: by 2002:a65:49c1:0:b0:3db:6979:ca6f with SMTP id
 t1-20020a6549c1000000b003db6979ca6fmr14417160pgs.76.1652692445734; 
 Mon, 16 May 2022 02:14:05 -0700 (PDT)
Received: from [10.72.13.125] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 cj18-20020a056a00299200b00517d7fb695fsm2318952pfb.200.2022.05.16.02.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 02:14:05 -0700 (PDT)
Message-ID: <51811045-548c-1241-0a25-d23e8f7c9d1d@redhat.com>
Date: Mon, 16 May 2022 17:14:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 gregkh@linuxfoundation.org, lingshan.zhu@intel.com, parav@nvidia.com,
 elic@nvidia.com
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220516060342.106-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzUvMTYgMTQ6MDMsIFhpZSBZb25namkg5YaZ6YGTOgo+IEludHJvZHVjZSBhIGRl
dmljZSBvYmplY3QgZm9yIHZkcGEgbWFuYWdlbWVudCBkZXZpY2UgdG8gY29udHJvbAo+IGl0cyBs
aWZlY3ljbGUuIEFuZCB0aGUgZGV2aWNlIG5hbWUgd2lsbCBiZSB1c2VkIHRvIG1hdGNoCj4gVkRQ
QV9BVFRSX01HTVRERVZfREVWX05BTUUgZmllbGQgb2YgbmV0bGluayBtZXNzYWdlIHJhdGhlciB0
aGFuCj4gdXNpbmcgcGFyZW50IGRldmljZSBuYW1lLgo+Cj4gV2l0aCB0aGlzIHBhdGNoIGFwcGxp
ZWQsIGRyaXZlcnMgc2hvdWxkIHVzZSB2ZHBhX21nbXRkZXZfYWxsb2MoKQo+IG9yIF92ZHBhX21n
bXRkZXZfYWxsb2MoKSB0byBhbGxvY2F0ZSBhIHZEUEEgbWFuYWdlbWVudCBkZXZpY2UKPiBiZWZv
cmUgY2FsbGluZyB2ZHBhX21nbXRkZXZfcmVnaXN0ZXIoKS4gQW5kIHNvbWUgYnVnZ3kgZW1wdHkK
PiByZWxlYXNlIGZ1bmN0aW9uIGNhbiBhbHNvIGJlIHJlbW92ZWQgZnJvbSB0aGUgZHJpdmVyIGNv
ZGVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jICAgICAgfCAxMSAr
Ky0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgICAgfCAxMSArKy0tCj4g
ICBkcml2ZXJzL3ZkcGEvdmRwYS5jICAgICAgICAgICAgICAgICAgfCA5MiArKysrKysrKysrKysr
KysrKysrKysrKystLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMg
fCAzOSArKysrLS0tLS0tLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQu
YyB8IDQ2ICsrKysrLS0tLS0tLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jICAgfCAzOCArKysrLS0tLS0tLS0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAg
ICAgICAgICB8IDM4ICsrKysrKysrKysrLQo+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxNjggaW5zZXJ0
aW9ucygrKSwgMTA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gaW5k
ZXggNDM2NjMyMGZiNjhkLi5kNDA4N2MzN2NmZGYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWlu
LmMKPiBAQCAtODIxLDEwICs4MjEsMTEgQEAgc3RhdGljIGludCBpZmN2Zl9wcm9iZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+ICAgCXUzMiBk
ZXZfdHlwZTsKPiAgIAlpbnQgcmV0Owo+ICAgCj4gLQlpZmN2Zl9tZ210X2RldiA9IGt6YWxsb2Mo
c2l6ZW9mKHN0cnVjdCBpZmN2Zl92ZHBhX21nbXRfZGV2KSwgR0ZQX0tFUk5FTCk7Cj4gLQlpZiAo
IWlmY3ZmX21nbXRfZGV2KSB7Cj4gKwlpZmN2Zl9tZ210X2RldiA9IHZkcGFfbWdtdGRldl9hbGxv
YyhzdHJ1Y3QgaWZjdmZfdmRwYV9tZ210X2RldiwKPiArCQkJCQkgICAgbWRldiwgZGV2X25hbWUo
ZGV2KSwgZGV2KTsKCgpKdXN0IHdvbmRlciBpZiBpdCdzIGJldHRlciB0byBtYWtlIHZEUEEgZGV2
aWNlIGEgY2hpbGQgb2YgdGhlIG1nbXQgCmRldmljZSBpbnN0ZWFkIG9mIHRoZSBQQ0kgZGV2aWNl
PwoKKEN1cnJlbnRseSB3ZSB1c2UgUENJIGRldmljZSBhcyB0aGUgcGFyZW50IG9mIHRoZSB2RFBB
IGRldmljZSwgb3IgYXQgCmxlYXN0IHdlIGNhbiBkbyB0aGlzIGZvciB0aGUgc2ltdWxhdG9yIHdo
aWNoIGRvZXNuJ3QgaGF2ZSBhIHBhcmVudD8pCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
