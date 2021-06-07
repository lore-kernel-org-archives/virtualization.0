Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE18C4743E
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:29:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA9261003
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA9261003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFD27831CB;
	Mon,  7 Jun 2021 02:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZeDYRmcJLSz5; Mon,  7 Jun 2021 02:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 323C383118;
	Mon,  7 Jun 2021 02:29:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 148EEC000E;
	Mon,  7 Jun 2021 02:29:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98EF3C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86CC9401D6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ioe0fSW3jBVC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:29:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C72840015
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623032947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VUeJVdhPn2VuLW7BaccrekOt7TaxxTxZqwvCsiTqLA=;
 b=bUFuofInTLh8Sa4kbMx1BIbBBQTJc1Yin7k5aamCrYsePfokEjKf2eNK1n2fmcX4iI7trt
 w+pzZNGBfYFFxSbYF1Iq6CVnJ7PkXr+HoK0tcooFMRCRUTvADtDZzG98kHuF89Fijp1THp
 NNwHySuVSSu7zzDNwx7QRMPeIFixf0A=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-SB5i2HggPLuwRGIYfPvQMQ-1; Sun, 06 Jun 2021 22:29:02 -0400
X-MC-Unique: SB5i2HggPLuwRGIYfPvQMQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 b8-20020a056a000a88b02902e97a71383dso6930442pfl.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5VUeJVdhPn2VuLW7BaccrekOt7TaxxTxZqwvCsiTqLA=;
 b=E0OszM46BCPrLa1uPeA4CTOf8OyFW9h48IGQTiyakRg6isxszkxYkwKKWSvNhG3OoY
 A4WG+yp9EPY6RiKcU/8iBORGzaYBJh9Khwsi2+qhapcjujxW3iEDX3oxs7Vmx/YaKl1k
 tKPWOdz2TW3xPNkETmffUsIJ6ZjxXSV+GcOOgFv/dwiHDyrI7vniT2Dj8sdR5aJ7ofK9
 PZ9ysAdoLKGKzuJRsRhdzst1x8+ugspK4ZOr47x1hS+QtYY4Y4f66FFuRUngQqlCxyWf
 0Ma2wXHvIw6YEOcR6tV0GlbDefI8WR0uyrTt2+hkrPp+iHIVf+bzWUS5mkw37XxGmQ2i
 Yd4A==
X-Gm-Message-State: AOAM533uT6qC7gDY/c3H8zW3hQFmPzonq/LcnDNMXKei+MogTS5OCMOX
 PgQUE3Iyswl5N7e7saKRfORkM2CLMUW1KuK5oC8eIXJiMjiYQGec7LwsnmOAxU00z35ChlOR71/
 wcRNofD8emrH4/NyH7FBfjhhERcDyoBjBOo5HIA9sRA==
X-Received: by 2002:a17:90b:4b51:: with SMTP id
 mi17mr30393730pjb.109.1623032941724; 
 Sun, 06 Jun 2021 19:29:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvVvxNkgnHrJ2d3RgrbdFzecGugtjc5EPSwjXywyTeTkJohMyytdl/wnAUpQRjX3BuI/eg8Q==
X-Received: by 2002:a17:90b:4b51:: with SMTP id
 mi17mr30393705pjb.109.1623032941406; 
 Sun, 06 Jun 2021 19:29:01 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id in24sm3095374pjb.54.2021.06.06.19.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:29:00 -0700 (PDT)
Subject: Re: [PATCH net-next] virtio_net: set link state down when virtqueue
 is broken
To: wangyunjian <wangyunjian@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jcfaracco@gmail.com" <jcfaracco@gmail.com>
References: <79907bf6c835572b4af92f16d9a3ff2822b1c7ea.1622028946.git.wangyunjian@huawei.com>
 <03c68dd1-a636-9d3b-1dec-5e11c8025ccc@redhat.com>
 <d18383f7e675452d9392321506db6fa0@huawei.com>
 <0fcc1413-cb20-7a17-bdcd-6f9994990432@redhat.com>
 <20a5f1bd8a5a49fa8c0f90875a49631b@huawei.com>
 <1cc933e6-cde4-ba20-3c54-7391db93a9a1@redhat.com>
 <5d6fdd5c8e62498ba804aa22d71eb6a8@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0cc0cba2-dcda-6d8c-4304-af51089a649e@redhat.com>
