Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4238EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 06:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D535380C0D;
	Mon, 17 Jan 2022 06:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2cUWXwm7cRwr; Mon, 17 Jan 2022 06:48:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EF1280BF9;
	Mon, 17 Jan 2022 06:48:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 316EBC0039;
	Mon, 17 Jan 2022 06:48:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E9F9C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DA6E6061B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KrLMW8DThf7u
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:48:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22FC860615
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642402080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCmzKllbX3SIjaXydQOKPtJ4w089XM+8yWzlxM8Ci1M=;
 b=KFSyseNclgOvbBSg2cbMHp0Dmq3SstEYBSQIURmcfeMMx0n14VG/nTc4MHf4VkXIiOMRaA
 /OTz1Xm/kgAoWQh1ss7cyCl3UPFyQqgq8OpwzW3QrSSKDk7ZXUm59LPBMRy3rIFYKMhd2L
 VbRn1vl6ncXuUv1EHa3SL4aInAusxsk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-0ZiYZPgTNCWwdNOByhJnBQ-1; Mon, 17 Jan 2022 01:47:59 -0500
X-MC-Unique: 0ZiYZPgTNCWwdNOByhJnBQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 q4-20020aa78424000000b004c022bd294eso5680494pfn.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jan 2022 22:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iCmzKllbX3SIjaXydQOKPtJ4w089XM+8yWzlxM8Ci1M=;
 b=MyYIDotYQiJOuX/0pw8M+pQ1o+56NP0BUjIlrYclqh7QYuhboGB54qbj1v0B/hxQjI
 LQvbmVTeeyNnNxBLBXzyJfGlwoPyKWZCQOWYJlBh67EJWSVfDdNgrcxKkOtgL6RmqxZi
 7XoS6IU5Ss8rOJ9qHIDAb3huYKz5aNSuJ500wxaqIlaHVTr5A8tWyE1YiayCQgoo4eA0
 KFLYZdr62+GqeprXGRifYQV2Q/htrurwRY+9qU4syIHegYVhq57yJfnvbcftLGUtAUBL
 BEql6St4jph/h0VEBEywLUUatKRo42vFMf5qFzGv2SZUkTtUAXWQQdQIy3H6LsCzOfuN
 vTpQ==
X-Gm-Message-State: AOAM531Z8x/1pIXo+BB7WMNa8pG8wR1mqnwaNQDZ7TC4UqBk2IFyoIzC
 8euFIY4abY4F8NhlVrkf1GhRHAOOiogqiWExZwKr40XNKV4fM12MuuOnZVruhlpDbAYpUibpi6D
 2nZS4g4FblY+HG0DwQIjfCmAZ9T/fj1xWRpj20ngomA==
X-Received: by 2002:a17:90a:247:: with SMTP id
 t7mr32864397pje.198.1642402077883; 
 Sun, 16 Jan 2022 22:47:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKUBB8PHYL3YH18s5/KqvKADTloIEAaueOXJaVISJKNLLmUwkzmvJwRZp57AF32LW6V2yMwg==
X-Received: by 2002:a17:90a:247:: with SMTP id
 t7mr32864386pje.198.1642402077668; 
 Sun, 16 Jan 2022 22:47:57 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i4sm11490947pjj.30.2022.01.16.22.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jan 2022 22:47:57 -0800 (PST)
Message-ID: <e67611ea-fb61-6647-18ae-fa7a13e01625@redhat.com>
Date: Mon, 17 Jan 2022 14:47:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] vdpa: factor out vdpa_set_features_unlocked for
 vdpa internal use
To: Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
 <1642206481-30721-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1642206481-30721-2-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com
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

