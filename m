Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D363C47080
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:39:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4684613D7
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4684613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 719BE60B24;
	Thu,  3 Jun 2021 03:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xunwkRHMYFWf; Thu,  3 Jun 2021 03:39:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00A3D60B21;
	Thu,  3 Jun 2021 03:39:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1941C000D;
	Thu,  3 Jun 2021 03:39:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D35C0C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B497A83CD6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03YDfaZSXBtd
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDFEA83CC0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622691591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+f0EqceIPMcCE81nyX/6vRLB2yNbJsosjw0iow1ykg=;
 b=Tnt6wm8G5yhZ+BFiMJUv7Qu1LuAAEKM2EMIbCwjIgqVoEogTL9geoaI9lIyBYc9vZpR7o/
 TyZ8ioP7QKWKT+3cT03At5lE90/y//HP42WftIoorMfB4xFDqZmVJwQw25c586AmN11GUv
 eq5rISjvigCYLOW37AZV1eaHVH61A34=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-5euu8CEMOFuBpp6pIhZt0g-1; Wed, 02 Jun 2021 23:39:50 -0400
X-MC-Unique: 5euu8CEMOFuBpp6pIhZt0g-1
Received: by mail-pj1-f71.google.com with SMTP id
 hf1-20020a17090aff81b02901630f822d2aso4575815pjb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 20:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=g+f0EqceIPMcCE81nyX/6vRLB2yNbJsosjw0iow1ykg=;
 b=RgwxrtUV5ukpvD8EWiQFl+TwP5kGU2Tvq2IjO7uDfOYN2SfNFOdisMPEAdMB+7febH
 O6uK1fKMx6tFyJ16zqVL7kTO60aT2kTHayyHBZblKXYMvb4ifULp0Ae2p3d3RoprIePX
 DmwmD/J4p7akIhGT6bA81l1YbdeWFQYs0rr+ZVoZrdXiNQA1cgPTCw46W3TP4YsCgszb
 MzOLA98OUhZRJzNBnFm/DUsVy8J9T5ydOvVehCgWw5IZNAgyiH+kwUqTb5DQO0Jammqk
 7wOMBu6Hbw0nwXTaOYa69NdPoJEgH/5s/RovjNFZaV37swyGBlAgAUE4DZXwNRc1e2lK
 pEPw==
X-Gm-Message-State: AOAM531ET8HihuehgsTF8S91Gf4AOgv+AI9kb/cfvlRVX9VoaHtZTbHn
 IXYzbGq5dCchp8qPh1mK0B/A27I+LZGSI1UQ8ne9XaL19tAUVjRpj+M/I20J+xygCTRiYvTiRDB
 QslnR9bmhO643rnMaptEnrKv6YFfVjgTUdwAEpceuHVYRBb8KehCHDR47X7ALpI2HBuh1jSz3Hi
 u2qjt8oPlRDDnAvAyuLA==
X-Received: by 2002:a17:90a:bc8f:: with SMTP id
 x15mr8894597pjr.119.1622691588877; 
 Wed, 02 Jun 2021 20:39:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmyLU35I8pSCDrAAyyxEVDjVzxelKIYOR1EC7Y8kByaiY/eRN53VJQToZhn1sQG25poWKNXw==
X-Received: by 2002:a17:90a:bc8f:: with SMTP id
 x15mr8894573pjr.119.1622691588556; 
 Wed, 02 Jun 2021 20:39:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o17sm1086838pgj.25.2021.06.02.20.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 20:39:47 -0700 (PDT)
Subject: Re: [RFC v3 25/29] vhost: Add custom IOTLB translations to SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-26-eperezma@redhat.com>
 <ae560866-4598-3157-a0cb-e0e79b4dca42@redhat.com>
 <CAJaqyWc7OWeQnXHihY=mYp=N+rRJLcbFUsJA-OszD6tyr6v-FQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <316a88dc-2d78-e36b-50d7-d0243bceb898@redhat.com>
Date: Thu, 3 Jun 2021 11:39:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJaqyWc7OWeQnXHihY=mYp=N+rRJLcbFUsJA-OszD6tyr6v-FQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 virtualization@lists.linux-foundation.org, Eric Blake <eblake@redhat.com>,
 Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzYvMyDkuIrljYgxOjUxLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gV2VkLCBKdW4gMiwgMjAyMSBhdCAxMTo1MiBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yMCDkuIrljYgxMjoyOCwgRXVnZW5pbyBQ
