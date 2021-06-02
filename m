Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C8BC4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 09:52:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6EC611CC
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 09:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6EC611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48DB783A4E;
	Wed,  2 Jun 2021 09:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AWAG8Ga8k9S7; Wed,  2 Jun 2021 09:52:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 712BE839DB;
	Wed,  2 Jun 2021 09:52:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42CC2C000D;
	Wed,  2 Jun 2021 09:52:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6008BC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D21A839DC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C4qAHVH88YWq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:52:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A6D9839DB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622627525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zg+84APsNS25yQpVptn8SNrnNPDbi/ATETB/fjwsP80=;
 b=b3WYjPBeY9GX+hEYNJvFpzhbT3qLzq6c0OMt9WlkSrJ3XQSJAZb6K9Vjkn3OQnCrVnJtBt
 MrXH9BqspkkVjKVHNoS9ZCuSh4U06KXc/IA1Dgmuu//qAvGSoX6bnQPDSB/Sk5g95ezxEN
 8bhWjnoKExNRQZ13EJRCRjog6nReVjU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-XJ4ejOPhO9-xLh0QeRhfmA-1; Wed, 02 Jun 2021 05:52:04 -0400
X-MC-Unique: XJ4ejOPhO9-xLh0QeRhfmA-1
Received: by mail-pf1-f198.google.com with SMTP id
 i13-20020aa78b4d0000b02902ea019ef670so1226831pfd.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 02:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Zg+84APsNS25yQpVptn8SNrnNPDbi/ATETB/fjwsP80=;
 b=TrayDd/QtHffP5lTWV+vJ3jLfZHPhqIzfheKjCwPAehJN+GBj7x8zStV9rx2BzJJRT
 1IGn8D7HQXv1b2Fr66Yhzhki2mrs8q9VOWl7jA2jOgAJ7/VfU2V/LLNA7Br5rLZBskYL
 +KeK8YwFNbuIC0ykkLICIWYPs8p/K0pqE1WNShy1oDs7kCJmVchxRD1ro5kdIbQoiN/y
 lhfWUuzX8/HXfUdwpK106dvk1lhaH+dtKtZtTBSWUVi0yfpT4myOPJMZHRi9GfPuc+h3
 anls4Havakq3Il4bujwHmbXjJJHWhFCsqS6QjBHiSRx+iJJTJeIDjgwWkIM6NFeWyt7d
 y+Tg==
X-Gm-Message-State: AOAM532qPkco87l3bd2AJcy/yxSpK5Tr8z4iFnyl7Ka35owDyS/nFkfI
 7wjSi5n8DOtHK8fQ4uTunCYAs+EE9QrpthwxAe7Bu+xAKORXe75wJQhzn1m1gQb8vavvFBsTyyz
 8hOxQk04Dcevh0sdLG0AxVTQS6vGsXe+/z5t2dHK8SdNsz34npydY3EOsx0NQ12H+uoCiHwZZne
 A2kVAr9EHII1077wUy3w==
X-Received: by 2002:a63:f615:: with SMTP id m21mr33231363pgh.282.1622627523025; 
 Wed, 02 Jun 2021 02:52:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4EOfE9UMVuhU5wQ9lpQsAAs49arqW8IAxCW/pRWiW4JPhjKI3zMbvc+Lss7x1/7mR2BYvGw==
X-Received: by 2002:a63:f615:: with SMTP id m21mr33231333pgh.282.1622627522723; 
 Wed, 02 Jun 2021 02:52:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c130sm14872136pfc.51.2021.06.02.02.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 02:52:02 -0700 (PDT)
