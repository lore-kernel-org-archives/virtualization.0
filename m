Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1EA4B04B7
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069630; cv=none; b=rEf9+qHxTC+Ml4GCOGh06p/+3l7iyk3GQZcCmtrGKpiI1c7+JpF8f7cBfcd6wE+Ul47iwtRDCdUIyMZxhuO9WW53sTZuW/NUSx3xOZbmdu/b8pfeizc7U84pT9W7S5eKbKZQFRIPY90R+hoWCZvhuFqxrqtMliesDhfn/RgcQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069630; c=relaxed/simple;
	bh=0sIHYHXmj4kfkFzJUw5iipjWTE9r6gD6R63u5QZ378E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dd2kr1dIlRDet+MhLwWoTRFkx+wMJL4RaHnZ/bqHfz3z5gheu4V/fdkH7bwC+usYNpFBclQzMflyJeWvIbeS4EyXjufIbbz695tHcMSESUgRfUSDfzq5MNVsGh6nzdJhHFn9VUZE867ucbL9ucGzhRmCBWA2LexE2hwGoue6wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvf19rgL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvf19rgL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cfff5f88dbso41849845ad.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 19:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786069629; x=1786674429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rt72B6lVkq2wOx7y/7/IbB63EiyH3V4VoZfX5qtaWOk=;
        b=fvf19rgLIqCMRhN/rfbLRvFt3CZa5lpTmNlCkD2K5FhaR3HRYnTbBf9ZKkIZbMftCE
         5bQPYA16tMdvezLOj67GklRMDR0F3JZZzd6OXE0+cM4mHJ2KP50wEO59TkYbE9GlmUEV
         ZQZm08LfW71WX2J/oK1adXCqPCRJJQ0s/SsaYjyBQ3wV8RM73voJymDZ15FIk7Y6wLDM
         ktaYIL9T7BuLIG5FRsbM8wCFFlaIxMkC5/PBhUErJJPxFo8Kq13212fPru4vNcGMDQOQ
         c/3v/+1SbdfrKhv1aFs99Egz6i2WpzWmZxnCgqZBuSX3mX1yZ8D+BmZ0vE9e1PaT5/Q+
         Yn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786069629; x=1786674429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rt72B6lVkq2wOx7y/7/IbB63EiyH3V4VoZfX5qtaWOk=;
        b=ngDyrUmHiBaQ5igv4m+oaUavU3pkg1erVdZnnACjbzh7sKRtKWdJzgkUsD+XS1uHcy
         K+pUO/PkC59TuOls/emZ2eaJsSAllD5uE8yC79nGbndczcMPib76r0oAYYg0BQOaKTXH
         xQh83+cUG/OVam8krJv4kmUn9MbXyHsQor0pfjyBLMyxHnh+q9sBQxMinx0nezXYYCWS
         7GvGf6Ob3CDzb/yrDpqg6vr32KeBUeC8/P44m1p6YK6CSBKIpMAOtnbR1PCuUN1Tc9DM
         BBM/6dNmJNRsV5G+lS3fO670cx6Vft+cJoIvFz8CxIyZWR9VfooN1wE7+rffMgKVryVn
         0vig==
X-Gm-Message-State: AOJu0YzjTkbgjwBOh7eZvIlPCQkbTF7St34c2ea8ePBYtau4QqShnZOV
	ICBlwGjNt1mPN0cS+fmkvc0HKHDIDmUADZIiNMNRt97ZALyvuxGxu1r2
