Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349366;
	b=V4oD3zIPfTFmc4KH1svV4O75gE6QzeYE9lockBh8JXLJPHoJKZIumvDRAuX0cmafSYWz
	 DZyuec1azk0mG4fPwDFoIVq1t29LBNsrmmTbMUbEAmral/+u+gykjhmPgtAquZ0dIyopx
	 pxTpfEOtAB+Qi/3DywuqfazOPKS6ebPJtN+NX0qh67kQXZQwsp0oUcHbIIc++YY8z3C5P
	 FAGJNxGMgVxJPCNkWK4/ZQDIcqTOYJ36pOLxA6OOAkGviJbtJGkGVCE3JXcsV2aciDGm2
	 TjaAa4ypHCPQCm73C0JALoLsSkzWc8JRH3g+lcKd+IfXV/PUOtvAbEccrUvTlCfS1+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
	b=ruTviSvWQUlWrH8hGvT0ufaklYKzDo9aWcjtHHeRAzLkrTbTHhyphN5pt9gR2zBveUdN
	 ICIUTgMV7DGVFdOqq64wg78CHQPI/PI7TvW4d2z6gQFXvgL+455CulGwPZv0Y2bYChwcm
	 KiCMEpdQUYggeI42rA51tz83jCZ2TVTvnCMw3zgjqatvJyt7zA3cpD2uSNJ3CrnRnp+ct
	 kPMsnNm6dWwFYfkFLLAqYLGpiE5DYEhp3n0ILKk4sIshRDW2OMJOOvyF5Cicb89Uo8Qji
	 CN/CJAexrE3ffDSeDVroDbvpGwqoYxyKordKa0fnszbQ7JPM5nTQtaQrBSH2WOutXbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b="dX/3ZzUa";
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2C606A32A
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 12:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE2C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=dX/3ZzUa
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67da62357acso3177323d50.0
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795349364; x=1795954164; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
        b=dX/3ZzUaGE9zA5pHHHQ+A8PQ9FeW89GykMowvaCdu+Tcx8dCVKRstoHd5NmFDoXXp0
         +MYhibVFWGPK+dVM073LKTuJKy7C+QNkxOKchfb1WbL+pk8OaPX3XyePFTdzvhXMj1MK
         s8JIcBbw2qbBic4gzVVj3adC4WCDTr1jAJV3rWvU4FmUG9vGux+J3vHmzeWsabIbNdoW
         QWoxXKk3MWLiCMbT8cuWOO4aCLAD2yqF4st0rKXilDnFVTz4AvCfSO89JbrV0amLOU03
         35mestcldaai0tMnxgN7k4SmcSWBMhvCvrIC4Z4NGgdKwYH9c+Ur2G/MHjlZwju/AOP2
         1wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795349364; x=1795954164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
        b=g/4OaEeaTG5YhRXB22sVRKI9Z5t/Ml+ysoxFCtXohgANLwuFHKoX/8i1AjfwkgUQSS
         vEmCiUtk/yWp2/2enA415I3zFuP1ssjTHwb8PVZNFqlfuQ2XSGY78UKEzWEyAdaJ336+
         3QH5xN7Smc/S7+tyYhl9reYhWfSqHPb2AAEObEtgk/mvtL3+eGen0gEP3J0ONn+p+Rz2
         gCtkIv86MyuRO4LFoSCgwJjY0wYIffe9CGzjEW0TNVb4vze5rYFr+VTT3AUWWjJgvpXO
         oYmzn+WR/47v4RyZMHh5fdmCykjsB5IgK+XIjbrYBWQA+dUmX0XnzCVjzOfCOFIyZU6w
         R1SA==
X-Forwarded-Encrypted: i=1; AL+hErGC1ewI4ANF8pIMWF4d4LYJ1yRlOi5NCuCWs6KEc8RtXX83tzfszIwQ/oHJsS5G83DWV6q2Ixviw7Gy73mGoA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3BjkQuKxMiNcYcvP6JlVzv/Y7B6rhE6aIekmfuyyeamYxo0yt
	70MH6zx7IWdugSyvkAPDj4tvPhtuVQiDBtKgWyMg7k33A9kahx4qVE+xCbgQAyLGgQj54hloD6U
	TkkZXUA==
