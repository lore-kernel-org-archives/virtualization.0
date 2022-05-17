Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28808C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 13:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D015C60E3C;
	Tue, 17 May 2022 13:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GVxotu92PUg2; Tue, 17 May 2022 13:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7889260BDD;
	Tue, 17 May 2022 13:57:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D8ECC0032;
	Tue, 17 May 2022 13:57:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B817C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69F8A40C6F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WH2AsraRJhcD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4E7040571
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652795851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=viibydTd4bSnmnraP9+6rpq5V9PMsloOGv8pDneMFf0=;
 b=C4MvHYw69EWmqeDmdtRbkZmhSBXzfEkhArMCjRsMZOLFYF+aGqXuKpnKuHB2yuHHL/sxe9
 efrLC7bvboGtNP3K7BKYVcpjTiMFoQmn757o+AXGa4zsQ4Dron5JLuL+nvSM63kd9vtX8H
 pGpXttvD7ndbQADeq4Z6JOxJeuokXuY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-afO-q4TUOMa_6Z5aAzXmNw-1; Tue, 17 May 2022 09:57:30 -0400
X-MC-Unique: afO-q4TUOMa_6Z5aAzXmNw-1
Received: by mail-qv1-f71.google.com with SMTP id
 bu6-20020ad455e6000000b004563a74e3f9so14857991qvb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=viibydTd4bSnmnraP9+6rpq5V9PMsloOGv8pDneMFf0=;
 b=b5knqZ295yZi1EmVDMXgGdN6NzyHFB6pFlnHDI1tP0kKAteUlgRhU2EFjrHMnvRuXg
 SlXfBxsx9nypjtRIwKhT8Au9yIN9Ekj8opLJuvx37X7QUJKxOQy58o1+OjaQbBwIAwJr
 7kQb9BuFkymppuutiSlfi1tTz6J6RyCcMf+MmPMNWXLEgQfz+/7n3RnRaMZ62tdMHGIj
 tKTDHTDUT1fIRaUqo4qLkJg6YOb7zyQai7CTaWVpIDP6+j9jPRP+Pap1G3vVyIfsWozF
 F4C1vf9rKPNXeq44MhiBTurBbmXxwYRKGApaWT8OBr/DblG7OEK5ITXTm4iJf5QoPuwI
 0qjw==
X-Gm-Message-State: AOAM531gc5cufbTu5avxJLGFfRhYK1bX3YyOMV3erSDPBtt1WbEuPift
 KuW/sqa1SWxkjuL8oOz3tzE9wL/8OfKA5xRpkaRXb3z6QBOE+FIMIbCQFhzyT4jLjc2e4dYDFRF
 1BVwXR7R3R41Zd8Y983TyvfAjZl0Cu4X0cS/p508IvA==
X-Received: by 2002:a05:620a:2202:b0:6a2:fc92:9916 with SMTP id
 m2-20020a05620a220200b006a2fc929916mr5112862qkh.508.1652795849935; 
 Tue, 17 May 2022 06:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe7zcjZcA8Kcx3rc2nnfrZ9NipqHZg8A6P7mRPPmBqcAc/0YlonEn5QytVNQ6oZsXFnAwz3Q==
X-Received: by 2002:a05:620a:2202:b0:6a2:fc92:9916 with SMTP id
 m2-20020a05620a220200b006a2fc929916mr5112845qkh.508.1652795849686; 
 Tue, 17 May 2022 06:57:29 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 t12-20020ac865cc000000b002f39b99f6b0sm7507185qto.74.2022.05.17.06.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 06:57:28 -0700 (PDT)
Date: Tue, 17 May 2022 15:57:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V2 2/8] vhost: flush dev once during vhost_dev_stop
Message-ID: <20220517135724.ums4yq2yk6fgmqb5@sgarzare-redhat>
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-3-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220515202922.174066-3-michael.christie@oracle.com>
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

On Sun, May 15, 2022 at 03:29:16PM -0500, Mike Christie wrote:
>When vhost_work_dev_flush returns all work queued at that time will have
>completed. There is then no need to flush after every vhost_poll_stop
>call, and we can move the flush call to after the loop that stops the
>pollers.
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/vhost.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
