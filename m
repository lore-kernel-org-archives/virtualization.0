Received: from out0-177.static.mail.aliyun.com (out0-177.static.mail.aliyun.com [59.82.0.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9F7D416
	for <virtualization+bounces-2526-xuanzhuo=linux.alibaba.com@lists.linux.dev>; Thu,  8 Feb 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408945; cv=none; b=YoQDFd0duRXAWolJ+faYUC+hZYmYe35CobK99w3BjJd436XghLMpELhHOhBBM+pIxlKqks8JERonP9E95orTzvGbyfhjdwQ6FF5waCnXHse689rGzNnFPiTS4CNZPW5Ul3/vNtAhio9iPL6z9TXRyYbetl2oGHJ7JeshgjyX9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408945; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=uri1DIHaBEhz7Npj7ARwcF3O0l8ciCMxT/dV4Gbn1054OjfNEqYvuS8CHZX90eRw8s1sS7xJ90jOhTX4oWjdntgElrMeayztxfF/k1FO4Sko32MdZrNDBRA+W+2aBnBvLFV1uYoorO3TlH4jN23oRp2OQ5hDKDqW9+6r4LElI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UI+ZSKw9; arc=none smtp.client-ip=59.82.0.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UI+ZSKw9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707408935; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=UI+ZSKw9ZJmCWV7IfjVzxl6M34OhmYbeNWaqYkpDZnTMYncSZPGOeFdzLxrYgz4L+9TejLzjikXl6qz7Rr1i9cr+qs3fxDrf3xq+z072krHZKdL7AMET+lm1hJjSDisA9xTxq/YnM64d7l56Wwz5wuqM6XVCAXARkd/+y2GFTvY=
auto-submitted:auto-replied
date:Fri, 09 Feb 2024 00:10:17 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCB2MTcgMy8zXSB2ZmlvL252Z3JhY2UtZ3B1OiBBZGQgdmZpbyBwY2kgdmFyaWFudCBtb2R1bGUgZm9yIGdyYWNlIGhvcHBlcg==?=
to:virtualization@lists.linux.dev
message-id: 2ff846f7-456e-4f97-8410-0014b89f842c
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
