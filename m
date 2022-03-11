Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F45CC433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 15:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE61540280;
	Fri, 11 Mar 2022 15:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EwGNhwKoPte1; Fri, 11 Mar 2022 15:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9FF8D40274;
	Fri, 11 Mar 2022 15:38:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83ED3C0012;
	Fri, 11 Mar 2022 15:38:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 523FFC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 15:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41E64842E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 15:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sxk4jaEcWfpX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 15:38:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6113841AC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647013094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YD3FbTWDdRUPir8Zt2BKp98U4skV0lPtRrNJbm4dnUw=;
 b=SIxQcHXmongWEjR0ZZpuLdhJFvHMM/gtz1Am44Jh8M9/TK3JuewObXU3UAhOy4Xi/cqhJQ
 U0AFXlOYOdOaLCGFNYTQ+QctS4ls2hihvCWQmuNmCkpFs8NbVROSMSRShLBtkJEw90wLkM
 cY2anTpE83lPHEfYJXxrYhR+XF3A6lY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-bu5oMJH1Pey7NZOqWtLfFw-1; Fri, 11 Mar 2022 10:38:12 -0500
X-MC-Unique: bu5oMJH1Pey7NZOqWtLfFw-1
Received: by mail-wr1-f72.google.com with SMTP id
 t8-20020adfa2c8000000b001e8f6889404so2938953wra.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 07:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YD3FbTWDdRUPir8Zt2BKp98U4skV0lPtRrNJbm4dnUw=;
 b=DT4VR3JOtfn6ywxxUuttA/i5kGSSjg0ER1bAPyobqTqpwLlCtNLvhnocZ7kN9ZMoUG
 XfdJXIi5IGjWZfBX9IhsRDqtcSXsY9DKWm6HA48L4W2U3lE6q53PFjWhBwqA8H/inSMp
 rMxA885l7dQGcjisnAvRJHEqnKnmmtByIPmlt3LND+F1mktDXIqvpEe0gTuL7pJTC4oR
 cRTBwQhF7wEhBM1Bn/inWx4rIjBe178N1a7CWpcQLN2m2u5Dz95b0qJ9J8kebv48kpB7
 qgsNG8DG4qyF90cODjNBL6g814IYFXP1HbqqknSIEbMRUwbOmteKt0ip2zwLE1Krhxov
 Le3g==
X-Gm-Message-State: AOAM5334uBznjuOjJ5HQD87N/zk01w9QZOv4uuSLfZH+wz964CN8CWcW
 ZhihXCCfTX9EFQIm82d7mkQmys0icna0izvxjzzwIkLlY4IVU231BJEAOdeUgC8Jc8ty4/yNLnz
 NERGv4ajYChqt9zcU02ApeqLGc+Qrpj+zUFx40KER6g==
X-Received: by 2002:a05:6000:1568:b0:203:72c4:bee with SMTP id
 8-20020a056000156800b0020372c40beemr7710549wrz.193.1647013091797; 
 Fri, 11 Mar 2022 07:38:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynfVlQBSjbAKsq3G5l6Xx8jziz3/IiquJn6qXnkJBSURmwWs8ZfZVn999GsTUAb4z5l9DKvg==
X-Received: by 2002:a05:6000:1568:b0:203:72c4:bee with SMTP id
 8-20020a056000156800b0020372c40beemr7710533wrz.193.1647013091544; 
 Fri, 11 Mar 2022 07:38:11 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00389a616615csm11858696wmc.2.2022.03.11.07.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Mar 2022 07:38:10 -0800 (PST)
Date: Fri, 11 Mar 2022 10:38:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220311103549-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220311152832.17703-1-suwan.kim027@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, pbonzini@redhat.com, stefanha@redhat.com,
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

On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..3fcaf937afe1 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>  	 * deallocation of one or more of the sectors.
>  	 */
>  	__u8 write_zeroes_may_unmap;
> +	__u8 unused1;
>  
> -	__u8 unused1[3];
> +	__virtio16 num_poll_queues;
>  } __attribute__((packed));

Same as any virtio UAPI change, this has to go through the virtio TC.
In particular I don't think gating a new config field on
an existing feature flag is a good idea.

>  /*
> -- 
> 2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
