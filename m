Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A589FC47080
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:17:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F136139A
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F136139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20CB583C65;
	Tue,  1 Jun 2021 06:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35RLExSawnro; Tue,  1 Jun 2021 06:17:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46F2183C61;
	Tue,  1 Jun 2021 06:17:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20673C000D;
	Tue,  1 Jun 2021 06:17:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F792C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D4F24042D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ufjBwchfbcLL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:17:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6DFE402D5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622528256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enybrQ/dLg4DwTtxWWLNNtD7Qa94WazVTzOjB6L1kbs=;
 b=A5xZcCpLQb3eebYPuMHq4jqv3xt5FmebAD+4DaD+188FZuoP9czKe6/Cwr2/fa8d++X4Ad
 CaipsdiVKR5lyaRooqnQXyxzGcO8/8hkZqcNF+v+BK/CbL4pJi1O6nJ1REwCN7Hkj47D05
 eiYe2N1FLQOMalDXRC8LtJF59UEMZBs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-jFJeDdjINgeoTWVqipw9Ew-1; Tue, 01 Jun 2021 02:17:35 -0400
X-MC-Unique: jFJeDdjINgeoTWVqipw9Ew-1
Received: by mail-pg1-f197.google.com with SMTP id
 30-20020a630a1e0000b029021a63d9d4cdso8311817pgk.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 23:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=enybrQ/dLg4DwTtxWWLNNtD7Qa94WazVTzOjB6L1kbs=;
 b=kg5FNWVgp08prAz5tO0eUP7/JHyORJf18AvIpINLkw4vpqd69ns7WvodQKDaPekEdG
 /E2rwaEmO3cAhF42dxkw70hqVw9178TNWJMmood2py4Tt3jowhu5ZQMMQMut+pQkEUVF
 JB5fI0UmnPr8bsf4OKsz6P/L5T+j5pxgDbnWBsqtQ/mOqpD/2HdnNEPG3nBW75C+lm2b
 HpO+yizGTTCl1v1aAy6l6iSJSb3M7mf9gqoSa+X3YzO8xFClt5dvb5n4bSMDNojTPvc0
 ej9+SfePyo8FHK+3mPJ3LzYEdPNuSjbNPMv4dIQuDyw04hpjztbwcTJ26ojQT89kAstH
 X0/A==
X-Gm-Message-State: AOAM530IPiOtaRKeidL/05NF3pbQx3tpH16kjcLAwXMeTlN9uNIKFEPK
 4AbA7t6DJUF6tN8ULs98P1bSa46o1+0OdVr2lWfrzfoUnc6h3T4GzqZwY/moBR2evkNebS9wawS
 G0DYkVh5VuIWhNS1ZE076bhphARx6z0cy0m1v4gZq1g==
X-Received: by 2002:a62:1547:0:b029:2e9:f6d7:776a with SMTP id
 68-20020a6215470000b02902e9f6d7776amr2589748pfv.14.1622528253933; 
 Mon, 31 May 2021 23:17:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyARS+L1qKbMKnCk9SWMeyLcmqdjqkmCDtc4ng4Xld6vqUKHV0CxJ/aenivQw4SLHkcmQismQ==
