Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90C2BB1D
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734630; cv=none; b=Q3MurkQSselTom9bq3addRluQu7l6VlEagwZc0XgGYS57UM8HEVHNs6XOgoGePYpZXqFy0S5xPxo9hwJDmp6535onZEy+Wc7Hwa0oFPJjpPlGzv5qZxCYdjSETewSh2M53Tstouorlqfh+BXpBQNv4OARXZ2+gRZ+CaXxMSjjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734630; c=relaxed/simple;
	bh=3fI1e8YW6ckftDaKPUNAmL/WzscuyEM9rt2IRJzL6pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXMMbYyR5UVT/NBs+P4jnOFDRNEbPWyBVB52r4LHYgQiAAGYNEH3aDO8eSiAoFJif+ytUOgGaSvzl9Crva8agM8xkOSLIutHdQeonBzWbVh3cXCHZ0oHduSrZFBUOcUbg/lUPw+2TLEhcNQXHCiOxfNRUwkpVumoUbjt7mwkPok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=LjJ08WAZ; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="LjJ08WAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1778734625; bh=VPP+hrS/MC4SAEG50qlVD7UkNB32c4pO9Og/0ICGMxk=;
	h=From:Message-ID:From;
	b=LjJ08WAZLLMMmtzTYVzxXruiJnCi56PyKUrHKlSQFErTlGTFd3Nz/+i4a7S4LbWFC
	 8DLQDFbs090UzR4Dk5cTQrdMtxvgmUDLq2/L82a8tVJT5TrSxW0H+Wovz0CkbtJFaU
	 UIwi7BwrWZFlhXiGLRWlNljJ4CS6ChgYyVPx1Tlk=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 6C427C0B5D;
	Thu, 14 May 2026 06:57:05 +0200 (CEST)
Date: Thu, 14 May 2026 06:57:05 +0200
From: Willy Tarreau <w@1wt.eu>
To: me@berkoc.com
Cc: security@kernel.org, virtualization@lists.linux.dev, berkantkoc@proton.me
Subject: Re: [Hardening] drm/qxl: apply_reloc/apply_surf_reloc write
 dst_offset without validating against BO size
Message-ID: <agVWIV5RGACx9GP-@1wt.eu>
References: <36acd33982bfdce04090e17294596ff8@berkoc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36acd33982bfdce04090e17294596ff8@berkoc.com>

Hello,

