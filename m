Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4FC47096
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 03:00:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9DF6140A
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 03:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9DF6140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82EC8405F3;
	Fri,  4 Jun 2021 03:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lQ3dNYhSt0Io; Fri,  4 Jun 2021 03:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C53EA4010D;
	Fri,  4 Jun 2021 03:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A89C9C000D;
	Fri,  4 Jun 2021 03:00:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 140A2C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 03:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFABA83EC0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 03:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e5llO_Sz6BI0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 03:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3546083E6C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622775637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7/4MS6/UAZIaNxIFBPyQzBnfKTG+9XLJhdmv1C+xeQ=;
 b=aN5ep1Wb9t3RpnuenARQ5rrl5n7CMOtf0s+LsbMSyuoS1VFtYz9GDvfW3gdIfxD//eb+X6
 la0kFarFO3Bc/G4gYHrmqEfM/5slyP2jkUBP+rCFgiUtzlMW1Jdy48VAwBSRA/xRMjFVC+
 eNXqtijft1p2DjnzEuueucMhBfoD28Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-BF9bbaJ8NbugMOrLGXakYw-1; Thu, 03 Jun 2021 23:00:34 -0400
X-MC-Unique: BF9bbaJ8NbugMOrLGXakYw-1
Received: by mail-pj1-f72.google.com with SMTP id
 t8-20020a17090aba88b029016baed73c00so3126211pjr.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 20:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=h7/4MS6/UAZIaNxIFBPyQzBnfKTG+9XLJhdmv1C+xeQ=;
 b=QcJzgRQ7fyfeXWEsxJBj/yGc8uBzMse+VMhyqIH7QmL4eGKJh1npIGZyQ5FpnwzD7q
 S/C5h3K6/1r8UdkMBKDq2tRf2bhm+62mXjuvrjK2SQxljRjSyVzoJ4UKrOaIMfVf+wp4
 CpU4NfHJS4lWa86KE4ESJhV0KOsQw6trZcEMFnElCkvpo6Xjat+BSqhCjdK+5LD/jIyA
 utFDKjWzx+PFcxfD5bRIF69/BYpks9cuD2cCJfchq/BBHzOgGlBiKZs1/JfDqmD2DhfR
 /oBpRYXYDrUE6pO0Fyia0mifZ0d5SwNYTcWvrpB1RtfseLzxl2scC1LRrnvwSkU7lQz2
 M3XQ==
X-Gm-Message-State: AOAM530673KlK8LmWTtpLlbnuBYqkpMR8iZ1Nj3Qa2tiigvmuFNIFpxl
 cyZbqu0fxO6tGnrRfNFZy0bZk8s6WgwbrD6pJQXSLWvnELq0yd1GCVu9OwuzLGVwtPCvkH/BQw5
 q6MprAcm+mLzThGYxuAQGQnDHG9NH/p3BcdEJWiMq3w==
X-Received: by 2002:a17:90a:a395:: with SMTP id
 x21mr2476694pjp.63.1622775633145; 
 Thu, 03 Jun 2021 20:00:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxesy3zu14mg5kPb+7fRdWWOa2at1J+p0Hk3DlmS27KByrxCzwqi/z7jYjn+PTiQAlZCnXvMw==
X-Received: by 2002:a17:90a:a395:: with SMTP id
 x21mr2476666pjp.63.1622775632819; 
 Thu, 03 Jun 2021 20:00:32 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d12sm354020pfo.113.2021.06.03.20.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 20:00:32 -0700 (PDT)
Subject: Re: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1622773823.5042562-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e2ab6611-69fc-480e-f126-b69fecad5280@redhat.com>
Date: Fri, 4 Jun 2021 11:00:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622773823.5042562-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Corentin_No=c3=abl?= <corentin.noel@collabora.com>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
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