X-Received: by 2002:a62:1547:0:b029:2e9:f6d7:776a with SMTP id
 68-20020a6215470000b02902e9f6d7776amr2589722pfv.14.1622528253625; 
 Mon, 31 May 2021 23:17:33 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m1sm13661936pgd.78.2021.05.31.23.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 23:17:32 -0700 (PDT)
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1622527177.2087624-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <24aee726-83a9-9741-23bb-1f8be0e775e6@redhat.com>
Date: Tue, 1 Jun 2021 14:17:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622527177.2087624-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIxLzYvMSDkuIvljYgxOjU5LCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIFR1ZSwgMSBK
dW4gMjAyMSAxMToyNzoxMiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IOWcqCAyMDIxLzYvMSDkuIrljYgxMTowOCwgWHVhbiBaaHVvIOWGmemBkzoKPj4+
IE9uIFR1ZSwgMSBKdW4gMjAyMSAxMTowMzozNyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjEvNS8zMSDkuIvljYg2OjU4LCBYdWFuIFpo
dW8g5YaZ6YGTOgo+Pj4+PiBPbiBNb24sIDMxIE1heSAyMDIxIDE0OjEwOjU1ICswODAwLCBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IOWcqCAyMDIxLzUvMTQg
5LiL5Y2IMTE6MTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4+Pj4+Pj4gSW4gdGhlIGNhc2Ugb2YgbWVy
Z2UsIHRoZSBwYWdlIHBhc3NlZCBpbnRvIHBhZ2VfdG9fc2tiKCkgbWF5IGJlIGEgaGVhZAo+Pj4+
Pj4+IHBhZ2UsIG5vdCB0aGUgcGFnZSB3aGVyZSB0aGUgY3VycmVudCBkYXRhIGlzIGxvY2F0ZWQu
Cj4+Pj4+PiBJIGRvbid0IGdldCBob3cgdGhpcyBjYW4gaGFwcGVuPwo+Pj4+Pj4KPj4+Pj4+IE1h
eWJlIHlvdSBjYW4gZXhwbGFpbiBhIGxpdHRsZSBiaXQgbW9yZT8KPj4+Pj4+Cj4+Pj4+PiByZWNl
aXZlX21lcmdlYWJsZSgpIGNhbGwgcGFnZV90b19za2IoKSBpbiB0d28gcGxhY2VzOgo+Pj4+Pj4K
Pj4+Pj4+IDEpIFhEUF9QQVNTIGZvciBsaW5lYXJpemVkIHBhZ2UgLCBpbiB0aGlzIGNhc2Ugd2Ug
dXNlIHhkcF9wYWdlCj4+Pj4+PiAyKSBwYWdlX3RvX3NrYigpIGZvciAibm9ybWFsIiBwYWdlLCBp
biB0aGlzIGNhc2UgdGhlIHBhZ2UgY29udGFpbnMgdGhlIGRhdGEKPj4+Pj4gVGhlIG9mZnNldCBt
YXkgYmUgZ3JlYXRlciB0aGFuIFBBR0VfU0laRSwgYmVjYXVzZSBwYWdlIGlzIG9idGFpbmVkIGJ5
Cj4+Pj4+IHZpcnRfdG9faGVhZF9wYWdlKCksIG5vdCB0aGUgcGFnZSB3aGVyZSBidWYgaXMgbG9j
YXRlZC4gQW5kICJvZmZzZXQiIGlzIHRoZSBvZmZzZXQKPj4+Pj4gb2YgYnVmIHJlbGF0aXZlIHRv
IHBhZ2UuCj4+Pj4+Cj4+Pj4+IAl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gb2Zmc2V0Owo+
Pj4+Pgo+Pj4+PiBJbiB0aGlzIGNhc2UsIHRoZSB0YWlscm9vbSBtdXN0IGJlIGxlc3MgdGhhbiAw
LiBBbHRob3VnaCB0aGVyZSBtYXkgYmUgZW5vdWdoCj4+Pj4+IGNvbnRlbnQgb24gdGhpcyBwYWdl
IHRvIHNhdmUgc2tiX3NoYXJlZF9pbmZvLgo+Pj4+IEludGVyZXN0aW5nLCBJIHRoaW5rIHdlIGRv
bid0IHVzZSBjb21wb3VuZCBwYWdlcyBmb3IgdmlydGlvLW5ldC4gKFdlCj4+Pj4gZG9uJ3QgZGVm
aW5lIFNLQl9GUkFHX1BBR0VfT1JERVIpLgo+Pj4+Cj4+Pj4gQW0gSSB3cm9uZz8KPj4+IEl0IHNl
ZW1zIHRvIG1lIHRoYXQgaXQgc2VlbXMgdG8gYmUgYSBmaXhlZCBzZXR0aW5nLCBub3QgZm9yIHVz
IHRvIGNvbmZpZ3VyZQo+Pj4gaW5kZXBlbmRlbnRseQo+Pgo+PiBMb29rcyBsaWtlIHlvdSBhcmUg
cmlnaHQuCj4+Cj4+IFNlZSBjb21tZW50cyBiZWxvdy4KPj4KPj4KPj4+IFRoYW5rcy4KPj4+Cj4+
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4+Cj4+PiBuZXQv
c29jay5jCj4+Pgo+Pj4gI2RlZmluZSBTS0JfRlJBR19QQUdFX09SREVSCWdldF9vcmRlcigzMjc2
OCkKPj4+IERFRklORV9TVEFUSUNfS0VZX0ZBTFNFKG5ldF9oaWdoX29yZGVyX2FsbG9jX2Rpc2Fi
bGVfa2V5KTsKPj4+Cj4+PiAvKioKPj4+ICAgICogc2tiX3BhZ2VfZnJhZ19yZWZpbGwgLSBjaGVj
ayB0aGF0IGEgcGFnZV9mcmFnIGNvbnRhaW5zIGVub3VnaCByb29tCj4+PiAgICAqIEBzejogbWlu
aW11bSBzaXplIG9mIHRoZSBmcmFnbWVudCB3ZSB3YW50IHRvIGdldAo+Pj4gICAgKiBAcGZyYWc6
IHBvaW50ZXIgdG8gcGFnZV9mcmFnCj4+PiAgICAqIEBnZnA6IHByaW9yaXR5IGZvciBtZW1vcnkg
YWxsb2NhdGlvbgo+Pj4gICAgKgo+Pj4gICAgKiBOb3RlOiBXaGlsZSB0aGlzIGFsbG9jYXRvciB0
cmllcyB0byB1c2UgaGlnaCBvcmRlciBwYWdlcywgdGhlcmUgaXMKPj4+ICAgICogbm8gZ3VhcmFu
dGVlIHRoYXQgYWxsb2NhdGlvbnMgc3VjY2VlZC4gVGhlcmVmb3JlLCBAc3ogTVVTVCBiZQo+Pj4g
ICAgKiBsZXNzIG9yIGVxdWFsIHRoYW4gUEFHRV9TSVpFLgo+Pj4gICAgKi8KPj4+IGJvb2wgc2ti
X3BhZ2VfZnJhZ19yZWZpbGwodW5zaWduZWQgaW50IHN6LCBzdHJ1Y3QgcGFnZV9mcmFnICpwZnJh
ZywgZ2ZwX3QgZ2ZwKQo+Pj4gewo+Pj4gCWlmIChwZnJhZy0+cGFnZSkgewo+Pj4gCQlpZiAocGFn
ZV9yZWZfY291bnQocGZyYWctPnBhZ2UpID09IDEpIHsKPj4+IAkJCXBmcmFnLT5vZmZzZXQgPSAw
Owo+Pj4gCQkJcmV0dXJuIHRydWU7Cj4+PiAJCX0KPj4+IAkJaWYgKHBmcmFnLT5vZmZzZXQgKyBz
eiA8PSBwZnJhZy0+c2l6ZSkKPj4+IAkJCXJldHVybiB0cnVlOwo+Pj4gCQlwdXRfcGFnZShwZnJh
Zy0+cGFnZSk7Cj4+PiAJfQo+Pj4KPj4+IAlwZnJhZy0+b2Zmc2V0ID0gMDsKPj4+IAlpZiAoU0tC
X0ZSQUdfUEFHRV9PUkRFUiAmJgo+Pj4gCSAgICAhc3RhdGljX2JyYW5jaF91bmxpa2VseSgmbmV0
X2hpZ2hfb3JkZXJfYWxsb2NfZGlzYWJsZV9rZXkpKSB7Cj4+PiAJCS8qIEF2b2lkIGRpcmVjdCBy
ZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8gd2FrZSAqLwo+Pj4gCQlwZnJhZy0+cGFnZSA9IGFs
bG9jX3BhZ2VzKChnZnAgJiB+X19HRlBfRElSRUNUX1JFQ0xBSU0pIHwKPj4+IAkJCQkJICBfX0dG
UF9DT01QIHwgX19HRlBfTk9XQVJOIHwKPj4+IAkJCQkJICBfX0dGUF9OT1JFVFJZLAo+Pj4gCQkJ
CQkgIFNLQl9GUkFHX1BBR0VfT1JERVIpOwo+Pj4gCQlpZiAobGlrZWx5KHBmcmFnLT5wYWdlKSkg
ewo+Pj4gCQkJcGZyYWctPnNpemUgPSBQQUdFX1NJWkUgPDwgU0tCX0ZSQUdfUEFHRV9PUkRFUjsK
Pj4+IAkJCXJldHVybiB0cnVlOwo+Pj4gCQl9Cj4+PiAJfQo+Pj4gCXBmcmFnLT5wYWdlID0gYWxs
b2NfcGFnZShnZnApOwo+Pj4gCWlmIChsaWtlbHkocGZyYWctPnBhZ2UpKSB7Cj4+PiAJCXBmcmFn
LT5zaXplID0gUEFHRV9TSVpFOwo+Pj4gCQlyZXR1cm4gdHJ1ZTsKPj4+IAl9Cj4+PiAJcmV0dXJu
IGZhbHNlOwo+Pj4gfQo+Pj4gRVhQT1JUX1NZTUJPTChza2JfcGFnZV9mcmFnX3JlZmlsbCk7Cj4+
Pgo+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cj4+Pj4+IFRoYW5rcy4KPj4+Pj4KPj4+Pj4+IFRo
YW5rcwo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4gU28gd2hlbiB0cnlpbmcgdG8KPj4+Pj4+PiBnZXQg
dGhlIGJ1ZiB3aGVyZSB0aGUgZGF0YSBpcyBsb2NhdGVkLCB5b3Ugc2hvdWxkIGRpcmVjdGx5IHVz
ZSB0aGUKPj4+Pj4+PiBwb2ludGVyKHApIHRvIGdldCB0aGUgYWRkcmVzcyBjb3JyZXNwb25kaW5n
IHRvIHRoZSBwYWdlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gQXQgdGhlIHNhbWUgdGltZSwgdGhlIG9mZnNl
dCBvZiB0aGUgZGF0YSBpbiB0aGUgcGFnZSBzaG91bGQgYWxzbyBiZQo+Pj4+Pj4+IG9idGFpbmVk
IHVzaW5nIG9mZnNldF9pbl9wYWdlKCkuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGlzIHBhdGNoIHNvbHZl
cyB0aGlzIHByb2JsZW0uIEJ1dCBpZiB5b3UgZG9u4oCZdCB1c2UgdGhpcyBwYXRjaCwgdGhlCj4+
Pj4+Pj4gb3JpZ2luYWwgY29kZSBjYW4gYWxzbyBydW4sIGJlY2F1c2UgaWYgdGhlIHBhZ2UgaXMg
bm90IHRoZSBwYWdlIG9mIHRoZQo+Pj4+Pj4+IGN1cnJlbnQgZGF0YSwgdGhlIGNhbGN1bGF0ZWQg
dGFpbHJvb20gd2lsbCBiZSBsZXNzIHRoYW4gMCwgYW5kIHdpbGwgbm90Cj4+Pj4+Pj4gZW50ZXIg
dGhlIGxvZ2ljIG9mIGJ1aWxkX3NrYigpIC4gVGhlIHNpZ25pZmljYW5jZSBvZiB0aGlzIHBhdGNo
IGlzIHRvCj4+Pj4+Pj4gbW9kaWZ5IHRoaXMgbG9naWNhbCBwcm9ibGVtLCBhbGxvd2luZyBtb3Jl
IHNpdHVhdGlvbnMgdG8gdXNlCj4+Pj4+Pj4gYnVpbGRfc2tiKCkuCj4+Pj4+Pj4KPj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4+
Pj4+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pj4+Pj4+
IC0tLQo+Pj4+Pj4+ICAgICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgOCArKysrKystLQo+
Pj4+Pj4+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+PiBpbmRleCAzZTQ2YzEyZGRlMDguLjA3
M2ZlYzRjMGRmMSAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
Pj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+PiBAQCAtNDA3LDgg
KzQwNywxMiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLAo+Pj4+Pj4+ICAgICAgCQkgKiBzZWUgYWRkX3JlY3ZidWZfbWVyZ2VhYmxl
KCkgKyBnZXRfbWVyZ2VhYmxlX2J1Zl9sZW4oKQo+Pj4+Pj4+ICAgICAgCQkgKi8KPj4+Pj4+PiAg
ICAgIAkJdHJ1ZXNpemUgPSBQQUdFX1NJWkU7Cj4+Pj4+Pj4gLQkJdGFpbHJvb20gPSB0cnVlc2l6
ZSAtIGxlbiAtIG9mZnNldDsKPj4+Pj4+PiAtCQlidWYgPSBwYWdlX2FkZHJlc3MocGFnZSk7Cj4+
Pj4+Pj4gKwo+Pj4+Pj4+ICsJCS8qIHBhZ2UgbWF5YmUgaGVhZCBwYWdlLCBzbyB3ZSBzaG91bGQg
Z2V0IHRoZSBidWYgYnkgcCwgbm90IHRoZQo+Pj4+Pj4+ICsJCSAqIHBhZ2UKPj4+Pj4+PiArCQkg
Ki8KPj4+Pj4+PiArCQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gb2Zmc2V0X2luX3BhZ2Uo
cCk7Cj4+Cj4+IEkgd29uZGVyIHdoeSBvZmZzZXRfaW5fcGFnZShwKSBpcyBjb3JyZWN0PyBJIGd1
ZXNzIGl0IHNob3VsZCBiZToKPj4KPj4gdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRy
b29tOwo+Pgo+PiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGJ1ZmZlciBpcyBub3QgbmVjZXNzYXJp
bHkgYWxsb2NhdGVkIGF0IHRoZSBwYWdlCj4+IGJvdW5kYXJ5Lgo+IEluIG15IHVuZGVyc3RhbmRp
bmcsIG9mZnNldF9pbl9wYWdlKHApIGlzIHRoZSBvZmZzZXQgb2YgcCBpbiB0aGUgcGFnZSB3aGVy
ZSBpdAo+IGlzIGxvY2F0ZWQuIEluIHRoaXMgY2FzZSwgdGhlIHR3byBzaG91bGQgYmUgZXF1YWwu
CgoKSSB0aGluayBub3QsIGlmIHRoZSBmcmFnIGlzIG5vdCBwYWdlIGFsaWduZWQuIG9mZnNldF9p
bl9wYWdlKHApIGRvZXNuJ3QgCmVxdWFsIHRvIGhlYWRyb29tLgoKQ29uc2lkZXIgdGhlIGNhc2Ug
dGhhdCB0aGUgZnJhZyBzdGFydCBmcm9tIHBhZ2Ugb2Zmc2V0IDE1MDAuCgoKPiAgIFRoaXMgaGFz
IG5vdGhpbmcgdG8gZG8gd2l0aAo+IHdoaWNoIHBhZ2UgaXMgYWxsb2NhdGVkLgo+Cj4gT2YgY291
cnNlIEkgdGhpbmsgdXNpbmcgaGVhZHJvb20gaXMgYSBnb29kIGlkZWEsIGFuZCBpdCBpcyBzZW1h
bnRpY2FsbHkgYmV0dGVyLgo+Cj4gVGhhbmtzLgoKClRoYW5rcwoKCj4KPj4gVGhhbmtzCj4+Cj4+
Cj4+Pj4+Pj4gKwkJYnVmID0gKGNoYXIgKikoKHVuc2lnbmVkIGxvbmcpcCAmIFBBR0VfTUFTSyk7
Cj4+Pj4+Pj4gICAgICAJfSBlbHNlIHsKPj4+Pj4+PiAgICAgIAkJdGFpbHJvb20gPSB0cnVlc2l6
ZSAtIGxlbjsKPj4+Pj4+PiAgICAgIAkJYnVmID0gcDsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
