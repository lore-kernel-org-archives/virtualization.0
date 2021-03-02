Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F99C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 14:15:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6E564F0B
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 14:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6E564F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9861A43166;
	Tue,  2 Mar 2021 14:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDXufkLiyYDc; Tue,  2 Mar 2021 14:15:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D2D8430A2;
	Tue,  2 Mar 2021 14:15:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10587C000A;
	Tue,  2 Mar 2021 14:15:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1EADC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 972DB4F100
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4t4Y2N0MtYx
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:15:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6A274F0F3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614694523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjOoUYxeG19DT5eJ2WuZnRhWzkvWoRa4HG3rYru+1nk=;
 b=TARHDRKxTcMj23Ok+2Ue2h34m0Or4hNvqr5wYCSrEogVGb6ZEih1dqQ1EZHQayfT86n6JE
 7AzPiq9hhLfRYpCtyrtr69m1Ww6p6E7CBPmiXu9SqAFAS6rOgEW2LY/MI1Cj3+2HaLmVql
 xSwDW6xoum85NZDzoeoBWeEXQZ+cag8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-0faSmOTLOpioJv-ItkAA5A-1; Tue, 02 Mar 2021 09:15:21 -0500
X-MC-Unique: 0faSmOTLOpioJv-ItkAA5A-1
Received: by mail-ej1-f71.google.com with SMTP id n25so8538556ejd.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Mar 2021 06:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rjOoUYxeG19DT5eJ2WuZnRhWzkvWoRa4HG3rYru+1nk=;
 b=p/M0GlFXuPeQ3bn4hfK+IF4foKz0KVGbZ5gsRNP33HWR0Ze54zd48SFwKoFkrvinER
 Kn41LWluXfRjlBspkOQuV2HE8bx5k/ILWyZDyWJCq7IMoqRFQHjonCgxNtnuz+OlkaTL
 SEhuMNUXPMO3rC8NLdDuVp1SINPAhVAQjDNAiujq5w2/kUUVIMMDc7pY3O38gp0TxPaP
 0EDlfN2O546K50cH5ixrlqSTn/EMhYzdg99L9V0lDmtR+Yc6MTspqHsvH1bMPAXezqTk
 faCejnu67FBGOEHQhjGdzIDI9p40hBCWxgsTnSufhJAndAqy4ZXFwZ8yXu88rmaA2/Pc
 5GAA==
X-Gm-Message-State: AOAM530pDoFHfcjiXK9Vk3o0jLWwlfI8roNDDj63NzCA4Up+RfvDA0mB
 S6TRzGFVsV3k5NweKpa+dMcJ7WZPgYFriWflsSD+QCjjg2hQIzcQI3KPc9itGR/QmGEz85enYKU
 tDJc9QlCpDddqblUisPQ4kPdfr2+ZxkUb1NDyvXYhVA==
X-Received: by 2002:a17:906:f891:: with SMTP id
 lg17mr21120899ejb.69.1614694520442; 
 Tue, 02 Mar 2021 06:15:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygE29SnX3D3HuuzIHfSkf8dbUaigd8KEMZKU0eY9r+w462+eOcRfQHeat9otGJbyl2OKaNyA==
X-Received: by 2002:a17:906:f891:: with SMTP id
 lg17mr21120877ejb.69.1614694520244; 
 Tue, 02 Mar 2021 06:15:20 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id c17sm18013380edw.32.2021.03.02.06.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 06:15:19 -0800 (PST)
Date: Tue, 2 Mar 2021 15:15:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 01/10] vdpa: add get_config_size callback in
 vdpa_config_ops
