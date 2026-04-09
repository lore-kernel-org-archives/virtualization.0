Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142C3B7741
	for <virtualization@lists.linux.dev>; Thu,  9 Apr 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752469; cv=none; b=fJOqdteKGJL3IK5HpARBQJvGEc9yx63ZwXvqMOklM0jrWj0htXLlCiPoRmNS71hSJReeTWfMVRCv70jRaEuDErb9twp9F9fhv1Lg9q0SlFeYyYuF385ziD4L94Zteg8X6udsCZIzG4rhEBDVcdJh72S/2wGE5mF4NllgtP5xTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752469; c=relaxed/simple;
	bh=5HPjyCGIUcS+XZxwOq7su4bREXkMRa1byoy+Frp53Po=;
	h=From:Content-Type:Mime-Version:Date:Subject:Cc:To:Message-Id; b=E8TuuSe+1R/VmPnjyZv1xqPnATACD67SWTOwMoFH7E4LJEPKGRIYdtNB+QwkK4Tewn6T0NJpK6qITLCPV5GL56nqn17k/7UaB+P+9lr2Aa0MWSK341oRmOMZ95bqspxmHsLm47GmDI8Q9u0T6671mKcpKoFXELnBvESCu0G0rW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=aSEV4Dxv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="aSEV4Dxv"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6701fb93f23so1683900a12.0
        for <virtualization@lists.linux.dev>; Thu, 09 Apr 2026 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1775752465; x=1776357265; darn=lists.linux.dev;
        h=message-id:to:cc:subject:date:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvD6iQG1O/I+/j+ks+GogJBSWRhUCp/c6DPnLqjhUYs=;
        b=aSEV4DxvZ/RfRh7mHOcqaOdRxrIfPdDObMDNvZKw8/4b4j6lsDwRRjuez17/DqHBgm
         ocKkWkY00qOkEuwrpKtwZIoR30XirWP/AJgtnHCK4kR1Xd7gfhEYzmIkxhLXjojz4PGY
         JZIySZ9Myk6DYblI1hDKYh7JzleOnUX0OWyj+nWsLCDVoqQ47tmLSW7G9Ykif1RcqbUU
         o6ZxTu/4FNkVNTVw13rAQbgoFXlSsfqqUE+am9cpYddfMTpEUxTKpruhjRi4uvYaxJcj
         hAS3AK0rtMaUm9osewdIbAcNcolDkAWKkMutvP935dmtWOZYaE7gIdaMuuzWHUw8lU7y
         eDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775752465; x=1776357265;
        h=message-id:to:cc:subject:date:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvD6iQG1O/I+/j+ks+GogJBSWRhUCp/c6DPnLqjhUYs=;
        b=lAEAA01mbnB0q4RVdFvCidJAWTaHedAHlfMJ2uniCWNwT2XoKfivFNPg/BVcjKGp7s
         7Bpc8Tu83Z7WZiSFJ4ZY2ZHP+mHZq4adNpB/Z3+7WZ17iHVJApALRUaJsQMGU0mqZ+u1
         4Zei5108rjX3V5OQpur/+7dpHloRv8OFd0FHAK4BHZ9016EUsU1jJIyuvm1bNXWCT2hI
         1WzsT+NjDqqeoTQ7QfYwgJY58pgCzD/utLnQe6zSKkiclXNKtHoYWe3+SjrSKFwjEwjr
         NOBmSeP2474PH6SrjUd0l8K+kLQ3zez72/AY2htIbdF543nTpiewVqSLnAan9pJUvZ72
         jZtA==
X-Forwarded-Encrypted: i=1; AJvYcCXeC+7JSdqFtDnnzrYjFngYyTz0XXHq88OpDLmFOM+TFXpOWQn9Prx+UVL2XfB1uxLgU3GlMg4yV+6SFgUKBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDWpx8Cr3mohu9psKpY8U5LnMW2FNHAg+h1iwK48Q47h8dvLhT
	BnpMTq/3AwH/UZJMLRd8OuqWkX4Vp7TJuW7yFNnLUEKZ8Ih1jY1f+mcY+jzJu68WxQ0=
X-Gm-Gg: AeBDieth/UkRZHtA7RYOxRH5PNL637O1Cprgzihk4jipuIOXuxjGBebcWQqKzbf6YwG
	jxyUCZIaSey+xPEnjTqG7g8wWWm6TyBeFYOTyi7mDPlTMnyFwI4jcS9D/qSYxCkbhJNsmbnt70/
	dgkyRi/EzokUmgKvKLB0eXTEBxNWcO7+8If2AJlj9b/I6Lr+puIwHWLRRgTIHzDv4jxRILroS7u
	x5UIcCG3gbt7ZVZnq5X3eeUztR3B3dj73uQTknXCAThJS2XgOIMmp5re2o504hZWbEWQaSlvaEz
	zPtDRiGQX04vJc61ezLq7Tp7VkR9At7+I3/okeaJRr+whWIzN9tKFrjisR46mAz/q8b5MSGVPwB
	Gjk31ggpn8viTrD9qrF91ZRM5EZCxTyIjMMgUnFShZisF/GfRLMjU57RAo4dpAnAA2APB4nOzhl
	Vr00X/hIlwIVhtjQsKU2nSfyBp74JMtPGMzsQAy2OzuY66ZefpItJUwzThD7yIcT1eoN6T2xnS9
	mN4
X-Received: by 2002:a05:6402:504a:b0:66e:df52:7ce0 with SMTP id 4fb4d7f45d1cf-66edf527d86mr8235560a12.17.1775752465513;
        Thu, 09 Apr 2026 09:34:25 -0700 (PDT)
Received: from smtpclient.apple (83.10.27.44.ipv4.supernova.orange.pl. [83.10.27.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033a787fsm5984074a12.14.2026.04.09.09.34.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 09:34:24 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Date: Thu, 9 Apr 2026 18:34:12 +0200
Subject: [PATCH v3 net] vsock: fix buffer size clamping order
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

In vsock_update_buffer_size(), the buffer size was being clamped to the
maximum first, and then to the minimum. If a user sets a minimum buffer
size larger than the maximum, the minimum check overrides the maximum
check, inverting the constraint.

This breaks the intended socket memory boundaries by allowing the
vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.

Fix this by checking the minimum first, and then the maximum. This
ensures the buffer size never exceeds the buffer_max_size.

Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
v3:=20
 - Added Fixes and Suggested-by tags.

 net/vmw_vsock/af_vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d912ed2f012a..08f4dfb9782c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct =
vsock_sock *vsk,
 				     const struct vsock_transport =
*transport,
 				     u64 val)
 {
-	if (val > vsk->buffer_max_size)
-		val =3D vsk->buffer_max_size;
-
 	if (val < vsk->buffer_min_size)
 		val =3D vsk->buffer_min_size;
=20
+	if (val > vsk->buffer_max_size)
+		val =3D vsk->buffer_max_size;
+
 	if (val !=3D vsk->buffer_size &&
 	    transport && transport->notify_buffer_size)
 		transport->notify_buffer_size(vsk, &val);
--=20
2.53.0

