Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A7C4708F
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:50:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C9D6138C
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C9D6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09321607CC;
	Tue,  1 Jun 2021 08:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id idj5mUDGa0o7; Tue,  1 Jun 2021 08:50:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E64D607CB;
	Tue,  1 Jun 2021 08:50:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E84FCC000D;
	Tue,  1 Jun 2021 08:50:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91346C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E6A4607CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_uwkQbsGpz7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:50:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D00E6607CB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622537409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yivOBnqcmrnUcZvCryP/43pugu1L6MME5PS60ENJv/M=;
 b=VpC5Zx2YHiy4dgxA5d08V1E7vD8d/+VLduV8+49cylMY0cepW2hoeeVHYEvlgPH0QH6zUZ
 vXXVDXI49r+owo2cjdv0aYDqqagG/+VYe9ktRNVYMq+gHFkjS3kATk/gn4Au7A6ZL1jAFO
 5KtegIrbmR/n9JHMg8BADR+KUTGAi08=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-ZAeWdBlkPeuMGgeEAWmW9A-1; Tue, 01 Jun 2021 04:50:08 -0400
X-MC-Unique: ZAeWdBlkPeuMGgeEAWmW9A-1
Received: by mail-pg1-f198.google.com with SMTP id
 m7-20020a6545c70000b029020f6af21c77so8510978pgr.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 01:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yivOBnqcmrnUcZvCryP/43pugu1L6MME5PS60ENJv/M=;
 b=fURbsttktW8qwUTabkYn5+92nb185aOz34+Wvm14Jw+Dqqv1iW04AuDa423c2R0A0m
 aUjzK3xmnNPnm3f0Kl1NH22VK+G/4g61ls+Pr1xzZhSBn/KuhEG2PrwWB3PqOhl6Ikcn
 2fWUsH2LbHv4NtZE1d4PUDUDDN0AXS2513VN5jyKdrjy45agVJzVAn6l9fdZHRzcxVEs
 QOQ83b4hrnJYQxNX/pE7ejXxCHkOGX1CqSKSTYIdOvEFLXEAEYhd142ugzZ6CMdanU4B
 9q4DK04qjUMBO1xzZDh0BwKtxidr8+aDp8R+IqvR/CiT5K+6QAvZppWYYLy5pYxT2WIg
 9BTg==
X-Gm-Message-State: AOAM532KT95nEiN83oOoWAUaifiHzN76cJDsIxd2ECHJvxLbucLrvCxE
 VjxpTOKkO/YzftmhOzuzgXsEIVaYOT6J5oQJQKJwbsW3Yhk5U2xFebVyG6KG9IssQUnOdlm//LR
 0c625oIYiEYxI3mbqXFu9+nJbH0+9AJ1PGrMlpgLjEQ==
X-Received: by 2002:a17:90a:7e07:: with SMTP id
 i7mr12184737pjl.191.1622537407265; 
 Tue, 01 Jun 2021 01:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFpMEfUtTyPNfxXRLulAlYn/bEwbtUZktwkJFm+B/PvV/oT/iXyBBlyR0tLL37DB2ceP1RKw==
X-Received: by 2002:a17:90a:7e07:: with SMTP id
 i7mr12184726pjl.191.1622537407093; 
 Tue, 01 Jun 2021 01:50:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f16sm13071239pju.12.2021.06.01.01.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 01:50:06 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] vDPA/ifcvf: implement doorbell mapping for ifcvf
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210601062850.4547-1-lingshan.zhu@intel.com>
 <20210601062850.4547-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d286a8f9-ac5c-ba95-777e-df926ea45292@redhat.com>
Date: Tue, 1 Jun 2021 16:50:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601062850.4547-3-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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