On Thu, May 14, 2026 at 02:07:47AM +0200, me@berkoc.com wrote:
> # QXL DRM: `apply_reloc` and `apply_surf_reloc` write to `info->dst_offset` without validating against BO size
> 
> ## Summary
> 
> The QXL DRM driver's relocation processing in `drivers/gpu/drm/qxl/qxl_ioctl.c` writes 64-bit and 32-bit values to `reloc_page + (info->dst_offset & ~PAGE_MASK)` after mapping `info->dst_offset & PAGE_MASK` into kernel space via `qxl_bo_kmap_atomic_page`. The `dst_offset` is taken verbatim from the user-supplied `drm_qxl_reloc` ioctl argument and is never validated against the destination buffer object's size before the write.
> 
> An aspirational comment at the top of `apply_reloc` explicitly notes that "`dst` must be validated, i.e. whole bo on vram/surfacesram", but the validation has not been implemented since the driver was introduced in 2013.
> 
> ## Impact
> 
> This is **not** a host-VM-escape primitive (the writes hit guest-controlled VRAM emulated by QEMU, not host kernel memory). It is a **guest-side memory corruption** primitive:
> 
> - A guest userspace process with `DRM_AUTH` (any logged-in user) can write attacker-chosen 64-bit/32-bit values to arbitrary offsets within the QXL VRAM aperture.
> - Targets reachable within the aperture include other guest processes' QXL buffer objects, QXL release-command BOs queued for the host, and ring buffers that QEMU consumes.
> - Corrupting QXL command structures that QEMU/SPICE then parses **moves the attack surface** to QEMU's QXL parser (separate codebase; historically vulnerable). This kernel bug is therefore a viable priming primitive for a guest-to-host escape chain whose terminal step lives in QEMU.
> 
> CWE-787 (Out-of-bounds Write). Realistic CVSS 3.1: `AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:H/A:H` ≈ **5.5 Medium** for the kernel-side bug in isolation. If chained with a QEMU QXL parser bug: higher.
> 
> This is submitted as **hardening / defense-in-depth**, not as a self-contained RCE/VM-escape claim.
> 
> ## Affected versions
> 
> Linux mainline HEAD (audited 2026-05-13). The pattern is unchanged since the QXL DRM driver merged in v3.10 (2013). Commit history is sparse on this file; the issue is structural.
> 
> ## Vulnerable code
> 
> `drivers/gpu/drm/qxl/qxl_ioctl.c:73-110`:
> 
> ```c
> struct qxl_reloc_info {
>     int type;
>     struct qxl_bo *dst_bo;
>     uint32_t dst_offset;          /* <-- user-controlled, copied from drm_qxl_reloc.dst_offset (__u64) */
>     struct qxl_bo *src_bo;
>     int src_offset;
> };
> 
> /*
>  * dst must be validated, i.e. whole bo on vram/surfacesram (right now all bo's
>  * are on vram).
>  * *(dst + dst_off) = qxl_bo_physical_address(src, src_off)
>  */
> static void
> apply_reloc(struct qxl_device *qdev, struct qxl_reloc_info *info)
> {
>     void *reloc_page;
> 
>     reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
>                                          info->dst_offset & PAGE_MASK);
>     *(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =
>         qxl_bo_physical_address(qdev, info->src_bo, info->src_offset);
>     qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
> }
> ```
> 
> `apply_surf_reloc` (Lines 98-110) has the identical pattern for a `uint32_t` write.
> 
> ### How `dst_offset` reaches `apply_reloc`
> 
> The user-space struct is defined in `include/uapi/drm/qxl_drm.h`:
> 
> ```c
> struct drm_qxl_reloc {
>     __u64 src_offset;
>     __u64 dst_offset;        /* user-controlled */
>     __u32 src_handle;
>     __u32 dst_handle;
>     __u32 reloc_type;
>     __u32 pad;
> };
> ```
> 
> `qxl_process_single_command` (`qxl_ioctl.c:141-269`) copies the user `drm_qxl_reloc` array into `reloc_info`, narrows `dst_offset` from `__u64` to `uint32_t` (silent truncation -- still gives the attacker the full 32-bit / 4 GB range), and then calls `apply_reloc`/`apply_surf_reloc`. No bounds check against `dst_bo->tbo.base.size` exists anywhere in the call chain. `qxl_release_reserve_list` only handles TTM placement validation.
> 
> ### Mapping behaviour
> 
> `qxl_bo_kmap_atomic_page` (`drivers/gpu/drm/qxl/qxl_object.c`) computes `offset = (bo->tbo.resource->start << PAGE_SHIFT) + page_offset` and maps via `io_mapping_map_atomic_wc` on the QXL device's full VRAM aperture (`vram_mapping`). The `BUG_ON(offset >= mapping->size)` inside `io_mapping_map_atomic_wc` (see `include/linux/io-mapping.h`) only fires if the offset exceeds the *entire* aperture, not the specific BO. Writes within the aperture but outside the BO succeed and land on whatever data occupies those pages.
> 
> ## Proposed fix
> 
> Add the validation the comment promised, in the per-reloc-info-fill loop in `qxl_process_single_command` (around line 228-244):
> 
> ```c
> +   if (reloc_info[i].type == QXL_RELOC_TYPE_BO &&
> +       (reloc_info[i].dst_offset + sizeof(uint64_t) > reloc_info[i].dst_bo->tbo.base.size ||
> +        reloc_info[i].dst_offset > U32_MAX - sizeof(uint64_t))) {
> +       ret = -EINVAL;
> +       goto out_free_bos;
> +   }
> +   if (reloc_info[i].type == QXL_RELOC_TYPE_SURF &&
> +       (reloc_info[i].dst_offset + sizeof(uint32_t) > reloc_info[i].dst_bo->tbo.base.size ||
> +        reloc_info[i].dst_offset > U32_MAX - sizeof(uint32_t))) {
> +       ret = -EINVAL;
> +       goto out_free_bos;
> +   }
> ```

Please turn this fix into a regular patch that can be applied. If it's
accepted by maintainers, it will save them some time and will have you
credited for finding and fixing this bug.

> Equivalent to checking `dst_offset` plus the write size fits inside the resolved BO. Also enforce a reasonable upper bound on `cmd->relocs_num` to prevent allocation DoS.
> 
> ## Discovery
> 
> Static analysis of QXL DRM ioctl handlers.
> 
> ## Disclosure
> 
> Per Linux kernel security policy, report to `security@kernel.org` and the QXL maintainers (Gerd Hoffmann, virtualization@lists.linux.dev).

Thanks for your report. However, this report is already public via the
virtualization list, so no need to involve security@, and it can be
dropped from future responses:

   https://lore.kernel.org/virtualization/36acd33982bfdce04090e17294596ff8@berkoc.com/T/#u

Willy
