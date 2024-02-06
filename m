Received: from out0-199.static.mail.aliyun.com (out0-199.static.mail.aliyun.com [59.82.0.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D1D517
	for <virtualization+bounces-2496-xuanzhuo=linux.alibaba.com@lists.linux.dev>; Tue,  6 Feb 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237765; cv=none; b=oQfYa8BadMlnBn3CR6+BUReC7NjhmK9FGgBZ6AJTnZ98gTHWvPurjenNe6zBvaYJwnRannbGPgQG7rmHpeQNiDhNTmiKfKFIbPSCNtu9eR0hmfv04eA7EEMJISt0UPrMjyEEOcCro5wrVp8seSiMBfxPv/tY4E9XESW4uZOdHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237765; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=Y1A2KkpBbu63gTqVQU1gzg4HQ33qLtztYoGcJNBoLyOzzxipTPEcCOAiOsd0YGUeqSn9/MARK6Sq+B1iLNv3AyvNUHKfLzUp99SXmf13wL93H1KGHRXxeAYntomJGPqF7Sxu/iKhUgqxTw81W07ymUmyHw7f9nVB06TniYBl4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A48wJGmh; arc=none smtp.client-ip=59.82.0.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A48wJGmh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707237754; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=A48wJGmhsURvfuy3w4D1IRFkL/pwI4hdHHqNp4kNGh5PO762cvalIRlKLy7YhFhJPAgnKWaePIRlCjKpojrP4VtPaRuVWio9f1+FXdK4QobbS5iaN9e0UKyNcdAl5ffeq4jh5GBIlha1dC5xTcnJRBTlNUg4KiZbbhSzfnDNwtU=
auto-submitted:auto-replied
date:Wed, 07 Feb 2024 00:42:34 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFJlOiBbUEFUQ0hdIHZob3N0LXZkcGE6IGZhaWwgZW5hYmxpbmcgdmlydHF1ZXVlIGluIGNlcnRhaW4gY29uZGl0aW9ucw==?=
to:virtualization@lists.linux.dev
message-id: 39df64a8-fcbb-4787-90a5-6baf3ebdc0a5
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
