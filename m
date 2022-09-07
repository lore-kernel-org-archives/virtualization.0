Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C14C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 04:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D1CD4027A;
	Wed,  7 Sep 2022 04:21:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D1CD4027A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lpu79Qs4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-weVjtWC0v5; Wed,  7 Sep 2022 04:21:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B54D40278;
	Wed,  7 Sep 2022 04:21:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B54D40278
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D73EC0032;
	Wed,  7 Sep 2022 04:21:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95C67C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AF5981865
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:21:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AF5981865
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lpu79Qs4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohi9BDsA-KXB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:21:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E2F78183D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E2F78183D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662524481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+P+z8TSJ/Zyfj7d1c5azECG0cOYl08GFb3K30xN3HE=;
 b=Lpu79Qs4LxRlTr9nFiLQt8z3VqN1+EVqRtq9cv6L9TIFgnCJ8GNHQdijAMYVh+YHPMxLPp
 hYWm22hAlZdg7toFaJlgGO9zSV+x+/SnrjCTGC7O6CF0kQ8ogZFHtkLbHCb7na8mWB2dEO
 9OL8y22bLnAr5j8riMYXsQJtvtxGYHU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-9-mZzD2F73NHqJQQCn27IpBg-1; Wed, 07 Sep 2022 00:21:20 -0400
X-MC-Unique: mZzD2F73NHqJQQCn27IpBg-1
Received: by mail-pf1-f200.google.com with SMTP id
 u2-20020aa78482000000b0053b8d7d996fso5029500pfn.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 21:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=S+P+z8TSJ/Zyfj7d1c5azECG0cOYl08GFb3K30xN3HE=;
 b=4BjOxCTt1u3j6e09UOVQHPo3tYB2nd83SLBq3MZTaEByMMO4PpQz7hHNlOtE+OQUaN
 SCDJdOsT6eenmIVdd5w/Rdze7+idSIEfJB7B3UuvNzyw7i/3rlkAhiFchGaV6xOtGqGP
 S+IIBivVJW0l5cRkoP/K5vFABKpR2P1GL7+0dlC6PobPePC3TRKA50crfT9twCEWQVKW
 gKD14Gw2kaCuk4X8d+TjH60OU8nynejQ0GiC5wpd/xjwIutQNO60X2xb8CPGFOMBvp7I
 D50LlZRcD2/2pNctr7IPZPExc+5DXsfIyn4SjkRd5CQuY973w4dgzqj1vOlHvuNx/tKz
 LZrQ==
X-Gm-Message-State: ACgBeo0dFi+Gq/YrV7tZ36zSkLcdLWpX8G4WIv6ZCAjAHckDW6Yrm3Vo
 HMvU2mqt8vdLGQ/gvYL3uOwL4LGcBFz8zOQyhgYwNS9MkT8Lt46nhRZmAVQuonISBeBLtYkFjSW
 sghz8nnl+tpmKgp+QUrCyBP+5rYI0fFyvUsq9UyN5Xg==
X-Received: by 2002:a05:6a00:22c7:b0:53a:bea5:9abd with SMTP id
 f7-20020a056a0022c700b0053abea59abdmr1770321pfj.3.1662524479110; 
 Tue, 06 Sep 2022 21:21:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7FdPkXihchbJtJv8Jd83bDgPxk3tYbsa2yRZ4rh/+Tyemh4rXUJmUXF5h6WyCU3XNVQ3nufA==
X-Received: by 2002:a05:6a00:22c7:b0:53a:bea5:9abd with SMTP id
 f7-20020a056a0022c700b0053abea59abdmr1770291pfj.3.1662524478842; 
 Tue, 06 Sep 2022 21:21:18 -0700 (PDT)
Received: from [10.72.13.171] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 b28-20020aa78edc000000b0053ae6a3c51asm11172533pfr.186.2022.09.06.21.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Sep 2022 21:21:18 -0700 (PDT)
Message-ID: <dcf40392-26a7-b4f1-ad2c-44fac99fb330@redhat.com>
Date: Wed, 7 Sep 2022 12:21:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v3 1/7] vhost: expose used buffers
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220901055434.824-1-qtxuning1999@sjtu.edu.cn>
 <20220901055434.824-2-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220901055434.824-2-qtxuning1999@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CuWcqCAyMDIyLzkvMSAxMzo1NCwgR3VvIFpoaSDlhpnpgZM6Cj4gRm9sbG93IFZJUlRJTyAxLjEg
