Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101A8C4708F
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:56:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F9560FE9
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 07:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F9560FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31DE840363;
	Mon, 31 May 2021 07:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Hcag65Qay3L; Mon, 31 May 2021 07:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79AC3402FE;
	Mon, 31 May 2021 07:56:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50BFAC000D;
	Mon, 31 May 2021 07:56:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66E8EC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47D9D83B78
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uOwV4VVybRlN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5962A82E29
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 07:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622447774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twMQBKVBYP+3C668h6+k4MZ8lCmQRLRa2Kt2PzgnD7I=;
 b=frTbzk6m+V8n9nk6Vc29zr1OGF5531GuXea0mtLOGQANtaXvvAjragSOJJ4viesbcQEkMN
 tsQ3mEIBmUVPAA97k3lUQ31zcYbvoz1mq8jKJs0cq3gINAZ8BBrnXueyRYtj0PcKEYOgX/
 QBcII7yJ9yIjxTPoMbMau8LIxLMUtl0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-8dgBEr6PPjmzlEqPNVflkA-1; Mon, 31 May 2021 03:56:12 -0400
X-MC-Unique: 8dgBEr6PPjmzlEqPNVflkA-1
Received: by mail-pl1-f197.google.com with SMTP id
 h3-20020a1709026803b029010163ec78c5so1915509plk.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 00:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=twMQBKVBYP+3C668h6+k4MZ8lCmQRLRa2Kt2PzgnD7I=;
 b=AzY3mmvlYrT/GhOzkgLTnN+nD5NfAn3LHMSq6DAvldo+dfYlAfors/WgNmrmKoL592
 Bi9USmai25jllXTdafWjWhwIaAdjmVmGDKNCItu5Gh2KxZU3lkaaPQVJsogZSFw1MhlG
 4VYXf6F8+tyKxGlwS30nqTii9vb87B34ymAZKcJA8MMjtIDpUBr0znITYD7lMDxDpUY/
 OPFqmpbY6l/YIcSgmgiXiDX0K+jocsXPVGJQ9OLwk1pfySSRcPs2dsbis1nRLixRRJeP
 f5if2EeI/PSvgbC+yGluknsFcyV1UA3TX2K2p7kK5CQ7ZXgK0lpX5uCmuR5WFnsH9EvR
 AWUA==
X-Gm-Message-State: AOAM533ABg6VEiqbiQZeiJ8qB7zB+kSYquiLp8XtbvwOSZ5hkfLjnQBJ
 zXofEl/WhV2a4s0Ovqlzv94zz4rCDluxAl4iNONyrWEUtWSxL1kOsL+gNjnrAxa0+mqeytgN+zm
 cbfZ5nPfzLIP8x1fQo0N4xnsP+Qybvkzl2i8HB2gqUw==
X-Received: by 2002:a17:90a:d24a:: with SMTP id o10mr64988pjw.19.1622447771201; 
 Mon, 31 May 2021 00:56:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8TC88Xtx7F14ZsQpXbpJHfPDYW9N6L5JuXudwujjTwdCrrK/LGYsXmWWRMwVYIznSPLKRCw==
X-Received: by 2002:a17:90a:d24a:: with SMTP id o10mr64969pjw.19.1622447770917; 
 Mon, 31 May 2021 00:56:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 76sm920482pfy.82.2021.05.31.00.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 00:56:10 -0700 (PDT)
Subject: Re: [PATCH V2 RESEND 2/2] vDPA/ifcvf: implement doorbell mapping for
 ifcvf
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210531073316.363655-1-lingshan.zhu@intel.com>
 <20210531073316.363655-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f3c28e92-3e8d-2a8a-ec5a-fc64f2098678@redhat.com>
Date: Mon, 31 May 2021 15:56:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531073316.363655-3-lingshan.zhu@intel.com>
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

