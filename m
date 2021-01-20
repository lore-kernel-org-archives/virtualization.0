Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C7C433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 08:52:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDB222C9E
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 08:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDB222C9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78CDA84921;
	Wed, 20 Jan 2021 08:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQbzlQSTl9WU; Wed, 20 Jan 2021 08:52:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1540985D92;
	Wed, 20 Jan 2021 08:52:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3D51C08A1;
	Wed, 20 Jan 2021 08:52:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C91D5C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B4FAE86FCB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-jkfLukfAe8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D989385F4B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611132727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4UnMNibyh8PbpucVHsdwUM+5SKhACPpSJYaybcE7KM=;
 b=BxKUCEqDvQT+8X2NQHwOLtONP9rZK58328UGwppeeTpe37wyw+wAax6ID9ngOkc32i9ETD
 pFOxAOoQ6xGXlmdsDE6g1KTWNCjyLZW8rRHzVEgk6FFQGeZUAisqk39HvylphSuoFkM3xM
 hJeB1ZpouU+sKZYlBJHgrD6f/kRZCws=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-xsDMfiR1PE6U8yMrgICn5Q-1; Wed, 20 Jan 2021 03:52:04 -0500
X-MC-Unique: xsDMfiR1PE6U8yMrgICn5Q-1
Received: by mail-wm1-f72.google.com with SMTP id d2so1034570wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d4UnMNibyh8PbpucVHsdwUM+5SKhACPpSJYaybcE7KM=;
 b=C+dVCYSyAMBkyJAQvHroKPUJg+4bzHb2aTVIB65DlgTDP/uNczzP5kJFnwwAA8e/70
 dZzkVD+ZCioZLIUhxNG5ItC+PZTaEmn9cbceAJwdLQ/WP1TBBjLWuDOiWwK0AZzKRx44
 VDV1Kapc4NmPg9xuHahROGtBzCfYF73xqRduWxCtLGOBUAXLXzZSI6iOsXBkZZqmgELD
 fc+LJS8v3pwP9DckF+XfJzPBrmVo5efRwo5ZeWKbYk+8XJ1BkmmpOFEk8wWyh0O+KH8v
 1dDVXRY5JmNV6D6eNu8J7gKDuy8pXhg1Jhs28F79hEdf6VOr9EAEt+QnJM3+HgDG3xBF
 /B1w==
X-Gm-Message-State: AOAM532uaE+DuXZNxEdT/30ZN24lj5frJLbM15ukHwF3z0iqhJY4qADM
 ZXB19O5s0RwLPqglNWzSXkN2YiSmP9qQycf28/QilgDF5ZSTZrSeCF8DEleACQkKWJdiWGCA4Q1
 w4jFo+iWkXEB6GFrAtTyHCRMsx48OVm1HLsaPphXWgg==
X-Received: by 2002:a1c:7f8c:: with SMTP id a134mr3287572wmd.184.1611132723753; 
 Wed, 20 Jan 2021 00:52:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9HHKjWFC7iPFhp5YFU8NaoWOBXnOXFOBmJKdJIiIKgWhVdaqgHhBEeVM6yYHYdkW+3705MQ==
X-Received: by 2002:a1c:7f8c:: with SMTP id a134mr3287561wmd.184.1611132723632; 
 Wed, 20 Jan 2021 00:52:03 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id w23sm2532766wmi.13.2021.01.20.00.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 00:52:03 -0800 (PST)
Date: Wed, 20 Jan 2021 03:52:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] vdpa/mlx5: Fix memory key MTT population
Message-ID: <20210120035031-mutt-send-email-mst@kernel.org>
References: <20210107071845.GA224876@mtl-vdi-166.wap.labs.mlnx>
 <07d336a3-7fc2-5e4a-667a-495b5bb755da@redhat.com>
 <20210120053619.GA126435@mtl-vdi-166.wap.labs.mlnx>
 <20210120025651-mutt-send-email-mst@kernel.org>
 <20210120081154.GA132136@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210120081154.GA132136@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lulu@redhat.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 20, 2021 at 10:11:54AM +0200, Eli Cohen wrote:
> On Wed, Jan 20, 2021 at 02:57:05AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Jan 20, 2021 at 07:36:19AM +0200, Eli Cohen wrote:
> > > On Fri, Jan 08, 2021 at 04:38:55PM +0800, Jason Wang wrote:
> > > 
> > > Hi Michael,
> > > this patch is a fix. Are you going to merge it?
> > 
> > yes - in the next pull request.
> > 
> 
> Great thanks.
> Can you send the path to your git tree where you keep the patches you
> intend to merge?

https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

Note I often rebase it (e.g. just did).

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
