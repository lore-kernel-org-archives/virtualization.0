Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C845C49EAF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 03:35:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25026613B9
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 03:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25026613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FB8E83C07;
	Thu, 24 Jun 2021 03:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRRIVSzWcQBW; Thu, 24 Jun 2021 03:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34D1583C11;
	Thu, 24 Jun 2021 03:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9990C000E;
	Thu, 24 Jun 2021 03:35:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A15C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06F27405E2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GZlCwbPQ_T3d
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:35:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC40A405DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624505701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QohIO9QZ56POeZsL8ywMd6mageIeyr6m/mT20FPwPo=;
 b=IvnMUpI8ARjUQ2px4raVHAzkZtw8Xe8nNM9kftL3XfBjKTJcrecktPUp7p9IcpR5MXDNGR
 DE5AgIzEme5gS3gO8raxa67tqctDueaqX9ZfAub2jdg0bSe8pbw5yfGlIiIvz+ic3rtRao
 E5g34nLDd19n6b7XaBsRfiqUYH2+tX8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-Ilapg5FkMpm4_IvH0twYbA-1; Wed, 23 Jun 2021 23:34:59 -0400
X-MC-Unique: Ilapg5FkMpm4_IvH0twYbA-1
Received: by mail-pg1-f199.google.com with SMTP id
 w38-20020a6347660000b029022342ce1f8bso2895814pgk.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 20:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5QohIO9QZ56POeZsL8ywMd6mageIeyr6m/mT20FPwPo=;
 b=S/7OqUaIXYqK18JTopn3VG+piklrNEpkdfME7AOpcf+nyUpHAsjx+9dqrBTeDKVlt9
 X7z3EMXaj9P2ftniHWjWzwqs4DaLxoA5IM9G0LyNM68gQe7hCQ2Ccoa+ZfjrWsDNkG6O
 /SjfOe/DPjqPEP5pYozjy3wRi1KDmCCCxGZo1uU0P+5jI7uc0y8sx/kdzXa4tD4Aq1s0
 Fhqsyt4v1gmuficKjBqo9kj+ayUgVzVM/XHdQUAGYB+teiw+qVEdXfqLoLLK5Fv4y3L3
 /7sZPoF0c6ES0WS34TPR1AuMHQiJ8UzmjYSTzxEdXBw//KfWRO3lrklWam/kNw6oa8kt
 zvzg==
X-Gm-Message-State: AOAM533bQLoganCfeAxtKOKxBUyraRSH9Xx6I96r3W2PS3iksu4tnks0
 kkqyIiRiyfFeGuvMLAA9uQbne+aDp8gzMui1vmwLMDHtNGGAhF4hg0fDIj9uljdM4yMYADtpWv7
 KK5oqK+e1+r7SKiFwMUoAcHuLSdJfVVlm16LnTULq3Q==
X-Received: by 2002:a17:90b:1191:: with SMTP id
 gk17mr2989118pjb.95.1624505698677; 
 Wed, 23 Jun 2021 20:34:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoEDvRxknwye7AvfyEaKP6cKcvSDe8Ou4kXVMU8NQ9OSeQD22thwiDze8XxBwVGv+OJzWxjg==
X-Received: by 2002:a17:90b:1191:: with SMTP id
 gk17mr2989081pjb.95.1624505698416; 
 Wed, 23 Jun 2021 20:34:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a15sm1101133pff.128.2021.06.23.20.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 20:34:57 -0700 (PDT)
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
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
Date: Thu, 24 Jun 2021 11:34:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
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

