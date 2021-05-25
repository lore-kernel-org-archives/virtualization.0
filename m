Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B81C2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 06:23:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4374A61413
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 06:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4374A61413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AB7683C02;
	Tue, 25 May 2021 06:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LrS3gO1YQ8fX; Tue, 25 May 2021 06:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA8FA83BFD;
	Tue, 25 May 2021 06:23:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B9FC000D;
	Tue, 25 May 2021 06:23:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A5B6C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6889E40104
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NW4HTNyOXOxp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AECA1400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621923808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqC+rL03NFU00q36iPYaCWY4fHiegTpGAwzrspkzWwU=;
 b=buPcdxeLhSuc7/RL97baTbVZe0t/BIyVD+pcK0YMT+bm+9NeD6ACwNaIpL5Z1MpVeeSS2T
 d+lV33/JMmxv8ienskMCvNO+ZS+trFWroele6Zzh6IGUWDbW8Pp4Kfrtt7nUhanEf6VfhF
 sxQt3/Y1XBoevve58R15feQegYus4tU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-SPjtgHwxPdCJYOigy8khVQ-1; Tue, 25 May 2021 02:23:24 -0400
X-MC-Unique: SPjtgHwxPdCJYOigy8khVQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 u14-20020a170903304eb02900ec9757f3dbso14241803pla.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 23:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RqC+rL03NFU00q36iPYaCWY4fHiegTpGAwzrspkzWwU=;
 b=VnubJwAmiWgscoDbUdcdhjl7enixz6W64GKFKLnbW79VZMHameRiY21zK2Zk9yvo3Y
 PbGczzt6AiCNuuOMqlht4nfA3Qrcs50wgiJHp3MivjVl530Wbn44/TZVBPsMD81zN9zp
 Cn4GZ03Jv7Wns4NZvngoRvt0cFJ9s9DFdj4LYT98N0HyPLGTtgiEoyrVgj6cm5KnAWBA
 D7nJ7AypROSlwM4wnSpyNPftzpNfRKznWIjwg/9kw//1qZ9aHai2c1W+V70Od4uqRLBE
 kMdkdO/HcJMXdo9b5S0tLdvzMP+MMubPFc+8By/0LsVtTuC+KJmkfmjEstcwZM/YGL7R
 yiZg==
X-Gm-Message-State: AOAM530f+tewH3QucIGk4KKRMzhM+hmyFWtJn6q32aaP9xd8iR5L084p
 KjLT2sm5SKGR80Bd0qphGab4TfWzadvlCOG/DudS+fLuBKBt1QkeV+043OPiLhowNe8Xku09nTH
 hB1lbk2WtAd/vyqgIKMdXG8NPMXUFDtcoAzo8XGibrg==
X-Received: by 2002:a17:90a:602:: with SMTP id
 j2mr29435204pjj.211.1621923803809; 
 Mon, 24 May 2021 23:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzthPvWzWsy+OgjCaqNyzQJxLtpWU/5mo8q3NP6jddpWWmCJIfZD4jC3PimfRJ+ctmhjllivg==
X-Received: by 2002:a17:90a:602:: with SMTP id
 j2mr29435186pjj.211.1621923803627; 
 Mon, 24 May 2021 23:23:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j20sm10584356pfj.40.2021.05.24.23.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 23:23:23 -0700 (PDT)
Subject: Re: [PATCH] virtio_console: Assure used length from device is limited
To: Xie Yongji <xieyongji@bytedance.com>, amit@kernel.org, mst@redhat.com
References: <20210525045304.1085-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <007b4e26-8ea1-ac22-fd77-e54b7417351b@redhat.com>
Date: Tue, 25 May 2021 14:23:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525045304.1085-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNS8yNSDPws7nMTI6NTMsIFhpZSBZb25namkg0LS1wDoKPiBUaGUgYnVmLT5sZW4g
bWlnaHQgY29tZSBmcm9tIGFuIHVudHJ1c3RlZCBkZXZpY2UuIFRoaXMKPiBlbnN1cmVzIHRoZSB2
YWx1ZSB3b3VsZCBub3QgZXhjZWVkIHRoZSBzaXplIG9mIHRoZSBidWZmZXIKPiB0byBhdm9pZCBk
YXRhIGNvcnJ1cHRpb24gb3IgbG9zcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhp
ZXlvbmdqaUBieXRlZGFuY2UuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYyB8IDQg
KystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYyBiL2RyaXZlcnMv
Y2hhci92aXJ0aW9fY29uc29sZS5jCj4gaW5kZXggMWM0MGNhNmQ3NmJhLi41OTg4NjNlNmRhZjgg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKPiArKysgYi9kcml2
ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwo+IEBAIC00NzUsNyArNDc1LDcgQEAgc3RhdGljIHN0
cnVjdCBwb3J0X2J1ZmZlciAqZ2V0X2luYnVmKHN0cnVjdCBwb3J0ICpwb3J0KQo+ICAgCj4gICAJ
YnVmID0gdmlydHF1ZXVlX2dldF9idWYocG9ydC0+aW5fdnEsICZsZW4pOwo+ICAgCWlmIChidWYp
IHsKPiAtCQlidWYtPmxlbiA9IGxlbjsKPiArCQlidWYtPmxlbiA9IG1pbihsZW4sIGJ1Zi0+c2l6
ZSk7Cj4gICAJCWJ1Zi0+b2Zmc2V0ID0gMDsKPiAgIAkJcG9ydC0+c3RhdHMuYnl0ZXNfcmVjZWl2
ZWQgKz0gbGVuOwo+ICAgCX0KPiBAQCAtMTcwOSw3ICsxNzA5LDcgQEAgc3RhdGljIHZvaWQgY29u
dHJvbF93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCXdoaWxlICgo
YnVmID0gdmlydHF1ZXVlX2dldF9idWYodnEsICZsZW4pKSkgewo+ICAgCQlzcGluX3VubG9jaygm
cG9ydGRldi0+Y19pdnFfbG9jayk7Cj4gICAKPiAtCQlidWYtPmxlbiA9IGxlbjsKPiArCQlidWYt
PmxlbiA9IG1pbihsZW4sIGJ1Zi0+c2l6ZSk7Cj4gICAJCWJ1Zi0+b2Zmc2V0ID0gMDsKPiAgIAo+
ICAgCQloYW5kbGVfY29udHJvbF9tZXNzYWdlKHZxLT52ZGV2LCBwb3J0ZGV2LCBidWYpOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
