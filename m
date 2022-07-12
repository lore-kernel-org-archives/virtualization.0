Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E9EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 08:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F35586108C;
	Tue, 12 Jul 2022 08:34:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F35586108C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a8WGqyUr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0tQdGFIPiW9; Tue, 12 Jul 2022 08:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7DF5260B29;
	Tue, 12 Jul 2022 08:34:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DF5260B29
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E8CEC0033;
	Tue, 12 Jul 2022 08:34:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 857E0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F2DC8408C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:34:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F2DC8408C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a8WGqyUr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 46pa5QHx76LF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:34:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DB6184084
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DB6184084
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657614860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ciMX/RuHI1AVXWq2Q5hVAjhC6awxZbzM0WmTsHePMI=;
 b=a8WGqyUrUQGnd3PhkaS83mEtCvmeDW1GaTrW7RzIrC4AdFlTs9c+y1U0jIAW+YlbXzMWxi
 7dY/dlP1qrSAKaMdjzmDZhE9iXpzAOOhMuN17zvwcu7izHmdotTZ4zNigo/Yqyg4Vgygiv
 GugA4luEVmpuV7SGPCg4L9YTL8F6fOo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-VAar0-BkNzCSizu7DnARKQ-1; Tue, 12 Jul 2022 04:34:18 -0400
X-MC-Unique: VAar0-BkNzCSizu7DnARKQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d10-20020a170902ceca00b0016bea2dc145so5248874plg.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 01:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=4ciMX/RuHI1AVXWq2Q5hVAjhC6awxZbzM0WmTsHePMI=;
 b=Yiw9GkZkL4mGxeWJohIoLakMz87biYWxzUX9IGLClQWEXOdnodsW6YuzQH4pDrkHeL
 D872PWBhu//P/rqcSAKWCsyF30riW7QFT+qA7Awfzhcdrdd2MPvrPPWeA6Qv5XWJPcRM
 1Y2sPb9BYPjixkXHA0TGQI2aE31dMHtrNZzksyvISeuHiJt++JVtmV4jUOlHIxlH/jlH
 ApPR+JISWoZCsG+f2kqRuGSBMLVUxOTmom3RTSQMFeyjT4fGdWtT9XDsyID01w+dELcz
 +4kJKEGMNArwmCqUeTZr1a59IBkktknH6f8EFmRJnQ8a7XA4aNPvZPSovpBXHp5o3BrT
 6WKg==
X-Gm-Message-State: AJIora8AhRYUeeLl+dpHQRhHu82BLTsvRi59mvrr9uGHNkSa/SjYqolD
 hNpNx1aY5M7SOY2gs2ezs6zYgatxX7Dvw8x5a4ZkGYmFk8E4lg/SFsBKoigX2pPrzKcb9o6qACM
 JzUqiJIK90E9A+inrabt4bD7614XoxDr+o2RvtT6zAA==
X-Received: by 2002:a63:5a44:0:b0:412:7bee:d757 with SMTP id
 k4-20020a635a44000000b004127beed757mr20003581pgm.419.1657614857272; 
 Tue, 12 Jul 2022 01:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYVO3vSLUIZSmWIXfePtiHngDbFb1xsmaDaTzi6lizNFpTYFpmBmlun2e6WoeX3mI/D12AUg==
X-Received: by 2002:a63:5a44:0:b0:412:7bee:d757 with SMTP id
 k4-20020a635a44000000b004127beed757mr20003566pgm.419.1657614857037; 
 Tue, 12 Jul 2022 01:34:17 -0700 (PDT)
