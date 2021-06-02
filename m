Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E7C47083
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF5D60233
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF5D60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60123605A8;
	Wed,  2 Jun 2021 09:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1Blmn22YuSp; Wed,  2 Jun 2021 09:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBC6C607F0;
	Wed,  2 Jun 2021 09:06:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55015C000E;
	Wed,  2 Jun 2021 09:06:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25151C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02AB2402BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HPE81t5bW7x
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:06:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEC7C4020D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622624806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SKDhNmHqN2aKK0+XSIC4OXwk6NfJlgx4QyzKzOMn5g=;
 b=Vyws82sMCwe4LFZpIaqEClxvYW1C7sawjOEfr8/OWHKYHwdYVEiowSAx1lV1qV/VXM0oow
 LWBKD//wWdEGrJSAqDaCRlVKSzl+p4umwifos6MAIIAXpzTlv9+1X0ZVYOTU+o9f/9KcMk
 iw1EUG9nELIdCN2UFLSzfeka1e4u1Vg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-qlj6b_iyPt2BDCTZ_WcjYg-1; Wed, 02 Jun 2021 05:06:43 -0400
X-MC-Unique: qlj6b_iyPt2BDCTZ_WcjYg-1
Received: by mail-pg1-f198.google.com with SMTP id
 m7-20020a6545c70000b029020f6af21c77so1297494pgr.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 02:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4SKDhNmHqN2aKK0+XSIC4OXwk6NfJlgx4QyzKzOMn5g=;
 b=s6jcGpfN1i5405EDIXW/YBoRMMY8/mQ2JJWlCnnLJ+oMRWytas2zdjcqw6Q9m4CBri
 jkulctrzdyd1g8YdYeevSM2ujb+jSTEFF1LCOphMQn+f4YfwOA1yQAv7AJnDXpu/8XMT
 hqeuE+qlgOjQHsI0fC4menDOl42iTGJy9xosEkCRv0u76I4cHrU0S/tWsPvpH4RciUlR
 KNnWqfcbLMfHtQnz3yRaOW95RtcpjfIUPTheGh0QGHgwWwIB6iDXYKqJKYOhWP0s/3vC
 aqfVy4x1xHYno35KiU/y/wnU4V7hF3ELQlnMAJboHlBfmrZa30lQ/q63yrlX0/GEtzuq
 TE2g==
X-Gm-Message-State: AOAM532reLWc8PQG3tC4nmbBbseqRyH41mGhpgSLywcc9K9GS8V8UPdi
 9q3Hg4RSEAxH6UMDBPP/DrEpkK+hoJEOGUHGyDtK5asgUP3S7lVNDhHNu5EtRP4BKZHhslW5A7I
 ecTCbZ8N5FF/pKkLKa10QyRMg3RIxeBALkgGTk9ajdQ==
X-Received: by 2002:a17:90a:d106:: with SMTP id
 l6mr29442506pju.164.1622624802290; 
 Wed, 02 Jun 2021 02:06:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywOxQ+NWTfjlQmSNDqckkjmrNWhEkCDBhZCvcjcZYkfXqk+RN3ycPoZAbDZtUF42apd9FTcg==
X-Received: by 2002:a17:90a:d106:: with SMTP id
 l6mr29442495pju.164.1622624802084; 
 Wed, 02 Jun 2021 02:06:42 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id bo14sm249140pjb.40.2021.06.02.02.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 02:06:41 -0700 (PDT)
Subject: Re: [RESEND PATCH V4 2/2] vDPA/ifcvf: implement doorbell mapping for
 ifcvf
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210602084550.289599-1-lingshan.zhu@intel.com>
 <20210602084550.289599-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <87adb0ea-689e-f014-d81d-37b2ee032c54@redhat.com>
Date: Wed, 2 Jun 2021 17:06:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602084550.289599-3-lingshan.zhu@intel.com>
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

CtTaIDIwMjEvNi8yIM/Czuc0OjQ1LCBaaHUgTGluZ3NoYW4g0LS1wDoKPiBUaGlzIGNvbW1pdCBp
bXBsZW1lbnRzIGRvb3JiZWxsIG1hcHBpbmcgZmVhdHVyZSBmb3IgaWZjdmYuCj4gVGhpcyBmZWF0
dXJlIG1hcHMgdGhlIG5vdGlmeSBwYWdlIHRvIHVzZXJzcGFjZSwgdG8gZWxpbWluYXRlCj4gdm1l
eGl0IHdoZW4ga2ljayBhIHZxLgo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMTYg
KysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IGFiMGFiNWNmMGY2ZS4uNDZhOTkyZWFiM2U1
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTQxMyw2ICs0MTMsMjEgQEAgc3Rh
dGljIGludCBpZmN2Zl92ZHBhX2dldF92cV9pcnEoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2Rl
diwKPiAgIAlyZXR1cm4gdmYtPnZyaW5nW3FpZF0uaXJxOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBz
dHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSBpZmN2Zl9nZXRfdnFfbm90aWZpY2F0aW9uKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4gKwkJCQkJCQkgICAgICAgdTE2IGlkeCkKPiAr
ewo+ICsJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+ICsJc3Ry
dWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgYXJlYTsKPiArCj4gKwlhcmVhLmFkZHIgPSB2Zi0+
dnJpbmdbaWR4XS5ub3RpZnlfcGE7Cj4gKwlpZiAoIXZmLT5ub3RpZnlfb2ZmX211bHRpcGxpZXIp
Cj4gKwkJYXJlYS5zaXplID0gUEFHRV9TSVpFOwo+ICsJZWxzZQo+ICsJCWFyZWEuc2l6ZSA9IHZm
LT5ub3RpZnlfb2ZmX211bHRpcGxpZXI7Cj4gKwo+ICsJcmV0dXJuIGFyZWE7Cj4gK30KPiArCj4g
ICAvKgo+ICAgICogSUZDVkYgY3VycmVudGx5IGRvZXMndCBoYXZlIG9uLWNoaXAgSU9NTVUsIHNv
IG5vdAo+ICAgICogaW1wbGVtZW50ZWQgc2V0X21hcCgpL2RtYV9tYXAoKS9kbWFfdW5tYXAoKQo+
IEBAIC00NDAsNiArNDU1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMg
aWZjX3ZkcGFfb3BzID0gewo+ICAgCS5nZXRfY29uZmlnCT0gaWZjdmZfdmRwYV9nZXRfY29uZmln
LAo+ICAgCS5zZXRfY29uZmlnCT0gaWZjdmZfdmRwYV9zZXRfY29uZmlnLAo+ICAgCS5zZXRfY29u
ZmlnX2NiICA9IGlmY3ZmX3ZkcGFfc2V0X2NvbmZpZ19jYiwKPiArCS5nZXRfdnFfbm90aWZpY2F0
aW9uID0gaWZjdmZfZ2V0X3ZxX25vdGlmaWNhdGlvbiwKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyBp
bnQgaWZjdmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2
aWNlX2lkICppZCkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
