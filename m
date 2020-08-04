Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EC5C433E1
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B7F2073E
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuwbclcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B7F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F01FC204C0;
	Tue,  4 Aug 2020 06:01:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mxEtBBs+X-LI; Tue,  4 Aug 2020 06:01:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4DE0420424;
	Tue,  4 Aug 2020 06:01:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C64EC0050;
	Tue,  4 Aug 2020 06:01:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D66CC004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 06:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EE53885BD0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 06:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0oqA9O0qgBCp
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 06:01:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 208BD85B5B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 06:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596520908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iCL1Xp60PBWuivH0HthdQ2JVXbrP96B1PBURhwN7M+g=;
 b=MuwbclcKAh9etyC2S+l3GYG6Y0iicPHFt0j/KgV+OuTmw1SXvZkHrT4dSTbHSrUzeWTENE
 RrWh6VbGrxRrxD543YzlLfXKQ7j+ZDdiS599T+zW9zgHC7zPdtg6kkhkty8Y1n+G6ZuMb3
 GcaiyA248q/TAsnT2iMwwk5M9cWZ9Hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Mt-GLynOPTW0Da43TrKIng-1; Tue, 04 Aug 2020 02:01:46 -0400
X-MC-Unique: Mt-GLynOPTW0Da43TrKIng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC42C100A8C0;
 Tue,  4 Aug 2020 06:01:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B80B45C1BD;
 Tue,  4 Aug 2020 06:01:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A2D4311AB5; Tue,  4 Aug 2020 08:01:41 +0200 (CEST)
Date: Tue, 4 Aug 2020 08:01:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 11/24] virtio_input: correct tags for config space
 fields
Message-ID: <20200804060141.nhxsxs57oi576mzw@sirius.home.kraxel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-12-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-12-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Aug 03, 2020 at 04:59:23PM -0400, Michael S. Tsirkin wrote:
> Since this is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_input.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_input.h b/include/uapi/linux/virtio_input.h
> index a7fe5c8fb135..52084b1fb965 100644
> --- a/include/uapi/linux/virtio_input.h
> +++ b/include/uapi/linux/virtio_input.h
> @@ -40,18 +40,18 @@ enum virtio_input_config_select {
>  };
>  
>  struct virtio_input_absinfo {
> -	__u32 min;
> -	__u32 max;
> -	__u32 fuzz;
> -	__u32 flat;
> -	__u32 res;
> +	__le32 min;
> +	__le32 max;
> +	__le32 fuzz;
> +	__le32 flat;
> +	__le32 res;
>  };
>  
>  struct virtio_input_devids {
> -	__u16 bustype;
> -	__u16 vendor;
> -	__u16 product;
> -	__u16 version;
> +	__le16 bustype;
> +	__le16 vendor;
> +	__le16 product;
> +	__le16 version;
>  };
>  
>  struct virtio_input_config {
> -- 
> MST

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
