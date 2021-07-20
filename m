Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4391FC07E95
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 03:13:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CC06113B
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 03:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CC06113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 729AC607D5;
	Tue, 20 Jul 2021 03:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZY1eEVKcsFl8; Tue, 20 Jul 2021 03:13:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 18B72605DB;
	Tue, 20 Jul 2021 03:13:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0368C001A;
	Tue, 20 Jul 2021 03:13:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9736EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 718404023A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id if303jy5udJs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:13:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9442400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626750787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoLEcT33LRgRDL/zFFgtY3SrFi92a7SIbwIG491oqAU=;
 b=TZ9y26hoA1kGNVSEQq2witH4pTK6mFVXEjbtkfKdmgmZGeY3L8hQ6lTpEINHLffKqP4WsQ
 0s/JpeGxnbV/DVQOrZTVxIyLqVxpp+igI0xHL9iyrVBK1Pq5+yKx9VEItkrAWRAN2rC9HQ
 Di076hTGO8RFBQAdeVfqmAcTAE5fhnA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-mnxnlYunN2eVj6NjHE5CHA-1; Mon, 19 Jul 2021 23:13:06 -0400
X-MC-Unique: mnxnlYunN2eVj6NjHE5CHA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d8-20020a056a001988b02903468678ce14so4620683pfl.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 20:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DoLEcT33LRgRDL/zFFgtY3SrFi92a7SIbwIG491oqAU=;
 b=NkkRzzdz24JotuVuQcV3WD/CPGxOhqbOeJcPvXtXQJhw9cndDaneeIgSTAZKXdmvTe
 hBBnPvF9/t5ZDW2jGn2CRvtN+CWi3GPDv9zGlFm47nY5kcO/txAUWQx07VWF1lc8ugu9
 6vo3uzrACHI/w+oRrr7+GUJWnVHHV+5BBHmrzujpe1ngriAZv0tmtgkGx5vrs7gl++Gr
 SrkV95Rvj4FrEey/rh5/z/+h1wMJ7iz1ajMUErwDQ3z4PAsLV6jvlH1CiXnS0YIvb9l6
 kmtg4F0Pdn8zMC8y3+eNpeQ3gOiLoEsPnZXaxBBQcR1AgbEvnxzWzZjOuycZqnNa5oPQ
 aaCg==
X-Gm-Message-State: AOAM532EvnrjEUjiuVuqyy5Bnmx1mAAO6rwS7wr3KlNZFlFdZkd9i9wv
 tXO+/ISQcqWs4aCwTQ/MPI6kGH0lApf70EFzfip5GU3pyb6YQIips90VA4Z2yx2WLo1ACwuIpY8
 LE1gofgH3rkyVPoIVjuJQetttD3GEmwkBEdGQvPl/yA==
X-Received: by 2002:a17:902:ea07:b029:129:ade2:1b05 with SMTP id
 s7-20020a170902ea07b0290129ade21b05mr21629477plg.31.1626750784942; 
 Mon, 19 Jul 2021 20:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+4DvQ+yNCHTnf+mLnJP+rqdTfJp4hrhDj9VtzG/Y3UP2/HCHBpsXpxIocOrKbBFUaJ1HO4g==
X-Received: by 2002:a17:902:ea07:b029:129:ade2:1b05 with SMTP id
 s7-20020a170902ea07b0290129ade21b05mr21629458plg.31.1626750784644; 
 Mon, 19 Jul 2021 20:13:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x10sm13865584pfh.56.2021.07.19.20.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 20:13:04 -0700 (PDT)
Subject: Re: [PATCH] vdpa/vdpa_sim: Use the negotiated features when calling
 vringh_init_iotlb
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210719134407.175884-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <970569fc-80bc-b0ef-b163-c59650796515@redhat.com>
Date: Tue, 20 Jul 2021 11:13:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719134407.175884-1-elic@nvidia.com>
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

CtTaIDIwMjEvNy8xOSDPws7nOTo0NCwgRWxpIENvaGVuINC0tcA6Cj4gV2hlbiBjYWxsaW5nIHZy
aW5naF9pbml0X2lvdGxiKCksIHVzZSB0aGUgbmVnb3RpYXRlZCBmZWF0dXJlcyB3aGljaAo+IG1p
Z2h0IGJlIGRpZmZlcmVudCB0aGFuIHRoZSBzdXBwb3J0ZWQgZmVhdHVyZXMuCj4KPiBGaXhlczog
MDExYzM1YmFjNWVmICgidmRwYV9zaW06IGFkZCBzdXBwb3J0ZWRfZmVhdHVyZXMgZmllbGQgaW4g
dmRwYXNpbV9kZXZfYXR0cikKCgpBcyBTdGVmYW5vIHNhaWQuCgpJdCBzaG91bGQgYmUgMmM1M2Qw
ZjY0YzA2ZiAoInZkcGFzaW06IHZEUEEgZGV2aWNlIHNpbXVsYXRvciIpCgpPdGhlciB0aGFuIHRo
aXMKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gU2lnbmVk
LW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4g
aW5kZXggMTRlMDI0ZGU1Y2JmLi44OWE0NzRjN2EwOTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW0uYwo+IEBAIC02Niw3ICs2Niw3IEBAIHN0YXRpYyB2b2lkIHZkcGFzaW1fcXVldWVfcmVh
ZHkoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHVuc2lnbmVkIGludCBpZHgpCj4gICB7Cj4gICAJ
c3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICp2cSA9ICZ2ZHBhc2ltLT52cXNbaWR4XTsKPiAgIAo+
IC0JdnJpbmdoX2luaXRfaW90bGIoJnZxLT52cmluZywgdmRwYXNpbS0+ZGV2X2F0dHIuc3VwcG9y
dGVkX2ZlYXR1cmVzLAo+ICsJdnJpbmdoX2luaXRfaW90bGIoJnZxLT52cmluZywgdmRwYXNpbS0+
ZmVhdHVyZXMsCj4gICAJCQkgIFZEUEFTSU1fUVVFVUVfTUFYLCBmYWxzZSwKPiAgIAkJCSAgKHN0
cnVjdCB2cmluZ19kZXNjICopKHVpbnRwdHJfdCl2cS0+ZGVzY19hZGRyLAo+ICAgCQkJICAoc3Ry
dWN0IHZyaW5nX2F2YWlsICopCj4gQEAgLTg2LDcgKzg2LDcgQEAgc3RhdGljIHZvaWQgdmRwYXNp
bV92cV9yZXNldChzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwKPiAgIAl2cS0+ZGV2aWNlX2FkZHIg
PSAwOwo+ICAgCXZxLT5jYiA9IE5VTEw7Cj4gICAJdnEtPnByaXZhdGUgPSBOVUxMOwo+IC0JdnJp
bmdoX2luaXRfaW90bGIoJnZxLT52cmluZywgdmRwYXNpbS0+ZGV2X2F0dHIuc3VwcG9ydGVkX2Zl
YXR1cmVzLAo+ICsJdnJpbmdoX2luaXRfaW90bGIoJnZxLT52cmluZywgdmRwYXNpbS0+ZmVhdHVy
ZXMsCj4gICAJCQkgIFZEUEFTSU1fUVVFVUVfTUFYLCBmYWxzZSwgTlVMTCwgTlVMTCwgTlVMTCk7
Cj4gICAKPiAgIAl2cS0+dnJpbmcubm90aWZ5ID0gTlVMTDsKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
