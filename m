Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34C9C2B9F7
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 00:02:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C07613E6
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 00:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C07613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F416B60ABF;
	Tue, 25 May 2021 00:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0U1hSJxjcCJo; Tue, 25 May 2021 00:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2FE460A55;
	Tue, 25 May 2021 00:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF66C000E;
	Tue, 25 May 2021 00:02:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9506DC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 769DC4014A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sObOH6IqKtkA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 925434010D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621900921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imijlKNEI7IwgyrS4rUEIPV9LAYeyI+8AWg14saEzdE=;
 b=gBNk7N/AXCV7iLog4l3xgVcOI6V6ZIGo3ZQoXi+gLbRUZqdRV4RzkzoR6KHyS2y6rwoKWu
 m2zt7Rx/MrpP1fKe8VTnDwsAGWsAZPAjhqFWnICSIxfu43KhnBoC+lumwke5kYe0RGOd9M
 bw7miXcbBxPwxdTx5rfxMPGAIehu/iA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-t301qOyJM9e2xLPwc4SFdw-1; Mon, 24 May 2021 20:01:59 -0400
X-MC-Unique: t301qOyJM9e2xLPwc4SFdw-1
Received: by mail-pg1-f200.google.com with SMTP id
 q64-20020a6343430000b02902164088f2f0so19591204pga.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 17:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=imijlKNEI7IwgyrS4rUEIPV9LAYeyI+8AWg14saEzdE=;
 b=TaO1cT7qYSwgmox7SuRdwMArU6+RVgQf3sPqsyhb6ahIDR0nka6MCtX2RGC3Yo8aNj
 aWhdeDJsL05S3jnSWjJ5l8yegbh/We7M+P7OeIiufc1OM/0EGADlWD5yQbQFOREU1xaT
 oKzaHMccJpxiN3mW3+XlqLDcFraJxanRAK14RlclRM/Lz0v1Ye9TE6ahApQuEb7Q+sa9
 7klDibznx7y5nT//uP5fvMajaPI+YGI4dqjFABo4JSybgb8VUdsQg8fpKAWXzr/YO9BE
 Rqe6Xn7roLdUvGC89tqC5eSKbMdRSQeMX39bPefflFtgn0b8SrkdG2Bf5Kkt+/w1l4DP
 ANMA==
X-Gm-Message-State: AOAM532nZekb1Wz0cH/dVW+Djt4BJ+2CsjYkXbQYtIKknqccblxwQXwa
 FM8+pTa0NhqmM+Cx394j5rk2iYkOGGMfpEjKHzHvd8XgoPkXFD1pk6v4BIbV9v7tLlynV0Y0PAa
 Yvtr1sriHLiVt7ReNfDlWvaX75ZiLeA5LXvz/QXgovA==
X-Received: by 2002:a63:44b:: with SMTP id 72mr11953935pge.424.1621900918554; 
 Mon, 24 May 2021 17:01:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuyz+85rXuY6R5pL2kXR/r7gopDh02d36WTxzFo6l8EcT/c7ns3FsTcy4I3rehNsOzlG4UGQ==
X-Received: by 2002:a63:44b:: with SMTP id 72mr11953915pge.424.1621900918290; 
 Mon, 24 May 2021 17:01:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v21sm12231212pgh.12.2021.05.24.17.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 17:01:57 -0700 (PDT)
Subject: Re: [PATCH] vdpa_sim_blk: Remove the repeated header file
To: Shaokun Zhang <zhangshaokun@hisilicon.com>,
 virtualization@lists.linux-foundation.org
References: <1621858880-39581-1-git-send-email-zhangshaokun@hisilicon.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <924bbaa5-d171-ff2c-5893-88d50594764c@redhat.com>
Date: Tue, 25 May 2021 08:01:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1621858880-39581-1-git-send-email-zhangshaokun@hisilicon.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CtTaIDIwMjEvNS8yNCDPws7nODoyMSwgU2hhb2t1biBaaGFuZyDQtLXAOgo+IEhlYWRlciBmaWxl
ICdibGtkZXYuaCcgaGFzIGJlZW4gaW5jbHVkZWQgdHdpY2VkLCBjbGVhbnVwIHRoZQo+IGxhdGVy
IG9uZS4KPgo+IENjOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4g
Q2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4KPiBDYzogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFva3VuIFpoYW5nIDx6
aGFuZ3NoYW9rdW5AaGlzaWxpY29uLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbV9ibGsuYyB8IDEgLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgYi9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiBpbmRleCA1YmZlMWMyODE2NDUu
LmE3OTA5MDNmMjQzZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW1fYmxrLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiBA
QCAtMTUsNyArMTUsNiBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L2Jsa2Rldi5oPgo+ICAgI2luY2x1
ZGUgPGxpbnV4L3ZyaW5naC5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4KPiAtI2luY2x1
ZGUgPGxpbnV4L2Jsa2Rldi5oPgo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2Jsay5o
Pgo+ICAgCj4gICAjaW5jbHVkZSAidmRwYV9zaW0uaCIKCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
