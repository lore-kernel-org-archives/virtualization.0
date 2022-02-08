Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2620CC433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 02:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4AA560A77;
	Tue,  8 Feb 2022 02:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vab4jirxM9q2; Tue,  8 Feb 2022 02:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 57302607F6;
	Tue,  8 Feb 2022 02:58:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB29C0011;
	Tue,  8 Feb 2022 02:58:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6B12C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 958C760803
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMMJd2Ez6OeN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:58:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67667607F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644289134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iPL/OY2vKtxnnn4ofse5g3sqVcV7OwRhLLviSAEN2s=;
 b=fMhzR+yVHt4gd4D1q0IWiMTBk13qtyNdcjiiJQw+YlvHc4o6P1dH+drKz146yFEKCmwhu6
 8Z0sIdTJkG70x3TqEf7cJFyLHxxDrhDIPDluOADKbM6ayRYfXS/IPihd2yPzv/T7MoT5NT
 5KeCSRAJzq0jeKc2l3OvKJJQpUqxfP8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-gg2JN8xXNVOo6ZbhyqHouw-1; Mon, 07 Feb 2022 21:58:53 -0500
X-MC-Unique: gg2JN8xXNVOo6ZbhyqHouw-1
Received: by mail-pl1-f198.google.com with SMTP id
 p16-20020a170902a41000b0014992c5d56bso6544071plq.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 18:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1iPL/OY2vKtxnnn4ofse5g3sqVcV7OwRhLLviSAEN2s=;
 b=JFmMZelwqY9bAP5vRQga3ccP9AyORGGrcIRS5pOpFN1VZyuFwoY+29X+vVJmNR82Yu
 AjnKmDOdw+oKPmvz0+ve6XhbgXudjYCh1vgL5wS+y5+V/S6PM64hE/10xnd5uto6gWmt
 fSWaq+eaV9b6F0qKMulffJWQoclMy9WKLJBjPU8M1t8f0mHL1xYh32s4QDc0C7SVjVHp
 y31UQc05L10cNfxgsMiSDU6UzzweFu3hLg6WtXyO9ZtC1QTwSYHtiW/JEZgSB5cMBotb
 xMU/Z0dFsyPNskSH8JpWH3HsXys+d59dBMqEZbea/V6crZ0P8dqICE8H4IgkAI8gp5/7
 7tAQ==
X-Gm-Message-State: AOAM531jXZpcwNmNQ7j5rbfAY2qsx1Zp6JKwvbFR0wNItSet2OaT8zDJ
 Qv1t04XBNjETVpS0gt0HBmJUbAtFKOIl+vv0KvK5UxfJ1xiUiM38pryKvj9aUYvHRUzcPDFLt9k
 SNKl48c8p5+Lr1XFn+8zE61E+UoxlJCM/m0qFETXIEA==
X-Received: by 2002:a17:902:b583:: with SMTP id
 a3mr2677358pls.77.1644289131929; 
 Mon, 07 Feb 2022 18:58:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDaqEp6ylw0Kb/+6cBe2Mf1Qn8HvvlERmvET9tFW4bEroVdMmJC/V5b59ayI5l0Rjw7B7isA==
X-Received: by 2002:a17:902:b583:: with SMTP id
 a3mr2677336pls.77.1644289131628; 
 Mon, 07 Feb 2022 18:58:51 -0800 (PST)
