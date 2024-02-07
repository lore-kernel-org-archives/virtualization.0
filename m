Received: from out0-179.static.mail.aliyun.com (out0-179.static.mail.aliyun.com [59.82.0.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0971429F
	for <virtualization+bounces-2512-xuanzhuo=linux.alibaba.com@lists.linux.dev>; Wed,  7 Feb 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345171; cv=none; b=pqu3fGbxuMp82xp4JByLMi4GG/oWs9d3BDqnk5Twa2JG3fo7FqpYT73uOPpk/ajQBdqlqlDIRsl9bQFW5OlcZnvmeOFXTthbicyTv/p2qCGiItCPVwpZNfXVmWU9IH7+TcZp7nW6ktNZWZ8gh3UZ/SXWRbGK6TCkHOkjjD3XSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345171; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=YVsF2Q/Pl2eA6e9hPHi7BRBhoetuJjXHZOyKdjipRs9B8nQ0OO4ESXXyiArwc8NAx7jxc+Aqn7kHF/5FXNVwGQlTx/39j5UfTmmtS1H+8b5zK2rvwLr0OPhbMe5BK36nBZ+R9gx0h9OnuRKBdrSt3EKu8jIyjGDRB90s+/LYebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gi8wKly0; arc=none smtp.client-ip=59.82.0.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gi8wKly0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707345160; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=gi8wKly0uHWV6ye8MeoAFlaaxi8V1IxR/6QIC2iKs9Ysr5h++w8b5TjeKnbWjQ7ymF3bznp4OEEC246Vz+r1BIsXgISvpb+rW6G4t/MPl4sx/1PJn9+A1eR+zCJH4QXYKFE2XHreldOdx4ssCoI8sA+a6J2T9PYp0t+eL3bjznc=
auto-submitted:auto-replied
date:Thu, 08 Feb 2024 06:32:40 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCB2MTcgMy8zXSB2ZmlvL252Z3JhY2UtZ3B1OiBBZGQgdmZpbyBwY2kgdmFyaWFudCBtb2R1bGUgZm9yIGdyYWNlIGhvcHBlcg==?=
to:virtualization@lists.linux.dev
message-id: 6372410c-bae5-4c3f-aabb-aef93f8ab88f
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
