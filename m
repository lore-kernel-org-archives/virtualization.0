Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D60C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 05:06:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DF5604D7
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 05:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1DF5604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55491404B5;
	Tue, 17 Aug 2021 05:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FDZQTuFcGWi5; Tue, 17 Aug 2021 05:06:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F237404B3;
	Tue, 17 Aug 2021 05:06:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB2FC001A;
	Tue, 17 Aug 2021 05:06:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F19CFC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC0A483673
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:06:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKB7PoqFVJfC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:06:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A87D783670
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 05:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629176788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/OoGVTR7ymdCHb2EKtYPbd5TfitDvcXS0Vhd4dGzSM=;
 b=Qe/wD5lBmDGMOKw9BX+8baaDZG8mY3RtEalR++OaFn0EckLU4NR50UE2Hn5w8LLacFVrra
 s+ZG3s3cQihQI8DNkUKZIK9yY8v55cZ6ieTIz3v1yjmMSjHoFxoRuy9xkfLlz7eupjh55q
 yilUXIUkSCVqzrouWOtcBLONp0dcSIY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-MeuCcuKAPKeEp2UHSMxDEg-1; Tue, 17 Aug 2021 01:06:25 -0400
X-MC-Unique: MeuCcuKAPKeEp2UHSMxDEg-1
Received: by mail-pj1-f70.google.com with SMTP id
 d35-20020a17090a6f26b0290178ab46154dso14370552pjk.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 22:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=k/OoGVTR7ymdCHb2EKtYPbd5TfitDvcXS0Vhd4dGzSM=;
 b=Iqv4UpArNgGeTheIsMsZlLF8NmNyPNxXZQFwp7KTY2GzGwrljMTmOBXLPIf1UNWcLv
 3DcP7KtLsRqdnEPxueekS4tzgszlTh2OZF241hOrFuAa5VDvPU4PjaK+AN5kbV5YYUCI
 VcXgyoEJypOOEIrr1pAC6SpE9hxt4L5RMi1wg4Icjm9+1GRf1oORJ4Uxww+CUY8M1rSr
 +Bqy/eNMZPNjXjXujNjUdajS/GbGByvmBb/xAa8r0Z5Vsd1NbfH7jk9rSNSV9GFCy9D9
 4dU4m3H3TqVtqtOxMYiHDmQkuoUhzILojU++99lYbUOXroyK5vdWVWbbZKSVKj9xTU/n
 5zbQ==
X-Gm-Message-State: AOAM530Pw/9n7z6OJiHcTprx8dBbKxC/EQ3/CYF3RG1txwRrsb/vsA7y
 9dlzB9v537esPEMzRZpxpvRHL6CFssE07iKlNcWUL8DhwDExotan4PYjynZucKltR+6vQolLHmh
 RAQmbny0wi34WTQBpIgla2ybcJ/wpdTL7h1dwZKjpaw==
X-Received: by 2002:a17:90a:9411:: with SMTP id
 r17mr1649610pjo.49.1629176784015; 
 Mon, 16 Aug 2021 22:06:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytPS/fwxvAyj8noMAZTjO0aIt10FWB1L90TMhfXAUgtwGqNDmAKWLXConsomtKBLLX7uhxfA==
X-Received: by 2002:a17:90a:9411:: with SMTP id
 r17mr1649588pjo.49.1629176783793; 
 Mon, 16 Aug 2021 22:06:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g202sm882368pfb.125.2021.08.16.22.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 22:06:23 -0700 (PDT)
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
 <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
Message-ID: <607ee628-4b64-e5e5-7dfc-bf06f4e873c0@redhat.com>
Date: Tue, 17 Aug 2021 13:06:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIxLzgvMTcg5LiK5Y2IMTE6NTUsIEphc29uIFdhbmcg5YaZ6YGTOgo+Pj4+PiBJIHRo
aW5rIHRoYXQgY291bGQgd29yay4gSSB3aWxsIGNvZGUgdGhpcyBhbmQgdXBkYXRlLgo+Pj4gSXQg
d29ya3MgZmluZSB3aGVuIEkgYW0gd29ya2luZyB3aXRoIHlvdXIgdmVyc2lvbiBvZiBxZW11IHdp
dGggc3VwcG9ydAo+Pj4gZm9yIG11bHRpIHF1ZXVlLgo+Pj4KPj4+IFRoZSBwcm9ibGVtIGlzIHRo
YXQgaXQgaXMgYnJva2VuIG9uIHFlbXUgdjYuMC4wLiBJZiBJIHJlZ2lzdGVyIG15IHZkcGEKPj4+
IGRldmljZSB3aXRoIG1vcmUgdGhhbiAyIGRhdGEgdmlydHF1ZXVlcywgcWVtdSB3b24ndCBldmVu
IGNyZWF0ZSBhCj4+PiBuZXRkZXZpY2UgaW4gdGhlIFZNLgo+IFFlbXUgc2hvdWxkIGhpZGUgTVEg
ZmVhdHVyZSBpbiB0aGlzIGNhc2UgYnV0IGxvb2tzIGxpa2UgaXQgZG9lc24ndC4KPgo+IFdpbGwg
aGF2ZSBhIGxvb2suCgoKU28gaXQgbG9va3MgdG8gbWUgY3VycmVudCBRZW11IGNvZGUgZG9lc24n
dCB0YWtlIGNhcmUgYWJvdXQgdGhlIGNhc2UgCndoZW4gYSBmZWF0dXJlIChlLmcgTVEpOgoKMSkg
c3VwcG9ydGVkIGJ5IHRoZSB2aG9zdAoyKSBlbmFibGVkIHZpYSB0aGUgY29tbWFuZCBsaW5lCjMp
IGJ1dCBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBRZW11CgpOb3Qgc3VyZSBpdCdzIHdvcnRoIHRvIGJv
dGhlci4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
