Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9A0C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:03:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811776136E
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811776136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4646640313;
	Thu, 15 Jul 2021 08:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IMbpU07CmHF2; Thu, 15 Jul 2021 08:03:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 907E5402A7;
	Thu, 15 Jul 2021 08:03:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55662C0010;
	Thu, 15 Jul 2021 08:03:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6597DC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 410A3402BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id muLo9pZkGQSh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:03:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8505402A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626336226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5u6pg0hYCaUNMo58LvBtVvCroUSMpkH2wRipT9msuM=;
 b=K5Ypu4i7KHq+zE7ZIcPQj0m5IvzXph5bNZsZmxc8x+ZK3qxF7s4C39c2F3m25UPrhQubJw
 ZFtAlSdd5cUhsm71ugw4hBmILK9jmZw25bBbzsXvdnNQk8tzbhkooTbiwA9D2KdaRyLcSs
 KQ1iaN3G24zn37TDjKaPhrTmG86lnhE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-XTeAJrR1PbKZAnpFLsCoyw-1; Thu, 15 Jul 2021 04:03:45 -0400
X-MC-Unique: XTeAJrR1PbKZAnpFLsCoyw-1
Received: by mail-pf1-f199.google.com with SMTP id
 k11-20020aa792cb0000b02903305e16bd1dso3655922pfa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 01:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=u5u6pg0hYCaUNMo58LvBtVvCroUSMpkH2wRipT9msuM=;
 b=W25a+ZQ8alnsRy+EKA2nL9hPKGq/yUbvUDFs28ZzJBOjsnvumd19alSarxbplVyigR
 LXuIWf2mQpdoA/N1nb/j9VkA4ffkDTTw9SDEJyN5gGf12HBO3aoeSz83J5BpSsqoPziR
 juoLJVAWID0JS/2p47sQVCV8HPr9ZGdAak685w/0ugbLyt7TozXSEgj4WsDlrGUuk/EW
 rzFva86wFgS2N1DGpkL0yN4MvQ8B1E4+sacc3eOwho7Kp4bBUl0nbYboRAft8UERdI4l
 zsGyai1i63MIDkQoSf7OpuVXYGCK8VFqzUp6ud00tQhdNCE9Gnz0sTozcXdh6viMPkaw
 +KOQ==
X-Gm-Message-State: AOAM533xjOVTn3PaK7BxxwR2bdBLTH1ELh5BUVha5IaosuIJgywLuLaj
 dT+/385/hW2/MtfCmDBgOURK6IcmeSlewUMI6kfFEXkWrk7BqsA90wUDJyW9dsVAeKg+ieU6F1Y
 HBN+HCVjCEKmpRfBhzMdaAKkVXZqlwRl8FwzumGe2dQ==
X-Received: by 2002:a17:90a:4205:: with SMTP id
 o5mr8579260pjg.131.1626336224464; 
 Thu, 15 Jul 2021 01:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3qMf4Hw/PAsPqQGH5Kwd/EmAPkF38M9Z2w2cgp0M3rMmGu/6JdyPiHCDx8h7AbuKAbUSmbg==
X-Received: by 2002:a17:90a:4205:: with SMTP id
 o5mr8579226pjg.131.1626336224192; 
 Thu, 15 Jul 2021 01:03:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w16sm6008583pgi.41.2021.07.15.01.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 01:03:43 -0700 (PDT)
Subject: Re: [PATCH 1/4] vdpa_sim: Fix return value check for
 vdpa_alloc_device()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 dan.carpenter@oracle.com
References: <20210715075936.180-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7db5fbcd-3672-3a26-8b9f-bb01e3d3c3bd@redhat.com>
Date: Thu, 15 Jul 2021 16:03:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715075936.180-1-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8xNSDPws7nMzo1OSwgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSB2ZHBhX2FsbG9j
X2RldmljZSgpIHJldHVybnMgYW4gZXJyb3IgcG9pbnRlciB1cG9uCj4gZmFpbHVyZSwgbm90IE5V
TEwuIFRvIGhhbmRsZSB0aGUgZmFpbHVyZSBjb3JyZWN0bHksIHRoaXMKPiByZXBsYWNlcyBOVUxM
IGNoZWNrIHdpdGggSVNfRVJSKCkgY2hlY2sgYW5kIHByb3BhZ2F0ZSB0aGUKPiBlcnJvciB1cHdh
cmRzLgo+Cj4gRml4ZXM6IDJjNTNkMGY2NGMwNiAoInZkcGFzaW06IHZEUEEgZGV2aWNlIHNpbXVs
YXRvciIpCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNv
bT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+
ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCA0ICsrKy0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbS5jCj4gaW5kZXggMTRlMDI0ZGU1Y2JmLi5jNjIxY2Y3ZmVlYzAgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC0yNTEsOCArMjUxLDEwIEBAIHN0cnVjdCB2ZHBhc2lt
ICp2ZHBhc2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciAqZGV2X2F0dHIpCj4gICAK
PiAgIAl2ZHBhc2ltID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IHZkcGFzaW0sIHZkcGEsIE5V
TEwsIG9wcywKPiAgIAkJCQkgICAgZGV2X2F0dHItPm5hbWUpOwo+IC0JaWYgKCF2ZHBhc2ltKQo+
ICsJaWYgKElTX0VSUih2ZHBhc2ltKSkgewo+ICsJCXJldCA9IFBUUl9FUlIodmRwYXNpbSk7Cj4g
ICAJCWdvdG8gZXJyX2FsbG9jOwo+ICsJfQo+ICAgCj4gICAJdmRwYXNpbS0+ZGV2X2F0dHIgPSAq
ZGV2X2F0dHI7Cj4gICAJSU5JVF9XT1JLKCZ2ZHBhc2ltLT53b3JrLCBkZXZfYXR0ci0+d29ya19m
bik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
