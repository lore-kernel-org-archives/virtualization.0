Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13107C433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 13:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A479840C69;
	Tue, 17 May 2022 13:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9sXr3PK8kUQc; Tue, 17 May 2022 13:56:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3FA674051F;
	Tue, 17 May 2022 13:56:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 115F2C0032;
	Tue, 17 May 2022 13:56:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14C32C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E822260E3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20kvyICARJli
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:56:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4084F60BDD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652795809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbPGPwVzae8dQv/ddA09mNxlsRu13UXy8yfMZnqJBcs=;
 b=DlOHLa7yD3oIWE9H1deQQKQVcpudSXa0hLkJ1oGCSHEIy13L2CQsFhp3cU5iphXTXQlQHn
 2a8GMULHc2zi4XpjxE6Cz4PY8aPL7kakYTaminDow9xr4I1VqSWuY6YJcKL2byP8DtdZ0O
 XhWY+UxNiS0vsaRed7/8DWIqfHxueNk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-OhbFGqDcM92DaxJhNsdDjg-1; Tue, 17 May 2022 09:56:48 -0400
X-MC-Unique: OhbFGqDcM92DaxJhNsdDjg-1
Received: by mail-qk1-f198.google.com with SMTP id
 17-20020a370511000000b0069fd3b67d95so13745962qkf.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lbPGPwVzae8dQv/ddA09mNxlsRu13UXy8yfMZnqJBcs=;
 b=mZhcTm5rEZSXlUwDu//T2yJqP3X2wFjjWpNgO4WgEUfRWltjDDmMjtLnWNQlsXQHaC
 AocBPKBkp9smYwmZh+EtGvnZtvqV2NvHS3RZjzCk1JWpqaOZEgiDUmuog7Z5dGYbDw/F
 rvbwLrj9Ad9QhYUY9WHMASfiBgE+5wFDIfYSHJfT4Q7AbpTuSSjig4OrX6A+RYb3NH0b
 57lZlo+TYBKO1vl4MnlFAfq3fPMWknafP+S/F6gpsNC0PArlmz4Q2+4UgCFL82RyFJLZ
 URsP2695EHpmutzvphgSH0a2k6hrgEjsERFq6Z5II+rIWF8bI6IPusOD8DIplIhzhUso
 IfWQ==
X-Gm-Message-State: AOAM531/wMHViUkXEOMWkGsiB92eY7yblQSPMSNzrxwPcZAD7rPR4jAZ
 9gX9ylU2rJ64/wpr5dv6+bLkNMnfFMZPPI+W1xc5WA9UUqtjznXw0WzHLgnKmlt4ZtAw7Z8uIiU
 +ljf50veLYqKr+iBpmvsqTSiH31zGdaJgEPBBZ6tHhg==
X-Received: by 2002:a05:620a:49d:b0:69f:b7bd:f831 with SMTP id
 29-20020a05620a049d00b0069fb7bdf831mr15809278qkr.749.1652795807482; 
 Tue, 17 May 2022 06:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3fieq4R7fH/EdFmXuRgdGuDypLcztgzz2moJnvNeJe3G/K8OrViimoEfw/Ezuu7ZxZpN6dA==
X-Received: by 2002:a05:620a:49d:b0:69f:b7bd:f831 with SMTP id
 29-20020a05620a049d00b0069fb7bdf831mr15809260qkr.749.1652795807271; 
 Tue, 17 May 2022 06:56:47 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 y3-20020a05620a09c300b0069fc13ce220sm7040769qky.81.2022.05.17.06.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 06:56:46 -0700 (PDT)
Date: Tue, 17 May 2022 15:56:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V2 1/8] vhost: get rid of vhost_poll_flush() wrapper
Message-ID: <20220517135641.252dj3gxis7oe7qm@sgarzare-redhat>
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-2-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220515202922.174066-2-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, arbn@yandex-team.com,
 stefanha@redhat.com, mst@redhat.com
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

On Sun, May 15, 2022 at 03:29:15PM -0500, Mike Christie wrote:
>From: Andrey Ryabinin <arbn@yandex-team.com>
>
>vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
>It gives wrong impression that we are doing some work over vhost_poll,
>while in fact it flushes vhost_poll->dev.
>It only complicate understanding of the code and leads to mistakes
>like flushing the same vhost_dev several times in a row.
>
>Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>[merge vhost_poll_flush removal from Stefano Garzarella]
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/net.c   |  4 ++--
> drivers/vhost/test.c  |  2 +-
> drivers/vhost/vhost.c | 12 ++----------
> drivers/vhost/vhost.h |  1 -
> drivers/vhost/vsock.c |  2 +-
> 5 files changed, 6 insertions(+), 15 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
