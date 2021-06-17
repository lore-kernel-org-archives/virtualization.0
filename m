Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA14C2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:58:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05CC613CE
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05CC613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6ADD83DB7;
	Thu, 17 Jun 2021 06:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ccKLCuIoV80v; Thu, 17 Jun 2021 06:58:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DA22831DA;
	Thu, 17 Jun 2021 06:58:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C2B7C000D;
	Thu, 17 Jun 2021 06:58:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2363C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9748B4021E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EPIomzSEk-jz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26C1C401EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623913127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOaHdq19h0FHSg5bZ7nKKung5JqY0zRI7wk+b6EfG4M=;
 b=Wm1J0GSQE+gTwtSKw6+ox5SY4OIAp+47miW3uBSoawh00mXxk9GEsF+S3AmSkk2nwZO4cM
 W+1F4JE2M+FcIgvdR1xOmh8hpwVNJphjDrCdsKmCk8sQlZNIOpiQoUSpupqqjnUsFv5td2
 6JgfvQznCsIXw6l8sV09s6sFf7u78Jk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-7LEc1ps0O_SeGUAteVRYvQ-1; Thu, 17 Jun 2021 02:58:46 -0400
X-MC-Unique: 7LEc1ps0O_SeGUAteVRYvQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 k193-20020a633dca0000b029021ff326b222so3167771pga.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 23:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oOaHdq19h0FHSg5bZ7nKKung5JqY0zRI7wk+b6EfG4M=;
 b=Qq7+0zdL1sMvjzz1++0J64pop4k/WkH1NfxCJb634vJ4y3sE8wdB2ThxowicXPZ4JX
 ndUNhploQubdNvDUec4IuQMXPlxcO7dOFgxnYm1m+OKoJVgMKl7hFIolMXYSlPYfPO9/
 Jmr2Ah48fuGiwOn5mXDH3Xa7BaQemnnehjtoGNjtaGNia63AkjTzkaectzAcjbETTtgc
 Lp4Q2sDJHARyLNBPoWul5971RjVJIdRD6Knq1z+un09Fl4hExrh1QlEzGFHgrQTh4rK2
 f7ZW4Ui0nsqsBXJrVO7FPaYAWotDW9qPG0cSlcudY1UvzDs+Dwh+RoUWFWBkndOZAVQ+
 AZsA==
X-Gm-Message-State: AOAM5314AySktkjGGiMMk2rYaOIOqvUzhBivwEZbURiB1kfMhyZWi5Dj
 QTWB3A5tk91LBC1sdSgMgzAAMl5kcSXnHJ7PUTH9+Vjc7e2dtwyG2U7YbbrPzxG3iOO4p6dbBx+
 1cE0h1VwcJLPsua79XyaGJhxEE1fJbHYy7mWgi7eH0A==
X-Received: by 2002:a63:7c08:: with SMTP id x8mr3610834pgc.184.1623913125093; 
 Wed, 16 Jun 2021 23:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwUSnD5cuh7xbAATrzKhJmHrpLZfoxOlAvgZTAR0bzrEOjJocAZWmX4wUY/0QaEbPCp+cKsg==
X-Received: by 2002:a63:7c08:: with SMTP id x8mr3610801pgc.184.1623913124900; 
 Wed, 16 Jun 2021 23:58:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j10sm930961pjz.36.2021.06.16.23.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 23:58:44 -0700 (PDT)
Subject: Re: [PATCH net-next v5 13/15] virtio-net: support AF_XDP zc rx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1623911825.4660118-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a8f79a9d-1328-f5e8-167b-4eda844c52ca@redhat.com>
Date: Thu, 17 Jun 2021 14:58:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623911825.4660118-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Melnychenko <andrew@daynix.com>,
 Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
 yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust.li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

