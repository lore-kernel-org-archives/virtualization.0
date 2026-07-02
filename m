Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D242DEA7B
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958892; cv=none; b=kSp8r7Z0vYG4sjdudiK3tecJgUi/yI4MP7q5kKpNasYTWFUNonU6SCtQYbFnKaiGPBqWbDQ/jFlE0KnBfyhlWT4hwqG9zUx9map0gJ5bYG0DPJhMIZ3YzbZOBIdFpQuC7Iww75Fg9O4fElzaLTqee6iFJf5CNOPnBJlui4RHaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958892; c=relaxed/simple;
	bh=2Ndl/mRuVtdCs70NpAmZsm/XnxGCp953NlnHqmYAZKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwVPb3NEv7ZlYnGrU2qIj7mvdrnBlGPnEdXL/hcGFfe645L4g/pp2C96RsrtVpBthBuP+F6Ar14Hhng0pxzpuUwc0cH6F7/klUfTSk6YGi8M4G9zOrDViazVUCrnQzMFi1Boi9yhTmRiKS3T/fN+ACkJNChKhHYBXJrRahrDMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PzLDD4x5; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PzLDD4x5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782958866;
	bh=2Ndl/mRuVtdCs70NpAmZsm/XnxGCp953NlnHqmYAZKY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=PzLDD4x5ffXEY8Ef7S6xbH5EuxhzZnOuzE8qUf3yQgTlwOq8xdrxGjLZZ9m6gmiw+
	 U4wIfppI/JwroMZa3AneASPNXgJw8LhyfgHCIu8s+vTi1WA+tpN6Ff1bURGSY9hhjH
	 D4JHqUJKGeyq4yb4ZwaDh4z5K4OhadnHAtpah128=
X-QQ-mid: zesmtpgz8t1782958847t5911ad0a
X-QQ-Originating-IP: TIqPUYdNphPiOHUZ09zuMwgfWlNYp6TE1cknZU+QQU4=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jul 2026 10:20:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17772042891314411197
EX-QQ-RecipientCnt: 12
From: Yichong Chen <chenyichong@uniontech.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	chenyichong@uniontech.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	mst@redhat.com,
	pabeni@redhat.com,
	rppt@kernel.org,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v2 2/2] tools/include: Include stdint.h for SIZE_MAX in overflow.h
Date: Thu,  2 Jul 2026 10:20:45 +0800
Message-Id: <20260702022045.306377-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260701133503.41823-1-sj@kernel.org>
References: <20260701133503.41823-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MDN2VRNR2P4wXuzwOC4l+Prg4QUbovmX//y16PaF0AX1eeHC5Fz7Vzf+
	7waGoNY07Wx+lGVzKX4OB/JCi3am1f0MRRpr2v1GXST4riszv/HyMGXSFWRTpRrl8nBuhyV
	BdJImeLyEb1aZr4OwuBncuUkX5Nnk6tSYAjMBxiWEjM9G2mbtGRuhex1jK37lhFnx5Ogh/j
	QW4VvlLnSfuEXGZcm1Kt4+UXdBJqThxplWvBZ/sO6ElIZ6va8hnW40vIN+VGD/P8cU67PU+
	sSB+c6uPPrvJ+FIowJ8bFaQzPfyujNuU774EgBy9z+weuFwgxCF8HMe0vnIHmPvoDTwt893
	PaZDCcAjlZQUuzXgq+jFiza3lWp22OVJV/HOSfNAoISe8znG2Oypn8b94LFRuFw/4jJEJ/r
	16Zn6ylEFkyRvAd3GLgd4wyqtsQybyS3tpZw213wdlo3ZoozT3SZePVg11+aIZ5MJ+NweCF
	hX+Yo3WJgiDIOfErRoXgf6JP82YT6zKoIre0bm9ONQ/LHpPkpU7VjcwSsFj5DxFsNE2omLP
	UwCk49tNVTYn/eHnBqFo2VTYQWLMl7bXw+Ua8Ao668HGq6mQiIaV4r9f3INKo9HCl6wCjd6
	wyRTr3QLyG5SmzYGAAQ8y0Fz4iui/I8CFg+gE5Dzrt5vVxMyQOpHRR3eMM4sSGd+mcUlYQL
	Z0SPldYUU1cJTcaMJhRqHXigTslr3njmpDteOVSXRFDOvifwYTokQSG4XpI5cWZvctzDxCP
	G/RfQabQnIKWLkRm0SPFfM8dbfvEsF1GUoZEBXCUiqHdFt1k0Jdd4YTbyQOD7HG747ZtMIW
	C/j2SYernb8y2hRVDRRR7GLe5p+B7JO5XHaPd8dhh1h8LGsTnXvfdxlchuD5pEU6z3xPW38
	KUC2yaMmNMEdrq4pbP6NqXcqG5FueZveu9RSGhUNQ6UrMC94IDayrPh2juy6xycVw1bOcmO
	ZFoN8DpDu00+5CV7QvBTtj/7tREt+74vNbfoAKW3yfv4yQwrtvlyMSmcla2x0sDTUDl9Pi6
	29YBHqcw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Hi SJ,

You are right. The include should be inside the header guard, after
#define __LINUX_OVERFLOW_H.

I will fix it in the next version.

Thanks,
Yichong
