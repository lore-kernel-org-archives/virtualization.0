Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A2C04AA5
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 07:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26B0283300;
	Thu, 25 Aug 2022 07:01:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26B0283300
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dqudO+KP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3NU2KoeU0f5A; Thu, 25 Aug 2022 07:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C183D832C9;
	Thu, 25 Aug 2022 07:01:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C183D832C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8349FC0033;
	Thu, 25 Aug 2022 07:01:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20CA8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D874941853
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:01:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D874941853
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dqudO+KP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aZbe3kbP3qkR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:01:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9428F415D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9428F415D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661410906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7Q/XXN1Xt6SZJFciYXpFS6HHcnYgr65n/puG7GgfQY=;
 b=dqudO+KP0XBwEyIcTvG4u8o9S3ck+PPSfeLXQJsHlascGQ269J8JObDfhjO2qYygB4ebtQ
 Df3FjhB6Pr7Q3RZ/Ukyn1JtFUqmIwEKHpDAqS14Aek3lbRsMDU2YX+wwRwyIJBT7SQ0IBG
 OwHbeQ3ipaPJhf5CF0iUJe/35UOm9SA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-A9HCMxYCNxC_ppomyKBhSw-1; Thu, 25 Aug 2022 03:01:39 -0400
X-MC-Unique: A9HCMxYCNxC_ppomyKBhSw-1
Received: by mail-pj1-f71.google.com with SMTP id
 z8-20020a17090a014800b001fac4204c7eso2029781pje.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 00:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=+7Q/XXN1Xt6SZJFciYXpFS6HHcnYgr65n/puG7GgfQY=;
 b=DhKbxr+rpsd+g+H+2uhVK1RQQHsBZ7BSKzjYeSCPcAhHK5PoYDd8wOArBoCbsEuMlr
 gg4qZQXSV7LwGAA0HSA/upuYEH7cWZpyZHRzUSzpYeCv3aPI+7HHgxtn1lQ99+seRm+8
 UEK8bvn6GhLfmxiEFoz+3yV2mnAGJJR1cYgjjImCG50PjVftb+NZUvsTRuZmrsSn7sSj
 2zbjaE1vPEzXBPc9bwS8Ei4rEp/1JOKMmKyM/k7FvxkPKLMCL9pZXfUOUETi7jqdu2BN
 WxPlTQG1/OYLgEnb77JBFc3W9/AFutiUNahsZzPfFMseS9SF3BnmagTKv/tY+fJ99Mcm
 nBug==
X-Gm-Message-State: ACgBeo1/FHeMs8bj38RBjN4bMJcWcOgCYXyJCqd70q7cnjXITXqWAjc7
 qvqLmsYGEtP99KFDgKhJKkzg3g5Ca/HKyyZo6jxShQjiK0V+pT4E1y+GfFxIUNVTGig4rk/Zdm9
 5EXzHfb19fPQAOn+DUIcyMYFH6JySDYYC+Dml6HrTiA==
X-Received: by 2002:a17:90a:1b69:b0:1fa:f9de:fbcf with SMTP id
 q96-20020a17090a1b6900b001faf9defbcfmr11990637pjq.201.1661410898348; 
 Thu, 25 Aug 2022 00:01:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fQhngR98Oeq2+dGcVYZV3kfTv/ZlLWB36qK/slHkYNTgX2VUISGCAUCdxzL/7nf+paX9Aow==
X-Received: by 2002:a17:90a:1b69:b0:1fa:f9de:fbcf with SMTP id
 q96-20020a17090a1b6900b001faf9defbcfmr11990595pjq.201.1661410897994; 
 Thu, 25 Aug 2022 00:01:37 -0700 (PDT)
Received: from [10.72.12.107] ([119.254.120.70])
 by smtp.gmail.com with ESMTPSA id
 12-20020a17090a034c00b001fb438fb772sm2609158pjf.56.2022.08.25.00.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:01:37 -0700 (PDT)
Message-ID: <3a184162-afdc-9103-e786-66d796389e3a@redhat.com>
Date: Thu, 25 Aug 2022 15:01:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v2 1/7] vhost: expose used buffers
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-2-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817135718.2553-2-qtxuning1999@sjtu.edu.cn>
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

