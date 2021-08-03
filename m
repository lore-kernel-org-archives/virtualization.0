Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027DC4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 07:46:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAA960BD3
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 07:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BAA960BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D3C760771;
	Tue,  3 Aug 2021 07:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6T4yIGzQBJKm; Tue,  3 Aug 2021 07:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BA9D1605DF;
	Tue,  3 Aug 2021 07:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88BAAC0010;
	Tue,  3 Aug 2021 07:46:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46A57C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E77482F4F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 35i6kzRorrHr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:46:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DA2882F14
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627976777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnfVPSk/HizDyO3JxuKbaXMtEKJY0iQR8Nsy47TDxzw=;
 b=Bpsu45Ybojy5IW/zbVw51aw0UoshLyYz/zslIIq47NQmWavNeHmSuU1B820LIGExiovOGC
 H/Bzs/5A0ZEyoNceeH0zK7XzWJnl7KeNXqu+OpjsIPcRtKzhUnNPQNeX9Otx6M+xFyQeOw
 7deMkja8Slm0OpuvQ3css35pKR0QCPY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-kbcogyeVMGCCXTiBFETHcQ-1; Tue, 03 Aug 2021 03:46:14 -0400
X-MC-Unique: kbcogyeVMGCCXTiBFETHcQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 lx12-20020a17090b4b0cb0290176d6de7ddbso18955419pjb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 00:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GnfVPSk/HizDyO3JxuKbaXMtEKJY0iQR8Nsy47TDxzw=;
 b=lIOs/PPu5rS4lIqRUFWGMKP03C3VYL9QhdDjg9/9LT8wkUe8VmsyKAhvDQZOB7twY5
 LNeif5mqCsO8wbVJhgEeEuoX3k1FJNz77HIz0pd1/HeR+lkB6dgtoHU39l+McF6C0p2u
 DsynKao3Da6VMT1XDf3fwrvHaVZmO6d+kiUWfX68/KuhrnGvknYWXsvH9Os87xIWMblb
 70RWl1XytxkAdWU7xAS9Dh8S3Vs0R77DUzsPeq3NrIEAwsj21Fyzdi7btgKNyumb79+G
 WzrwJ+5Gsmlirr3UA2heSvsAyGwWPcd0D/6/kH8pgwDSSCaCWrSj87ot17+oo+LzeMQS
 fl+g==
X-Gm-Message-State: AOAM531pHmiZuuJ+F2Jlz2e6eeUKYyo53jpv0dd1b42MNrHDyNuFK7mA
 bZEnG3u2U0O87Z8W8jQ+DYWvKQxFwQCZ2rbZWP+RiVQGhdAkrPJ2FRkvRr/8pgh5wnJxsPBQoPn
 rm4yHWa0kzhpepubLiaAFRYbjacl/8/a63up9dx4XNQ==
X-Received: by 2002:a17:90a:7065:: with SMTP id
 f92mr3190640pjk.16.1627976773356; 
 Tue, 03 Aug 2021 00:46:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEvOW/oPitztnM44QtOEHatfCeA16JROutkQDb3a25VjV+JgBNuHrwDZ3buALcITz8Iapu0g==
X-Received: by 2002:a17:90a:7065:: with SMTP id
 f92mr3190595pjk.16.1627976773095; 
 Tue, 03 Aug 2021 00:46:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f1sm7278948pfk.115.2021.08.03.00.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 00:46:12 -0700 (PDT)