Message-ID: <20210302141516.oxsdb7jogrvu75yc@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-2-sgarzare@redhat.com>
 <5de4cd5b-04cb-46ca-1717-075e5e8542fd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5de4cd5b-04cb-46ca-1717-075e5e8542fd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBNYXIgMDIsIDIwMjEgYXQgMTI6MTQ6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8yLzE2IDU6NDQg5LiL5Y2ILCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+VGhpcyBuZXcgY2FsbGJhY2sgaXMgdXNlZCB0byBnZXQgdGhlIHNpemUgb2YgdGhlIGNvbmZp
Z3VyYXRpb24gc3BhY2UKPj5vZiB2RFBBIGRldmljZXMuCj4+Cj4+U2lnbmVkLW9mZi1ieTogU3Rl
ZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pi0tLQo+PiAgaW5jbHVkZS9s
aW51eC92ZHBhLmggICAgICAgICAgICAgIHwgNCArKysrCj4+ICBkcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jICAgfCA2ICsrKysrKwo+PiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jIHwgNiArKysrKysKPj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICB8
IDkgKysrKysrKysrCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykKPj4KPj5k
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
PmluZGV4IDRhYjU0OTQ1MDNhOC4uZmRkZjQyYjE3NTczIDEwMDY0NAo+Pi0tLSBhL2luY2x1ZGUv
bGludXgvdmRwYS5oCj4+KysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj5AQCAtMTUwLDYgKzE1
MCw5IEBAIHN0cnVjdCB2ZHBhX2lvdmFfcmFuZ2Ugewo+PiAgICogQHNldF9zdGF0dXM6CQkJU2V0
IHRoZSBkZXZpY2Ugc3RhdHVzCj4+ICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPj4gICAqCQkJ
CUBzdGF0dXM6IHZpcnRpbyBkZXZpY2Ugc3RhdHVzCj4+KyAqIEBnZXRfY29uZmlnX3NpemU6CQlH
ZXQgdGhlIHNpemUgb2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UKPj4rICoJCQkJQHZkZXY6IHZk
cGEgZGV2aWNlCj4+KyAqCQkJCVJldHVybnMgc2l6ZV90OiBjb25maWd1cmF0aW9uIHNpemUKPgo+
Cj5SZXRoaW5rIGFib3V0IHRoaXMsIGhvdyBtdWNoIHdlIGNvdWxkIGdhaW4gYnkgaW50cm9kdWNp
bmcgYSBkZWRpY2F0ZWQgCj5vcHMgaGVyZT8gRS5nIHdvdWxkIGl0IGJlIHNpbXBsZXIgaWYgd2Ug
c2ltcGx5IGludHJvZHVjZSBhIAo+bWF4X2NvbmZpZ19zaXplIHRvIHZkcGEgZGV2aWNlPwoKTWFp
bmx5IGJlY2F1c2UgaW4gdGhpcyB3YXkgd2UgZG9uJ3QgaGF2ZSB0byBhZGQgbmV3IHBhcmFtZXRl
cnMgdG8gdGhlIAp2ZHBhX2FsbG9jX2RldmljZSgpIGZ1bmN0aW9uLgoKV2UgZG8gdGhlIHNhbWUg
Zm9yIGV4YW1wbGUgZm9yICdnZXRfZGV2aWNlX2lkJywgJ2dldF92ZW5kb3JfaWQnLCAKJ2dldF92
cV9udW1fbWF4Jy4gQWxsIG9mIHRoZXNlIGFyZSB1c3VhbGx5IHN0YXRpYywgYnV0IHdlIGhhdmUg
b3BzLgpJIHRoaW5rIGJlY2F1c2UgaXQncyBlYXNpZXIgdG8gZXh0ZW5kLgoKSSBkb24ndCBrbm93
IGlmIGl0J3Mgd29ydGggYWRkaW5nIGEgbmV3IHN0cnVjdHVyZSBmb3IgdGhlc2Ugc3RhdGljIAp2
YWx1ZXMgYXQgdGhpcyBwb2ludCwgbGlrZSAnc3RydWN0IHZkcGFfY29uZmlnX3BhcmFtcycuCgpU
aGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
