Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E5EECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 20:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D94D940195;
	Fri, 16 Sep 2022 20:01:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D94D940195
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvUT834pmYAq; Fri, 16 Sep 2022 20:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 904EE40BCB;
	Fri, 16 Sep 2022 20:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 904EE40BCB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A4A1C0032;
	Fri, 16 Sep 2022 20:01:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B198C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 20:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D36D9843B1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 20:01:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D36D9843B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iZdXEuZBAGv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 20:01:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42C88843B0
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42C88843B0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 20:01:13 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id c24so21289226pgg.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 13:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=aI55elBM47AbpRIfEoRwcS12RWAxkruf3PuVmLaNsIw=;
 b=514koLH0R9AdzeW6uqEwaIJyO0t93nbpQEBoM55ny76RNrQj881LnFh8MYHYU2jJu4
 uXtvKwB5+EsC0KoLhPdjUwOVrqF9TE4Pum09L9caQtTSYUg/TRBdKz92NuvyYjiyPpua
 hkwpjP30/DC9MfatXbvzGtWncqcXDw5E7tzyEGb6qiHIHesIc/I393Chsq/P7RmZJGXD
 R3jdQfGT1D81gSYPPCWMvl6OwaLUrz5skTGdq71RdBfE7OzvEOPD75irWt5SwVDmpqTX
 5egop/WMCTvfff/3UNBZPyphxdqkoWF+Qu+ShxY+GV+Qc2rs8UggvBFwnV+3R921ie+j
 hEkQ==
X-Gm-Message-State: ACrzQf253L/xyrdDYVzo7NpMGIX8ITqssq2VZ94S+HmaPj1bKW4mTp5y
 hKy8ej2n+t+1ONn6y1bn06E=
X-Google-Smtp-Source: AMsMyM7BtRpoBGm+25ZIcjQ1eDg7usENuczHgm9wgE8Sus1sUlVcptKPjg/7yVuSQ/Mc/WEtnHJpcQ==
X-Received: by 2002:a63:e452:0:b0:42c:60ce:8b78 with SMTP id
 i18-20020a63e452000000b0042c60ce8b78mr5917990pgk.453.1663358472565; 
 Fri, 16 Sep 2022 13:01:12 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e470:c0f8:8896:5368?
 ([2620:15c:211:201:e470:c0f8:8896:5368])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a170902d2ca00b00174c235e1fdsm15550309plc.199.2022.09.16.13.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Sep 2022 13:01:11 -0700 (PDT)
Message-ID: <0be0e378-1601-678c-247a-ba24d111b934@acm.org>
Date: Fri, 16 Sep 2022 13:01:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Content-Language: en-US
To: Sarthak Kukreti <sarthakkukreti@chromium.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-ext4@vger.kernel.org,
 Evan Green <evgreen@google.com>, Alasdair Kergon <agk@redhat.com>
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

On 9/16/22 11:48, Sarthak Kukreti wrote:
> Yes. On ChromiumOS, we regularly deal with storage devices that don't
> support WRITE_ZEROES or that need to have it disabled, via a quirk,
> due to a bug in the vendor's implementation. Using WRITE_ZEROES for
> allocation makes the allocation path quite slow for such devices (not
> to mention the effect on storage lifetime), so having a separate
> provisioning construct is very appealing. Even for devices that do
> support an efficient WRITE_ZEROES implementation but don't support
> logical provisioning per-se, I suppose that the allocation path might
> be a bit faster (the device driver's request queue would report
> 'max_provision_sectors'=0 and the request would be short circuited
> there) although I haven't benchmarked the difference.

Some background information about why ChromiumOS uses thin provisioning 
instead of a single filesystem across the entire storage device would be 
welcome. Although UFS devices support thin provisioning I am not aware 
of any use cases in Android that would benefit from UFS thin 
provisioning support.

Thanks,

Bart.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
