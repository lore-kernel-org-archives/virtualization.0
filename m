Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C98C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:10:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCBC610FE
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BCBC610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06C3C40184;
	Thu, 19 Aug 2021 04:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKRYh3VljwOL; Thu, 19 Aug 2021 04:10:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8AF50401E3;
	Thu, 19 Aug 2021 04:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B149C0010;
	Thu, 19 Aug 2021 04:10:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91E21C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7349C401E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WSHB2MaCDm23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:10:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 912C240184
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629346204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAKFB523upMxo0+DwG+qMEdFT9ki0LjoFpTj11Nr6RM=;
 b=bD4krGlmqfPzIQHETCt7Nobja47o15jYKdoeuOhOOsUifXD935Bjz24BPEq6x5AdfunlPv
 PyF3AIUd28Xx9KxTqnUXz2D88WyV6MdEHrrBq/xvozv6TBLxv0CKtFL4YuxJmX2638mbQW
 at0MYBN4Aqs/1SVU6RIz/+614hg/AQY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-V21596rHN8Om6mwnBk6EJA-1; Thu, 19 Aug 2021 00:10:03 -0400
X-MC-Unique: V21596rHN8Om6mwnBk6EJA-1
Received: by mail-pf1-f197.google.com with SMTP id
 p40-20020a056a0026e8b02903e08239ba3cso2427878pfw.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 21:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mAKFB523upMxo0+DwG+qMEdFT9ki0LjoFpTj11Nr6RM=;
 b=SKE8ftVpMPlmzibI6uszq+mP6AxLL6OHQqrdsA4zaBEtwOva0VQZaZy+aXrIGzqsLb
 d37eRbTFuo1riAEpDqqrHu7TgAFb6QMxvcZ74FHaDKoOs/+whM621vjxaj8286bi7if+
 EGV4wh2GJ8VNYkGejhzBlruvXhG+FdF8Qc6VzecuGZKHiPkpO3hRSG9o7RP864bOdJew
 HplIAZxmOQxtWMSqDTd5O2cB8yNYNpRqtQtR/I7bN+UiHTG8e1GnnM7DnJ6BHudG8SDN
 pmjc5OCB1QFohuC2mgAX+SgZ3co+MQl6v0NorFoYVuBR6nNoIf2TNL0ArGOCWr70bAEJ
 qGYg==
X-Gm-Message-State: AOAM532rpOXeGJdAxds5c6I8gYb3HE2/haXe3LA7uX1IEJCCghqH6APS
 iemrFDjZPha7eY7lIylbLcLDWvvkFxFHyiHfZJ7bmIqtoo7Uoxy2tQ1O9nsFjP2NnnUM3SCvAFr
 N/hAHlfuH/okKQkYrcbZjGf0iz2vrImdDE1j7HaNUkg==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id
 w16-20020a170902a710b029012b9b9fc461mr9934344plq.59.1629346202069; 
 Wed, 18 Aug 2021 21:10:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvJvKxjGvDP16m5jvYKL6UB/rB3oLFvT92PakF4jUj1koqC+slPZsHsy5c/+Dx1bYU8TY/Nw==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id
 w16-20020a170902a710b029012b9b9fc461mr9934329plq.59.1629346201878; 
 Wed, 18 Aug 2021 21:10:01 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g6sm1336541pfv.156.2021.08.18.21.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 21:10:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] vDPA/ifcvf: enable multiqueue and control vq
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210818095714.3220-1-lingshan.zhu@intel.com>
 <20210818095714.3220-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ecb03725-ecae-89bf-e8bc-b47859b75d4e@redhat.com>
Date: Thu, 19 Aug 2021 12:09:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818095714.3220-3-lingshan.zhu@intel.com>
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

