Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDA5C0015E
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 12:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AC9681F38;
	Mon, 24 Jul 2023 12:42:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AC9681F38
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZIw/NB6u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z2k1KDoZ1Zqv; Mon, 24 Jul 2023 12:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17C4981753;
	Mon, 24 Jul 2023 12:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17C4981753
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD2C5C0071;
	Mon, 24 Jul 2023 12:42:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B74EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 12:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21E9640C88
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 12:42:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21E9640C88
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=ZIw/NB6u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aoJ5ouVUYjRg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 12:42:12 +0000 (UTC)
X-Greylist: delayed 942 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 24 Jul 2023 12:42:12 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B4DA40C1C
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B4DA40C1C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FgtQe2iC/0NBUdTIYwU6FvaIC/2mZu3i/WpphGYT+1k=; b=ZIw/NB6uEo0641+Wq8EzNrbHBV
 rrdS2AkdlanLUW4jtuNV7YJmE8dx65rhuqNN6d+O2A+YB9l53nFIBcRLIER24dz2SZGSbQpUdfRFt
 O+SQB8u46jmJ0V3lkB2dv55l0XkOFJ2vLXAjC15/xKJogcvcsepgRzVe5Zf2VfboPt9BBV/mRWBu/
 r1HeDooSZKO8KrM91YanEuhJbHVgQEIeOAYvY50OE9Oa0XF31R7B/jnZvsmScHku30xY6VnjseHTr
 PXjdkkROSxxW+REohqgqj+xc5EAtZBuKqFbmv/xo9QoVvk4ORWEH1k1N/to1rfbfNrbjLNy69S5M/
 AYY+hq7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qNudM-004Ned-Mr; Mon, 24 Jul 2023 12:25:53 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0440300195;
 Mon, 24 Jul 2023 14:25:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5C178266885CD; Mon, 24 Jul 2023 14:25:49 +0200 (CEST)
Date: Mon, 24 Jul 2023 14:25:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 03/47] mm: shrinker: add infrastructure for
 dynamically allocating shrinker
Message-ID: <20230724122549.GA3731903@hirez.programming.kicks-ass.net>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-4-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230724094354.90817-4-zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev,
 david@fromorbit.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org,
 x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org,
 linux-bcache@vger.kernel.org, yujie.liu@intel.com, vbabka@suse.cz,
 linux-raid@vger.kernel.org, brauner@kernel.org, tytso@mit.edu,
 gregkh@linuxfoundation.org, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
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

On Mon, Jul 24, 2023 at 05:43:10PM +0800, Qi Zheng wrote:

> +void shrinker_unregister(struct shrinker *shrinker)
> +{
> +	struct dentry *debugfs_entry;
> +	int debugfs_id;
> +
> +	if (!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))
> +		return;
> +
> +	down_write(&shrinker_rwsem);
> +	list_del(&shrinker->list);
> +	shrinker->flags &= ~SHRINKER_REGISTERED;
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);
> +	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
> +	up_write(&shrinker_rwsem);
> +
> +	shrinker_debugfs_remove(debugfs_entry, debugfs_id);

Should there not be an rcu_barrier() right about here?

> +
> +	kfree(shrinker->nr_deferred);
> +	shrinker->nr_deferred = NULL;
> +
> +	kfree(shrinker);
> +}
> +EXPORT_SYMBOL(shrinker_unregister);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
