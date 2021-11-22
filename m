Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD46C433FE
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 10:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6993D80B54;
	Mon, 22 Nov 2021 10:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPYHiJM95Tak; Mon, 22 Nov 2021 10:58:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E0CF80B26;
	Mon, 22 Nov 2021 10:58:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6ECEC002E;
	Mon, 22 Nov 2021 10:58:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 230CFC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F071B40172
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41mI02kTSEXx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:58:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2F2340010
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637578706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psTM8ISrjkyMgJwD8v5I4omETk3J8QMXgeddK2v/9Oo=;
 b=ZyFu5W/QQqGZISQPJ0flp7xPIrWgSlEApqbV8Q+trH2Pt5we+G5rkRk7v9VD91+kry7aKV
 NkMZJ57yka6nCcUnl/Gkj+5I52XabBxUwVrMGV73DQA+XS85Esi8w3V2CDLHkjcvuXZk3a
 VRTWF2kfxE0PFTY+67R0m8DOpC+5vgs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-TLo-3UZSPeiJpmRrYGH1-Q-1; Mon, 22 Nov 2021 05:58:25 -0500
X-MC-Unique: TLo-3UZSPeiJpmRrYGH1-Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 b15-20020aa7c6cf000000b003e7cf0f73daso14383933eds.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=psTM8ISrjkyMgJwD8v5I4omETk3J8QMXgeddK2v/9Oo=;
 b=AnkzE5tW3X8mYHNO8zFn41EA0qDUwDWbt2BHWfRErNWuz28kdfh8qcmaZukSHLk4Yr
 oKo+tooAn2IeLuuCf89VmtpSl8OEyuB5FvNnFCNtmpfL929jMvcEtOWMN+trp8DFQDyK
 wOmn3AIXkw38IZjr1fQ/IBcU/Ir83kTBZt6lB8R5rg+a5S1d3bpzen1KS6k+6zZ8+Zge
 eDW8fsCRankcwSQ9OvTHQ59C++3bfDXyaoZzdk78ZZjQYd6AQOzxW4PynhiU67vpSnzg
 jTEIpH5LR80IO6YNs3rs94kfw8jB2H+71pZq1vDdIMT0om+QMDDrgxpFlOQeG1bBlkvT
 1Vcw==
X-Gm-Message-State: AOAM530shpfFiKKExAcFL+rpJ9bkfEDfauqoFg5WnojsDo4FqdIo3gEQ
 tfvZoyinF7joLUBS1P4EmCIlfgKMsfxGR7UbT5/LHnEhi5fxFnfxqfn+ejqjPmeudcZVbB5Fizo
 NSK2nvWnJMVyhJ5h9ZKsQ/BYtGo6aYMH5aIWCm3Y4KQ==
X-Received: by 2002:a17:906:bcce:: with SMTP id
 lw14mr39444159ejb.411.1637578704540; 
 Mon, 22 Nov 2021 02:58:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5euxEOhXA4OuQ9nCYhyy7FrC86z4Kyu9dkiD0+vafLsMdUW/fn+csxa5thD15nAAx3gGTww==
X-Received: by 2002:a17:906:bcce:: with SMTP id
 lw14mr39444132ejb.411.1637578704379; 
 Mon, 22 Nov 2021 02:58:24 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id w24sm3527362ejk.0.2021.11.22.02.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 02:58:24 -0800 (PST)
Date: Mon, 22 Nov 2021 11:58:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vsock/virtio: suppress used length validation
Message-ID: <20211122105822.onarsa4sydzxqynu@steredhat>
References: <20211122093036.285952-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211122093036.285952-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: david.kaplan@amd.com, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 netdev@vger.kernel.org, f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Nov 22, 2021 at 04:32:01AM -0500, Michael S. Tsirkin wrote:
>It turns out that vhost vsock violates the virtio spec
>by supplying the out buffer length in the used length
>(should just be the in length).
>As a result, attempts to validate the used length fail with:
>vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
>
>Since vsock driver does not use the length fox tx and
>validates the length before use for rx, it is safe to
>suppress the validation in virtio core for this driver.
>
>Reported-by: Halil Pasic <pasic@linux.ibm.com>
>Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
>Cc: "Jason Wang" <jasowang@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 1 +
> 1 file changed, 1 insertion(+)

Thanks for this fix

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


I think we should also fix vhost-vsock violation (in stable branches 
too).
@Halil do you plan to send a fix? Otherwise I can do it ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
