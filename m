Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B79EC47092
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:02:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57D261008
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57D261008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FDBF40352;
	Mon, 31 May 2021 03:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkn4uUL067Im; Mon, 31 May 2021 03:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A22B340350;
	Mon, 31 May 2021 03:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6642EC000D;
	Mon, 31 May 2021 03:02:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B419C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45BB183B5B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivnsNmVj9dDf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:02:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B807838D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622430151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RlzLP9cDBuypH+co4NfKjwM55SCL4ZjJRzPsMReFNRo=;
 b=WsLtgt9aRC9XWv5eEj2myKMYMjutDFTt7mNgkwW4sexxA2G1DArT97yskaOj7sRzSOjbQX
 maJPO8SAe0sStcXK6QlmXZymyzkawqI9ItZdOcLqaxMOJTix5/klWla9Guloi5Qg2a/CJz
 Yfc/hsjbbZLiGietuaDgNnt9NdZll7M=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-cwXY4KJLPri2xmxJOzhnKA-1; Sun, 30 May 2021 23:02:29 -0400
X-MC-Unique: cwXY4KJLPri2xmxJOzhnKA-1
Received: by mail-pg1-f200.google.com with SMTP id
 p4-20020a63c1440000b029021f609e8798so3947751pgi.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 20:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RlzLP9cDBuypH+co4NfKjwM55SCL4ZjJRzPsMReFNRo=;
 b=E+QFql5hTKJgpE0bHxQARmj3fEeC9Lr/BZa97chb0f6JgY2hFROFxb4N5p70vHGTIQ
 v+LkLHcIAMGhQ8Q/512tZQW8jFXZZMrRLA/++JHgy8HgQYUeWuoW903IWWzb1QVcEU3A
 o55ZFlJN0yt++ipjZVBaAYZGBW4FSpnta5B82/fo8DM6fQ4K8SI6nfTkYffcuvDUC+Pf
 t5UwtmnnYlUSgSI8rz2eiXuNrDy5jb3Xd2IYJYrDvfqZc0zMeK8P/ARyJUOxcHmeKe00
 6AgdnT/PgP+mRe8lHhZ+hN1wppmNddVqTergUYDUlKCbGRghoGZWQDOGqR+e5EunuIP1
 MrVQ==
X-Gm-Message-State: AOAM532cK+4DIy+98GEWO8o4sTiXqoP79uxG3ZH9gnF6iWr3kiXA/lWt
 1fTStjlIkrkMuynU80m1DQdk6bRP61J4r5t3Nq/bvn/q/yQv3rmtsYlTf1m6wnEfalg9WbS7ved
 Wttgdy9l3FnM2EeZAtJ2Xv3bZ1BEL0d18d9a+qxsZUg==
X-Received: by 2002:a17:90a:b294:: with SMTP id
 c20mr16794735pjr.236.1622430148736; 
 Sun, 30 May 2021 20:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjtTbccwyZv6xn0V6J4JGVL5xRVBUofxiR5wbmsLL5CF8elClM8l9yQI5vGTq+9Jo/DURJQw==
X-Received: by 2002:a17:90a:b294:: with SMTP id
 c20mr16794708pjr.236.1622430148409; 
 Sun, 30 May 2021 20:02:28 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h24sm9669974pfn.180.2021.05.30.20.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 20:02:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
Date: Mon, 31 May 2021 11:02:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210530075415.4644-2-elic@nvidia.com>
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

