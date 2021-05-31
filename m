Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48282C47092
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:29:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7372610C8
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7372610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9615F4029C;
	Mon, 31 May 2021 03:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F12jwRYYXlYN; Mon, 31 May 2021 03:29:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A03F40234;
	Mon, 31 May 2021 03:29:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB7C4C000E;
	Mon, 31 May 2021 03:29:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F97DC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C743605E4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:29:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQsg6b4lPl6a
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:29:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A85F605DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622431751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m45hNuVFYeGW1Xz/2rfmBSBDjFlEr9Kgts0SpTXrBnw=;
 b=e3bpDs7g2J8kT1Bwp1YV4RqjRpoCi1Ui7WDouQih24l+CG7VtYp3FjBWQvqmb2YTthwg9s
 RCjAxyhzD+2Qx47Ee9sZf8IsRhVC1TesclueDfvc70qnAhG0Y/E450vb8JGG9ExIyvZYVW
 Q/3nqrP7SKIUy/Je7UmyBUa2ROBl4XU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301--4dqNtSNOXOpagt4yQDcSQ-1; Sun, 30 May 2021 23:29:07 -0400
X-MC-Unique: -4dqNtSNOXOpagt4yQDcSQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 p18-20020a62ab120000b02902e923e4779bso5205532pff.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 20:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=m45hNuVFYeGW1Xz/2rfmBSBDjFlEr9Kgts0SpTXrBnw=;
 b=Vr4MpW0YNFXJbm5j1wnbhHaTm2d8k8KE3Ije5rcCkbS1WlDqo+QyDFU5+6cLIhfm2Z
 2wrfsCitRRaUaJoZTvfsEzPZc4+k2OoAXQ7cM1Am1/sEG635onUSVvtUVJGsPJonLi8l
 o6hciy6nNFK6GWROD9txopYvmIGSwRnZO76PjagKUch65Lx9xmt69oxD7sbU+mCL5d7U
 6aPXKrAl69E+ugXkv3J2wFkFCmUFQHkDKhgMhrSPNN5JCAMySRJ5Gy+7yFbdXyQF7ifO
 Clnq82j0BKVU0AM4Riy0ME/MSLvEpd78hnnIMvJBxLWVBEuaDsV/OYGDBr63CJW2v7vP
 G5Ng==
X-Gm-Message-State: AOAM531fwDOTnHbKXydTj8YkYueKFUZ5yvqP0DTssS0cHv7Q39yHD+9C
 30MPhsYgxGmyFO+GUz8Yt38VMMxeyvvlYr5XtCEi4Bse6TOrvOt9bTBCDqY9JceJSZnoHqb4UjJ
 bbSagQqx9ESMUtVcW3nHfXP5zfFBLGiPqYAa2Sgeilw==
X-Received: by 2002:a17:90a:1588:: with SMTP id
 m8mr17072554pja.31.1622431746044; 
 Sun, 30 May 2021 20:29:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/d/61zAmRkvATlZvt85qn1GHGi5BiOuv5Z+UIHQ5rWVq/ZAEduNPO3CWSD13UAG0w6hZDGw==
X-Received: by 2002:a17:90a:1588:: with SMTP id
 m8mr17072544pja.31.1622431745832; 
 Sun, 30 May 2021 20:29:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id mp21sm9923834pjb.50.2021.05.30.20.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 20:29:05 -0700 (PDT)
Subject: Re: [PATCH net-next] virtio_net: set link state down when virtqueue
 is broken
To: wangyunjian <wangyunjian@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <79907bf6c835572b4af92f16d9a3ff2822b1c7ea.1622028946.git.wangyunjian@huawei.com>
 <03c68dd1-a636-9d3b-1dec-5e11c8025ccc@redhat.com>
 <d18383f7e675452d9392321506db6fa0@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0fcc1413-cb20-7a17-bdcd-6f9994990432@redhat.com>
