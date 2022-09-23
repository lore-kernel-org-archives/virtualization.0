Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0321C6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 14:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28494813C0;
	Fri, 23 Sep 2022 14:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28494813C0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2eQy8M9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IdkUeggrIOWl; Fri, 23 Sep 2022 14:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 684A6812DE;
	Fri, 23 Sep 2022 14:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 684A6812DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F439C0033;
	Fri, 23 Sep 2022 14:23:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22682C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E24D040082
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E24D040082
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2eQy8M9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLtg-PFg9-0Q
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C19D240114
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C19D240114
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663943008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MtMta5sZ7F8zj2gNZ2FUjMLqWdc2TCa8gGZwFvL5igI=;
 b=N2eQy8M9WK0KndyPz7YJIe9AhbZ/9B0/GpeRNPAOzOxMnt1IjGo9vnui+5SSwRrJ+j8BHr
 A88SwCWyibMLYuAcY+GTh0iKSkdlG0zACcUeQHZVmmSo8xQOfFgnO724AcCR92ZhrKpDKp
 prnGSPEx/6D2XS8/fwvndYbR7Xw+3qk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-q9TNeSgnOh60W__ISIDRng-1; Fri, 23 Sep 2022 10:23:27 -0400
X-MC-Unique: q9TNeSgnOh60W__ISIDRng-1
Received: by mail-qv1-f69.google.com with SMTP id
 q5-20020a056214194500b004a03466c568so8653943qvk.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=MtMta5sZ7F8zj2gNZ2FUjMLqWdc2TCa8gGZwFvL5igI=;
 b=639IVw8wivsGrp5o/JcZwBAQOl3A2U9Jh5Gx4UgBLg3RNyqnlluefeu0UDrPzjCWKw
 dAOuA934oY1blF5h6q/vINsgFZjG9XUjyNo4qpLNS/DA5Ke2kZJ+MCVtRQ1mcGNYtHkb
 dXd9/9U8T9JewOT5363Om4HkmF+HTt+0wKywA2paBfaHpk2Vr4QnGk+w1sBtHuVxOvng
 I+HNhMrzSCfbWlTosIZMEpjMs1g9kmfbMKZuSaC9lHBVOtJOWU86cgIXDQzTZWK3yDMJ
 qu+Mzxs43UMY87ySzxQv9sZxq5yoLcgfKvc7J8fuf6psC2bl2FI8uPRwxP+RJDyeOL5o
 mLRw==
X-Gm-Message-State: ACrzQf3ZiE8ZzU6uAOl9cy0LlbpvRA4nKez4M48tyFcbOKRYCxZADEij
 /g/BfddeTuXJCpTi0Ld6e8sG/RmTvjjbLX8YbojonJEoGtNC/auALyIvdWjrPiKKH9LNZ56uPFR
 WjpQdUfBszsDy1DvUBNAUoW5LDtwTHTiOC9UoEm4r
X-Received: by 2002:a37:ef18:0:b0:6ce:175f:409a with SMTP id
 j24-20020a37ef18000000b006ce175f409amr5781663qkk.572.1663943006691; 
 Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7XaeBSmIgCS5xVoX7O37KV2Q4BatIbL+4W7934TQWhD9AMaj+EBoxQ49sZN/jgeEabR6YtNA==
X-Received: by 2002:a37:ef18:0:b0:6ce:175f:409a with SMTP id
 j24-20020a37ef18000000b006ce175f409amr5781650qkk.572.1663943006470; 
 Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net.
 [68.160.173.162]) by smtp.gmail.com with ESMTPSA id
 y26-20020a37f61a000000b006ceb933a9fesm5847674qkj.81.2022.09.23.07.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
Date: Fri, 23 Sep 2022 10:23:25 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 2/8] dm: Add support for block provisioning
Message-ID: <Yy3BXc9wf4PH6Rby@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-3-sarthakkukreti@google.com>
MIME-Version: 1.0
In-Reply-To: <20220915164826.1396245-3-sarthakkukreti@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Thu, Sep 15 2022 at 12:48P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Add support to dm devices for REQ_OP_PROVISION. The default mode
> is to pass through the request and dm-thin will utilize it to provision
> blocks.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-crypt.c         |  4 +-
>  drivers/md/dm-linear.c        |  1 +
>  drivers/md/dm-table.c         | 17 +++++++
>  drivers/md/dm-thin.c          | 86 +++++++++++++++++++++++++++++++++--
>  drivers/md/dm.c               |  4 ++
>  include/linux/device-mapper.h |  6 +++
>  6 files changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 159c6806c19b..357f0899cfb6 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -3081,6 +3081,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
>  	if (ret)
>  		return ret;
>  
> +	ti->num_provision_bios = 1;
> +
>  	while (opt_params--) {
>  		opt_string = dm_shift_arg(&as);
>  		if (!opt_string) {
> @@ -3384,7 +3386,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
>  	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
>  	 */
>  	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
> -	    bio_op(bio) == REQ_OP_DISCARD)) {
> +	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
>  		bio_set_dev(bio, cc->dev->bdev);
>  		if (bio_sectors(bio))
>  			bio->bi_iter.bi_sector = cc->start +
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 3212ef6aa81b..1aa782149428 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	ti->num_discard_bios = 1;
>  	ti->num_secure_erase_bios = 1;
>  	ti->num_write_zeroes_bios = 1;
> +	ti->num_provision_bios = 1;
>  	ti->private = lc;
>  	return 0;
>  
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 332f96b58252..b7f9cb66b7ba 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1853,6 +1853,18 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
>  	return true;
>  }
>  
> +static bool dm_table_supports_provision(struct dm_table *t)
> +{
> +	for (unsigned int i = 0; i < t->num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(t, i);
> +
> +		if (ti->num_provision_bios)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

This needs to go a step further and verify a device in the stack
actually services REQ_OP_PROVISION.

Please see dm_table_supports_discards(): it iterates all devices in
the table and checks that support is advertised.

For discard, DM requires that _all_ devices in a table advertise
support (that is pretty strict and likely could be relaxed to _any_).

You'll need ti->provision_supported (like ->discards_supported) to
advertise actual support is provided by dm-thinp (even if underlying
devices don't support it).

And yeah, dm-thinp passdown support for REQ_OP_PROVISION can follow
later as needed (if there actual HW that would benefit from
REQ_OP_PROVISION).

Mike

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
