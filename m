Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1D261588
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530569; cv=none; b=liagt/k2D1gKeWU3D+p1dlJXai8ZF7Mz0nVtQWZQbmZ+KNCQrrrBzH/Og7FoBvzxRBBodnbO1CQbgwkl6ZooVlopm9VQhtX5ZvoqV3fl2jdv7AixeV9R6ssP9SuOsp+1DmOkdCnCPudBcTDWMOUWRi1uiY6QILc84TqWhEHI0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530569; c=relaxed/simple;
	bh=7za5Sd2CGbYsFXxwOnGNM8Jslwis+pCwNRd0c2y4a64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fd3bbJsMBOjU0y1pq0YodfJ/Y+YjNKSeABvGSGTKdodZrlamI5S/IV52ixFupP9RvlptjQgvwm3FsbWA+bswIJcuO+QH3M2ozy5qHY9TwmzGcatjIcBn4697aEKPrNccpp7bvK9D7jnha7lnOzJcBorkD6+unaY6zQpLhPZgThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fX6OukSs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fX6OukSs"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ece1102998so538957f8f.2
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530566; x=1763135366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq4MExtB76y0zEBbNqiZC5rZ/xWdqQI6U2spz/c6ZLQ=;
        b=fX6OukSsJvttVDHycyg32axf2VibaYSCUkG/lIGjJ3R6rqxOCBCAxZgPeO2n+UVcHD
         Yipp2G1rUroobNposzYeOCJzsyo0LtDG96UqJT+IZzWUfti9R+/yWgnB5Fkl4CzxhwAa
         BkaCFb/R6ZumsUnl5/hWWkeRlTJeYRy1ArTSxukkQGLMMZorjjyM4g8t8lyIlMEw8nDY
         QzGV/rvoC4ybn1F63UbGl/wi+lRxeb0NFY+5D7UzS9WKfX+PwjsMj2PNjaCMd001aDv4
         rt50buPtWKF579t2HcY38a5RS4/nbrfvmFMfmG2rqbLpYaW8bce9POm5ALSSWjtFq347
         et/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530566; x=1763135366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qq4MExtB76y0zEBbNqiZC5rZ/xWdqQI6U2spz/c6ZLQ=;
        b=cCAxY4B5xgbL3+QDYHGs5nE6nZ+zOBvY3lvWCdI1hFEN4HWQtLoBJbHGuiNIxgt0Kx
         gBE60dvCJMySggYviHqcbBxp2hDlO8xqnbwz0pDRr5Vox9CIBUUHtg2LG6bSRkCmdeU3
         Ad+bMCU80STUTJk92Nw9MTryZq+dd/avkAoo4PmVKE0KmwmTfGFZUYnoIEYxinlGrtL1
         n7ip06TfjuL7nnz1JjZFay3+0R0OYNjAIFUAxmLIjgM2VRNWQ+kORt+Uhh916d6b77qc
         ZvjG0owTGwkZwA0ZyxJeBTm7jKa31hWBMaw3n+4CvkWKVpPRvVVcYs0/fHq3l06M7SIB
         XZEA==
X-Forwarded-Encrypted: i=1; AJvYcCVMLDcOP82qp/ULCZaEFZrzpI9dEVq7yLsN8NRDQ/Begk/3rE10usiid9KEVJYsdhYxgB2gH36Er90x/s1axg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNKiY22qwmHy8BQ9dTKgtSEabtIs5i7l3V2Tc9tqQJ1kuHGBjs
	+dIPwMNCv8H+tA81X6o6IoTw97TONlX0is9IPlouRmIgKOh4eH8iP8VT0XQfGNB06wk=
X-Gm-Gg: ASbGnctL4GGVpyVF9mNNxOrYtb2Dy/4LbalhMouTgyC/Sazag0KUP+96ffXi61iJFxs
	OaBED0VCRKIsvPjFnkswv8L7GI8YcHOsUWDrjPO84nhFHTnW/MGEx16SB7g6QYwsoq7sRjYM5j9
	ZtoJi0b2jEQFvn1Z2jWDxt6F3spNk7tMwhZHs57b/fg7IDg3SdFc3xF5sNRaWKmSi289s9e9rIZ
	wV1TKoNN649rhnhNfheqwdrM+jBq5djwNnNo6bEnHKzWfEGwZghqIm52BiCd63/xm3sXFaTd+5W
	gqylbPbvx2m1egNr0Qw8PVVVtS2PNxqRM7jaREzYqSLhS2HCiEw3HwaRvZnyi2yCXTzlJeve5N0
	fg9pS6NuKWl8gVpvthLHtXxh27piSgitVxb/UikmVyM3+om/beKF29EjUkoxV4oCtcOenihTe1a
	wXPpUQAzA8T3v13tqZG7o4kkPzQ+o0VUJoUoo=
X-Google-Smtp-Source: AGHT+IEhUIEI5+F913Bjhs0+Zl1YPWT7epmOweSo2OlY5tR346YUfwrdeSsWD37i1I0Bd1XqYIQHwA==
X-Received: by 2002:a05:6000:3110:b0:429:f01d:dd83 with SMTP id ffacd0b85a97d-42ae5af3b50mr3391420f8f.62.1762530566060;
        Fri, 07 Nov 2025 07:49:26 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5875338f8f.9.2025.11.07.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:49:25 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH 1/2] virtio_balloon: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:49:16 +0100
Message-ID: <20251107154917.313090-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107154917.313090-1-marco.crivellari@suse.com>
References: <20251107154917.313090-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/virtio/virtio_balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1b93d8c64361..74fe59f5a78c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -983,7 +983,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_del_vqs;
 		}
 		vb->balloon_wq = alloc_workqueue("balloon-wq",
-					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
+					WQ_FREEZABLE | WQ_CPU_INTENSIVE | WQ_PERCPU,
+					0);
 		if (!vb->balloon_wq) {
 			err = -ENOMEM;
 			goto out_del_vqs;
-- 
2.51.1