CtTaIDIwMjEvNS8zMCDPws7nMzo1NCwgRWxpIENvaGVuINC0tcA6Cj4gQ3VycmVudGx5IGFsbCBy
ZXNvdXJjZXMgbXVzdCBiZSBjcmVhdGVkIHdpdGggdWlkICE9IDAgd2hpY2ggaXMgZXNzZW50aWFs
Cj4gdXNlcnNwYWNlIHByb2Nlc3NlcyBhbGxvY2F0aW5nIHZpcnRxdXVldWUgcmVzb3VyY2VzLiBT
aW5jZSB0aGlzIGlzIGEKPiBrZXJuZWwgaW1wbGVtZW50YXRpb24sIGl0IGlzIHBlcmZlY3RseSBs
ZWdhbCB0byBvcGVuIHJlc291cmNlcyB3aXRoCj4gdWlkID09IDAuCj4KPiBJbiBjYXNlIGZyaW13
YXJlIHN1cHBvcnRzLCBhdm9pZCBhbGxvY2F0aW5nIHVzZXIgY29udGV4dC4KCgpUeXBvICJmcmlt
d2FyZSIuCgpPdGhlcndpc2UuCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KCihJIGRvbid0IHNlZSBhbnkgY29kZSB0byBjaGVjayB0aGUgZmlybXdhcmUgY2FwYWJp
bGl0eSwgaXMgdGhpcyBpbnRlbmRlZD8pCgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogRWxp
IENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L3Jlc291cmNlcy5jIHwgNiArKysrKysKPiAgIGluY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5o
ICAgICAgfCA0ICsrKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJj
ZXMuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPiBpbmRleCA2NTIxY2Jk
MGY1YzIuLjgzNmFiOWVmMGZhNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L3Jlc291cmNlcy5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYwo+
IEBAIC01NCw2ICs1NCw5IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3VjdHgoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LCB1MTYgKnVpZCkKPiAgIAl2b2lkICppbjsKPiAgIAlpbnQgZXJyOwo+ICAg
Cj4gKwlpZiAoTUxYNV9DQVBfR0VOKG12ZGV2LT5tZGV2LCB1bWVtX3VpZF8wKSkKPiArCQlyZXR1
cm4gMDsKPiArCj4gICAJLyogMCBtZWFucyBub3Qgc3VwcG9ydGVkICovCj4gICAJaWYgKCFNTFg1
X0NBUF9HRU4obXZkZXYtPm1kZXYsIGxvZ19tYXhfdWN0eCkpCj4gICAJCXJldHVybiAtRU9QTk9U
U1VQUDsKPiBAQCAtNzksNiArODIsOSBAQCBzdGF0aWMgdm9pZCBkZXN0cm95X3VjdHgoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1MzIgdWlkKQo+ICAgCXUzMiBvdXRbTUxYNV9TVF9TWl9E
VyhkZXN0cm95X3VjdHhfb3V0KV0gPSB7fTsKPiAgIAl1MzIgaW5bTUxYNV9TVF9TWl9EVyhkZXN0
cm95X3VjdHhfaW4pXSA9IHt9Owo+ICAgCj4gKwlpZiAoIXVpZCkKPiArCQlyZXR1cm47Cj4gKwo+
ICAgCU1MWDVfU0VUKGRlc3Ryb3lfdWN0eF9pbiwgaW4sIG9wY29kZSwgTUxYNV9DTURfT1BfREVT
VFJPWV9VQ1RYKTsKPiAgIAlNTFg1X1NFVChkZXN0cm95X3VjdHhfaW4sIGluLCB1aWQsIHVpZCk7
Cj4gICAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbHg1L21seDVfaWZjLmggYi9pbmNs
dWRlL2xpbnV4L21seDUvbWx4NV9pZmMuaAo+IGluZGV4IDljNjhiMmRhMTRjNi4uNjA2ZDJhZWFj
YWQ0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5oCj4gKysrIGIv
aW5jbHVkZS9saW51eC9tbHg1L21seDVfaWZjLmgKPiBAQCAtMTQ4Nyw3ICsxNDg3LDkgQEAgc3Ry
dWN0IG1seDVfaWZjX2NtZF9oY2FfY2FwX2JpdHMgewo+ICAgCXU4ICAgICAgICAgdWFyXzRrWzB4
MV07Cj4gICAJdTggICAgICAgICByZXNlcnZlZF9hdF8yNDFbMHg5XTsKPiAgIAl1OCAgICAgICAg
IHVhcl9zelsweDZdOwo+IC0JdTggICAgICAgICByZXNlcnZlZF9hdF8yNTBbMHg4XTsKPiArCXU4
ICAgICAgICAgcmVzZXJ2ZWRfYXRfMjQ4WzB4Ml07Cj4gKwl1OCAgICAgICAgIHVtZW1fdWlkXzBb
MHgxXTsKPiArCXU4ICAgICAgICAgcmVzZXJ2ZWRfYXRfMjUwWzB4NV07Cj4gICAJdTggICAgICAg
ICBsb2dfcGdfc3pbMHg4XTsKPiAgIAo+ICAgCXU4ICAgICAgICAgYmZbMHgxXTsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
