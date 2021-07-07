Return-Path: <SRS0=rr22=L7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29034C07E9B
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 09:30:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C178461C6D
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 09:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C178461C6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AA4040179;
	Wed,  7 Jul 2021 09:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_KnRfW5vUDf; Wed,  7 Jul 2021 09:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3970404BA;
	Wed,  7 Jul 2021 09:30:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7A09C0010;
	Wed,  7 Jul 2021 09:30:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05E08C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E70628399E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i9MEytrPlOJP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEE368376D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625650216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6o/7kaTqPTYt2A7Z0zjqMN0nvm6hpJh6BNtPQwdwRLU=;
 b=RZG+/29uI1O5+FKSDpZztRydr+U8DWOJEaFTBKbV1ib7FMbnurWPlxp8XZOOJad1y6lwmW
 QuGbZjosD7QF42fgEHZzfbmJwDQxi8zRBjkVsSPKaqmmIg7LlRaYCuRUtxuQsgyNk+djHL
 hP9GjQxXk3JP5PF2pnSdeUZhmnD65ag=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-ynQXtJUdOd-bz3-WfUO7_A-1; Wed, 07 Jul 2021 05:30:15 -0400
X-MC-Unique: ynQXtJUdOd-bz3-WfUO7_A-1
Received: by mail-io1-f69.google.com with SMTP id
 x21-20020a5d99150000b02904e00bb129f0so1223069iol.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jul 2021 02:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6o/7kaTqPTYt2A7Z0zjqMN0nvm6hpJh6BNtPQwdwRLU=;
 b=Cylywlyb6xg3iJM5H6BKgCbu5oO8Sea3U4ZILlw9JJFTRyR5Hiz6/elZHmwp+pmQuh
 E958ekyj68LaRV5eF9/piYTlR75KJA8S3fe3vMwjagoJrAGs+huANWASEhns62ckn8Ho
 H5dL98IrSl1oc18sRvqic7SjTGr3YxYYgzCsmzc16ZSRtpIFIS9INQ4NjVGH8pCG3Bxp
 xNIGc3cKPIZc8YQ6MvSefaOissWq2A4V5dYO2873s1mYk6oKUrK6fziP8tqJMp/dtg4R
 u3zHFfm4I8jhmeTjaXWnUvNZtQ9x36POOAVAcXi6ALZHc7I6gpgD/SivahEy0Xt83CwG
 cNMA==
X-Gm-Message-State: AOAM5325UWJsrjbu2CWW/dWuG1qUnSWGOvGtwZSCyIPasLU428wW3Is/
 +8OCJSFGkpsjkypfNzQPakPS8a2jCzj2rKThOR6QY4v2kbqp3WsXfsTXFlvewzR93QBYOYh0qSP
 /v2eMXUg0n6mJJBBIT1dW6803iS7T5UKIvG3A7ow7Qg==
X-Received: by 2002:a63:d908:: with SMTP id r8mr25178224pgg.414.1625649863837; 
 Wed, 07 Jul 2021 02:24:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhom9V3zcwokImKdubLhhEYAw1OEUfXMki4J5NNqR0Ed07VLuH+WgHu4YOpQSJUGm/lh1JIQ==
X-Received: by 2002:a63:d908:: with SMTP id r8mr25178193pgg.414.1625649863513; 
 Wed, 07 Jul 2021 02:24:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id md15sm5946056pjb.30.2021.07.07.02.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 02:24:23 -0700 (PDT)
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
 <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
 <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
 <8320d26d-6637-85c6-8773-49553dfa502d@redhat.com>
 <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
 <5b5107fa-3b32-8a3b-720d-eee6b2a84ace@redhat.com>
 <YOQtG3gDOhHDO5CQ@stefanha-x1.localdomain>
 <CACGkMEs2HHbUfarum8uQ6wuXoDwLQUSXTsa-huJFiqr__4cwRg@mail.gmail.com>
 <YOSOsrQWySr0andk@stefanha-x1.localdomain>
 <100e6788-7fdf-1505-d69c-bc28a8bc7a78@redhat.com>
 <YOVr801d01YOPzLL@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a03c8627-7dac-2255-a2d9-603fc623b618@redhat.com>
