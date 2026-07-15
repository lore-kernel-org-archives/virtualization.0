Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E32DCC1C
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103291; cv=none; b=KV8rUF9XDKVjXVvf871IQVXCpoHpDQrniF2ZdDDqVj2PQaMbUoyXBHTqOx/iTDdJ7tK4R4XpiTan8jd9omZ7NXgLzIU79zO735lfVqEAu3uu0WSGn/0FNsxE4CY6cC9rU49ZeuG9NCqfcma6nkI7aXIrQYybH7Ji9urV/KIBoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103291; c=relaxed/simple;
	bh=U6JR/PoX3S+8pkFQ9lQp6OpGeokwyfDEgky1PWHD/+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G45YGSw+W9diJYrJLe6mhLvKmVK4gm8JFTFEhb2hu30FA60aWlKVMHdcSiB+0JX6z3N5mRSnqYtZJCoseypDNDiAjjGg6Y1r5EuKwXN05fIO2wjyu+FR2hBNETg5Vycs/iGuby7sFIAxLjNrY6swbaMBC2xbqmQkzDmjGR9nYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FdF4tPTk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FdF4tPTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=U6JR/PoX3S+8pkFQ9lQp6OpGeokwyfDEgky1PWHD/+8=;
	b=FdF4tPTkpdJA3S/IzS0ulc19hUvFugKRToNxGqhzY3KDEbK6vlxUWl4Uy/AvQI
	tzDP/NVFWdA/75cs0s3TynXW/FrC4lYezaMVmPcoaMFqNycut7dT3AZrbj9eqTtf
	yu0I1sR+Tv14+hDa+uz8MRYgVmzyaD+SFMiBpuQW6kIjM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHagJzQVdqIzlbHw--.21009S2;
	Wed, 15 Jul 2026 16:14:44 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	michael.christie@oracle.com
Subject: [PATCH 00/12] vhost: cleanups and improvements - PLEASE IGNORE
Date: Wed, 15 Jul 2026 16:14:44 +0800
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
X-CM-TRANSID:PigvCgCHagJzQVdqIzlbHw--.21009S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfyv3UUUUU
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzRTdbWpXQXTOhgAA3p

Please ignore the previous series "[PATCH 00/12] vhost: cleanups and improvements"
sent earlier today. There were missing CC recipients. A corrected version
will be resent shortly.

Sorry for the noise.

Weimin Xiong

