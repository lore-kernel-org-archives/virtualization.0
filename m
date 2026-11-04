Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785886;
	b=e028PJ80gcu/AwWYTz9Z001HWzh1kCPyWHEVgy/ZkdRD7O8AXpbYX+1ZHRo2GuXtYUVf
	 6DW/lC2uLngM3+TjQlhkfIIwZxihy9VtmYmQ6BknT+5zsUpNSBU/iIGEuWiB4u2ASdLlD
	 8ZII2lp7CAna6bQWgmT++Fc6xeaxQS0pG2Bx689AKfUx2bjkF7/gz6/3dpkrVhOk8DkZN
	 UsX4YGenaXpiVuXQsurdsYQtZXKUkkdU6XxFVB4KmhJeZdo+UVTJkxDRGfbQGkSIPQlUt
	 OK3p6FFcVFAzBbaTxCkfw6+eAyXBNORv5FQfERPEE20Igx074gKyL/FxJIPf2k0xVbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785886;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GMprxfEezCoh7/h412LE6//XE/ONqR/9sL3yJ6mBKrI=;
	b=dbPUg0KxB4Mtv01BaUkOfWu5hmGq6mBJTw6xG2GEIPO9UG2g7pESrxr+T8NJ+9ginJ9H
	 GUaNHcXRHNjRIARNVbAmsUUECSc5amYc/wiZNzmT6bUOpEMYAwyACKppk+lbTxaXUSRZa
	 HUJz/+jb6ogBZNLN/umMeEA3JcPeeEmReZDfccdTquQPtjZCwe3Wb3wNMQQ51ob/Ppv8Y
	 gPMonEZGDU7hk6WakuZhXunF0HCuA9cO9F0qJw2F2YYCG+L1S+BaAinm5sXb6VwJXCLHq
	 mbtxpcspiY2w3gZgzySxgGQkJ39lxeXmyD1khBv1XERmuS/TXQSeuuesmFJbots3QMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8hqftHh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259AE606A339;
	Wed,  4 Nov 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8hqftHh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1851F00A16;
	Wed,  4 Nov 2026 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785885;
	bh=GMprxfEezCoh7/h412LE6//XE/ONqR/9sL3yJ6mBKrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8hqftHhkVOdYFgFk+LjMFi1DgGSzm/wGPnzPGtCz2evBjc+XbnIjJYvNta6mB9fz
	 jBl1KtsxNN/IMO8j7+2R7GgtKAzJPlkGLHKQLek0mFTaJOAy2eVGfhH0YeEjubfYtL
	 fCAJczrM8FL++zqhSmtXe1dIkRIGLI0/CB2X/3lQ3j+27Cqlolay+uy7TtVW7Ienp3
	 7R1i/VrLgcKH9VAce0UcjAUL7GFSDQ/GQc+CbP4iEe3B2BBgDXZykGcw64QpkLSO+e
	 OegMlGrymtbwxCMdgkRZ4hKL6v+MwNFHi3QqiHT1cJjzvRaSRFa2xaBnhBHCJEvUnQ
	 58ttHFAaG3rOA==
Message-ID: <sashiko-outbox-197004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/6] virtio-mem: support memmap_on_memory in Sub
 Block Mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolaos Karaolidis" <nick@karaolidis.com>, "David Hildenbrand" <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Oscar Salvador" <osalvador@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowangio@gmail.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?utf-8?b?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Michal
 Hocko" <mhocko@suse.com>, "Hui Zhu" <teawater@gmail.com>, "Georgi Djakov" <georgi.djakov@oss.qualcomm.com>, virtualization@lists.linux.dev, linux-mm@kvack.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261103-virtio-mem-memmap-v1-5-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
 <20261103-virtio-mem-memmap-v1-5-308ae1da6240@karaolidis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:51:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] virtio-mem: swallowed memmap unplug errors in virtio_mem_sbm_try=
_remove_unplugged_mb()
--

commit b0988c80262195af51a910d0ad85c26ee566fe77
Author: Nikolaos Karaolidis <nick@karaolidis.com>

virtio-mem: support memmap_on_memory in Sub Block Mode

This commit adds memmap_on_memory support for Sub Block Mode in virtio-mem
when the self-hosted memmap spans complete subblocks. It keeps the memmap
subblocks plugged while a memory block is added to Linux, skips them when
unplugging from an added block, and unplugs them once the block is removed.

> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 688c178c760f5..d6623f67b76bb 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c

[ ... ]

> @@ -1617,35 +1628,65 @@ static int virtio_mem_sbm_unplug_mb(struct virtio=
_mem *vm, unsigned long mb_id)
>  {
>  	uint64_t nb_sb =3D vm->sbm.sbs_per_mb;
> =20
> -	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, &nb_sb);
> +	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, 0, &nb_sb);
> +}
> +
> +/*
> + * Unplug the memmap subblocks of a memory block removed from Linux and =
mark it
> + * unused. The memmap subblocks are deducted from @nb_sb (clamped), even=
 if
> + * unplugging them fails. On error, the memory block stays
> + * VIRTIO_MEM_SBM_MB_PLUGGED and virtio_mem_cleanup_pending_mb() retries.
> + *
> + * Will modify the state of the memory block.
> + */
> +static int virtio_mem_sbm_finish_remove_mb(struct virtio_mem *vm,
> +					   unsigned long mb_id, uint64_t *nb_sb)
> +{
> +	const int count =3D vm->sbm.memmap_sbs;
> +	int rc;
> +
> +	if (count) {
> +		if (nb_sb)
> +			*nb_sb -=3D min_t(uint64_t, *nb_sb, count);
> +		virtio_mem_sbm_set_mb_state(vm, mb_id,
> +					    VIRTIO_MEM_SBM_MB_PLUGGED);
> +		rc =3D virtio_mem_sbm_unplug_sb(vm, mb_id, 0, count);
> +		if (rc)
> +			return rc;
> +	}
> +	virtio_mem_sbm_set_mb_state(vm, mb_id, VIRTIO_MEM_SBM_MB_UNUSED);
> +	return 0;
>  }
> =20
>  /*
> - * Try (offlining and) removing memory from Linux in case all subblocks =
are
> - * unplugged. Can be called on online and offline memory blocks.
> + * Try (offlining and) removing memory from Linux in case all subblocks =
except
> + * the memmap subblocks are unplugged. Can be called on online and offli=
ne
> + * memory blocks.
>   *
>   * May modify the state of memory blocks in virtio-mem.
>   */
>  static int virtio_mem_sbm_try_remove_unplugged_mb(struct virtio_mem *vm,
> -						  unsigned long mb_id)
> +						  unsigned long mb_id,
> +						  uint64_t *nb_sb)
>  {
> +	const int first_sb =3D vm->sbm.memmap_sbs;
>  	int rc;
> =20
>  	/*
>  	 * Once all subblocks of a memory block were unplugged, offline and
> -	 * remove it.
> +	 * remove it. The memmap subblocks alone provide no memory to Linux.
>  	 */
> -	if (!virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
> +	if (!virtio_mem_sbm_test_sb_unplugged(vm, mb_id, first_sb,
> +					      vm->sbm.sbs_per_mb - first_sb))
>  		return 0;
> =20
>  	/* offline_and_remove_memory() works for online and offline memory. */
>  	mutex_unlock(&vm->hotplug_mutex);
>  	rc =3D virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
>  	mutex_lock(&vm->hotplug_mutex);
> -	if (!rc)
> -		virtio_mem_sbm_set_mb_state(vm, mb_id,
> -					    VIRTIO_MEM_SBM_MB_UNUSED);
> -	return rc;
> +	if (rc)
> +		return rc;
> +	return virtio_mem_sbm_finish_remove_mb(vm, mb_id, nb_sb);
>  }

[ ... ]

> @@ -2072,7 +2130,7 @@ static int virtio_mem_sbm_unplug_any_sb_online(stru=
ct virtio_mem *vm,
>  	}
> =20
>  unplugged:
> -	rc =3D virtio_mem_sbm_try_remove_unplugged_mb(vm, mb_id);
> +	rc =3D virtio_mem_sbm_try_remove_unplugged_mb(vm, mb_id, nb_sb);
>  	if (rc)
>  		vm->sbm.have_unplugged_mb =3D 1;
>  	/* Ignore errors, this is not critical. We'll retry later. */
> @@ -2389,11 +2447,11 @@ static int virtio_mem_cleanup_pending_mb(struct v=
irtio_mem *vm)
> =20
>  	mutex_lock(&vm->hotplug_mutex);
>  	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL)
> -		rc |=3D virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
> +		rc |=3D virtio_mem_sbm_try_remove_unplugged_mb(vm, id, NULL);
>  	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL)
> -		rc |=3D virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
> +		rc |=3D virtio_mem_sbm_try_remove_unplugged_mb(vm, id, NULL);
>  	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL)
> -		rc |=3D virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
> +		rc |=3D virtio_mem_sbm_try_remove_unplugged_mb(vm, id, NULL);
>  	mutex_unlock(&vm->hotplug_mutex);
> =20
>  	if (rc)