CuWcqCAyMDIxLzYvNCDkuIrljYgxMDozMCwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBGcmksIDQg
SnVuIDIwMjEgMTA6Mjg6NDEgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+PiDlnKggMjAyMS82LzQg5LiK5Y2IMTowOSwgWHVhbiBaaHVvIOWGmemBkzoKPj4+
IEluIHZpcnRpby1uZXQncyBsYXJnZSBwYWNrZXQgbW9kZSwgdGhlcmUgaXMgYSBob2xlIGluIHRo
ZSBzcGFjZSBiZWhpbmQKPj4+IGJ1Zi4KPj4KPj4gYmVmb3JlIHRoZSBidWYgYWN0dWFsbHkgb3Ig
YmVoaW5kIHRoZSB2bmV0IGhlYWRlcj8KPj4KPj4KPj4+ICAgICAgIGhkcl9wYWRkZWRfbGVuIC0g
aGRyX2xlbgo+Pj4KPj4+IFdlIG11c3QgdGFrZSB0aGlzIGludG8gYWNjb3VudCB3aGVuIGNhbGN1
bGF0aW5nIHRhaWxyb29tLgo+Pj4KPj4+IFsgICA0NC41NDQzODVdIHNrYl9wdXQuY29sZCAobmV0
L2NvcmUvc2tidWZmLmM6NTI1NCAoZGlzY3JpbWluYXRvciAxKSBuZXQvY29yZS9za2J1ZmYuYzo1
MjUyIChkaXNjcmltaW5hdG9yIDEpKQo+Pj4gWyAgIDQ0LjU0NDg2NF0gcGFnZV90b19za2IgKGRy
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYzo0ODUpIFsgICA0NC41NDUzNjFdIHJlY2VpdmVfYnVmIChk
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6ODQ5IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxMTMx
KQo+Pj4gWyAgIDQ0LjU0NTg3MF0gPyBuZXRpZl9yZWNlaXZlX3NrYl9saXN0X2ludGVybmFsIChu
ZXQvY29yZS9kZXYuYzo1NzE0KQo+Pj4gWyAgIDQ0LjU0NjYyOF0gPyBkZXZfZ3JvX3JlY2VpdmUg
KG5ldC9jb3JlL2Rldi5jOjYxMDMpCj4+PiBbICAgNDQuNTQ3MTM1XSA/IG5hcGlfY29tcGxldGVf
ZG9uZSAoLi9pbmNsdWRlL2xpbnV4L2xpc3QuaDozNSBuZXQvY29yZS9kZXYuYzo1ODY3IG5ldC9j
b3JlL2Rldi5jOjU4NjIgbmV0L2NvcmUvZGV2LmM6NjU2NSkKPj4+IFsgICA0NC41NDc2NzJdIHZp
cnRuZXRfcG9sbCAoZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjE0MjcgZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jOjE1MjUpCj4+PiBbICAgNDQuNTQ4MjUxXSBfX25hcGlfcG9sbCAobmV0L2NvcmUv
ZGV2LmM6Njk4NSkKPj4+IFsgICA0NC41NDg3NDRdIG5ldF9yeF9hY3Rpb24gKG5ldC9jb3JlL2Rl
di5jOjcwNTQgbmV0L2NvcmUvZGV2LmM6NzEzOSkKPj4+IFsgICA0NC41NDkyNjRdIF9fZG9fc29m
dGlycSAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsLmg6MTkgLi9pbmNsdWRlL2xp
bnV4L2p1bXBfbGFiZWwuaDoyMDAgLi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9pcnEuaDoxNDIga2Vy
bmVsL3NvZnRpcnEuYzo1NjApCj4+PiBbICAgNDQuNTQ5NzYyXSBpcnFfZXhpdF9yY3UgKGtlcm5l
bC9zb2Z0aXJxLmM6NDMzIGtlcm5lbC9zb2Z0aXJxLmM6NjM3IGtlcm5lbC9zb2Z0aXJxLmM6NjQ5
KQo+Pj4gWyAgIDQ0LjU1MTM4NF0gY29tbW9uX2ludGVycnVwdCAoYXJjaC94ODYva2VybmVsL2ly
cS5jOjI0MCAoZGlzY3JpbWluYXRvciAxMykpCj4+PiBbICAgNDQuNTUxOTkxXSA/IGFzbV9jb21t
b25faW50ZXJydXB0ICguL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lkdGVudHJ5Lmg6NjM4KQo+Pj4g
WyAgIDQ0LjU1MjY1NF0gYXNtX2NvbW1vbl9pbnRlcnJ1cHQgKC4vYXJjaC94ODYvaW5jbHVkZS9h
c20vaWR0ZW50cnkuaDo2MzgpCj4+Pgo+Pj4gRml4ZXM6IGZiMzI4NTZiMTZhZCAoInZpcnRpby1u
ZXQ6IHBhZ2VfdG9fc2tiKCkgdXNlIGJ1aWxkX3NrYiB3aGVuIHRoZXJlJ3Mgc3VmZmljaWVudCB0
YWlscm9vbSIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+Pj4gUmVwb3J0ZWQtYnk6IENvcmVudGluIE5vw6tsIDxjb3JlbnRpbi5ub2Vs
QGNvbGxhYm9yYS5jb20+Cj4+PiBUZXN0ZWQtYnk6IENvcmVudGluIE5vw6tsIDxjb3JlbnRpbi5u
b2VsQGNvbGxhYm9yYS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyB8IDIgKy0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IGluZGV4IGZhNDA3ZWI4YjQ1Ny4uNzhhMDFjNzFhMTdj
IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+PiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IEBAIC00MDYsNyArNDA2LDcgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPj4+ICAgIAkg
KiBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoKSArIGdldF9tZXJnZWFibGVfYnVmX2xlbigpCj4+PiAg
ICAJICovCj4+PiAgICAJdHJ1ZXNpemUgPSBoZWFkcm9vbSA/IFBBR0VfU0laRSA6IHRydWVzaXpl
Owo+Pj4gLQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gaGVhZHJvb207Cj4+PiArCXRhaWxy
b29tID0gdHJ1ZXNpemUgLSBsZW4gLSBoZWFkcm9vbSAtIChoZHJfcGFkZGVkX2xlbiAtIGhkcl9s
ZW4pOwo+Pgo+PiBUaGUgcGF0Y2ggbG9va3MgY29ycmVjdCBhbmQgSSBzYXcgaXQgaGFzIGJlZW4g
bWVyZ2VkLgo+Pgo+PiBCdXQgSSBwcmVmZXIgdG8gZG8gdGhhdCBpbiByZWNlaXZlX2JpZygpIGlu
c3RlYWQgb2YgaGVyZS4KPj4KPj4gVGhhbmtzCj4gSG93Pwo+Cj4gY2hhbmdlIHRydWVzaXplIG9y
IGhlYWRyb29tPwo+Cj4gSSBkaWRuJ3QgZmluZCBhIGdvb2Qgd2F5LiBEbyB5b3UgaGF2ZSBhIGdv
b2Qgd2F5PwoKClNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmc/IFRoZSBBUEkgaXMgZGVzaWdu
ZWQgdG8gbGV0IHRoZSBjYWxsZXIgdG8gCnBhc3MgYSBjb3JyZWN0IGhlYWRyb29tIGluc3RlYWQg
b2YgZmlndXJlIGl0IG91dCBieSBpdHNlbGYuCgogwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNrX2J1
ZmYgKnNrYiA9CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZV90b19za2Iodmks
IHJxLCBwYWdlLCAwLCBsZW4sIFBBR0VfU0laRSwgdHJ1ZSwgMCwgCmhkcl9wYWRkZWRfbGVuIC0g
aGRyX2xlbik7CgpUaGFua3MKCgo+Cj4gVGhhbmtzLgo+Cj4+Cj4+Cj4+PiAgICAJYnVmID0gcCAt
IGhlYWRyb29tOwo+Pj4KPj4+ICAgIAlsZW4gLT0gaGRyX2xlbjsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
