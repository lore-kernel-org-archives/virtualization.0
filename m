Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739CC47082
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 01:55:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C916E61263
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 01:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C916E61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B24F60A6D;
	Tue,  1 Jun 2021 01:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsy-81p0OPfQ; Tue,  1 Jun 2021 01:55:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 368B560A49;
	Tue,  1 Jun 2021 01:55:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17DD7C000D;
	Tue,  1 Jun 2021 01:55:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7D73C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE07B402EB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z_ZntkpuxpoT
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:55:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 406E4402E9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622512504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ASyMBPQPEsfDziJ+K95xbpCDWyQpQmjYvWNZlEBpeY=;
 b=A3y0G6cH6WZOjoCXP863mCQgWDYZ2yXJqtzquDQUcMmXT7JurZDAI+QxgjEiDfVnQcJbEm
 J37QdjzhlUzkYbvFNHy+cEMBmrJkKGg3ldDTUbqgzqa7m3d2RWSqrbyVtIfD8lB5RQIdyw
 Jd9IT4COtGC+W/OWqsHVms2daHvPTvc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-dx5dQIw0MomXKfAVHeLGIg-1; Mon, 31 May 2021 21:55:02 -0400
X-MC-Unique: dx5dQIw0MomXKfAVHeLGIg-1
Received: by mail-pf1-f197.google.com with SMTP id
 s5-20020aa78d450000b02902ace63a7e93so6560582pfe.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 18:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7ASyMBPQPEsfDziJ+K95xbpCDWyQpQmjYvWNZlEBpeY=;
 b=UX0+BRK5t+FUkrCJ9PDrWldJhXcRwm2tSDjW0X0Yvq2MZIRXPhJ70mkc9LmqbVj3D6
 DhMVO0hXIyJIrR050am3GGB513g6vI3h/e0rqZ0EtLf0caTHJrxgjg4EygJ4wHmUScJ2
 n15uhurDWp9uU5/a4cZx+/IWpm8KACy7JQbbkkOxZmo1/7jqdh3LYR+PkJ8lZ+M8m+wl
 sisvwernYxIcNBKWbmIpe7GMb7mXcwFP4TwVolgH2pD6zqzDIlSwS4XRN7KSxs3LswDA
 e4jD5B1xofWgEX+1Id+Qlk7derrvDWt5GKPqI2jDINQJKj1nMTQrZNHfqhH34CIaDFs3
 fFzw==
X-Gm-Message-State: AOAM532LTszhDldnGePtu9pbUZ03eRn+bOJIsvJJQeAEiDTwh0T9YZLc
 3Z0MajneCp8o/Li1EWFh+4sP+82uXzm6tlul6KtiWIH25NhFUAY0sSbcxtf0gK0mo+A82A0caYF
 LzS8PZqwHDfP6O0uwfCC5LfW9R1uEB3EivckFgBMvOw==
X-Received: by 2002:a17:902:4:b029:fa:670f:f20f with SMTP id
 4-20020a1709020004b02900fa670ff20fmr23126201pla.11.1622512501249; 
 Mon, 31 May 2021 18:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwackNHk9NU70dohTROxE93bBTCw+m7dTBc2owq9+YhG/iJRBmDXtt6soLUeratGznqq9fVOQ==