Date: Mon, 31 May 2021 11:28:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <d18383f7e675452d9392321506db6fa0@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "kuba@kernel.org" <kuba@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 dingxiaoxiong <dingxiaoxiong@huawei.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzUvMjgg5LiL5Y2INjo1OCwgd2FuZ3l1bmppYW4g5YaZ6YGTOgo+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBo
dWF3ZWkuY29tPgo+Pj4KPj4+IFRoZSBOSUMgY2FuJ3QgcmVjZWl2ZS9zZW5kIHBhY2tldHMgaWYg
YSByeC90eCB2aXJ0cXVldWUgaXMgYnJva2VuLgo+Pj4gSG93ZXZlciwgdGhlIGxpbmsgc3RhdGUg
b2YgdGhlIE5JQyBpcyBzdGlsbCBub3JtYWwuIEFzIGEgcmVzdWx0LCB0aGUKPj4+IHVzZXIgY2Fu
bm90IGRldGVjdCB0aGUgTklDIGV4Y2VwdGlvbi4KPj4KPj4gRG9lc24ndCB3ZSBoYXZlOgo+Pgo+
PiAgIMKgwqDCoMKgwqDCoCAvKiBUaGlzIHNob3VsZCBub3QgaGFwcGVuISAqLwo+PiAgIMKgwqDC
oMKgwqDCoMKgIGlmICh1bmxpa2VseShlcnIpKSB7Cj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRldi0+c3RhdHMudHhfZmlmb19lcnJvcnMrKzsKPj4gICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5ldF9yYXRlbGltaXQoKSkKPj4gICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKCZkZXYtPmRldiwKPj4g
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICJVbmV4cGVjdGVkIFRYUSAoJWQpIHF1ZXVlCj4+IGZhaWx1cmU6ICVkXG4iLAo+
PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcW51bSwgZXJyKTsKPj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7Cj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRldl9rZnJlZV9za2JfYW55KHNrYik7Cj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBORVRERVZfVFhfT0s7Cj4+ICAgwqDCoMKgwqDCoMKgwqAgfQo+Pgo+
PiBXaGljaCBzaG91bGQgYmUgc3VmZmljaWVudD8KPiBUaGVyZSBtYXkgYmUgb3RoZXIgcmVhc29u
cyBmb3IgdGhpcyBlcnJvciwgZS5nIC1FTk9TUEMobm8gZnJlZSBkZXNjKS4KCgpUaGlzIHNob3Vs
ZCBub3QgaGFwcGVuIHVubGVzcyB0aGUgZGV2aWNlIG9yIGRyaXZlciBpcyBidWdneS4gV2UgYWx3
YXlzIApyZXNlcnZlZCBzdWZmaWNpZW50IHNsb3RzOgoKIMKgwqDCoMKgwqDCoMKgIGlmIChzcS0+
dnEtPm51bV9mcmVlIDwgMitNQVhfU0tCX0ZSQUdTKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbmV0aWZfc3RvcF9zdWJxdWV1ZShkZXYsIHFudW0pOwouLi4KCgo+IEFuZCBpZiBy
eCB2aXJ0cXVldWUgaXMgYnJva2VuLCB0aGVyZSBpcyBubyBlcnJvciBzdGF0aXN0aWNzLgoKCkZl
ZWwgZnJlZSB0byBhZGQgb25lIGlmIGl0J3MgbmVjZXNzYXJ5LgoKTGV0J3MgbGVhdmUgdGhlIHBv
bGljeSBkZWNpc2lvbiAobGluayBkb3duKSB0byB1c2Vyc3BhY2UuCgoKPgo+Pgo+Pj4gVGhlIGRy
aXZlciBjYW4gc2V0IHRoZSBsaW5rIHN0YXRlIGRvd24gd2hlbiB0aGUgdmlydHF1ZXVlIGlzIGJy
b2tlbi4KPj4+IElmIHRoZSBzdGF0ZSBpcyBkb3duLCB0aGUgdXNlciBjYW4gc3dpdGNoIG92ZXIg
dG8gYW5vdGhlciBOSUMuCj4+Cj4+IE5vdGUgdGhhdCwgd2UgcHJvYmFibHkgbmVlZCB0aGUgd2F0
Y2hkb2cgZm9yIHZpcnRpby1uZXQgaW4gb3JkZXIgdG8gYmUgYQo+PiBjb21wbGV0ZSBzb2x1dGlv
bi4KPiBZZXMsIEkgY2FuIHRoaW5rIG9mIGlzIHRoYXQgdGhlIHZpcnRxdWV1ZSdzIGJyb2tlbiBl
eGNlcHRpb24gaXMgZGV0ZWN0ZWQgb24gd2F0Y2hkb2cuCj4gSXMgdGhlcmUgYW55dGhpbmcgZWxz
ZSB0aGF0IG5lZWRzIHRvIGJlIGRvbmU/CgoKQmFzaWNhbGx5LCBpdCdzIGFsbCBhYm91dCBUWCBz
dGFsbCB3aGljaCB3YXRjaGRvZyB0cmllcyB0byBjYXRjaC4gQnJva2VuIAp2cSBpcyBvbmx5IG9u
ZSBvZiB0aGUgcG9zc2libGUgcmVhc29uLgoKVGhhbmtzCgoKPgo+IFRoYW5rcwo+Cj4+IFRoYW5r
cwo+Pgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