Subject: Re: [PATCH v10 02/17] file: Export receive_fd() to modules
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a0ab081a-db06-6b7a-b22e-4ace96a5c7db@redhat.com>
Date: Tue, 3 Aug 2021 15:45:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-3-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IEV4cG9ydCByZWNlaXZl
X2ZkKCkgc28gdGhhdCBzb21lIG1vZHVsZXMgY2FuIHVzZQo+IGl0IHRvIHBhc3MgZmlsZSBkZXNj
cmlwdG9yIGJldHdlZW4gcHJvY2Vzc2VzIHdpdGhvdXQKPiBtaXNzaW5nIGFueSBzZWN1cml0eSBz
dHVmZnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNl
LmNvbT4KPiAtLS0KPiAgIGZzL2ZpbGUuYyAgICAgICAgICAgIHwgNiArKysrKysKPiAgIGluY2x1
ZGUvbGludXgvZmlsZS5oIHwgNyArKystLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9mcy9maWxlLmMgYi9mcy9m
aWxlLmMKPiBpbmRleCA4NmRjOTk1NmFmMzIuLjIxMGU1NDA2NzJhYSAxMDA2NDQKPiAtLS0gYS9m
cy9maWxlLmMKPiArKysgYi9mcy9maWxlLmMKPiBAQCAtMTEzNCw2ICsxMTM0LDEyIEBAIGludCBy
ZWNlaXZlX2ZkX3JlcGxhY2UoaW50IG5ld19mZCwgc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVk
IGludCBvX2ZsYWdzKQo+ICAgCXJldHVybiBuZXdfZmQ7Cj4gICB9Cj4gICAKPiAraW50IHJlY2Vp
dmVfZmQoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBvX2ZsYWdzKQo+ICt7Cj4gKwly
ZXR1cm4gX19yZWNlaXZlX2ZkKGZpbGUsIE5VTEwsIG9fZmxhZ3MpOwoKCkFueSByZWFzb24gdGhh
dCByZWNlaXZlX2ZkX3VzZXIoKSBjYW4gbGl2ZSBpbiB0aGUgZmlsZS5oPwoKVGhhbmtzCgoKPiAr
fQo+ICtFWFBPUlRfU1lNQk9MX0dQTChyZWNlaXZlX2ZkKTsKPiArCj4gICBzdGF0aWMgaW50IGtz
eXNfZHVwMyh1bnNpZ25lZCBpbnQgb2xkZmQsIHVuc2lnbmVkIGludCBuZXdmZCwgaW50IGZsYWdz
KQo+ICAgewo+ICAgCWludCBlcnIgPSAtRUJBREY7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvZmlsZS5oIGIvaW5jbHVkZS9saW51eC9maWxlLmgKPiBpbmRleCAyZGUyZTQ2MTNkN2IuLjUx
ZTgzMGI0ZmUzYSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZpbGUuaAo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvZmlsZS5oCj4gQEAgLTk0LDYgKzk0LDkgQEAgZXh0ZXJuIHZvaWQgZmRfaW5z
dGFsbCh1bnNpZ25lZCBpbnQgZmQsIHN0cnVjdCBmaWxlICpmaWxlKTsKPiAgIAo+ICAgZXh0ZXJu
IGludCBfX3JlY2VpdmVfZmQoc3RydWN0IGZpbGUgKmZpbGUsIGludCBfX3VzZXIgKnVmZCwKPiAg
IAkJCXVuc2lnbmVkIGludCBvX2ZsYWdzKTsKPiArCj4gK2V4dGVybiBpbnQgcmVjZWl2ZV9mZChz
dHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IG9fZmxhZ3MpOwo+ICsKPiAgIHN0YXRpYyBp
bmxpbmUgaW50IHJlY2VpdmVfZmRfdXNlcihzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IF9fdXNlciAq
dWZkLAo+ICAgCQkJCSAgdW5zaWduZWQgaW50IG9fZmxhZ3MpCj4gICB7Cj4gQEAgLTEwMSwxMCAr
MTA0LDYgQEAgc3RhdGljIGlubGluZSBpbnQgcmVjZWl2ZV9mZF91c2VyKHN0cnVjdCBmaWxlICpm
aWxlLCBpbnQgX191c2VyICp1ZmQsCj4gICAJCXJldHVybiAtRUZBVUxUOwo+ICAgCXJldHVybiBf
X3JlY2VpdmVfZmQoZmlsZSwgdWZkLCBvX2ZsYWdzKTsKPiAgIH0KPiAtc3RhdGljIGlubGluZSBp
bnQgcmVjZWl2ZV9mZChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IG9fZmxhZ3MpCj4g
LXsKPiAtCXJldHVybiBfX3JlY2VpdmVfZmQoZmlsZSwgTlVMTCwgb19mbGFncyk7Cj4gLX0KPiAg
IGludCByZWNlaXZlX2ZkX3JlcGxhY2UoaW50IG5ld19mZCwgc3RydWN0IGZpbGUgKmZpbGUsIHVu
c2lnbmVkIGludCBvX2ZsYWdzKTsKPiAgIAo+ICAgZXh0ZXJuIHZvaWQgZmx1c2hfZGVsYXllZF9m
cHV0KHZvaWQpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
