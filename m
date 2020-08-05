Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E80C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 14:24:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0AE2312D
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+4TaoHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0AE2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 440EF86214;
	Wed,  5 Aug 2020 14:24:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id trL258b6U2sY; Wed,  5 Aug 2020 14:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2268585C56;
	Wed,  5 Aug 2020 14:24:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09A99C0050;
	Wed,  5 Aug 2020 14:24:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D929C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9197487E9C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:24:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsg8dDyU-EiO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:24:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D16F187C0C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596637466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJk+gBSUOEE3QpuiYByxtg4+dvbr5r/Pq6TTI3Asc18=;
 b=L+4TaoHCSGRS1b8IfXRc2hDSSgdIl2iyTxzIZ98/jurtyQ5yzRWsl73AklqIE6oSccBOcv
 bb/IUrN+adsfgiaPk5zH9wSHbkaX77vAw/YZnMpVWH25Xu1AgDRSdKAHzcsJtH5iAHbZZ6
 uLnszk7BeloP0N1332wmAQtjwSVDlGc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-8Bk5R-JRM8S0c3HHn691FA-1; Wed, 05 Aug 2020 10:24:22 -0400
X-MC-Unique: 8Bk5R-JRM8S0c3HHn691FA-1
Received: by mail-wr1-f70.google.com with SMTP id j2so11061908wrr.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 07:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NJk+gBSUOEE3QpuiYByxtg4+dvbr5r/Pq6TTI3Asc18=;
 b=XKGB0POtC7u92aGdQMpDmUkwF4ylOGPO7qnhgetgIb4R3HpaoEmlmvpz/pIEwjA23o
 JU13h6NDamGRwCJdAgdTXWjhLkXsGLmm/lv5y+pNeKeT4RqtFpdOjGH1rPm4Jz8YqXPf
 daJZR+SJZp2tRwffPR51rVCYwWxzuZ5GcSIAxSsfoi3MKtjfIbo613JrnidmXd4pYat1
 ht8QT8z4IXaPk8K72GSiAcUB79h/azQzoMS9XXcbt6F/FNg1JdaV43mku0w+DXXKfpY7
 gVgltwluPxQl6uxvo6Vh1cke1nrZP3hiBA6odJkL4rzmz263ppeqL6F8SqZC+I0eQun9
 E8zA==
X-Gm-Message-State: AOAM531Yu5JqZ71tUccLK0/Fr131j8bm9Ogz6iJ0LZINCwDKzYPB19YJ
 4g0GG8fDXWI2lxleJbIGGn/9DW96Or5Z/Hbps3g41wn1mKf6JZSjxk+PPA/pymJUF2nwquno+kr
 llsmgpSEEFEUGuJ1B0TPg6jrZVULt7MH5IDmTwe4jRg==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr3577307wmd.143.1596637461351; 
 Wed, 05 Aug 2020 07:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxykd/6TYQBVQob6vYx2bOO/iHZmxM2Bk8CCL9fbpMhS8zjTz+5shlJ5og3sBNrgt6khAQqMA==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr3577290wmd.143.1596637461088; 
 Wed, 05 Aug 2020 07:24:21 -0700 (PDT)
Received: from steredhat ([5.171.198.65])
 by smtp.gmail.com with ESMTPSA id x11sm2840060wmc.33.2020.08.05.07.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 07:24:20 -0700 (PDT)
Date: Wed, 5 Aug 2020 16:24:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 06/38] virtio_blk: correct tags for config space fields
Message-ID: <20200805142415.sqx7saezivvcolkt@steredhat>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-7-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-7-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
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

On Wed, Aug 05, 2020 at 09:43:30AM -0400, Michael S. Tsirkin wrote:
> Tag config space fields as having virtio endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/uapi/linux/virtio_blk.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> 
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 0f99d7b49ede..d888f013d9ff 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -57,20 +57,20 @@
>  
>  struct virtio_blk_config {
>  	/* The capacity (in 512-byte sectors). */
> -	__u64 capacity;
> +	__virtio64 capacity;
>  	/* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
> -	__u32 size_max;
> +	__virtio32 size_max;
>  	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
> -	__u32 seg_max;
> +	__virtio32 seg_max;
>  	/* geometry of the device (if VIRTIO_BLK_F_GEOMETRY) */
>  	struct virtio_blk_geometry {
> -		__u16 cylinders;
> +		__virtio16 cylinders;
>  		__u8 heads;
>  		__u8 sectors;
>  	} geometry;
>  
>  	/* block size of device (if VIRTIO_BLK_F_BLK_SIZE) */
> -	__u32 blk_size;
> +	__virtio32 blk_size;
>  
>  	/* the next 4 entries are guarded by VIRTIO_BLK_F_TOPOLOGY  */
>  	/* exponent for physical block per logical block. */
> @@ -78,42 +78,42 @@ struct virtio_blk_config {
>  	/* alignment offset in logical blocks. */
>  	__u8 alignment_offset;
>  	/* minimum I/O size without performance penalty in logical blocks. */
> -	__u16 min_io_size;
> +	__virtio16 min_io_size;
>  	/* optimal sustained I/O size in logical blocks. */
> -	__u32 opt_io_size;
> +	__virtio32 opt_io_size;
>  
>  	/* writeback mode (if VIRTIO_BLK_F_CONFIG_WCE) */
>  	__u8 wce;
>  	__u8 unused;
>  
>  	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
> -	__u16 num_queues;
> +	__virtio16 num_queues;
>  
>  	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
>  	/*
>  	 * The maximum discard sectors (in 512-byte sectors) for
>  	 * one segment.
>  	 */
> -	__u32 max_discard_sectors;
> +	__virtio32 max_discard_sectors;
>  	/*
>  	 * The maximum number of discard segments in a
>  	 * discard command.
>  	 */
> -	__u32 max_discard_seg;
> +	__virtio32 max_discard_seg;
>  	/* Discard commands must be aligned to this number of sectors. */
> -	__u32 discard_sector_alignment;
> +	__virtio32 discard_sector_alignment;
>  
>  	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
>  	/*
>  	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
>  	 * one segment.
>  	 */
> -	__u32 max_write_zeroes_sectors;
> +	__virtio32 max_write_zeroes_sectors;
>  	/*
>  	 * The maximum number of segments in a write zeroes
>  	 * command.
>  	 */
> -	__u32 max_write_zeroes_seg;
> +	__virtio32 max_write_zeroes_seg;
>  	/*
>  	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
>  	 * deallocation of one or more of the sectors.
> -- 
> MST
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
