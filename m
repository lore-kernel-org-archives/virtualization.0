Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF1C433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 11:28:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0947222B3
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 11:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0947222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2F77F8558A;
	Mon, 18 Jan 2021 11:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8iaWw0ncDgO; Mon, 18 Jan 2021 11:28:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D6D485535;
	Mon, 18 Jan 2021 11:28:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80475C08A1;
	Mon, 18 Jan 2021 11:28:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 398B3C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2AAD28667D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfrI3Sxlf0Fs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:28:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C78AF8667A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610969283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfkKudYaZlqmuF0tL9e4J/Hz3n8hnZrxD3cO+HhHt7c=;
 b=W4OgQLaI6tfMdqwg5mv6ARmwxiI+ezp58HE0EMvahtX20vJKKeat7DiXkRN+iBXNRKofcR
 Bucz1gxoqFDxdZM1NmB+483g9AJOmb2kMCWqdXUncWED9BvfMwKgII2Xl8wnBHw3k9I+Pc
 ap34ZCAhPYko+hijKt4BWz8SE72FqmI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-255EEfNoOQeU0tlrDcoS1w-1; Mon, 18 Jan 2021 06:28:00 -0500
X-MC-Unique: 255EEfNoOQeU0tlrDcoS1w-1
Received: by mail-wr1-f69.google.com with SMTP id g17so8123701wrr.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 03:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GfkKudYaZlqmuF0tL9e4J/Hz3n8hnZrxD3cO+HhHt7c=;
 b=SeX6bXlrva0vaJXqT19MxesiylGfzSGr7Bk+zNsqbIUnMu/HsOIw7HRnh1NEpZxJid
 IjuGd1ScHUCwsBpdft2mQ1KFKh7BZslBfUSfK99HI+dHBZPypFyaexdJ9edLB1FnZp/t
 OHANDa3eiMMeIjIW2iBZQomi9+y1bxMXb9O73/Pbh5Nyr6ZFIlBUbtbBh9ECD8F4HcKk
 5p+qEySLE3n90qw6yoPjRWHYxmtH9+1NrariurKz3OVLqzwTvH2/UZ9QcovECGjlnJH+
 AVn3OM2L5x/oRO7KNjlQnmMjo5qVOZ6t0sJonB5cf8wL9uUtms8yJ52PabSQMxDIFmgJ
 OX6g==
X-Gm-Message-State: AOAM530ApoO2wpyab6KcPmrLlRPxgQM8iEcTfD0yqJz7LmhtDYd57fdR
 7YWEzs6kQlYAdzLYgz7YUPLFLGXHfTWtG5OMySR2vvJi9txiRVrKgjkJ581OLGnRujrkkx4/Sd+
 UZ4suQee+yptu7WcC/gBdy4xDEgeGlTC+kRYxemMQ1A==
X-Received: by 2002:adf:b1da:: with SMTP id r26mr21560889wra.198.1610969279348; 
 Mon, 18 Jan 2021 03:27:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXJ0k/cNJfD975QGqeq3Um6f+ympUYuBPRRl5bHpD0GmnEEsYtRLTxC5yL4qC2rX3vGpo1WA==
X-Received: by 2002:adf:b1da:: with SMTP id r26mr21560869wra.198.1610969279157; 
 Mon, 18 Jan 2021 03:27:59 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o14sm25518146wmc.28.2021.01.18.03.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 03:27:58 -0800 (PST)
Date: Mon, 18 Jan 2021 12:27:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH] VMCI: Enforce queuepair max size for
 IOCTL_VMCI_QUEUEPAIR_ALLOC
Message-ID: <20210118112756.ekfebcbyqwz4dd4b@steredhat>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
In-Reply-To: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

+Cc: Norbert Slusarek <nslusarek@gmx.net>