CtTaIDIwMjEvOC8xOCDPws7nNTo1NywgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
ZW5iYWxlcyBtdWx0aS1xdWV1ZSBhbmQgY29udHJvbCB2cQo+IGZlYXR1cmVzIGZvciBpZmN2Zgo+
Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgoK
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBk
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgIDkgLS0tLS0tLS0tCj4gICBkcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMTEgKysrLS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaAo+IGluZGV4IDk3ZDkwMTlhM2VjMC4uMDk5MThhZjNlY2Y4IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4gQEAgLTIyLDE1ICsyMiw2IEBACj4gICAjZGVmaW5lIE4zMDAwX0RF
VklDRV9JRAkJMHgxMDQxCj4gICAjZGVmaW5lIE4zMDAwX1NVQlNZU19ERVZJQ0VfSUQJMHgwMDFB
Cj4gICAKPiAtI2RlZmluZSBJRkNWRl9ORVRfU1VQUE9SVEVEX0ZFQVRVUkVTIFwKPiAtCQkoKDFV
TEwgPDwgVklSVElPX05FVF9GX01BQykJCQl8IFwKPiAtCQkgKDFVTEwgPDwgVklSVElPX0ZfQU5Z
X0xBWU9VVCkJCQl8IFwKPiAtCQkgKDFVTEwgPDwgVklSVElPX0ZfVkVSU0lPTl8xKQkJCXwgXAo+
IC0JCSAoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfU1RBVFVTKQkJCXwgXAo+IC0JCSAoMVVMTCA8PCBW
SVJUSU9fRl9PUkRFUl9QTEFURk9STSkJCXwgXAo+IC0JCSAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NF
U1NfUExBVEZPUk0pCQl8IFwKPiAtCQkgKDFVTEwgPDwgVklSVElPX05FVF9GX01SR19SWEJVRikp
Cj4gLQo+ICAgLyogTWF4IDggZGF0YSBxdWV1ZSBwYWlycygxNiBxdWV1ZXMpIGFuZCBvbmUgY29u
dHJvbCB2cSBmb3Igbm93LiAqLwo+ICAgI2RlZmluZSBJRkNWRl9NQVhfUVVFVUVTCTE3Cj4gICAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCBlMzRjMmVjMmI2OWIuLmI5OTI4M2E5ODE3
NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC0xNzQsMTcgKzE3NCwxMiBAQCBz
dGF0aWMgdTY0IGlmY3ZmX3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YV9kZXYpCj4gICAJc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSB2ZHBhX3RvX2FkYXB0
ZXIodmRwYV9kZXYpOwo+ICAgCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFf
ZGV2KTsKPiAgIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGFkYXB0ZXItPnBkZXY7Cj4gLQo+ICsJ
dTMyIHR5cGUgPSB2Zi0+ZGV2X3R5cGU7Cj4gICAJdTY0IGZlYXR1cmVzOwo+ICAgCj4gLQlzd2l0
Y2ggKHZmLT5kZXZfdHlwZSkgewo+IC0JY2FzZSBWSVJUSU9fSURfTkVUOgo+IC0JCWZlYXR1cmVz
ID0gaWZjdmZfZ2V0X2ZlYXR1cmVzKHZmKSAmIElGQ1ZGX05FVF9TVVBQT1JURURfRkVBVFVSRVM7
Cj4gLQkJYnJlYWs7Cj4gLQljYXNlIFZJUlRJT19JRF9CTE9DSzoKPiArCWlmICh0eXBlID09IFZJ
UlRJT19JRF9ORVQgfHwgdHlwZSA9PSBWSVJUSU9fSURfQkxPQ0spCj4gICAJCWZlYXR1cmVzID0g
aWZjdmZfZ2V0X2ZlYXR1cmVzKHZmKTsKPiAtCQlicmVhazsKPiAtCWRlZmF1bHQ6Cj4gKwllbHNl
IHsKPiAgIAkJZmVhdHVyZXMgPSAwOwo+ICAgCQlJRkNWRl9FUlIocGRldiwgIlZJUlRJTyBJRCAl
dSBub3Qgc3VwcG9ydGVkXG4iLCB2Zi0+ZGV2X3R5cGUpOwo+ICAgCX0KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
