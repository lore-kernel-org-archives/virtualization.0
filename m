Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4A305047
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104427; cv=none; b=jn+8o8uMOJ7IIczSYISxn43zuUjS+mxP9JHh2LeUQHuNlcbXUOcyw8e3VWa4JPiWfM1xuSswk6DGbw0yf85cIM632EzeId2tzp1MMOo3jVtn1X9edD6+5jwEBCKSfFkqmNCaXFm54WXBGTrU/mdrU05U8+WS6FKFByATfyuK8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104427; c=relaxed/simple;
	bh=U6JR/PoX3S+8pkFQ9lQp6OpGeokwyfDEgky1PWHD/+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TwOcU0Tpe7jNomxd8tEdT/YCtPh8rZhp/a5cKawKTtKQyZFAiB89kJmZQeHzOZD1dh4M34sWSUUCbeRBW7omUiyRXt7jCpot9zXZrCISwQkUAOyQaJl0fNLt3VQ66QHsaH8JoHZMjufNLSp+1Mx+Pt+5Xf7IyY++nV3ZDPfk97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xj7SNS5w; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xj7SNS5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=U6JR/PoX3S+8pkFQ9lQp6OpGeokwyfDEgky1PWHD/+8=;
	b=Xj7SNS5wTVoI+gm22IRrMoULd37ta7ZMPAvFAEFBsrwkbOv3XsNvy/c/MH5DA8
	0FP+gORoj+doCz4dKL7Kz36h+yViVwMsqFIkCaLfhK4BOWWZxt/xuKap6NbXV3t4
	+4D74/72wFTYnREhh7mdTJkqGBgbwxYcXcD9hhkyYapiw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn8xDfRVdqVvEJIg--.101S2;
	Wed, 15 Jul 2026 16:33:38 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 00/12] vhost: cleanups and improvements - PLEASE IGNORE
Date: Wed, 15 Jul 2026 16:33:35 +0800
Message-ID: <20260715081400.1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn8xDfRVdqVvEJIg--.101S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2T5lUUUUU
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7wL5iWpXReKAkAAA3X
Message-ID: <20260715083335.OhWale_r6s57Xqy4DWDdEp5HNioUuPo3VMiT_OC7bLo@z>

Please ignore the previous series "[PATCH 00/12] vhost: cleanups and improvements"
sent earlier today. There were missing CC recipients. A corrected version
will be resent shortly.

Sorry for the noise.

Weimin Xiong