Received: from [10.72.13.233] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r12sm9576072pgn.6.2022.02.07.18.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 18:58:51 -0800 (PST)
Message-ID: <b0debb2b-7548-c354-2128-2ddf56bf5c18@redhat.com>
Date: Tue, 8 Feb 2022 10:58:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 03/17] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1644218386.0457659-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1644218386.0457659-1-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzIvNyDkuIvljYgzOjE5LCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIE1vbiwgNyBG
ZWIgMjAyMiAxNDo0NTowMiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IOWcqCAyMDIyLzEvMjYg5LiL5Y2IMzozNSwgWHVhbiBaaHVvIOWGmemBkzoKPj4+
IFBlcmZvcm1pbmcgcmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8gdHdvIHN0ZXBzOgo+
Pj4KPj4+IDEuIHJlc2V0X3ZxOiByZXNldCBvbmUgdnEKPj4+IDIuIGVuYWJsZV9yZXNldF92cTog
cmUtZW5hYmxlIHRoZSByZXNldCBxdWV1ZQo+Pj4KPj4+IEluIHRoZSBmaXJzdCBzdGVwLCB0aGVz
ZSB0YXNrcyB3aWxsIGJlIGNvbXBsZXRlZDoKPj4+ICAgICAgIDEuIG5vdGlmeSB0aGUgaGFyZHdh
cmUgcXVldWUgdG8gcmVzZXQKPj4+ICAgICAgIDIuIHJlY3ljbGUgdGhlIGJ1ZmZlciBmcm9tIHZx
Cj4+PiAgICAgICAzLiByZWxlYXNlIHRoZSByaW5nIG9mIHRoZSB2cQo+Pj4KPj4+IFRoZSBzZWNv
bmQgc3RlcCBpcyBzaW1pbGFyIHRvIGZpbmQgdnFzLAo+Pgo+PiBOb3Qgc3VyZSwgc2luY2UgZmlu
ZF92cXMgd2lsbCB1c3VhbGx5IHRyeSB0byBhbGxvY2F0ZSBpbnRlcnJ1cHRzLgo+Pgo+Pgo+IFll
cy4KPgo+Cj4+PiAgICBwYXNzaW5nIHBhcmFtZXRlcnMgY2FsbGJhY2sgYW5kCj4+PiBuYW1lLCBl
dGMuIEJhc2VkIG9uIHRoZSBvcmlnaW5hbCB2cSwgdGhlIHJpbmcgaXMgcmUtYWxsb2NhdGVkIGFu
ZAo+Pj4gY29uZmlndXJlZCB0byB0aGUgYmFja2VuZC4KPj4KPj4gSSB3b25kZXIgd2hldGhlciB3
ZSByZWFsbHkgaGF2ZSBzdWNoIHJlcXVpcmVtZW50Lgo+Pgo+PiBGb3IgZXhhbXBsZSwgZG8gd2Ug
cmVhbGx5IGhhdmUgYSB1c2UgY2FzZSB0aGF0IG1heSBjaGFuZ2U6Cj4+Cj4+IHZxIGNhbGxiYWNr
LCBjdHgsIHJpbmdfbnVtIG9yIGV2ZW4gcmUtY3JlYXRlIHRoZSB2aXJ0cXVldWU/Cj4gMS4gdmly
dHF1ZXVlIGlzIG5vdCByZWNyZWF0ZWQKPiAyLiByaW5nX251bSBjYW4gYmUgdXNlZCB0byBtb2Rp
ZnkgcmluZyBudW0gYnkgZXRodG9vbCAtRwoKCkl0IGxvb2tzIHRvIG1lIHdlIGRvbid0IHN1cHBv
cnQgdGhpcyByaWdodCBub3cuCgoKPgo+IFRoZXJlIGlzIHJlYWxseSBubyBzY2VuZSB0byBtb2Rp
ZnkgdnEgY2FsbGJhY2ssIGN0eCwgbmFtZS4KPgo+IERvIHlvdSBtZWFuIHdlIHN0aWxsIHVzZSB0
aGUgb2xkIG9uZSBpbnN0ZWFkIG9mIGFkZGluZyB0aGVzZSBwYXJhbWV0ZXJzPwoKClllcywgSSB0
aGluayBmb3IgZHJpdmVyIHdlIG5lZWQgdG8gaW1wbGVtZW50IHRoZSBmdW5jdGlvbiB0aGF0IGlz
IG5lZWRlZCAKZm9yIHRoZSBmaXJzdCB1c2VyIChlLmcgQUZfWERQKS4gSWYgdGhlcmUncyBubyB1
c2UgY2FzZSwgd2UgY2FuIGxlYXZlIAp0aG9zZSBleHRlbnNpb24gZm9yIHRoZSBmdXR1cmUuCgpU
aGFua3MKCgo+Cj4gVGhhbmtzLgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gU28gYWRkIHR3byBjYWxs
YmFja3MgcmVzZXRfdnEsIGVuYWJsZV9yZXNldF92cSB0byBzdHJ1Y3QKPj4+IHZpcnRpb19jb25m
aWdfb3BzLgo+Pj4KPj4+IEFkZCBhIHN0cnVjdHVyZSBmb3IgcGFzc2luZyBwYXJhbWV0ZXJzLiBU
aGlzIHdpbGwgZmFjaWxpdGF0ZSBzdWJzZXF1ZW50Cj4+PiBleHBhbnNpb24gb2YgdGhlIHBhcmFt
ZXRlcnMgb2YgZW5hYmxlIHJlc2V0IHZxLgo+Pj4gVGhlcmUgaXMgY3VycmVudGx5IG9ubHkgb25l
IGRlZmF1bHQgZXh0ZW5kZWQgcGFyYW1ldGVyIHJpbmdfbnVtLgo+Pj4KPj4+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4+PiAtLS0KPj4+ICAg
IGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2Nv
bmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPj4+IGluZGV4IDRkMTA3YWQz
MTE0OS4uNTFkZDg0NjFkMWI2IDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9f
Y29uZmlnLmgKPj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4+PiBAQCAt
MTYsNiArMTYsNDQgQEAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uIHsKPj4+ICAgIAl1NjQgbGVu
Owo+Pj4gICAgfTsKPj4+Cj4+PiArdHlwZWRlZiB2b2lkIHZxX2NhbGxiYWNrX3Qoc3RydWN0IHZp
cnRxdWV1ZSAqKTsKPj4+ICsKPj4+ICsvKiB2aXJ0aW9fcmVzZXRfdnE6IHNwZWNpZnkgcGFyYW1l
dGVycyBmb3IgcXVldWVfcmVzZXQKPj4+ICsgKgo+Pj4gKyAqCXZkZXY6IHRoZSBkZXZpY2UKPj4+
ICsgKglxdWV1ZV9pbmRleDogdGhlIHF1ZXVlIGluZGV4Cj4+PiArICoKPj4+ICsgKglmcmVlX3Vu
dXNlZF9jYjogY2FsbGJhY2sgdG8gZnJlZSB1bnVzZWQgYnVmcwo+Pj4gKyAqCWRhdGE6IHVzZWQg
YnkgZnJlZV91bnVzZWRfY2IKPj4+ICsgKgo+Pj4gKyAqCWNhbGxiYWNrOiBjYWxsYmFjayBmb3Ig
dGhlIHZpcnRxdWV1ZSwgTlVMTCBmb3IgdnEgdGhhdCBkbyBub3QgbmVlZCBhCj4+PiArICoJICAg
ICAgICAgIGNhbGxiYWNrCj4+PiArICoJbmFtZTogdmlydHF1ZXVlIG5hbWVzIChtYWlubHkgZm9y
IGRlYnVnZ2luZyksIE5VTEwgZm9yIHZxIHVudXNlZCBieQo+Pj4gKyAqCSAgICAgIGRyaXZlcgo+
Pj4gKyAqCWN0eDogY3R4Cj4+PiArICoKPj4+ICsgKglyaW5nX251bTogc3BlY2lmeSByaW5nIG51
bSBmb3IgdGhlIHZxIHRvIGJlIHJlLWVuYWJsZWQuIDAgbWVhbnMgdXNlIHRoZQo+Pj4gKyAqCSAg
ICAgICAgICBkZWZhdWx0IHZhbHVlLiBNVVNUIGJlIGEgcG93ZXIgb2YgMi4KPj4+ICsgKi8KPj4+
ICtzdHJ1Y3QgdmlydGlvX3Jlc2V0X3ZxOwo+Pj4gK3R5cGVkZWYgdm9pZCB2cV9yZXNldF9jYWxs
YmFja190KHN0cnVjdCB2aXJ0aW9fcmVzZXRfdnEgKnBhcmFtLCB2b2lkICpidWYpOwo+Pj4gK3N0
cnVjdCB2aXJ0aW9fcmVzZXRfdnEgewo+Pj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldjsK
Pj4+ICsJdTE2IHF1ZXVlX2luZGV4Owo+Pj4gKwo+Pj4gKwkvKiByZXNldCB2cSBwYXJhbSAqLwo+
Pj4gKwl2cV9yZXNldF9jYWxsYmFja190ICpmcmVlX3VudXNlZF9jYjsKPj4+ICsJdm9pZCAqZGF0
YTsKPj4+ICsKPj4+ICsJLyogZW5hYmxlIHJlc2V0IHZxIHBhcmFtICovCj4+PiArCXZxX2NhbGxi
YWNrX3QgKmNhbGxiYWNrOwo+Pj4gKwljb25zdCBjaGFyICpuYW1lOwo+Pj4gKwljb25zdCBib29s
ICpjdHg7Cj4+PiArCj4+PiArCS8qIGV4dCBlbmFibGUgcmVzZXQgdnEgcGFyYW0gKi8KPj4+ICsJ
dTE2IHJpbmdfbnVtOwo+Pj4gK307Cj4+PiArCj4+PiAgICAvKioKPj4+ICAgICAqIHZpcnRpb19j
b25maWdfb3BzIC0gb3BlcmF0aW9ucyBmb3IgY29uZmlndXJpbmcgYSB2aXJ0aW8gZGV2aWNlCj4+
PiAgICAgKiBOb3RlOiBEbyBub3QgYXNzdW1lIHRoYXQgYSB0cmFuc3BvcnQgaW1wbGVtZW50cyBh
bGwgb2YgdGhlIG9wZXJhdGlvbnMKPj4+IEBAIC03NCw4ICsxMTIsOSBAQCBzdHJ1Y3QgdmlydGlv
X3NobV9yZWdpb24gewo+Pj4gICAgICogQHNldF92cV9hZmZpbml0eTogc2V0IHRoZSBhZmZpbml0
eSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFsKS4KPj4+ICAgICAqIEBnZXRfdnFfYWZmaW5pdHk6
IGdldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1ZXVlIChvcHRpb25hbCkuCj4+PiAgICAgKiBA
Z2V0X3NobV9yZWdpb246IGdldCBhIHNoYXJlZCBtZW1vcnkgcmVnaW9uIGJhc2VkIG9uIHRoZSBp
bmRleC4KPj4+ICsgKiBAcmVzZXRfdnE6IHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5Cj4+PiAr
ICogQGVuYWJsZV9yZXNldF92cTogZW5hYmxlIGEgcmVzZXQgcXVldWUKPj4+ICAgICAqLwo+Pj4g
LXR5cGVkZWYgdm9pZCB2cV9jYWxsYmFja190KHN0cnVjdCB2aXJ0cXVldWUgKik7Cj4+PiAgICBz
dHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+Pj4gICAgCXZvaWQgKCplbmFibGVfY2JzKShzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4+PiAgICAJdm9pZCAoKmdldCkoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIG9mZnNldCwKPj4+IEBAIC0xMDAsNiArMTM5LDggQEAg
c3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKPj4+ICAgIAkJCWludCBpbmRleCk7Cj4+PiAgICAJ
Ym9vbCAoKmdldF9zaG1fcmVnaW9uKShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPj4+ICAg
IAkJCSAgICAgICBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gKnJlZ2lvbiwgdTggaWQpOwo+Pj4g
KwlpbnQgKCpyZXNldF92cSkoc3RydWN0IHZpcnRpb19yZXNldF92cSAqcGFyYW0pOwo+Pj4gKwlz
dHJ1Y3QgdmlydHF1ZXVlICooKmVuYWJsZV9yZXNldF92cSkoc3RydWN0IHZpcnRpb19yZXNldF92
cSAqcGFyYW0pOwo+Pj4gICAgfTsKPj4+Cj4+PiAgICAvKiBJZiBkcml2ZXIgZGlkbid0IGFkdmVy
dGlzZSB0aGUgZmVhdHVyZSwgaXQgd2lsbCBuZXZlciBhcHBlYXIuICovCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
