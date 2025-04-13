Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190431C5D56;
	Sun, 13 Apr 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564271; cv=none; b=ZpHpSWvCtiUm2VbMpJJZXZ2mRXdB+QZ7k22sIHhh6tZP8KDBZmpLPUehjcMu7GlRbzMX/WwymipseBxYamqbje66RJ68nOvmSjIVtb34flKC4N13F0qAkArr/26jpkHwRyf/UdPYouiyZEIzXKdCURtUHFTRY8lonW0Z36c5cRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564271; c=relaxed/simple;
	bh=Dd00MAcQXaBwzX5oHPO/PZyvKrghrdBUXv9jtXcuSEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDbiISjCU8w6GTFWs3b4svufWy9fDI8KpxLOZfOfHFS1fVPniZa57R38p6YjtJFwGVyjgEXzUiQu5RYZ/gTfMFONiQ0PqnQaH0EuO/LJwr6Mx/Cy4Pw/3lfWPim7UPdxyLGi1GZaQUNrKwlWNHsWA2xIeVHAAadNRtomhrYuoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gXQb7WEx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gXQb7WEx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zuyyklr2NSR5SZnTYhW13D4u+H13Qg7A3uaAtI3DJS8=; b=gXQb7WExS0sZ2bjQ
	Tqch/B6Ur8i7yedpK714X8cDhVuGKbeEySlmK4VMq8L9r/SlTGFsRiGBZJYe1t4lceS6ZpSB+VGBo
	ronFZzxmrHTPUtivRylrlPxjKTtGwT48FK6wpX2Ld+sImOIJwaxu+D56rX4FGwOyuUKnVEdo06eE1
	XKP0x5CiZgNPiKzFmo7fpMboyK8hBZdkzQTzCasdtAGRTIMQg8mZWeodwfu0p7S+RTo4NWXD0E71U
	n2Fd/yX83DJrmarZ4jr/aq1dQVUeu4s+yNPRpfnz5pLG2ZRsHqg2104d56et4qhA8INz/baUVUggp
	fpj89oTb0JfBnA+3IA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u40rD-00B22s-1j;
	Sun, 13 Apr 2025 17:10:59 +0000
From: linux@treblig.org
To: kraxel@redhat.com,
	airlied@redhat.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] drm: qxl: Deadcoding
Date: Sun, 13 Apr 2025 18:10:56 +0100
Message-ID: <20250413171058.271234-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A couple of small deadcodings for qxl.  The first
just cleans up a couple of trivial unusued wrappers.
The second cleans out some debugfs code that's been unused
for a few years.

Dave
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (2):
  drm: qxl: Remove dead qxl_io_flush_* functions
  drm: qxl: Remove unused debugfs code

 drivers/gpu/drm/qxl/qxl_cmd.c     | 10 ----------
 drivers/gpu/drm/qxl/qxl_debugfs.c | 29 -----------------------------
 drivers/gpu/drm/qxl/qxl_drv.h     | 12 ------------
 3 files changed, 51 deletions(-)

-- 
2.49.0