c3BlYywgb25seSB3cml0aW5nIG91dCBhIHNpbmdsZSB1c2VkIHJpbmcgZm9yIGEgYmF0Y2gKPiBv
ZiBkZXNjcmlwdG9ycy4KPgo+IFNpZ25lZC1vZmYtYnk6IEd1byBaaGkgPHF0eHVuaW5nMTk5OUBz
anR1LmVkdS5jbj4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDE2ICsrKysrKysr
KysrKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhv
c3Qvdmhvc3QuYwo+IGluZGV4IDQwMDk3ODI2Y2ZmMC4uMjY4NjJjOGJmNzUxIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+
IEBAIC0yMzc2LDEwICsyMzc2LDIwIEBAIHN0YXRpYyBpbnQgX192aG9zdF9hZGRfdXNlZF9uKHN0
cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxLAo+ICAgCXZyaW5nX3VzZWRfZWxlbV90IF9fdXNlciAq
dXNlZDsKPiAgIAl1MTYgb2xkLCBuZXc7Cj4gICAJaW50IHN0YXJ0Owo+ICsJaW50IGNvcHlfbiA9
IGNvdW50Owo+ICAgCj4gKwkvKioKPiArCSAqIElmIGluIG9yZGVyIGZlYXR1cmUgbmVnb3RpYXRl
ZCwgZGV2aWNlcyBjYW4gbm90aWZ5IHRoZSB1c2Ugb2YgYSBiYXRjaCBvZiBidWZmZXJzIHRvCj4g
KwkgKiB0aGUgZHJpdmVyIGJ5IG9ubHkgd3JpdGluZyBvdXQgYSBzaW5nbGUgdXNlZCByaW5nIGVu
dHJ5IHdpdGggdGhlIGlkIGNvcnJlc3BvbmRpbmcKPiArCSAqIHRvIHRoZSBoZWFkIGVudHJ5IG9m
IHRoZSBkZXNjcmlwdG9yIGNoYWluIGRlc2NyaWJpbmcgdGhlIGxhc3QgYnVmZmVyIGluIHRoZSBi
YXRjaC4KPiArCSAqLwo+ICsJaWYgKHZob3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9JTl9P
UkRFUikpIHsKPiArCQljb3B5X24gPSAxOwo+ICsJCWhlYWRzID0gJmhlYWRzW2NvdW50IC0gMV07
Cj4gKwl9CgoKV291bGQgaXQgYmV0dGVyIHRvIGhhdmUgYSBkZWRpY2F0ZWQgaGVscGVyIGxpa2Ug
CnZob3N0X2FkZF91c2VkX2luX29yZGVyKCkgaGVyZT8KCgo+ICAgCXN0YXJ0ID0gdnEtPmxhc3Rf
dXNlZF9pZHggJiAodnEtPm51bSAtIDEpOwo+ICAgCXVzZWQgPSB2cS0+dXNlZC0+cmluZyArIHN0
YXJ0Owo+IC0JaWYgKHZob3N0X3B1dF91c2VkKHZxLCBoZWFkcywgc3RhcnQsIGNvdW50KSkgewo+
ICsJaWYgKHZob3N0X3B1dF91c2VkKHZxLCBoZWFkcywgc3RhcnQsIGNvcHlfbikpIHsKPiAgIAkJ
dnFfZXJyKHZxLCAiRmFpbGVkIHRvIHdyaXRlIHVzZWQiKTsKPiAgIAkJcmV0dXJuIC1FRkFVTFQ7
Cj4gICAJfQo+IEBAIC0yMzg4LDcgKzIzOTgsNyBAQCBzdGF0aWMgaW50IF9fdmhvc3RfYWRkX3Vz
ZWRfbihzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwKPiAgIAkJc21wX3dtYigpOwo+ICAgCQkv
KiBMb2cgdXNlZCByaW5nIGVudHJ5IHdyaXRlLiAqLwo+ICAgCQlsb2dfdXNlZCh2cSwgKCh2b2lk
IF9fdXNlciAqKXVzZWQgLSAodm9pZCBfX3VzZXIgKil2cS0+dXNlZCksCj4gLQkJCSBjb3VudCAq
IHNpemVvZiAqdXNlZCk7Cj4gKwkJCSBjb3B5X24gKiBzaXplb2YoKnVzZWQpKTsKPiAgIAl9Cj4g
ICAJb2xkID0gdnEtPmxhc3RfdXNlZF9pZHg7Cj4gICAJbmV3ID0gKHZxLT5sYXN0X3VzZWRfaWR4
ICs9IGNvdW50KTsKPiBAQCAtMjQxMCw3ICsyNDIwLDcgQEAgaW50IHZob3N0X2FkZF91c2VkX24o
c3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEsIHN0cnVjdCB2cmluZ191c2VkX2VsZW0gKmhlYWRz
LAo+ICAgCj4gICAJc3RhcnQgPSB2cS0+bGFzdF91c2VkX2lkeCAmICh2cS0+bnVtIC0gMSk7Cj4g
ICAJbiA9IHZxLT5udW0gLSBzdGFydDsKPiAtCWlmIChuIDwgY291bnQpIHsKPiArCWlmIChuIDwg
Y291bnQgJiYgIXZob3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9JTl9PUkRFUikpIHsKCgpU
aGlzIHNlZW1zIHN0cmFuZ2UsIGFueSByZWFzb24gZm9yIHRoaXM/IChBY3R1YWxseSBpZiB3ZSBz
dXBwb3J0IAppbi1vcmRlciB3ZSBvbmx5IG5lZWQgb25lIHVzZWQgc2xvdCB3aGljaCBmaXQgZm9y
IHRoZSBjYXNlIGhlcmUpCgpUaGFua3MKCgo+ICAgCQlyID0gX192aG9zdF9hZGRfdXNlZF9uKHZx
LCBoZWFkcywgbik7Cj4gICAJCWlmIChyIDwgMCkKPiAgIAkJCXJldHVybiByOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
