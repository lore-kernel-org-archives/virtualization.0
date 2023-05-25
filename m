Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5210C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 07:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5620A83D13;
	Thu, 25 May 2023 07:58:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5620A83D13
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L1N84/wX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PGJjZvSh4U2N; Thu, 25 May 2023 07:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57ABA83D10;
	Thu, 25 May 2023 07:58:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57ABA83D10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27DDCC0035;
	Thu, 25 May 2023 07:58:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67D34C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BF36402A6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:58:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BF36402A6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L1N84/wX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rjWDlGCzUUP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:58:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F31342575
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F31342575
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685001489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MhuDpYug9nQtTBkx3yBfGEnCnjBO/H2Ca4eqWqXaFzc=;
 b=L1N84/wXNAURb+K32AXe+O4qvufkcNNHMwpTblbyA30xj3d3DWccGCH240wXrGd5xukkYl
 HgmDMaruvq5h3xEM5TxBIC6wDpClXGydM8I0jeZxtHfsjzF9fj0q1FXEtBIKfixuYZQCqT
 JtlFaFdymUin0uxSqfA3+yMdjhhLxdo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-luTE1HOfNPi4nAuaXH5aZg-1; Thu, 25 May 2023 03:58:07 -0400
X-MC-Unique: luTE1HOfNPi4nAuaXH5aZg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f7f713eeb0so13806781cf.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 00:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685001487; x=1687593487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhuDpYug9nQtTBkx3yBfGEnCnjBO/H2Ca4eqWqXaFzc=;
 b=a8A/MRygs1MegLJvnDnompnTvDiK+hoRZbuWzUoMDWt/RnhAC/Rc7G881Y602XkpUz
 /Pr4Rp8GJOJeAzgYXAlQHbwkS4uaYtMJGL7gK5XUqwln3qdpOt57yrk25GGc55BE684R
 WdKqognWwyqRyDxCCyOwcCtFB67OZm1nSEdKuxDpzDIXcRlYQQewmfT6iQ9lngZnDVyy
 DM0+05DKfZf60OBOKigX74Up/m96li9S22DGGa1thhuxA9rXODTC10Z+Yy7O9dVCjlRr
 dTy33LV70qtVgccYzUMTHzoomFl5Tba0odWmJrmbNOETzHwDXXIeqXSzd47OWZXF01rV
 kXww==
X-Gm-Message-State: AC+VfDwEPb5UuZ5+6RmCJ+NHSdP2SMs3xdDyg50IwlNMlp/+I188lL2d
 5YLzmF+rPMngiKyr6XjtWTFvaIUcIXfkvRUfgiDKaDzJRVXlacYXtz1I+YaSf3/SYS4N7bahW2r
 q6w2HBbtYo02298gaA3Z2Ps4T192JunYGxC0zae9zf5r/5Wvm5TNq
X-Received: by 2002:ac8:57d6:0:b0:3f6:a92e:7f47 with SMTP id
 w22-20020ac857d6000000b003f6a92e7f47mr18728612qta.13.1685001486831; 
 Thu, 25 May 2023 00:58:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sqMrQXIubKqyzU0f/l+R+wvCBJOZr6nSDlFejOgZrhHWOZ8NGIH0gF+Ve/tXV2hUc1CN18w==
X-Received: by 2002:ac8:57d6:0:b0:3f6:a92e:7f47 with SMTP id
 w22-20020ac857d6000000b003f6a92e7f47mr18728596qta.13.1685001486469; 
 Thu, 25 May 2023 00:58:06 -0700 (PDT)
Received: from redhat.com ([191.101.160.247]) by smtp.gmail.com with ESMTPSA id
 h12-20020ac8138c000000b003f0a79e6a8bsm218174qtj.28.2023.05.25.00.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:58:05 -0700 (PDT)
Date: Thu, 25 May 2023 03:57:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/3] vhost-scsi: Fix alignment handling with windows
Message-ID: <20230525034741-mutt-send-email-mst@kernel.org>
References: <20230524233407.41432-1-michael.christie@oracle.com>
 <20230524233407.41432-2-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230524233407.41432-2-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com
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

