Return-Path: <SRS0=F8NL=MB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B28C07E96
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 02:29:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07F061421
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 02:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07F061421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAF30400AE;
	Fri,  9 Jul 2021 02:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wvezLFMAe33s; Fri,  9 Jul 2021 02:29:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5387E401C9;
	Fri,  9 Jul 2021 02:29:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21EDEC001A;
	Fri,  9 Jul 2021 02:29:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48D53C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 02:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 221E260A61
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 02:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ziNarzwdAvKk
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 02:29:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C96A60746
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 02:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625797789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jC8ebqLDwty//t4KfVA7RFoJa+JDs1zz/7ayauIgC5s=;
 b=T2dZn3qqtixeMaAy9fnk6V/vRgwfEGGCntCSTFc1K1+rluxWA88zsW5MNUwXvo873ngYDt
 gS0HKuAT9OkYe0WkeuGmdTLlGLnspsI09t8SH3iO7kaRjEUYkAEtNcEzTltSpxaO52l8Sd
 WvSAT1RQ9bXXbRoO4rh1mWW0eWs0jtI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-XCLucGMDOXaYkxm19wFaqQ-1; Thu, 08 Jul 2021 22:29:47 -0400
X-MC-Unique: XCLucGMDOXaYkxm19wFaqQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 u12-20020a17090abb0cb029016ee12ec9a1so3693223pjr.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jul 2021 19:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jC8ebqLDwty//t4KfVA7RFoJa+JDs1zz/7ayauIgC5s=;
 b=BzP+BkKQx6CF/rDDKw4YuywnNbPSDAn+dQWSQ83blfOHp8JuIzfy7yNaFIVbYcJA1H
 SqsqPq3/KLyImXMktACBeQ2y9RS0UYffun+kcF3EKJ7m3XGmPdVSJRWT3/V6Qrz6v/y7
 C5fLz8HKzzVVR2SG21NFFXwXPTaRXcdz8frUTkih8CGTQ+o062guO3BMGdeRE3lORRog
 Twjjj8Cxa0PzdswmqYTzmFkd8JPJCgNr2ANe6u1WTZDph9dqf65Aaiov57MgwZujwQRl
 09rZUwZdffX5TuntPCVyzlB5Gw8v2r4ReT/pjmJ3g95TwW9xb3LdEMcbOpg2FQQwyZDc
 stBQ==
X-Gm-Message-State: AOAM5300N/f2QbGyQtnY/3DolO+IguLhvkPipWAnxZybO1vVowdlmpf6
 Zu77JaHcRp0I80WqXns/vOv7jbfNUdtsTHurdul+70RSxsL0aHlmLKUwzokZfYupPdNWX9RrSuL
 RiZeDCjQWCJAAi9r512lKuoL8EFk13sKOyWoKp7li1Q==
X-Received: by 2002:a62:1708:0:b029:31b:113f:174a with SMTP id
 8-20020a6217080000b029031b113f174amr30557494pfx.68.1625797786914; 
 Thu, 08 Jul 2021 19:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcSNDEpisA7AaUQv65sNC7SSxSvR5Hd5rr7dX1Ad3A6kno6Tgb6OvZoPwEHv5RC/WjWhzHRg==
X-Received: by 2002:a62:1708:0:b029:31b:113f:174a with SMTP id
 8-20020a6217080000b029031b113f174amr30557471pfx.68.1625797786688; 
 Thu, 08 Jul 2021 19:29:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v6sm4947769pgk.33.2021.07.08.19.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 19:29:46 -0700 (PDT)
Subject: Re: [PATCH V3 1/2] vDPA/ifcvf: introduce get_dev_type() which returns
 virtio dev id
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210706023649.23360-1-lingshan.zhu@intel.com>
 <20210706023649.23360-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <abe284e0-7f0a-2cca-04ad-ef69fa1cc1d7@redhat.com>
Date: Fri, 9 Jul 2021 10:29:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706023649.23360-2-lingshan.zhu@intel.com>
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

