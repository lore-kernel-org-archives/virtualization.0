Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F23624D4;
	Tue, 16 Jun 2026 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613040; cv=none; b=QdZpGmdJbiqqNGr/9tH1zFnWHoWDQJi3fBWxcpZfvvrVeVUOckDr6RK0QfJIsWiaQrfQF/rDEDcXqXsoUk4JYNfPpwHSIqfnAvDPdDK2UGvn5456aQ4/naYtxz5R7hiu1CDaaZyPLnbjHIj4erUPw0vjntbZsrl94gjoOR1s7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613040; c=relaxed/simple;
	bh=dVQEoz/nk2xypuD8aDIU4/qL625aUBU9Me7xHls4YX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAobTn6xTyDvB7K/SQDu0F1rZvnisPFnuF9T9LIR6FLS5UiTZ8i6f3eoTkbUuD/GILh5IfgBqRxV4SEwdGRC+kGzJoujK9YPlpIemfFvaVYVJrJjSxUHu1+P6t11IGsHJrjI/GbdrfhD+0S26cWOqU4yGnZ5OzoSgFeVvDHA6YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYgXAUrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYgXAUrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D21F00A3A;
	Tue, 16 Jun 2026 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613039;
	bh=bXDJn4ET/n49nZO9bSK0/Jpj40ZMZXCaUyXxGq2ATAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZYgXAUrxxkpNst1MV2nPoEHdSFKAeck/Ff+Z7V/Vk4zLrOYdwTdBBRhzMzKSjWNHC
	 sVYgBkTuuP1vnQbqUPJA8hvemaOqPqvQdQUjr/XWXtNtYQLEBqHZlxTePbDzrcbid8
	 mJsPRxje/5LGJAPgqnGQKdA/jnS+fLF5ZcoT/OQynOu6jqtmLB5imx+pXYi5gfeGB2
	 XDKJfW2mXhD6heGhys9dpFXGUZ3zDXbT9jHkC3alaqaaI3C3tLtR55mia4Kxei8Ot3
	 ho4DnUhjwU3tk+SCUGF973n8gwNDFpFce8y2QJusM8BgxLMZR9lFDpk74lk/nEKJfB
	 lSdf//tItOZzw==
Message-ID: <8e766803-e68d-4efd-a69e-cec5b2492988@kernel.org>
Date: Tue, 16 Jun 2026 14:30:34 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] virtio-balloon: extend stats with memory
 composition and pressure data
To: Gregory Price <gourry@gourry.net>, virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 hannes@cmpxchg.org, surenb@google.com, peterz@infradead.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com
References: <20260513165006.2790857-1-gourry@gourry.net>
 <20260513165006.2790857-2-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260513165006.2790857-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 18:50, Gregory Price wrote:
