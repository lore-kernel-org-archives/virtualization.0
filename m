Received: from out199-20.us.a.mail.aliyun.com (out199-20.us.a.mail.aliyun.com [47.90.199.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2DB482E6
	for <virtualization+bounces-2488-xuanzhuo=linux.alibaba.com@lists.linux.dev>; Mon,  5 Feb 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175242; cv=none; b=rBv+ZsiZrEYOoC+C4oVoJXE4rRHOmA2tljDtDFTjS2zhaXl/MbMM0ZS3zNH15sMAUn+WD9degoE4LZdLs57DsXBx7Ma7XuMXm3TVb6b8Kd59kuHGI1EFlakkic7d7CyQSVHOiU6HO2lkwNxtLNGXz4oRQYIfcZF/jrAnSYWXoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175242; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=N4lwQu1KF0maSgKbB6uJqsW+2bCJRZWWjLKCXeBpFggIG018hI+Jil9IsB6bsqZeaDrV2GeEvOcX3nN/SW8VGn4ksr74wKJu0OBqbsPWHPP8/PoR49okK5dPGJMNKhx2gGgiMctONwX8x+SuTNIZIkM/Iiuj56pqZWLqRg8ChBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CDu45hM1; arc=none smtp.client-ip=47.90.199.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CDu45hM1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707175222; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=CDu45hM1ZG2icwugwPjmDOHGTfq94ZBXcyOF4bH8sBH/xgStqVNkmNyMC/sZsY0R8Ba2jbM8cdX4vlmfd3tqGdU2NTmgxPePUR4fcLeWTYiG7SjgjsfyE69+sU/B4I2ZPujiez06qNPECW12PGLg0v6p7VR0L5nOiNBeipCx1v8=
auto-submitted:auto-replied
date:Tue, 06 Feb 2024 07:20:22 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6W1BBVENIIHYxNyAzLzNdIHZmaW8vbnZncmFjZS1ncHU6IEFkZCB2ZmlvIHBjaSB2YXJpYW50IG1vZHVsZSBmb3IgZ3JhY2UgaG9wcGVy?=
to:virtualization@lists.linux.dev
message-id: 64733737-a13f-42c2-9412-ad773d62894a
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
