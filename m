Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810EEC4708F
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:51:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5D5610C8
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5D5610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF9AC401DF;
	Mon, 31 May 2021 07:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DV0o0ZPWTaYQ; Mon, 31 May 2021 07:51:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5E2D401D6;
	Mon, 31 May 2021 07:51:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85E7EC000D;
	Mon, 31 May 2021 07:51:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E60A0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B830160A44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K0HuVmBjNVtp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:51:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74F0F60A41
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622447489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNGA1jL4s1cXzURPp/0nj2H5xrOIbUXubYxtkYgHXmM=;
 b=IxWuoV2hFPm5/EawJKwrpLjeuIEXaTkVN830/TMT+DVXFZvQj+X1s7M9hgpeLCEfnbbYmJ
 /GGz/tPS84cqaxuDBfUQO0gjOnoNUX8XDOkmDdMI+D1uzB9DSEgv+8tsxE6/IOgmrZBtdU
 aLKLqWD+BVN1u8O0QFv/KmYfDFg+ZSw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-ZZIaEtgjMLe6i1vZOUgdRA-1; Mon, 31 May 2021 03:51:27 -0400
X-MC-Unique: ZZIaEtgjMLe6i1vZOUgdRA-1
Received: by mail-pj1-f70.google.com with SMTP id
 em20-20020a17090b0154b029015d6b612e97so10008888pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 00:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bNGA1jL4s1cXzURPp/0nj2H5xrOIbUXubYxtkYgHXmM=;
 b=AIsFo7okf5Ku7gCCBpZwHuSmfrNIqJqGJ4tRyhSpDZcTezGsuauvQW2QFddt/b98Ma
 IgW3QyhE9APQtP9ofEArwsQHjjbnECdXmKwdODSUAeeGuBEIz2Ujcdpb3UPQ8bitqEgz
 HTjrYkKk5As3qgvxEuGMdrYuxRAyLHSUNMqUaCv2AqYB/jOc/qAEvLXhWKaQa8t74KLC
 HyAFj2szZOagrFBBwOjosReYr+93pmu+Bv8ZXbe3fvSH4ByodnWHkHI52H2LYJ8eL/ry
 xUqnPZ/qTBnnimNP8tcZ/tpeMuqVegYIaV1yz/5XUQ2jvta69WNQcSa+IYzsGCUME89r
 qGaQ==
X-Gm-Message-State: AOAM533vs4oFAQ6nsYKkpnaTcobutP4cnStLY8JniNj1Svi3YqiOHWl7
 cbS0NgejDFlcijPdmem6LOwJygaRIuhtGzGz3j40qHX1cs7KCqz5R9NxRpcqW7pUCAyrNQg0D+R
 1jKn3uMpDTlUQkP6prSylCnRiEBTEghonk23IlvCIvQ==
X-Received: by 2002:a62:828f:0:b029:2e9:1449:4269 with SMTP id
 w137-20020a62828f0000b02902e914494269mr15634096pfd.6.1622447486337; 
 Mon, 31 May 2021 00:51:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0CMdqh/gqxDzY6nw0FnXAh/wMfejyrnXngWxGVTIiHVeU9O/RV3kFZY0/yKKbzZhYNYlaVA==
X-Received: by 2002:a62:828f:0:b029:2e9:1449:4269 with SMTP id
 w137-20020a62828f0000b02902e914494269mr15634083pfd.6.1622447486045; 
 Mon, 31 May 2021 00:51:26 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c17sm11010862pgm.3.2021.05.31.00.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 00:51:25 -0700 (PDT)
Subject: Re: [PATCH v3] virtio-net: Add validation for used length
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210528121157.105-1-xieyongji@bytedance.com>
 <49ab3d41-c5d8-a49d-3ff4-28ebfdba0181@redhat.com>
 <CACycT3uo-J3MYdEo0TscENewp3Xnjce8yFLtt6JkK8uZrvsMjg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4ff90e78-0c7a-def6-ef84-367bcce4cea5@redhat.com>