> When doing proactive ballooning to reduce the size of a guest, some
> additional vmstat information is useful in deciding how much pressure
> to exert on the VM and when the VM starts experiencing undesirable
> behavior (memory and io pressure).
> 
> Add 11 new statistics tags to the existing balloon stats virtqueue
> for improved balloon sizing decisions. Old hosts ignore unknown tags,
> so no feature negotiation is required.
> 
> New memory composition stats (bytes):
>   S_DIRTY:         dirty pages awaiting writeback
>   S_WRITEBACK:     pages under active writeback
>   S_ANON:          anonymous pages (for balloon ceiling calculation)
>   S_INACTIVE_FILE: inactive file LRU (safely reclaimable subset of cache)
>   S_SLAB_RECLAIM:  reclaimable slab memory
> 
> New workingset stats (counts):
>   S_WS_REFAULT_A:  anon workingset refaults
>   S_WS_REFAULT_F:  file workingset refaults
> 
> New PSI stats (microseconds, cumulative):
>   S_PSI_MEM_SOME:  memory pressure (some stalled)
>   S_PSI_MEM_FULL:  memory pressure (all stalled)
>   S_PSI_IO_SOME:   IO pressure (some stalled)
>   S_PSI_IO_FULL:   IO pressure (all stalled)
> 
> Export psi_system for module builds (CONFIG_VIRTIO_BALLOON=m with
> CONFIG_PSI=y).
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/virtio/virtio_balloon.c     | 33 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_balloon.h | 26 +++++++++++++++++++++--
>  kernel/sched/psi.c                  |  1 +
>  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f6c2dff33f8a..8fa33aec4ce7 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -18,6 +18,8 @@
>  #include <linux/wait.h>
>  #include <linux/mm.h>
>  #include <linux/page_reporting.h>
> +#include <linux/vmstat.h>
> +#include <linux/psi.h>
>  
>  /*
>   * Balloon device works in 4K page units.  So each page is pointed to by
> @@ -414,6 +416,37 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
>  				pages_to_bytes(caches));
>  
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRTY,
> +		    pages_to_bytes(global_node_page_state(NR_FILE_DIRTY)));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_WRITEBACK,
> +		    pages_to_bytes(global_node_page_state(NR_WRITEBACK)));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_ANON,
> +		    pages_to_bytes(global_node_page_state(NR_ANON_MAPPED)));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_INACTIVE_FILE,
> +		    pages_to_bytes(global_node_page_state(NR_INACTIVE_FILE)));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_SLAB_RECLAIM,
> +		    pages_to_bytes(
> +			global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B)));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_WS_REFAULT_A,
> +		    global_node_page_state(WORKINGSET_REFAULT_ANON));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_WS_REFAULT_F,
> +		    global_node_page_state(WORKINGSET_REFAULT_FILE));
> +
> +#ifdef CONFIG_PSI
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_MEM_SOME,
> +		    div_u64(psi_system.total[PSI_AVGS][PSI_MEM_SOME],
> +			    NSEC_PER_USEC));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_MEM_FULL,
> +		    div_u64(psi_system.total[PSI_AVGS][PSI_MEM_FULL],
> +			    NSEC_PER_USEC));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_IO_SOME,
> +		    div_u64(psi_system.total[PSI_AVGS][PSI_IO_SOME],
> +			    NSEC_PER_USEC));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_PSI_IO_FULL,
> +		    div_u64(psi_system.total[PSI_AVGS][PSI_IO_FULL],
> +			    NSEC_PER_USEC));
> +#endif
> +
>  	return idx;
>  }
>  
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ee35a372805d..37ec8a8466c4 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -77,7 +77,18 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_DIRECT_SCAN   13 /* Amount of memory scanned directly */
>  #define VIRTIO_BALLOON_S_ASYNC_RECLAIM 14 /* Amount of memory reclaimed asynchronously */
>  #define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15 /* Amount of memory reclaimed directly */
> -#define VIRTIO_BALLOON_S_NR       16
> +#define VIRTIO_BALLOON_S_DIRTY	       16 /* Dirty pages (bytes) */
> +#define VIRTIO_BALLOON_S_WRITEBACK     17 /* Pages under writeback (bytes) */
> +#define VIRTIO_BALLOON_S_ANON	       18 /* Anonymous pages (bytes) */
> +#define VIRTIO_BALLOON_S_INACTIVE_FILE 19 /* Inactive file LRU pages (bytes) */
> +#define VIRTIO_BALLOON_S_SLAB_RECLAIM  20 /* Reclaimable slab (bytes) */
> +#define VIRTIO_BALLOON_S_WS_REFAULT_A  21 /* Workingset refaults anon (count) */
> +#define VIRTIO_BALLOON_S_WS_REFAULT_F  22 /* Workingset refaults file (count) */
> +#define VIRTIO_BALLOON_S_PSI_MEM_SOME  23 /* PSI memory some total (us) */
> +#define VIRTIO_BALLOON_S_PSI_MEM_FULL  24 /* PSI memory full total (us) */
> +#define VIRTIO_BALLOON_S_PSI_IO_SOME   25 /* PSI IO some total (us) */
> +#define VIRTIO_BALLOON_S_PSI_IO_FULL   26 /* PSI IO full total (us) */
> +#define VIRTIO_BALLOON_S_NR	       27
>  
>  #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>  	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> @@ -95,7 +106,18 @@ struct virtio_balloon_config {
>  	VIRTIO_BALLOON_S_NAMES_prefix "async-scans", \
>  	VIRTIO_BALLOON_S_NAMES_prefix "direct-scans", \
>  	VIRTIO_BALLOON_S_NAMES_prefix "async-reclaims", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "dirty", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "writeback", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "anon-pages", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "inactive-file", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "slab-reclaimable", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "ws-refault-anon", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "ws-refault-file", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "psi-mem-some-us", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "psi-mem-full-us", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "psi-io-some-us", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "psi-io-full-us" \
>  }
>  
>  #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index d9c9d9480a45..8ab3aa1c4ef5 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -175,6 +175,7 @@ static DEFINE_PER_CPU(struct psi_group_cpu, system_group_pcpu);
>  struct psi_group psi_system = {
>  	.pcpu = &system_group_pcpu,
>  };
> +EXPORT_SYMBOL_GPL(psi_system);

Nothing too crazy here, however, the question is which of these values we
actually want to guarantee that we will provide them with unchanged semantics in
the future ... I guess anything we already expose to user space is alright
(because it effectively already must remain mostly unchanged I assume).

-- 
Cheers,

David
