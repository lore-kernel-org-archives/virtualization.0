Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0174209663
	for <virtualization@lists.linux.dev>; Mon,  3 Feb 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595348; cv=none; b=iiwoVOS/wqy6yL6JbiBZ5Au81v7B0xjBYWTSSNebBx4eQ1vw/DhwTPWtJGQkcE67PuBUNSpkQa3quNRuvltikHtfn41xZMFVBQXuQ5wH8ViPiXy0PywwyUfR1bm8WlO7UbiVedQwDt1hDJdxruUnBbGjTdB8A3CTFRWnJYNljPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595348; c=relaxed/simple;
	bh=X9vv2KOumpKMXpLrOCA/JuTc7MZFGf4/fguoPOHeebg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmzLrZ7W5Bp8VjhW/Uj4CwGXwuxQkRLWJ9N1dMjUj2nEx9ptjOWNeUgEQ+d1snv3Hv5Ro//a4m/295kay9TlNMb5/PcbHdh1bcv0l/ZzX3780bYI6QA+CtwwV82WbVv74xVi+lPujnXg1QGBq9FFOUR497UvGLqIDWb6cQXdh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hayrZvFh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hayrZvFh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-218c8aca5f1so90521135ad.0
        for <virtualization@lists.linux.dev>; Mon, 03 Feb 2025 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738595345; x=1739200145; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Liydz60cmndYD4qns14/Qbs4OC2qocuyXIy5gGvyjyg=;
        b=hayrZvFhaYc0+UB//azNBmolGepQCkYCl6mryDXfOyhQeqjw0QofL9HGh0rdkpsdfq
         WAoTgB4uSNV960tEGXZH0WYdb3cycA4Gh1N/KuV6ZN6YK3BhB/AedM3UZoj+Q7Y6YT5F
         FbaXn4tp5e/Q1LDSam9LRMkNW4hz3weJlnFO9Qi029o7/i4hZqMN4KI36/dyDdtsUwnJ
         yGp/5uwphhyduO8BCshRIi/mpABCnkEOW8ON6BdDMwp0blNBQeKe99ij7I0FTdm+gfmd
         iXWkt/z4G5J8jfHjlGf7UB2Rxrkcr90bUX1gOC075PTov7YZiTAVJAVz1JfgBbCmNxEk
         86bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595345; x=1739200145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Liydz60cmndYD4qns14/Qbs4OC2qocuyXIy5gGvyjyg=;
        b=l0LgJVVWVTimxbOCGRQ2HY5Q+D+Xo7y2o9H2FEaZFrxFfp6G5w84AVing7ODY9uvdl
         Bbl1F1/gDdY5Winw3zr7DsL5ZyjFqqhGvmpQAgWro/7R3LNO6w+fNM19ERX7RiEmv8V0
         6G8IgqHtVkhRjYPgn5ZI6x41lIjxNosN/e0hI7NSijN4Jh09d0tfKj1oa4TGBG8pIddi
         qwsGOQ83xha5NkHTNibs9jq+HGzYD+yVbcOzHHtGN2PlqTt758s3cNDVsVxdzTGJQjgj
         JKnZn2fZ2b6fxzwDcwpSGW9wf8FD6E5xjAYoAC1Rvc50XBSEz5uylxkB1IXBgx83QYgk
         +yWw==
X-Forwarded-Encrypted: i=1; AJvYcCXcbkXrj9/Zz5gEMdpoHDDuurTZx4emptHwvinMl0xzBrhkcI/RGsbRgdO762x2JpeelJ7AnN989hkCj8Siyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWyIzkQhnfRVgIYLzQ5CQPI+133b/AEiB7PlrWjtOrLgEJvyhz
	K6XUnBKLUYSMGkMXCQWrC3xkOeVz3twGIwS7dVFBSWRZWdGqLBVu
X-Gm-Gg: ASbGncu3C7MSg6kv7cCWmJDoPjTpWjeu88RoBB+EJxXlbiS+sk0hFNNFRutKR1iz7EG
	CEAjrza8V+88Yv5HHv+In/9cRrUOrWqiPC7+JDGkE0HM0UjW8/Sr4zxkOa8FfoFveb+TgqVruQa
	BtXfoifTVvFbH0p2guYRUVFTWTUtJK8HMzoXs2S/9oLEvTGbhvVhm0i49u5vgT4ZS4ONX48Rf7m
	Jt0aD78t6DV//cyLazznkc/6lTWK9mfYnZV4WrSh2rzN8Sn6nli8Y7AowxNtKPfd2SsU1MJWva+
	cJLbNtgmmeXSMuu8ehnJpqeDhUP0
