Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DFE3F1AC4
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595416; cv=none; b=BCR6KEZl00NAH4zggTXmCyzk6GLZGIeSFs1PnEdSkzCYmzuSA8HU0CWKorQE/nyySkkE8bGzSzOzfLK87QPD5A1ajkj37EEQbsR2dM88LIuzGpHS3DAngvQd04PmlXQHNR46BK8B23ORdVpi2S3Wj/3NzdhJhdY9P6H4oYueVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595416; c=relaxed/simple;
	bh=Jf1Z3wiUSnHmBFlRFZCz2LuluHz3SAmuUlW9niHQURk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m6vHdXfsN6mulyqTk/ZOXwLkbz4Bfmb1L5BYbPWlBjz3dGEPPRMX25DymsrmXFv4CSdcuZlngXgoM7sGdEF3+4ZyOIqbTH+kCkLL4YZJGpAaDtaw7WbLp7VVt4WJWFEINu7/YV/5FCPYl9W59CRgySEXLq54fJVbS8TJH3nxgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBeMWZxE; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBeMWZxE"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so6025965ad.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784595413; x=1785200213; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dVZeqaiAWbMoulLNM+KQI45sBsT7cMtZAQ/ZsFxQyUg=;
        b=iBeMWZxECYpRwTUZnK/snC2X825IuMD8ZAEVmC+wlHJZoNIpJx15/SVnAtshk7k8/c
         +DDpXYTBD79QCq/whxlIz8h/cq+7zfAfos7CDD39oC8iMC5QBWYDhiOBT28EM6FMLJt5
         G9mLyC+a8VKdM0LkHbpmjU5lcGP0f4t8e0i9ObMJSupclOGUFhdhhwyTNyL4aW1PCKQw
         Xq6EBlgGRYDtNAtvEW10dti8uzQCFtF7C46ymqI8XilLyNpzuCbkZJIqFKLzQPcUiWRi
         30DHIH3qtXZ/SZ8Rm5mSYtS+Mom+pmQm3X9Xr0pKEmEAGtzu0TpQU2RMSA29rb0jvNxS
         So4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784595413; x=1785200213;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVZeqaiAWbMoulLNM+KQI45sBsT7cMtZAQ/ZsFxQyUg=;
        b=SKcRtmjOc0T9QVN9gM8CylWI+rUh6s3iMiHMCOJ5yPwKZV1eY7Zk04FobJfvSStjYF
         U15TgJjHD+yrggChGNQM4jjSljNbD7EmSLua3xhZtSArKCHXHlqnr71KZdYuxsLicloh
         v47i0a1Mumw9JfpPnfCwyP3IM7YUhcsCS1vHx2hhQeGTYWFrhEb4liIGg4dwvXcbLyxB
         o8ab7dgOq+AA8ZGc1vcSuWrzI/c7oVWrCQ9MIfICmqeyL9096DE7+4FS+PD001+ffWPq
         5NlLHCmJQO1n1GSRMYK3k2kAi5sia6DyfjQFLzgAolHdN0lp0tiZuFr166sxLamM21Fa
         WBYQ==
X-Gm-Message-State: AOJu0YwmkE7y3d5p9unEXM1kX2znMulyIikI0z7PyTTjNgx6EXYdq9nb
	H3/nxr40R+auM0Tg4+4xLdHmmFa0bmARKH8l7zwNJqiKPFt7FiKgcZvWDS1eEnOZzgxtirxFf/t
	MFg==
X-Received: from pjbng10.prod.google.com ([2002:a17:90b:1a8a:b0:38e:7f2c:2c4b])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3886:b0:36b:944b:fd81
 with SMTP id 98e67ed59e1d1-38e4b3d27c3mr16883838a91.4.1784595413290; Mon, 20
 Jul 2026 17:56:53 -0700 (PDT)
Date: Tue, 21 Jul 2026 00:55:33 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721005603.1710551-1-linkl@google.com>
Subject: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
From: Link Lin <linkl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

During PM freeze (e.g. S3 suspend or S4 hibernation), device drivers like
virtio_balloon reset their underlying virtio devices and delete their
virtqueues via vdev->config->del_vqs().

However, page reporting work (page_reporting_process) was scheduled on
the global system_wq. Because system_wq lacks the WQ_FREEZABLE flag, the
PM freezer skips it, leaving page_reporting_process active during suspend.

If pages are freed into the buddy allocator while suspending (for example,
when core MM invokes the balloon shrinker during S4 hibernation image
saving), page reporting triggers virtballoon_free_page_report() on deleted
virtqueues, resulting in a Use-After-Free / General Protection Fault:

    [  196.795226] general protection fault, probably for non-canonical add=
ress 0xaa1436fe70dae6df: 0000 [#1] SMP NOPTI
    [  196.825967] Workqueue: events page_reporting_process
    [  196.831038] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
    [  196.927073] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
    [  196.946943] page_reporting_process+0x370/0x4f0

Fix this by switching page reporting work to system_freezable_wq. This
ensures that the PM freezer pauses page_reporting_process before device
drivers destroy their reporting virtqueues. Because the reporting worker
is frozen, memory reclamation/freeing (e.g. via shrinker execution) can
safely return pages to MM during freeze without triggering unfrozen
reporting work on deleted virtqueues.

This aligns with the driver's existing design. The comment in
virtballoon_freeze() states:
    /*
     * The workqueue is already frozen by the PM core before this
     * function is called.
     */

Testing:
I have verified these fixes using Google=E2=80=99s virtualization infrastru=
cture by
running continuous suspend/resume iterations (40+ cycles) while churning
memory using stress-ng (`stress-ng --vm 4 --vm-bytes 60% --timeout 1`) to
constantly create free pages for the buddy allocator. We also set the
`page_reporting_order` parameter to 0 to make the page reporting worker
highly sensitive, forcing it to pick up any 4K free pages. This confirmed
that the UAF crashes are no longer reproducible.

Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
Cc: stable@vger.kernel.org
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Link Lin <linkl@google.com>
---
v3:
  - Dropped Patch 2/2 (virtio_balloon shrinker flag). Freeing pages via
    the shrinker only returns pages to MM; with page reporting work now
    properly serialized on system_freezable_wq, shrinker execution during
    freeze is harmless and requires no additional locking/flags in
    virtio_balloon.
  - Link to v2: https://lore.kernel.org/all/20260717002311.681748-1-linkl@g=
oogle.com/

v2:
  - Split into a 2-patch series including explicit shrinker fencing.
  - Link to RFC: https://lore.kernel.org/all/20260709224330.946683-1-linkl@=
google.com/

 mm/page_reporting.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 7418f2e500..4dc6f4b852 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -80,7 +80,8 @@ __page_reporting_request(struct page_reporting_dev_info *=
prdev)
 	 * now we are limiting this to running no more than once every
 	 * couple of seconds.
 	 */
-	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+	queue_delayed_work(system_freezable_wq, &prdev->work,
+			   PAGE_REPORTING_DELAY);
 }
=20
 /* notify prdev of free page reporting request */
@@ -343,7 +344,8 @@ static void page_reporting_process(struct work_struct *=
work)
 	 */
 	state =3D atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
 	if (state =3D=3D PAGE_REPORTING_REQUESTED)
-		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+		queue_delayed_work(system_freezable_wq, &prdev->work,
+				   PAGE_REPORTING_DELAY);
 }
=20
 static DEFINE_MUTEX(page_reporting_mutex);
--=20
2.55.0