CuWcqCAyMDIyLzgvMTcgMjE6NTcsIEd1byBaaGkg5YaZ6YGTOgo+IEZvbGxvdyBWSVJUSU8gMS4x
IHNwZWMsIG9ubHkgd3JpdGluZyBvdXQgYSBzaW5nbGUgdXNlZCByaW5nIGZvciBhIGJhdGNoCj4g
b2YgZGVzY3JpcHRvcnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBHdW8gWmhpIDxxdHh1bmluZzE5OTlA
c2p0dS5lZHUuY24+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxNCArKysrKysr
KysrKystLQo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5oIHwgIDEgKwo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IGluZGV4IDQwMDk3
ODI2Y2ZmMC4uN2IyMGZhNWE0NmMzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3Qu
Ywo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IEBAIC0yMzc2LDEwICsyMzc2LDIwIEBA
IHN0YXRpYyBpbnQgX192aG9zdF9hZGRfdXNlZF9uKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZx
LAo+ICAgCXZyaW5nX3VzZWRfZWxlbV90IF9fdXNlciAqdXNlZDsKPiAgIAl1MTYgb2xkLCBuZXc7
Cj4gICAJaW50IHN0YXJ0Owo+ICsJaW50IGNvcHlfbiA9IGNvdW50Owo+ICAgCj4gKwkvKioKPiAr
CSAqIElmIGluIG9yZGVyIGZlYXR1cmUgbmVnb3RpYXRlZCwgZGV2aWNlcyBjYW4gbm90aWZ5IHRo
ZSB1c2Ugb2YgYSBiYXRjaCBvZiBidWZmZXJzIHRvCj4gKwkgKiB0aGUgZHJpdmVyIGJ5IG9ubHkg
d3JpdGluZyBvdXQgYSBzaW5nbGUgdXNlZCByaW5nIGVudHJ5IHdpdGggdGhlIGlkIGNvcnJlc3Bv
bmRpbmcKPiArCSAqIHRvIHRoZSBoZWFkIGVudHJ5IG9mIHRoZSBkZXNjcmlwdG9yIGNoYWluIGRl
c2NyaWJpbmcgdGhlIGxhc3QgYnVmZmVyIGluIHRoZSBiYXRjaC4KPiArCSAqLwo+ICsJaWYgKHZo
b3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9JTl9PUkRFUikpIHsKPiArCQljb3B5X24gPSAx
Owo+ICsJCWhlYWRzID0gJmhlYWRzW2NvdW50IC0gMV07CgoKRG8gd2UgbmVlZCB0byBjaGVjayB3
aGV0aGVyIG9yIG5vdCB0aGUgYnVmZmVyIGlzIGZ1bGx5IHVzZWQgYmVmb3JlIGRvaW5nIAp0aGlz
PwoKCj4gKwl9Cj4gICAJc3RhcnQgPSB2cS0+bGFzdF91c2VkX2lkeCAmICh2cS0+bnVtIC0gMSk7
Cj4gICAJdXNlZCA9IHZxLT51c2VkLT5yaW5nICsgc3RhcnQ7Cj4gLQlpZiAodmhvc3RfcHV0X3Vz
ZWQodnEsIGhlYWRzLCBzdGFydCwgY291bnQpKSB7Cj4gKwlpZiAodmhvc3RfcHV0X3VzZWQodnEs
IGhlYWRzLCBzdGFydCwgY29weV9uKSkgewo+ICAgCQl2cV9lcnIodnEsICJGYWlsZWQgdG8gd3Jp
dGUgdXNlZCIpOwo+ICAgCQlyZXR1cm4gLUVGQVVMVDsKPiAgIAl9Cj4gQEAgLTI0MTAsNyArMjQy
MCw3IEBAIGludCB2aG9zdF9hZGRfdXNlZF9uKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxLCBz
dHJ1Y3QgdnJpbmdfdXNlZF9lbGVtICpoZWFkcywKPiAgIAo+ICAgCXN0YXJ0ID0gdnEtPmxhc3Rf
dXNlZF9pZHggJiAodnEtPm51bSAtIDEpOwo+ICAgCW4gPSB2cS0+bnVtIC0gc3RhcnQ7Cj4gLQlp
ZiAobiA8IGNvdW50KSB7Cj4gKwlpZiAobiA8IGNvdW50ICYmICF2aG9zdF9oYXNfZmVhdHVyZSh2
cSwgVklSVElPX0ZfSU5fT1JERVIpKSB7Cj4gICAJCXIgPSBfX3Zob3N0X2FkZF91c2VkX24odnEs
IGhlYWRzLCBuKTsKPiAgIAkJaWYgKHIgPCAwKQo+ICAgCQkJcmV0dXJuIHI7Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaCBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+IGluZGV4
IGQ5MTA5MTA3YWYwOC4uMGQ1YzQ5YTMwNDIxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dmhvc3QuaAo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+IEBAIC0yMzYsNiArMjM2LDcg
QEAgZW51bSB7Cj4gICAJVkhPU1RfRkVBVFVSRVMgPSAoMVVMTCA8PCBWSVJUSU9fRl9OT1RJRllf
T05fRU1QVFkpIHwKPiAgIAkJCSAoMVVMTCA8PCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0Mp
IHwKPiAgIAkJCSAoMVVMTCA8PCBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCkgfAo+ICsJCQkgKDFV
TEwgPDwgVklSVElPX0ZfSU5fT1JERVIpIHwKPiAgIAkJCSAoMVVMTCA8PCBWSE9TVF9GX0xPR19B
TEwpIHwKCgpBcmUgd2Ugc3VyZSBhbGwgdmhvc3QgZGV2aWNlcyBjYW4gc3VwcG9ydCBpbi1vcmRl
ciAoZXNwZWNpYWxseSB0aGUgU0NTSSk/CgpJdCBsb29rcyBiZXR0ZXIgdG8gc3RhcnQgZnJvbSBh
IGRldmljZSBzcGVjaWZpYyBvbmUuCgpUaGFua3MKCgo+ICAgCQkJICgxVUxMIDw8IFZJUlRJT19G
X0FOWV9MQVlPVVQpIHwKPiAgIAkJCSAoMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
