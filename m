Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9C0C4361B
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:38:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A056B207BD
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A056B207BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C98A68750E;
	Thu,  3 Dec 2020 17:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N-JDnEfL8UpN; Thu,  3 Dec 2020 17:38:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 195ED874B4;
	Thu,  3 Dec 2020 17:38:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF91CC163C;
	Thu,  3 Dec 2020 17:38:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67F6AC0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4F7AE87CA8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9QJfx2V0tL6C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:37:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7CF8387C67
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=9JV3l87i7qLuKjrvGVIBLbXpO5mZxmVEIeZIIj4DDBE=; b=aj9cu+XYV8TCyhcLCZh0/WjBjV
 uYmmIxruOBzucXfBghia+f98ozsoaToftIyylqh8O4gT6AC9VGzRIaGYoU7f0agEh7aD40D87ukul
 vq/ZZP7tWjPlnuDMCvyCGwcNCEGKdetpzdCACMcHnzrVAGKQybkGU2kBP08KDZjeq3izr28Z5FQAl
 1PvYFz1q4AV3n9IaxFGX5PdYbtevBqNtzsgcGtn5byE5ZnEHbipEwY+3xFEjx3Pc7x2nV1yfTve3k
 PeIBUX4TEZMgLMOXJA1T0Ede7h70oG7xTXvyKYHNt5uDJzCBUH5nWfsDVK4sTO64CCie3utaAFlVi
 bGHnw7Nw==;
Received: from [2601:1c0:6280:3f0::1494]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kksYE-00060O-CT; Thu, 03 Dec 2020 17:37:54 +0000
Subject: Re: [PATCH v3 02/19] vdpa_sim: remove unnecessary headers inclusion
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-3-sgarzare@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e55ab39-afdd-f47b-55ec-a2bec4ab4cec@infradead.org>
Date: Thu, 3 Dec 2020 09:37:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-3-sgarzare@redhat.com>
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 12/3/20 9:04 AM, Stefano Garzarella wrote:
> Some headers are not necessary, so let's remove them to do
> some cleaning.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Hi,
What makes you say that some of these are unnecessary?

Please use Rule #1 from Documentation/process/submit-checklist.rst:

1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.


so just because it will compile without these headers being explictly
#included does not mean that you should remove them.


> ---
> v3:
> - avoided to remove some headers with structures and functions directly
>   used (device.h, slab.h, virtio_byteorder.h)[Jason]
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 6a90fdb9cbfc..b08f28d20d8d 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -7,20 +7,10 @@
>   *
>   */
>  
> -#include <linux/init.h>

above is used by __init and __exit.

>  #include <linux/module.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/fs.h>
> -#include <linux/poll.h>

Looks OK to remove poll.h.

>  #include <linux/slab.h>
> -#include <linux/sched.h>

Might be OK for sched.h.

> -#include <linux/wait.h>

Might be OK for wait.h.

> -#include <linux/uuid.h>
> -#include <linux/iommu.h>
>  #include <linux/dma-map-ops.h>
> -#include <linux/sysfs.h>
> -#include <linux/file.h>
>  #include <linux/etherdevice.h>
>  #include <linux/vringh.h>
>  #include <linux/vdpa.h>
> 

I didn't check the others.


-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
