Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E9C47082
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 01:52:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8275E610E7
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 01:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8275E610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 482C640255;
	Tue,  1 Jun 2021 01:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZvT8oii1FkX; Tue,  1 Jun 2021 01:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8DBA4026C;
	Tue,  1 Jun 2021 01:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8429DC000D;
	Tue,  1 Jun 2021 01:52:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41673C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C00260A57
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XI30NQpiH6xf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDD9360A49
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622512320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWev/Te8IAqF0czBilN1sKjy7odret07+EIptXPPlVg=;
 b=TXwF/i8V6hrGIl92RaXvW/ky4c5+dZMFRko8AV4zlFc0N0sjTXu9WZvV0YI1mUKxwVU9wP
 GXppf4zYqjR/H9eDfxZriREHOMH9aajthwl3QfA51yBlJBhQ6eq4skCksIas6XgioeICSz
 exbJ4Z4GT6XceQY+Jn6JR1UUSy0xbKQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-0Co7qtH9NROkUTPzXCZ1tg-1; Mon, 31 May 2021 21:51:58 -0400
X-MC-Unique: 0Co7qtH9NROkUTPzXCZ1tg-1
Received: by mail-pj1-f69.google.com with SMTP id
 me1-20020a17090b17c1b029015f8192660bso955814pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 18:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YWev/Te8IAqF0czBilN1sKjy7odret07+EIptXPPlVg=;
 b=Ue9bpD9agOx7LfLGDbwsbrAckK0iabwk4lp6UhC95MFdD85CZhwN8QtwIwDptOx28u
 6iPcoW1mavUk29ZWfyQVXZSV0RT62gTjhAjM7PoWhP/rINSIUQPTcAztt+Vb9JguvB8N
 N18xlUJOxS05ox4Atbn4j8YwDvyoze9zaDBGT31PI2h2RNFO8KTjZsejXJluHVP1vQUt
 1Ug2fnkW8aibijNLzZv0rlNLe5daN+2kPvoRplLGKG47VQilBKJ7H4XBjZXQMV8is8MY
 e7IPYO0IU12hFi1cPCl6SXBkwxZRpvPAMc1oVIQ14A5gUTInu+HnfpFJeGg5G5u4H0yc
 xiHg==
X-Gm-Message-State: AOAM532M5RiuWH2N+RRGGQCrw3D2DVTtxxCcr8sYHH3qSHPpVdFFTsST
 tmTpothQ8XtfQ6P7tg8tXYMOl2C93cjup0mV9+YNgy9yzYmOMF2uQPbzedCH+nCIHAiKP0hsn4E
 3Pa7sR9QP9DW+RcMgQSGZ9NyZfV3pNxR+vLLsBUn5lw==
X-Received: by 2002:a17:90a:43a6:: with SMTP id
 r35mr1957760pjg.222.1622512317826; 
 Mon, 31 May 2021 18:51:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZhUSTY2svEIOJpmqKwnCCesMbeoDS4VzTWct+zhBKdDDhqnrLsxPBRcTsNvaHlbKxAssgRw==
X-Received: by 2002:a17:90a:43a6:: with SMTP id
 r35mr1957746pjg.222.1622512317648; 
 Mon, 31 May 2021 18:51:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k12sm7581515pga.13.2021.05.31.18.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 18:51:57 -0700 (PDT)