w6lyZXog5YaZ6YGTOgo+Pj4gVXNlIHRyYW5zbGF0aW9ucyBhZGRlZCBpbiBJT1ZBUmV2ZXJzZU1h
cHMgaW4gU1ZRIGlmIHRoZSB2aG9zdCBkZXZpY2UKPj4+IGRvZXMgbm90IHN1cHBvcnQgdGhlIG1h
cHBpbmcgb2YgdGhlIGZ1bGwgcWVtdSdzIHZpcnR1YWwgYWRkcmVzcyBzcGFjZS4KPj4+IEluIG90
aGVyIGNhc2VzLCBTaGFkb3cgVmlydHF1ZXVlIHN0aWxsIHVzZXMgdGhlIHFlbXUncyB2aXJ0dWFs
IGFkZHJlc3MKPj4+IG9mIHRoZSBidWZmZXIgcG9pbnRlZCBieSB0aGUgZGVzY3JpcHRvciwgd2hp
Y2ggaGFzIGJlZW4gdHJhbnNsYXRlZAo+Pj4gYWxyZWFkeSBieSBxZW11J3MgVmlydFF1ZXVlIG1h
Y2hpbmVyeS4KPj4KPj4gSSdkIHNheSBsZXQgc3RpY2sgdG8gYSBzaW5nbGUga2luZCBvZiB0cmFu
c2xhdGlvbiAoaW92YSBhbGxvY2F0b3IpIHRoYXQKPj4gd29ya3MgZm9yIGFsbCB0aGUgY2FzZXMg
Zmlyc3QgYW5kIGFkZCBvcHRpbWl6YXRpb25zIG9uIHRvcC4KPj4KPiBPaywgSSB3aWxsIHN0YXJ0
IGZyb20gaGVyZSBmb3IgdGhlIG5leHQgcmV2aXNpb24uCj4KPj4+IE5vdyBldmVyeSBlbGVtZW50
IG5lZWRzIHRvIHN0b3JlIHRoZSBwcmV2aW91cyBhZGRyZXNzIGFsc28sIHNvIFZpcnRRdWV1ZQo+
Pj4gY2FuIGNvbnN1bWUgdGhlIGVsZW1lbnRzIHByb3Blcmx5LiBUaGlzIGFkZHMgYSBsaXR0bGUg
b3ZlcmhlYWQgcGVyIFZRCj4+PiBlbGVtZW50LCBoYXZpbmcgdG8gYWxsb2NhdGUgbW9yZSBtZW1v
cnkgdG8gc3Rhc2ggdGhlbS4gQXMgYSBwb3NzaWJsZQo+Pj4gb3B0aW1pemF0aW9uLCB0aGlzIGFs
bG9jYXRpb24gY291bGQgYmUgYXZvaWRlZCBpZiB0aGUgZGVzY3JpcHRvciBpcyBub3QKPj4+IGEg
Y2hhaW4gYnV0IGEgc2luZ2xlIG9uZSwgYnV0IHRoaXMgaXMgbGVmdCB1bmRvbmUuCj4+Pgo+Pj4g
Q2hlY2tpbmcgYWxzbyBmb3Igdmhvc3Rfc2V0X2lvdGxiX2NhbGxiYWNrIHRvIHNlbmQgdXNlZCBy
aW5nIHJlbWFwcGluZy4KPj4+IFRoaXMgaXMgb25seSBuZWVkZWQgZm9yIGtlcm5lbCwgYW5kIHdv
dWxkIHByaW50IGFuIGVycm9yIGluIGNhc2Ugb2YKPj4+IHZob3N0IGRldmljZXMgd2l0aCBpdHMg
b3duIG1hcHBpbmcgKHZkcGEpLgo+Pj4KPj4+IFRoaXMgY291bGQgY2hhbmdlIGZvciBvdGhlciBj
YWxsYmFjaywgbGlrZSBjaGVja2luZyBmb3IKPj4+IHZob3N0X2ZvcmNlX2lvbW11LCBlbmFibGVf
Y3VzdG9tX2lvbW11LCBvciBhbm90aGVyLiBBbm90aGVyIG9wdGlvbiBjb3VsZAo+Pj4gYmUgdG8s
IGF0IGxlYXN0LCBleHRyYWN0IHRoZSBjaGVjayBvZiAiaXMgbWFwKHVzZWQsIHdyaXRhYmxlKSBu
ZWVkZWQ/Igo+Pj4gaW4gYW5vdGhlciBmdW5jdGlvbi4gQnV0IGF0IHRoZSBtb21lbnQganVzdCBj
b3B5IHRoZSBjaGVjayB1c2VkIGluCj4+PiB2aG9zdF9kZXZfc3RhcnQgaGVyZS4KPj4+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+IC0t
LQo+Pj4gICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8IDEzNCArKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLQo+Pj4gICAgaHcvdmlydGlvL3Zob3N0LmMgICAgICAgICAg
ICAgICAgICB8ICAyOSArKysrKy0tCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDE0NSBpbnNlcnRp
b25zKCspLCAxOCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVl
LmMKPj4+IGluZGV4IDkzNGQzYmIyN2IuLmE5MmRhOTc5ZDEgMTAwNjQ0Cj4+PiAtLS0gYS9ody92
aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5jCj4+PiBAQCAtMTAsMTIgKzEwLDE5IEBACj4+PiAgICAjaW5jbHVk
ZSAiaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCIKPj4+ICAgICNpbmNsdWRlICJo
dy92aXJ0aW8vdmhvc3QuaCIKPj4+ICAgICNpbmNsdWRlICJody92aXJ0aW8vdmlydGlvLWFjY2Vz
cy5oIgo+Pj4gKyNpbmNsdWRlICJody92aXJ0aW8vdmhvc3QtaW92YS10cmVlLmgiCj4+Pgo+Pj4g
ICAgI2luY2x1ZGUgInN0YW5kYXJkLWhlYWRlcnMvbGludXgvdmhvc3RfdHlwZXMuaCIKPj4+Cj4+
PiAgICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCIKPj4+ICAgICNpbmNsdWRlICJxZW11
L21haW4tbG9vcC5oIgo+Pj4KPj4+ICt0eXBlZGVmIHN0cnVjdCBTVlFFbGVtZW50IHsKPj4+ICsg
ICAgVmlydFF1ZXVlRWxlbWVudCBlbGVtOwo+Pj4gKyAgICB2b2lkICoqaW5fc2dfc3Rhc2g7Cj4+
PiArICAgIHZvaWQgKipvdXRfc2dfc3Rhc2g7Cj4+Cj4+IEFueSByZWFzb24gZm9yIHRoZSB0cmlj
ayBsaWtlIHRoaXM/Cj4+Cj4+IENhbiB3ZSBzaW1wbHkgdXNlIGlvdmVjIGFuZCBpb3ZfY29weSgp
IGhlcmU/Cj4+Cj4gQXQgdGhlIG1vbWVudCB0aGUgZGV2aWNlIHdyaXRlcyB0aGUgYnVmZmVyIGRp
cmVjdGx5IHRvIHRoZSBndWVzdCdzCj4gbWVtb3J5LCBhbmQgU1ZRIG9ubHkgdHJhbnNsYXRlcyB0
aGUgZGVzY3JpcHRvci4gSW4gdGhpcyBzY2VuYXJpbywKPiB0aGVyZSB3b3VsZCBiZSBubyBuZWVk
IGZvciBpb3ZfY29weSwgaXNuJ3QgaXQ/CgoKSXQgZGVwZW5kcyBvbiB3aGljaCBraW5kcyBvZiB0
cmFuc2xhdGlvbiB5b3UgdXNlZC4KCklmIEkgcmVhZCB0aGUgY29kZSBjb3JyZWN0bHksIHN0YXNo
IGlzIHVzZWQgZm9yIHN0b3JpbmcgSFZBcyBhZnRlciB0aGUgCkhWQS0+SU9WQSB0cmFuc2xhdGlv
bi4KClRoaXMgbG9va3MgZXhhY3RseSB0aGUgd29yayBvZiBpb3YgKGFuZCBkbyB3ZSBndWFyYW50
ZWUgdGhlIHRoZXJlIHdpbGwgCmJlIGEgMToxIHRyYW5zbGF0aW9uPykKCkFuZCBpZiB0aGUgbWFw
cGluZyBpcyAxOjEgeW91IGNhbiBzaW1wbHkgdXNlIGlvdl9jb3B5KCkuCgpCdXQgdGhpcyB3b250
JyBiZSBhIG9wdGlvbiBpZiB3ZSB3aWxsIGFsd2F5cyB1c2UgaW92YSBhbGxvY2F0b3IuCgoKPgo+
IFRoZSByZWFzb24gZm9yIHN0YXNoIGFuZCB1bnN0YXNoIHRoZW0gd2FzIHRvIGFsbG93IHRoZSAx
OjEgbWFwcGluZwo+IHdpdGggcWVtdSBtZW1vcnkgYW5kIElPTU1VIGFuZCBpb3ZhIGFsbG9jYXRv
ciB0byB3b3JrIHdpdGggbGVzcwo+IGNoYW5nZXMsIEluIHBhcnRpY3VsYXIsIHRoZSByZWFzb24g
Zm9yIHVuc3Rhc2ggaXMgdGhhdCB2aXJ0cXVldWVfZmlsbCwKPiBleHBlY3RzIHFlbXUgcG9pbnRl
cnMgdG8gc2V0IHRoZSBndWVzdCBtZW1vcnkgcGFnZSBhcyBkaXJ0eSBpbgo+IHZpcnRxdWV1ZV91
bm1hcF9zZy0+ZG1hX21lbW9yeV91bm1hcC4KPgo+IE5vdyBJIHRoaW5rIHRoYXQganVzdCBzdG9y
aW5nIHRoZSBpb3ZhIGFkZHJlc3MgZnJvbSB0aGUgYWxsb2NhdG9yIGluIGEKPiBzZXBhcmF0ZWQg
ZmllbGQgYW5kIHVzaW5nIGEgd3JhcHBlciB0byBnZXQgdGhlIElPVkEgYWRkcmVzc2VzIGluIFNW
UQo+IHdvdWxkIGJlIGEgYmV0dGVyIGlkZWEsIHNvIEkgd291bGQgY2hhbmdlIHRvIHRoaXMgaWYg
ZXZlcnlvbmUgYWdyZWVzLgoKCkkgYWdyZWUuCgpUaGFua3MKCgo+Cj4gVGhhbmtzIQo+Cj4+IFRo
YW5rcwo+Pgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
