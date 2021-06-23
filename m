Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11476C48BE5
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 03:31:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA90C611CE
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 03:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA90C611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CE5240605;
	Wed, 23 Jun 2021 03:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAVzoDz3_7vG; Wed, 23 Jun 2021 03:31:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08B4840602;
	Wed, 23 Jun 2021 03:31:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF5B3C0010;
	Wed, 23 Jun 2021 03:31:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC5BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1EFE83C2E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k1hT-gccGZv0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:31:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44DB783C33
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 03:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624419070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZSgP5xqL55dngZG3CanjqGD23m6Wc1RN7v32XWp3kc=;
 b=B5mMVEc2OIy/YOZK96mY3jR7ZgTL8ZS+998K9dAY/3Db3Ke7kq4ozreHp4NpPIL2lr4Hi6
 AgWIvJ1Y0YoXhVjAqPjVxPLPrknxxu3F+z3GbuK2ruaLf6ER9eVF8ra67grLvpElgjr2av
 DKD4/NDr1xKUrI+SnOllGn6jTyW6L0c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-XZmzwY40OQqev5SgSwpnSg-1; Tue, 22 Jun 2021 23:31:06 -0400
X-MC-Unique: XZmzwY40OQqev5SgSwpnSg-1
Received: by mail-pl1-f198.google.com with SMTP id
 x15-20020a170902e04fb02900f5295925dbso319899plx.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 20:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VZSgP5xqL55dngZG3CanjqGD23m6Wc1RN7v32XWp3kc=;
 b=hCawg7AcU4NwLZYULN33HOOSbJtaBzn0OUc8hotUoguyboVtiQzCbRplACeZ3vftai
 2QSP80FHNC5dl8YAav6yiWxPwYX9VIRONQq1GOy6rG1Gd0TRTDgJ5wMkpTPdP5Vh6H2H
 2uzD2la8yNWy7/DDFqczytndPwhKlfQ2zGG0JkgH3rc9HstwrGBWN206z5ASs+lT2bDe
 IZmIEWUx/PNvdlRR9W8Fdo4h9nRJ1tSjbz9vPjt4xeClWAo60EJgh7Zg1IVdgx/Tw3js
 0XsotnIMXXDjh57/CmzVK3EY3sucH2cL0b4dsf0lfrnh5bq+CcK0jsn1wmNtS6hLURh9
 s3Ow==
X-Gm-Message-State: AOAM532xF2e+VJ/DYh/acwJ2dF82Tmxwl+o1Ab0XNIU5olhzBd6q/6DQ
 vw7qHSJgfVmIprI1SfRLygH3v0doVURwyQRBHv6DAMs4MrKiZxugXZYrbey1Yd2Ij2QPuOhcwUv
 ZaX0ircvqQCM7HxOANM9IsOVnmXxhDA3+WuPN3acI+Q==
X-Received: by 2002:a17:90b:a4d:: with SMTP id
 gw13mr7324898pjb.104.1624419065660; 
 Tue, 22 Jun 2021 20:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQhXaoy3jxuNbqcv+CnTgPw9skCZRgRJ2b9PqWzTzCghH3uazW1CaiGjP6RnFZCrYeeAvhUQ==
X-Received: by 2002:a17:90b:a4d:: with SMTP id
 gw13mr7324867pjb.104.1624419065413; 
 Tue, 22 Jun 2021 20:31:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g4sm658859pfu.134.2021.06.22.20.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 20:31:04 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
Date: Wed, 23 Jun 2021 11:30:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzYvMjIg5LiL5Y2INDoxNCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVHVlLCBK
dW4gMjIsIDIwMjEgYXQgMzo1MCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNi8yMiDkuIvljYgzOjIyLCBZb25namkgWGllIOWGmemBkzoK
Pj4+PiBXZSBuZWVkIGZpeCBhIHdheSB0byBwcm9wYWdhdGUgdGhlIGVycm9yIHRvIHRoZSB1c2Vy
c3BhY2UuCj4+Pj4KPj4+PiBFLmcgaWYgd2Ugd2FudCB0byBzdG9wIHRoZSBkZWl2Y2UsIHdlIHdp
bGwgZGVsYXkgdGhlIHN0YXR1cyByZXNldCB1bnRpbAo+Pj4+IHdlIGdldCByZXNwb3NlIGZyb20g
dGhlIHVzZXJzcGFjZT8KPj4+Pgo+Pj4gSSBkaWRuJ3QgZ2V0IGhvdyB0byBkZWxheSB0aGUgc3Rh
dHVzIHJlc2V0LiBBbmQgc2hvdWxkIGl0IGJlIGEgRG9TCj4+PiB0aGF0IHdlIHdhbnQgdG8gZml4
IGlmIHRoZSB1c2Vyc3BhY2UgZG9lc24ndCBnaXZlIGEgcmVzcG9uc2UgZm9yZXZlcj8KPj4KPj4g
WW91J3JlIHJpZ2h0LiBTbyBsZXQncyBtYWtlIHNldF9zdGF0dXMoKSBjYW4gZmFpbCBmaXJzdCwg
dGhlbiBwcm9wYWdhdGUKPj4gaXRzIGZhaWx1cmUgdmlhIFZIT1NUX1ZEUEFfU0VUX1NUQVRVUy4K
Pj4KPiBPSy4gU28gd2Ugb25seSBuZWVkIHRvIHByb3BhZ2F0ZSB0aGUgZmFpbHVyZSBpbiB0aGUg
dmhvc3QtdmRwYSBjYXNlLCByaWdodD8KCgpJIHRoaW5rIG5vdCwgd2UgbmVlZCB0byBkZWFsIHdp
dGggdGhlIHJlc2V0IGZvciB2aXJ0aW8gYXMgd2VsbDoKCkUuZyBpbiByZWdpc3Rlcl92aXJ0aW9f
ZGV2aWNlcygpLCB3ZSBoYXZlOgoKIMKgwqDCoMKgwqDCoMKgIC8qIFdlIGFsd2F5cyBzdGFydCBi
eSByZXNldHRpbmcgdGhlIGRldmljZSwgaW4gY2FzZSBhIHByZXZpb3VzCiDCoMKgwqDCoMKgwqDC
oMKgICogZHJpdmVyIG1lc3NlZCBpdCB1cC7CoCBUaGlzIGFsc28gdGVzdHMgdGhhdCBjb2RlIHBh
dGggYSAKbGl0dGxlLiAqLwogwqDCoMKgwqDCoCBkZXYtPmNvbmZpZy0+cmVzZXQoZGV2KTsKCldl
IHByb2JhYmx5IG5lZWQgdG8gbWFrZSByZXNldCBjYW4gZmFpbCBhbmQgdGhlbiBmYWlsIHRoZSAK
cmVnaXN0ZXJfdmlydGlvX2RldmljZSgpIGFzIHdlbGwuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+
IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
