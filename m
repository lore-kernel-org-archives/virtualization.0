Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AF0C433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 09:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BD0940272;
	Tue, 15 Mar 2022 09:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oct73hOT4sCq; Tue, 15 Mar 2022 09:42:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8095440112;
	Tue, 15 Mar 2022 09:42:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B1F2C0012;
	Tue, 15 Mar 2022 09:42:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A634AC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C71C415DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fNI4mesQHDCH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:42:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0BE2415BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647337350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ds972m32UsHYPTXO2zaE7harfTeBM/jXF+brjmWcEJU=;
 b=Sk9AE5DjhirNDBdoXcs411BYKYZf5z3c9cCQbtGBeN9ITOIrra1CCBZJZ47rou4RkL9Lme
 ESRiOoDnXeJ2jIEf6BpNEavMXXWt6WC1SARck0cFdN8JaC9U9X2bnZy6dQ81+cwjiI39zh
 OYJ3c3Ic93eMD9lUqRmDVETowhWOdr0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-3NEoJMxxN3SyBJT95Yu8EA-1; Tue, 15 Mar 2022 05:42:29 -0400
X-MC-Unique: 3NEoJMxxN3SyBJT95Yu8EA-1
Received: by mail-qv1-f70.google.com with SMTP id
 es11-20020a056214192b00b004354eecad3bso16113217qvb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 02:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ds972m32UsHYPTXO2zaE7harfTeBM/jXF+brjmWcEJU=;
 b=DBFoKL9qy6fX4Qkx6TdQ7P0Eyt20lpmx1rimU2w++6ekYphQMpbIDEExW5zKbdfOeQ
 wVQzuAIJucQGK2XD2pOp50TqEyr6J/3nQH1gP5BZRODqtVT6VtqkyLFIru+F/xANsNxb
 Y9WiEqh7NCNXoqr/ly5XNlWI2gffM9ZPBCYWqeEBbu/isylVzf417CrF/0Ah/N5GKka3
 scJ3NYhfXn2eYOPd1Lv5pY3Pk3GX5zFTwImCFmT7qQ8hkFxaE4kcjcybVYlA/xwHnbq/
 eie0GQoxwGqvI6yRZyHARS4CuQL/gr5hiusAOHBxy8ZGbi0X4MmCsNAahrkaVtXRFS23
 74Vg==
X-Gm-Message-State: AOAM533udpiS3In6Pc/Kwf3c6xVmdow8Qc/Oizr/IUXARl7zmOgfGM9e
 gQy4BZyRIsxlP7ypG159uv0Zynid5r33IcKavX7cUZYuhlxUJnGmP/5gPgjDkbeMaUfB/3lXKKb
 L1OZX25EOwDGTFuJLJhhESRVa4iZI0hXWgAl0tjPuwA==
X-Received: by 2002:a05:6214:c6d:b0:440:ac02:7780 with SMTP id
 t13-20020a0562140c6d00b00440ac027780mr6806438qvj.3.1647337349129; 
 Tue, 15 Mar 2022 02:42:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz42nBONUMqEZ4XOsuNGpVckpNWadr0jR4fGhO7CwI1fHw6DycfxJ/bVDSIU0KjGdkQQBH4Ag==
X-Received: by 2002:a05:6214:c6d:b0:440:ac02:7780 with SMTP id
 t13-20020a0562140c6d00b00440ac027780mr6806421qvj.3.1647337348926; 
 Tue, 15 Mar 2022 02:42:28 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05622a199300b002e1a669eeb6sm11762076qtc.34.2022.03.15.02.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 02:42:28 -0700 (PDT)
Date: Tue, 15 Mar 2022 10:42:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH v2 2/3] vdpa: change the type of nvqs to u32
Message-ID: <20220315094222.nbrknj5lqtqnbvmt@sgarzare-redhat>
References: <20220315032553.455-1-longpeng2@huawei.com>
 <20220315032553.455-3-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220315032553.455-3-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yechuan@huawei.com, huangzhichao@huawei.com,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Tue, Mar 15, 2022 at 11:25:52AM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>Change vdpa_device.nvqs and vhost_vdpa.nvqs to use u32
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vdpa/vdpa.c  |  6 +++---
> drivers/vhost/vdpa.c | 10 ++++++----
> include/linux/vdpa.h |  6 +++---
> 3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
