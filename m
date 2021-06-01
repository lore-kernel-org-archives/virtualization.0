Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71234C47082
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 02:21:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DEA6135D
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 02:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DEA6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E144A607C8;
	Tue,  1 Jun 2021 02:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lRmKd-R2jng; Tue,  1 Jun 2021 02:21:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B9C760766;
	Tue,  1 Jun 2021 02:21:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7077BC000E;
	Tue,  1 Jun 2021 02:21:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 998B1C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A1C3836FE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TBGYz8XKfQt4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:20:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8289836F1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622514056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RHJV0WlocBHDOX8jLF2mkpZ5nqCjiTVwGU4D5WLHsm8=;
 b=AhHZ71VWQ8B9IteZJ1abzLeFuANl2joUwkr9NbH+nI99KloR8tqcrwAAuPNmjLEw3rIa24
 bbQ+Fh9n/Ojfw7NAXwxHRH69lKv2Datkp7fbPklIrEE4GdG+J1exrjiggHp77fCTgmsVXZ
 O/sU7gtF6dJMAiaSDQfTHVb6dTa9wu4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-IIyCvajkNv-DtApdkpBnww-1; Mon, 31 May 2021 22:20:54 -0400
X-MC-Unique: IIyCvajkNv-DtApdkpBnww-1
Received: by mail-pf1-f200.google.com with SMTP id
 a21-20020a62e2150000b02902e4e5d37f10so6562861pfi.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 19:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RHJV0WlocBHDOX8jLF2mkpZ5nqCjiTVwGU4D5WLHsm8=;
 b=ZSKgdJ7W+kjx40jOFHy5d1MoBxOE+jQ2ZbSc21bAMkeSiDHzi5o5wRCrTlHTKCZiNV
 cuH1J8bkZpMG3nRcrwZ9L0Yzyt6gx/oD7khMpKTji0pE1KtXIuOxSg0m8xKV0PKFQ3+R
 FsFwF7hbUKrq2CE9woKsbUdLED4IaUgW7Mvew9MX1aLmGGq02RyJ/DUTw6OcGg2Drtwo
 zcKabyNo09ZDn4j0x6Hp6v9Ig2mfd9YEtXtFEmDJLa6NKY3CHVfV1Q6N+/KTXL6+Ep7n
 j1kF0QZJ0fDUDLsrdYsuf4hQar1qb2LdxZdMY3OdOkmgNbNgRjfNuOIrx93CNdjFhVI0
 5ZyQ==
X-Gm-Message-State: AOAM533XocLFnHPjH5VorqTrPk//qd3uQqdxa986LERmRyX+h0ea396V
 I3u6ukrZwAYjS/IxEMB/4yN+eYqpSbJ9xZvgSC7OyR/s/xKuwHbGZb1hCoq6htoX56tI4fvZE5A
 6B2PNuZr9amzQa6g5BmCqylJsvd+rkk2HVr+pt4FQ0g==
X-Received: by 2002:a17:90a:f50b:: with SMTP id
 cs11mr9520570pjb.207.1622514053903; 
 Mon, 31 May 2021 19:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxVrXcTasCSSiYsHm316XHk1ghILzTBFdpIAESw/JpgIYRaR6IcNyGyler2uXnVOlhL/IRYw==
X-Received: by 2002:a17:90a:f50b:: with SMTP id
 cs11mr9520561pjb.207.1622514053738; 
 Mon, 31 May 2021 19:20:53 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p11sm12351136pgn.65.2021.05.31.19.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 19:20:53 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio/vdpa: Clear the available index during probe
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210531160502.31610-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a0a106c-af92-37b7-84de-5754b8ac645b@redhat.com>
Date: Tue, 1 Jun 2021 10:20:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531160502.31610-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CtTaIDIwMjEvNi8xIMnPzucxMjowNSwgRWxpIENvaGVuINC0tcA6Cj4gQ2xlYXIgdGhlIGF2YWls
YWJsZSBpbmRleCBhcyBwYXJ0IG9mIHRoZSBpbml0aWFsaXphdGlvbiBwcm9jZXNzIHRvCj4gY2xl
YXIgYW5kIHZhbHVlcyB0aGF0IG1pZ2h0IGJlIGxlZnQgZnJvbSBwcmV2aW91cyB1c2FnZSBvZiB0
aGUgZGV2aWNlLgo+IEZvciBleGFtcGxlLCBpZiB0aGUgZGV2aWNlIHdhcyBwcmV2aW91c2x5IHVz
ZWQgYnkgdmhvc3RfdmRwYSBhbmQgbm93Cj4gcHJvYmVkIGJ5IHZob3N0X3ZkcGEsIHlvdSB3YW50
IHRvIHN0YXJ0IHdpdGggaW5kaWNlcy4KPgo+IEZpeGVzOiBjMDQzYjRhOGNmM2IgKCJ2aXJ0aW86
IGludHJvZHVjZSBhIHZEUEEgYmFzZWQgdHJhbnNwb3J0IikKPiBTaWduZWQtb2ZmLWJ5OiBFbGkg
Q29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCk5vdGUgdGhhdCB3ZSBwcm9iYWJseSBuZWVkIGEgZm9sbG93LXVw
IGZpeGVzIGZvciB2cF92ZHBhIGRyaXZlci4KCkkgd2lsbCBwb3N0IGl0IHNvb24uCgpUaGFua3MK
Cgo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDYgKysrKysrCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiBpbmRleCBlMjhh
Y2Y0ODJlMGMuLjMyZmIxMjFhNmVjNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IEBAIC0xNDIs
NiArMTQyLDcgQEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYsIHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAlzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjYjsKPiAg
IAlzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiAgIAl1NjQgZGVzY19hZGRyLCBkcml2ZXJfYWRkciwg
ZGV2aWNlX2FkZHI7Cj4gKwlzdHJ1Y3QgdmRwYV92cV9zdGF0ZSBzdGF0ZSA9IHswfTsKPiAgIAl1
bnNpZ25lZCBsb25nIGZsYWdzOwo+ICAgCXUzMiBhbGlnbiwgbnVtOwo+ICAgCWludCBlcnI7Cj4g
QEAgLTE5MSw2ICsxOTIsMTEgQEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAkJZ290byBlcnJfdnE7Cj4gICAJ
fQo+ICAgCj4gKwkvKiByZXNldCBhdmFpbGFibGUgaW5kZXggKi8KPiArCWVyciA9IG9wcy0+c2V0
X3ZxX3N0YXRlKHZkcGEsIGluZGV4LCAmc3RhdGUpOwo+ICsJaWYgKGVycikKPiArCQlnb3RvIGVy
cl92cTsKPiArCj4gICAJb3BzLT5zZXRfdnFfcmVhZHkodmRwYSwgaW5kZXgsIDEpOwo+ICAgCj4g
ICAJdnEtPnByaXYgPSBpbmZvOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
