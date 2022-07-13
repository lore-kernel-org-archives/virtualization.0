Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA1EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 05:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99B094238B;
	Wed, 13 Jul 2022 05:59:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99B094238B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eoFQQJPS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPuEQzd0e28J; Wed, 13 Jul 2022 05:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E042E4238D;
	Wed, 13 Jul 2022 05:59:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E042E4238D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E436C0033;
	Wed, 13 Jul 2022 05:59:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F600C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 325304238D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 325304238D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D-_3kKe-WeYV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 114FF4238B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 114FF4238B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657691965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzD6kdHxiY7mtO/Z6JY7Tp5Pi+RySdvVPmDOY2LGqsM=;
 b=eoFQQJPS+Lf3vZo1LDu/2js+PT2/an07gcJF5gY9ulFG1RaPeYaf2M81RtZY+OEErBGLnS
 yTOqAN9txdq2PO2VDAFW+SnOKaSEIqUfsMfANGb9kyMxTAvRnUsMT2Aq8zdRFS38JVeInW
 qU7Dc4Q6CXXXuSiaKx9I9t1ChLYlTbs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-YHxoKZRTOkCOy8i6601XpA-1; Wed, 13 Jul 2022 01:59:23 -0400
X-MC-Unique: YHxoKZRTOkCOy8i6601XpA-1
Received: by mail-pf1-f198.google.com with SMTP id
 x123-20020a626381000000b005254d5e6a0fso3337832pfb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 22:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mzD6kdHxiY7mtO/Z6JY7Tp5Pi+RySdvVPmDOY2LGqsM=;
 b=vkJG8WaWIWMorQdY5BMg8EDUSK2p1EY1V8DZHIjDJ0D21dqI4r7JQHy+oO4wXqnUf4
 tFCWthJutO2DEAuq50vCTH2uKWCsuTyYcd02q8DfBCmECc3Z2x2I/hPjDNUfHHmARwIH
 lkvLNF8PcXV19TeOt+F+6TLD6TkGGHp9RrUGLLyYogqfldMNbsWPtbzYwY1OP3YdHZb9
 K2q4nilYJz6KxluNox/r4rzBjsoXd8WuEcxlGLLvKyQaA5WLxYyIiMhxCnhiuEFFrtaM
 VW7ykdqz9zZuqn5AoOK1zsLYp3X6MDnPtVwEYajEUUBXnycKI8TtT1RyfIMUnOxfjyn7
 dn/g==
X-Gm-Message-State: AJIora8xXZihM+RmOZyRqhPpvZMsGWumAmDy+DGCPQZ8eJZAnvmbp6JP
 W8OQtPEfHyaK0QnGazXAD+4ZjEegYYxXt5dnOT1pZDuToqz6O9OarJ5ij9kHwhb/+b3RMnk0O01
 +ZiV0y7ZgcM2oGa/yS6mPDg62XocMlMP2znb/Y2ezhA==
X-Received: by 2002:a05:6a00:319c:b0:52a:ccb2:ee0b with SMTP id
 bj28-20020a056a00319c00b0052accb2ee0bmr1537210pfb.59.1657691962687; 
 Tue, 12 Jul 2022 22:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uWhjXpvdfdtRhWbr1DHQCetvgqmrYhUYE0vPFHOhNUEsXrMGuKxs6K+M0pz7/rLa0NzPcRMQ==
X-Received: by 2002:a05:6a00:319c:b0:52a:ccb2:ee0b with SMTP id
 bj28-20020a056a00319c00b0052accb2ee0bmr1537192pfb.59.1657691962403; 
 Tue, 12 Jul 2022 22:59:22 -0700 (PDT)
Received: from [10.72.12.200] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 t123-20020a625f81000000b0052842527052sm7769513pfb.189.2022.07.12.22.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 22:59:21 -0700 (PDT)
Message-ID: <44610c2a-9fd1-8d15-a792-a96900e89424@redhat.com>
Date: Wed, 13 Jul 2022 13:59:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] vduse: Use memcpy_{to,from}_page() in do_bounce()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 xiaodong.liu@intel.com, maxime.coquelin@redhat.com, stefanha@redhat.com
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220706050503.171-3-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 songmuchun@bytedance.com
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

