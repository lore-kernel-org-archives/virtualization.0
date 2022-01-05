Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4940BC433EF
	for <virtualization@archiver.kernel.org>; Wed,  5 Jan 2022 06:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8C90415FF;
	Wed,  5 Jan 2022 06:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oduy93L0dZXV; Wed,  5 Jan 2022 06:06:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6AFF840966;
	Wed,  5 Jan 2022 06:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A7E2C002F;
	Wed,  5 Jan 2022 06:06:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE32C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24DD360773
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xXdUFP-1_2IL
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:05:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89B2E606CB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641362756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UL4Und+6KLWOYAHGFmB/jvd7RT8XTJmiAk4kEiJLJb8=;
 b=Y2I5A1gzk5++EqKa+iTXzSyB5LCs0Ra4qwplaYFwQXTKM2yY06UST/lPpGA5RliI31fHYu
 c/V2pFqzIRQb1j5KGakBdWA9YBCi9uhsSQlH+Tjg7MvsyZxB3GjIEhT2P0NGGhvle7Syil
 GgO0QKawkjfvs/fiGdj+mk2/FWY1hpA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-E0Rx3IDWOM6HGZ3RYLam5w-1; Wed, 05 Jan 2022 01:05:54 -0500
X-MC-Unique: E0Rx3IDWOM6HGZ3RYLam5w-1
Received: by mail-lf1-f70.google.com with SMTP id
 g18-20020a05651222d200b0042612bda352so8972705lfu.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jan 2022 22:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UL4Und+6KLWOYAHGFmB/jvd7RT8XTJmiAk4kEiJLJb8=;
 b=RbpkJmw+IolHvc9+FHpii3ZojAJpOsenyZv6TupJEyWuZIOxI+hD+k1+09Huv4A8jJ
 UcSAkoXLxMOO6nlwwlJxKaqI+qP2AXWlRciGpPuPk+/1qhVMiUDf3UsI/NP/DTybFcz8
 8Y358VsF7xhjnDQhAlMqW15wbgPV9xHQqiBnrHoyYhG+VfXhI0+XnY86i2w28UhcwoVd
 qkXStGI9oOhVfMFPWDoQqKoiQ5klKIQwZc5cIMyhyiTQ+TtIS11KbtFuhJwwP0zhyCvq
 z282DSsDLktU5mv4rlgiNQyiMYZnxZq6NUfb3b5FH7HAe5x6qivbk4aLR4UNNz8p0wQU
 b/Rw==
X-Gm-Message-State: AOAM533Y/Ev8BcyS/tUAbgUGeqwbbOOdimx6ifSgT2LkRBYLsvWETm87
 F5Yr2De5qD9tjMkUq3DZEOD2uJwBeTURkod5S3pe+M0ns4COtbEm8sjBGXZcAqonH/0Jc4qgETu
 n2CRFaQqswf8eZfbQS+xf6AB3lvBEyDVHf6xtxqKykPY3RMtXKi7OCeHIAQ==
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr46191535lfm.580.1641362752707; 
 Tue, 04 Jan 2022 22:05:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRg7a8MzGZw6q4KrC1avYz+TiYrVxgJoTeM3mEsGZPtExXsXak0VN2a1umFHW5YpsuEnvvG3o6jjAx8Q+dafI=
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr46191523lfm.580.1641362752501; 
 Tue, 04 Jan 2022 22:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20211229092443.GA10533@L-PF27918B-1352.localdomain>
In-Reply-To: <20211229092443.GA10533@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jan 2022 14:05:41 +0800
Message-ID: <CACGkMEtYV7ANSYaA3d4dYC2P93nOc2qh_FxFTYabw_+Rrq4G=w@mail.gmail.com>
Subject: Re:
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Dec 29, 2021 at 5:31 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> linux-kernel@vger.kernel.org
> Bcc:
> Subject: Should we call vdpa_config_ops->get_vq_num_{max,min} with a
>  virtqueue index?
> Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
>
> Hi jason,
>
> AFAIK, a virtio device may have multiple virtqueues of diffrent sizes.
> It is okay for modern devices with the vdpa_config_ops->get_vq_num_max
> implementation with a static number currently since modern devices can
> reset the queue size. But for legacy-virtio based devices, we cannot
> allocate correct sizes for these virtqueues since it is not supported to
> negotiate the queue size with harware.
>
> So as the title said, I wonder is it neccessary to add a new parameter
> `index` to vdpa_config_ops->get_vq_num_{max,min} to help us get the size
> of a dedicated virtqueue.

I've posted something like this in the past here:

https://lore.kernel.org/lkml/CACycT3tMd750PQ0mgqCjHnxM4RmMcx2+Eo=2RBs2E2W3qPJang@mail.gmail.com/

>
> Or we can introduce a new callback like get_config_vq_num?
>
> What do you think?

If you wish, you can carry on my work. We can start by reusing the
current ops, if it doesn't work, we can use new.

Thanks

>
> Thanks
>
>
>
>
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
