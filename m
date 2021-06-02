Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FFC4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:15:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837DC60200
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837DC60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4AD4240236;
	Wed,  2 Jun 2021 02:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QUS41ejNGrqq; Wed,  2 Jun 2021 02:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFFF040272;
	Wed,  2 Jun 2021 02:15:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3D5DC000D;
	Wed,  2 Jun 2021 02:15:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7166C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B08C34030B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yi1xiBEXbWbK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE70A40233
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622600108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cle+/CWEjt+Ggeb0RHpQ+aAs+qfHNk8GUbIdw+15kXg=;
 b=YSKgRbdWguVx12SQf35gaGbXhTXgq0UuWgay/WF6abphoJmMZkjDwlKB53966bZ6J2qjNs
 EDK/ZF968cDDyvkiIZoR/rWNm1XqNBv/lvfde2rvv44N58YVs4A2Nq3mMUln6NPXAbDHlU
 ToZmlHgyoN0Fz5PnEPHOX+9VmabXeTI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-_Ksp2_7NOi6TTGPfq4b8hw-1; Tue, 01 Jun 2021 22:15:07 -0400
X-MC-Unique: _Ksp2_7NOi6TTGPfq4b8hw-1
Received: by mail-pf1-f200.google.com with SMTP id
 j206-20020a6280d70000b02902e9e02e1654so664571pfd.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 19:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Cle+/CWEjt+Ggeb0RHpQ+aAs+qfHNk8GUbIdw+15kXg=;
 b=hwXzseuqm8QVqmkrWvNIx0F5s4e1/TzmHN7v13PkpZ0uA9rF9XFGD8Gn/qa17HDBNz
 MaXnIJxiDNOFD9+DU+ZP9B+SaVQFQX0hdRwVBp6u6zDri2mwMzkJ5/Cvw5hOfmm3TvAu
 60ioFycze6UN2UetHlqUuk/fLqGWphxPq9Waegcy9mlJNhBqItMRXOB+iANnMcHJOQWc
 f3VSVubF6ZoZcjw9Bh52xjU+deXUNyYm0zlVoPu1HUSYe18xIo2/T7nv/NC149jVMwiv
 UOzI89FX/MXuG8O9hCUi4UvzBGA/hRa1xWytSv9+FMQRXREa2J2mdLHnYooOBLi7mSZB
 Xi4g==
X-Gm-Message-State: AOAM532KR2vBtDKuHOabSd6QRGK0r99Dt03FRWnYoJEGTAFucKNeYjMI
 k8/zUrQ0fmIrQMUVf2GgUmQSJPyBs8tnKkiBvc0eCkY/+mDgQ5th1v3Gddmo40JGXucZRuR3D5N
 o7PijRx25RWz6yGF1yq7vtHkmKXdIFym3cRE+LcdRkA==
X-Received: by 2002:a17:90a:a08c:: with SMTP id
 r12mr2883167pjp.204.1622600106065; 
 Tue, 01 Jun 2021 19:15:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykGnr2O1DetdkzyvT3UnCkBGf69svfeCgS6uB7/1SFywbpMZIzEMp+JZbR6AtEywCmSjue0w==
X-Received: by 2002:a17:90a:a08c:: with SMTP id
 r12mr2883149pjp.204.1622600105909; 
 Tue, 01 Jun 2021 19:15:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l201sm5847594pfd.183.2021.06.01.19.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 19:15:05 -0700 (PDT)
Subject: Re: [PATCH V2 0/4]
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
References: <20210602021043.39201-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3a1f66f8-12af-3853-49a9-3bd27062a3bf@redhat.com>
Date: Wed, 2 Jun 2021 10:15:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602021043.39201-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eli@mellanox.com
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

CtTaIDIwMjEvNi8yIMnPzucxMDoxMCwgSmFzb24gV2FuZyDQtLXAOgo+ICoqKiBCTFVSQiBIRVJF
ICoqKgoKCk1pc3NpbmcgYmx1cmIuLi4KCldpbGwgcmVzZW5kIGEgbmV3IHZlcnNpb24uCgpUaGFu
a3MKCgo+Cj4gRWxpIENvaGVuICgxKToKPiAgICB2aXJ0aW8vdmRwYTogY2xlYXIgdGhlIHZpcnRx
dWV1ZSBzdGF0ZSBkdXJpbmcgcHJvYmUKPgo+IEphc29uIFdhbmcgKDMpOgo+ICAgIHZkcGE6IHN1
cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSBmb3Igc2V0L2dldF92cV9zdGF0ZSgpCj4gICAgdmlydGlv
LXBjaSBsaWJyYXJ5OiBpbnRyb2R1Y2UgdnBfbW9kZXJuX2dldF9kcml2ZXJfZmVhdHVyZXMoKQo+
ICAgIHZwX3ZkcGE6IGFsbG93IHNldCB2cSBzdGF0ZSB0byBpbml0aWFsIHN0YXRlIGFmdGVyIHJl
c2V0Cj4KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgICAgICAgIHwgIDQgKy0t
Cj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgICAgICB8ICA4ICsrLS0tCj4g
ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgICB8ICA0ICstLQo+ICAgZHJp
dmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jICAgICAgfCA0MiArKysrKysrKysrKysrKysr
KysrKysrKystLQo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICAgICAgICAgICAgfCAg
NCArLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jIHwgMjEgKysr
KysrKysrKysrKwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyAgICAgICAgICAgfCAx
NSArKysrKysrKysKPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgICAgICAgIHwg
MjUgKysrKysrKysrKysrKy0tCj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgg
ICAgICB8ICAxICsKPiAgIDkgZmlsZXMgY2hhbmdlZCwgMTA5IGluc2VydGlvbnMoKyksIDE1IGRl
bGV0aW9ucygtKQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
