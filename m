Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E445190473
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718251; cv=none; b=AP86C9dCQUb1gcl/p6uexJRPNMr82d2vD2uW41RlmKEUwof0qeBcGtxUIBy3TO0ynjJWvOZTtHncbExOKzk4UyTFKa7J3DCpU0API3hkfblXac6LcSWxMraykee0+d1I+NRBSzuIYZ0O9PzpcIuAihX/xkfB+5MFdadq6TQT+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718251; c=relaxed/simple;
	bh=1lSxn84Masa10X1bQBBHncJrbpXCih2ed4ZA9iqfu+k=;
	h=Date:Message-ID:From:To:Cc:Subject; b=eN577WoQJAyuaHKZMK+1TknyE+d3koTmwfVaPEvCfm8b6ocNnaf93Lc7RBqsMIwVN8Vdu6uFwereXXO/SNLhDMd7mIYj1b9uwNzL/WCKxSu+0RjcQ02MtS0pE2HsFUpH8MfI1Dpzuzs8ufBnF/vWZ8imambU71inFMlKiUsTzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=F/Zp4HUs; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="F/Zp4HUs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Subject:Reply-To:Cc:To:From:Message-ID:Date:Sender:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RYtJUrFo8+8tWjBXE9igp7MAI+rioIToXtESNe9qICs=; b=F/Zp4HUstCkZzsivKPMvxgWXmg
	V6uZ8D7NMP5qxLxLyJ+diiiygguRvZRLKMDaWmsO+hbceRDxPA7CJJTEzTFVhB25qNEjnz2rtXHpo
	FUlxa1l0CMjGejV9D9ynxAnCoRQuI+BkJ4tiQZr9tjiTHcvmKZkjoQDjin3Zv9aXNiGKxe0R/fLM4
	ynZXFoaEuqIMzdp8/pS4kmvKZIUieOJIX/a95lbXFW+ZV4Bhl3e21tngYcS5D7Bd+305Lvj5YhaI3
	cgG3mjs6evTOZpQybc2JT5qsqfL7OehMW18EjUwZ9+cJQTG3+TaUdySaYDIfaIub5XgNjSk/LRHO/
	QqwWcVxg==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wNJcE-0035Lu-0U;
	Thu, 14 May 2026 00:07:51 +0000
Date: Thu, 14 May 2026 02:07:47 +0200
Message-ID: <36acd33982bfdce04090e17294596ff8@berkoc.com>
From: me@berkoc.com
To: security@kernel.org
Cc: virtualization@lists.linux.dev, berkantkoc@proton.me
Reply-To: me@berkoc.com
Subject: [Hardening] drm/qxl: apply_reloc/apply_surf_reloc write dst_offset without validating against BO size
X-Spam-Score: 1.0 (+)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

# QXL DRM: `apply_reloc` and `apply_surf_reloc` write to `info->dst_offset` without validating against BO size

## Summary

The QXL DRM driver's relocation processing in `drivers/gpu/drm/qxl/qxl_ioctl.c` writes 64-bit and 32-bit values to `reloc_page + (info->dst_offset & ~PAGE_MASK)` after mapping `info->dst_offset & PAGE_MASK` into kernel space via `qxl_bo_kmap_atomic_page`. The `dst_offset` is taken verbatim from the user-supplied `drm_qxl_reloc` ioctl argument and is never validated against the destination buffer object's size before the write.

An aspirational comment at the top of `apply_reloc` explicitly notes that "`dst` must be validated, i.e. whole bo on vram/surfacesram", but the validation has not been implemented since the driver was introduced in 2013.

## Impact

This is **not** a host-VM-escape primitive (the writes hit guest-controlled VRAM emulated by QEMU, not host kernel memory). It is a **guest-side memory corruption** primitive:

- A guest userspace process with `DRM_AUTH` (any logged-in user) can write attacker-chosen 64-bit/32-bit values to arbitrary offsets within the QXL VRAM aperture.
- Targets reachable within the aperture include other guest processes' QXL buffer objects, QXL release-command BOs queued for the host, and ring buffers that QEMU consumes.
- Corrupting QXL command structures that QEMU/SPICE then parses **moves the attack surface** to QEMU's QXL parser (separate codebase; historically vulnerable). This kernel bug is therefore a viable priming primitive for a guest-to-host escape chain whose terminal step lives in QEMU.

