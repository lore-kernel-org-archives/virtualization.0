Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2298C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 08:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 281BE40171;
	Tue, 23 Nov 2021 08:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e44DcH_QKV7J; Tue, 23 Nov 2021 08:19:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A46D3400C4;
	Tue, 23 Nov 2021 08:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D180C001E;
	Tue, 23 Nov 2021 08:19:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3E1AC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B03FB401FA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i_kIF5DQJYV8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:19:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0570401F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637655574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DB5J6o56aoD8qmKsx2+0tQdowaBmrwF9mBpHda0JqSk=;
 b=K/FM9/vVo7oZuoz0WoVTCIJKInMFqHxlf93+fER1lKdT63P75f4XyXXS5xbow/IpoZ+CeF
 qRQngx9Q+uRNTnbk/rXbn2bR8al1DFy45AgGLuWKeAP/o4mAGK5Q0GhcB0YD6xF8kPkDaH
 rOJbM+npPi67MauhIw/qZQUokcyE0zo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-8RJu5x6lMd2CGAEdRPwJSQ-1; Tue, 23 Nov 2021 03:19:33 -0500
X-MC-Unique: 8RJu5x6lMd2CGAEdRPwJSQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 p4-20020aa7d304000000b003e7ef120a37so17103394edq.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 00:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DB5J6o56aoD8qmKsx2+0tQdowaBmrwF9mBpHda0JqSk=;
 b=ScwCRtlqSntY3UKZp91AVTlK72MZcXSQlh851bMqzfNytwfnpyMz8BMKxcF+8oeDzx
 IyUFMXgj/KhYCGFvkg2fsyy9qaWSpjjZ9ztsVrvOyIzPgq/BLoxpaQMGPegVY7/krRZ+
 gSCrakso9cyuDmSibzaMWbu0BwkfIRYNhyTeaOvFFct1qXljXs2tjGe5fWad/Yg8C2Fo
 MyW2BOtN3rvCmBIRQM7qbDiRE+dOYRBT8qrbNcCcN/Sii6EzXe6cZpiPySpcAFY30OqO
 xqat9aX2mzubn7Kj2eiXgPSZEbC06F17nryh+1I12H/R2EVjnbcbcwhbvW1CJ15rXyPj
 WUvg==
X-Gm-Message-State: AOAM533N+cOwMjG69jQP4yDBkAla50HsD3sR3VT3hiHpD8nLhaE96Em4
 8FAg3QgQ5G4rB+L+w0D16hmfYgaugRdIAl61eQamuolpe2m6635Aad46YUqDoU/Mur+Ofgd1iAz
 PGc87jJm5I4fS8zu8eherOHP2oSpgr5RrwpOMX3YIVg==
X-Received: by 2002:a17:907:7f2a:: with SMTP id
 qf42mr5436091ejc.388.1637655572331; 
 Tue, 23 Nov 2021 00:19:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRz2QfWedQwOSAAZ8IRUzi/jx1YDNZdeXP8Oohael6RR8amwpDFZd2lFJY3yoiPhevjQBh6A==
X-Received: by 2002:a17:907:7f2a:: with SMTP id
 qf42mr5436067ejc.388.1637655572156; 
 Tue, 23 Nov 2021 00:19:32 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id v13sm4705134ejo.36.2021.11.23.00.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 00:19:31 -0800 (PST)
Date: Tue, 23 Nov 2021 09:19:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
Message-ID: <20211123081929.6wa3jes3rnm5hh63@steredhat>
References: <20211122122221.56-1-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20211122122221.56-1-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mgurtovoy@nvidia.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Nov 22, 2021 at 08:22:21PM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>The system will crash if we put an uninitialized iova_domain, this
>could happen when an error occurs before initializing the iova_domain
>in vdpasim_create().
>
>BUG: kernel NULL pointer dereference, address: 0000000000000000
>...
>RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
>...
>Call Trace:
> <TASK>
> put_iova_domain+0x29/0x220
> vdpasim_free+0xd1/0x120 [vdpa_sim]
> vdpa_release_dev+0x21/0x40 [vdpa]
> device_release+0x33/0x90
> kobject_release+0x63/0x160
> vdpasim_create+0x127/0x2a0 [vdpa_sim]
> vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
> vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
> genl_family_rcv_msg_doit+0x112/0x140
> genl_rcv_msg+0xdf/0x1d0
> ...
>
>So we must make sure the iova_domain is already initialized before
>put it.
>
>In addition, we may get the following warning in this case:
>WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70
>
>So we must make sure the iova_cache_put() is invoked only if the
>iova_cache_get() is already invoked. Let's fix it together.
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

Ooops, thanks for fixing this :-)

With the Fixes tag as suggested:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
