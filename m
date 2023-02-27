Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF39C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 07:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87AB260B50;
	Mon, 27 Feb 2023 07:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87AB260B50
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FcvkTrak
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id udBrN_DOuZI2; Mon, 27 Feb 2023 07:15:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0AC1960B36;
	Mon, 27 Feb 2023 07:15:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AC1960B36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C15C2C0032;
	Mon, 27 Feb 2023 07:15:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFBFEC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4724409B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4724409B3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FcvkTrak
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KurXtXBVz1Jc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:15:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83A32409AC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83A32409AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677482112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SySw8/CNyrMF5cRsCFPlxbhx3jjhT+MiUqznIwp8Ks=;
 b=FcvkTrak4QI3Dc+14XLFtRVOX9nYi2RHIGAUEcRnbq0czHEFd2/HsGT9Pugc3zb/OtYCBq
 s8Tfaghy21Dcdp0HrfwE/ObsAIh+l9yZvv96besDN6/BYIkMTYXi0FU2vIFkGrJnzULmf9
 ++OIjMk8LiSqfQP93I5ls69QE6oIveg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-Lu7Jx2T4PE6C8YjvHFYddQ-1; Mon, 27 Feb 2023 02:15:11 -0500
X-MC-Unique: Lu7Jx2T4PE6C8YjvHFYddQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 p5-20020a056a0026c500b005cbeecd5c0dso2950570pfw.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Feb 2023 23:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7SySw8/CNyrMF5cRsCFPlxbhx3jjhT+MiUqznIwp8Ks=;
 b=IikZq7zpaIh34ptLBIkBQonUSF+YAeS9pfvaE7WZGBGkHVVY1uYCK82usT4xgF94HJ
 SYzmMaMwp8mSmmWOMy6GtZyK5ODTekrpMnIgAhPVjEbuRWibOc65tGylgQ4GEtid3pmj
 1rVdVie/L6fMG9+VaJ3jK+qZVdq2Tc8dQHr17NU1hhQhnbHSG8qGMB4PKEWkdz63100f
 nOfzi6efuPHqaZ24f/j6XKlstNHFgFooVTttfSyhlTdyzC9g7B9P80Z5Uhi/rRwWPoDM
 3W5XE6TLfTHwYWwibM94nf4a93ZwsS0sz/1Qx3TvRQ6iqmp9YEx0hPwwut6cIIRlRTHV
 n9Hw==
X-Gm-Message-State: AO0yUKXK6HkGs2u8ffzNgPfJFTNnJ6b1sgpBf+Zu4/FxN2gI/QAs3V+Q
 zbl3mXl/I3K2zzG1s7bQx8eBuIdn0/MGS5jXMJBigsrGfuV1JgUd9fwMr5f3nLD9G+OhEOKXZpQ
 fKdOONDMqVwIzhJ2YJZpqltNtzDOXJOy4j4aW9KUz2A==
X-Received: by 2002:a17:902:f9cb:b0:19d:1230:438f with SMTP id
 kz11-20020a170902f9cb00b0019d1230438fmr2198483plb.37.1677482110201; 
 Sun, 26 Feb 2023 23:15:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8Hfo5s9SM/In7JklsCABMu6wxF3hzv3LjCxqeU/OgNKtbhQhlDt88eSLq3Ud5sdgi/jItAIg==
X-Received: by 2002:a17:902:f9cb:b0:19d:1230:438f with SMTP id
 kz11-20020a170902f9cb00b0019d1230438fmr2198465plb.37.1677482109936; 
 Sun, 26 Feb 2023 23:15:09 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a170902fe0c00b0019a7f493151sm3768774plj.212.2023.02.26.23.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Feb 2023 23:15:09 -0800 (PST)
Message-ID: <3c485561-b993-1f4f-8003-073c1e27bc6b@redhat.com>
Date: Mon, 27 Feb 2023 15:15:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 03/15] vdpa: stop svq at vhost_vdpa_dev_start(false)
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230224155438.112797-4-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvMjQgMjM6NTQsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiBJdCB1c2VkIHRv
IGJlIGRvbmUgYXQgdmhvc3RfdmRwYV9zdnFfY2xlYW51cCwgc2luY2UgYSBkZXZpY2UgY291bGRu
J3QKPiBzd2l0Y2ggdG8gU1ZRIG1vZGUgZHluYW1pY2FsbHkuICBOb3cgdGhhdCB3ZSBuZWVkIHRv
IGZldGNoIHRoZSBzdGF0ZSBhbmQKPiB0cnVzdCBTVlEgd2lsbCBub3QgbW9kaWZ5IGd1ZXN0J3Mg
dXNlZF9pZHggYXQgbWlncmF0aW9uLCBzdG9wCj4gZWZmZWN0aXZlbHkgU1ZRIGF0IHN1c3BlbmQg
dGltZSwgYXMgYSByZWFsIGRldmljZSB3b3VsZCBkby4KPgo+IExlYXZpbmcgb2xkIHZob3N0X3N2
cV9zdG9wIGNhbGwgYXQgdmhvc3RfdmRwYV9zdnFfY2xlYW51cCwgYXMgaXRzCj4gc3VwcG9ydGVk
IHRvIGNhbGwgaXQgbWFueSB0aW1lcyBhbmQgaXQgZm9sbG93cyBvdGhlciBvcGVyYXRpb25zIHRo
YXQgYXJlCj4gY2FsbGVkIHJlZHVuZGFudGx5IHRoZXJlIHRvbzoKPiAqIHZob3N0X3ZkcGFfaG9z
dF9ub3RpZmllcnNfdW5pbml0Cj4gKiBtZW1vcnlfbGlzdGVuZXJfdW5yZWdpc3Rlcgo+Cj4gU2ln
bmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4g
djM6IE5ldyBpbiB2Mwo+IC0tLQo+ICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDMgKystCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMK
PiBpbmRleCA0ZjcyYTUyYTQzLi5kOTI2MDE5MWNjIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92
aG9zdC12ZHBhLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAgLTExMDAsMTAg
KzExMDAsMTEgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9zdnFzX3N0b3Aoc3RydWN0IHZob3N0
X2RldiAqZGV2KQo+ICAgCj4gICAgICAgZm9yICh1bnNpZ25lZCBpID0gMDsgaSA8IHYtPnNoYWRv
d192cXMtPmxlbjsgKytpKSB7Cj4gICAgICAgICAgIFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEg
PSBnX3B0cl9hcnJheV9pbmRleCh2LT5zaGFkb3dfdnFzLCBpKTsKPiArCj4gKyAgICAgICAgdmhv
c3Rfc3ZxX3N0b3Aoc3ZxKTsKPiAgICAgICAgICAgdmhvc3RfdmRwYV9zdnFfdW5tYXBfcmluZ3Mo
ZGV2LCBzdnEpOwo+ICAgCj4gICAgICAgICAgIGV2ZW50X25vdGlmaWVyX2NsZWFudXAoJnN2cS0+
aGRldl9raWNrKTsKPiAtICAgICAgICBldmVudF9ub3RpZmllcl9jbGVhbnVwKCZzdnEtPmhkZXZf
Y2FsbCk7CgoKQW55IHJlYXNvbiB3ZSBuZWVkIHRvIG5vdCBjbGVhbiBjYWxsZmQ/IChOb3QgZXhw
bGFpbmVkIGluIHRoZSBjaGFuZ2UgCmxvZywgb3Igc2hvdWxkIGJlIGFub3RoZXIgcGF0Y2g/KS4K
ClRoYW5rcwoKCj4gICAgICAgfQo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
