Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D3C433F5
	for <virtualization@archiver.kernel.org>; Sat,  8 Oct 2022 04:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C2244019D;
	Sat,  8 Oct 2022 04:48:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C2244019D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SuE5IDM7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L82Zxpu9hdlp; Sat,  8 Oct 2022 04:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B34EC400CB;
	Sat,  8 Oct 2022 04:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B34EC400CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89D0EC0032;
	Sat,  8 Oct 2022 04:48:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9030C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Oct 2022 04:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B219A60AAC
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Oct 2022 04:48:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B219A60AAC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SuE5IDM7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0hxHef9iG3Mj
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Oct 2022 04:48:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8C82605EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8C82605EC
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Oct 2022 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665204525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UR03F1LH3w2DyC2bKoegajgsRdph1ICRu5SgxFtX7YI=;
 b=SuE5IDM7CBJaQfiHamKl8l/kRQxv8HiaVD7h09c/Fj4T/p7ICFGuDzfz/Y0gkSnz8tAWbW
 oWJZE7uaq0ertZ+vmgG2wGPEghKHsKMvt4kyfEJYUp/NaMm+uLbWldunlZ7rsysqgpaGF6
 PIjMqlshy/FIQtTNM0kmUHkkTQUX/so=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-zSHFg2B4NPKQih-UuYtepQ-1; Sat, 08 Oct 2022 00:48:44 -0400
X-MC-Unique: zSHFg2B4NPKQih-UuYtepQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 il7-20020a17090b164700b0020d1029ceaaso7268pjb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Oct 2022 21:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UR03F1LH3w2DyC2bKoegajgsRdph1ICRu5SgxFtX7YI=;
 b=4GKm6Va6yyaNmuMSGFHe7Y0IA/BTOk/tRuUC7e5MN67im2dAxmqcDEwHhDoS0Vnugg
 g3Cu57uvhL6j+ph6c9PxE7cSBQ/jxxeKODwPsuEGD/Xpdu8BXZu2uG79xl03wgtOdzXr
 8THV//3w5MckLTP8e1NE3+bbeAMBzV6hWgJSyfEpzn+iKmVOuojpRCYxAgGcBr8GBbCW
 KCyIOtYWnZhuiQ7IIhNLUgBw9BwXtO6sUxQa1K5qAPjM9KDL95WzhEU6E40E2dNA3L92
 z3izGq1FOxEaPnzBHCL7VE0HjVsCmNBgQmhhVRMztG1hMjvl9xx/E3VhVTT8KsWzRGHh
 ODNw==
X-Gm-Message-State: ACrzQf0Jb63HcTUBXLmJitCmEV0kSi9sx9PCDiwlKzwSnQAyY/Yve091
 W89DoNamHlGuIRsAskI2hrdlTiaga7RBts0HGWaNLq+wK9qjmrNpEnQ72ReXdqeBV6aNIRsf0xL
 /pHbyXF0JEu7fW/5aY1YjOvsBNyder2V6eIqU7tmDDw==
X-Received: by 2002:a17:90b:4c0f:b0:20b:38e3:d4b9 with SMTP id
 na15-20020a17090b4c0f00b0020b38e3d4b9mr8220974pjb.184.1665204522903; 
 Fri, 07 Oct 2022 21:48:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4spmRPm5JD4myiQkhrkXzQ67tV4/FNmr7AbiwNi5rgm7ZASK1+z382kJG8JBa4bTovRw8fTQ==
X-Received: by 2002:a17:90b:4c0f:b0:20b:38e3:d4b9 with SMTP id
 na15-20020a17090b4c0f00b0020b38e3d4b9mr8220959pjb.184.1665204522615; 
 Fri, 07 Oct 2022 21:48:42 -0700 (PDT)
Received: from [10.72.13.133] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b00177f82f0789sm2371481plg.198.2022.10.07.21.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Oct 2022 21:48:42 -0700 (PDT)
Message-ID: <d02fd1b7-db37-5394-52ee-94ce3f56a120@redhat.com>
Date: Sat, 8 Oct 2022 12:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
 <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
 <20220928091512-mutt-send-email-mst@kernel.org>
 <CAJs=3_CmKjhS=Y3JHujws9y5KmN-AbSRXTnt1aZOhDzMuK7g3Q@mail.gmail.com>
 <20220929032021-mutt-send-email-mst@kernel.org>
 <CAJs=3_AgfyZkWhwK3pycSs49=k-q+9mpD3pyjG0us+ke60RqmQ@mail.gmail.com>
 <20220929033858-mutt-send-email-mst@kernel.org>
 <CAJs=3_AD_KLZHwo1gxejYRUJ6ucdCxv=3RnpOQXs+KiBEV=K5A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJs=3_AD_KLZHwo1gxejYRUJ6ucdCxv=3RnpOQXs+KiBEV=K5A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzkvMjkgMTY6NTEsIEFsdmFybyBLYXJzeiDlhpnpgZM6Cj4+IEhvd2V2ZXIsIHRo
aXMgbWVhbnMgdGhhdCBldmVuIGlmIGhvc3QgZXhwb3NlcyBWSVJUSU9fQkxLX0ZfU0VDVVJFX0VS
QVNFCj4+IHRoZSBob3N0IGNhbiBub3QgYmUgc3VyZSBndWVzdCB3aWxsIHVzZSBzZWN1cmUgZXJh
c2UuCj4+IElzIHRoaXMgb3IgY2FuIGJlIGEgc2VjdXJpdHkgcHJvYmxlbT8KPj4gSWYgeWVzIGxl
dCdzIGJlIHN0cmljdCBhbmQgZmFpbCBwcm9iZSBhcyBjdXJyZW50IGNvZGUgZG9lcy4KPj4gSWYg
bm90IGxldCdzIGJlIGZsZXhpYmxlIGFuZCBlbnN1cmUgZm9yd2FyZCBjb21wYXRpYmlsaXR5Lgo+
Cj4gSSBjYW4ndCB0aGluayBvZiBhbnkgc2VjdXJpdHkgcHJvYmxlbXMuCgoKWWVzLiBBbmQgZXZl
biBpZiB0aGUgZGV2aWNlIHRyeSB0byBtYW5kYXRlIFZJUlRJT19CTEtfRl9TRUNVUkVfRVJBU0Us
IAp0aGVyZSdzIG5vIGd1YXJhbnRlZSB0aGF0IGl0IGhhcyBiZWVuIGltcGxlbWVudGVkIGFzIHdo
YXQgZ3Vlc3Qgd2FudC4KCkd1ZXN0IG1pZ2h0IG5lZWQgdG8gZG8gZW5jcnlwdGlvbiBmb3IgZXh0
cmEgYXNzdXJhbmNlLgoKVGhhbmtzCgoKPiBTdGVmYW4sIHdoYXQgZG8geW91IHRoaW5rPwo+IEFy
ZSB5b3Ugb2sgd2l0aCBjbGVhcmluZyB0aGUgZmVhdHVyZT8KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