On Wed, May 24, 2023 at 06:34:05PM -0500, Mike Christie wrote:
> The linux block layer requires bios/requests to have lengths with a 512
> byte alignment. Some drivers/layers like dm-crypt and the directi IO code
> will test for it and just fail. Other drivers like SCSI just assume the
> requirement is met and will end up in infinte retry loops. The problem
> for drivers like SCSI is that it uses functions like blk_rq_cur_sectors
> and blk_rq_sectors which divide the request's length by 512. If there's
> lefovers then it just gets dropped. But other code in the block/scsi
> layer may use blk_rq_bytes/blk_rq_cur_bytes and end up thinking there is
> still data left and try to retry the cmd. We can then end up getting
> stuck in retry loops where part of the block/scsi thinks there is data
> left, but other parts think we want to do IOs of zero length.
> 
> Linux will always check for alignment, but windows will not. When
> vhost-scsi then translates the iovec it gets from a windows guest to a
> scatterlist, we can end up with sg items where the sg->length is not
> divisible by 512 due to the misaligned offset:
> 
> sg[0].offset = 255;
> sg[0].length = 3841;
> sg...
> sg[N].offset = 0;
> sg[N].length = 255;
> 
> When the lio backends then convert the SG to bios or other iovecs, we
> end up sending them with the same misaligned values and can hit the
> issues above.
> 
> This just has us drop down to allocating a temp page and copying the data
> when this happens. Because this adds a check that needs to loop over the
> iovec in the main IO path, this patch adds an attribute that can be turned
> on for just windows.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

I am assuming this triggers rarely, yes?

If so I would like to find a way to avoid setting an attribute.

I am guessing the main cost is an extra scan of iov.
vhost_scsi_iov_to_sgl already does a scan, how about changing
it to fail if misaligned?
We can then detect the relevant error code and try with a copy.

WDYT?

