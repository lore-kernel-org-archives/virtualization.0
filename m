Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444DEC4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:06:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06A560F6F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E06A560F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B87B40467;
	Tue, 10 Aug 2021 03:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vbvCTonWxd6w; Tue, 10 Aug 2021 03:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 361EE403AE;
	Tue, 10 Aug 2021 03:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A5C2C0010;
	Tue, 10 Aug 2021 03:06:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2172CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0366C40467
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b-py0N3SuSFo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:06:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DEA1403AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628564779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/XJyPAYHXanGu8PLfmROFQrl19iFkKvHMXPx3gWnhY=;
 b=VzDEz/OY/lPhvhhQFZEsq+dVDoERT4miD9JjozPTk1NGmlL8nEtjfJNTgO57QAMcEwePCj
 RHKGp1DKGfDkmIpXkbgWKpsun5msj7IcnBarnFpvzK2xL2g/njvAPz2ihkJBcXBPC5Zwx0
 /h8ESD0ZII9yISRfamlrJ1pTDVh8JJE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-gYN5ZIWYMOOx_5mjFKaYcQ-1; Mon, 09 Aug 2021 23:06:18 -0400
X-MC-Unique: gYN5ZIWYMOOx_5mjFKaYcQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 d35-20020a17090a6f26b0290178ab46154dso3497397pjk.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 20:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=e/XJyPAYHXanGu8PLfmROFQrl19iFkKvHMXPx3gWnhY=;
 b=BTpxDxA3cI2PVfydfxbs5jZdKWMYfjxsBewycX7zSwVhsNkiQrqeJ6YStmnhWMD7hQ
 CkNZcZdduD/zMpOQ2NmFxD1Yd0RZv2T/AEmPKg4EisQTHfIOwjU533d2th8ZlXIneQfQ
 r/fHf6IZd9srTrE0qNMXbhL/gJXEOMjLl9OhBk4p83/Q5H2D1WmhmKt9zSUTzFE6Z2/9
 rdnl7wqkq9MoDgezaH/MrqaPG3Es/CIJH3dz+WWSzmY5UU2m7+oDdMB2oI+Hh+1/spnQ
 BGYXfM3YIenHa+xcttt5166k7cjpve6U+sSrAh4B5T9sClmrkcb+S+s78llDhDese6vT
 vqPg==
X-Gm-Message-State: AOAM530Rk9o8g19/onkPn4UkKu4wqp9JJW9jwr0mfpvmPx+DcIgI/nXs
 Xkx8Wp0nCb6F3/WofqBfGyPjRMOs86bNTwi3ZkNnmp22YjJSYAkXF8HmAz7FByn8E51EjaNac8E
 2EsjSxgm0KIo9YgbKG1jVPMcXWrqnhZiXDMwVn8mlbnjbTh1RuLYdmLrj7yno3ORTh++poTQawK
 lcgi177jZnIAyZBTNY5g==
X-Received: by 2002:a65:6554:: with SMTP id a20mr180308pgw.107.1628564777062; 
 Mon, 09 Aug 2021 20:06:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6FZL/uRG7KTv+CRV0uQZgov1Gk4oGzOLsWFTFR6aE6EAaUKrE0LE2dczy1Wncsi/jaOFvgA==
X-Received: by 2002:a65:6554:: with SMTP id a20mr180293pgw.107.1628564776847; 
 Mon, 09 Aug 2021 20:06:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 1sm19363712pjk.54.2021.08.09.20.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Aug 2021 20:06:16 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa_sim: Use iova_shift() for the size passed to
 alloc_iova()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, sgarzare@redhat.com
References: <20210809100923.38-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f4d710d0-ab51-b251-b213-34668354447d@redhat.com>
Date: Tue, 10 Aug 2021 11:06:13 +0800
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
bm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gaW5k
ZXggMTRlMDI0ZGU1Y2JmLi4xY2NmNjE1MjIxZmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYwo+IEBAIC0xMzcsNyArMTM3LDggQEAgc3RhdGljIGRtYV9hZGRyX3QgdmRwYXNpbV9tYXBf
cmFuZ2Uoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHBoeXNfYWRkcl90IHBhZGRyLAo+ICAgCWlu
dCByZXQ7Cj4gICAKPiAgIAkvKiBXZSBzZXQgdGhlIGxpbWl0X3BmbiB0byB0aGUgbWF4aW11bSAo
VUxPTkdfTUFYIC0gMSkgKi8KPiAtCWlvdmEgPSBhbGxvY19pb3ZhKCZ2ZHBhc2ltLT5pb3ZhLCBz
aXplLCBVTE9OR19NQVggLSAxLCB0cnVlKTsKPiArCWlvdmEgPSBhbGxvY19pb3ZhKCZ2ZHBhc2lt
LT5pb3ZhLCBzaXplID4+IGlvdmFfc2hpZnQoJnZkcGFzaW0tPmlvdmEpLAo+ICsJCQkgIFVMT05H
X01BWCAtIDEsIHRydWUpOwo+ICAgCWlmICghaW92YSkKPiAgIAkJcmV0dXJuIERNQV9NQVBQSU5H
X0VSUk9SOwo+ICAgCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