Received: from [10.72.12.111] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 iw11-20020a170903044b00b0016a0bf0ce32sm6145115plb.70.2022.07.12.01.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 01:34:16 -0700 (PDT)
Message-ID: <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
Date: Tue, 12 Jul 2022 16:34:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20220704171701.127665-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzcvNSAwMToxNiwgU3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPiBUaGUgZmly
c3QgMyBwYXRjaGVzIGZpeCB2YXJpb3VzIHByb2JsZW1zIEkgaGF2ZSBlbmNvdW50ZXJlZCB3aXRo
Cj4gdmlydGlvX3Rlc3QgKHRoZXkgbWF5IGdvIHdpdGhvdXQgdGhpcyBzZXJpZXMsIGJ1dCBJIGlu
Y2x1ZGVkIHRvIGFsbG93IHlvdQo+IHRvIHRlc3QgdGhlIHNlcmllcykuCj4KPiBQYXRjaCA0IGlz
IGluIHByZXBhcmF0aW9uIG9mIHBhdGNoIDUsIG1vdmluZyB0aGUgZmVhdHVyZSBuZWdvdGlhdGlv
biB3aGVuCj4gd2UgaW5pdGlhbGl6ZSB0aGUgZGV2aWNlLgo+Cj4gUGF0Y2ggNSBhZGQgdGhlIHN1
cHBvcnQgb2Ygdmhvc3QtdmRwYSBpbiB2aXJ0aW9fdGVzdAo+Cj4gUGF0Y2ggNiBhZGQgdmRwYV90
ZXN0LmtvIGJhc2VkIG9uIHZkcGFfc2ltX3Rlc3QuYywgc28gd2UgY2FuIHJldXNlIG1vc3Qgb2YK
PiB0aGUgY29kZSBjb21pbmcgZnJvbSB0aGUgdmRwYV9zaW0gZnJhbWV3b3JrLgo+Cj4gSSB0ZXN0
ZWQgaW4gdGhpcyB3YXk6Cj4KPiAgICAkIG1vZHByb2JlIHZkcGFfc2ltCj4gICAgJCBtb2Rwcm9i
ZSB2aG9zdC12ZHBhCj4KPiAgICAjIGxvYWQgdGhlIHZkcGFzaW1fdGVzdCBkZXZpY2UKPiAgICAk
IGluc21vZCB2ZHBhX3Rlc3Qua28KPgo+ICAgICMgY3JlYXRlIGEgbmV3IHZkcGFzaW1fdGVzdCBk
ZXZpY2UKPiAgICAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHZkcGFzaW1fdGVzdCBuYW1lIGRldjAK
CgpJIHdvbmRlciB3aGF0J3MgdGhlIGJlbmVmaXQgb2YgdXNpbmcgYSBkZWRpY2F0ZWQgdGVzdCBk
ZXZpY2Ugb3RoZXIgdGhhbiAKbmV0d29ya2luZz8gKGFscmVhZHkgYSBsb29wYmFjayBkZXZpY2Ug
YW55aG93KS4KClRoYW5rcwoKCj4KPiAgICAjIHJ1biB0aGUgdGVzdCB1c2luZyB0aGUgL2Rldi92
aG9zdC12ZHBhLTAgZGV2aWNlCj4gICAgJCAuL3ZpcnRpb190ZXN0IC0tdmRwYSAvZGV2L3Zob3N0
LXZkcGEtMAo+ICAgIHNwdXJpb3VzIHdha2V1cHM6IDB4MCBzdGFydGVkPTB4MTAwMDAwIGNvbXBs
ZXRlZD0weDEwMDAwMAo+Cj4gQ29tbWVudHMgYW5kIHN1Z2dlc3Rpb25zIGFyZSB3ZWxjb21lIDot
KQo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgo+IFN0ZWZhbm8gR2FyemFyZWxsYSAoNik6Cj4gICAg
dG9vbHMvdmlydGlvOiBmaXggYnVpbGQKPiAgICB2aG9zdF90ZXN0OiBhZGQgJChzcmN0cmVlKSBv
biB0aGUgaW5jbHVkZWQgcGF0aAo+ICAgIHZpcnRpb190ZXN0OiBjYWxsIF9fdmlydGlvX3VuYnJl
YWtfZGV2aWNlCj4gICAgdG9vbHMvdmlydGlvOiBtb3ZlIGZlYXR1cmUgbmVnb3RpYXRpb24gaW4g
dmRldl9pbmZvX2luaXQoKQo+ICAgIHZpcnRpb190ZXN0OiBzdXBwb3J0IHZob3N0LXZkcGEgZGV2
aWNlCj4gICAgdmRwYXNpbTogYWRkIHZkcGFfc2ltX3Rlc3QgbW9kdWxlCj4KPiAgIHRvb2xzL3Zp
cnRpby9saW51eC9rZXJuZWwuaCAgICAgICAgICAgfCAgIDIgKy0KPiAgIHRvb2xzL3ZpcnRpby9s
aW51eC92aXJ0aW8uaCAgICAgICAgICAgfCAgIDIgKwo+ICAgdG9vbHMvdmlydGlvL2xpbnV4L3Zy
aW5naC5oICAgICAgICAgICB8ICAgMSArCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW1fdGVzdC5jIHwgMjAzICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICB0b29scy92aXJ0
aW8vdmRwYV90ZXN0L3ZkcGFfdGVzdC5jICAgIHwgICAxICsKPiAgIHRvb2xzL3ZpcnRpby92aXJ0
aW9fdGVzdC5jICAgICAgICAgICAgfCAxMzEgKysrKysrKysrKysrKystLS0KPiAgIHRvb2xzL3Zp
cnRpby9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgMzIgKysrLQo+ICAgdG9vbHMvdmlydGlv
L3ZkcGFfdGVzdC9NYWtlZmlsZSAgICAgICB8ICAgMyArCj4gICB0b29scy92aXJ0aW8vdmhvc3Rf
dGVzdC9NYWtlZmlsZSAgICAgIHwgICAyICstCj4gICA5IGZpbGVzIGNoYW5nZWQsIDM1MCBpbnNl
cnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fdGVzdC5jCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9v
bHMvdmlydGlvL3ZkcGFfdGVzdC92ZHBhX3Rlc3QuYwo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRv
b2xzL3ZpcnRpby92ZHBhX3Rlc3QvTWFrZWZpbGUKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