Date: Mon, 31 May 2021 15:51:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3uo-J3MYdEo0TscENewp3Xnjce8yFLtt6JkK8uZrvsMjg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIxLzUvMzEg5LiL5Y2IMzoxOSwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gTW9uLCBN
YXkgMzEsIDIwMjEgYXQgMjo0OSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yOCDkuIvljYg4OjExLCBYaWUgWW9uZ2ppIOWGmemBkzoK
Pj4+IFRoaXMgYWRkcyB2YWxpZGF0aW9uIGZvciB1c2VkIGxlbmd0aCAobWlnaHQgY29tZQo+Pj4g
ZnJvbSBhbiB1bnRydXN0ZWQgZGV2aWNlKSB0byBhdm9pZCBkYXRhIGNvcnJ1cHRpb24KPj4+IG9y
IGxvc3MuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVk
YW5jZS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDI4ICsr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IGluZGV4IDA3M2Zl
YzRjMGRmMS4uMDFmMTViNjU4MjRjIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IEBAIC03MzIsNiAr
NzMyLDE3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9zbWFsbChzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LAo+Pj4KPj4+ICAgICAgICByY3VfcmVhZF9sb2NrKCk7Cj4+PiAgICAgICAg
eGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UocnEtPnhkcF9wcm9nKTsKPj4+ICsgICAgIGlmICh1
bmxpa2VseShsZW4gPiBHT09EX1BBQ0tFVF9MRU4pKSB7Cj4+PiArICAgICAgICAgICAgIHByX2Rl
YnVnKCIlczogcnggZXJyb3I6IGxlbiAldSBleGNlZWRzIG1heCBzaXplICVkXG4iLAo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICBkZXYtPm5hbWUsIGxlbiwgR09PRF9QQUNLRVRfTEVOKTsKPj4+
ICsgICAgICAgICAgICAgZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4+PiArICAgICAg
ICAgICAgIGlmICh4ZHBfcHJvZykKPj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94
ZHA7Cj4+PiArCj4+PiArICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+Pj4gKyAgICAg
ICAgICAgICBwdXRfcGFnZShwYWdlKTsKPj4+ICsgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+
PiArICAgICB9Cj4+PiAgICAgICAgaWYgKHhkcF9wcm9nKSB7Cj4+PiAgICAgICAgICAgICAgICBz
dHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmICpoZHIgPSBidWYgKyBoZWFkZXJfb2Zmc2V0
Owo+Pj4gICAgICAgICAgICAgICAgc3RydWN0IHhkcF9mcmFtZSAqeGRwZjsKPj4+IEBAIC04ODgs
NiArODk5LDE2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+Cj4+PiAgICAgICAgcmN1X3JlYWRfbG9jaygpOwo+Pj4g
ICAgICAgIHhkcF9wcm9nID0gcmN1X2RlcmVmZXJlbmNlKHJxLT54ZHBfcHJvZyk7Cj4+PiArICAg
ICBpZiAodW5saWtlbHkobGVuID4gdHJ1ZXNpemUpKSB7Cj4+PiArICAgICAgICAgICAgIHByX2Rl
YnVnKCIlczogcnggZXJyb3I6IGxlbiAldSBleGNlZWRzIHRydWVzaXplICVsdVxuIiwKPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgZGV2LT5uYW1lLCBsZW4sICh1bnNpZ25lZCBsb25nKWN0eCk7
Cj4+PiArICAgICAgICAgICAgIGRldi0+c3RhdHMucnhfbGVuZ3RoX2Vycm9ycysrOwo+Pj4gKyAg
ICAgICAgICAgICBpZiAoeGRwX3Byb2cpCj4+PiArICAgICAgICAgICAgICAgICAgICAgZ290byBl
cnJfeGRwOwo+Pj4gKwo+Pj4gKyAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPj4+ICsg
ICAgICAgICAgICAgZ290byBlcnJfc2tiOwo+Pj4gKyAgICAgfQo+Pgo+PiBQYXRjaCBsb29rcyBj
b3JyZWN0IGJ1dCBJJ2QgcmF0aGVyIG5vdCBib3RoZXIgWERQIGhlcmUuIEl0IHdvdWxkIGJlCj4+
IGJldHRlciBpZiB3ZSBqdXN0IGRvIHRoZSBjaGVjayBiZWZvcmUgcmN1X3JlYWRfbG9jaygpIGFu
ZCB1c2UgZXJyX3NrYgo+PiBkaXJlY3RseSgpIHRvIGF2b2lkIFJDVS9YRFAgc3R1ZmZzLgo+Pgo+
IElmIHNvLCB3ZSB3aWxsIG1pc3MgdGhlIHN0YXRpc3RpY3Mgb2YgeGRwX2Ryb3BzLiBJcyBpdCBP
Sz8KCgpJdCBzaG91bGQgYmUgb2ssIHdlIHN0aWxsIGhhZCBkcm9wcyBhbmQgaXQgd2FzIGRyb3Bw
ZWQgYmVmb3JlIGRlYWxpbmcgCndpdGggWERQLgoKVGhlIG1vdGl2YXRpb24gaXMgdG8gaGF2ZSBz
aW1wbGUgY29kZXMuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
