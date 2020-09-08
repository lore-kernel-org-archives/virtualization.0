Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A66C43461
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 14:16:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7E7221EC
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTNQH5AJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7E7221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB74786A84;
	Tue,  8 Sep 2020 14:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2DTi90U0dVp; Tue,  8 Sep 2020 14:16:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E038A8692E;
	Tue,  8 Sep 2020 14:16:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7E58C0052;
	Tue,  8 Sep 2020 14:16:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27867C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 233528722C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7p+LFfcEnapx
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:16:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7BC2087223
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXzNpJhj5sowidUDfDEXaS6phGxQ0LavcBR8ek7/U9c=;
 b=RTNQH5AJKh+K/IEye+nxbgV13nvw+DBXA3IoAAzBuztzentplFuX4ykQnNLEi+zs9Kjdh+
 c3BKqoBkkVPVuT54kEp2Kycd3tBOLjaSIgtaYGfNPUfgb2TeTDNqCo9W+fk1UFTOJDMqWE
 XIlYsCpwD+ifBnWkEHYqVMXJTzMJD5o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-TnovlVvzO-KVQE-wP45Dfw-1; Tue, 08 Sep 2020 10:15:58 -0400
X-MC-Unique: TnovlVvzO-KVQE-wP45Dfw-1
Received: by mail-wm1-f71.google.com with SMTP id s24so3534450wmh.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Sep 2020 07:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UXzNpJhj5sowidUDfDEXaS6phGxQ0LavcBR8ek7/U9c=;
 b=GaQWOwEtKHF3JRaamJM5foobB60CA7vD20brGjqEzEiQLWy6SxhKxQhZmkTxKhHQkZ
 P73n2HIORARjEmeKXLIDChHNJX6Feqkso7CG0jy5BM8ygphGY/Ccd3adMloHIthFPAd7
 b0MDadwC7J1wqAt/YlHF+q7poQnKUUTAZMQfAedl5RqCfYWe3JkDcVfEX1G+RbtEJhCb
 qDWNiX0FVNFzFbJ445WKJdvqRJnlZZgPJXNM+9dd8BPjoDVm+Dhor4xjP+vrivtOvB5p
 s1QwsMaD1gHxb3BMASv+rBq4dN2z1odHro8DAu2ptUo/t7xB5a9JrnMqlgW8ioO0gHJG
 cE2Q==
X-Gm-Message-State: AOAM531RJPsDjfASL7T4sMpm+k2+OcZz2dbp7n8QzD2e9f92kh6vQa6p
 uYQPMiFtMaDQLAfcwHXYqF4TloaaGP4TETCQlI56V27zJ0VD/afWvC2Pg5p3hSSs8nOXuurZ0DD
 UHuNzKJlk8FLSIEK2+BQ4jJ/Ipv5dC6DCZ9jwktyniA==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr26932370wrg.100.1599574557184; 
 Tue, 08 Sep 2020 07:15:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqEKlAdEL5xW+LjUpamB0FNN2eHC7z5gQAJUS0ZT9mISMnhGZ2hx0LZial5U4dn8IDd/bz+A==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr26932354wrg.100.1599574557014; 
 Tue, 08 Sep 2020 07:15:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 a20sm30604272wmm.40.2020.09.08.07.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:15:55 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:15:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matej Genci <matej.genci@nutanix.com>
Subject: Re: [PATCH] Rescan the entire target on transport reset when LUN is 0
Message-ID: <20200908101531-mutt-send-email-mst@kernel.org>
References: <CY4PR02MB33354370E0A81E75DD9DFE74FB520@CY4PR02MB3335.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <CY4PR02MB33354370E0A81E75DD9DFE74FB520@CY4PR02MB3335.namprd02.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>
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

On Fri, Aug 28, 2020 at 12:21:35PM +0000, Matej Genci wrote:
> VirtIO 1.0 spec says
>     The removed and rescan events ... when sent for LUN 0, they MAY
>     apply to the entire target so the driver can ask the initiator
>     to rescan the target to detect this.
> 
> This change introduces the behaviour described above by scanning the
> entire scsi target when LUN is set to 0. This is both a functional and a
> performance fix. It aligns the driver with the spec and allows control
> planes to hotplug targets with large numbers of LUNs without having to
> request a RESCAN for each one of them.
> 
> Signed-off-by: Matej Genci <matej@nutanix.com>
> Suggested-by: Felipe Franciosi <felipe@nutanix.com>

Stefan, Paolo, could you review this pls?

> ---
>  drivers/scsi/virtio_scsi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bfec84aacd90..a4b9bc7b4b4a 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -284,7 +284,12 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
>  
>  	switch (virtio32_to_cpu(vscsi->vdev, event->reason)) {
>  	case VIRTIO_SCSI_EVT_RESET_RESCAN:
> -		scsi_add_device(shost, 0, target, lun);
> +		if (lun == 0) {
> +			scsi_scan_target(&shost->shost_gendev, 0, target,
> +					 SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
> +		} else {
> +			scsi_add_device(shost, 0, target, lun);
> +		}
>  		break;
>  	case VIRTIO_SCSI_EVT_RESET_REMOVED:
>  		sdev = scsi_device_lookup(shost, 0, target, lun);
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
