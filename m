Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B4C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 04:37:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438F660F11
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 04:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 438F660F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06370407CC;
	Wed, 13 Oct 2021 04:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TAHzV__AAUtk; Wed, 13 Oct 2021 04:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B11C2407D2;
	Wed, 13 Oct 2021 04:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB42C000F;
	Wed, 13 Oct 2021 04:37:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D62BC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C66B8299E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nl315ZDkM5wU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:36:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1404182983
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634099815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvUhcTTQ2pxsY3jW1PKSwCOFp6YIbWxJGDsBgyWUDwA=;
 b=TQLxx2yHgpwPf4/BpNnX4srulS/Ri0BQOJObDV/sCbA0MmF/157117KOBKWtfof6uIOD8z
 XJ+VX9ZI/hocpSDuV3SVrqNCPdBWVqiMUwe4DDNWZrmUUeR56LB/vn3Bj5ivzau9wov20Z
 Vee2lKb/jtSHs8u5YbXZIPPVW3lg84E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-EoO5aVjLMcOBT9CkYpYalA-1; Wed, 13 Oct 2021 00:36:52 -0400
X-MC-Unique: EoO5aVjLMcOBT9CkYpYalA-1
Received: by mail-pf1-f199.google.com with SMTP id
 f9-20020a056a001ac900b0044c4f04a6b1so828071pfv.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SvUhcTTQ2pxsY3jW1PKSwCOFp6YIbWxJGDsBgyWUDwA=;
 b=5iuzLgH8I5T4dBfEITnfm+tN1k0y5IvnTWFUecCVgDzTs7yltVhCg6zkvqH37Hz7xi
 /7RlnXaX/c0yZFipAZE0vIGN1fLfbDH6CFX0fQKRF3h0gLkh8f1baVj5LPHFqbMW6JzG
 +QHFZzyvj4S5rpmn/JFUqFyMqXMGwGC5Uc02+bp3piE6GEyfw82BeduIVb3eKru83EXa
 kjvcjbEnzGoezMUKsdxjVrP/XEBFsO/bdANcJ9QzCNPLeOIzHnUvnFSMrth5X3k0KWrr
 8Oity6TbOWT01fV/uTf1aAPq3Mx0dbsAkJ8MfrsakvEvSXdlmjm3pfKQZ0h2tL0Js8uW
 bHhA==
X-Gm-Message-State: AOAM533ANeFeo+ysHrDZxS/mU2SHz2K7ngTz14e416EqNLYj9ZOiK3Lt
 harMSi1rP+aBebCYk0e8zzJGTxf6/9mW/kWOgfkI0/B4pzlLh+qCOA/RO1pDwLcby4HAAjwmqPR
 29JN1vX+r9d2G3VO85Ibp6q4/jZP8TDgkgsKShocbHA==
X-Received: by 2002:a17:90a:e7cc:: with SMTP id
 kb12mr10884079pjb.182.1634099811692; 
 Tue, 12 Oct 2021 21:36:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKK75ijthkI1cwqd+QXDZEh29wqU5QfrYGfWA3cVQJ5a2kMcOmuTfCoXY0vbHeqpLY0EI3BQ==
X-Received: by 2002:a17:90a:e7cc:: with SMTP id
 kb12mr10884052pjb.182.1634099811466; 
 Tue, 12 Oct 2021 21:36:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w2sm12742496pfq.207.2021.10.12.21.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 21:36:51 -0700 (PDT)
Subject: Re: [RFC PATCH v4 17/20] vhost: Use VRING_AVAIL_F_NO_INTERRUPT at
 device call on shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-18-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6ae86e3f-a922-3576-a73a-a6c80ac7dd3f@redhat.com>
