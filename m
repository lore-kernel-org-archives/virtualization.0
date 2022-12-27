Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F1C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 09:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6330F4032F;
	Tue, 27 Dec 2022 09:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6330F4032F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=daeMOgAQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CD-n6Y-ZyUZN; Tue, 27 Dec 2022 09:06:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EE3A40275;
	Tue, 27 Dec 2022 09:06:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EE3A40275
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58153C0032;
	Tue, 27 Dec 2022 09:06:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D48AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE7EC60BD6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:06:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE7EC60BD6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=daeMOgAQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwLZXtfgqktn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:06:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0790C60BCE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0790C60BCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672131979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nz1SnC0gAVnfhR/QDRjT/YSO9ZI+vbqwUHzyKwphYUc=;
 b=daeMOgAQ0VWoX6nB4kcpGAq4OYMxFmR+pzacQhU8Jqm4ForPsBUYoo8ct5aUFcxH8SddC2
 zEmN1kOWf46UoOY8gSPi6mXn0+sTCQKQSIp/rMvsjAvSZuR++0MHJzhO54v5WXn5jNFMzT
 2FPtU8Oq5q3vRhnQXyiP4A+172FeWlo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-YOcKHC1fOI6_uq6I9TYY6g-1; Tue, 27 Dec 2022 04:06:17 -0500
X-MC-Unique: YOcKHC1fOI6_uq6I9TYY6g-1
Received: by mail-pg1-f198.google.com with SMTP id
 r126-20020a632b84000000b004393806c06eso6464534pgr.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 01:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nz1SnC0gAVnfhR/QDRjT/YSO9ZI+vbqwUHzyKwphYUc=;
 b=z6fgq7fYPCueWCN63JECb0/UYvJYKYIOq+nd06c/IcIF3FkUH0X0pkCMJbf92rXuML
 h1kmpfrtKhS7cSKosUnDUBGJB4h7N2DfdXMpu34HYtdt5Hn8CiEdrXrYvLFuMjndui7F
 nTYaSxo/N32bsfCLPSnJE5+J7b4TtJs+hnjLDbu6eg7cr860a3uAVsA/uCOKCcMq5HK6
 Xq6UNJu3jeRBAmjQbZGcFmmvuJBzAdDxVynLXXFRIaZEqu2LP7W1o14f2uH4/YbBLfbL
 hIAXeely6cuZ8gJuAwuO3hVYMj15POfhe6JAjcVLpWlE6kOpHaAynFzIUIo1QHCx0IX2
 WHSA==
X-Gm-Message-State: AFqh2kpWLrOvJqgRVjWnWs4o3SyIGZ85pZObNVGvlkQaA5R+3kZFzmB9
 D23mF5WtyYow5yCpfx+36idf3Ievv14Pa37Dz0PqlnHEBYRIV2TFs3VY+I08vSKtCCavub5Rl6l
 tP7VCpNZrxw1wLe5A6E43PI4mQbdZNND8ztQ7H6ht9w==
X-Received: by 2002:a17:90a:4744:b0:21a:fd7:210d with SMTP id
 y4-20020a17090a474400b0021a0fd7210dmr23290673pjg.2.1672131976947; 
 Tue, 27 Dec 2022 01:06:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu93UpcjkbltIaP0U0Rt09nzSfJefeq48CvQOBnDYBKMyh1vT3OdwcM5vSFTtb3thaw2XTprg==
X-Received: by 2002:a17:90a:4744:b0:21a:fd7:210d with SMTP id
 y4-20020a17090a474400b0021a0fd7210dmr23290648pjg.2.1672131976643; 
 Tue, 27 Dec 2022 01:06:16 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 o61-20020a17090a0a4300b00225ffb9c43dsm2168531pjo.5.2022.12.27.01.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Dec 2022 01:06:16 -0800 (PST)
Message-ID: <6026e801-6fda-fee9-a69b-d06a80368621@redhat.com>
Date: Tue, 27 Dec 2022 17:06:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] virtio-net: convert rx mode setting to use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-2-jasowang@redhat.com>
 <20221227023447-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227023447-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

CuWcqCAyMDIyLzEyLzI3IDE1OjM5LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9uIE1v
biwgRGVjIDI2LCAyMDIyIGF0IDAzOjQ5OjA1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IEBAIC0yMjI3LDkgKzIyNjcsMjEgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhfbW9kZShz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+PiAgIAkJCQkgIFZJUlRJT19ORVRfQ1RSTF9NQUNfVEFC
TEVfU0VULCBzZykpCj4+ICAgCQlkZXZfd2FybigmZGV2LT5kZXYsICJGYWlsZWQgdG8gc2V0IE1B
QyBmaWx0ZXIgdGFibGUuXG4iKTsKPj4gICAKPj4gKwlydG5sX3VubG9jaygpOwo+PiArCj4+ICAg
CWtmcmVlKGJ1Zik7Cj4+ICAgfQo+PiAgIAo+PiArc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhf
bW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+PiArewo+PiArCXN0cnVjdCB2aXJ0bmV0X2lu
Zm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPj4gKwo+PiArCXNwaW5fbG9jaygmdmktPnJ4X21v
ZGVfbG9jayk7Cj4+ICsJaWYgKHZpLT5yeF9tb2RlX3dvcmtfZW5hYmxlZCkKPj4gKwkJc2NoZWR1
bGVfd29yaygmdmktPnJ4X21vZGVfd29yayk7Cj4+ICsJc3Bpbl91bmxvY2soJnZpLT5yeF9tb2Rl
X2xvY2spOwo+PiArfQo+PiArCj4+ICAgc3RhdGljIGludCB2aXJ0bmV0X3ZsYW5fcnhfYWRkX3Zp
ZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+PiAgIAkJCQkgICBfX2JlMTYgcHJvdG8sIHUxNiB2
aWQpCj4+ICAgewo+IEhtbSBzbyB1c2VyIHRlbGxzIHVzIHRvIGUuZyBlbmFibGUgcHJvbWlzYy4g
V2UgcmVwb3J0IGNvbXBsZXRpb24KPiBidXQgY2FyZCBpcyBzdGlsbCBkcm9wcGluZyBwYWNrZXRz
LiBJIHRoaW5rIHRoaXMKPiBoYXMgYSBjaGFuY2UgdG8gYnJlYWsgc29tZSBzZXR1cHMuCgoKSSB0
aGluayBhbGwgdGhvc2UgZmlsdGVycyBhcmUgYmVzdCBlZmZvcnRzLCBhbSBJIHdyb25nPwoKVGhh
bmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
