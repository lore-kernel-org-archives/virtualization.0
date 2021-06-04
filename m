Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E9C47096
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:32:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD2B61287
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD2B61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCD2C40698;
	Fri,  4 Jun 2021 02:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FoPVBOdP_16k; Fri,  4 Jun 2021 02:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C7FA40697;
	Fri,  4 Jun 2021 02:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20405C000D;
	Fri,  4 Jun 2021 02:32:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 088F9C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E553584389
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0SoM-xkdsomL
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:32:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EB4484380
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622773922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ER+R9Jl5XhwxccKJlvpYXmmwxORWURurFR7gOzA5Ic=;
 b=FMk9ISbfdNLlo+s+4ap9rguVry2j/OWRhI5H0dinQb2NiXua+ah/rGlutE8fuHp0pB61yV
 bHqmrcu0z/0n92IzDcuSVMpkZVZb3xFdp9vbzea5FOFe8q/A+wAxQSh5DxNTrRy7F1lA7p
 Mx04U+g9wVqLvHzDvjbq8gwDtaCuaWc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-HH3t6__KO2OR9XcWnnH7Jg-1; Thu, 03 Jun 2021 22:32:00 -0400
X-MC-Unique: HH3t6__KO2OR9XcWnnH7Jg-1
Received: by mail-pg1-f199.google.com with SMTP id
 w185-20020a6362c20000b02902208d90c8c8so4262207pgb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 19:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1ER+R9Jl5XhwxccKJlvpYXmmwxORWURurFR7gOzA5Ic=;
 b=jVtaSHBpC8to2FSw0KxeSriJb6RcCGCxbZoTDH+VnFh91dHjt3vXb+duzTXR8kVUO2
 4QUpk+6QvYCvBmqMBAAH1KefK8MYkSVfPZ+u9jRHjRFteWtrYV6NieC328kLeDUX6Tkn
 jlZ+25IaoCazLO/aeYZj9ySrnqex3Yw4y4m4Yn3yTslvfbAmjMCYl9q/TF3bFhwuMLqi
 BTkSjcv39Tuhe8b9+Kx7PjQrr2q1wjbiLEqAHXs3ql7m73RuGywKVorpvgRKPaSOLFva
 ZGMP/Di4F80QyF40mWkaoyu5szHwB3iPrldMamrW5Q0cGhEYjYdCbSBaO34lUfK/qekI
 5upQ==
X-Gm-Message-State: AOAM533kfagFxPb+OdbhRyk5IVHzEyEOuDTvCD0v8UHhIiZh7an05yAF
 ZADeYsC6kgxc7qi3Hwt9rImn1+4ZeqM/vNgQ4c95MJC/RfSxUwonOJJNKe1+ikSbF/cVxlrIqYJ
 5D9JZw5M2fdnfx4d2bg/rL15+SjfCcc1OUCw1wwSmeA==
X-Received: by 2002:a63:803:: with SMTP id 3mr2524809pgi.344.1622773919607;
 Thu, 03 Jun 2021 19:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTA1Z9LbyV3J3zEgf7+sU1jjmtq1JtXpQlvGr520SAKpAwmN2o24N1cV3orayvrMF19LfnZA==
X-Received: by 2002:a63:803:: with SMTP id 3mr2524794pgi.344.1622773919394;
 Thu, 03 Jun 2021 19:31:59 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l8sm363994pgq.49.2021.06.03.19.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:31:58 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa/mlx5: Add support for doorbell bypassing
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210603081153.5750-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <21c3bf84-7caf-cc64-2432-b19f46622fb9@redhat.com>
Date: Fri, 4 Jun 2021 10:31:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603081153.5750-1-elic@nvidia.com>
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