Subject: Re: [RFC v3 25/29] vhost: Add custom IOTLB translations to SVQ
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-26-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ae560866-4598-3157-a0cb-e0e79b4dca42@redhat.com>
Date: Wed, 2 Jun 2021 17:51:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210519162903.1172366-26-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzUvMjAg5LiK5Y2IMTI6MjgsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBVc2Ug
dHJhbnNsYXRpb25zIGFkZGVkIGluIElPVkFSZXZlcnNlTWFwcyBpbiBTVlEgaWYgdGhlIHZob3N0
IGRldmljZQo+IGRvZXMgbm90IHN1cHBvcnQgdGhlIG1hcHBpbmcgb2YgdGhlIGZ1bGwgcWVtdSdz
IHZpcnR1YWwgYWRkcmVzcyBzcGFjZS4KPiBJbiBvdGhlciBjYXNlcywgU2hhZG93IFZpcnRxdWV1
ZSBzdGlsbCB1c2VzIHRoZSBxZW11J3MgdmlydHVhbCBhZGRyZXNzCj4gb2YgdGhlIGJ1ZmZlciBw
b2ludGVkIGJ5IHRoZSBkZXNjcmlwdG9yLCB3aGljaCBoYXMgYmVlbiB0cmFuc2xhdGVkCj4gYWxy
ZWFkeSBieSBxZW11J3MgVmlydFF1ZXVlIG1hY2hpbmVyeS4KCgpJJ2Qgc2F5IGxldCBzdGljayB0
byBhIHNpbmdsZSBraW5kIG9mIHRyYW5zbGF0aW9uIChpb3ZhIGFsbG9jYXRvcikgdGhhdCAKd29y
a3MgZm9yIGFsbCB0aGUgY2FzZXMgZmlyc3QgYW5kIGFkZCBvcHRpbWl6YXRpb25zIG9uIHRvcC4K
Cgo+Cj4gTm93IGV2ZXJ5IGVsZW1lbnQgbmVlZHMgdG8gc3RvcmUgdGhlIHByZXZpb3VzIGFkZHJl
c3MgYWxzbywgc28gVmlydFF1ZXVlCj4gY2FuIGNvbnN1bWUgdGhlIGVsZW1lbnRzIHByb3Blcmx5
LiBUaGlzIGFkZHMgYSBsaXR0bGUgb3ZlcmhlYWQgcGVyIFZRCj4gZWxlbWVudCwgaGF2aW5nIHRv
IGFsbG9jYXRlIG1vcmUgbWVtb3J5IHRvIHN0YXNoIHRoZW0uIEFzIGEgcG9zc2libGUKPiBvcHRp
bWl6YXRpb24sIHRoaXMgYWxsb2NhdGlvbiBjb3VsZCBiZSBhdm9pZGVkIGlmIHRoZSBkZXNjcmlw
dG9yIGlzIG5vdAo+IGEgY2hhaW4gYnV0IGEgc2luZ2xlIG9uZSwgYnV0IHRoaXMgaXMgbGVmdCB1
bmRvbmUuCj4KPiBDaGVja2luZyBhbHNvIGZvciB2aG9zdF9zZXRfaW90bGJfY2FsbGJhY2sgdG8g
c2VuZCB1c2VkIHJpbmcgcmVtYXBwaW5nLgo+IFRoaXMgaXMgb25seSBuZWVkZWQgZm9yIGtlcm5l
bCwgYW5kIHdvdWxkIHByaW50IGFuIGVycm9yIGluIGNhc2Ugb2YKPiB2aG9zdCBkZXZpY2VzIHdp
dGggaXRzIG93biBtYXBwaW5nICh2ZHBhKS4KPgo+IFRoaXMgY291bGQgY2hhbmdlIGZvciBvdGhl
ciBjYWxsYmFjaywgbGlrZSBjaGVja2luZyBmb3IKPiB2aG9zdF9mb3JjZV9pb21tdSwgZW5hYmxl
X2N1c3RvbV9pb21tdSwgb3IgYW5vdGhlci4gQW5vdGhlciBvcHRpb24gY291bGQKPiBiZSB0bywg
YXQgbGVhc3QsIGV4dHJhY3QgdGhlIGNoZWNrIG9mICJpcyBtYXAodXNlZCwgd3JpdGFibGUpIG5l
ZWRlZD8iCj4gaW4gYW5vdGhlciBmdW5jdGlvbi4gQnV0IGF0IHRoZSBtb21lbnQganVzdCBjb3B5
IHRoZSBjaGVjayB1c2VkIGluCj4gdmhvc3RfZGV2X3N0YXJ0IGhlcmUuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3L3Zp
cnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCAxMzQgKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0KPiAgIGh3L3ZpcnRpby92aG9zdC5jICAgICAgICAgICAgICAgICAgfCAgMjkgKysr
KystLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNDUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBi
L2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiBpbmRleCA5MzRkM2JiMjdiLi5h
OTJkYTk3OWQxIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVl
LmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTEwLDEy
ICsxMCwxOSBAQAo+ICAgI2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVl
LmgiCj4gICAjaW5jbHVkZSAiaHcvdmlydGlvL3Zob3N0LmgiCj4gICAjaW5jbHVkZSAiaHcvdmly
dGlvL3ZpcnRpby1hY2Nlc3MuaCIKPiArI2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC1pb3ZhLXRy
ZWUuaCIKPiAgIAo+ICAgI2luY2x1ZGUgInN0YW5kYXJkLWhlYWRlcnMvbGludXgvdmhvc3RfdHlw
ZXMuaCIKPiAgIAo+ICAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiCj4gICAjaW5jbHVk
ZSAicWVtdS9tYWluLWxvb3AuaCIKPiAgIAo+ICt0eXBlZGVmIHN0cnVjdCBTVlFFbGVtZW50IHsK
PiArICAgIFZpcnRRdWV1ZUVsZW1lbnQgZWxlbTsKPiArICAgIHZvaWQgKippbl9zZ19zdGFzaDsK
PiArICAgIHZvaWQgKipvdXRfc2dfc3Rhc2g7CgoKQW55IHJlYXNvbiBmb3IgdGhlIHRyaWNrIGxp
a2UgdGhpcz8KCkNhbiB3ZSBzaW1wbHkgdXNlIGlvdmVjIGFuZCBpb3ZfY29weSgpIGhlcmU/CgpU
aGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
