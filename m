Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C2AC4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 05:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78C5A60BF3;
	Wed, 12 Oct 2022 05:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78C5A60BF3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DcRdABCM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9DodZcYviSDW; Wed, 12 Oct 2022 05:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 132F460A4F;
	Wed, 12 Oct 2022 05:54:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 132F460A4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB840C0032;
	Wed, 12 Oct 2022 05:54:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA2A7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 800D84026C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:54:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 800D84026C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DcRdABCM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18yE0BFOfaH5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:54:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90AEF40265
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90AEF40265
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665554068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4nlj50WPMcH7w2yz/1NnL0XsiKvj2FRcmAW5ed9ibA=;
 b=DcRdABCMutRfvAP+k6LgkMsFhyvFSlIYfJXm0Sm0paUM/K80440xOu9MUP6icZsJVqbnTO
 vxtQtbzsbGpYuPZM3ijSaM2PLwR1LlwwWuOdCcJUJJMzjgshwaP65l70pmkLbar6e+EVBo
 4jwPGZbzjL4BW9Pli6xcqNeRQlrvVsA=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-251-RDJ7WWf3M7GVnuv5drJTSA-1; Wed, 12 Oct 2022 01:54:25 -0400
X-MC-Unique: RDJ7WWf3M7GVnuv5drJTSA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-135ee7e13efso5988112fac.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 22:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4nlj50WPMcH7w2yz/1NnL0XsiKvj2FRcmAW5ed9ibA=;
 b=I+cq/ow+qRC5up1b0/AdhpgC+k9xiL3jhbaOGMYAOUbdi2TSK2yalV2I+8Xi1aStvW
 FE/lY5laUm4vci+CEG69u5jft+72x4t5T9eP7t+g6MBxGNbwcg0iMNux9dDuoAyZpl1c
 Yk7tR3/ToHDP+lDdjJQmVx8KvbkAqXilZAATv2YAQKYHrgGdMynq0kE6PwNhBjRaSP37
 bHYD4v0SNI2KTNkrVVCW/9BZHuRVTOafppeNPQImKCqs6DUoJJUXWbBy/HhdA0e0qE5K
 /46WI+97mhXQ5XFORCL+m45XbyyE702WxbZb0ZNtA/LHVhcIXcCsIJZQx2hC5J+BaOHk
 IcmQ==
X-Gm-Message-State: ACrzQf23DkHdNAS/lKwVpMFQ6WFVOxjQ+1y2ybdmPIHoZd3veVf8Pn2B
 eDJSW4dIc1ubTNU5wJmPRze9rXxN3fTbF4PPLFG/nKbIlhDmyOsdk3fAFdlnmDruMmAaVnmO4UE
 ZSFdDdIoyumz6Z5Izra2GMDdDCl1EBHM+KozhU3F+57E+IESEFJLk//pr8Q==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr1474559oad.35.1665554064400; 
 Tue, 11 Oct 2022 22:54:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7c9Rp6vwpqfYxPmhZD9MeI8O/wsB7Z6IHw5Y32+tnGBv7pt411ObFY6hMz5nGHkrScp4/Bqil0HgewiskCCvE=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr1474552oad.35.1665554064248; Tue, 11
 Oct 2022 22:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221012045152.223274-1-mst@redhat.com>
In-Reply-To: <20221012045152.223274-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Oct 2022 13:54:13 +0800
Message-ID: <CACGkMEv1+TqR4Jb51SmrsoZ9H9OKaF_EMbSbeJ=Mr-BcN-bpnQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifcvf: add reviewer
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, linux-kernel@vger.kernel.org,
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

On Wed, Oct 12, 2022 at 12:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Zhu Lingshan has been writing and reviewing ifcvf patches for
> a while now, add as reviewer.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d960ca4e969..531bbb0a507a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21736,6 +21736,10 @@ F:     include/linux/virtio*.h
>  F:     include/uapi/linux/virtio_*.h
>  F:     tools/virtio/
>
> +IFCVF VIRTIO DATA PATH ACCELERATOR
> +R:     Zhu Lingshan <lingshan.zhu@intel.com>
> +F:     drivers/vdpa/ifcvf/
> +
>  VIRTIO BALLOON
>  M:     "Michael S. Tsirkin" <mst@redhat.com>
>  M:     David Hildenbrand <david@redhat.com>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