CtTaIDIwMjEvNi8zIM/Czuc0OjExLCBFbGkgQ29oZW4g0LS1wDoKPiBJbXBsZW1lbnQgbWx4NV9n
ZXRfdnFfbm90aWZpY2F0aW9uKCkgdG8gcmV0dXJuIHRoZSBkb29yYmVsbCBhZGRyZXNzLgo+IFNp
bmNlIHRoZSBub3RpZmljYXRpb24gYXJlYSBpcyBtYXBwZWQgdG8gdXNlcnNwYWNlLCBtYWtlIHN1
cmUgdGhhdCB0aGUKPiBCQVIgc2l6ZSBpcyBhdCBsZWFzdCBQQUdFX1NJWkUgbGFyZ2UuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiB2MCAtLT4g
djE6Cj4gICAgTWFrZSBzdXJlIFNGIGJhciBzaXplIGlzIG5vdCBzbWFsbGVyIHRoYW4gUEFHRV9T
SVpFCj4gdjEgLS0+IHYyOgo+ICAgIFJlbW92ZSB0ZXN0IG9uIGFkZHIgYWxpZ25tZW50IHNpbmNl
IGl0J3MgYWxyYWR5IGRvbmUgYnkgdGhlIGNhbGxlci4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+Cj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVf
dmRwYS5oIHwgIDEgKwo+ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYyB8ICAx
ICsKPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAxNCArKysrKysrKysr
KysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbWx4NV92ZHBhLmgKPiBpbmRleCAwOWExNmEzZDFiMmEuLjAwMDJiMjEzNmI0OCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gKysrIGIvZHJp
dmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+IEBAIC00Miw2ICs0Miw3IEBAIHN0cnVj
dCBtbHg1X3ZkcGFfcmVzb3VyY2VzIHsKPiAgIAl1MzIgcGRuOwo+ICAgCXN0cnVjdCBtbHg1X3Vh
cnNfcGFnZSAqdWFyOwo+ICAgCXZvaWQgX19pb21lbSAqa2lja19hZGRyOwo+ICsJdTY0IHBoeXNf
a2lja19hZGRyOwo+ICAgCXUxNiB1aWQ7Cj4gICAJdTMyIG51bGxfbWtleTsKPiAgIAlib29sIHZh
bGlkOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIGIv
ZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYwo+IGluZGV4IDgzNmFiOWVmMGZhNi4u
ZDQ2MDYyMTNmODhhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3Vy
Y2VzLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4gQEAgLTI1
Myw2ICsyNTMsNyBAQCBpbnQgbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYpCj4gICAJCWdvdG8gZXJyX2tleTsKPiAgIAo+ICAgCWtpY2tfYWRkciA9
IG1kZXYtPmJhcl9hZGRyICsgb2Zmc2V0Owo+ICsJcmVzLT5waHlzX2tpY2tfYWRkciA9IGtpY2tf
YWRkcjsKPiAgIAo+ICAgCXJlcy0+a2lja19hZGRyID0gaW9yZW1hcChraWNrX2FkZHIsIFBBR0Vf
U0laRSk7Cj4gICAJaWYgKCFyZXMtPmtpY2tfYWRkcikgewo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiBpbmRleCA2ODlkM2ZhNjFlMDguLmJjMzNmMmM1MjNkMyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMTg3OSw4ICsxODc5LDIyIEBAIHN0YXRpYyB2b2lkIG1s
eDVfdmRwYV9mcmVlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiAgIAo+ICAgc3RhdGljIHN0
cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIG1seDVfZ2V0X3ZxX25vdGlmaWNhdGlvbihzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpCj4gICB7Cj4gKwlzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPiAgIAlzdHJ1Y3QgdmRwYV9ub3RpZmljYXRp
b25fYXJlYSByZXQgPSB7fTsKPiArCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2Owo+ICsJcGh5
c19hZGRyX3QgYWRkcjsKPiAgIAo+ICsJLyogSWYgU0YgQkFSIHNpemUgaXMgc21hbGxlciB0aGFu
IFBBR0VfU0laRSwgZG8gbm90IHVzZSBkaXJlY3QKPiArCSAqIG5vdGlmaWNhdGlvbiB0byBhdm9p
ZCB0aGUgcmlzayBvZiBtYXBwaW5nIHBhZ2VzIHRoYXQgY29udGFpbiBCQVIgb2YgbW9yZQo+ICsJ
ICogdGhhbiBvbmUgU0YKPiArCSAqLwo+ICsJaWYgKE1MWDVfQ0FQX0dFTihtdmRldi0+bWRldiwg
bG9nX21pbl9zZl9zaXplKSArIDEyIDwgUEFHRV9TSElGVCkKPiArCQlyZXR1cm4gcmV0Owo+ICsK
PiArCW5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gKwlhZGRyID0gKHBoeXNfYWRk
cl90KW5kZXYtPm12ZGV2LnJlcy5waHlzX2tpY2tfYWRkcjsKPiArCXJldC5hZGRyID0gYWRkcjsK
PiArCXJldC5zaXplID0gUEFHRV9TSVpFOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
