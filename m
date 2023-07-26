Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E43C0015E
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 23:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C78941E97;
	Wed, 26 Jul 2023 23:09:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C78941E97
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=Lnuap/X4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x-JWtaTnccRH; Wed, 26 Jul 2023 23:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D94641BF8;
	Wed, 26 Jul 2023 23:09:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D94641BF8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3418BC0071;
	Wed, 26 Jul 2023 23:09:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFBF6C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 23:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD37141D62
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 23:09:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD37141D62
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mvy_6aGcL7oC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 23:09:47 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37A5741BF8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 23:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37A5741BF8
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bbc2e1c6b2so2323255ad.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1690412986; x=1691017786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bNBWi9BFA7oJZNyI/XnA5H8tHZCJl01gNE0DBxlvZ40=;
 b=Lnuap/X4mLRvumv8rxik6XXAmLQssX2LaTRnfxOwbhhRA6q+4W8DfrIsG7kVikG4Iw
 ozUx9bZZDKNb4aqqrWuoDs7rpphs2fFB4IjiULQPXjflO/XhZA2vc5TzngrkqmMIM5UL
 tCjpn3hCX/GmJvs5MwDi73VFwiTs9hADB2Cru8fy0ICxuL68/fE/7pFEUcb8ihUp2Ey5
 GxMGCc+rwQuZGeGguv2m2EFaBOeJPE6kWVGxSMJPh4gYWl2FbXQzGnA0u5AYkb1ckWFe
 PYG7wUThiNHKJJU/Kftp/PqqvyLMK20NIq4IuXuyA0M1JDxZWj46ZkNyp0CVDzf4FlQ+
 b/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690412986; x=1691017786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNBWi9BFA7oJZNyI/XnA5H8tHZCJl01gNE0DBxlvZ40=;
 b=egms6RRfQpUXT1CrlwNdBJtKoJZ+iX+LHlIIhteW/9UztfnYCIswnan+pB+L6OZtu2
 KZC1QMM5i4oollox3xuxECAvc+Q5uau3Mlaq0xBihDXsHtxVFhNRRsBEkBWroiJ+23qy
 7aiQiW6Gg+8vA5fwmqSM9aQv6/QHUEo9wHoCSP+9cI49UHRyRg6V+r8uGIP69JgnihjV
 R6l3WAdqdCBTZ1o048YA37m+V1WprHARRIPuHl6+yn9EvQwNH9X7ERNp2AxYbvmz5p4z
 czRCgO2QvT1++xCGC47gflaol9xJkX5As2smTOvXKOQp3jM6mUE7RoTqdXhFUZrdV7of
 eWFg==
X-Gm-Message-State: ABy/qLa/1KMNqletRwqEpZA/FzbNIQ08iMZZoisMprPONeXjyXcqUUvK
 tC/r9qujj67IOwjn6mNy4rf9cw==
X-Google-Smtp-Source: APBJJlHUt9d2hTqe2ud94c6lNUCrPn/cPviOHGLjkBp5h1xJnkt7lTpPKllT1sxo0CM9mi2vK7HwDA==
X-Received: by 2002:a17:902:c10c:b0:1b8:b382:f6c3 with SMTP id
 12-20020a170902c10c00b001b8b382f6c3mr2914213pli.13.1690412986476; 
 Wed, 26 Jul 2023 16:09:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au.
 [49.186.119.116]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090341c900b001ac95be5081sm58846ple.307.2023.07.26.16.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 16:09:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
 (envelope-from <david@fromorbit.com>) id 1qOndW-00AvaD-0j;
 Thu, 27 Jul 2023 09:09:42 +1000
Date: Thu, 27 Jul 2023 09:09:42 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 44/47] mm: shrinker: make global slab shrink lockless
Message-ID: <ZMGnthZAh48JF+eV@dread.disaster.area>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-45-zhengqi.arch@bytedance.com>
 <ZMDUkoIXUlTkCSYL@dread.disaster.area>
 <19ad6d06-8a14-6102-5eae-2134dc2c5061@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19ad6d06-8a14-6102-5eae-2134dc2c5061@bytedance.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org,
 cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com,
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
From: Dave Chinner via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jul 26, 2023 at 05:14:09PM +0800, Qi Zheng wrote:
> On 2023/7/26 16:08, Dave Chinner wrote:
> > On Mon, Jul 24, 2023 at 05:43:51PM +0800, Qi Zheng wrote:
> > > @@ -122,6 +126,13 @@ void shrinker_free_non_registered(struct shrinker *shrinker);
> > >   void shrinker_register(struct shrinker *shrinker);
> > >   void shrinker_unregister(struct shrinker *shrinker);
> > > +static inline bool shrinker_try_get(struct shrinker *shrinker)
> > > +{
> > > +	return READ_ONCE(shrinker->registered) &&
> > > +	       refcount_inc_not_zero(&shrinker->refcount);
> > > +}
> > 
> > Why do we care about shrinker->registered here? If we don't set
> > the refcount to 1 until we have fully initialised everything, then
> > the shrinker code can key entirely off the reference count and
> > none of the lookup code needs to care about whether the shrinker is
> > registered or not.
> 
> The purpose of checking shrinker->registered here is to stop running
> shrinker after calling shrinker_free(), which can prevent the following
> situations from happening:
> 
> CPU 0                 CPU 1
> 
> shrinker_try_get()
> 
>                        shrinker_try_get()
> 
> shrinker_put()
> shrinker_try_get()
>                        shrinker_put()

