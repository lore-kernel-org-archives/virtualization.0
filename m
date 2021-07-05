Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785B7C07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 05:09:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D70613DD
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 05:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D70613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3FAE83A15;
	Mon,  5 Jul 2021 05:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUXOmRlo4fjZ; Mon,  5 Jul 2021 05:09:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 93197839DD;
	Mon,  5 Jul 2021 05:09:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CB9C001A;
	Mon,  5 Jul 2021 05:09:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C76C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 05:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE33140168
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 05:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kRcboaKIPI84
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 05:09:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CC2A400B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 05:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625461773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKsids3f945YQDF5Oen93rLvMd+sZCBgdX5IUN3ZQHE=;
 b=X2ttzcBAagBgxA3kPq+jmHuglmdO3DidUgxa0NiDTiRRaJbxZwYlDchnNkIqX80iJ/x4ad
 IbZ/3O4MnEjhnDDZcHSvXJx8NFTHOD228MaGwl2YbN7TuJqjDrN5eV0l4F5C0rx5dm+5Pn
 DfwBzVEIExZcePIC84lmGMLlAFcF8sQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-4CIHhAStNZOTrbWYOy9GXQ-1; Mon, 05 Jul 2021 01:09:31 -0400
X-MC-Unique: 4CIHhAStNZOTrbWYOy9GXQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 c24-20020a1709028498b0290128cdfbb2f1so5890405plo.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 22:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GKsids3f945YQDF5Oen93rLvMd+sZCBgdX5IUN3ZQHE=;
 b=g4clmp5VG46hF5qRvUcgSbeE2KsFDeG2aPrHKCRFvg5EL+tFEUVAzdP8Aj4j8RL5eo
 M5zs+7D9r/4d8g3ZHkbE+TFrx8xp4swrX99PaqsgTO55LXRkoBiOjpnEbQminXeH1Zhz
 1ikZ85kJiizkx8pQ7pkfm4zmFv4PLE91bFY5+7rbNdUXonFrqVqkjhjlIpXa6N01VHeY
 LCwJBMt5FTR/VH3TOQOg9GD0H3vgl6lp/TnK6dJ2i/1ruZS2QH/GL0RX3kr11IE2DJBB
 Kg4j+pUffDqq5Ab+2f+Ea8sJGDiResQaEMeqGIgJd3+X5A6A8c7NybSaDfUN73l3JrAG
 A6Tw==
X-Gm-Message-State: AOAM533yl5jpRjdjUAMgI3a7nBCGd3m8XtULdVd3cbkeLwYARsyl8VeA
 04Vvvqoh0rJG0XC72OIJ0eIosaURFd6ChljDmyp/N3WJxtV2DxlWcTf0IYplfrgKJMYRJaRCeUP
 3QMPZE/5CgyMXbHf2f2apcjvFwk/GgmLUDM+0iTa0UA==
X-Received: by 2002:a17:902:7403:b029:129:5f48:dc37 with SMTP id
 g3-20020a1709027403b02901295f48dc37mr9523532pll.58.1625461769922; 
 Sun, 04 Jul 2021 22:09:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYKuL/vTytNEw3Xxr1NKzCafhtSD+dri4UUFdqvBeHMdSNzzAMluRD5YRZoC8KMP8WxfzvsA==
X-Received: by 2002:a17:902:7403:b029:129:5f48:dc37 with SMTP id
 g3-20020a1709027403b02901295f48dc37mr9523505pll.58.1625461769424; 
 Sun, 04 Jul 2021 22:09:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d1sm10341887pfu.6.2021.07.04.22.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jul 2021 22:09:28 -0700 (PDT)
Subject: Re: [PATCH 3/3] vDPA/ifcvf: set_status() should get a adapter from
 the mgmt dev
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210630082145.5729-1-lingshan.zhu@intel.com>
 <20210630082145.5729-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <81d8aaed-f2e8-bbf8-a7d5-71e41837d866@redhat.com>
Date: Mon, 5 Jul 2021 13:09:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630082145.5729-4-lingshan.zhu@intel.com>
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

CtTaIDIwMjEvNi8zMCDPws7nNDoyMSwgWmh1IExpbmdzaGFuINC0tcA6Cj4gaWZjdmZfdmRwYV9z
ZXRfc3RhdHVzKCkgc2hvdWxkIGdldCBhIGFkYXB0ZXIgZnJvbSB0aGUKPiBtYW5hZ2VtZW50IGRl
dmljZQo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQgKysrLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfbWFpbi5jCj4gaW5kZXggN2MyZjY0Y2EyMTYzLi4yOGM3MWVlZjFkMmIgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBAQCAtMjEyLDEzICsyMTIsMTUgQEAgc3RhdGlj
IHU4IGlmY3ZmX3ZkcGFfZ2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+
ICAgCj4gICBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhX2RldiwgdTggc3RhdHVzKQo+ICAgewo+ICsJc3RydWN0IGlmY3ZmX3ZkcGFfbWdt
dF9kZXYgKmlmY3ZmX21nbXRfZGV2Owo+ICAgCXN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVy
Owo+ICAgCXN0cnVjdCBpZmN2Zl9odyAqdmY7Cj4gICAJdTggc3RhdHVzX29sZDsKPiAgIAlpbnQg
cmV0Owo+ICAgCj4gICAJdmYgID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4gLQlhZGFwdGVyID0g
ZGV2X2dldF9kcnZkYXRhKHZkcGFfZGV2LT5kZXYucGFyZW50KTsKCgpJZiB0aGlzIGlzIGEgZml4
IGZvciBwYXRjaCAyLCB5b3UgbmVlZCB0byBzcXVhc2ggdGhpcyBpbnRvIHRoYXQgb25lLgoKQW55
IHJlYXNvbiB0aGF0IHZkcGFfdG9fYWRhcHRlcigpIGNhbid0IHdvcms/CgpBbmQgSSBzZWU6Cgor
c3RydWN0IGlmY3ZmX3ZkcGFfbWdtdF9kZXYgeworCXN0cnVjdCB2ZHBhX21nbXRfZGV2IG1kZXY7
CisJc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXI7CisJc3RydWN0IHBjaV9kZXYgKnBkZXY7
Cit9OwoKV2hhdCdzIHRoZSByZWFzb24gZm9yIGhhdmluZyBhIGFkYXB0ZXIgcG9pbnRlciBoZXJl
PwoKVGhhbmtzCgoKPiArCWlmY3ZmX21nbXRfZGV2ID0gZGV2X2dldF9kcnZkYXRhKHZkcGFfZGV2
LT5kZXYucGFyZW50KTsKPiArCWFkYXB0ZXIgPSBpZmN2Zl9tZ210X2Rldi0+YWRhcHRlcjsKPiAg
IAlzdGF0dXNfb2xkID0gaWZjdmZfZ2V0X3N0YXR1cyh2Zik7Cj4gICAKPiAgIAlpZiAoc3RhdHVz
X29sZCA9PSBzdGF0dXMpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
