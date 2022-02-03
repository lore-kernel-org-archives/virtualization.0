Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABA2C433EF
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 13:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B92940192;
	Thu,  3 Feb 2022 13:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yOmxPRYPBfM1; Thu,  3 Feb 2022 13:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A1F340A14;
	Thu,  3 Feb 2022 13:06:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D47B3C0011;
	Thu,  3 Feb 2022 13:06:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BFD8C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56C1941678
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:06:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8G3FrBrJs5_s
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:06:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7539041672
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:06:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7E93768AFE; Thu,  3 Feb 2022 14:06:22 +0100 (CET)
Date: Thu, 3 Feb 2022 14:06:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/5] virtio_blk: simplify refcounting
Message-ID: <20220203130622.GA12361@lst.de>
References: <20220202155659.107895-1-hch@lst.de>
 <20220202155659.107895-3-hch@lst.de>
 <YfudSXcT2rNh/Jhl@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfudSXcT2rNh/Jhl@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jens Axboe <axboe@kernel.dk>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-mmc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Feb 03, 2022 at 09:15:53AM +0000, Stefan Hajnoczi wrote:
>           /* Make sure no work handler is accessing the device. */
>           flush_work(&vblk->config_work);
>   
>           del_gendisk(vblk->disk);
>           blk_cleanup_disk(vblk->disk);
> 	          ^--- is virtblk_free_disk() called here?
>           blk_mq_free_tag_set(&vblk->tag_set);
> 	                         ^--- use after free

Yeah.  We need to split up blk_cleanup_disk again for this into
separate calls to blk_cleanup_queue and put_disk..
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
