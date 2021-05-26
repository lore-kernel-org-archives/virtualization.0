Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53456C47089
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 07:52:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA0D61442
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 07:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA0D61442
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84CCB40509;
	Wed, 26 May 2021 07:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MB3JeciSpzZE; Wed, 26 May 2021 07:52:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDBF840377;
	Wed, 26 May 2021 07:52:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9DC2C000D;
	Wed, 26 May 2021 07:52:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 349CAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 07:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CBFB83BBE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 07:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id huuJJMHdqcHz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 07:52:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B02E583BB2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622015548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVw3shBSRM9cCjmRdNWLJQgAvu0wuJKkFQWrzs4FqGI=;
 b=PPH9fImOcx+rnQUqw2sz6VqZ4OGPC+A+mFFt/hK3d7+Q5zZhIPNNBGLzBdanWG4NONQUTj
 Y3IoQ4ri9cGEk3ZEmAhxunxvPisrpHfv+044QpGfkyoqJHwNFFdaOuMI/fO2FK1eZBqRM4
 tFzf/+J8/fvIptNDTd81c1WauU01iSM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-GL2si5crPaGE9A1PW4e8Ww-1; Wed, 26 May 2021 03:52:26 -0400
X-MC-Unique: GL2si5crPaGE9A1PW4e8Ww-1
Received: by mail-pg1-f199.google.com with SMTP id
 r16-20020a63a5500000b02902155900cc63so214974pgu.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 00:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=dVw3shBSRM9cCjmRdNWLJQgAvu0wuJKkFQWrzs4FqGI=;
 b=ndMVVPH1cVy/47yat0fOp6hk/JdGrHnS0dhywrJZa0N6i7LtajHRirlGyJTjFjZFw5
 wqwqR58XZ4cfigXHiZonVwRnLbwF5YHdy5yeWFpwkH+rKLbgITUV4KyEKnNKHNB+BX1V
 yCwzdO7rkyv64ys+OP/WNPC/pjOKpXt67qxENf769DJ6LfdIye+ZqJ5v5Avi4ryKARuA
 /ZEN86UAHzop3WiarnxXbbijPLWGbOfCZTvbcOfTZmTvyiaII6fwf4iMqCZxR4mUyKqO
 3dv6FxP55HQaEF+I41UQqUNgRzaxznEODrbRlZw6teBWUKeEZ/vK/IRHLU8c7YCDunaV
 JBNw==
X-Gm-Message-State: AOAM532WOgGyOm8Quind3ETbvvKNaQTzFbKwq0szOyYbP5bHLakkqiJa
 5Vz+xwmku6FMDjr35wyILBgRHET8Bjdsi8Mhsl+ThV6xSTokRTjyuBp4jofNxI/BipZikCDt+88
 uXH6uOERtq06xeaa+v/dCi+VZwLyAOKAFk3nmGYD4HQ==
X-Received: by 2002:a17:90a:ac04:: with SMTP id
 o4mr34169884pjq.114.1622015545212; 
 Wed, 26 May 2021 00:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlZ4+ufAUqXTa/BSHAz2PdlAOim2N8MhD4LPOb3cUXLInNAVYMiHTUODnYlzBp1l/jEmNg5A==
X-Received: by 2002:a17:90a:ac04:: with SMTP id
 o4mr34169864pjq.114.1622015544950; 
 Wed, 26 May 2021 00:52:24 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y129sm1697041pfy.123.2021.05.26.00.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 00:52:24 -0700 (PDT)
Subject: Re: [PATCH] virtio-net: Add validation for used length
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210525045838.1137-1-xieyongji@bytedance.com>
 <75e26cf1-6ee8-108c-ff48-8a23345b3ccc@redhat.com>
 <CACycT3s1VkvG7zr7hPciBx8KhwgtNF+CM5GeSJs2tp-2VTsWRw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <efb7d2e0-39b0-129d-084b-122820c93138@redhat.com>
Date: Wed, 26 May 2021 15:52:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3s1VkvG7zr7hPciBx8KhwgtNF+CM5GeSJs2tp-2VTsWRw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