Date: Wed, 7 Jul 2021 17:24:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOVr801d01YOPzLL@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
 Jens Axboe <axboe@kernel.dk>, gregkh@linuxfoundation.org,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bcrl@kvack.org" <bcrl@kvack.org>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
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

CuWcqCAyMDIxLzcvNyDkuIvljYg0OjU1LCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+IE9uIFdl
ZCwgSnVsIDA3LCAyMDIxIGF0IDExOjQzOjI4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IOWcqCAyMDIxLzcvNyDkuIrljYgxOjExLCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+Pj4gT24g
VHVlLCBKdWwgMDYsIDIwMjEgYXQgMDk6MDg6MjZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4+PiBPbiBUdWUsIEp1bCA2LCAyMDIxIGF0IDY6MTUgUE0gU3RlZmFuIEhham5vY3ppIDxzdGVm
YW5oYUByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4gT24gVHVlLCBKdWwgMDYsIDIwMjEgYXQgMTA6
MzQ6MzNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+IOWcqCAyMDIxLzcvNSDkuIvl
jYg4OjQ5LCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+Pj4+Pj4+IE9uIE1vbiwgSnVsIDA1LCAy
MDIxIGF0IDExOjM2OjE1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pj4+IOWcqCAy
MDIxLzcvNCDkuIvljYg1OjQ5LCBZb25namkgWGllIOWGmemBkzoKPj4+Pj4+Pj4+Pj4gT0ssIEkg
Z2V0IHlvdSBub3cuIFNpbmNlIHRoZSBWSVJUSU8gc3BlY2lmaWNhdGlvbiBzYXlzICJEZXZpY2UK
Pj4+Pj4+Pj4+Pj4gY29uZmlndXJhdGlvbiBzcGFjZSBpcyBnZW5lcmFsbHkgdXNlZCBmb3IgcmFy
ZWx5LWNoYW5naW5nIG9yCj4+Pj4+Pj4+Pj4+IGluaXRpYWxpemF0aW9uLXRpbWUgcGFyYW1ldGVy
cyIuIEkgYXNzdW1lIHRoZSBWRFVTRV9ERVZfU0VUX0NPTkZJRwo+Pj4+Pj4+Pj4+PiBpb2N0bCBz
aG91bGQgbm90IGJlIGNhbGxlZCBmcmVxdWVudGx5Lgo+Pj4+Pj4+Pj4+IFRoZSBzcGVjIHVzZXMg
TVVTVCBhbmQgb3RoZXIgdGVybXMgdG8gZGVmaW5lIHRoZSBwcmVjaXNlIHJlcXVpcmVtZW50cy4K
Pj4+Pj4+Pj4+PiBIZXJlIHRoZSBsYW5ndWFnZSAoZXNwZWNpYWxseSB0aGUgd29yZCAiZ2VuZXJh
bGx5IikgaXMgd2Vha2VyIGFuZCBtZWFucwo+Pj4+Pj4+Pj4+IHRoZXJlIG1heSBiZSBleGNlcHRp
b25zLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQW5vdGhlciB0eXBlIG9mIGFjY2VzcyB0aGF0IGRv
ZXNuJ3Qgd29yayB3aXRoIHRoZSBWRFVTRV9ERVZfU0VUX0NPTkZJRwo+Pj4+Pj4+Pj4+IGFwcHJv
YWNoIGlzIHJlYWRzIHRoYXQgaGF2ZSBzaWRlLWVmZmVjdHMuIEZvciBleGFtcGxlLCBpbWFnaW5l
IGEgZmllbGQKPj4+Pj4+Pj4+PiBjb250YWluaW5nIGFuIGVycm9yIGNvZGUgaWYgdGhlIGRldmlj
ZSBlbmNvdW50ZXJzIGEgcHJvYmxlbSB1bnJlbGF0ZWQgdG8KPj4+Pj4+Pj4+PiBhIHNwZWNpZmlj
IHZpcnRxdWV1ZSByZXF1ZXN0LiBSZWFkaW5nIGZyb20gdGhpcyBmaWVsZCByZXNldHMgdGhlIGVy
cm9yCj4+Pj4+Pj4+Pj4gY29kZSB0byAwLCBzYXZpbmcgdGhlIGRyaXZlciBhbiBleHRyYSBjb25m
aWd1cmF0aW9uIHNwYWNlIHdyaXRlIGFjY2Vzcwo+Pj4+Pj4+Pj4+IGFuZCBwb3NzaWJseSByYWNl
IGNvbmRpdGlvbnMuIEl0IGlzbid0IHBvc3NpYmxlIHRvIGltcGxlbWVudCB0aG9zZQo+Pj4+Pj4+
Pj4+IHNlbWFudGljcyBzdWluZyBWRFVTRV9ERVZfU0VUX0NPTkZJRy4gSXQncyBhbm90aGVyIGNv
cm5lciBjYXNlLCBidXQgaXQKPj4+Pj4+Pj4+PiBtYWtlcyBtZSB0aGluayB0aGF0IHRoZSBpbnRl
cmZhY2UgZG9lcyBub3QgYWxsb3cgZnVsbCBWSVJUSU8gc2VtYW50aWNzLgo+Pj4+Pj4+PiBOb3Rl
IHRoYXQgdGhvdWdoIHlvdSdyZSBjb3JyZWN0LCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgY29u
ZmlnIHNwYWNlIGlzCj4+Pj4+Pj4+IG5vdCBzdWl0YWJsZSBmb3IgdGhpcyBraW5kIG9mIGVycm9y
IHByb3BhZ2F0aW5nLiBBbmQgaXQgd291bGQgYmUgdmVyeSBoYXJkCj4+Pj4+Pj4+IHRvIGltcGxl
bWVudCBzdWNoIGtpbmQgb2Ygc2VtYW50aWMgaW4gc29tZSB0cmFuc3BvcnRzLiAgVmlydHF1ZXVl
IHNob3VsZCBiZQo+Pj4+Pj4+PiBtdWNoIGJldHRlci4gQXMgWW9uZyBKaSBxdW90ZWQsIHRoZSBj
b25maWcgc3BhY2UgaXMgdXNlZCBmb3IKPj4+Pj4+Pj4gInJhcmVseS1jaGFuZ2luZyBvciBpbnRp
YWxpemF0aW9uLXRpbWUgcGFyYW1ldGVycyIuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBB
Z3JlZWQuIEkgd2lsbCB1c2UgVkRVU0VfREVWX0dFVF9DT05GSUcgaW4gdGhlIG5leHQgdmVyc2lv
bi4gQW5kIHRvCj4+Pj4+Pj4+PiBoYW5kbGUgdGhlIG1lc3NhZ2UgZmFpbHVyZSwgSSdtIGdvaW5n
IHRvIGFkZCBhIHJldHVybiB2YWx1ZSB0bwo+Pj4+Pj4+Pj4gdmlydGlvX2NvbmZpZ19vcHMuZ2V0
KCkgYW5kIHZpcnRpb19jcmVhZF8qIEFQSSBzbyB0aGF0IHRoZSBlcnJvciBjYW4KPj4+Pj4+Pj4+
IGJlIHByb3BhZ2F0ZWQgdG8gdGhlIHZpcnRpbyBkZXZpY2UgZHJpdmVyLiBUaGVuIHRoZSB2aXJ0
aW8tYmxrIGRldmljZQo+Pj4+Pj4+Pj4gZHJpdmVyIGNhbiBiZSBtb2RpZmllZCB0byBoYW5kbGUg
dGhhdC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBKYXNvbiBhbmQgU3RlZmFuLCB3aGF0IGRvIHlvdSB0
aGluayBvZiB0aGlzIHdheT8KPj4+Pj4+PiBXaHkgZG9lcyBWRFVTRV9ERVZfR0VUX0NPTkZJRyBu
ZWVkIHRvIHN1cHBvcnQgYW4gZXJyb3IgcmV0dXJuIHZhbHVlPwo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhl
IFZJUlRJTyBzcGVjIHByb3ZpZGVzIG5vIHdheSBmb3IgdGhlIGRldmljZSB0byByZXBvcnQgZXJy
b3JzIGZyb20KPj4+Pj4+PiBjb25maWcgc3BhY2UgYWNjZXNzZXMuCj4+Pj4+Pj4KPj4+Pj4+PiBU
aGUgUUVNVSB2aXJ0aW8tcGNpIGltcGxlbWVudGF0aW9uIHJldHVybnMgLTEgZnJvbSBpbnZhbGlk
Cj4+Pj4+Pj4gdmlydGlvX2NvbmZpZ19yZWFkKigpIGFuZCBzaWxlbnRseSBkaXNjYXJkcyB2aXJ0
aW9fY29uZmlnX3dyaXRlKigpCj4+Pj4+Pj4gYWNjZXNzZXMuCj4+Pj4+Pj4KPj4+Pj4+PiBWRFVT
RSBjYW4gdGFrZSB0aGUgc2FtZSBhcHByb2FjaCB3aXRoCj4+Pj4+Pj4gVkRVU0VfREVWX0dFVF9D
T05GSUcvVkRVU0VfREVWX1NFVF9DT05GSUcuCj4+Pj4+Pj4KPj4+Pj4+Pj4gSSdkIGxpa2UgdG8g
c3RpY2sgdG8gdGhlIGN1cnJlbnQgYXNzdW1wdGlvbiB0aGljaCBnZXRfY29uZmlnIHdvbid0IGZh
aWwuCj4+Pj4+Pj4+IFRoYXQgaXMgdG8gc2F5LAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAxKSBtYWludGFp
biBhIGNvbmZpZyBpbiB0aGUga2VybmVsLCBtYWtlIHN1cmUgdGhlIGNvbmZpZyBzcGFjZSByZWFk
IGNhbgo+Pj4+Pj4+PiBhbHdheXMgc3VjY2VlZAo+Pj4+Pj4+PiAyKSBpbnRyb2R1Y2UgYW4gaW9j
dGwgZm9yIHRoZSB2ZHVzZSB1c2Vyc2FwY2UgdG8gdXBkYXRlIHRoZSBjb25maWcgc3BhY2UuCj4+
Pj4+Pj4+IDMpIHdlIGNhbiBzeW5jaHJvbml6ZSB3aXRoIHRoZSB2ZHVzZSB1c2Vyc3BhY2UgZHVy
aW5nIHNldF9jb25maWcKPj4+Pj4+Pj4KPj4+Pj4+Pj4gRG9lcyB0aGlzIHdvcms/Cj4+Pj4+Pj4g
SSBub3RpY2VkIHRoYXQgY2FjaGluZyBpcyBhbHNvIGFsbG93ZWQgYnkgdGhlIHZob3N0LXVzZXIg
cHJvdG9jb2wKPj4+Pj4+PiBtZXNzYWdlcyAoUUVNVSdzIGRvY3MvaW50ZXJvcC92aG9zdC11c2Vy
LnJzdCksIGJ1dCB0aGUgZGV2aWNlIGRvZXNuJ3QKPj4+Pj4+PiBrbm93IHdoZXRoZXIgb3Igbm90
IGNhY2hpbmcgaXMgaW4gZWZmZWN0LiBUaGUgaW50ZXJmYWNlIHlvdSBvdXRsaW5lZAo+Pj4+Pj4+
IGFib3ZlIHJlcXVpcmVzIGNhY2hpbmcuCj4+Pj4+Pj4KPj4+Pj4+PiBJcyB0aGVyZSBhIHJlYXNv
biB3aHkgdGhlIGhvc3Qga2VybmVsIHZEUEEgY29kZSBuZWVkcyB0byBjYWNoZSB0aGUKPj4+Pj4+
PiBjb25maWd1cmF0aW9uIHNwYWNlPwo+Pj4+Pj4gQmVjYXVzZToKPj4+Pj4+Cj4+Pj4+PiAxKSBL
ZXJuZWwgY2FuIG5vdCB3YWl0IGZvcmV2ZXIgaW4gZ2V0X2NvbmZpZygpLCB0aGlzIGlzIHRoZSBt
YWpvciBkaWZmZXJlbmNlCj4+Pj4+PiB3aXRoIHZob3N0LXVzZXIuCj4+Pj4+IHZpcnRpb19jcmVh
ZCgpIGNhbiBzbGVlcDoKPj4+Pj4KPj4+Pj4gICAgICNkZWZpbmUgdmlydGlvX2NyZWFkKHZkZXYs
IHN0cnVjdG5hbWUsIG1lbWJlciwgcHRyKSAgICAgICAgICAgICAgICAgICAgIFwKPj4+Pj4gICAg
ICAgICAgICAgZG8geyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKPj4+Pj4gICAgICAgICAgICAgICAgICAgICB0eXBlb2YoKChzdHJ1
Y3RuYW1lKikwKS0+bWVtYmVyKSB2aXJ0aW9fY3JlYWRfdjsgICAgICAgIFwKPj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwKPj4+Pj4gICAgICAgICAgICAgICAgICAgICBtaWdodF9zbGVlcCgpOyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPj4+Pj4gICAgICAgICAg
ICAgICAgICAgICBeXl5eXl5eXl5eXl5eXgo+Pj4+Pgo+Pj4+PiBXaGljaCBjb2RlIHBhdGggY2Fu
bm90IHNsZWVwPwo+Pj4+IFdlbGwsIGl0IGNhbiBzbGVlcCBidXQgaXQgY2FuJ3Qgc2xlZXAgZm9y
ZXZlci4gRm9yIFZEVVNFLCBhCj4+Pj4gYnVnZ3kvbWFsaWNpb3VzIHVzZXJzcGFjZSBtYXkgcmVm
dXNlIHRvIHJlc3BvbmQgdG8gdGhlIGdldF9jb25maWcuCj4+Pj4KPj4+PiBJdCBsb29rcyB0byBt
ZSB0aGUgaWRlYWwgY2FzZSwgd2l0aCB0aGUgY3VycmVudCB2aXJ0aW8gc3BlYywgZm9yIFZEVVNF
IGlzIHRvCj4+Pj4KPj4+PiAxKSBtYWludGFpbiB0aGUgZGV2aWNlIGFuZCBpdHMgc3RhdGUgaW4g
dGhlIGtlcm5lbCwgdXNlcnNwYWNlIG1heSBzeW5jCj4+Pj4gd2l0aCB0aGUga2VybmVsIGRldmlj
ZSB2aWEgaW9jdGxzCj4+Pj4gMikgb2ZmbG9hZCB0aGUgZGF0YXBhdGggKHZpcnRxdWV1ZSkgdG8g
dGhlIHVzZXJzcGFjZQo+Pj4+Cj4+Pj4gVGhpcyBzZWVtcyBtb3JlIHJvYnVzdCBhbmQgc2FmZSB0
aGFuIHNpbXBseSByZWxheWluZyBldmVyeXRoaW5nIHRvCj4+Pj4gdXNlcnNwYWNlIGFuZCB3YWl0
aW5nIGZvciBpdHMgcmVzcG9uc2UuCj4+Pj4KPj4+PiBBbmQgd2Uga25vdyBmb3Igc3VyZSB0aGlz
IG1vZGVsIGNhbiB3b3JrLCBhbiBleGFtcGxlIGlzIFRVTi9UQVA6Cj4+Pj4gbmV0ZGV2aWNlIGlz
IGFic3RyYWN0ZWQgaW4gdGhlIGtlcm5lbCBhbmQgZGF0YXBhdGggaXMgZG9uZSB2aWEKPj4+PiBz
ZW5kbXNnKCkvcmVjdm1zZygpLgo+Pj4+Cj4+Pj4gTWFpbnRhaW5pbmcgdGhlIGNvbmZpZyBpbiB0
aGUga2VybmVsIGZvbGxvd3MgdGhpcyBtb2RlbCBhbmQgaXQgY2FuCj4+Pj4gc2ltcGxpZnkgdGhl
IGRldmljZSBnZW5lcmF0aW9uIGltcGxlbWVudGF0aW9uLgo+Pj4+Cj4+Pj4gRm9yIGNvbmZpZyBz
cGFjZSB3cml0ZSwgaXQgcmVxdWlyZXMgbW9yZSB0aG91Z2h0IGJ1dCBmb3J0dW5hdGVseSBpdCdz
Cj4+Pj4gbm90IGNvbW1vbmx5IHVzZWQuIFNvIFZEVVNFIGNhbiBjaG9vc2UgdG8gZmlsdGVyIG91
dCB0aGUKPj4+PiBkZXZpY2UvZmVhdHVyZXMgdGhhdCBkZXBlbmRzIG9uIHRoZSBjb25maWcgd3Jp
dGUuCj4+PiBUaGlzIGlzIHRoZSBwcm9ibGVtLiBUaGVyZSBhcmUgb3RoZXIgbWVzc2FnZXMgbGlr
ZSBTRVRfRkVBVFVSRVMgd2hlcmUgSQo+Pj4gZ3Vlc3Mgd2UnbGwgZmFjZSB0aGUgc2FtZSBjaGFs
bGVuZ2UuCj4+Cj4+IFByb2JhYmx5IG5vdCwgdXNlcnNwYWNlIGRldmljZSBjYW4gdGVsbCB0aGUg
a2VybmVsIGFib3V0IHRoZSBkZXZpY2VfZmVhdHVyZXMKPj4gYW5kIG1hbmRhdGVkX2ZlYXR1cmVz
IGR1cmluZyBjcmVhdGlvbiwgYW5kIHRoZSBmZWF0dXJlIG5lZ290aWF0aW9uIGNvdWxkIGJlCj4+
IGRvbmUgcHVyZWx5IGluIHRoZSBrZXJuZWwgd2l0aG91dCBib3RoZXJpbmcgdGhlIHVzZXJzcGFj
ZS4KCgooRm9yIHNvbWUgcmVhc29uIEkgZHJvcCB0aGUgbGlzdCBhY2NpZGVudGFsbHksIGFkZGlu
ZyB0aGVtIGJhY2ssIHNvcnJ5KQoKCj4gU29ycnksIEkgY29uZnVzZWQgdGhlIG1lc3NhZ2VzLiBJ
IG1lYW50IFNFVF9TVEFUVVMuIEl0J3MgYSBzeW5jaHJvbm91cwo+IGludGVyZmFjZSB3aGVyZSB0
aGUgZHJpdmVyIHdhaXRzIGZvciB0aGUgZGV2aWNlLgoKCkl0IGRlcGVuZHMgb24gaG93IHdlIGRl
ZmluZSAic3luY2hyb25vdXMiIGhlcmUuIElmIEkgdW5kZXJzdGFuZCAKY29ycmVjdGx5LCB0aGUg
c3BlYyBkb2Vzbid0IGV4cGVjdCB0aGVyZSB3aWxsIGJlIGFueSBraW5kIG9mIGZhaWx1cmUgZm9y
IAp0aGUgb3BlcmF0aW9uIG9mIHNldF9zdGF0dXMgaXRzZWxmLgoKSW5zdGVhZCwgYW55dGltZSBp
dCB3YW50IGFueSBzeW5jaHJvbml6YXRpb24sIGl0IHNob3VsZCBiZSBkb25lIHZpYSAKZ2V0X3N0
YXR1cygpOgoKMSkgcmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIG1ha2Ugc3VyZSBGRUFUVVJFU19P
SyBpcyBzZXQgZHVyaW5nIGZlYXR1cmUgCm5lZ290aWF0aW9uCjIpIHJlLXJlYWQgZGV2aWNlIHN0
YXR1cyB0byBiZSAwIHRvIG1ha2Ugc3VyZSB0aGUgZGV2aWNlIGhhcyBmaW5pc2ggdGhlIApyZXNl
dAoKCj4KPiBWRFVTRSBjdXJyZW50bHkgZG9lc24ndCB3YWl0IGZvciB0aGUgZGV2aWNlIGVtdWxh
dGlvbiBwcm9jZXNzIHRvIGhhbmRsZQo+IHRoaXMgbWVzc2FnZSAobm8gcmVwbHkgaXMgbmVlZGVk
KSBidXQgSSB0aGluayB0aGlzIGlzIGEgbWlzdGFrZSBiZWNhdXNlCj4gVkRVU0UgaXMgbm90IGZv
bGxvd2luZyB0aGUgVklSVElPIGRldmljZSBtb2RlbC4KCgpXaXRoIHRoZSB0cmljayB0aGF0IGlz
IGRvbmUgZm9yIEZFQVRVUkVTX09LIGFib3ZlLCBJIHRoaW5rIHdlIGRvbid0IG5lZWQgCnRvIHdh
aXQgZm9yIHRoZSByZXBseS4KCklmIHVzZXJzcGFjZSB0YWtlcyB0b28gbG9uZyB0byByZXNwb25k
LCBpdCBjYW4gYmUgZGV0ZWN0ZWQgc2luY2UgCmdldF9zdGF0dXMoKSBkb2Vzbid0IHJldHVybiB0
aGUgZXhwZWN0ZWQgdmFsdWUgZm9yIGxvbmcgdGltZS4KCkFuZCBmb3IgdGhlIGNhc2UgdGhhdCBu
ZWVkcyBhIHRpbWVvdXQsIHdlIHByb2JhYmx5IGNhbiB1c2UgTkVFRFNfUkVTRVQuCgoKPgo+IEkg
c3Ryb25nbHkgc3VnZ2VzdCBkZXNpZ25pbmcgdGhlIFZEVVNFIGludGVyZmFjZSB0byBtYXRjaCB0
aGUgVklSVElPCj4gZGV2aWNlIG1vZGVsIChvciBhdCBsZWFzdCB0aGUgdkRQQSBpbnRlcmZhY2Up
LgoKCkkgZnVsbHkgYWdyZWUgd2l0aCB5b3UgYW5kIHRoYXQgaXMgd2hhdCB3ZSB3YW50IHRvIGFj
aGlldmUgaW4gdGhpcyBzZXJpZXMuCgoKPiBEZWZpbmluZyBhIGN1c3RvbQo+IGludGVyZmFjZSBm
b3IgVkRVU0UgYXZvaWRzIHNvbWUgaW1wbGVtZW50YXRpb24gY29tcGxleGl0eSBhbmQgbWFrZXMg
aXQKPiBlYXNpZXIgdG8gZGVhbCB3aXRoIHVudHJ1c3RlZCB1c2Vyc3BhY2UsIGJ1dCBpdCdzIGlt
cG9zc2libGUgdG8KPiBpbXBsZW1lbnQgY2VydGFpbiBWSVJUSU8gZmVhdHVyZXMgb3IgZGV2aWNl
cy4gSXQgYWxzbyBmcmFnbWVudHMgVklSVElPCj4gbW9yZSB0aGFuIG5lY2Vzc2FyeTsgd2UgaGF2
ZSBhIHN0YW5kYXJkLCBsZXQncyBzdGljayB0byBpdC4KCgpZZXMuCgoKPgo+Pj4gSSBhZ3JlZSB0
aGF0IGNhY2hpbmcgdGhlIGNvbnRlbnRzIG9mIGNvbmZpZ3VyYXRpb24gc3BhY2UgaW4gdGhlIGtl
cm5lbAo+Pj4gaGVscHMsIGJ1dCBpZiB0aGVyZSBhcmUgb3RoZXIgVkRVU0UgbWVzc2FnZXMgd2l0
aCB0aGUgc2FtZSBwcm9ibGVtIHRoZW4KPj4+IGFuIGF0dGFja2VyIHdpbGwgZXhwbG9pdCB0aGVt
IGluc3RlYWQuCj4+Pgo+Pj4gSSB0aGluayBhIHN5c3RlbWF0aWMgc29sdXRpb24gaXMgbmVlZGVk
LiBJdCB3b3VsZCBiZSBuZWNlc3NhcnkgdG8KPj4+IGVudW1lcmF0ZSB0aGUgdmlydGlvX3ZkcGEg
YW5kIHZob3N0X3ZkcGEgY2FzZXMgc2VwYXJhdGVseSB0byBmaWd1cmUgb3V0Cj4+PiB3aGVyZSBW
RFVTRSBtZXNzYWdlcyBhcmUgc3luY2hyb25vdXMvdGltZS1zZW5zaXRpdmUuCj4+Cj4+IFRoaXMg
aXMgdGhlIGNhc2Ugb2YgcmVzZXQgYW5kIG5lZWRzIG1vcmUgdGhvdWdodC4gV2Ugc2hvdWxkIHN0
aWNrIGEKPj4gY29uc2lzdGVudCB1QVBJIGZvciB0aGUgdXNlcnNwYWNlLgo+Pgo+PiBGb3Igdmhv
c3QtdkRQQSwgaXQgbmVlZHMgc3luY2hyb256aWVkIHdpdGggdGhlIHVzZXJzcGFjZSBhbmQgd2Ug
Y2FuIHdhaXQgZm9yCj4+IGV2ZXIuCj4gVGhlIFZNTSBzaG91bGQgc3RpbGwgYmUgYWJsZSB0byBo
YW5kbGUgc2lnbmFscyB3aGVuIGEgdmhvc3RfdmRwYSBpb2N0bAo+IGlzIHdhaXRpbmcgZm9yIGEg
cmVwbHkgZnJvbSB0aGUgVkRVU0UgdXNlcnNwYWNlIHByb2Nlc3MuIE9yIGlmIHRoYXQncwo+IG5v
dCBwb3NzaWJsZSB0aGVuIHRoZXJlIG5lZWRzIHRvIGJlIGEgd2F5IHRvIGZvcmNlIGRpc2Nvbm5l
Y3Rpb24gZnJvbQo+IFZEVVNFIHNvIHRoZSBWTU0gY2FuIGJlIGtpbGxlZC4KCgpOb3RlIHRoYXQg
VkRVU0Ugd29ya3MgdW5kZXIgdkRQQSBidXMsIHNvIHZob3N0IHNob3VsZCBiZSB0cmFuc3BvcnQg
dG8gVkRVU0UuCgpCdXQgd2UgY2FuIGRldGVjdCB0aGlzIHZpYSB3aGV0aGVyIG9yIG5vdCB0aGUg
Ym91bmNlIGJ1ZmZlciBpcyB1c2VkLgoKVGhhbmtzCgoKPgo+IFN0ZWZhbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