[Severity: Medium]
When virtio_mem_sbm_offline_and_remove_mb() succeeds in
virtio_mem_sbm_try_remove_unplugged_mb(), it calls
virtio_mem_sbm_finish_remove_mb() to transition the memory block to
VIRTIO_MEM_SBM_MB_PLUGGED and unplug the memmap subblocks via
virtio_mem_sbm_unplug_sb().

Before this change, virtio_mem_sbm_try_remove_unplugged_mb() only failed wh=
en
virtio_mem_sbm_offline_and_remove_mb() failed, leaving the block added to
Linux in a *_PARTIAL state with all subblocks already unplugged from the
device. Both callers (virtio_mem_sbm_unplug_any_sb_online() and
virtio_mem_cleanup_pending_mb()) therefore set vm->sbm.have_unplugged_mb and
return 0 to ignore the offlining failure.

With this change, if virtio_mem_sbm_finish_remove_mb() fails to unplug the
memmap subblocks (for example, returning -EAGAIN on a concurrent config
change during offlining, -ETXTBSY on VIRTIO_MEM_RESP_BUSY, or -EINVAL on
VIRTIO_MEM_RESP_ERROR), both callers treat that device unplug error the same
way as an offlining failure:

1. They set vm->sbm.have_unplugged_mb even though the memory block was
   already removed from Linux and moved to VIRTIO_MEM_SBM_MB_PLUGGED rather
   than a *_PARTIAL state.

2. In virtio_mem_cleanup_pending_mb(), the VIRTIO_MEM_SBM_MB_PLUGGED loop h=
as
   already run earlier in the function:

   virtio_mem_run_wq()
     virtio_mem_cleanup_pending_mb()
       virtio_mem_sbm_for_each_mb(..., VIRTIO_MEM_SBM_MB_PLUGGED)
         ...
       virtio_mem_sbm_for_each_mb(..., VIRTIO_MEM_SBM_MB_*_PARTIAL)
         virtio_mem_sbm_try_remove_unplugged_mb()
           virtio_mem_sbm_finish_remove_mb() -> fails, sets MB_PLUGGED
       returns 0
     virtio_mem_unplug_request() / virtio_mem_plug_request()

   Because virtio_mem_cleanup_pending_mb() swallows the error and returns 0,
   virtio_mem_run_wq() proceeds directly to virtio_mem_unplug_request() or
   virtio_mem_plug_request() in the same workqueue run while the failed
   block's memmap subblocks are still counted in vm->plugged_size. Doesn't
   this cause virtio_mem_unplug_request() to unplug extra subblocks from
   another active memory block (or virtio_mem_plug_request() to under-plug)?

3. In both callers, device errors from virtio_mem_sbm_finish_remove_mb() are
   masked instead of aborting the operation and propagating to
   virtio_mem_run_wq() (unlike virtio_mem_sbm_unplug_any_sb_offline(), which
   returns the error directly). For instance, in
   virtio_mem_sbm_unplug_any_sb_online(), returning 0 allows
   virtio_mem_sbm_unplug_request() to keep unplugging subsequent blocks on
   the device error, and in virtio_mem_run_wq(), -EAGAIN will not jump to
   retry and a fatal -EINVAL from VIRTIO_MEM_RESP_ERROR will be turned into
   -EBUSY via have_unplugged_mb instead of setting vm->broken =3D true.

Should virtio_mem_sbm_try_remove_unplugged_mb() distinguish an offlining
failure in virtio_mem_sbm_offline_and_remove_mb() (setting
vm->sbm.have_unplugged_mb and returning 0) from a device unplug failure in
virtio_mem_sbm_finish_remove_mb() (propagating the error code to the caller=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-virtio-mem=
-memmap-v1-0-308ae1da6240@karaolidis.com?part=3D5
