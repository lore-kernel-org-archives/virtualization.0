Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDDDCCA480
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 05:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2972B42347;
	Wed, 13 Jul 2022 05:44:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2972B42347
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hkdff2nh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VivUOfTbtwk3; Wed, 13 Jul 2022 05:44:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7176A42332;
	Wed, 13 Jul 2022 05:44:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7176A42332
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4297EC0033;
	Wed, 13 Jul 2022 05:44:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0133C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9534041146
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9534041146
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hkdff2nh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1F5EuP040Lmq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFE094010D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFE094010D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657691045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sogOu0Je2hI8kCeSkB7cNWVEmJuAsjifkkQViIo6h78=;
 b=Hkdff2nhxkQuspkLDu/hQZVJS9s6oRJvPAnwU3sWB+jAkkLMotW7OjmQAk/k6PxBFsh+pK
 2f2SJF39rB1+1x9vvv8hLBcSTLL+7CCqTiQuyJveoK5O1iwSyR0YvifWPM8AuLYyL5Fsob
 JlTyXm26LH2+45ZmDhr/6sZeEir1SGw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-J-mQTqWJPammz15fyp6dZg-1; Wed, 13 Jul 2022 01:44:02 -0400
X-MC-Unique: J-mQTqWJPammz15fyp6dZg-1
Received: by mail-pg1-f199.google.com with SMTP id
 e4-20020a631e04000000b004128f83af17so4490451pge.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 22:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sogOu0Je2hI8kCeSkB7cNWVEmJuAsjifkkQViIo6h78=;
 b=6zsFu07n4/r4kUjTb4X5Q4iaYDOYIyDp/N2AMYkX10QqOOitfTybtQyTbCLq7KFaUK
 D00578Nr+25l6Wsb5yGh8e7b7cdxdlfYkcjgXlXLm3n/Cl0g77Zy90kL7xjgsu6Eg/9w
 OL/Twn9aDgpdUFqqInXzcxRessItFeQIL5W9LdMkD7NmBLx4P4R1D++eAz4BdUKAUYu8
 HbetBbVLF8EBokQOlY++kYSqbFZ7Gsd8MNYrNa8WNCBZNwuhyQM6egfTGHSMdMz2RZxL
 GHUrcb+Fzu7BUS/g0NsJW8l0jkH5ZIJZuTuGm137IkRWL7iKzMmBSpCJKott93zvDlFx
 Sxaw==
X-Gm-Message-State: AJIora/zQ641zPcmX/BUa3ChK/7Waj3uYjB/oymVVafSaWXRWBqecVmf
 mtdjT9k7tIdlEJDFydDSFweakqBTLGv7lPjDh18rWP76APTceSC4UrLyAQefI2DyXcAy0Dk/WjA
 wKOHs4JypB7EdRhxnR4J3FKFjMOETURyU7WJ13nizDA==
X-Received: by 2002:a05:6a00:c95:b0:52b:e4c:19d5 with SMTP id
 a21-20020a056a000c9500b0052b0e4c19d5mr575689pfv.50.1657691041131; 
 Tue, 12 Jul 2022 22:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syH+1nFx4fKmmG1nejbbinYoF6wkNNQaFi8/VZ2oi6PeG4TpUQIBxAubV7u0BXIAuFc5S89Q==
X-Received: by 2002:a05:6a00:c95:b0:52b:e4c:19d5 with SMTP id
 a21-20020a056a000c9500b0052b0e4c19d5mr575672pfv.50.1657691040884; 
 Tue, 12 Jul 2022 22:44:00 -0700 (PDT)
Received: from [10.72.12.200] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 b21-20020aa79515000000b0052ac5e304ccsm6121714pfp.194.2022.07.12.22.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 22:44:00 -0700 (PDT)
Message-ID: <1106133f-ebd4-f6a8-83ab-19e995bcdba6@redhat.com>
Date: Wed, 13 Jul 2022 13:43:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 xiaodong.liu@intel.com, maxime.coquelin@redhat.com, stefanha@redhat.com
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220706050503.171-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 songmuchun@bytedance.com
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

CuWcqCAyMDIyLzcvNiAxMzowNCwgWGllIFlvbmdqaSDlhpnpgZM6Cj4gVGFraW5nIGlvdGxiIGxv
Y2sgdG8gYWNjZXNzIGJvdW5jZSBwYWdlIGluIHBhZ2UgZmF1bHQKPiBoYW5kbGVyIGlzIG1lYW5p
bmdsZXNzIHNpbmNlIHZkdXNlX2RvbWFpbl9mcmVlX2JvdW5jZV9wYWdlcygpCj4gd291bGQgb25s
eSBiZSBjYWxsZWQgZHVyaW5nIGZpbGUgcmVsZWFzZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZ
b25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3Zk
cGFfdXNlci9pb3ZhX2RvbWFpbi5jIHwgNyArKy0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS92ZHBhX3VzZXIvaW92YV9kb21haW4uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvaW92YV9k
b21haW4uYwo+IGluZGV4IDZkYWEzOTc4ZDI5MC4uYmNhMWYwYjg4NTBjIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvaW92YV9kb21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS92ZHBhX3VzZXIvaW92YV9kb21haW4uYwo+IEBAIC0yMTEsMTcgKzIxMSwxNCBAQCBzdGF0aWMg
c3RydWN0IHBhZ2UgKgo+ICAgdmR1c2VfZG9tYWluX2dldF9ib3VuY2VfcGFnZShzdHJ1Y3QgdmR1
c2VfaW92YV9kb21haW4gKmRvbWFpbiwgdTY0IGlvdmEpCj4gICB7Cj4gICAJc3RydWN0IHZkdXNl
X2JvdW5jZV9tYXAgKm1hcDsKPiAtCXN0cnVjdCBwYWdlICpwYWdlID0gTlVMTDsKPiArCXN0cnVj
dCBwYWdlICpwYWdlOwo+ICAgCj4gLQlzcGluX2xvY2soJmRvbWFpbi0+aW90bGJfbG9jayk7Cj4g
ICAJbWFwID0gJmRvbWFpbi0+Ym91bmNlX21hcHNbaW92YSA+PiBQQUdFX1NISUZUXTsKPiAgIAlp
ZiAoIW1hcC0+Ym91bmNlX3BhZ2UpCj4gLQkJZ290byBvdXQ7Cj4gKwkJcmV0dXJuIE5VTEw7CgoK
SW50ZXJlc3RpbmcsIEkgd29uZGVyIHdoeSB3ZSBkb24ndCBzZXJpYWxpemUgd2l0aCAKdmR1c2Vf
ZG9tYWluX21hcF9ib3VuY2VfcGFnZSgpIHdpdGggaW90bGJfbG9jaz8KClRoYW5rcwoKCj4gICAK
PiAgIAlwYWdlID0gbWFwLT5ib3VuY2VfcGFnZTsKPiAgIAlnZXRfcGFnZShwYWdlKTsKPiAtb3V0
Ogo+IC0Jc3Bpbl91bmxvY2soJmRvbWFpbi0+aW90bGJfbG9jayk7Cj4gICAKPiAgIAlyZXR1cm4g
cGFnZTsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
