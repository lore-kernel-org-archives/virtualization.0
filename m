Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06106C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 18:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B80E416DE;
	Tue,  4 Apr 2023 18:20:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B80E416DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJ0uk8O1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dnzPtrMvuSCZ; Tue,  4 Apr 2023 18:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D6352416D0;
	Tue,  4 Apr 2023 18:20:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6352416D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A84A3C0037;
	Tue,  4 Apr 2023 18:20:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2D95C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D10281E04
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:20:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D10281E04
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJ0uk8O1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RQfoTbz2ySca
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:20:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBA6081DFE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBA6081DFE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680632407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7XT+54kNmbwxTpTAz5W9o9/M+Rh1QMK7ruIlt9Kz6lw=;
 b=XJ0uk8O1SX3Vfyoryt/7cicT/4L63UEeI7LWZB6P1i4qOs3vx+xbcjBPGbICKTy13BHS/c
 70bxnyBNLvXXKz3dsJyub8JioLg1SjeFCuUXZgIxcTCF36f1G3rKJrjgM6U0gZRZKnO3Ao
 wUXDUYpkjXeHbnGw1LoYyz2ThvR9GmA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-PC8i8OWPPUqBHrIrRJuZtw-1; Tue, 04 Apr 2023 14:20:06 -0400
X-MC-Unique: PC8i8OWPPUqBHrIrRJuZtw-1
Received: by mail-ed1-f70.google.com with SMTP id
 t26-20020a50d71a000000b005003c5087caso46799436edi.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 11:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680632405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XT+54kNmbwxTpTAz5W9o9/M+Rh1QMK7ruIlt9Kz6lw=;
 b=E+VfvFYyzqHmPpICMopBzIWdRBVZc4WkS20ChY0eJidMTdPlQbGgXFN6sN02Re01Hv
 sPqcNsrIT6HnHaFp0f5x00gQkq/5jAewCQAcW80ZXoTOZty08KM/WkUkM8PTM/F2A/8+
 fkskZ07WaxKhBXnEXutWaxhK31zi8IW+HDkg9ACJrJKCJZmxjYUXkec2r9JXr9VGBomF
 oQjhm+UYLSrnuOVH8V1yLzk+1mb9lNISHM33nOg7pWu8lNeudkM6yFu0kN/PMArHz3hw
 G5ylGgBRavWSIEZpgeI5JmU6Dl6vvovhb3r8HWFTwgMo5Ql45j4Ni9CH5c6y4dw1Mio1
 G6cg==
X-Gm-Message-State: AAQBX9cAA5zIMYc22IKP5KAEWdN2CpJcnRQBhH2BW6lc0qvpANOhXDQA
 q78lPrKlwGmj78DeKZwbJryj2TAob3RWjBpcv6CqugAn92BW21fe6raoof6elmHif1kgcBq5Pxp
 v5mh4ZL8otNY+/jN6X03UnyzUAhgPrrkAv5dJaEGIDQ==
X-Received: by 2002:a17:906:7ccf:b0:8af:3b78:315d with SMTP id
 h15-20020a1709067ccf00b008af3b78315dmr494843ejp.23.1680632405035; 
 Tue, 04 Apr 2023 11:20:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+YtSgiZBggw+M7xHvvW2pBrOXMai9kh5qc/qV7jQ/QF37ZVHXAE3jOk4rynID9LNK2xF72Q==
X-Received: by 2002:a17:906:7ccf:b0:8af:3b78:315d with SMTP id
 h15-20020a1709067ccf00b008af3b78315dmr494825ejp.23.1680632404803; 
 Tue, 04 Apr 2023 11:20:04 -0700 (PDT)
Received: from redhat.com ([2.52.139.22]) by smtp.gmail.com with ESMTPSA id
 g20-20020a170906595400b00932ebffdf4esm6233903ejr.214.2023.04.04.11.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 11:20:04 -0700 (PDT)
Date: Tue, 4 Apr 2023 14:20:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v4 01/11] lib/group_cpus: Export group_cpus_evenly()
Message-ID: <20230404141915-mutt-send-email-mst@kernel.org>
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-2-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230323053043.35-2-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de, hch@lst.de
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

On Thu, Mar 23, 2023 at 01:30:33PM +0800, Xie Yongji wrote:
> Export group_cpus_evenly() so that some modules
> can make use of it to group CPUs evenly according
> to NUMA and CPU locality.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>


Hi Thomas, do you ack merging this through my tree?
Thanks!

> ---
>  lib/group_cpus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 9c837a35fef7..aa3f6815bb12 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -426,3 +426,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	return masks;
>  }
>  #endif /* CONFIG_SMP */
> +EXPORT_SYMBOL_GPL(group_cpus_evenly);
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
