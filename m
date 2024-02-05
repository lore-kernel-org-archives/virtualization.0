Received: from out199-24.us.a.mail.aliyun.com (out199-24.us.a.mail.aliyun.com [47.90.199.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48073B660
	for <virtualization+bounces-2471-xuanzhuo=linux.alibaba.com@lists.linux.dev>; Mon,  5 Feb 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110439; cv=none; b=HpTqdTz4lz6ls0/2Crz0ozDqdj4/BO5FW8Bz/gB5Y7yn/JbQoI68gzitUucuXVh+HudZn3b460Jwe5TZskBaKpmR6f36O/V4RvhTuZJw74Jw70DXFgT3rCpguvEq5uHmm/78IX9IqTXfPen0vw80XzB9Qi01oqvkhNSPYWJL2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110439; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=fLloMPDr/nhAWMhFm6U6/1oyFrdOBeDAbHqjqrPk1UiPtQ8XiRBkY2lMWgRFR5+8P0BNvhzMmkae8gWS/Q+tRB+PEwkNj0QMfizcsLGTPZuAOmKU5JvYoK6W9Yi270hBieDww/UTf98t5lpRyDdnRkXbouf/3ceac0Dnc2VSFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dAYF6DQg; arc=none smtp.client-ip=47.90.199.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dAYF6DQg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707110424; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=dAYF6DQgUNYwRQ8Fd6B8cpPJFIdQDzjtdyHuMR3+A89b38Sw51f8D6xBVVKpYvsjBWXeKrQCaW+1ZCb/PegruxMZ3NappeIMAXKsTWKdiTU4+cGUwKlZVvNEeVTp3yu6+y8snIuluv0oxCKaGVAQx3+9KTqhHRRQbuPdld2EhPg=
auto-submitted:auto-replied
date:Mon, 05 Feb 2024 13:20:24 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6W1BBVENIIHY2LjEueS12NC4xOS55XSB2aG9zdDogdXNlIGt6YWxsb2MoKSBpbnN0ZWFkIG9mIGttYWxsb2MoKSBmb2xsb3dlZCBieSBtZW1zZXQoKQ==?=
to:virtualization@lists.linux.dev
message-id: 588b9c2b-7909-4434-9cf8-ae37b9dae5fc
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version:1.0
Content-Type:text/plain;
	charset="utf-8"

Hi, I'm on vacation. I'll get back to you when I'm done with this vacation.
I'll be back on 2.18.

Thanks.