I don't see any race here? What is wrong with having multiple active
users at once?

> > 
> > This should use a completion, then it is always safe under
> > rcu_read_lock().  This also gets rid of the shrinker_lock spin lock,
> > which only exists because we can't take a blocking lock under
> > rcu_read_lock(). i.e:
> > 
> > 
> > void shrinker_put(struct shrinker *shrinker)
> > {
> > 	if (refcount_dec_and_test(&shrinker->refcount))
> > 		complete(&shrinker->done);
> > }
> > 
> > void shrinker_free()
> > {
> > 	.....
> > 	refcount_dec(&shrinker->refcount);
> 
> I guess what you mean is shrinker_put(), because here may be the last
> refcount.

Yes, I did.

> > 	wait_for_completion(&shrinker->done);
> > 	/*
> > 	 * lookups on the shrinker will now all fail as refcount has
> > 	 * fallen to zero. We can now remove it from the lists and
> > 	 * free it.
> > 	 */
> > 	down_write(shrinker_rwsem);
> > 	list_del_rcu(&shrinker->list);
> > 	up_write(&shrinker_rwsem);
> > 	call_rcu(shrinker->rcu_head, shrinker_free_rcu_cb);
> > }
> > 
> > ....
> > 
> > > @@ -686,11 +711,14 @@ EXPORT_SYMBOL(shrinker_free_non_registered);
> > >   void shrinker_register(struct shrinker *shrinker)
> > >   {
> > > -	down_write(&shrinker_rwsem);
> > > -	list_add_tail(&shrinker->list, &shrinker_list);
> > > -	shrinker->flags |= SHRINKER_REGISTERED;
> > > +	refcount_set(&shrinker->refcount, 1);
> > > +
> > > +	spin_lock(&shrinker_lock);
> > > +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
> > > +	spin_unlock(&shrinker_lock);
> > > +
> > >   	shrinker_debugfs_add(shrinker);
> > > -	up_write(&shrinker_rwsem);
> > > +	WRITE_ONCE(shrinker->registered, true);
> > >   }
> > >   EXPORT_SYMBOL(shrinker_register);
> > 
> > This just looks wrong - you are trying to use WRITE_ONCE() as a
> > release barrier to indicate that the shrinker is now set up fully.
> > That's not necessary - the refcount is an atomic and along with the
> > rcu locks they should provides all the barriers we need. i.e.
> 
> The reason I used WRITE_ONCE() here is because the shrinker->registered
> will be read and written concurrently (read in shrinker_try_get() and
> written in shrinker_free()), which is why I added shrinker::registered
> field instead of using SHRINKER_REGISTERED flag (this can reduce the
> addition of WRITE_ONCE()/READ_ONCE()).

Using WRITE_ONCE/READ_ONCE doesn't provide memory barriers needed to
use the field like this. You need release/acquire memory ordering
here. i.e. smp_store_release()/smp_load_acquire().

As it is, the refcount_inc_not_zero() provides a control dependency,
as documented in include/linux/refcount.h, refcount_dec_and_test()
provides release memory ordering. The only thing I think we may need
is a write barrier before refcount_set(), such that if
refcount_inc_not_zero() sees a non-zero value, it is guaranteed to
see an initialised structure...

i.e. refcounts provide all the existence and initialisation
guarantees. Hence I don't see the need to use shrinker->registered
like this and it can remain a bit flag protected by the
shrinker_rwsem().