CuWcqCAyMDIxLzYvMTcg5LiL5Y2IMjozNywgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBUaHUsIDE3
IEp1biAyMDIxIDE0OjAzOjI5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjEvNi8xNyDkuIvljYgxOjUzLCBYdWFuIFpodW8g5YaZ6YGTOgo+
Pj4gT24gVGh1LCAxNyBKdW4gMjAyMSAxMToyMzo1MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjEvNi8xMCDkuIvljYg0OjIyLCBYdWFu
IFpodW8g5YaZ6YGTOgo+Pj4+PiBDb21wYXJlZCB0byB0aGUgY2FzZSBvZiB4c2sgdHgsIHRoZSBj
YXNlIG9mIHhzayB6YyByeCBpcyBtb3JlCj4+Pj4+IGNvbXBsaWNhdGVkLgo+Pj4+Pgo+Pj4+PiBX
aGVuIHdlIHByb2Nlc3MgdGhlIGJ1ZiByZWNlaXZlZCBieSB2cSwgd2UgbWF5IGVuY291bnRlciBv
cmRpbmFyeQo+Pj4+PiBidWZmZXJzLCBvciB4c2sgYnVmZmVycy4gV2hhdCBtYWtlcyB0aGUgc2l0
dWF0aW9uIG1vcmUgY29tcGxpY2F0ZWQgaXMKPj4+Pj4gdGhhdCBpbiB0aGUgY2FzZSBvZiBtZXJn
ZWFibGUsIHdoZW4gbnVtX2J1ZmZlciA+IDEsIHdlIG1heSBzdGlsbAo+Pj4+PiBlbmNvdW50ZXIg
dGhlIGNhc2Ugd2hlcmUgeHNrIGJ1ZmZlciBpcyBtaXhlZCB3aXRoIG9yZGluYXJ5IGJ1ZmZlci4K
Pj4+Pj4KPj4+Pj4gQW5vdGhlciB0aGluZyB0aGF0IG1ha2VzIHRoZSBzaXR1YXRpb24gbW9yZSBj
b21wbGljYXRlZCBpcyB0aGF0IHdoZW4gd2UKPj4+Pj4gZ2V0IGFuIHhzayBidWZmZXIgZnJvbSB2
cSwgdGhlIHhzayBib3VuZCB0byB0aGlzIHhzayBidWZmZXIgbWF5IGhhdmUKPj4+Pj4gYmVlbiB1
bmJvdW5kLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPgo+Pj4+IFRoaXMgaXMgc29tZWhvdyBzaW1pbGFyIHRvIHRoZSBjYXNl
IG9mIHR4IHdoZXJlIHdlIGRvbid0IGhhdmUgcGVyIHZxIHJlc2V0Lgo+Pj4+Cj4+Pj4gWy4uLl0K
Pj4+Pgo+Pj4+PiAtCWlmICh2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMpCj4+Pj4+ICsJaWYgKGlzX3hz
a19jdHgoY3R4KSkKPj4+Pj4gKwkJc2tiID0gcmVjZWl2ZV94c2soZGV2LCB2aSwgcnEsIGJ1Ziwg
bGVuLCB4ZHBfeG1pdCwgc3RhdHMpOwo+Pj4+PiArCWVsc2UgaWYgKHZpLT5tZXJnZWFibGVfcnhf
YnVmcykKPj4+Pj4gICAgIAkJc2tiID0gcmVjZWl2ZV9tZXJnZWFibGUoZGV2LCB2aSwgcnEsIGJ1
ZiwgY3R4LCBsZW4sIHhkcF94bWl0LAo+Pj4+PiAgICAgCQkJCQlzdGF0cyk7Cj4+Pj4+ICAgICAJ
ZWxzZSBpZiAodmktPmJpZ19wYWNrZXRzKQo+Pj4+PiBAQCAtMTE3NSw2ICsxMjk2LDE0IEBAIHN0
YXRpYyBib29sIHRyeV9maWxsX3JlY3Yoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCBy
ZWNlaXZlX3F1ZXVlICpycSwKPj4+Pj4gICAgIAlpbnQgZXJyOwo+Pj4+PiAgICAgCWJvb2wgb29t
Owo+Pj4+Pgo+Pj4+PiArCS8qIEJlY2F1c2UgdmlydGlvLW5ldCBkb2VzIG5vdCB5ZXQgc3VwcG9y
dCBmbG93IGRpcmVjdCwKPj4+PiBOb3RlIHRoYXQgdGhpcyBpcyBub3QgdGhlIGNhc2UgYW55IG1v
cmUuIFJTUyBoYXMgYmVlbiBzdXBwb3J0ZWQgYnkKPj4+PiB2aXJ0aW8gc3BlYyBhbmQgcWVtdS92
aG9zdC90YXAgbm93LiBXZSBqdXN0IG5lZWQgc29tZSB3b3JrIG9uIHRoZQo+Pj4+IHZpcnRpby1u
ZXQgZHJpdmVyIHBhcnQgKGUuZyB0aGUgZXRob29sIGludGVyZmFjZSkuCj4+PiBPaCwgYXJlIHRo
ZXJlIGFueSBwbGFucz8gV2hvIGlzIGRvaW5nIHRoaXMgd29yaywgY2FuIEkgaGVscD8KPj4KPj4g
UWVtdSBhbmQgc3BlYyBoYXMgc3VwcG9ydCBSU1MuCj4+Cj4+IFRBUCBzdXBwb3J0IGlzIHJlYWR5
IHZpYSBzdGVlcmluZyBlQlBGIHByb2dyYW0sIHlvdSBjYW4gdHJ5IHRvIHBsYXkgaXQKPj4gd2l0
aCBjdXJyZW50IHFlbXUgbWFzdGVyLgo+Pgo+PiBUaGUgb25seSB0aGluZyBtaXNzZWQgaXMgdGhl
IExpbnV4IGRyaXZlciwgSSB0aGluayBZdXJpIG9yIEFuZHJldyBpcwo+PiB3b3JraW5nIG9uIHRo
aXMuCj4gSSBmZWVsIHRoYXQgaW4gdGhlIGNhc2Ugb2YgeHNrLCB0aGUgZmxvdyBkaXJlY3RvciBp
cyBtb3JlIGFwcHJvcHJpYXRlLgo+Cj4gVXNlcnMgbWF5IHN0aWxsIHdhbnQgdG8gYWxsb2NhdGUg
cGFja2V0cyB0byBhIGNlcnRhaW4gY2hhbm5lbCBiYXNlZCBvbgo+IGluZm9ybWF0aW9uIHN1Y2gg
YXMgcG9ydC9pcC90Y3AvdWRwLCBhbmQgdGhlbiB4c2sgd2lsbCBwcm9jZXNzIHRoZW0uCj4KPiBJ
IHdpbGwgdHJ5IHRvIHB1c2ggdGhlIGZsb3cgZGlyZWN0b3IgdG8gdGhlIHNwZWMuCgoKVGhhdCB3
b3VsZCBiZSBmaW5lLiBGb3IgdGhlIGJhY2tlbmQgaW1wbGVtZW50YXRpb24sIGl0IGNvdWxkIHN0
aWxsIGJlIAppbXBsZW1lbnRlZCB2aWEgc3RlZXJpbmcgZUJQRi4KClRoYW5rcwoKCj4KPiBUaGFu
a3MuCj4KPj4gVGhhbmtzCj4+Cj4+Cj4+PiBUaGFua3MuCj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+
Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
