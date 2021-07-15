Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED810C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:11:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B3361362
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 08:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B3361362
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 703D983D56;
	Thu, 15 Jul 2021 08:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9_NIvxyvPUnR; Thu, 15 Jul 2021 08:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EA1083D59;
	Thu, 15 Jul 2021 08:11:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0759AC0010;
	Thu, 15 Jul 2021 08:11:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4DBFC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 906B842256
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HvVJcWYbyY3Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:11:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6B9842257
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626336664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsyq0RE9WU7Ypp4Gm+eQdmDLZ+QGqhUmGOqrJ08ECV8=;
 b=M+28B+pJ/e5neDifuIqaPObyFlnnOtarb49Ad9fUrEp+rzfVxnH/FiMyKjvIr7VB0YcNhK
 0L5/ZNom2zTm1mKcYrrXY6dL+X3VUdeEU5BEe09z5oZfsDAtyVJ4hjPwzWBHtqjIDzSvee
 Wg73z191aHAsnRka8Dg7LcA9oJvfdPg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-THl0dZXXMdayPmmtXtIVsw-1; Thu, 15 Jul 2021 04:11:03 -0400
X-MC-Unique: THl0dZXXMdayPmmtXtIVsw-1
Received: by mail-pf1-f198.google.com with SMTP id
 q2-20020a056a000882b02903256c7471c7so3665159pfj.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 01:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tsyq0RE9WU7Ypp4Gm+eQdmDLZ+QGqhUmGOqrJ08ECV8=;
 b=cLh+sTrfLvse3ggyy8TZHBvTMHxsVtDt1WlXEJUcfeMcpI5vsjsSh76g+Vu6JJ/vmL
 HJ8HnxUspxzApZjlUOZx6Qw2rdFTOMEicl4fWUWBYtsIG3G4lIi6vQ5KGYmcFSVB9YMP
 asyPsop76J3mZwNxuxjJU1G9KcxeDZInOBS1TVX4SigKfPPf6Ui/osyvo6bfHKYo/33+
 g3w+iCp1qe76Rtv0nntE4bCXN9o0DWrcm0Xr/S4iQ94KhBfl2UZfEuE5d0ewbtKzu5YH
 DpHd2BG58Jyum6iAjpLKMaPB27gcq3z6Y9mmhc20+l3609ZamOfGBXGfkd6kSFbU5LIQ
 j6/Q==
X-Gm-Message-State: AOAM532IzRcrw3rM15WNuko7s5cVyc5obyMOu/a1FjpJObgWs/8h41Su
 8DlDN7naTZ0KZ7IWQYxuHcFymSlqWYC/jZ8iRfbdXuMWOzAEQAV063HQ9hGYwKVnnup/9P/ajwt
 88G71r4vvDk+77s0AaSxp23Brkrk3deRJ/nqKu2JYLA==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr3275851pjb.52.1626336662304; 
 Thu, 15 Jul 2021 01:11:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgdRSlGSxamOhLsopmlpgUvS49WuoZJFtfu/4SL+rwM+O8AzT3DsZTC193gTbNFSIv6SvnpA==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr3275838pjb.52.1626336662106; 
 Thu, 15 Jul 2021 01:11:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x68sm5470497pfb.115.2021.07.15.01.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 01:11:01 -0700 (PDT)
Subject: Re: [PATCH 4/4] vdpa: Add documentation for vdpa_alloc_device() macro
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 dan.carpenter@oracle.com
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <30a9222e-30fc-8dfb-312e-05367785ff6a@redhat.com>
Date: Thu, 15 Jul 2021 16:10:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-4-xieyongji@bytedance.com>
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

CtTaIDIwMjEvNy8xNSDPws7nNDowMCwgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSByZXR1cm4gdmFs
dWUgb2YgdmRwYV9hbGxvY19kZXZpY2UoKSBtYWNybyBpcyBub3QgdmVyeQo+IGNsZWFyLCBzbyB0
aGF0IG1vc3Qgb2YgY2FsbGVycyBkaWQgdGhlIHdyb25nIGNoZWNrLiBMZXQncwo+IGFkZCBzb21l
IGNvbW1lbnRzIHRvIGJldHRlciBkb2N1bWVudCBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZ
b25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDEx
ICsrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBp
bmRleCAzMzU3YWM5ODg3OGQuLjhjZmU0OWQyMDFkZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3ZkcGEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTI3Nyw2ICsyNzcs
MTcgQEAgc3RydWN0IHZkcGFfZGV2aWNlICpfX3ZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCBkZXZp
Y2UgKnBhcmVudCwKPiAgIAkJCQkJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqY29uZmln
LAo+ICAgCQkJCQlzaXplX3Qgc2l6ZSwgY29uc3QgY2hhciAqbmFtZSk7Cj4gICAKPiArLyoqCj4g
KyAqIHZkcGFfYWxsb2NfZGV2aWNlIC0gYWxsb2NhdGUgYW5kIGluaXRpbGFpemUgYSB2RFBBIGRl
dmljZQo+ICsgKgo+ICsgKiBAZGV2X3N0cnVjdDogdGhlIHR5cGUgb2YgdGhlIHBhcmVudCBzdHJ1
Y3R1cmUKPiArICogQG1lbWJlcjogdGhlIG5hbWUgb2Ygc3RydWN0IHZkcGFfZGV2aWNlIHdpdGhp
biB0aGUgQGRldl9zdHJ1Y3QKPiArICogQHBhcmVudDogdGhlIHBhcmVudCBkZXZpY2UKPiArICog
QGNvbmZpZzogdGhlIGJ1cyBvcGVyYXRpb25zIHRoYXQgaXMgc3VwcG9ydGVkIGJ5IHRoaXMgZGV2
aWNlCj4gKyAqIEBuYW1lOiBuYW1lIG9mIHRoZSB2ZHBhIGRldmljZQo+ICsgKgo+ICsgKiBSZXR1
cm4gYWxsb2NhdGVkIGRhdGEgc3RydWN0dXJlIG9yIEVSUl9QVFIgdXBvbiBlcnJvcgo+ICsgKi8K
PiAgICNkZWZpbmUgdmRwYV9hbGxvY19kZXZpY2UoZGV2X3N0cnVjdCwgbWVtYmVyLCBwYXJlbnQs
IGNvbmZpZywgbmFtZSkgICBcCj4gICAJCQkgIGNvbnRhaW5lcl9vZihfX3ZkcGFfYWxsb2NfZGV2
aWNlKCBcCj4gICAJCQkJICAgICAgIHBhcmVudCwgY29uZmlnLCBcCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