X-Received: by 2002:a17:902:4:b029:fa:670f:f20f with SMTP id
 4-20020a1709020004b02900fa670ff20fmr23126187pla.11.1622512501000; 
 Mon, 31 May 2021 18:55:01 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 195sm154446pfz.24.2021.05.31.18.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 18:55:00 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] vdpa/mlx5: Support creating resources with uid == 0
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210531160404.31368-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <09bf796a-2c89-496d-a304-e889f3519a5c@redhat.com>
Date: Tue, 1 Jun 2021 09:54:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531160404.31368-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CtTaIDIwMjEvNi8xIMnPzucxMjowNCwgRWxpIENvaGVuINC0tcA6Cj4gQ3VycmVudGx5IGFsbCBy
ZXNvdXJjZXMgbXVzdCBiZSBjcmVhdGVkIHdpdGggdWlkICE9IDAgd2hpY2ggaXMgZXNzZW50aWFs
Cj4gd2hlbiB1c2Vyc3BhY2UgcHJvY2Vzc2VzIGFyZSBhbGxvY2F0aW5nIHZpcnRxdXVldWUgcmVz
b3VyY2VzLiBTaW5jZSB0aGlzCj4gaXMgYSBrZXJuZWwgaW1wbGVtZW50YXRpb24sIGl0IGlzIHBl
cmZlY3RseSBsZWdhbCB0byBvcGVuIHJlc291cmNlcyB3aXRoCj4gdWlkID09IDAuCj4KPiBJbiBj
YXNlIGZpcm13YXJlIHN1cHBvcnRzLCBhdm9pZCBhbGxvY2F0aW5nIHVzZXIgY29udGV4dC4KPgo+
IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgoKCkFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gdjAgLS0+IHYxOgo+ICAg
IEZpeCB0eXBvIGFuZCBtb2RpZnkgcGhyYXNpbmcKPgo+ICAgZHJpdmVycy92ZHBhL21seDUvY29y
ZS9yZXNvdXJjZXMuYyB8IDYgKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmMu
aCAgICAgIHwgNCArKystCj4gICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3Vy
Y2VzLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4gaW5kZXggNjUyMWNi
ZDBmNWMyLi44MzZhYjllZjBmYTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9yZXNvdXJjZXMuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMK
PiBAQCAtNTQsNiArNTQsOSBAQCBzdGF0aWMgaW50IGNyZWF0ZV91Y3R4KHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldiwgdTE2ICp1aWQpCj4gICAJdm9pZCAqaW47Cj4gICAJaW50IGVycjsKPiAg
IAo+ICsJaWYgKE1MWDVfQ0FQX0dFTihtdmRldi0+bWRldiwgdW1lbV91aWRfMCkpCj4gKwkJcmV0
dXJuIDA7Cj4gKwo+ICAgCS8qIDAgbWVhbnMgbm90IHN1cHBvcnRlZCAqLwo+ICAgCWlmICghTUxY
NV9DQVBfR0VOKG12ZGV2LT5tZGV2LCBsb2dfbWF4X3VjdHgpKQo+ICAgCQlyZXR1cm4gLUVPUE5P
VFNVUFA7Cj4gQEAgLTc5LDYgKzgyLDkgQEAgc3RhdGljIHZvaWQgZGVzdHJveV91Y3R4KHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTMyIHVpZCkKPiAgIAl1MzIgb3V0W01MWDVfU1RfU1pf
RFcoZGVzdHJveV91Y3R4X291dCldID0ge307Cj4gICAJdTMyIGluW01MWDVfU1RfU1pfRFcoZGVz
dHJveV91Y3R4X2luKV0gPSB7fTsKPiAgIAo+ICsJaWYgKCF1aWQpCj4gKwkJcmV0dXJuOwo+ICsK
PiAgIAlNTFg1X1NFVChkZXN0cm95X3VjdHhfaW4sIGluLCBvcGNvZGUsIE1MWDVfQ01EX09QX0RF
U1RST1lfVUNUWCk7Cj4gICAJTUxYNV9TRVQoZGVzdHJveV91Y3R4X2luLCBpbiwgdWlkLCB1aWQp
Owo+ICAgCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5oIGIvaW5j
bHVkZS9saW51eC9tbHg1L21seDVfaWZjLmgKPiBpbmRleCA5YzY4YjJkYTE0YzYuLjYwNmQyYWVh
Y2FkNCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmMuaAo+ICsrKyBi
L2luY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5oCj4gQEAgLTE0ODcsNyArMTQ4Nyw5IEBAIHN0
cnVjdCBtbHg1X2lmY19jbWRfaGNhX2NhcF9iaXRzIHsKPiAgIAl1OCAgICAgICAgIHVhcl80a1sw
eDFdOwo+ICAgCXU4ICAgICAgICAgcmVzZXJ2ZWRfYXRfMjQxWzB4OV07Cj4gICAJdTggICAgICAg
ICB1YXJfc3pbMHg2XTsKPiAtCXU4ICAgICAgICAgcmVzZXJ2ZWRfYXRfMjUwWzB4OF07Cj4gKwl1
OCAgICAgICAgIHJlc2VydmVkX2F0XzI0OFsweDJdOwo+ICsJdTggICAgICAgICB1bWVtX3VpZF8w
WzB4MV07Cj4gKwl1OCAgICAgICAgIHJlc2VydmVkX2F0XzI1MFsweDVdOwo+ICAgCXU4ICAgICAg
ICAgbG9nX3BnX3N6WzB4OF07Cj4gICAKPiAgIAl1OCAgICAgICAgIGJmWzB4MV07CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
