Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DA4C433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:04:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A8F6054F
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98A8F6054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E46B80E3F;
	Mon, 11 Oct 2021 03:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGB2qLpMkFS1; Mon, 11 Oct 2021 03:04:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1107780E07;
	Mon, 11 Oct 2021 03:04:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB6FAC000F;
	Mon, 11 Oct 2021 03:04:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1066FC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF4B14024E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJUsBsPZLdjS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:04:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EB4B4023C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633921461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T79BKdCqOj489zc3OMzu2/jJB+p06oKh0yYujOy933Y=;
 b=MYLXmxTBszOmjtaGjJoIorRAN04cRlXGXkPQc5jewC8/sDxRrm9P5huY1bPw8I8nKz84qf
 wwsQvk61znLlRInWIUg0PMr+6SaYsRagdEpUXVNo2RMyaZvVGZmcdMxm1wCZA/L9p48oVz
 KZbbJ7FGMgotd++q+Ff1zL256CzwGNo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-qzd60yvhPamzSr3eRi0CXA-1; Sun, 10 Oct 2021 23:04:19 -0400
X-MC-Unique: qzd60yvhPamzSr3eRi0CXA-1
Received: by mail-pj1-f72.google.com with SMTP id
 41-20020a17090a0fac00b00195a5a61ab8so7867643pjz.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 20:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=T79BKdCqOj489zc3OMzu2/jJB+p06oKh0yYujOy933Y=;
 b=41Y7KfBdt7eohfPIwUEc7j9HEo0onv4t6sUq3zSpiDjgy8QAkDTaGGvxgpI78LpghZ
 m1HvfGQ3hnWhNVCEvevRFfXoiJO1iio+B5cSsr6wnyQPqmSU8LZkXRj57tnQCEDb4Drv
 GiEoIjkCazA9umYNsHP9HUyOU52fFueJrLQjtb7PGZO/NnH0xP5mjCV7fPWPIq2zNHTB
 TbCQztJIe6H9D/MNYX0jr0hg5CJva2rDEniJ1HYssXEnIBkR0a8U6M8czmATA2ACi3kc
 +t9WCmOEBIp9NnWh4Mp5HgBhjP7aek8gTbHUTlfVuA04tRWZKv6FdFpLyAFT8gXfbIb9
 CAnQ==
X-Gm-Message-State: AOAM533NX9PEIyK6q/hFqmoWB+UnyMgkErKQqMn4ky0hhfkHXg4A/lNX
 X02czltBhAGCwcUncaNQ9QUTb5gDCxVoZaKeZy2qBmCAQzC/hXMkC2hV+sZAWIiJVOsJJlhQq31
 U/2WmzWB0XJ7+Dtxo73Bqjb925ldr1eUJOwuFuU3WgA==
X-Received: by 2002:a17:90b:4d09:: with SMTP id
 mw9mr27157213pjb.100.1633921458636; 
 Sun, 10 Oct 2021 20:04:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj5eVsOT5kcTZ/KTOQVLWqO2RshC4Do9f4Y1Paq4OzbE2pH4irvvwspv1U+ckK8B0ZVkiBng==
X-Received: by 2002:a17:90b:4d09:: with SMTP id
 mw9mr27157183pjb.100.1633921458358; 
 Sun, 10 Oct 2021 20:04:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z9sm5505242pji.42.2021.10.10.20.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Oct 2021 20:04:17 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] vdpa: add new callback get_vq_num_min in
 vdpa_config_ops
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <451ce3c272ebd5d532db1ed19c2ab53c4609f7ad.1632882380.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a07c02e3-e5eb-ae94-33d9-26c29de484c9@redhat.com>
Date: Mon, 11 Oct 2021 11:04:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <451ce3c272ebd5d532db1ed19c2ab53c4609f7ad.1632882380.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com
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

CtTaIDIwMjEvOS8yOSDPws7nMjoxMSwgV3UgWm9uZ3lvbmcg0LS1wDoKPiBUaGlzIGNhbGxiYWNr
IGlzIG9wdGlvbmFsLiBGb3IgdmRwYSBkZXZpY2VzIHRoYXQgbm90IHN1cHBvcnQgdG8gY2hhbmdl
Cj4gdmlydHF1ZXVlIHNpemUsIGdldF92cV9udW1fbWluIGFuZCBnZXRfdnFfbnVtX21heCB3aWxs
IHJldHVybiB0aGUgc2FtZQo+IHZhbHVlLCBzbyB0aGF0IHVzZXJzIGNhbiBjaG9vc2UgYSBjb3Jy
ZWN0IHZhbHVlIGZvciB0aGF0IGRldmljZS4KPgo+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBXdSBab25neW9uZyA8d3V6b25n
eW9uZ0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA0ICsrKysKPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXggYTg5NmVlMDIxZTVm
Li4zMDg2NDg0ODk1MGIgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IEBAIC0xNzEsNiArMTcxLDkgQEAgc3RydWN0IHZkcGFf
bWFwX2ZpbGUgewo+ICAgICogQGdldF92cV9udW1fbWF4OgkJR2V0IHRoZSBtYXggc2l6ZSBvZiB2
aXJ0cXVldWUKPiAgICAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+ICAgICoJCQkJUmV0dXJucyB1
MTY6IG1heCBzaXplIG9mIHZpcnRxdWV1ZQo+ICsgKiBAZ2V0X3ZxX251bV9taW46CQlHZXQgdGhl
IG1pbiBzaXplIG9mIHZpcnRxdWV1ZSAob3B0aW9uYWwpCj4gKyAqCQkJCUB2ZGV2OiB2ZHBhIGRl
dmljZQo+ICsgKgkJCQlSZXR1cm5zIHUxNjogbWluIHNpemUgb2YgdmlydHF1ZXVlCj4gICAgKiBA
Z2V0X2RldmljZV9pZDoJCUdldCB2aXJ0aW8gZGV2aWNlIGlkCj4gICAgKgkJCQlAdmRldjogdmRw
YSBkZXZpY2UKPiAgICAqCQkJCVJldHVybnMgdTMyOiB2aXJ0aW8gZGV2aWNlIGlkCj4gQEAgLTI2
Niw2ICsyNjksNyBAQCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHsKPiAgIAl2b2lkICgqc2V0X2Nv
bmZpZ19jYikoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+ICAgCQkJICAgICAgc3RydWN0IHZk
cGFfY2FsbGJhY2sgKmNiKTsKPiAgIAl1MTYgKCpnZXRfdnFfbnVtX21heCkoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2KTsKPiArCXUxNiAoKmdldF92cV9udW1fbWluKShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYpOwo+ICAgCXUzMiAoKmdldF9kZXZpY2VfaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldik7Cj4gICAJdTMyICgqZ2V0X3ZlbmRvcl9pZCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
KTsKPiAgIAl1OCAoKmdldF9zdGF0dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
