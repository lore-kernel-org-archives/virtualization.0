Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E21C001B0
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 06:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C68740A41;
	Tue, 15 Aug 2023 06:17:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C68740A41
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j9idbQM197MB; Tue, 15 Aug 2023 06:17:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16A4840126;
	Tue, 15 Aug 2023 06:17:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16A4840126
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCDD6C0072;
	Tue, 15 Aug 2023 06:17:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 637C0C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3604881332
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:17:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3604881332
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yflcsIlc5yjj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:17:49 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58E838132C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 06:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58E838132C
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R441e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0Vpqf43B_1692080260; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vpqf43B_1692080260) by smtp.aliyun-inc.com;
 Tue, 15 Aug 2023 14:17:41 +0800
Message-ID: <1692080254.2375736-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio-balloon: correct the comment of
 virtballoon_migratepage()
Date: Tue, 15 Aug 2023 14:17:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xueshi Hu <xueshi.hu@smartx.com>
References: <20230813140709.835536-1-xueshi.hu@smartx.com>
In-Reply-To: <20230813140709.835536-1-xueshi.hu@smartx.com>
Cc: mst@redhat.com, Xueshi Hu <xueshi.hu@smartx.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, 13 Aug 2023 22:07:09 +0800, Xueshi Hu <xueshi.hu@smartx.com> wrote:
> After commit 68f2736a8583 ("mm: Convert all PageMovable users to
> movable_operations"), the execution path has been changed to
>
> move_to_new_folio
> 	movable_operations->migrate_page
> 		balloon_page_migrate
> 			balloon_page_migrate->balloon_page_migrate
> 				balloon_page_migrate
>
> Correct the outdated comment.
>
> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5b15936a5214..f5aac6cf3aa9 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -741,7 +741,7 @@ static void report_free_page_func(struct work_struct *work)
>   *  2) update the host about the old page removed from vb->pages list;
>   *
>   * This function preforms the balloon page migration task.
> - * Called through balloon_mapping->a_ops->migratepage
> + * Called through movable_operations->migrate_page
>   */
>  static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  		struct page *newpage, struct page *page, enum migrate_mode mode)
> --
> 2.40.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
