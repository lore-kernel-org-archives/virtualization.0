Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFFDC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 06:06:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F39E60724
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 06:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F39E60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0976C80D5C;
	Mon, 25 Oct 2021 06:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_iEknDhCEzF; Mon, 25 Oct 2021 06:06:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ABDDA80D5E;
	Mon, 25 Oct 2021 06:06:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69549C0019;
	Mon, 25 Oct 2021 06:06:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CC55C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BA8B401EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iCNOIs6SjSE9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:05:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDE3240148
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635141957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrGmaSTC+++rl9WzG4E7+WQe9YwddCVMuLNLN7WUKr8=;
 b=e7K4Z6rCxNmDLibRIJQ8ueC+lAwZifvm2nzHu0b48zgDOQqECuAXo0o2gAHPQZz9G/iNwZ
 ZdvYYt69Ang+ra23bI1pWKp0mYRhhxyuhJ7VwDWS6AEOPlprAMteKMMuHZfAXhhWs2b+BC
 +Or70d9Kcb4Wu+oK+nAZQpzgSA7Xj40=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Cxxaghq5NTaNIO8OEPK2Ow-1; Mon, 25 Oct 2021 02:05:55 -0400
X-MC-Unique: Cxxaghq5NTaNIO8OEPK2Ow-1
Received: by mail-pl1-f198.google.com with SMTP id
 n9-20020a170902968900b0013f23b51142so3294315plp.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 23:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lrGmaSTC+++rl9WzG4E7+WQe9YwddCVMuLNLN7WUKr8=;
 b=CabJxFQQSYPb4kdkxqtbrRu8AbIXf+5K3t8EovHS4cWsy57/SyJCEl2XDY/ktMKPPy
 kDfuLNKdFvrPZ1PczFc4jEY1w3JTkmbse6zDX4F29yPBtECW27TQS1E8kizGPsGYFJpz
 btUhQP6Ys2AMYvP0vE+8kNniS9eBH3sUa6Y5KNAZm7UF0f4dN673sabGweZtvPTGBOW5
 Ez4yN76dPjgmJNMCnriQ8mr/GHJ1VL7cdd02gVR1hZsbcp04l1x5uFQx4nkfslgLeF9V
 8/Gd6tg6QolenAVqzQNR2Gulk8UMuFO7+NrvJBqgnqUYvsuom8MgZpDbNxvqm2snipPu
 CqFA==
X-Gm-Message-State: AOAM532OoYer7Q9W4jaM3f03LcIcTwZe+5COsLbD6Ays0/A41x67bU+d
 fga3DPj1Z1J7wdyu7ruR15x/Cs3dlLRJmHaPnjckP/Mswvb+0GoyVS4kZhpMftyc17LARc5y6+T
 PIOtrGeqSytRHTGNsRWiMpayEfid7qkGhQatoXbxS9g==
X-Received: by 2002:a05:6a00:2181:b0:44d:c18d:7af9 with SMTP id
 h1-20020a056a00218100b0044dc18d7af9mr16826428pfi.16.1635141954264; 
 Sun, 24 Oct 2021 23:05:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR8HVQeziryzi/+P9pZ5w2OlTX1JjtlOWUFEA/OrmeyQcZu9+QB53dAWsNavj14nOQ0ZbyqQ==
X-Received: by 2002:a05:6a00:2181:b0:44d:c18d:7af9 with SMTP id
 h1-20020a056a00218100b0044dc18d7af9mr16826404pfi.16.1635141954002; 
 Sun, 24 Oct 2021 23:05:54 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id qe7sm14054362pjb.1.2021.10.24.23.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Oct 2021 23:05:53 -0700 (PDT)
Subject: Re: [PATCH linux-next v4 2/8] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-3-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05bf6f39-66fc-cd9a-83d7-0836caf53239@redhat.com>
Date: Mon, 25 Oct 2021 14:05:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021163509.6978-3-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: elic@nvidia.com, mst@redhat.com
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

CtTaIDIwMjEvMTAvMjIgyc/O5zEyOjM1LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBJbnRyb2R1Y2Ug
YSBjb21tYW5kIHRvIHF1ZXJ5IGEgZGV2aWNlIGNvbmZpZyBsYXlvdXQuCj4KPiBBbiBleGFtcGxl
IHF1ZXJ5IG9mIG5ldHdvcmsgdmRwYSBkZXZpY2U6Cj4KPiAkIHZkcGEgZGV2IGFkZCBuYW1lIGJh
ciBtZ210ZGV2IHZkcGFzaW1fbmV0Cj4KPiAkIHZkcGEgZGV2IGNvbmZpZyBzaG93Cj4gYmFyOiBt
YWMgMDA6MzU6MDk6MTk6NDg6MDUgbGluayB1cCBsaW5rX2Fubm91bmNlIGZhbHNlIG10dSAxNTAw
CgoKTml0OiBpdCBsb29rcyB0byBtZSB0aGlzIHBhdGNoIGRvZXNuJ3QgZXhwb3NlIGxpbmtfYW5u
b3VuY2UgYnV0IAptYXhfdmlydHF1ZXVlX3BhaXJzLgoKT3RoZXIgbG9va3MgZ29vZC4KClRoYW5r
cwoKCj4KPiAkIHZkcGEgZGV2IGNvbmZpZyBzaG93IC1qcAo+IHsKPiAgICAgICJjb25maWciOiB7
Cj4gICAgICAgICAgImJhciI6IHsKPiAgICAgICAgICAgICAgIm1hYyI6ICIwMDozNTowOToxOTo0
ODowNSIsCj4gICAgICAgICAgICAgICJsaW5rICI6ICJ1cCIsCj4gICAgICAgICAgICAgICJsaW5r
X2Fubm91bmNlICI6IGZhbHNlLAo+ICAgICAgICAgICAgICAibXR1IjogMTUwMCwKPiAgICAgICAg
ICB9Cj4gICAgICB9Cj4gfQo+Cj4gU2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0PHBhcmF2QG52
aWRpYS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuPGVsaWNAbnZpZGlhLmNvbT4KPgo+
IC0tLQo+IGNoYW5nZWxvZzoKPiB2My0+djQ6Cj4gICAtIHJlbW92ZWQgY29uZmlnIHNwYWNlIGZp
ZWxkcyByZXBvcnRpbmcgd2hpY2ggYXJlIG5vdCB1c2VkIGJ5IG1seDUKPiAgICAgYW5kIHNpbSBk
cml2ZXJzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