Date: Wed, 13 Oct 2021 12:36:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-18-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNpZ25l
ZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgoKCkNvbW1pdCBs
b2cgcGxlYXNlLgoKVGhhbmtzCgoKPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmly
dGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmMKPiBpbmRleCA3NzVmOGQzNmEwLi4yZmQwYmFiNzVkIDEwMDY0NAo+IC0tLSBhL2h3
L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTYwLDYgKzYwLDkgQEAgdHlwZWRlZiBzdHJ1Y3QgVmhv
c3RTaGFkb3dWaXJ0cXVldWUgewo+ICAgCj4gICAgICAgLyogTmV4dCBoZWFkIHRvIGNvbnN1bWUg
ZnJvbSBkZXZpY2UgKi8KPiAgICAgICB1aW50MTZfdCB1c2VkX2lkeDsKPiArCj4gKyAgICAvKiBD
YWNoZSBmb3IgdGhlIGV4cG9zZWQgbm90aWZpY2F0aW9uIGZsYWcgKi8KPiArICAgIGJvb2wgbm90
aWZpY2F0aW9uOwo+ICAgfSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZTsKPiAgIAo+ICAgLyogSWYgdGhl
IGRldmljZSBpcyB1c2luZyBzb21lIG9mIHRoZXNlLCBTVlEgY2Fubm90IGNvbW11bmljYXRlICov
Cj4gQEAgLTEwNSw2ICsxMDgsMjQgQEAgYm9vbCB2aG9zdF9zdnFfdmFsaWRfZGV2aWNlX2ZlYXR1
cmVzKHVpbnQ2NF90ICpkZXZfZmVhdHVyZXMpCj4gICAgICAgcmV0dXJuIHI7Cj4gICB9Cj4gICAK
PiArc3RhdGljIHZvaWQgdmhvc3Rfc3ZxX3NldF9ub3RpZmljYXRpb24oVmhvc3RTaGFkb3dWaXJ0
cXVldWUgKnN2cSwgYm9vbCBlbmFibGUpCj4gK3sKPiArICAgIHVpbnQxNl90IG5vdGlmaWNhdGlv
bl9mbGFnOwo+ICsKPiArICAgIGlmIChzdnEtPm5vdGlmaWNhdGlvbiA9PSBlbmFibGUpIHsKPiAr
ICAgICAgICByZXR1cm47Cj4gKyAgICB9Cj4gKwo+ICsgICAgbm90aWZpY2F0aW9uX2ZsYWcgPSBj
cHVfdG9fbGUxNihWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCk7Cj4gKwo+ICsgICAgc3ZxLT5u
b3RpZmljYXRpb24gPSBlbmFibGU7Cj4gKyAgICBpZiAoZW5hYmxlKSB7Cj4gKyAgICAgICAgc3Zx
LT52cmluZy5hdmFpbC0+ZmxhZ3MgJj0gfm5vdGlmaWNhdGlvbl9mbGFnOwo+ICsgICAgfSBlbHNl
IHsKPiArICAgICAgICBzdnEtPnZyaW5nLmF2YWlsLT5mbGFncyB8PSBub3RpZmljYXRpb25fZmxh
ZzsKPiArICAgIH0KPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkIHZob3N0X3ZyaW5nX3dyaXRlX2Rl
c2NzKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaW92ZWMgKmlvdmVjLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IG51bSwgYm9vbCBtb3JlX2Rlc2NzLCBib29s
IHdyaXRlKQo+IEBAIC0yNzMsNyArMjk0LDcgQEAgc3RhdGljIHZvaWQgdmhvc3Rfc3ZxX2hhbmRs
ZV9jYWxsX25vX3Rlc3QoRXZlbnROb3RpZmllciAqbikKPiAgICAgICBkbyB7Cj4gICAgICAgICAg
IHVuc2lnbmVkIGkgPSAwOwo+ICAgCj4gLSAgICAgICAgLyogVE9ETzogVXNlIFZSSU5HX0FWQUlM
X0ZfTk9fSU5URVJSVVBUICovCj4gKyAgICAgICAgdmhvc3Rfc3ZxX3NldF9ub3RpZmljYXRpb24o
c3ZxLCBmYWxzZSk7Cj4gICAgICAgICAgIHdoaWxlICh0cnVlKSB7Cj4gICAgICAgICAgICAgICBn
X2F1dG9mcmVlIFZpcnRRdWV1ZUVsZW1lbnQgKmVsZW0gPSB2aG9zdF9zdnFfZ2V0X2J1ZihzdnEp
Owo+ICAgICAgICAgICAgICAgaWYgKCFlbGVtKSB7Cj4gQEAgLTI4Niw2ICszMDcsNyBAQCBzdGF0
aWMgdm9pZCB2aG9zdF9zdnFfaGFuZGxlX2NhbGxfbm9fdGVzdChFdmVudE5vdGlmaWVyICpuKQo+
ICAgCj4gICAgICAgICAgIHZpcnRxdWV1ZV9mbHVzaCh2cSwgaSk7Cj4gICAgICAgICAgIGV2ZW50
X25vdGlmaWVyX3NldCgmc3ZxLT5ndWVzdF9jYWxsX25vdGlmaWVyKTsKPiArICAgICAgICB2aG9z
dF9zdnFfc2V0X25vdGlmaWNhdGlvbihzdnEsIHRydWUpOwo+ICAgICAgIH0gd2hpbGUgKHZob3N0
X3N2cV9tb3JlX3VzZWQoc3ZxKSk7Cj4gICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