CtTaIDIwMjEvNi8xIM/CzucyOjI4LCBaaHUgTGluZ3NoYW4g0LS1wDoKPiBUaGlzIGNvbW1pdCBp
bXBsZW1lbnRzIGRvb3JiZWxsIG1hcHBpbmcgZmVhdHVyZSBmb3IgaWZjdmYuCj4gVGhpcyBmZWF0
dXJlIG1hcHMgdGhlIG5vdGlmeSBwYWdlIHRvIHVzZXJzcGFjZSwgdG8gZWxpbWluYXRlCj4gdm1l
eGl0IHdoZW4ga2ljayBhIHZxLgo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21h
aW4uYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IGFiMGFiNWNmMGY2
ZS4uZDQxZGIwNDI2MTJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTQxMyw2
ICs0MTMsMjYgQEAgc3RhdGljIGludCBpZmN2Zl92ZHBhX2dldF92cV9pcnEoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhX2RldiwKPiAgIAlyZXR1cm4gdmYtPnZyaW5nW3FpZF0uaXJxOwo+ICAgfQo+
ICAgCj4gK3N0YXRpYyBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSBpZmN2Zl9nZXRfdnFf
bm90aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4gKwkJCQkJCQkgICAg
ICAgdTE2IGlkeCkKPiArewo+ICsJc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSB2ZHBh
X3RvX2FkYXB0ZXIodmRwYV9kZXYpOwo+ICsJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9f
dmYodmRwYV9kZXYpOwo+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBhZGFwdGVyLT5wZGV2Owo+
ICsJc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgYXJlYTsKPiArCj4gKwlhcmVhLmFkZHIg
PSB2Zi0+dnJpbmdbaWR4XS5ub3RpZnlfcGE7Cj4gKwlpZiAoIXZmLT5ub3RpZnlfb2ZmX211bHRp
cGxpZXIpCj4gKwkJYXJlYS5zaXplID0gUEFHRV9TSVpFOwo+ICsJZWxzZQo+ICsJCWFyZWEuc2l6
ZSA9IHZmLT5ub3RpZnlfb2ZmX211bHRpcGxpZXI7Cj4gKwo+ICsJaWYgKGFyZWEuYWRkciAlIFBB
R0VfU0laRSkKPiArCQlJRkNWRl9EQkcocGRldiwgInZxICV1IGRvb3JiZWxsIGFkZHJlc3MgaXMg
bm90IFBBR0VfU0laRSBhbGlnbmVkXG4iLCBpZHgpOwoKCkkgZG9uJ3Qgc2VlIHRoZSByZWFzb24g
dG8ga2VlcCB0aGlzLCBvciBnZXRfbm90aWZpY2F0aW9uIGlzIG5vdCB0aGUgCnByb3BlciBwbGFj
ZSB0byBkbyB0aGlzIGtpbmQgb2Ygd2FybmluZy4KClRoYW5rcwoKCj4gKwo+ICsJcmV0dXJuIGFy
ZWE7Cj4gK30KPiArCj4gICAvKgo+ICAgICogSUZDVkYgY3VycmVudGx5IGRvZXMndCBoYXZlIG9u
LWNoaXAgSU9NTVUsIHNvIG5vdAo+ICAgICogaW1wbGVtZW50ZWQgc2V0X21hcCgpL2RtYV9tYXAo
KS9kbWFfdW5tYXAoKQo+IEBAIC00NDAsNiArNDYwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2
ZHBhX2NvbmZpZ19vcHMgaWZjX3ZkcGFfb3BzID0gewo+ICAgCS5nZXRfY29uZmlnCT0gaWZjdmZf
dmRwYV9nZXRfY29uZmlnLAo+ICAgCS5zZXRfY29uZmlnCT0gaWZjdmZfdmRwYV9zZXRfY29uZmln
LAo+ICAgCS5zZXRfY29uZmlnX2NiICA9IGlmY3ZmX3ZkcGFfc2V0X2NvbmZpZ19jYiwKPiArCS5n
ZXRfdnFfbm90aWZpY2F0aW9uID0gaWZjdmZfZ2V0X3ZxX25vdGlmaWNhdGlvbiwKPiAgIH07Cj4g
ICAKPiAgIHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0
IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