CuWcqCAyMDIyLzcvNiAxMzowNSwgWGllIFlvbmdqaSDlhpnpgZM6Cj4ga21hcF9hdG9taWMoKSBp
cyBiZWluZyBkZXByZWNhdGVkIGluIGZhdm9yIG9mIGttYXBfbG9jYWxfcGFnZSgpLgo+Cj4gVGhl
IHVzZSBvZiBrbWFwX2F0b21pYygpIGluIGRvX2JvdW5jZSgpIGlzIGFsbCB0aHJlYWQgbG9jYWwg
dGhlcmVmb3JlCj4ga21hcF9sb2NhbF9wYWdlKCkgaXMgYSBzdWZmaWNpZW50IHJlcGxhY2VtZW50
Lgo+Cj4gQ29udmVydCB0byBrbWFwX2xvY2FsX3BhZ2UoKSBidXQsIGluc3RlYWQgb2Ygb3BlbiBj
b2RpbmcgaXQsCj4gdXNlIHRoZSBoZWxwZXJzIG1lbWNweV90b19wYWdlKCkgYW5kIG1lbWNweV9m
cm9tX3BhZ2UoKS4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRl
ZGFuY2UuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmMgfCA5ICsrKyst
LS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmMgYi9k
cml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmMKPiBpbmRleCBiY2ExZjBiODg1MGMu
LjUwZDdjMDhkNTQ1MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFf
ZG9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL2lvdmFfZG9tYWluLmMKPiBA
QCAtMTM4LDE4ICsxMzgsMTcgQEAgc3RhdGljIHZvaWQgZG9fYm91bmNlKHBoeXNfYWRkcl90IG9y
aWcsIHZvaWQgKmFkZHIsIHNpemVfdCBzaXplLAo+ICAgewo+ICAgCXVuc2lnbmVkIGxvbmcgcGZu
ID0gUEZOX0RPV04ob3JpZyk7Cj4gICAJdW5zaWduZWQgaW50IG9mZnNldCA9IG9mZnNldF9pbl9w
YWdlKG9yaWcpOwo+IC0JY2hhciAqYnVmZmVyOwo+ICsJc3RydWN0IHBhZ2UgKnBhZ2U7Cj4gICAJ
dW5zaWduZWQgaW50IHN6ID0gMDsKPiAgIAo+ICAgCXdoaWxlIChzaXplKSB7Cj4gICAJCXN6ID0g
bWluX3Qoc2l6ZV90LCBQQUdFX1NJWkUgLSBvZmZzZXQsIHNpemUpOwo+ICAgCj4gLQkJYnVmZmVy
ID0ga21hcF9hdG9taWMocGZuX3RvX3BhZ2UocGZuKSk7Cj4gKwkJcGFnZSA9IHBmbl90b19wYWdl
KHBmbik7Cj4gICAJCWlmIChkaXIgPT0gRE1BX1RPX0RFVklDRSkKPiAtCQkJbWVtY3B5KGFkZHIs
IGJ1ZmZlciArIG9mZnNldCwgc3opOwo+ICsJCQltZW1jcHlfZnJvbV9wYWdlKGFkZHIsIHBhZ2Us
IG9mZnNldCwgc3opOwo+ICAgCQllbHNlCj4gLQkJCW1lbWNweShidWZmZXIgKyBvZmZzZXQsIGFk
ZHIsIHN6KTsKPiAtCQlrdW5tYXBfYXRvbWljKGJ1ZmZlcik7Cj4gKwkJCW1lbWNweV90b19wYWdl
KHBhZ2UsIG9mZnNldCwgYWRkciwgc3opOwo+ICAgCj4gICAJCXNpemUgLT0gc3o7Cj4gICAJCXBm
bisrOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
