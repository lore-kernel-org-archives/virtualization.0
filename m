Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59460C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 03:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA33B40463;
	Mon,  8 May 2023 03:12:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA33B40463
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dqAL4kMt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0iff2-nNx5Bw; Mon,  8 May 2023 03:12:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76425400AB;
	Mon,  8 May 2023 03:12:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76425400AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5799AC0037;
	Mon,  8 May 2023 03:12:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E93D4C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0DD440462
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:12:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0DD440462
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WRJIxsuhJKfP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:12:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26932400AB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26932400AB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683515533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nyAgUbuTjzD6fHJpqxIZiFQeyCjpbJk624bFTFNpfo=;
 b=dqAL4kMtn1iPVye9ftLbseCCSTCjkzdJSEHmWjTl6S72iWjsgp3N2vv26LhkwWXAXioEUH
 X3C+siAfl1JAm+J/w9JsmL1jK4uveIo2/adgi4TCAwvzim522IUnzI/CAgheEgGZ+t+WZ/
 Us0YeHduY8an97DUjCrI7KEkmp8BqkY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-7A6Lg9dFN962rDJi30IxQA-1; Sun, 07 May 2023 23:12:12 -0400
X-MC-Unique: 7A6Lg9dFN962rDJi30IxQA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1ac6193a1e3so7979885ad.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 20:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683515531; x=1686107531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9nyAgUbuTjzD6fHJpqxIZiFQeyCjpbJk624bFTFNpfo=;
 b=Ia4mNMlk8QI+DLIKigFV8AqdhlX9rIwSmmqFOecJbXRuOc/2ywDKumBEavaO6YnO0w
 mVEGh8TU1+xHpF0P8unhJ4vQrPa/j95FMGaewVfYFcECmxBezV09YdAUwNCLTDDTicmA
 DcHnC6YjJs2Iaxb8ESSo9xirp1L/F8tSkwhU6ONAMRBUx1h7HtDsNc8AZsJTEenXBfqt
 00BqSaZqlB0R5aUQ3l1wZd2pVxOpyl0UsaSOSXZCj8hyV0uUmAb+qLvu9LrXb6/5A9ih
 RCwGNAk9J8RgI23RXGK9uyU06DIrg7mbon/yUQ5bmLbmBE3xnWVAPIFQ4E/Fbg8tFUNG
 vJTA==
X-Gm-Message-State: AC+VfDz+gqbgZqLnsRH8PZ7FYPLZwCF2s876Obfx1Z386lIIth4lhiGY
 sA/vV8zfEmrltgJILH4yS4L3OW4PbTjAazkLKcYZtSDuTfYl5VHByqAxFfu02rSFPNTkNoJa/1Y
 NlOJIKrOX0bb2UlsqZf/PPYRDPqSJu5tpa63eFiF7pw==
X-Received: by 2002:a17:902:a516:b0:1ab:1355:1a45 with SMTP id
 s22-20020a170902a51600b001ab13551a45mr8724908plq.30.1683515530942; 
 Sun, 07 May 2023 20:12:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Dsr/5I/1xDjPCTgBELpkfYOze5JmdS9lW2LqmCICvddW3VQUgjgtMk5CSsiE4sTTKAkq0Yg==
X-Received: by 2002:a17:902:a516:b0:1ab:1355:1a45 with SMTP id
 s22-20020a170902a51600b001ab13551a45mr8724890plq.30.1683515530640; 
 Sun, 07 May 2023 20:12:10 -0700 (PDT)
Received: from [10.72.12.58] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a170902d4c400b00199193e5ea1sm5857923plg.61.2023.05.07.20.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 May 2023 20:12:10 -0700 (PDT)
Message-ID: <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
Date: Mon, 8 May 2023 11:12:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230507093328-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
 Wenliang Wang <wangwenliang.1995@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

