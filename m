Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E067EC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 08:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BFA761295;
	Thu,  9 Mar 2023 08:24:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BFA761295
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BWBgLYVP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AKztJIa7EFhS; Thu,  9 Mar 2023 08:24:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1575660DE5;
	Thu,  9 Mar 2023 08:24:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1575660DE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE7DFC0035;
	Thu,  9 Mar 2023 08:24:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE7FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3148F6124A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3148F6124A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qXKPwsRxzG7C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:23:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BA5C60DE5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BA5C60DE5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678350237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZw+8PkpvnITOM51K6QxrDhmPN2cNcmXJdgLsTe/KhY=;
 b=BWBgLYVPxzYk+C4quOpyUXP8eBAIFrh/K1af8CqkAB+eifn/QmhyLhK+GjpCKLYBtbTuz5
 CTCPUrWpOlLG1QEtXnJxmBLB818S0BNfwhJjs10l/DYcnD7CAOknHMB5eHXqNmvq19qZ9J
 2G+3jkjslIZvIa626i8MCuuLRBTMht8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-kb2IDeldOJii00KTQIRiyQ-1; Thu, 09 Mar 2023 03:23:56 -0500
X-MC-Unique: kb2IDeldOJii00KTQIRiyQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 r14-20020a0560001b8e00b002cdb76f7e80so215120wru.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 00:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678350235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZw+8PkpvnITOM51K6QxrDhmPN2cNcmXJdgLsTe/KhY=;
 b=Tn+6jd+F346hVw5D+2VOJizdONjydSNGxNWf5pjO2rufkxOmpLnN6xgikHuphshQ5x
 sGL5uPYgipQrPGAnKsKfbjG1GWj2E3pK+159XWLX/UQHFTgdq+MT9umCcQQUKo9HxVDA
 tFT0Z9snOVwGtnxrTD4uj9ZsI5NcO5AUvhhqOHios2XAD06sWdqSjUUEVYkfCtfnnKO+
 fxLO+uwFmghC41yWUkZZBFiNwOwqm/xWsBGRTmT4850CQO4U/DGfuKvF7HkIzlSKVPnE
 k85AEvL1I1sPV/VGkmgfabPJAb5ZSlJHNpc3duhVXiIaRM5Ax3raflZevMIImh0oH/VL
 GDCA==
X-Gm-Message-State: AO0yUKU3IHGbDsX5Uu+gIWjwN3qe5uplg2Kh1rpHlD4lDOtvHrbxWWIV
 +7fUC2HwNukKXsF33efwRdkVjlNOvifpuz1eR672agIS83zTfcv8f5BjQentUrxizADghgM38g8
 nrYA99y+7lwpgKxbnEDMjDLkryUpA+hHOfT6NEzLlNg==
X-Received: by 2002:a05:600c:c11:b0:3df:d431:cf64 with SMTP id
 fm17-20020a05600c0c1100b003dfd431cf64mr19159705wmb.39.1678350235115; 
 Thu, 09 Mar 2023 00:23:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8WNigRlS2/369LtM0djAYyNqN3raDfhZGg8ODekM6tL6N33xyLTnVfkUTqE57R1YdM9kFjFA==
X-Received: by 2002:a05:600c:c11:b0:3df:d431:cf64 with SMTP id
 fm17-20020a05600c0c1100b003dfd431cf64mr19159693wmb.39.1678350234844; 
 Thu, 09 Mar 2023 00:23:54 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003e4326a6d53sm1751764wmr.35.2023.03.09.00.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 00:23:54 -0800 (PST)
Date: Thu, 9 Mar 2023 09:23:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: Ignore virtio-trace/trace-agent
Message-ID: <20230309082351.y63lsa7gaxpoq2k7@sgarzare-redhat>
References: <tencent_52B2BC2F47540A5FEB46E710BD0C8485B409@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_52B2BC2F47540A5FEB46E710BD0C8485B409@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
 mst@redhat.com
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

On Thu, Mar 09, 2023 at 02:13:07PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>since commit 108fc82596e3("tools: Add guest trace agent as a user tool")
>introduce virtio-trace/trace-agent, it should be ignored in the git tree.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
> tools/virtio/.gitignore | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
>index 075588c4da08..9934d48d9a55 100644
>--- a/tools/virtio/.gitignore
>+++ b/tools/virtio/.gitignore
>@@ -2,3 +2,4 @@
> *.d
> virtio_test
> vringh_test
>+virtio-trace/trace-agent
>-- 
>2.39.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