Date: Mon, 7 Jun 2021 10:28:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5d6fdd5c8e62498ba804aa22d71eb6a8@huawei.com>
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

CuWcqCAyMDIxLzYvNSDkuIvljYgzOjEwLCB3YW5neXVuamlhbiDlhpnpgZM6Cj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpqYXNvd2FuZ0By
ZWRoYXQuY29tXQo+PiBTZW50OiBGcmlkYXksIEp1bmUgNCwgMjAyMSAxMDozOCBBTQo+PiBUbzog
d2FuZ3l1bmppYW4gPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnCj4+IENjOiBrdWJhQGtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IG1zdEByZWRo
YXQuY29tOwo+PiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgZGlu
Z3hpYW94aW9uZwo+PiA8ZGluZ3hpYW94aW9uZ0BodWF3ZWkuY29tPgo+PiBTdWJqZWN0OiBSZTog
W1BBVENIIG5ldC1uZXh0XSB2aXJ0aW9fbmV0OiBzZXQgbGluayBzdGF0ZSBkb3duIHdoZW4gdmly
dHF1ZXVlIGlzCj4+IGJyb2tlbgo+Pgo+Pgo+PiDlnKggMjAyMS82LzMg5LiL5Y2INzozNCwgd2Fu
Z3l1bmppYW4g5YaZ6YGTOgo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4gRnJv
bTogSmFzb24gV2FuZyBbbWFpbHRvOmphc293YW5nQHJlZGhhdC5jb21dCj4+Pj4gU2VudDogTW9u
ZGF5LCBNYXkgMzEsIDIwMjEgMTE6MjkgQU0KPj4+PiBUbzogd2FuZ3l1bmppYW4gPHdhbmd5dW5q
aWFuQGh1YXdlaS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnCj4+Pj4gQ2M6IGt1YmFAa2Vy
bmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgbXN0QHJlZGhhdC5jb207Cj4+Pj4gdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGRpbmd4aWFveGlvbmcKPj4+PiA8
ZGluZ3hpYW94aW9uZ0BodWF3ZWkuY29tPgo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5l
eHRdIHZpcnRpb19uZXQ6IHNldCBsaW5rIHN0YXRlIGRvd24gd2hlbgo+Pj4+IHZpcnRxdWV1ZSBp
cyBicm9rZW4KPj4+Pgo+Pj4+Cj4+Pj4g5ZyoIDIwMjEvNS8yOCDkuIvljYg2OjU4LCB3YW5neXVu
amlhbiDlhpnpgZM6Cj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4+Pj4+IEZy
b206IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPj4+Pj4+Pgo+Pj4+Pj4+
IFRoZSBOSUMgY2FuJ3QgcmVjZWl2ZS9zZW5kIHBhY2tldHMgaWYgYSByeC90eCB2aXJ0cXVldWUg
aXMgYnJva2VuLgo+Pj4+Pj4+IEhvd2V2ZXIsIHRoZSBsaW5rIHN0YXRlIG9mIHRoZSBOSUMgaXMg
c3RpbGwgbm9ybWFsLiBBcyBhIHJlc3VsdCwKPj4+Pj4+PiB0aGUgdXNlciBjYW5ub3QgZGV0ZWN0
IHRoZSBOSUMgZXhjZXB0aW9uLgo+Pj4+Pj4gRG9lc24ndCB3ZSBoYXZlOgo+Pj4+Pj4KPj4+Pj4+
ICAgICDCoMKgwqDCoMKgwqAgLyogVGhpcyBzaG91bGQgbm90IGhhcHBlbiEgKi8KPj4+Pj4+ICAg
ICDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoZXJyKSkgewo+Pj4+Pj4gICAgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXYtPnN0YXRzLnR4X2ZpZm9fZXJyb3JzKys7Cj4+Pj4+
PiAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChuZXRfcmF0ZWxpbWl0KCkp
Cj4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfd2FybigmZGV2LT5kZXYsCj4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiVW5leHBlY3RlZCBUWFEg
KCVkKQo+Pj4+IHF1ZXVlCj4+Pj4+PiBmYWlsdXJlOiAlZFxuIiwKPj4+Pj4+ICAgICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHFudW0sIGVycik7Cj4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
di0+c3RhdHMudHhfZHJvcHBlZCsrOwo+Pj4+Pj4gICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkZXZfa2ZyZWVfc2tiX2FueShza2IpOwo+Pj4+Pj4gICAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTkVUREVWX1RYX09LOwo+Pj4+Pj4gICAgIMKgwqDCoMKg
wqDCoMKgIH0KPj4+Pj4+Cj4+Pj4+PiBXaGljaCBzaG91bGQgYmUgc3VmZmljaWVudD8KPj4+Pj4g
VGhlcmUgbWF5IGJlIG90aGVyIHJlYXNvbnMgZm9yIHRoaXMgZXJyb3IsIGUuZyAtRU5PU1BDKG5v
IGZyZWUgZGVzYykuCj4+Pj4gVGhpcyBzaG91bGQgbm90IGhhcHBlbiB1bmxlc3MgdGhlIGRldmlj
ZSBvciBkcml2ZXIgaXMgYnVnZ3kuIFdlCj4+Pj4gYWx3YXlzIHJlc2VydmVkIHN1ZmZpY2llbnQg
c2xvdHM6Cj4+Pj4KPj4+PiAgICDCoMKgwqDCoMKgwqDCoCBpZiAoc3EtPnZxLT5udW1fZnJlZSA8
IDIrTUFYX1NLQl9GUkFHUykgewo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBuZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwgcW51bSk7IC4uLgo+Pj4+Cj4+Pj4KPj4+Pj4gQW5k
IGlmIHJ4IHZpcnRxdWV1ZSBpcyBicm9rZW4sIHRoZXJlIGlzIG5vIGVycm9yIHN0YXRpc3RpY3Mu
Cj4+Pj4gRmVlbCBmcmVlIHRvIGFkZCBvbmUgaWYgaXQncyBuZWNlc3NhcnkuCj4+PiBDdXJyZW50
bHkgcmVjZWl2aW5nIHNjZW5hcmlvLCBpdCBpcyBpbXBvc3NpYmxlIHRvIGRpc3Rpbmd1aXNoIHdo
ZXRoZXIKPj4+IHRoZSByZWFzb24gZm9yIG5vdCByZWNlaXZpbmcgcGFja2V0IGlzIHZpcnRxdWV1
ZSdzIGJyb2tlbiBvciBubyBwYWNrZXQuCj4+Cj4+IENhbiB3ZSBpbnRyb2R1Y2UgcnhfZmlmb19l
cnJvcnMgZm9yIHRoYXQ/Cj4+Cj4+Cj4+Pj4gTGV0J3MgbGVhdmUgdGhlIHBvbGljeSBkZWNpc2lv
biAobGluayBkb3duKSB0byB1c2Vyc3BhY2UuCj4+Pj4KPj4+Pgo+Pj4+Pj4+IFRoZSBkcml2ZXIg
Y2FuIHNldCB0aGUgbGluayBzdGF0ZSBkb3duIHdoZW4gdGhlIHZpcnRxdWV1ZSBpcyBicm9rZW4u
Cj4+Pj4+Pj4gSWYgdGhlIHN0YXRlIGlzIGRvd24sIHRoZSB1c2VyIGNhbiBzd2l0Y2ggb3ZlciB0
byBhbm90aGVyIE5JQy4KPj4+Pj4+IE5vdGUgdGhhdCwgd2UgcHJvYmFibHkgbmVlZCB0aGUgd2F0
Y2hkb2cgZm9yIHZpcnRpby1uZXQgaW4gb3JkZXIgdG8KPj4+Pj4+IGJlIGEgY29tcGxldGUgc29s
dXRpb24uCj4+Pj4+IFllcywgSSBjYW4gdGhpbmsgb2YgaXMgdGhhdCB0aGUgdmlydHF1ZXVlJ3Mg
YnJva2VuIGV4Y2VwdGlvbiBpcwo+Pj4+PiBkZXRlY3RlZCBvbgo+Pj4+IHdhdGNoZG9nLgo+Pj4+
PiBJcyB0aGVyZSBhbnl0aGluZyBlbHNlIHRoYXQgbmVlZHMgdG8gYmUgZG9uZT8KPj4+PiBCYXNp
Y2FsbHksIGl0J3MgYWxsIGFib3V0IFRYIHN0YWxsIHdoaWNoIHdhdGNoZG9nIHRyaWVzIHRvIGNh
dGNoLgo+Pj4+IEJyb2tlbiB2cSBpcyBvbmx5IG9uZSBvZiB0aGUgcG9zc2libGUgcmVhc29uLgo+
Pj4gQXJlIHRoZXJlIGFueSBwbGFucyBmb3IgdGhlIHdhdGNoZG9nPwo+Pgo+PiBTb21lYm9keSBw
b3N0ZWQgYSBwcm90b3R5cGUgMyBvciA0IHllYXJzIGFnbywgeW91IGNhbiBzZWFyY2ggaXQgYW5k
IG1heWJlIHdlCj4+IGNhbiBzdGFydCBmcm9tIHRoZXJlLgo+IEkgZmluZCB0aGUgcGF0Y2ggKGh0
dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9uZXRkZXYvcGF0Y2gvMjAxOTExMjYy
MDA2MjguMjIyNTEtMy1qY2ZhcmFjY29AZ21haWwuY29tLykKPgo+IFRoZSBwYXRjaCBjaGVja3Mg
b25seSB0aGUgc2NlbmFyaW8gd2hlcmUgdGhlIHNlbmRpbmcgcXVldWUgaXMgYWJub3JtYWwsIGJ1
dCBjYW4KPiBub3QgZGV0ZWN0IHRoZSBleGNlcHRpb24gaW4gdGhlIHJlY2VpdmluZyBxdWV1ZS4K
CgpJdCdzIGFsbW9zdCBpbXBvc3NpYmxlIHRvIGRldGVjdCB0aGUgYWJub3JtYWwgb2YgcmVjZWl2
aW5nIHF1ZXVlIHNpbmNlIAp3ZSB0aGVyZSdzIG5vIGRldGVybWluaXN0aWMgdGltZSBmb3IgYSBy
ZWNlaXZpbmcgcGFja2V0LgoKCj4KPiBBbmQgdGhlIHBhdGNoIHJlc3RvcmVzIHRoZSBOSUMgYnkg
cmVzZXQsIHdoaWNoIGlzIGluYXBwcm9wcmlhdGUgYmVjYXVzZSB0aGUgYnJva2VuCj4gc3RhdGUg
bWF5IGJlIGNhdXNlZCBieSBhIGZyb250LWVuZCBvciBiYWNrLWVuZCBidWcuIFdlIHNob3VsZCBr
ZWVwIHRoZSBzY2VuZSB0bwo+IGxvY2F0ZSBidWdzLgoKClRoaXMgY291bGQgYmUgY2hhbmdlZCwg
d2UgY2FuIGluY3JlYXNlIHRoZSBlcnJvciBjb3VudGVycyBhbmQgbGV0IAp1c2Vyc3BjZSB0byBk
ZWNpZGUgd2hhdCB0byBkby4KClRoYW5rcwoKCj4KPiBUaGFua3MKPgo+PiBUaGFua3MKPj4KPj4K
Pj4+IFRoYW5rcwo+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cj4+Pj4+IFRoYW5rcwo+Pj4+Pgo+
Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
