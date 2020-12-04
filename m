Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA22C4361A
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 07:58:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9923222581
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 07:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9923222581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1580787BCA;
	Fri,  4 Dec 2020 07:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5LsFPdV4OTWj; Fri,  4 Dec 2020 07:58:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7EF9287BAE;
	Fri,  4 Dec 2020 07:58:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 697CCC0FA7;
	Fri,  4 Dec 2020 07:58:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE6CFC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BD37A873A1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QKggbWrzBqQT
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:58:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D39468739A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607068679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3sUPOaWynCO3O/eLMCxguMEiANw6aKWhiDzAUiGP1rs=;
 b=Pb3A/mNCSe2RZu9uNBohQpXa38PjbJuOetAW38mKPLJtvSwL4LJUFCivIPb8YglSqT47LO
 Hebxbn6isUgxSCnPyvJcTs2GnnEQpTFnQta40TkU6v7uby4+Scmb5DikZ7dW4Sq+BQ8ywJ
 ZxAlOp0US2U6gRBbxMkr86jX1pP7aUI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Mh1yizNIP_6a4BVjLFfXsg-1; Fri, 04 Dec 2020 02:57:58 -0500
X-MC-Unique: Mh1yizNIP_6a4BVjLFfXsg-1
Received: by mail-ed1-f71.google.com with SMTP id e11so1114331edn.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Dec 2020 23:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3sUPOaWynCO3O/eLMCxguMEiANw6aKWhiDzAUiGP1rs=;
 b=aXze6JJccx4dQs0+zlb93Roe9+E6hh/QnOyg6+DG76ybfHCnLdo7WGRRM29tIZgWPy
 /vHI8JvSmKuYiGv9p2YqZ9HmOQHoLSQxau4i4Cssg6dYIdeHqdosTKCfnBSyU2/K0IrX
 0ZK1NYlKAec2+6p1c1DFxL72jWCcPL0+XZkx47fsYH55HjB9h0tRC0HEw+zgubUeAjXb
 2tbtZJKXl4EVZHo4RhzGWyArFlDyDkXB9IFeA0gfVBet58m73+qbjTzpAkoHnlfnpcHd
 BUG/IcWxSoGAnIIcVY9235Oy/UoJIM5fWRN7Xgw/w0OKuckvX2E9QwyCANzH5sxeNhtN
 L1qA==
X-Gm-Message-State: AOAM530Xa4MoX/VdTQk+LiAvi1rw5Zvp8Yt4wSCoG/zYE5Yu70KEzv3+
 PKVo25YI9cu1sh5xuqyVMr/PTi5/r7gX2qIoA7Xe45hZzHpHIvgTXzBwpllZynlxhRQF9j9VMYD
 wGERVIPvp1j0O4UNx6tc3HBS3VepWU0TOSDGirFMzww==
X-Received: by 2002:a17:906:770d:: with SMTP id
 q13mr5749770ejm.409.1607068677145; 
 Thu, 03 Dec 2020 23:57:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9ydI+gk0GU597+caEbXF5t7mw+FzxHkXerBBLJn8KhsajbxWOv0eqvKpNN41S0NFeDV0DoA==
X-Received: by 2002:a17:906:770d:: with SMTP id
 q13mr5749761ejm.409.1607068676971; 
 Thu, 03 Dec 2020 23:57:56 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id x16sm2504133ejo.104.2020.12.03.23.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Dec 2020 23:57:56 -0800 (PST)
Date: Fri, 4 Dec 2020 08:57:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 02/19] vdpa_sim: remove unnecessary headers inclusion
Message-ID: <20201204075753.et4zauuc5w7aj2cn@steredhat>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-3-sgarzare@redhat.com>
 <7e55ab39-afdd-f47b-55ec-a2bec4ab4cec@infradead.org>
MIME-Version: 1.0
In-Reply-To: <7e55ab39-afdd-f47b-55ec-a2bec4ab4cec@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Shahaf Shuler <shahafs@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>,
 Oren Duer <oren@nvidia.com>
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

Hi Randy,

On Thu, Dec 03, 2020 at 09:37:48AM -0800, Randy Dunlap wrote:
>On 12/3/20 9:04 AM, Stefano Garzarella wrote:
>> Some headers are not necessary, so let's remove them to do
>> some cleaning.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Hi,
>What makes you say that some of these are unnecessary?
>
>Please use Rule #1 from Documentation/process/submit-checklist.rst:
>
>1) If you use a facility then #include the file that defines/declares
>   that facility.  Don't depend on other header files pulling in ones
>   that you use.
>
>
>so just because it will compile without these headers being explictly
>#included does not mean that you should remove them.

Thanks for the clarification. I tried to follow this rule already 
pointed out by Jason, but of course I missed the __init and __exit 
macros...

I'll check better for the next version!

>
>
>> ---
>> v3:
>> - avoided to remove some headers with structures and functions directly
>>   used (device.h, slab.h, virtio_byteorder.h)[Jason]
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 6a90fdb9cbfc..b08f28d20d8d 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -7,20 +7,10 @@
>>   *
>>   */
>>
>> -#include <linux/init.h>
>
>above is used by __init and __exit.
>
>>  #include <linux/module.h>
>>  #include <linux/device.h>
>> -#include <linux/kernel.h>
>> -#include <linux/fs.h>
>> -#include <linux/poll.h>
>
>Looks OK to remove poll.h.
>
>>  #include <linux/slab.h>
>> -#include <linux/sched.h>
>
>Might be OK for sched.h.
>
>> -#include <linux/wait.h>
>
>Might be OK for wait.h.
>
>> -#include <linux/uuid.h>
>> -#include <linux/iommu.h>
>>  #include <linux/dma-map-ops.h>
>> -#include <linux/sysfs.h>
>> -#include <linux/file.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/vringh.h>
>>  #include <linux/vdpa.h>
>>
>
>I didn't check the others.
>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