X-Gm-Gg: AZFdTZcSzSSkvQ7DX6/U/ikHCENqPs+s9XKFeu4SWFx6q8doR6NhpnUDTacyQqPXSM7
	XrJtilt1SXMmSo+DTkVFt0R7XyR9eottFflpq+R2wxe4INJadnYjdYVtV3UjkJ9D7C2LwyYOwqm
	GnEu/shB3Mmu3UpNdIWHMWcTsRI4hSxrZbEF7WPuLwsC49eBZShIBpA1W+FP9keLvgWy6yXSJB4
	9sQ3IeGlYjSnZs2fnR94AQdkcknXwsxTgUSTjDGXOgYUShWB5bhJUX3XwUB8gGwe7L7DFsNpy+u
	he4uFOnzq4cEkNB4vwf+zOVAL40d6aTdST4lFF2icbyEUOz+Hy5BjTXUUCwSOhcEWI1iL3OXeHz
	TtBHQltSDtZC5qQFyXRQlDlrfNJuiWyYoTBj9HvS45NrQSmi8lvDLsy7gxa6LZTL/8pWi2GQSaQ
	9CmXoP5lGKVlsXdN7Pu8XJSG5NcmuNuI/u0v4T6/33m4Wmfva5lQMNsuBatJyYOT4X/o0epD5x9
	x9CrTsBg77Qz8yFTJt7ag2wZScma1O7/fAcBSoFstRgqP2FiM3W2Tddt7jSic0hBBYNLT4SZmaF
	k8NLz1va8xfAj+O39kgIA2Z5pZ11t/JduTDZSlKpKE4CCItmQnhN
X-Received: by 2002:a05:690c:6088:b0:8b4:d26a:aa7d with SMTP id 00721157ae682-8b5204ff21bmr37330077b3.56.1795349364614;
        Sun, 22 Nov 2026 04:09:24 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201ba5absm34801557b3.4.2026.11.22.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:09:24 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 07:09:19 -0500
Message-ID: <20261122120919.1718445-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 333c515d1896 ("vhost-net: allow configuring extended features")
added VHOST_SET_FEATURES_ARRAY. The ioctl reads the number of feature
words from user space and checks that every word above the supported
ones is zero, one word at a time in a loop.

However, the loop has no upper bound and no scheduling point. As of now,
a caller can pass a count of U64_MAX and a pointer into a large
zero-filled mapping. The ioctl then stays in the kernel for as long as
the mapping is readable, and a fatal signal is not handled until it
ends. On a v6.18 debug kernel booted with preempt=none, two such calls
from a non-root user, each on a 4 GiB mapping, froze a 2-CPU VM for
56 s with soft lockup reports.

Interfaces that take an extensible structure from user space limit it
to one page (openat2, clone3, sched_setattr).

On a KASAN kernel with a 1 GiB mapping: before commit 333c515d1896
("vhost-net: allow configuring extended features"), the ioctl does not
exist and the call fails with EPERM at once. After that commit, it
fails with EFAULT after 26.0 s. With this patch, it fails with E2BIG at
once. A reproducer is available on request.

This patch will reject counts above one page of words (512 on a 4 KiB
page, or 32768 feature bits; 128 are defined today) before the walk
starts.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on the vhost tree at 44293796526f with KASAN and lockdep: counts
of 0, 2, 3 and 512 words still succeed, a nonzero word above the
supported ones still gives EOPNOTSUPP, and VHOST_GET_FEATURES_ARRAY is
unchanged.
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 631855064b3d..22e06b44d2ed 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1795,6 +1795,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 	case VHOST_SET_FEATURES_ARRAY:
 		if (copy_from_user(&count, featurep, sizeof(count)))
 			return -EFAULT;
+		if (count > PAGE_SIZE / sizeof(u64))
+			return -E2BIG;
 
 		virtio_features_zero(all_features);
 		argp += sizeof(u64);

base-commit: 44293796526f4343639f87b2acc53811c78b5d54
-- 
2.53.0

