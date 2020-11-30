Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB02C64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:00:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CD520855
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtTJ2GeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CD520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 85A06228B3;
	Mon, 30 Nov 2020 14:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6PaISwYYigY; Mon, 30 Nov 2020 14:00:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4D69E22882;
	Mon, 30 Nov 2020 14:00:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02059C0859;
	Mon, 30 Nov 2020 14:00:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30151C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1D77886D11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8sjCYLx-K8I
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:00:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 65E8E86D09
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606744825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1V5TP+t4YgIIKSdanYDtXXCORZzAdrzBJD0xz3ZJJ4=;
 b=BtTJ2GeUg1hNT1lLWUN3td5pRoyAcxdn/VKPNRm4CQ0ApS1M5ACzBvuqdquk0fPunklBk5
 FODdiP1rJLGNz781Fq7jmsfOPtZ3GX+hFUusRauUSJ0WZN95+ceZ61YRFSSmsaWrOBVsIp
 FJVjyLaoXdcrzqvZrDsG9nT6GI8AK0c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-reiO_keDNqOTMKjXx_pR1A-1; Mon, 30 Nov 2020 09:00:18 -0500
X-MC-Unique: reiO_keDNqOTMKjXx_pR1A-1
Received: by mail-ej1-f72.google.com with SMTP id t17so2859869ejd.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 06:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z1V5TP+t4YgIIKSdanYDtXXCORZzAdrzBJD0xz3ZJJ4=;
 b=Mkw7IfgAx6eMZL5lNtqrkQ3wVvbH2QXpOZ3kUwxmm+VuYsxtDHHr7ktyA2xRZPKmVK
 UXvJz8DeXORuAYQPPWCIsjLMMHkyGwW+UHsZZqMk+G3R6gTSGQXzIR8/pS0X42vF/G6K
 7KsjSe5sMugAXb//OCzT8siKuPjkUpZ2XR5LievUUf+ChLFJEDFb11mLft6xo+YmgXMO
 G8Vf7gPbPApKC+zuCldS9vWK0qPMp6jPIoFA4B1rlYYXR92KOG3RvpPLQN5IsVZl7Lu7
 S78FwwLXN8bY+ex/sfIWUbB4WG+fxWZ8vqjO1wROad3JChu1ts6I9zuXtfila0DGCVZT
 FZhQ==
X-Gm-Message-State: AOAM530vINjlbt3ej8I7cLbefoDzUIsfFnwXH7V3cXFeda2jnYHwDkGn
 6Rteqg5tvgKtk45XPObGBoJMn34exltZNPKJPsf873ll5SB24e+D8RqJa3WGNIgplPKJ3WW5qot
 WDehYDXIeMAQDWvwV6pTyHQeSmnGhcBWnL3C3R5N1IQ==
X-Received: by 2002:a17:906:e093:: with SMTP id
 gh19mr16467520ejb.510.1606744816011; 
 Mon, 30 Nov 2020 06:00:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPMhCAxuB2B/TcTZz4LyxRjBTd2O6WcbKZeK0qo3nFya2kmMSturj18lyD86gg2TrlnvR3iQ==
X-Received: by 2002:a17:906:e093:: with SMTP id
 gh19mr16467362ejb.510.1606744815303; 
 Mon, 30 Nov 2020 06:00:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id f25sm8943114edr.53.2020.11.30.06.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Nov 2020 06:00:14 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Greg KH <gregkh@linuxfoundation.org>
References: <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <X8TzeoIlR3G5awC6@kroah.com>
 <17481d8c-c19d-69e3-653d-63a9efec2591@redhat.com>
 <X8T6RWHOhgxW3tRK@kroah.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8809319f-7c5b-1e85-f77c-bbc3f22951e4@redhat.com>
Date: Mon, 30 Nov 2020 15:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8T6RWHOhgxW3tRK@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 30/11/20 14:57, Greg KH wrote:
>> Every patch should be "fixing a real issue"---even a new feature.  But the
>> larger the patch, the more the submitters and maintainers should be trusted
>> rather than a bot.  The line between feature and bugfix_sometimes_  is
>> blurry, I would say that in this case it's not, and it makes me question how
>> the bot decided that this patch would be acceptable for stable (which AFAIK
>> is not something that can be answered).
> I thought that earlier Sasha said that this patch was needed as a
> prerequisite patch for a later fix, right?  If not, sorry, I've lost the
> train of thought in this thread...

Yeah---sorry I am replying to 22/33 but referring to 23/33, which is the 
one that in my opinion should not be blindly accepted for stable kernels 
without the agreement of the submitter or maintainer.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