X-Google-Smtp-Source: AGHT+IFUAkyxrkJaDrPwYodDQvzxDDTUk4r3atYHiHtcVu1uJFXauC2E5w6/RR2ly7RfMe7ktQE7aA==
X-Received: by 2002:a17:903:188:b0:21d:dfae:300c with SMTP id d9443c01a7336-21ddfae34camr280680665ad.3.1738595344940;
        Mon, 03 Feb 2025 07:09:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de4a91af6sm76095175ad.17.2025.02.03.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:09:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 3 Feb 2025 07:09:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	ceph-devel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH] block: force noio scope in blk_mq_freeze_queue
Message-ID: <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
References: <20250131120352.1315351-1-hch@lst.de>
 <20250131120352.1315351-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131120352.1315351-2-hch@lst.de>

On Fri, Jan 31, 2025 at 01:03:47PM +0100, Christoph Hellwig wrote:
> When block drivers or the core block code perform allocations with a
> frozen queue, this could try to recurse into the block device to
> reclaim memory and deadlock.  Thus all allocations done by a process
> that froze a queue need to be done without __GFP_IO and __GFP_FS.
> Instead of tying to track all of them down, force a noio scope as
> part of freezing the queue.
> 
> Note that nvme is a bit of a mess here due to the non-owner freezes,
> and they will be addressed separately.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

All sparc64 builds fail with this patch in the tree.

drivers/block/sunvdc.c: In function 'vdc_queue_drain':
drivers/block/sunvdc.c:1130:9: error: too many arguments to function 'blk_mq_unquiesce_queue'
 1130 |         blk_mq_unquiesce_queue(q, memflags);
      |         ^~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/block/sunvdc.c:10:
include/linux/blk-mq.h:895:6: note: declared here
  895 | void blk_mq_unquiesce_queue(struct request_queue *q);
      |      ^~~~~~~~~~~~~~~~~~~~~~
drivers/block/sunvdc.c:1131:9: error: too few arguments to function 'blk_mq_unfreeze_queue'
 1131 |         blk_mq_unfreeze_queue(q);
      |         ^~~~~~~~~~~~~~~~~~~~~
include/linux/blk-mq.h:914:1: note: declared here
  914 | blk_mq_unfreeze_queue(struct request_queue *q, unsigned int memflags)

Bisect log attached for reference.

Guenter

---
# bad: [8d0efe18f567040a251aef1e00ea39bd3776f5e1] Merge branch 'fixes-v6.14' into testing
# good: [69e858e0b8b2ea07759e995aa383e8780d9d140c] Merge tag 'uml-for-linus-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux
git bisect start 'HEAD' '69e858e0b8b2'
# bad: [1b5f3c51fbb8042efb314484b47b2092cdd40bf6] Merge tag 'riscv-for-linus-6.14-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect bad 1b5f3c51fbb8042efb314484b47b2092cdd40bf6
# bad: [9755ffd989aa04c298d265c27625806595875895] Merge tag 'block-6.14-20250131' of git://git.kernel.dk/linux
git bisect bad 9755ffd989aa04c298d265c27625806595875895
# good: [626d1a1e99583f846e44d6eefdc9d1c8b82c372d] Merge tag 'ceph-for-6.14-rc1' of https://github.com/ceph/ceph-client
git bisect good 626d1a1e99583f846e44d6eefdc9d1c8b82c372d
# good: [8c8492ca64e79c6e0f433e8c9d2bcbd039ef83d0] io_uring/net: don't retry connect operation on EPOLLERR
git bisect good 8c8492ca64e79c6e0f433e8c9d2bcbd039ef83d0
# good: [95d7e8226106e3445b0d877015f4192c47d23637] Merge tag 'ata-6.14-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect good 95d7e8226106e3445b0d877015f4192c47d23637
# good: [5aa21b0495df1fac6d39f45011c1572bb431c44c] loop: don't clear LO_FLAGS_PARTSCAN on LOOP_SET_STATUS{,64}
git bisect good 5aa21b0495df1fac6d39f45011c1572bb431c44c
# good: [14ef49657ff3b7156952b2eadcf2e5bafd735795] block: fix nr_hw_queue update racing with disk addition/removal
git bisect good 14ef49657ff3b7156952b2eadcf2e5bafd735795
# bad: [1e1a9cecfab3f22ebef0a976f849c87be8d03c1c] block: force noio scope in blk_mq_freeze_queue
git bisect bad 1e1a9cecfab3f22ebef0a976f849c87be8d03c1c
# first bad commit: [1e1a9cecfab3f22ebef0a976f849c87be8d03c1c] block: force noio scope in blk_mq_freeze_queue