CuWcqCAyMDIyLzEvMTUg5LiK5Y2IODoyNywgU2ktV2VpIExpdSDlhpnpgZM6Cj4gTm8gZnVuY3Rp
b25hbCBjaGFuZ2UgaW50cm9kdWNlZC4gdmRwYSBidXMgZHJpdmVyIHN1Y2ggYXMgdmlydGlvX3Zk
cGEKPiBvciB2aG9zdF92ZHBhIGlzIG5vdCBzdXBwb3NlZCB0byB0YWtlIGNhcmUgb2YgdGhlIGxv
Y2tpbmcgZm9yIGNvcmUKPiBieSBpdHMgb3duLiBUaGUgbG9ja2VkIEFQSSB2ZHBhX3NldF9mZWF0
dXJlcyBzaG91bGQgc3VmZmljZSB0aGUKPiBidXMgZHJpdmVyJ3MgbmVlZC4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPiBSZXZpZXdlZC1ieTog
RWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgICAgICAgICAg
fCAgMiArLQo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICB8ICAyICstCj4gICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwgIDIgKy0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5o
ICAgICAgICAgfCAxOCArKysrKysrKysrKystLS0tLS0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTUg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+IGluZGV4IDk4NDZjOWQuLjFlYTUyNTQg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92
ZHBhLmMKPiBAQCAtMzkzLDcgKzM5Myw3IEBAIHN0YXRpYyB2b2lkIHZkcGFfZ2V0X2NvbmZpZ191
bmxvY2tlZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4gICAJICogSWYgaXQgZG9lcyBoYXBw
ZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+ICAgCSAqLwo+ICAgCWlmICghdmRldi0+ZmVh
dHVyZXNfdmFsaWQpCj4gLQkJdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCwgdHJ1ZSk7Cj4gKwkJ
dmRwYV9zZXRfZmVhdHVyZXNfdW5sb2NrZWQodmRldiwgMCk7Cj4gICAJb3BzLT5nZXRfY29uZmln
KHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+ICAgfQo+ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCA4NTE1Mzk4Li5l
YzUyNDllIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPiBAQCAtMjg2LDcgKzI4Niw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3Zk
cGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQgX191c2VyICpmZWF0dXJl
cCkKPiAgIAlpZiAoY29weV9mcm9tX3VzZXIoJmZlYXR1cmVzLCBmZWF0dXJlcCwgc2l6ZW9mKGZl
YXR1cmVzKSkpCj4gICAJCXJldHVybiAtRUZBVUxUOwo+ICAgCj4gLQlpZiAodmRwYV9zZXRfZmVh
dHVyZXModmRwYSwgZmVhdHVyZXMsIGZhbHNlKSkKPiArCWlmICh2ZHBhX3NldF9mZWF0dXJlcyh2
ZHBhLCBmZWF0dXJlcykpCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gICAJcmV0dXJuIDA7
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fdmRwYS5jCj4gaW5kZXggNzc2N2E3Zi4uNzY1MDQ1NSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3ZkcGEuYwo+IEBAIC0zMTcsNyArMzE3LDcgQEAgc3RhdGljIGludCB2aXJ0aW9fdmRwYV9m
aW5hbGl6ZV9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAkvKiBHaXZl
IHZpcnRpb19yaW5nIGEgY2hhbmNlIHRvIGFjY2VwdCBmZWF0dXJlcy4gKi8KPiAgIAl2cmluZ190
cmFuc3BvcnRfZmVhdHVyZXModmRldik7Cj4gICAKPiAtCXJldHVybiB2ZHBhX3NldF9mZWF0dXJl
cyh2ZHBhLCB2ZGV2LT5mZWF0dXJlcywgZmFsc2UpOwo+ICsJcmV0dXJuIHZkcGFfc2V0X2ZlYXR1
cmVzKHZkcGEsIHZkZXYtPmZlYXR1cmVzKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGNvbnN0IGNo
YXIgKnZpcnRpb192ZHBhX2J1c19uYW1lKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4g
aW5kZXggMmRlNDQyZS4uNzIxMDg5YiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEu
aAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTQwMSwxOCArNDAxLDI0IEBAIHN0
YXRpYyBpbmxpbmUgaW50IHZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ICAg
CXJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGlubGluZSBpbnQgdmRwYV9zZXRfZmVh
dHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMsIGJvb2wgbG9ja2Vk
KQo+ICtzdGF0aWMgaW5saW5lIGludCB2ZHBhX3NldF9mZWF0dXJlc191bmxvY2tlZChzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiAgIHsKPiAgIAljb25zdCBzdHJ1Y3Qg
dmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4gICAJaW50IHJldDsKPiAgIAo+
IC0JaWYgKCFsb2NrZWQpCj4gLQkJbXV0ZXhfbG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+IC0KPiAg
IAl2ZGV2LT5mZWF0dXJlc192YWxpZCA9IHRydWU7Cj4gICAJcmV0ID0gb3BzLT5zZXRfZHJpdmVy
X2ZlYXR1cmVzKHZkZXYsIGZlYXR1cmVzKTsKPiAtCWlmICghbG9ja2VkKQo+IC0JCW11dGV4X3Vu
bG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+ICsKPiArCXJldHVybiByZXQ7Cj4gK30KPiArCj4gK3N0
YXRpYyBpbmxpbmUgaW50IHZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdTY0IGZlYXR1cmVzKQo+ICt7Cj4gKwlpbnQgcmV0Owo+ICsKPiArCW11dGV4X2xvY2soJnZk
ZXYtPmNmX211dGV4KTsKPiArCXJldCA9IHZkcGFfc2V0X2ZlYXR1cmVzX3VubG9ja2VkKHZkZXYs
IGZlYXR1cmVzKTsKPiArCW11dGV4X3VubG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+ICAgCj4gICAJ
cmV0dXJuIHJldDsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