> > void shrinker_register(struct shrinker *shrinker)
> > {
> > 	down_write(&shrinker_rwsem);
> > 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
> > 	shrinker->flags |= SHRINKER_REGISTERED;
> > 	shrinker_debugfs_add(shrinker);
> > 	up_write(&shrinker_rwsem);
> > 
> > 	/*
> > 	 * now the shrinker is fully set up, take the first
> > 	 * reference to it to indicate that lookup operations are
> > 	 * now allowed to use it via shrinker_try_get().
> > 	 */
> > 	refcount_set(&shrinker->refcount, 1);
> > }
> > 
> > > diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> > > index f1becfd45853..c5573066adbf 100644
> > > --- a/mm/shrinker_debug.c
> > > +++ b/mm/shrinker_debug.c
> > > @@ -5,6 +5,7 @@
> > >   #include <linux/seq_file.h>
> > >   #include <linux/shrinker.h>
> > >   #include <linux/memcontrol.h>
> > > +#include <linux/rculist.h>
> > >   /* defined in vmscan.c */
> > >   extern struct rw_semaphore shrinker_rwsem;
> > > @@ -161,17 +162,21 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
> > >   {
> > >   	struct dentry *entry;
> > >   	char buf[128];
> > > -	int id;
> > > -
> > > -	lockdep_assert_held(&shrinker_rwsem);
> > > +	int id, ret = 0;
> > >   	/* debugfs isn't initialized yet, add debugfs entries later. */
> > >   	if (!shrinker_debugfs_root)
> > >   		return 0;
> > > +	down_write(&shrinker_rwsem);
> > > +	if (shrinker->debugfs_entry)
> > > +		goto fail;
> > > +
> > >   	id = ida_alloc(&shrinker_debugfs_ida, GFP_KERNEL);
> > > -	if (id < 0)
> > > -		return id;
> > > +	if (id < 0) {
> > > +		ret = id;
> > > +		goto fail;
> > > +	}
> > >   	shrinker->debugfs_id = id;
> > >   	snprintf(buf, sizeof(buf), "%s-%d", shrinker->name, id);
> > > @@ -180,7 +185,8 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
> > >   	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
> > >   	if (IS_ERR(entry)) {
> > >   		ida_free(&shrinker_debugfs_ida, id);
> > > -		return PTR_ERR(entry);
> > > +		ret = PTR_ERR(entry);
> > > +		goto fail;
> > >   	}
> > >   	shrinker->debugfs_entry = entry;
> > > @@ -188,7 +194,10 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
> > >   			    &shrinker_debugfs_count_fops);
> > >   	debugfs_create_file("scan", 0220, entry, shrinker,
> > >   			    &shrinker_debugfs_scan_fops);
> > > -	return 0;
> > > +
> > > +fail:
> > > +	up_write(&shrinker_rwsem);
> > > +	return ret;
> > >   }
> > >   int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
> > > @@ -243,6 +252,11 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
> > >   	shrinker->name = NULL;
> > >   	*debugfs_id = entry ? shrinker->debugfs_id : -1;
> > > +	/*
> > > +	 * Ensure that shrinker->registered has been set to false before
> > > +	 * shrinker->debugfs_entry is set to NULL.
> > > +	 */
> > > +	smp_wmb();
> > >   	shrinker->debugfs_entry = NULL;
> > >   	return entry;
> > > @@ -266,14 +280,26 @@ static int __init shrinker_debugfs_init(void)
> > >   	shrinker_debugfs_root = dentry;
> > >   	/* Create debugfs entries for shrinkers registered at boot */
> > > -	down_write(&shrinker_rwsem);
> > > -	list_for_each_entry(shrinker, &shrinker_list, list)
> > > +	rcu_read_lock();
> > > +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
> > > +		if (!shrinker_try_get(shrinker))
> > > +			continue;
> > > +		rcu_read_unlock();
> > > +
> > >   		if (!shrinker->debugfs_entry) {
> > > -			ret = shrinker_debugfs_add(shrinker);
> > > -			if (ret)
> > > -				break;
> > > +			/* Paired with smp_wmb() in shrinker_debugfs_detach() */
> > > +			smp_rmb();
> > > +			if (READ_ONCE(shrinker->registered))
> > > +				ret = shrinker_debugfs_add(shrinker);
> > >   		}
> > > -	up_write(&shrinker_rwsem);
> > > +
> > > +		rcu_read_lock();
> > > +		shrinker_put(shrinker);
> > > +
> > > +		if (ret)
> > > +			break;
> > > +	}
> > > +	rcu_read_unlock();
> > >   	return ret;
> > >   }
> > 
> > And all this churn and complexity can go away because the
> > shrinker_rwsem is still used to protect shrinker_register()
> > entirely....
> 
> My consideration is that during this process, there may be a
> driver probe failure and then shrinker_free() is called (the
> shrinker_debugfs_init() is called in late_initcall stage). In
> this case, we need to use RCU+refcount to ensure that the shrinker
> is not freed.

Yeah, you're trying to work around the lack of a
wait_for_completion() call in shrinker_free().

With that, this doesn't need RCU at all, and the iteration can be
done fully under the shrinker_rwsem() safely and so none of this
code needs to change.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
