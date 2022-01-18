Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D8C4332F
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 03:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D1A760C17;
	Tue, 18 Jan 2022 03:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8MerP0cqE-QE; Tue, 18 Jan 2022 03:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A262960C12;
	Tue, 18 Jan 2022 03:07:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F8EC0039;
	Tue, 18 Jan 2022 03:07:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB735C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8D5260C17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ORMgkOjXwLVz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9064B60C12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642475215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/T+xqeUAypi/EBSYpJv9W0hZEqvgrZKwX4x1rH2s4Q=;
 b=R9GAkdRUmtvD206/k1gB0uLL8G8FFIlUlPWpb2sBFqKyV94oCC9zoMeFUit9lLzULFkdRa
 7bq1ROFfbW88EFibSRSJQkvjP50iesFAlyHFc5qg5uvmZv9Byi+kc8DxiYbJB9qujtmfky
 YRPO/CuK8eP394aOY3es/KBrUHRxidI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-lA2bhZThO7W6N5cE7XvZDw-1; Mon, 17 Jan 2022 22:06:52 -0500
X-MC-Unique: lA2bhZThO7W6N5cE7XvZDw-1
Received: by mail-pj1-f72.google.com with SMTP id
 d92-20020a17090a6f6500b001b35ac5f393so11745273pjk.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 19:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=m/T+xqeUAypi/EBSYpJv9W0hZEqvgrZKwX4x1rH2s4Q=;
 b=5DkmBirAS5nYtHzMn/Zrm7JbUDHliO/xDN8a6Z3sT2wu7lR4SvTKcqzCzRhsyRMxK3
 r8s9f5kNtdbdwpDR6ZoQ/GmdG197ngjhcM9/r/sEaFOGNXqFmNloQaDZFTT66lwaBkmL
 zBmVoMVbo3rNf+FuPr/MWdp+6VtOcQytNVfCAqyvAgKbfLr87OrnDVcNJghBNzir/96v
 no2YXBVo2dzO2mtIf6v2EZQ4OGHY2hqBJEZ05B50SnIsYXzt4kCW/vqq29MINemuAZtR
 ieutBEi5vdpMoMyubri2OiFM7cHnCNJMS4reQ0l1VdyBOcB+wPaEYeIwWI14iK2pj87N
 o6Aw==
X-Gm-Message-State: AOAM530JD8UhKrugTJ18mn1fkHjOibMwda3CebRZcBDjxEAKIlzrFYuv
 nIOjf/XvsfviEu5tR403qfjyDIJGRw7+qSAmSG3a5WY8ih24lP/vmn9sxA5XvZ1wPnwmb/UHQzU
 QXx/WYrtD9kqsBoqvdIkhSIHsZqgMmiCJdHlh+JwTHA==
X-Received: by 2002:a17:902:d505:b0:14a:77ac:1e8b with SMTP id
 b5-20020a170902d50500b0014a77ac1e8bmr25111385plg.1.1642475211597; 
 Mon, 17 Jan 2022 19:06:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoQYXGFOiuE7DE7WvP6A/zKMhsh+2K8vED7mN/UdEi/ZVq6aYj54hRESwmfzpInEWZa5o65A==
X-Received: by 2002:a17:902:d505:b0:14a:77ac:1e8b with SMTP id
 b5-20020a170902d50500b0014a77ac1e8bmr25111367plg.1.1642475211348; 
 Mon, 17 Jan 2022 19:06:51 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c19sm15280757pfo.91.2022.01.17.19.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jan 2022 19:06:50 -0800 (PST)
Message-ID: <ce3890b8-8f48-847d-b029-e29cc9261f18@redhat.com>
Date: Tue, 18 Jan 2022 11:06:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC 1/3] vdpa: support exposing the config size to userspace
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com
References: <20220117092921.1573-1-longpeng2@huawei.com>
 <20220117092921.1573-2-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220117092921.1573-2-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvMTcg5LiL5Y2INToyOSwgTG9uZ3BlbmcoTWlrZSkg5YaZ6YGTOgo+IEZyb206
IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPgo+IC0gR0VUX0NPTkZJR19TSVpFOiB0
aGUgc2l6ZSBvZiB0aGUgdmlydGlvIGNvbmZpZyBzcGFjZQoKCkkgdGhpbmsgd2UgbmVlZCB0byBi
ZSB2ZXJib3NlIGhlcmUuIEFuZCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcXVvdGUgd2hhdCAKc3Bl
YyBzYWlkOgoKIgoKVGhlIGRldmljZSBNVVNUIGFsbG93IHJlYWRpbmcgb2YgYW55IGRldmljZS1z
cGVjaWZpYyBjb25maWd1cmF0aW9uIGZpZWxkIApiZWZvcmUgRkVBVFVSRVNfT0sgaXMgc2V0IGJ5
IHRoZSBkcml2ZXIuIFRoaXMgaW5jbHVkZXMgZmllbGRzIHdoaWNoIGFyZSAKY29uZGl0aW9uYWwg
b24gZmVhdHVyZSBiaXRzLCBhcyBsb25nIGFzIHRob3NlIGZlYXR1cmUgYml0cyBhcmUgb2ZmZXJl
ZCAKYnkgdGhlIGRldmljZS4KCiIKCkkgZ3Vlc3MgdGhlIHNpemUgc2hvdWxkIGNvbnRhaW4gdGhl
IGNvbmRpdGlvbmFsIG9uIGZlYXR1cmVzIGJpdHMuCgooT3IgbWF5YmUgd2UgbmVlZCB0byB0d2Vh
ayB0aGUgY29tbWVudCBmb3IgZ2V0X2NvbmZpZ19zaXplIGFzIHdlbGwpLgoKT3RoZXIgbG9va3Mg
Z29vZC4KClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1
YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICB8IDE3ICsrKysr
KysrKysrKysrKysrCj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaCB8ICA0ICsrKysKPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCAyOWNjZWQxY2Qy
NzcuLjFlZWExNGE0ZWE1NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsr
KyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTM1NSw2ICszNTUsMjAgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIF9f
dXNlciAqYXJncCkKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgbG9uZyB2aG9z
dF92ZHBhX2dldF9jb25maWdfc2l6ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIF9fdXNlciAq
YXJncCkKPiArewo+ICsJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPiArCWNv
bnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiArCXUzMiBz
aXplOwo+ICsKPiArCXNpemUgPSBvcHMtPmdldF9jb25maWdfc2l6ZSh2ZHBhKTsKPiArCj4gKwlp
ZiAoY29weV90b191c2VyKGFyZ3AsICZzaXplLCBzaXplb2Yoc2l6ZSkpKQo+ICsJCXJldHVybiAt
RUZBVUxUOwo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGxvbmcgdmhvc3Rf
dmRwYV92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwK
PiAgIAkJCQkgICB2b2lkIF9fdXNlciAqYXJncCkKPiAgIHsKPiBAQCAtNDkyLDYgKzUwNiw5IEBA
IHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVw
LAo+ICAgCWNhc2UgVkhPU1RfVkRQQV9HRVRfSU9WQV9SQU5HRToKPiAgIAkJciA9IHZob3N0X3Zk
cGFfZ2V0X2lvdmFfcmFuZ2UodiwgYXJncCk7Cj4gICAJCWJyZWFrOwo+ICsJY2FzZSBWSE9TVF9W
RFBBX0dFVF9DT05GSUdfU0laRToKPiArCQlyID0gdmhvc3RfdmRwYV9nZXRfY29uZmlnX3NpemUo
diwgYXJncCk7Cj4gKwkJYnJlYWs7Cj4gICAJZGVmYXVsdDoKPiAgIAkJciA9IHZob3N0X2Rldl9p
b2N0bCgmdi0+dmRldiwgY21kLCBhcmdwKTsKPiAgIAkJaWYgKHIgPT0gLUVOT0lPQ1RMQ01EKQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaCBiL2luY2x1ZGUvdWFwaS9s
aW51eC92aG9zdC5oCj4gaW5kZXggYzk5ODg2MGQ3YmJjLi5iYzc0ZTk1YTI3M2EgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvdmhvc3QuaAo+IEBAIC0xNTAsNCArMTUwLDggQEAKPiAgIC8qIEdldCB0aGUgdmFsaWQgaW92
YSByYW5nZSAqLwo+ICAgI2RlZmluZSBWSE9TVF9WRFBBX0dFVF9JT1ZBX1JBTkdFCV9JT1IoVkhP
U1RfVklSVElPLCAweDc4LCBcCj4gICAJCQkJCSAgICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9y
YW5nZSkKPiArCj4gKy8qIEdldCB0aGUgY29uZmlnIHNpemUgKi8KPiArI2RlZmluZSBWSE9TVF9W
RFBBX0dFVF9DT05GSUdfU0laRQlfSU9SKFZIT1NUX1ZJUlRJTywgMHg3OSwgX191MzIpCj4gKwo+
ICAgI2VuZGlmCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
