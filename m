Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9935FC433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:08:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7BD60EE9
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B7BD60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01F2760705;
	Mon,  1 Nov 2021 08:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TEL2R5MouyWo; Mon,  1 Nov 2021 08:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A99C26066F;
	Mon,  1 Nov 2021 08:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 830DDC0019;
	Mon,  1 Nov 2021 08:08:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53CA6C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33C4580B57
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKvFuZSqKQEQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:08:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90A0280B23
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635754126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kLbjZDDkOhz4cJ9xiUMiFb06EkLr1swGgOKmXg3lr4=;
 b=fsVxumKTO0jzlBOmyuHd8ov5IGo31mV0QWedi27Z9hTQ6DHqcCMRZPbKD4Lgf6HEhvJZsz
 ODqxbcX9ICcGexMSE++cnZze+YANBBj0DbFmOvdxC0EvRYQ5d7MQOZLQLQObl8EwRmmBJy
 ITwIylWAGpt/bUBrZPrPVskiAnnZlUI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Ph8zwDIpO_6DuSENSHhjEQ-1; Mon, 01 Nov 2021 04:08:45 -0400
X-MC-Unique: Ph8zwDIpO_6DuSENSHhjEQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 w7-20020a056402268700b003dd46823a18so14804411edd.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 01:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5kLbjZDDkOhz4cJ9xiUMiFb06EkLr1swGgOKmXg3lr4=;
 b=lhPT/TEt6db3A/rmhuuObv6GDY/wDyPTaNLWMFDdNL2aTBLuvZaxh30fPOloy6txec
 OW0zlwQ5WceeBCcCn3PIv0Cxfl0DEwQBx0w350+fbgdxRIsIKgt8G08p/tfCwJTmagrZ
 mLzZOLKZv/ju6ByxJmzzoj6eB/PlxMcdIl8WmgG709dmIuFEJo2ZBuXFKU3gKXZ6/HD2
 Ye3SISBl5uXFKkA2vxNDW0Qppr7cTLChFUMHjTiNy0Lqe/PBzlmz+bWButx0K7iOVSDF
 h1nU+F+dmzXtnbJDhMiq68f4S+xUIhMORe2lugzWsWFThBpoBxngP2oznTVWojy/Sra5
 JptQ==
X-Gm-Message-State: AOAM531C5IPZ0gaMGLYLBXzQ0ZmPzVtgBxMCYPhWSWfp/MeTxFPfI+EP
 4QKHvl6oUVQJU4SqxfxJxGRzRs/gkBicoPceRL7pb4aO4E0L/kHwhSRNNSBJnb7UGeQncdG9FGT
 3HH2LFuJTI52KD1cDfeDPCwhD5LDybKPEbKeUDG2cXw==
X-Received: by 2002:a05:6402:1d9a:: with SMTP id
 dk26mr26519876edb.222.1635754124289; 
 Mon, 01 Nov 2021 01:08:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcxJeBlZMLJMZ/Yhk6ZkJJr8jvsWcWuj9uKKrNWq+CK5HLX298LesyvMYX0VmL4Ww/FQna1Q==
X-Received: by 2002:a05:6402:1d9a:: with SMTP id
 dk26mr26519863edb.222.1635754124152; 
 Mon, 01 Nov 2021 01:08:44 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
 by smtp.gmail.com with ESMTPSA id s26sm5967202edq.6.2021.11.01.01.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 01:08:43 -0700 (PDT)
Date: Mon, 1 Nov 2021 04:08:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH] i2c: virtio: update the maintainer to Conghui
Message-ID: <20211101040814-mutt-send-email-mst@kernel.org>
References: <00fadb64713aebd752dca3156e37c8f01c5ac184.1635736816.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <00fadb64713aebd752dca3156e37c8f01c5ac184.1635736816.git.jie.deng@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: vincent.whitchurch@axis.com, viresh.kumar@linaro.org,
 jiedeng@alumni.sjtu.edu.cn, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

On Mon, Nov 01, 2021 at 01:24:50PM +0800, Jie Deng wrote:
> Due to changes in my work, I'm passing the virtio-i2c driver
> maintenance to Conghui.
> 
> Signed-off-by: Jie Deng <jie.deng@intel.com>

Seeing as Conghui co-developed the driver, seems reasonable.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd4..8c9a677 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19944,7 +19944,7 @@ F:	include/uapi/linux/virtio_snd.h
>  F:	sound/virtio/*
>  
>  VIRTIO I2C DRIVER
> -M:	Jie Deng <jie.deng@intel.com>
> +M:	Conghui Chen <conghui.chen@intel.com>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-i2c@vger.kernel.org
>  L:	virtualization@lists.linux-foundation.org
> -- 
> 2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
