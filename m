Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE49C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 12:58:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B60960C49
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 12:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B60960C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22DE340270;
	Tue, 26 Oct 2021 12:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfPZ7jwpLFc6; Tue, 26 Oct 2021 12:58:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E1A9401D3;
	Tue, 26 Oct 2021 12:58:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 797EBC0012;
	Tue, 26 Oct 2021 12:58:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04B6FC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 12:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E79E2401EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 12:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFocS5rwJNZw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 12:58:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F3E6401D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635253112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqqaTMYlfZ5Tsuu7zAIoyf3ldDamhjNJ+wSASSUkqAE=;
 b=XYtgI8zVYst4s+WMjbsmaJ0AYWKBDPDtcd0En+Kid1qGfvvjdq0PSMmJbFnq3uq2m9KA4d
 T9VRxeQ0R0DdYw+qH2NUT++o8xfzOpTUvj4PocjiZku3UANqgx78RJ3uFpYJkg2KRycJFn
 DBxMXF2OAufHlnOAhTAXbdT4RTlCUP4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-qQwyWBJdMLKaTVeYNDIi_Q-1; Tue, 26 Oct 2021 08:58:31 -0400
X-MC-Unique: qQwyWBJdMLKaTVeYNDIi_Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 u17-20020a50d511000000b003daa3828c13so12950852edi.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qqqaTMYlfZ5Tsuu7zAIoyf3ldDamhjNJ+wSASSUkqAE=;
 b=16CQnACdPZ6hUQWf+TejkRaH644zKWLQtE/v7PaRlpNnLApKQ6aIGymC3ozjas+sZ8
 0GLi/TSNl5oHVE2jty1GuX6c7LQYMjcYHCZkqSrsDikSfg39Dc9c7+JPaE8U7/lOKfKv
 IQr6hwB9Ebav+aE3/jZlY/DjJtFg27ne+d69PDMg1Sg7s3/02P6AQCG+Xs4mjmgAvVH5
 ZtQbSCUBSPEw5Z1r0VLZ0T/lleuokfNs+FgQ5QNQaPUloFQySmJEVCbnk1wpPq43wh5U
 cUxn8JTbGOM4DgymW55x8qlUz5/HQvdh0d39u/4CtXturKUb/DPuki72pwe2txiH8FJT
 /A/Q==
X-Gm-Message-State: AOAM530LgwXr8fhwUqK4hQcOdJXLOJuFJXHWAH9kEPMaEItvVMt9I4LA
 MxoOpuaajS8OZELH4p8YvtlKKb/bunzYwY+qc4hYuTwuJjALw5Z8oGgzhFcuKXHqhu66ucPJN1d
 VJfgUO11jqU/glCgpmXQM8J00b5z8gJ/4CwrLyROwXA==
X-Received: by 2002:a17:907:8a04:: with SMTP id
 sc4mr30146858ejc.107.1635253110291; 
 Tue, 26 Oct 2021 05:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxKejbBsS3+DbaNTFNM3vXt3pfGeHZbqaZ5zfK5TPwnrdR2bPHZhTH/E9Mqy8adlCTxhvVVA==
X-Received: by 2002:a17:907:8a04:: with SMTP id
 sc4mr30146841ejc.107.1635253110135; 
 Tue, 26 Oct 2021 05:58:30 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id z4sm12262972edd.46.2021.10.26.05.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 05:58:29 -0700 (PDT)
Date: Tue, 26 Oct 2021 14:58:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v6 3/8] vdpa: Use kernel coding style for
 structure comments
Message-ID: <20211026125827.hkkxiwcrxh7hevfa@steredhat>
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211026040243.79005-4-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, mst@redhat.com, virtualization@lists.linux-foundation.org
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

On Tue, Oct 26, 2021 at 07:02:38AM +0300, Parav Pandit via Virtualization wrote:
>As subsequent patch adds new structure field with comment, move the
>structure comment to follow kernel coding style.
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>Reviewed-by: Eli Cohen <elic@nvidia.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> include/linux/vdpa.h | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
