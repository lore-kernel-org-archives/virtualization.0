Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CD10A1C
	for <virtualization@lists.linux.dev>; Fri, 24 May 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520661; cv=none; b=pDHS+iAG8UNN1elFUAdbv+wt49xz/rttM9yh1Bp5ev/5KmcvLzDjdQUNuxneBM+DWMxf7IqR0mKoH5F5ocODpj71I4ZQ8eAyQbKN3i3S9N6t7Plru9BEL34G8B74EXnRgq4yTAnqsG/Leor0pUnQt5zxmKsFSi+9IBCZAzHRw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520661; c=relaxed/simple;
	bh=KZCJ7YhijKwiZJ1xUJ2OGx9s+MymMCK9Uzsvp3M3spU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gGlXZ/gV4t9n4ty4Rsqhy0CG5cQmBWl7c8AB4vL5pwWfqCydrvMKqeFQ8ispcBoRucijIJVJNligkVlQtoXtWBwkiYksx7yvJT0f8zLnWkJWZ9ZqnSobsVOAkIwhMVPEm5wPQnImY1eJyNNht6MFaJnplaqv+KGeJcLc9//R+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADX3eW9BlBmYwAXDQ--.41660S2;
	Fri, 24 May 2024 11:17:18 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/bochs: Add check for drm_simple_display_pipe_init
Date: Fri, 24 May 2024 11:06:05 +0800
Message-Id: <20240524030605.2185210-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX3eW9BlBmYwAXDQ--.41660S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kZF4ktw1kZr4kuFW3Jrb_yoWftFc_WF
	15u3s5Xr9ru3srCFnxZFnYgrWS9a4vvF48Xry2qFZ3tFyfW3ZxJrW2qryfZw4UW3yUJF1k
	C3y7GrZ5JF1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JU-miiUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of drm_simple_display_pipe_init() and
return the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/tiny/bochs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index c23c9f0cf49c..31ad2bc4ee22 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -550,13 +550,15 @@ static int bochs_kms_init(struct bochs_device *bochs)
 	bochs->dev->mode_config.funcs = &bochs_mode_funcs;
 
 	bochs_connector_init(bochs->dev);
-	drm_simple_display_pipe_init(bochs->dev,
+	ret = drm_simple_display_pipe_init(bochs->dev,
 				     &bochs->pipe,
 				     &bochs_pipe_funcs,
 				     bochs_formats,
 				     ARRAY_SIZE(bochs_formats),
 				     NULL,
 				     &bochs->connector);
+	if (ret)
+		return ret;
 
 	drm_mode_config_reset(bochs->dev);
 
-- 
2.25.1

