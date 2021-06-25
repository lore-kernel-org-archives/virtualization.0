Return-Path: <SRS0=LBsv=LT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86196C49EA5
	for <virtualization@archiver.kernel.org>; Fri, 25 Jun 2021 03:09:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDDA613FA
	for <virtualization@archiver.kernel.org>; Fri, 25 Jun 2021 03:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDDA613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1745C40176;
	Fri, 25 Jun 2021 03:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i8WO5c_llGvF; Fri, 25 Jun 2021 03:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B8E79400DC;
	Fri, 25 Jun 2021 03:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 941C6C001A;
	Fri, 25 Jun 2021 03:09:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E48A2C0022
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2B224054B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q9W4PtpltNJX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:09:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D38DD40512
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624590544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2g9lBasApYrM4QFsD5hgHZyz+dwqoNSSbWrkfNZV2I=;
 b=T6N0mwGoButy10GAz6VAREaDqLgSnMS8/WRzbOHKWk53UAg5xA+8sxo6HxfHc6PO1P9gTI
 gaUlXOwVPE02TBSVgaKuW4qMfUFpwtqms4QzbuyVKTHFnQR7XQ/m6W/cBIl5FkJ41R99Df
 kdQ/kAnyqXRKDRSHk7IDdS81zVbODRg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-61h-81O5OC-7iFARHsnHMQ-1; Thu, 24 Jun 2021 23:09:00 -0400
X-MC-Unique: 61h-81O5OC-7iFARHsnHMQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 4-20020a6315440000b029022154a87a57so5157698pgv.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 20:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=x2g9lBasApYrM4QFsD5hgHZyz+dwqoNSSbWrkfNZV2I=;
 b=Xmvm7Gq4nLPnwFovKrfH9Ym2RTW78ey9CMG+Q+jEsto+ioX6TkMfogud00qMygJb5j
 oAmdzk8ckndprmrxRkDEW0xSK4nFOGU3CWwh3beLfZaWda4a/OWf6UmudxI4YXXPa22N
 JJKpEW3Oq6FN3dfb3eRZPwV8raaVIQ1mTjpdytn1I4VoEo9RgcECuOXDTXC6uyxyyElh
 ROrAcf+4cGWIcxI/kyNOSUtdlNc+OKBFvNNShMmkhdHTFiFKcizcFDYVZY6ctEi8yaMT
 VE4qYHmS0p9N4h/R8PGFylbsFv5XLICqw6sVVAJvlEEepj2Jc5CvF8Nwpwt6VQ6ynQLe
 YYyw==
X-Gm-Message-State: AOAM533RAecFBVTxxmReVn33oo1D12jBfyHagwuKJnokPTe0AoVDZI5K
 H1vDmornku8/jhTC1BJlirqxjJ0F2nEgL1eoTQa8rukOibyE1idzyidbcG5EFzt0r5vtQxeDKP7
 cBYgsuwa1nZnY1eKS6hKYqTWe0Q/o2miB+gTbnSk6Lw==
X-Received: by 2002:a17:90a:d302:: with SMTP id
 p2mr597052pju.186.1624590535520; 
 Thu, 24 Jun 2021 20:08:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSt2a7irPTEnHB75wt/k1DcVWt+k1ibjJ9B3uVz8Ybl5wVpiHcOLL8vV4fUc+onvCWC2yUZA==
X-Received: by 2002:a17:90a:d302:: with SMTP id
 p2mr597003pju.186.1624590535223; 
 Thu, 24 Jun 2021 20:08:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z9sm4301129pfc.101.2021.06.24.20.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 20:08:54 -0700 (PDT)
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
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
Date: Fri, 25 Jun 2021 11:08:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
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