X-Gm-Gg: AR+sD108ZGroj4sfqzC0WreiOQXByoDOAHzI/mgN0/ON7575Fgr3QcguTM7XNTuH07A
	YoQB1QezilUomBM++jlg6b9DPpv37Tezz0VUwLhaa/mR69qThNRgn7li7t7+4QtP0wlJSWEprIV
	rY0heR/6zpwqVBzbN/j9B6GoKQ38MAVf5TA3I77l6MhL2A647UllLaHTWkwro98Br5GisfToK3h
	XLaiQiaxQ8yfMDGjMQ40xl/XRfHIQbtvt/r1UGKxnJYEiCJpP7fWawSYRp/x5Hv6i6r4rJFvtrO
	wCWD/qSNvuUXrYaSHcEWN9K2nLDLs1IzN3rZdR+Z84JRuCIUZKFgZMsho2dFAtzPxpx7HPdBMoE
	o05wab9nVnpjRTqPE2fA4jXnJW4QmOUGuW3zDlFrOW3ha/arrtwYQGhSEAcXOjaWmihsq6sT3/8
	nUsYQ9BAUvHQiXdGA2qIr6XYrZol7TwCiizWhsRkumgw42StONsa9XJeISil5A1w+ODJ7M3GBSe
	/M8hzZ3eFPvbqo3P4p/nAvb5uvgrepg+HuUSZtWWiNR10aKgQVpDUA=
X-Received: by 2002:a05:6a21:a04:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3cb85ef91f7mr24553793637.20.1786069628776;
        Thu, 06 Aug 2026 19:27:08 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm1843082eec.18.2026.08.06.19.27.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 19:27:08 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] vduse: reject non-coherent iotlb entries in the coherent fault path
Date: Fri,  7 Aug 2026 12:26:57 +1000
Message-ID: <20260807022657.11318-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vduse_domain_get_coherent_page() turns an iotlb entry into a struct page
with pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT) and takes
a reference on it, with no check that map->addr is a physical address.

That assumption only holds for entries created by the domain's own
coherent allocator (vduse_domain_alloc_coherent(), which stores
virt_to_phys()). VDUSE registers its vdpa device with use_va=true, so for
a use_va device vhost_vdpa_va_map() passes a userspace virtual address as
the map address, and vduse_domain_set_map() copies those entries verbatim
into the same domain->iotlb. Both kinds of entry share one tree, and the
mmap fault handler only splits them by iova < bounce_size, so a use_va
entry placed above bounce_size lands in the coherent path.

A userspace daemon can exploit this: bind the device to virtio_vdpa so
the coherent allocator mints an entry whose backing file is the domain's
anon inode, obtain the domain fd with VDUSE_IOTLB_GET_FD2, rebind to
vhost_vdpa without deleting the vdpa device (vdpa_dev_del() only calls
_vdpa_unregister_device(), so the domain and the fd survive), install a
VHOST_IOTLB_UPDATE over the same iova with an arbitrary uaddr, then fault
the domain mapping. The kernel computes pfn = uaddr >> PAGE_SHIFT from
the userspace value and hands the daemon a struct page for a pfn of its
choosing -- an out-of-bounds vmemmap access for a wild value:

  BUG: unable to handle page fault for address: ffffea8000000008
  RIP: vduse_domain_mmap_fault+0x100/0x330

or, for a value that resolves to a valid pfn, a read/write window onto an
arbitrary physical page (confirmed: a write through the domain mapping
lands on a page selected purely by the fabricated pfn).

Coherent entries are always registered with domain->file as their backing
file, while entries installed through a vhost IOTLB message carry the
mapped vma's file (vhost_vdpa_va_map() stores get_file(vma->vm_file)).
Reject any entry whose file is not domain->file before calling
pfn_to_page(); the fault then returns VM_FAULT_SIGBUS. Legitimate coherent
mappings are unaffected.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 4dc76c0..847f010 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -221,6 +221,7 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	u64 start = iova & PAGE_MASK;
 	u64 last = start + PAGE_SIZE - 1;
 	struct vhost_iotlb_map *map;
+	struct vdpa_map_file *map_file;
 	struct page *page = NULL;
 
 	spin_lock(&domain->iotlb_lock);
@@ -228,6 +229,17 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	if (!map)
 		goto out;
 
+	/*
+	 * Only coherent allocations made by this domain are backed by a real
+	 * struct page here: their map->addr is a physical address and their
+	 * backing file is the domain's own anon inode. Entries installed via a
+	 * vhost IOTLB message on a use_va device instead carry a userspace
+	 * virtual address in map->addr, and must never be fed to pfn_to_page().
+	 */
+	map_file = (struct vdpa_map_file *)map->opaque;
+	if (map_file->file != domain->file)
+		goto out;
+
 	page = pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
 	get_page(page);
 out:
-- 
2.43.0

