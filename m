Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3F13C80B;
	Mon,  6 May 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005842; cv=none; b=bCVbz8aF2PGEAwx9fTXk29qcS0LzceAyTHfkZRbY/q3D0dtkn+QBxW1FYoXcliAu7zW1IsiPj+Pw38qSQ/PKP0v9iD0rA/3ITNVegV6ziT9LOUhu1R5AiRg/nxZjQV2QtOQEQrziuNCNFfaC8vbxRE2Ir5oVS01T4DGy/Jxkvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005842; c=relaxed/simple;
	bh=74avidpj6lHrcnz5DWt9tVaHKTbGh3voPFwrs+2HjNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keAB9BPqxgyVu/LGNkl5B4a+sy++C3WW11nRjo+smgYwOIHlISBDd8sPIcoxVOk2w/s3oVOx2PctM6WX/VfotU7XsSFErRqx8oIfo0wS5YJUORBSkRYGzhkNXgFwaOz5U5FkZk9RR/u4l60wCNYCYqIqgq0rKb510cO5i/QGUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EXx4/WGx; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EXx4/WGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=74avi
	dpj6lHrcnz5DWt9tVaHKTbGh3voPFwrs+2HjNg=; b=EXx4/WGxoek2QHnlkBoTc
	jRTT0OXc0BvIlIVVgO4dT8CHDkcMpwiNeUaEzYExIs9yWALPn7/aDuzvWZ9Y6hRX
	HDS/r3IY8rE8LFipmebk2F6XSCDnHIVRI1EC0jT7tkmEtYmi8SpI+gNRCAxHLuHh
	Q9yvqf/kUyr/KaAeMjbyu4=
Received: from localhost.localdomain (unknown [111.35.187.227])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDXL_Fr6ThmQiFiBA--.17029S4;
	Mon, 06 May 2024 22:30:09 +0800 (CST)
From: David Wang <00107082@163.com>
To: 00107082@163.com
Cc: airlied@gmail.com,
	airlied@redhat.com,
	daniel@ffwll.ch,
	dreaming.about.electric.sheep@gmail.com,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: Re: [Regression] 6.9.0: WARNING: workqueue: WQ_MEM_RECLAIM ttm:ttm_bo_delayed_delete [ttm] is flushing !WQ_MEM_RECLAIM events:qxl_gc_work [qxl]
Date: Mon,  6 May 2024 22:30:03 +0800
Message-Id: <20240506143003.4855-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430061337.764633-1-00107082@163.com>
References: <20240430061337.764633-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL_Fr6ThmQiFiBA--.17029S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUngAwUUUUU
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEBPWqmVODy8hSgAAsf

The kernel warning still shows up in 6.9.0-rc7.

(I think 4 high load processes on a 2-Core VM could easily trigger the kernel warning.)

Thanks
David