CuWcqCAyMDIxLzYvMjQg5LiL5Y2INToxNiwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVGh1LCBK
dW4gMjQsIDIwMjEgYXQgNDoxNCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNi8yNCDkuIvljYgxMjo0NiwgWW9uZ2ppIFhpZSDlhpnpgZM6
Cj4+Pj4gU28gd2UgbmVlZCB0byBkZWFsIHdpdGggYm90aCBGRUFUVVJFU19PSyBhbmQgcmVzZXQs
IGJ1dCBwcm9iYWJseSBub3QKPj4+PiBEUklWRVJfT0suCj4+Pj4KPj4+IE9LLCBJIHNlZS4gVGhh
bmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIE9uZSBtb3JlIHF1ZXN0aW9uIGlzIGhvdyBhYm91dAo+
Pj4gY2xlYXJpbmcgdGhlIGNvcnJlc3BvbmRpbmcgc3RhdHVzIGJpdCBpbiBnZXRfc3RhdHVzKCkg
cmF0aGVyIHRoYW4KPj4+IG1ha2luZyBzZXRfc3RhdHVzKCkgZmFpbC4gU2luY2UgdGhlIHNwZWMg
cmVjb21tZW5kcyB0aGlzIHdheSBmb3IKPj4+IHZhbGlkYXRpb24gd2hpY2ggaXMgZG9uZSBpbiB2
aXJ0aW9fZGV2X3JlbW92ZSgpIGFuZAo+Pj4gdmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVzKCkuCj4+
Pgo+Pj4gVGhhbmtzLAo+Pj4gWW9uZ2ppCj4+Pgo+PiBJIHRoaW5rIHlvdSBjYW4uIE9yIGl0IHdv
dWxkIGJlIGV2ZW4gYmV0dGVyIHRoYXQgd2UganVzdCBkb24ndCBzZXQgdGhlCj4+IGJpdCBkdXJp
bmcgc2V0X3N0YXR1cygpLgo+Pgo+IFllcywgdGhhdCdzIHdoYXQgSSBtZWFuLgo+Cj4+IEkganVz
dCByZWFsaXplIHRoYXQgaW4gdmRwYV9yZXNldCgpIHdlIGhhZDoKPj4KPj4gc3RhdGljIGlubGlu
ZSB2b2lkIHZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+PiB7Cj4+ICAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4+
Cj4+ICAgICAgICAgICB2ZGV2LT5mZWF0dXJlc192YWxpZCA9IGZhbHNlOwo+PiAgICAgICAgICAg
b3BzLT5zZXRfc3RhdHVzKHZkZXYsIDApOwo+PiB9Cj4+Cj4+IFdlIHByb2JhYmx5IG5lZWQgdG8g
YWRkIHRoZSBzeW5jaHJvbml6YXRpb24gaGVyZS4gRS5nIHJlLXJlYWQgd2l0aCBhCj4+IHRpbWVv
dXQuCj4+Cj4gTG9va3MgbGlrZSB0aGUgdGltZW91dCBpcyBhbHJlYWR5IGluIHNldF9zdGF0dXMo
KS4KCgpEbyB5b3UgbWVhbiB0aGUgVkRVU0UncyBpbXBsZW1lbnRhdGlvbj8KCgo+ICAgRG8gd2Ug
cmVhbGx5IG5lZWQgYQo+IGR1cGxpY2F0ZWQgb25lIGhlcmU/CgoKMSkgdGhpcyBpcyB0aGUgdGlt
ZW91dCBhdCB0aGUgdkRQQSBsYXllciBpbnN0ZWFkIG9mIHRoZSBWRFVTRSBsYXllci4KMikgaXQg
cmVhbGx5IGRlcGVuZHMgb24gd2hhdCdzIHRoZSBtZWFuaW5nIG9mIHRoZSB0aW1lb3V0IGZvciBz
ZXRfc3RhdHVzIApvZiBWRFVTRS4KCkRvIHdlIHdhbnQ6CgoyYSkgZm9yIHNldF9zdGF0dXMoKTog
cmVsYXkgdGhlIG1lc3NhZ2UgdG8gdXNlcnNwYWNlIGFuZCB3YWl0IGZvciB0aGUgCnVzZXJzcGFj
ZSB0byBxdWllc2NlbmNlIHRoZSBkYXRhcGF0aAoKb3IKCjJiKSBmb3Igc2V0X3N0YXR1cygpOiBz
aW1wbHkgcmVsYXkgdGhlIG1lc3NhZ2UgdG8gdXNlcnNwYWNlLCByZXBseSBpcyBubyAKbmVlZGVk
LiBVc2Vyc3BhY2Ugd2lsbCB1c2UgYSBjb21tYW5kIHRvIHVwZGF0ZSB0aGUgc3RhdHVzIHdoZW4g
dGhlIApkYXRhcGF0aCBpcyBzdG9wLiBUaGUgdGhlIHN0YXR1cyBjb3VsZCBiZSBmZXRjaGVkIHZp
YSBnZXRfc3RhdHMoKS4KCjJiIGxvb2tzIG1vcmUgc3BlYyBjb21wbGFpbnQuCgo+IEFuZCBob3cg
dG8gaGFuZGxlIGZhaWx1cmU/IEFkZGluZyBhIHJldHVybiB2YWx1ZQo+IHRvIHZpcnRpb19jb25m
aWdfb3BzLT5yZXNldCgpIGFuZCBwYXNzaW5nIHRoZSBlcnJvciB0byB0aGUgdXBwZXIKPiBsYXll
cj8KCgpTb21ldGhpbmcgbGlrZSB0aGlzLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