CWE-787 (Out-of-bounds Write). Realistic CVSS 3.1: `AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:H/A:H` ≈ **5.5 Medium** for the kernel-side bug in isolation. If chained with a QEMU QXL parser bug: higher.

This is submitted as **hardening / defense-in-depth**, not as a self-contained RCE/VM-escape claim.

## Affected versions

Linux mainline HEAD (audited 2026-05-13). The pattern is unchanged since the QXL DRM driver merged in v3.10 (2013). Commit history is sparse on this file; the issue is structural.

## Vulnerable code

`drivers/gpu/drm/qxl/qxl_ioctl.c:73-110`:

```c
struct qxl_reloc_info {
    int type;
    struct qxl_bo *dst_bo;
    uint32_t dst_offset;          /* <-- user-controlled, copied from drm_qxl_reloc.dst_offset (__u64) */
    struct qxl_bo *src_bo;
    int src_offset;
};

/*
 * dst must be validated, i.e. whole bo on vram/surfacesram (right now all bo's
 * are on vram).
 * *(dst + dst_off) = qxl_bo_physical_address(src, src_off)
 */
static void
apply_reloc(struct qxl_device *qdev, struct qxl_reloc_info *info)
{
    void *reloc_page;

    reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
                                         info->dst_offset & PAGE_MASK);
    *(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =
        qxl_bo_physical_address(qdev, info->src_bo, info->src_offset);
    qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
}
```

`apply_surf_reloc` (Lines 98-110) has the identical pattern for a `uint32_t` write.

### How `dst_offset` reaches `apply_reloc`

The user-space struct is defined in `include/uapi/drm/qxl_drm.h`:

```c
struct drm_qxl_reloc {
    __u64 src_offset;
    __u64 dst_offset;        /* user-controlled */
    __u32 src_handle;
    __u32 dst_handle;
    __u32 reloc_type;
    __u32 pad;
};
```

`qxl_process_single_command` (`qxl_ioctl.c:141-269`) copies the user `drm_qxl_reloc` array into `reloc_info`, narrows `dst_offset` from `__u64` to `uint32_t` (silent truncation -- still gives the attacker the full 32-bit / 4 GB range), and then calls `apply_reloc`/`apply_surf_reloc`. No bounds check against `dst_bo->tbo.base.size` exists anywhere in the call chain. `qxl_release_reserve_list` only handles TTM placement validation.

### Mapping behaviour

`qxl_bo_kmap_atomic_page` (`drivers/gpu/drm/qxl/qxl_object.c`) computes `offset = (bo->tbo.resource->start << PAGE_SHIFT) + page_offset` and maps via `io_mapping_map_atomic_wc` on the QXL device's full VRAM aperture (`vram_mapping`). The `BUG_ON(offset >= mapping->size)` inside `io_mapping_map_atomic_wc` (see `include/linux/io-mapping.h`) only fires if the offset exceeds the *entire* aperture, not the specific BO. Writes within the aperture but outside the BO succeed and land on whatever data occupies those pages.

## Proposed fix

Add the validation the comment promised, in the per-reloc-info-fill loop in `qxl_process_single_command` (around line 228-244):

```c
+   if (reloc_info[i].type == QXL_RELOC_TYPE_BO &&
+       (reloc_info[i].dst_offset + sizeof(uint64_t) > reloc_info[i].dst_bo->tbo.base.size ||
+        reloc_info[i].dst_offset > U32_MAX - sizeof(uint64_t))) {
+       ret = -EINVAL;
+       goto out_free_bos;
+   }
+   if (reloc_info[i].type == QXL_RELOC_TYPE_SURF &&
+       (reloc_info[i].dst_offset + sizeof(uint32_t) > reloc_info[i].dst_bo->tbo.base.size ||
+        reloc_info[i].dst_offset > U32_MAX - sizeof(uint32_t))) {
+       ret = -EINVAL;
+       goto out_free_bos;
+   }
```

Equivalent to checking `dst_offset` plus the write size fits inside the resolved BO. Also enforce a reasonable upper bound on `cmd->relocs_num` to prevent allocation DoS.

## Discovery

Static analysis of QXL DRM ioctl handlers.

## Disclosure

Per Linux kernel security policy, report to `security@kernel.org` and the QXL maintainers (Gerd Hoffmann, virtualization@lists.linux.dev).