> ---
>  drivers/vhost/scsi.c | 174 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 151 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index bb10fa4bb4f6..dbad8fb579eb 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -25,6 +25,8 @@
>  #include <linux/fs.h>
>  #include <linux/vmalloc.h>
>  #include <linux/miscdevice.h>
> +#include <linux/blk_types.h>
> +#include <linux/bio.h>
>  #include <asm/unaligned.h>
>  #include <scsi/scsi_common.h>
>  #include <scsi/scsi_proto.h>
> @@ -75,6 +77,9 @@ struct vhost_scsi_cmd {
>  	u32 tvc_prot_sgl_count;
>  	/* Saved unpacked SCSI LUN for vhost_scsi_target_queue_cmd() */
>  	u32 tvc_lun;
> +	u32 copied_iov:1;
> +	const void *saved_iter_addr;
> +	struct iov_iter saved_iter;
>  	/* Pointer to the SGL formatted memory from virtio-scsi */
>  	struct scatterlist *tvc_sgl;
>  	struct scatterlist *tvc_prot_sgl;
> @@ -107,6 +112,7 @@ struct vhost_scsi_nexus {
>  struct vhost_scsi_tpg {
>  	/* Vhost port target portal group tag for TCM */
>  	u16 tport_tpgt;
> +	bool check_io_alignment;
>  	/* Used to track number of TPG Port/Lun Links wrt to explict I_T Nexus shutdown */
>  	int tv_tpg_port_count;
>  	/* Used for vhost_scsi device reference to tpg_nexus, protected by tv_tpg_mutex */
> @@ -328,8 +334,13 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
>  	int i;
>  
>  	if (tv_cmd->tvc_sgl_count) {
> -		for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
> -			put_page(sg_page(&tv_cmd->tvc_sgl[i]));
> +		for (i = 0; i < tv_cmd->tvc_sgl_count; i++) {
> +			if (tv_cmd->copied_iov)
> +				__free_page(sg_page(&tv_cmd->tvc_sgl[i]));
> +			else
> +				put_page(sg_page(&tv_cmd->tvc_sgl[i]));
> +		}
> +		kfree(tv_cmd->saved_iter_addr);
>  	}
>  	if (tv_cmd->tvc_prot_sgl_count) {
>  		for (i = 0; i < tv_cmd->tvc_prot_sgl_count; i++)
> @@ -502,6 +513,27 @@ static void vhost_scsi_evt_work(struct vhost_work *work)
>  	mutex_unlock(&vq->mutex);
>  }
>  
> +static int vhost_scsi_copy_sgl_to_iov(struct vhost_scsi_cmd *cmd)
> +{
> +	struct iov_iter *iter = &cmd->saved_iter;
> +	struct scatterlist *sg = cmd->tvc_sgl;
> +	struct page *page;
> +	size_t len;
> +	int i;
> +
> +	for (i = 0; i < cmd->tvc_sgl_count; i++) {
> +		page = sg_page(&sg[i]);
> +		len = sg[i].length;
> +
> +		if (copy_page_to_iter(page, 0, len, iter) != len) {
> +			pr_err("Could not copy data. Error %lu\n", len);
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /* Fill in status and signal that we are done processing this command
>   *
>   * This is scheduled in the vhost work queue so we are called with the owner
> @@ -525,15 +557,20 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  
>  		pr_debug("%s tv_cmd %p resid %u status %#02x\n", __func__,
>  			cmd, se_cmd->residual_count, se_cmd->scsi_status);
> -
>  		memset(&v_rsp, 0, sizeof(v_rsp));
> -		v_rsp.resid = cpu_to_vhost32(cmd->tvc_vq, se_cmd->residual_count);
> -		/* TODO is status_qualifier field needed? */
> -		v_rsp.status = se_cmd->scsi_status;
> -		v_rsp.sense_len = cpu_to_vhost32(cmd->tvc_vq,
> -						 se_cmd->scsi_sense_length);
> -		memcpy(v_rsp.sense, cmd->tvc_sense_buf,
> -		       se_cmd->scsi_sense_length);
> +
> +		if (cmd->saved_iter_addr && vhost_scsi_copy_sgl_to_iov(cmd)) {
> +			v_rsp.response = VIRTIO_SCSI_S_BAD_TARGET;
> +		} else {
> +			v_rsp.resid = cpu_to_vhost32(cmd->tvc_vq,
> +						     se_cmd->residual_count);
> +			/* TODO is status_qualifier field needed? */
> +			v_rsp.status = se_cmd->scsi_status;
> +			v_rsp.sense_len = cpu_to_vhost32(cmd->tvc_vq,
> +							 se_cmd->scsi_sense_length);
> +			memcpy(v_rsp.sense, cmd->tvc_sense_buf,
> +			       se_cmd->scsi_sense_length);
> +		}
>  
>  		iov_iter_init(&iov_iter, ITER_DEST, cmd->tvc_resp_iov,
>  			      cmd->tvc_in_iovs, sizeof(v_rsp));
> @@ -682,7 +719,52 @@ vhost_scsi_iov_to_sgl(struct vhost_scsi_cmd *cmd, bool write,
>  }
>  
>  static int
> -vhost_scsi_mapal(struct vhost_scsi_cmd *cmd,
> +vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
> +			   struct scatterlist *sg, int sg_count)
> +{
> +	size_t len = iov_iter_count(iter);
> +	unsigned int nbytes = 0;
> +	struct page *page;
> +	int i;
> +
> +	if (cmd->tvc_data_direction == DMA_FROM_DEVICE) {
> +		cmd->saved_iter_addr = dup_iter(&cmd->saved_iter, iter,
> +						GFP_KERNEL);
> +		if (!cmd->saved_iter_addr)
> +			return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < sg_count; i++) {
> +		page = alloc_page(GFP_KERNEL);
> +		if (!page) {
> +			i--;
> +			goto err;
> +		}
> +
> +		nbytes = min_t(unsigned int, PAGE_SIZE, len);
> +		sg_set_page(&sg[i], page, nbytes, 0);
> +
> +		if (cmd->tvc_data_direction == DMA_TO_DEVICE &&
> +		    copy_page_from_iter(page, 0, nbytes, iter) != nbytes)
> +			goto err;
> +
> +		len -= nbytes;
> +	}
> +
> +	cmd->copied_iov = 1;
> +	return 0;
> +
> +err:
> +	pr_err("Could not read %u bytes\n", nbytes);
> +
> +	for (; i >= 0; i--)
> +		__free_page(sg_page(&sg[i]));
> +	kfree(cmd->saved_iter_addr);
> +	return -ENOMEM;
> +}
> +
> +static int
> +vhost_scsi_mapal(struct vhost_scsi_tpg *tpg, struct vhost_scsi_cmd *cmd,
>  		 size_t prot_bytes, struct iov_iter *prot_iter,
>  		 size_t data_bytes, struct iov_iter *data_iter)
>  {
> @@ -703,10 +785,8 @@ vhost_scsi_mapal(struct vhost_scsi_cmd *cmd,
>  		ret = vhost_scsi_iov_to_sgl(cmd, write, prot_iter,
>  					    cmd->tvc_prot_sgl,
>  					    cmd->tvc_prot_sgl_count);
> -		if (ret < 0) {
> -			cmd->tvc_prot_sgl_count = 0;
> -			return ret;
> -		}
> +		if (ret < 0)
> +			goto map_fail;
>  	}
>  	sgl_count = vhost_scsi_calc_sgls(data_iter, data_bytes,
>  					 VHOST_SCSI_PREALLOC_SGLS);
> @@ -717,14 +797,32 @@ vhost_scsi_mapal(struct vhost_scsi_cmd *cmd,
>  	cmd->tvc_sgl_count = sgl_count;
>  	pr_debug("%s data_sg %p data_sgl_count %u\n", __func__,
>  		  cmd->tvc_sgl, cmd->tvc_sgl_count);
> +	/*
> +	 * The block layer requires bios/requests to be a multiple of 512 bytes,
> +	 * but Windows can send us vecs that are misaligned. This can result
> +	 * in bios and later requests with misaligned sizes if we have to break
> +	 * up a cmd into multiple bios.
> +	 *
> +	 * We currently only break up a command into multiple bios if we hit
> +	 * the vec/seg limit, so check if our sgl_count is greater than the max
> +	 * and if a vec in the cmd has a misaligned size.
> +	 */
> +	if (tpg->check_io_alignment &&
> +	    (!iov_iter_is_aligned(data_iter, 0, SECTOR_SIZE - 1) &&
> +	     bio_max_segs(sgl_count) != sgl_count))
> +		ret = vhost_scsi_copy_iov_to_sgl(cmd, data_iter, cmd->tvc_sgl,
> +						 cmd->tvc_sgl_count);
> +	else
> +		ret = vhost_scsi_iov_to_sgl(cmd, write, data_iter,
> +					    cmd->tvc_sgl, cmd->tvc_sgl_count);
> +	if (ret)
> +		goto map_fail;
>  
> -	ret = vhost_scsi_iov_to_sgl(cmd, write, data_iter,
> -				    cmd->tvc_sgl, cmd->tvc_sgl_count);
> -	if (ret < 0) {
> -		cmd->tvc_sgl_count = 0;
> -		return ret;
> -	}
>  	return 0;
> +
> +map_fail:
> +	cmd->tvc_sgl_count = 0;
> +	return ret;
>  }
>  
>  static int vhost_scsi_to_tcm_attr(int attr)
> @@ -1077,7 +1175,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>  			 " %d\n", cmd, exp_data_len, prot_bytes, data_direction);
>  
>  		if (data_direction != DMA_NONE) {
> -			if (unlikely(vhost_scsi_mapal(cmd, prot_bytes,
> +			if (unlikely(vhost_scsi_mapal(tpg, cmd, prot_bytes,
>  						      &prot_iter, exp_data_len,
>  						      &data_iter))) {
>  				vq_err(vq, "Failed to map iov to sgl\n");
> @@ -2068,11 +2166,41 @@ static ssize_t vhost_scsi_tpg_attrib_fabric_prot_type_show(
>  
>  	return sysfs_emit(page, "%d\n", tpg->tv_fabric_prot_type);
>  }
> -
>  CONFIGFS_ATTR(vhost_scsi_tpg_attrib_, fabric_prot_type);
>  
> +static ssize_t
> +vhost_scsi_tpg_attrib_check_io_alignment_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct se_portal_group *se_tpg = attrib_to_tpg(item);
> +	struct vhost_scsi_tpg *tpg = container_of(se_tpg, struct vhost_scsi_tpg,
> +						  se_tpg);
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(page, &val);
> +	if (ret)
> +		return ret;
> +
> +	tpg->check_io_alignment = val;
> +	return count;
> +}
> +
> +static ssize_t
> +vhost_scsi_tpg_attrib_check_io_alignment_show(struct config_item *item,
> +					      char *page)
> +{
> +	struct se_portal_group *se_tpg = attrib_to_tpg(item);
> +	struct vhost_scsi_tpg *tpg = container_of(se_tpg, struct vhost_scsi_tpg,
> +						  se_tpg);
> +
> +	return sysfs_emit(page, "%d\n", tpg->check_io_alignment);
> +}
> +CONFIGFS_ATTR(vhost_scsi_tpg_attrib_, check_io_alignment);
> +
>  static struct configfs_attribute *vhost_scsi_tpg_attrib_attrs[] = {
>  	&vhost_scsi_tpg_attrib_attr_fabric_prot_type,
> +	&vhost_scsi_tpg_attrib_attr_check_io_alignment,
>  	NULL,
>  };
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