On Mon, Jan 11, 2021 at 04:18:53AM -0800, Jorgen Hansen wrote:
>When create the VMCI queue pair tracking data structures on the host
>side, the IOCTL for creating the VMCI queue pair didn't validate
>the queue pair size parameters. This change adds checks for this.
>
>This avoids a memory allocation issue in qp_host_alloc_queue, as
>reported by nslusarek@gmx.net. The check in qp_host_alloc_queue
>has also been updated to enforce the maximum queue pair size
>as defined by VMCI_MAX_GUEST_QP_MEMORY.
>
>The fix has been verified using sample code supplied by
>nslusarek@gmx.net.
>
>Reported-by: nslusarek@gmx.net
>Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
>Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
>---
> drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++++----
> include/linux/vmw_vmci_defs.h           |  4 ++--
> 2 files changed, 10 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
>index 525ef96..39d2f191 100644
>--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
>+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
>@@ -237,7 +237,9 @@ static struct qp_list qp_guest_endpoints = {
> #define QPE_NUM_PAGES(_QPE) ((u32) \
> 			     (DIV_ROUND_UP(_QPE.produce_size, PAGE_SIZE) + \
> 			      DIV_ROUND_UP(_QPE.consume_size, PAGE_SIZE) + 2))
>-
>+#define QP_SIZES_ARE_VALID(_prod_qsize, _cons_qsize) \
>+	((_prod_qsize) + (_cons_qsize) >= max(_prod_qsize, _cons_qsize) && \
>+	 (_prod_qsize) + (_cons_qsize) <= VMCI_MAX_GUEST_QP_MEMORY)
>
> /*
>  * Frees kernel VA space for a given queue and its queue header, and
>@@ -528,7 +530,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
> 	u64 num_pages;
> 	const size_t queue_size = sizeof(*queue) + sizeof(*(queue->kernel_if));
>
>-	if (size > SIZE_MAX - PAGE_SIZE)
>+	if (size > min(VMCI_MAX_GUEST_QP_MEMORY, SIZE_MAX - PAGE_SIZE))
> 		return NULL;
> 	num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
> 	if (num_pages > (SIZE_MAX - queue_size) /
>@@ -1929,6 +1931,9 @@ int vmci_qp_broker_alloc(struct vmci_handle handle,
> 			 struct vmci_qp_page_store *page_store,
> 			 struct vmci_ctx *context)
> {
>+	if (!QP_SIZES_ARE_VALID(produce_size, consume_size))
>+		return VMCI_ERROR_NO_RESOURCES;
>+
> 	return qp_broker_alloc(handle, peer, flags, priv_flags,
> 			       produce_size, consume_size,
> 			       page_store, context, NULL, NULL, NULL, NULL);
>@@ -2685,8 +2690,7 @@ int vmci_qpair_alloc(struct vmci_qp **qpair,
> 	 * used by the device is NO_RESOURCES, so use that here too.
> 	 */
>
>-	if (produce_qsize + consume_qsize < max(produce_qsize, consume_qsize) ||
>-	    produce_qsize + consume_qsize > VMCI_MAX_GUEST_QP_MEMORY)
>+	if (!QP_SIZES_ARE_VALID(produce_qsize, consume_qsize))
> 		return VMCI_ERROR_NO_RESOURCES;
>
> 	retval = vmci_route(&src, &dst, false, &route);
>diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
>index be0afe6..e36cb11 100644
>--- a/include/linux/vmw_vmci_defs.h
>+++ b/include/linux/vmw_vmci_defs.h
>@@ -66,7 +66,7 @@ enum {
>  * consists of at least two pages, the memory limit also dictates the
>  * number of queue pairs a guest can create.
>  */
>-#define VMCI_MAX_GUEST_QP_MEMORY (128 * 1024 * 1024)
>+#define VMCI_MAX_GUEST_QP_MEMORY ((size_t)(128 * 1024 * 1024))
> #define VMCI_MAX_GUEST_QP_COUNT  (VMCI_MAX_GUEST_QP_MEMORY / PAGE_SIZE / 2)
>
> /*
>@@ -80,7 +80,7 @@ enum {
>  * too much kernel memory (especially on vmkernel).  We limit a queuepair to
>  * 32 KB, or 16 KB per queue for symmetrical pairs.
>  */
>-#define VMCI_MAX_PINNED_QP_MEMORY (32 * 1024)
>+#define VMCI_MAX_PINNED_QP_MEMORY ((size_t)(32 * 1024))
>
> /*
>  * We have a fixed set of resource IDs available in the VMX.
>-- 
>2.6.2
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