CuWcqCAyMDIzLzUvNyAyMTozNCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBPbiBGcmks
IE1heSAwNSwgMjAyMyBhdCAxMToyODoyNUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBP
biBUaHUsIE1heSA0LCAyMDIzIGF0IDEwOjI34oCvQU0gV2VubGlhbmcgV2FuZwo+PiA8d2FuZ3dl
bmxpYW5nLjE5OTVAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4+PiBGb3IgbXVsdGktcXVldWUgYW5k
IGxhcmdlIHJpbmctc2l6ZSB1c2UgY2FzZSwgdGhlIGZvbGxvd2luZyBlcnJvcgo+Pj4gb2NjdXJy
ZWQgd2hlbiBmcmVlX3VudXNlZF9idWZzOgo+Pj4gcmN1OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1k
ZXRlY3RlZCBzdGFsbCBvbiBDUFUuCj4+Pgo+Pj4gRml4ZXM6IDk4NmE0ZjRkNDUyZCAoInZpcnRp
b19uZXQ6IG11bHRpcXVldWUgc3VwcG9ydCIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBXZW5saWFuZyBX
YW5nIDx3YW5nd2VubGlhbmcuMTk5NUBieXRlZGFuY2UuY29tPgo+Pj4gLS0tCj4+PiB2MjoKPj4+
IC1hZGQgbmVlZF9yZXNjaGVkIGNoZWNrLgo+Pj4gLWFwcGx5IHNhbWUgbG9naWMgdG8gc3EuCj4+
PiB2MzoKPj4+IC11c2UgY29uZF9yZXNjaGVkIGluc3RlYWQuCj4+PiB2NDoKPj4+IC1hZGQgZml4
ZXMgdGFnCj4+PiAtLS0KPj4+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArKwo+Pj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4gaW5k
ZXggOGQ4MDM4NTM4ZmM0Li5hMTJhZTI2ZGIwZTIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4gQEAg
LTM1NjAsMTIgKzM1NjAsMTQgQEAgc3RhdGljIHZvaWQgZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSkKPj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAq
dnEgPSB2aS0+c3FbaV0udnE7Cj4+PiAgICAgICAgICAgICAgICAgIHdoaWxlICgoYnVmID0gdmly
dHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKHZxKSkgIT0gTlVMTCkKPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1Zih2cSwgYnVmKTsKPj4+ICsgICAg
ICAgICAgICAgICBjb25kX3Jlc2NoZWQoKTsKPj4gRG9lcyB0aGlzIHJlYWxseSBhZGRyZXNzIHRo
ZSBjYXNlIHdoZW4gdGhlIHZpcnRxdWV1ZSBpcyB2ZXJ5IGxhcmdlPwo+Pgo+PiBUaGFua3MKPgo+
IGl0IGRvZXMgaW4gdGhhdCBhIHZlcnkgbGFyZ2UgcXVldWUgaXMgc3RpbGwganVzdCA2NGsgaW4g
c2l6ZS4KPiB3ZSBtaWdodCBob3dldmVyIGhhdmUgNjRrIG9mIHRoZXNlIHF1ZXVlcy4KCgpPaywg
YnV0IHdlIGhhdmUgb3RoZXIgc2ltaWxhciBsb29wcyBlc3BlY2lhbGx5IHRoZSByZWZpbGwsIEkg
dGhpbmsgd2UgCm1heSBuZWVkIGNvbmRfcmVzY2hlZCgpIHRoZXJlIGFzIHdlbGwuCgpUaGFua3MK
Cgo+Cj4+PiAgICAgICAgICB9Cj4+Pgo+Pj4gICAgICAgICAgZm9yIChpID0gMDsgaSA8IHZpLT5t
YXhfcXVldWVfcGFpcnM7IGkrKykgewo+Pj4gICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1
ZXVlICp2cSA9IHZpLT5ycVtpXS52cTsKPj4+ICAgICAgICAgICAgICAgICAgd2hpbGUgKChidWYg
PSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxMKQo+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHZxLCBidWYpOwo+Pj4g
KyAgICAgICAgICAgICAgIGNvbmRfcmVzY2hlZCgpOwo+Pj4gICAgICAgICAgfQo+Pj4gICB9Cj4+
Pgo+Pj4gLS0KPj4+IDIuMjAuMQo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
