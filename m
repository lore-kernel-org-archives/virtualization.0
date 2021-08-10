Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABCBC4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:10:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FAA60FC3
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80FAA60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42CD4607C7;
	Tue, 10 Aug 2021 03:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dK5VaG61ZbK; Tue, 10 Aug 2021 03:10:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E483560795;
	Tue, 10 Aug 2021 03:10:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9E34C0010;
	Tue, 10 Aug 2021 03:10:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC6AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4636681D67
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vrzKWrm1_1ri
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:10:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7BE081D4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628565026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oX2pkF9N16fnvpstzdQwpoUJiL0i5uUnc1l1ovj+dVc=;
 b=IktjuXlNzjm1wQU5hFPDY5OlGIIqYHMHgy3h56eJUNbT1w8SLwlNor0V5ag6OeAztVkECU
 Drpw6xfREn9+GtnuvElpwYOLlQ+rJo2QAtveqvuPna2jijWUowDT3qI9dNW8TPkW1ztEdZ
 F6kmwTRL2I2dEYScaqLJUyu56QR1PvE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-8N0z1awlO9GTzU59Hwsbeg-1; Mon, 09 Aug 2021 23:10:22 -0400
X-MC-Unique: 8N0z1awlO9GTzU59Hwsbeg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d10-20020a170902e14ab029012ccda38630so4141199pla.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 20:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oX2pkF9N16fnvpstzdQwpoUJiL0i5uUnc1l1ovj+dVc=;
 b=NCL6Pc9AcbFrOChy0pjoKiIUjzv9bQji/k1TfvYMbXRG7uILFqQDeGKwLG2OPFr2JS
 fGtvZjtq8XX27Z7lKVzZfnLjsXyzGPh7Dlfm/UAp9yRfJ7I5HTS/Yw6tplZO3pdpzPFw
 dhRvtijamiDGUh7rXrtdvYRbaAoMzG93LjJrnPTmXLUvgGcgvVzzNxgI0j0SPhvSPt71
 qB8f6/vttCpEyADEu4oeZ+5J0uDg/jCCG6z1MhKeB4H6CEwt1j9bDQNkvLbwdZWrvNtt
 uCvPBURp/whOoGAcIutDzUu6jcPHKkHiIiz56puLynK01LE8dFTlURIHjZKjg+DmuwOO
 mgPg==
X-Gm-Message-State: AOAM530bqVjkyD3E271CMlnu+6xrqo9oroXynp857hqZ7+ve7BC3du8Y
 87MmpDjC3YXuJIhbfmqHyTI82URQAsRkp7edHVFrk3essvUMQvNTP8HNPOPIf44mTrQC9603CM9
 ADLOlBdFch7KT0iAUwmdy5VjcOFAwo1K713XcSE38XfJWZBno3nGgOGWaQzA7r6okxj1y7nlAOH
 kJlakOcWVoSRWGEawB+Q==
X-Received: by 2002:a17:90a:3f8e:: with SMTP id
 m14mr2493944pjc.227.1628565003978; 
 Mon, 09 Aug 2021 20:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr/ykVRZ5m6I5dlp/Hp1DWCF7VyTTVfrX1UUGkbZgzsIlEn+Mjy8qX8YbmXQWnTPV38Or7wg==
X-Received: by 2002:a17:90a:3f8e:: with SMTP id
 m14mr2493921pjc.227.1628565003714; 
 Mon, 09 Aug 2021 20:10:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z5sm22327598pff.97.2021.08.09.20.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Aug 2021 20:10:03 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa_sim: Use iova_shift() for the size passed to
 alloc_iova()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, sgarzare@redhat.com
References: <20210809100923.38-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5d4bf44c-e749-2246-0bfc-d7b4ab4397fd@redhat.com>
Date: Tue, 10 Aug 2021 11:09:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809100923.38-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvOC85IM/Czuc2OjA5LCBYaWUgWW9uZ2ppINC0tcA6Cj4gVGhlIHNpemUgcGFzc2Vk
IHRvIGFsbG9jX2lvdmEoKSBzaG91bGQgYmUgdGhlIHNpemUgb2YgcGFnZSBmcmFtZXMuCj4gTm93
IHdlIHVzZSBieXRlIGdyYW51bGFyaXR5IGZvciB0aGUgaW92YSBkb21haW4sIHNvIGl0J3Mgc2Fm
ZSB0bwo+IHBhc3MgdGhlIHNpemUgaW4gYnl0ZXMgdG8gYWxsb2NfaW92YSgpLiBCdXQgaXQgd291
bGQgYmUgYmV0dGVyIHRvIHVzZQo+IGlvdmFfc2hpZnQoKSBmb3IgdGhlIHNpemUgdG8gYXZvaWQg
ZnV0dXJlIGJ1Z3MgaWYgd2UgY2hhbmdlIGdyYW51bGFyaXR5Lgo+Cj4gU2lnbmVkLW9mZi1ieTog
WGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gUmV2aWV3ZWQtYnk6IFN0ZWZh
bm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmMgfCAzICsrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBpbmRleCAxNGUwMjRk
ZTVjYmYuLjFjY2Y2MTUyMjFmZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gQEAg
LTEzNyw3ICsxMzcsOCBAQCBzdGF0aWMgZG1hX2FkZHJfdCB2ZHBhc2ltX21hcF9yYW5nZShzdHJ1
Y3QgdmRwYXNpbSAqdmRwYXNpbSwgcGh5c19hZGRyX3QgcGFkZHIsCj4gICAJaW50IHJldDsKPiAg
IAo+ICAgCS8qIFdlIHNldCB0aGUgbGltaXRfcGZuIHRvIHRoZSBtYXhpbXVtIChVTE9OR19NQVgg
LSAxKSAqLwo+IC0JaW92YSA9IGFsbG9jX2lvdmEoJnZkcGFzaW0tPmlvdmEsIHNpemUsIFVMT05H
X01BWCAtIDEsIHRydWUpOwo+ICsJaW92YSA9IGFsbG9jX2lvdmEoJnZkcGFzaW0tPmlvdmEsIHNp
emUgPj4gaW92YV9zaGlmdCgmdmRwYXNpbS0+aW92YSksCj4gKwkJCSAgVUxPTkdfTUFYIC0gMSwg
dHJ1ZSk7Cj4gICAJaWYgKCFpb3ZhKQo+ICAgCQlyZXR1cm4gRE1BX01BUFBJTkdfRVJST1I7Cj4g
ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