CuWcqCAyMDIxLzUvMjUg5LiL5Y2INDo0NSwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVHVlLCBN
YXkgMjUsIDIwMjEgYXQgMjozMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNSDkuIvljYgxMjo1OCwgWGllIFlvbmdqaSDlhpnpgZM6
Cj4+PiBUaGlzIGFkZHMgdmFsaWRhdGlvbiBmb3IgdXNlZCBsZW5ndGggKG1pZ2h0IGNvbWUKPj4+
IGZyb20gYW4gdW50cnVzdGVkIGRldmljZSkgdG8gYXZvaWQgZGF0YSBjb3JydXB0aW9uCj4+PiBv
ciBsb3NzLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRl
ZGFuY2UuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyMiAr
KysrKysrKysrKysrKysrKysrKysrCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IGluZGV4IGM0NzExZTIzYWY4OC4uMmRjZGMxYTNjN2U4
IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+PiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IEBAIC02NjgsNiArNjY4LDEzIEBAIHN0YXRpYyBzdHJ1
Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9zbWFsbChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+Pj4gICAg
ICAgICAgICAgICAgdm9pZCAqb3JpZ19kYXRhOwo+Pj4gICAgICAgICAgICAgICAgdTMyIGFjdDsK
Pj4+Cj4+PiArICAgICAgICAgICAgIGlmICh1bmxpa2VseShsZW4gPiBHT09EX1BBQ0tFVF9MRU4p
KSB7Cj4+PiArICAgICAgICAgICAgICAgICAgICAgcHJfZGVidWcoIiVzOiByeCBlcnJvcjogbGVu
ICV1IGV4Y2VlZHMgbWF4IHNpemUgJWx1XG4iLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRldi0+bmFtZSwgbGVuLCBHT09EX1BBQ0tFVF9MRU4pOwo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIGRldi0+c3RhdHMucnhfbGVuZ3RoX2Vycm9ycysrOwo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPj4+ICsgICAgICAgICAgICAgfQo+Pgo+PiBOZWVkIHRv
IGNvdW50IHZpLT5oZHJfbGVuIGhlcmU/Cj4+Cj4gV2UgZGlkIGxlbiAtPSB2aS0+aGRyX2xlbiBi
ZWZvcmUuCgoKUmlnaHQuCgoKPgo+Pj4gKwo+Pj4gICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5
KGhkci0+aGRyLmdzb190eXBlKSkKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJf
eGRwOwo+Pj4KPj4+IEBAIC03MzksNiArNzQ2LDE0IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAq
cmVjZWl2ZV9zbWFsbChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+Pj4gICAgICAgIH0KPj4+ICAg
ICAgICByY3VfcmVhZF91bmxvY2soKTsKPj4+Cj4+PiArICAgICBpZiAodW5saWtlbHkobGVuID4g
R09PRF9QQUNLRVRfTEVOKSkgewo+Pj4gKyAgICAgICAgICAgICBwcl9kZWJ1ZygiJXM6IHJ4IGVy
cm9yOiBsZW4gJXUgZXhjZWVkcyBtYXggc2l6ZSAlbHVcbiIsCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgIGRldi0+bmFtZSwgbGVuLCBHT09EX1BBQ0tFVF9MRU4pOwo+Pj4gKyAgICAgICAgICAg
ICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsKPj4+ICsgICAgICAgICAgICAgcHV0X3Bh
Z2UocGFnZSk7Cj4+PiArICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+Pj4gKyAgICAgfQo+Pj4g
Kwo+Pj4gICAgICAgIHNrYiA9IGJ1aWxkX3NrYihidWYsIGJ1Zmxlbik7Cj4+PiAgICAgICAgaWYg
KCFza2IpIHsKPj4+ICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+Pj4gQEAgLTgyMiw2
ICs4MzcsMTMgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LAo+Pj4gICAgICAgICAgICAgICAgdm9pZCAqZGF0YTsKPj4+ICAg
ICAgICAgICAgICAgIHUzMiBhY3Q7Cj4+Pgo+Pj4gKyAgICAgICAgICAgICBpZiAodW5saWtlbHko
bGVuID4gdHJ1ZXNpemUpKSB7Cj4+PiArICAgICAgICAgICAgICAgICAgICAgcHJfZGVidWcoIiVz
OiByeCBlcnJvcjogbGVuICV1IGV4Y2VlZHMgdHJ1ZXNpemUgJWx1XG4iLAo+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRldi0+bmFtZSwgbGVuLCAodW5zaWduZWQgbG9uZyljdHgp
Owo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGRldi0+c3RhdHMucnhfbGVuZ3RoX2Vycm9ycysr
Owo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPj4+ICsgICAgICAgICAg
ICAgfQo+Pgo+PiBUaGVyZSdzIGEgc2ltaWxhciBjaGVjayBhZnRlciB0aGUgWERQLCBsZXQncyBz
aW1wbHkgbW92ZSBpdCBoZXJlPwo+IERvIHdlIHN0aWxsIG5lZWQgdGhhdCBpbiBub24tWERQIGNh
c2VzPwoKCkkgbWVhbnQgd2UgY2hlY2sgb25jZSBmb3IgYm90aCBYRFAgYW5kIG5vbi1YRFAgaWYg
d2UgZG8gaXQgYmVmb3JlIGlmIAooeGRwX3Byb2cpCgoKPgo+PiBBbmQgZG8gd2UgbmVlZCBzaW1p
bGFyIGNoZWNrIGluIHJlY2VpdmVfYmlnKCk/Cj4+Cj4gSXQgc2VlbXMgdGhhdCB0aGUgY2hlY2sg
aW4gcGFnZV90b19za2IoKSBjYW4gZG8gc2ltaWxhciB0aGluZ3MuCgoKUmlnaHQuCgpUaGFua3MK
Cgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