Subject: Re: [PATCH v4] virtio-net: Add validation for used length
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, kuba@kernel.org
References: <20210531135852.113-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <32febeff-cc36-2333-5d2c-1f3ae3d91f94@redhat.com>
Date: Tue, 1 Jun 2021 09:51:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531135852.113-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNS8zMSDPws7nOTo1OCwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgYWRkcyB2YWxp
ZGF0aW9uIGZvciB1c2VkIGxlbmd0aCAobWlnaHQgY29tZQo+IGZyb20gYW4gdW50cnVzdGVkIGRl
dmljZSkgdG8gYXZvaWQgZGF0YSBjb3JydXB0aW9uCj4gb3IgbG9zcy4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgoKCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgfCAyMCArKysrKysrKysrKysrLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggMDczZmVj
NGMwZGYxLi5lZDk2OWI2NTEyNmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTczMCw2ICs3MzAsMTIg
QEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX3NtYWxsKHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsCj4gICAJbGVuIC09IHZpLT5oZHJfbGVuOwo+ICAgCXN0YXRzLT5ieXRlcyArPSBsZW47
Cj4gICAKPiArCWlmICh1bmxpa2VseShsZW4gPiBHT09EX1BBQ0tFVF9MRU4pKSB7Cj4gKwkJcHJf
ZGVidWcoIiVzOiByeCBlcnJvcjogbGVuICV1IGV4Y2VlZHMgbWF4IHNpemUgJWRcbiIsCj4gKwkJ
CSBkZXYtPm5hbWUsIGxlbiwgR09PRF9QQUNLRVRfTEVOKTsKPiArCQlkZXYtPnN0YXRzLnJ4X2xl
bmd0aF9lcnJvcnMrKzsKPiArCQlnb3RvIGVycl9sZW47Cj4gKwl9Cj4gICAJcmN1X3JlYWRfbG9j
aygpOwo+ICAgCXhkcF9wcm9nID0gcmN1X2RlcmVmZXJlbmNlKHJxLT54ZHBfcHJvZyk7Cj4gICAJ
aWYgKHhkcF9wcm9nKSB7Cj4gQEAgLTgzMyw2ICs4MzksNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1
ZmYgKnJlY2VpdmVfc21hbGwoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIGVycl94ZHA6Cj4g
ICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gICAJc3RhdHMtPnhkcF9kcm9wcysrOwo+ICtlcnJfbGVu
Ogo+ICAgCXN0YXRzLT5kcm9wcysrOwo+ICAgCXB1dF9wYWdlKHBhZ2UpOwo+ICAgeGRwX3htaXQ6
Cj4gQEAgLTg4Niw2ICs4OTMsMTIgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21l
cmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgCWhlYWRfc2tiID0gTlVMTDsKPiAg
IAlzdGF0cy0+Ynl0ZXMgKz0gbGVuIC0gdmktPmhkcl9sZW47Cj4gICAKPiArCWlmICh1bmxpa2Vs
eShsZW4gPiB0cnVlc2l6ZSkpIHsKPiArCQlwcl9kZWJ1ZygiJXM6IHJ4IGVycm9yOiBsZW4gJXUg
ZXhjZWVkcyB0cnVlc2l6ZSAlbHVcbiIsCj4gKwkJCSBkZXYtPm5hbWUsIGxlbiwgKHVuc2lnbmVk
IGxvbmcpY3R4KTsKPiArCQlkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiArCQlnb3Rv
IGVycl9za2I7Cj4gKwl9Cj4gICAJcmN1X3JlYWRfbG9jaygpOwo+ICAgCXhkcF9wcm9nID0gcmN1
X2RlcmVmZXJlbmNlKHJxLT54ZHBfcHJvZyk7Cj4gICAJaWYgKHhkcF9wcm9nKSB7Cj4gQEAgLTEw
MTIsMTMgKzEwMjUsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJfQo+ICAgCXJjdV9yZWFkX3VubG9jaygpOwo+
ICAgCj4gLQlpZiAodW5saWtlbHkobGVuID4gdHJ1ZXNpemUpKSB7Cj4gLQkJcHJfZGVidWcoIiVz
OiByeCBlcnJvcjogbGVuICV1IGV4Y2VlZHMgdHJ1ZXNpemUgJWx1XG4iLAo+IC0JCQkgZGV2LT5u
YW1lLCBsZW4sICh1bnNpZ25lZCBsb25nKWN0eCk7Cj4gLQkJZGV2LT5zdGF0cy5yeF9sZW5ndGhf
ZXJyb3JzKys7Cj4gLQkJZ290byBlcnJfc2tiOwo+IC0JfQo+IC0KPiAgIAloZWFkX3NrYiA9IHBh
Z2VfdG9fc2tiKHZpLCBycSwgcGFnZSwgb2Zmc2V0LCBsZW4sIHRydWVzaXplLCAheGRwX3Byb2cs
Cj4gICAJCQkgICAgICAgbWV0YXNpemUsICEhaGVhZHJvb20pOwo+ICAgCWN1cnJfc2tiID0gaGVh
ZF9za2I7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
