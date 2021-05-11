Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56464C433B4
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 06:47:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1CA616EC
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 06:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1CA616EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B6BA4056A;
	Tue, 11 May 2021 06:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmNrGDezK2lQ; Tue, 11 May 2021 06:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE937404B8;
	Tue, 11 May 2021 06:47:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D335AC000D;
	Tue, 11 May 2021 06:47:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A15EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 467EB40261
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgLILHx4qVH1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1F6E40173
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620715667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGT3PCvhdMF1ySAiULwwXSWctoW1fgtrGIWAnzk21Yk=;
 b=iHrdbDbHve6wSjyKc5K1C6Ck0AiOif8IO6cPiFms6KdG/foq+5AIVUTrNUFyTuB9hoM9KN
 Yh56IEUw9c1srU6TXeQkwzB109O+Qq7QpxGERgArebe3GV0mtcR049qiHzyaQiAbLJHQpR
 6opCd2zZUd980NjWnbqRRzrgBlsRxFM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-wSntaf01NASi9x020kSGyA-1; Tue, 11 May 2021 02:47:45 -0400
X-MC-Unique: wSntaf01NASi9x020kSGyA-1
Received: by mail-pf1-f197.google.com with SMTP id
 g17-20020a056a0023d1b029028f419cb9a2so12117340pfc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 23:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XGT3PCvhdMF1ySAiULwwXSWctoW1fgtrGIWAnzk21Yk=;
 b=Swn82biX2L9RHo0XUYePr6JBiugVs4Jbo0v1tReJ4QqftjfsYwCQX3uFRh8GNG+mBj
 LHoUYIK9HKtOcB50ial/eNzxmz4pMP2bdqpAbStlQt+7IVcuwQOI0RXf9Hr6BbmvxN7O
 rwhm9/zWAKvqwik4WS2K9KF4DH3slu9GjNEW7YFTk1BsWCS7fzd2UEq+rY9IVKht8LIg
 1u5aODIP/w7CmjbSIT2tAgYL6YeEGu7pRqkgUSyJbLthDwQIMJPcIW5eh+yMk7GlC0Tk
 OxUt67Di4sFKGOjhqfG1FG7teRnVYsx2WT3pgdiC7vf9RXXmio1e62/ifUGeY5dlaEZw
 iz9Q==
X-Gm-Message-State: AOAM53291Xlf5wnGXJTzDRJt4M1uvsFkpnqiEjzj0+LSSigBXRbceL6G
 Ku/pDIoCfxbChAwUJ/r1m7alz21iLb3hwllg9QA/cIZcYecsBsg1BpVZiucO6tKkz49MlAMCgEa
 0gnWBc6Ze3zw8guEjGKcVlMxGHwt+FJ2S6mph01g3BQ==
X-Received: by 2002:a63:175e:: with SMTP id 30mr29171621pgx.48.1620715664814; 
 Mon, 10 May 2021 23:47:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvwbj9SMbJvN2l/IkE6Fv7+EyyvfRZyr3PmFk8lIByMWRMcgD0FGP+VR5/y5nomzefatXMaQ==
X-Received: by 2002:a63:175e:: with SMTP id 30mr29171606pgx.48.1620715664592; 
 Mon, 10 May 2021 23:47:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h15sm12760024pfk.26.2021.05.10.23.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 23:47:44 -0700 (PDT)
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To: Yuri Benditovich <yuri.benditovich@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0e31ea70-f12a-070e-c72b-6e1d337a89bc@redhat.com>
Date: Tue, 11 May 2021 14:47:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511044253.469034-3-yuri.benditovich@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com
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

CtTaIDIwMjEvNS8xMSDPws7nMTI6NDIsIFl1cmkgQmVuZGl0b3ZpY2gg0LS1wDoKPiBMYXJnZSBV
RFAgcGFja2V0IHByb3ZpZGVkIGJ5IHRoZSBndWVzdCB3aXRoIEdTTyB0eXBlIHNldCB0bwo+IFZJ
UlRJT19ORVRfSERSX0dTT19VRFBfTDQgd2lsbCBiZSBkaXZpZGVkIHRvIHNldmVyYWwgVURQCj4g
cGFja2V0cyBhY2NvcmRpbmcgdG8gdGhlIGdzb19zaXplIGZpZWxkLgo+Cj4gU2lnbmVkLW9mZi1i
eTogWXVyaSBCZW5kaXRvdmljaCA8eXVyaS5iZW5kaXRvdmljaEBkYXluaXguY29tPgo+IC0tLQo+
ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmggfCA1ICsrKysrCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9f
bmV0LmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+IGluZGV4IGI0NjVmOGYzZTU1NC4u
NGVjZjlhMWNhOTEyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX25ldC5oCj4g
KysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgKPiBAQCAtNTEsNiArNTEsMTEgQEAgc3Rh
dGljIGlubGluZSBpbnQgdmlydGlvX25ldF9oZHJfdG9fc2tiKHN0cnVjdCBza19idWZmICpza2Is
Cj4gICAJCQlpcF9wcm90byA9IElQUFJPVE9fVURQOwo+ICAgCQkJdGhsZW4gPSBzaXplb2Yoc3Ry
dWN0IHVkcGhkcik7Cj4gICAJCQlicmVhazsKPiArCQljYXNlIFZJUlRJT19ORVRfSERSX0dTT19V
RFBfTDQ6Cj4gKwkJCWdzb190eXBlID0gU0tCX0dTT19VRFBfTDQ7Cj4gKwkJCWlwX3Byb3RvID0g
SVBQUk9UT19VRFA7Cj4gKwkJCXRobGVuID0gc2l6ZW9mKHN0cnVjdCB1ZHBoZHIpOwo+ICsJCQli
cmVhazsKCgpUaGlzIGlzIG9ubHkgZm9yIHJ4LCBob3cgYWJvdXQgdHg/CgpUaGFua3MKCgoKPiAg
IAkJZGVmYXVsdDoKPiAgIAkJCXJldHVybiAtRUlOVkFMOwo+ICAgCQl9CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