CtTaIDIwMjEvNy82IMnPzucxMDozNiwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
aW50cm9kdWNlcyBhIG5ldyBmdW5jdGlvbiBnZXRfZGV2X3R5cGUoKSB3aGljaCByZXR1cm5zCj4g
dGhlIHZpcnRpbyBkZXZpY2UgaWQgb2YgYSBkZXZpY2UsIHRvIGF2b2lkIGR1cGxpY2F0ZWQgY29k
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+
ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDM0ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gaW5kZXggYmMxZDU5ZjMx
NmQxLi41ZjcwYWIxMjgzYTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBAQCAtNDQy
LDYgKzQ0MiwyNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBpZmNfdmRw
YV9vcHMgPSB7Cj4gICAJLnNldF9jb25maWdfY2IgID0gaWZjdmZfdmRwYV9zZXRfY29uZmlnX2Ni
LAo+ICAgfTsKPiAgIAo+ICtzdGF0aWMgdTMyIGdldF9kZXZfdHlwZShzdHJ1Y3QgcGNpX2RldiAq
cGRldikKPiArewo+ICsJdTMyIGRldl90eXBlOwo+ICsKPiArCS8qIFRoaXMgZHJpcnZlciBkcml2
ZXMgYm90aCBtb2Rlcm4gdmlydGlvIGRldmljZXMgYW5kIHRyYW5zaXRpb25hbAo+ICsJICogZGV2
aWNlcyBpbiBtb2Rlcm4gbW9kZS4KPiArCSAqIHZEUEEgcmVxdWlyZXMgZmVhdHVyZSBiaXQgVklS
VElPX0ZfQUNDRVNTX1BMQVRGT1JNLAo+ICsJICogc28gbGVnYWN5IGRldmljZXMgYW5kIHRyYW5z
aXRpb25hbCBkZXZpY2VzIGluIGxlZ2FjeQo+ICsJICogbW9kZSB3aWxsIG5vdCB3b3JrIGZvciB2
RFBBLCB0aGlzIGRyaXZlciB3aWxsIG5vdAo+ICsJICogZHJpdmUgZGV2aWNlcyB3aXRoIGxlZ2Fj
eSBpbnRlcmZhY2UuCj4gKwkgKi8KPiArCj4gKwlpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+
ICsJCWRldl90eXBlID0gIHBkZXYtPnN1YnN5c3RlbV9kZXZpY2U7Cj4gKwllbHNlCj4gKwkJZGV2
X3R5cGUgPSAgcGRldi0+ZGV2aWNlIC0gMHgxMDQwOwo+ICsKPiArCXJldHVybiBkZXZfdHlwZTsK
PiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYs
IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiAgIHsKPiAgIAlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmcGRldi0+ZGV2Owo+IEBAIC00ODYsMTkgKzUwNiw3IEBAIHN0YXRpYyBpbnQgaWZj
dmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lk
ICppZCkKPiAgIAlwY2lfc2V0X2RydmRhdGEocGRldiwgYWRhcHRlcik7Cj4gICAKPiAgIAl2ZiA9
ICZhZGFwdGVyLT52ZjsKPiAtCj4gLQkvKiBUaGlzIGRyaXJ2ZXIgZHJpdmVzIGJvdGggbW9kZXJu
IHZpcnRpbyBkZXZpY2VzIGFuZCB0cmFuc2l0aW9uYWwKPiAtCSAqIGRldmljZXMgaW4gbW9kZXJu
IG1vZGUuCj4gLQkgKiB2RFBBIHJlcXVpcmVzIGZlYXR1cmUgYml0IFZJUlRJT19GX0FDQ0VTU19Q
TEFURk9STSwKPiAtCSAqIHNvIGxlZ2FjeSBkZXZpY2VzIGFuZCB0cmFuc2l0aW9uYWwgZGV2aWNl
cyBpbiBsZWdhY3kKPiAtCSAqIG1vZGUgd2lsbCBub3Qgd29yayBmb3IgdkRQQSwgdGhpcyBkcml2
ZXIgd2lsbCBub3QKPiAtCSAqIGRyaXZlIGRldmljZXMgd2l0aCBsZWdhY3kgaW50ZXJmYWNlLgo+
IC0JICovCj4gLQlpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+IC0JCXZmLT5kZXZfdHlwZSA9
ICBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+IC0JZWxzZQo+IC0JCXZmLT5kZXZfdHlwZSA9ICBw
ZGV2LT5kZXZpY2UgLSAweDEwNDA7Cj4gLQo+ICsJdmYtPmRldl90eXBlID0gZ2V0X2Rldl90eXBl
KHBkZXYpOwo+ICAgCXZmLT5iYXNlID0gcGNpbV9pb21hcF90YWJsZShwZGV2KTsKPiAgIAo+ICAg
CWFkYXB0ZXItPnBkZXYgPSBwZGV2OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