CuWcqCAyMDIxLzYvMjMg5LiL5Y2IMTo1MCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gV2VkLCBK
dW4gMjMsIDIwMjEgYXQgMTE6MzEgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzYvMjIg5LiL5Y2INDoxNCwgWW9uZ2ppIFhpZSDlhpnpgZM6
Cj4+PiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAzOjUwIFBNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IOWcqCAyMDIxLzYvMjIg5LiL5Y2IMzoyMiwgWW9uZ2pp
IFhpZSDlhpnpgZM6Cj4+Pj4+PiBXZSBuZWVkIGZpeCBhIHdheSB0byBwcm9wYWdhdGUgdGhlIGVy
cm9yIHRvIHRoZSB1c2Vyc3BhY2UuCj4+Pj4+Pgo+Pj4+Pj4gRS5nIGlmIHdlIHdhbnQgdG8gc3Rv
cCB0aGUgZGVpdmNlLCB3ZSB3aWxsIGRlbGF5IHRoZSBzdGF0dXMgcmVzZXQgdW50aWwKPj4+Pj4+
IHdlIGdldCByZXNwb3NlIGZyb20gdGhlIHVzZXJzcGFjZT8KPj4+Pj4+Cj4+Pj4+IEkgZGlkbid0
IGdldCBob3cgdG8gZGVsYXkgdGhlIHN0YXR1cyByZXNldC4gQW5kIHNob3VsZCBpdCBiZSBhIERv
Uwo+Pj4+PiB0aGF0IHdlIHdhbnQgdG8gZml4IGlmIHRoZSB1c2Vyc3BhY2UgZG9lc24ndCBnaXZl
IGEgcmVzcG9uc2UgZm9yZXZlcj8KPj4+PiBZb3UncmUgcmlnaHQuIFNvIGxldCdzIG1ha2Ugc2V0
X3N0YXR1cygpIGNhbiBmYWlsIGZpcnN0LCB0aGVuIHByb3BhZ2F0ZQo+Pj4+IGl0cyBmYWlsdXJl
IHZpYSBWSE9TVF9WRFBBX1NFVF9TVEFUVVMuCj4+Pj4KPj4+IE9LLiBTbyB3ZSBvbmx5IG5lZWQg
dG8gcHJvcGFnYXRlIHRoZSBmYWlsdXJlIGluIHRoZSB2aG9zdC12ZHBhIGNhc2UsIHJpZ2h0Pwo+
Pgo+PiBJIHRoaW5rIG5vdCwgd2UgbmVlZCB0byBkZWFsIHdpdGggdGhlIHJlc2V0IGZvciB2aXJ0
aW8gYXMgd2VsbDoKPj4KPj4gRS5nIGluIHJlZ2lzdGVyX3ZpcnRpb19kZXZpY2VzKCksIHdlIGhh
dmU6Cj4+Cj4+ICAgICAgICAgICAvKiBXZSBhbHdheXMgc3RhcnQgYnkgcmVzZXR0aW5nIHRoZSBk
ZXZpY2UsIGluIGNhc2UgYSBwcmV2aW91cwo+PiAgICAgICAgICAgICogZHJpdmVyIG1lc3NlZCBp
dCB1cC4gIFRoaXMgYWxzbyB0ZXN0cyB0aGF0IGNvZGUgcGF0aCBhCj4+IGxpdHRsZS4gKi8KPj4g
ICAgICAgICBkZXYtPmNvbmZpZy0+cmVzZXQoZGV2KTsKPj4KPj4gV2UgcHJvYmFibHkgbmVlZCB0
byBtYWtlIHJlc2V0IGNhbiBmYWlsIGFuZCB0aGVuIGZhaWwgdGhlCj4+IHJlZ2lzdGVyX3ZpcnRp
b19kZXZpY2UoKSBhcyB3ZWxsLgo+Pgo+IE9LLCBsb29rcyBsaWtlIHZpcnRpb19hZGRfc3RhdHVz
KCkgYW5kIHZpcnRpb19kZXZpY2VfcmVhZHkoKVsxXSBzaG91bGQKPiBiZSBhbHNvIG1vZGlmaWVk
IGlmIHdlIG5lZWQgdG8gcHJvcGFnYXRlIHRoZSBmYWlsdXJlIGluIHRoZQo+IHZpcnRpby12ZHBh
IGNhc2UuIE9yIGRvIHdlIG9ubHkgbmVlZCB0byBjYXJlIGFib3V0IHRoZSByZXNldCBjYXNlPwo+
Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTA1MTcwOTM0MjguNjcwLTEt
eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20vCgoKTXkgdW5kZXJzdGFuZGluZyBpcyBEUklWRVJfT0sg
aXMgbm90IHNvbWV0aGluZyB0aGF0IG5lZWRzIHRvIGJlIHZhbGlkYXRlZDoKCiIKCkRSSVZFUl9P
SyAoNCkKSW5kaWNhdGVzIHRoYXQgdGhlIGRyaXZlciBpcyBzZXQgdXAgYW5kIHJlYWR5IHRvIGRy
aXZlIHRoZSBkZXZpY2UuCgoiCgpTaW5jZSB0aGUgc3BlYyBkb2Vzbid0IHJlcXVpcmUgdG8gcmUt
cmVhZCB0aGUgYW5kIGNoZWNrIGlmIERSSVZFUl9PSyBpcyAKc2V0IGluIDMuMS4xIERyaXZlciBS
ZXF1aXJlbWVudHM6IERldmljZSBJbml0aWFsaXphdGlvbi4KCkl0J3MgbW9yZSBhYm91dCAidGVs
bGluZyB0aGUgZGV2aWNlIHRoYXQgZHJpdmVyIGlzIHJlYWR5LiIKCkJ1dCB3ZSBkb24gaGF2ZSBz
b21lIHN0YXR1cyBiaXQgdGhhdCByZXF1aXJlcyB0aGUgc3luY2hyb25pemF0aW9uIHdpdGggCnRo
ZSBkZXZpY2UuCgoxKSBGRUFUVVJFU19PSywgc3BlYyByZXF1aXJlcyB0byByZS1yZWFkIHRoZSBz
dGF0dXMgYml0IHRvIGNoZWNrIHdoZXRoZXIgCm9yIGl0IGl0IHdhcyBzZXQgYnkgdGhlIGRldmlj
ZToKCiIKClJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJp
dCBpcyBzdGlsbCBzZXQ6IApvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCBv
dXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgCmRldmljZSBpcyB1bnVzYWJsZS4KCiIKClRo
aXMgaXMgdXNlZnVsIGZvciBzb21lIGRldmljZSB3aGljaCBjYW4gb25seSBzdXBwb3J0IGEgc3Vi
c2V0IG9mIHRoZSAKZmVhdHVyZXMuIEUuZyBhIGRldmljZSB0aGF0IGNhbiBvbmx5IHdvcmsgZm9y
IHBhY2tlZCB2aXJ0cXVldWUuIFRoaXMgCm1lYW5zIHRoZSBjdXJyZW50IGRlc2lnbiBvZiBzZXRf
ZmVhdHVyZXMgd29uJ3Qgd29yaywgd2UgbmVlZCBlaXRoZXI6CgoxYSkgcmVsYXkgdGhlIHNldF9m
ZWF0dXJlcyByZXF1ZXN0IHRvIHVzZXJzcGFjZQoKb3IKCjFiKSBpbnRyb2R1Y2UgYSBtYW5kYXRl
ZF9kZXZpY2VfZmVhdHVyZXMgZHVyaW5nIGRldmljZSBjcmVhdGlvbiBhbmQgCnZhbGlkYXRlIHRo
ZSBkcml2ZXIgZmVhdHVyZXMgZHVyaW5nIHRoZSBzZXRfZmVhdHVyZXMoKSwgYW5kIGRvbid0IHNl
dCAKRkVBVFVSRVNfT0sgaWYgdGhleSBkb24ndCBtYXRjaC4KCgoyKSBTb21lIHRyYW5zcG9ydHMg
KFBDSSkgcmVxdWlyZXMgdG8gcmUtcmVhZCB0aGUgc3RhdHVzIHRvIGVuc3VyZSB0aGUgCnN5bmNo
cm9uaXphdGlvbi4KCiIKCkFmdGVyIHdyaXRpbmcgMCB0byBkZXZpY2Vfc3RhdHVzLCB0aGUgZHJp
dmVyIE1VU1Qgd2FpdCBmb3IgYSByZWFkIG9mIApkZXZpY2Vfc3RhdHVzIHRvIHJldHVybiAwIGJl
Zm9yZSByZWluaXRpYWxpemluZyB0aGUgZGV2aWNlLgoKIgoKU28gd2UgbmVlZCB0byBkZWFsIHdp
dGggYm90aCBGRUFUVVJFU19PSyBhbmQgcmVzZXQsIGJ1dCBwcm9iYWJseSBub3QgCkRSSVZFUl9P
Sy4KClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
