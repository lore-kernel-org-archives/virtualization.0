Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4F34D911
	for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815572; cv=none; b=qMh0jslgaqTRjOMQAm3qt7Sl6CCJXiH3F+BNDCWichhsB9dJ8pBrskNcNyCMniCQE8O+7iYq3LMgW3tFZqegQ4TnLJaa8vOs1VHaOJMd0+21rfEvYnstN3qWMijXcmpTvMyd06V1ybeyhoxOUwVaGA/DlQDH/T6lD3BE/m9zCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815572; c=relaxed/simple;
	bh=wnr94lP6aL8TmgsrcpDiGyiUGOH8xvev6pjgyErOphs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-Id:
	 Content-Type:MIME-Version; b=m/yKUuXQqFw0BWlg9vGoANPFIChP5O2/vFLkiqX8lX00Twco9Q8Z/2Hcjp1X9D+8ycyndruofpbOJa0hC1jT8YB+BRDflDgFbhTQvDH8XWM8bPcnpDbumR24eaA53wdQDQoKPCxfD+9TzF3//zGXvsefR0VyK9Qe+ZdwDLrEzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gvkd+Nqj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gvkd+Nqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=wnr94lP6aL8TmgsrcpDiGyiUGOH8xvev6pjgyErOphs=;
	b=Gvkd+NqjdcrK3C61swxJhEcQE1K8bqJ83Zb2OF/BXWpYoJVZfowHhcCg/9Z42z
	mbFHscdob3GJNUOlGezvP/VFldsyNEN06Q2v/EaF5OHKlyLEJ7hqTOshiaWUxTOO
	VACrPFdGIsHIsSBvuCvuTpbhLIgHwsXcaDEXgoTMPz29A=
Received: from 229.199.16.172.in-addr.arpa (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCHJs2Ey9hpC4kKZw--.1776S2;
	Fri, 10 Apr 2026 18:05:58 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefano Garzarella <stefano.garzarella@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Bobby Eshleman <bobbyeshleman@meta.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] selftests: vsock: avoid races creating Unix socket paths
In-Reply-To: <adi1X_3wVUsDhRmR@sgarzare-redhat>
References: <20260405195733.86043-1-create0818@163.com>
 <20260410035237.59644-1-create0818@163.com>
 <adi1X_3wVUsDhRmR@sgarzare-redhat>
Date: Fri, 10 Apr 2026 18:05:56 +0800
Message-Id: <177581555638.13754.16558385745397476529@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-CM-TRANSID:PSgvCgCHJs2Ey9hpC4kKZw--.1776S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUlkVUUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6Aak3WnYy4a25wAA36

Sorry, that was my mistake.

I accidentally sent v2 without the patch description. I will resend it as v3
with the proper changelog and Cc Bobby as suggested.

Thanks for catching this.

