Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4115E95
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IH6OjY18"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F4AD4047C
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 09:35:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F4AD4047C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=IH6OjY18
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YVebqR83FKd
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 09:35:58 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E30434013D
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 09:35:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E30434013D
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id B0C6166071C9;
	Mon, 13 Nov 2023 09:35:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699868154;
	bh=8uROONRUN3wfor36PH2C6IpVeGG4rm7nr0Sn4f9Grog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IH6OjY185JQTlA4pm0o6KfYpo9t/fkRl5549UNE2XDyQrHFqkuOroWpundtt1VozE
	 RJiM4rsZQt7jL4dO+XsOEf8IvavqHQeCpZ+/DWXSNQW02AiYxHkcu+sqHymJxsynr6
	 16CLOKrI2o+BVRWD1ri/Kpp3JmKOdIK8fXhyWIfC59Nk6SrFHfH5GNN+7+i+ff7jIG
	 NZOeQZyCyB3T56mjhJ5tJXcIvrQEzx2V6K0ltxoxRhcv+C/jZjmMO12cA8KAIDsnKy
	 zlFyHf+S9Ck/aFi22wcwdyKYHOTAGWuYphwiS82NSjkx3aowSg2F0IOJwf+grvCoz8
	 uqKYXUO8h8LdA==
Date: Mon, 13 Nov 2023 10:35:50 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 19/26] drm/shmem-helper: Add common memory shrinker
Message-ID: <20231113103550.6ef01d99@collabora.com>
In-Reply-To: <20231110155858.4c92f05d@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-20-dmitry.osipenko@collabora.com>
	<20231110155858.4c92f05d@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 15:58:58 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Mon, 30 Oct 2023 02:01:58 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
> > @@ -238,6 +308,20 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
> >  	if (refcount_dec_not_one(&shmem->pages_use_count))
> >  		return;
> >  
> > +	/*
> > +	 * Destroying the object is a special case because acquiring
> > +	 * the obj lock can cause a locking order inversion between
> > +	 * reservation_ww_class_mutex and fs_reclaim.
> > +	 *
> > +	 * This deadlock is not actually possible, because no one should
> > +	 * be already holding the lock when GEM is released.  Unfortunately
> > +	 * lockdep is not aware of this detail.  So when the refcount drops
> > +	 * to zero, we pretend it is already locked.
> > +	 */
> > +	if (!kref_read(&shmem->base.refcount) &&
> > +	    refcount_dec_and_test(&shmem->pages_use_count))
> > +		return drm_gem_shmem_free_pages(shmem);  
> 
> Uh, with get/put_pages() being moved to the create/free_gem()
> hooks, we're back to a situation where pages_use_count > 0 when we
> reach gem->refcount == 0, which is not nice. We really need to patch
> drivers so they dissociate GEM creation from the backing storage
> allocation/reservation + mapping of the BO in GPU VM space.

I gave this a try, and I think it'd work fine for lima (I have patches
if you want) and panfrost (I have patches for panfrost too, basically
addressing my comments on patch 15). It's a bit trickier for v3d, but
still possible (we'd have to add a gpu_map_count to v3d_bo, get it
incremented for each BO referenced by a job when the job is created,
decremented for each BO referenced by a job when the job is destroyed,
and have a _put_pages() call when gpu_map_count reached zero). The main
problem is virtio, where BO backing storage lifetime is really tied to
the BO object lifetime, and my virtio knowledge is too limited to come
up with an solution to dissociate those 2 things.

TLDR; let's just keep this hack for now. This being said, there are 2
things that I think should be addressed:

1/ we want this change in patch 18 ("drm/shmem-helper: Change sgt
allocation policy") to keep this series bisectable, otherwise you'll
hit the WARN_ON(shmem->pages_use_count != 0) in drm_gem_shmem_free()

2/ we should do:

	if (!kref_read(&shmem->base.refcount) {
		if (refcount_dec_and_test(&shmem->pages_use_count))
			drm_gem_shmem_free_pages(shmem);

		return;
	}

  if we don't want to try to acquire the resv lock when the user leaked
  a pages ref (the core will complain about this leak in
  drm_gem_shmem_free() anyway)

Regards,

Boris