CtTaIDIwMjEvNS8zMSDPws7nMzozMywgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
aW1wbGVtZW50cyBkb29yYmVsbCBtYXBwaW5nIGZlYXR1cmUgZm9yIGlmY3ZmLgo+IFRoaXMgZmVh
dHVyZSBtYXBzIHRoZSBub3RpZnkgcGFnZSB0byB1c2Vyc3BhY2UsIHRvIGVsaW1pbmF0ZQo+IHZt
ZXhpdCB3aGVuIGtpY2sgYSB2cS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGlu
Z3NoYW4uemh1QGludGVsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMgfCAxNyArKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5j
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IGFiMGFiNWNmMGY2ZS4u
ZWZmYjBlNTQ5MTM1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWlu
LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTQxMyw2ICs0
MTMsMjIgQEAgc3RhdGljIGludCBpZmN2Zl92ZHBhX2dldF92cV9pcnEoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhX2RldiwKPiAgIAlyZXR1cm4gdmYtPnZyaW5nW3FpZF0uaXJxOwo+ICAgfQo+ICAg
Cj4gK3N0YXRpYyBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSBpZmN2Zl9nZXRfdnFfbm90
aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4gKwkJCQkJCQkgICAgICAg
dTE2IGlkeCkKPiArewo+ICsJc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSB2ZHBhX3Rv
X2FkYXB0ZXIodmRwYV9kZXYpOwo+ICsJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYo
dmRwYV9kZXYpOwo+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBhZGFwdGVyLT5wZGV2Owo+ICsJ
c3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgYXJlYTsKPiArCj4gKwlhcmVhLmFkZHIgPSB2
Zi0+dnJpbmdbaWR4XS5ub3RpZnlfcGE7Cj4gKwlhcmVhLnNpemUgPSBQQUdFX1NJWkU7Cj4gKwlp
ZiAoYXJlYS5hZGRyICUgUEFHRV9TSVpFKQo+ICsJCUlGQ1ZGX0RCRyhwZGV2LCAidnEgJXUgZG9v
cmJlbGwgYWRkcmVzcyBpcyBub3QgUEFHRV9TSVpFIGFsaWduZWRcbiIsIGlkeCk7CgoKTGV0J3Mg
bGVhdmUgdGhlIGRlY2lzaW9uIHRvIHVwcGVyIGxheWVyIGJ5OiAoc2VlIAp2cF92ZHBhX2dldF92
cV9ub3RpZmljYXRpb24pCgphcmVhLmFkZHIgPSBub3RpZnlfcGE7CmFyZWEuc2l6ZSA9IG5vdGlm
eV9vZmZzZXRfbXVsdGlwbGllcjsKClRoYW5rcwoKCj4gKwo+ICsJcmV0dXJuIGFyZWE7Cj4gK30K
PiArCj4gICAvKgo+ICAgICogSUZDVkYgY3VycmVudGx5IGRvZXMndCBoYXZlIG9uLWNoaXAgSU9N
TVUsIHNvIG5vdAo+ICAgICogaW1wbGVtZW50ZWQgc2V0X21hcCgpL2RtYV9tYXAoKS9kbWFfdW5t
YXAoKQo+IEBAIC00NDAsNiArNDU2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgaWZjX3ZkcGFfb3BzID0gewo+ICAgCS5nZXRfY29uZmlnCT0gaWZjdmZfdmRwYV9nZXRf
Y29uZmlnLAo+ICAgCS5zZXRfY29uZmlnCT0gaWZjdmZfdmRwYV9zZXRfY29uZmlnLAo+ICAgCS5z
ZXRfY29uZmlnX2NiICA9IGlmY3ZmX3ZkcGFfc2V0X2NvbmZpZ19jYiwKPiArCS5nZXRfdnFfbm90
aWZpY2F0aW9uID0gaWZjdmZfZ2V0X3ZxX25vdGlmaWNhdGlvbiwKPiAgIH07Cj4gICAKPiAgIHN0
YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICppZCkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
