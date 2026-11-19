Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795073186;
	b=fylsOS1zNTDHgS0XT5GDx/wVGEo4W18hCUoKwNTuhUAP3woFj9m5OxEISV0p40tFyoCU
	 DN36njHlukHNRF5+sck05nBiE5JrlvZERIOJnr35mVxqGNqJkUlnFF3+TtN0Rvl9qlxHX
	 Su0ulmlipoNwijql2ULhF/LNV539Y358LTZhLcbLLtA3u9fCZGVhD9mJcv3PHkT+Kz7hf
	 6z3ANE/lJf9H22ImL//Qig5sDz46jGdnhaGv64GYXKLTuKU+mVsMkDLPMx/hgNuZvU6iO
	 4UiAy1nRm8XgYtwzTDdJgu4LKEKInsW1GjXLN4Ex6Vle2qZ4jRAYFarSn+rkSxSl5Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073186;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
	b=PuI/lRoIC13oPkDiqUYJe6XLDADAWfoDOunp9aHCSqDOuT/6Gm/BgJKwCy2Sb3FcS6uF
	 ZMuij+/tdO93bX22qELeEECJnpHWZQG3w53ldd/GtYdpW54B+mJcCwGQrtUbB248FEodn
	 dNwPOurNiFpyFq+4ZbTWgceIfFMlsFI7kXPUnS3npiqCwF3bJUwHhAJ9X1SIPTVcrgfco
	 toaUVm06uqXbYxWM82wEPduVDevuDAyN9J8WDqck+aVEB8QJSUnIsY5t+HfmyloOvZ+uF
	 NWAAGopxkpO82mXPQOJFA3N1LW1nboFqexuacsNeLQl8AgcVM/CpTzvimsPMabOmfPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q70o1SNh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC5606A333
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Nov 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q70o1SNh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37D6D8127F
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Nov 2026 07:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.073
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9FJwkaBp9rsG for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2026 07:26:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 90D8C81135
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795073185;
	b=IjwI0h6g7ssHiREKJDz1ZPT4ehtM9o6DnBReNL/+LnnI6PYsugypv+p5p2dAlQS2GaAB
	 HVUYDZmv7m8iScVCWuZTB6uGDgveq7qoSWTKBjbegaitqfwIr9kUr33xfKQ+o5lkk3XzT
	 vIWX9yurIj5ZZunSohzJhUbTmdqxYnFk1j1nTtRs4HYf8nbmQ9qwZSD5L+I8h2kGLyIBw
	 C59tgg0es5mJmaMdFPrQJMgA8Vr7SkDZefobxeY7wbv/zMHdTgBa3BNRvIKGdE6W1Rbbj
	 /+t4X3k4jI3jRJsxAE+S3vuPf51m2UKgyn0JzrnNVWlkGuTQioz74bgCVl8Lt4Za24w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795073185;
	h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
	b=Ny5RcuZy1m4AFTDH4ez3nYf4E0X40CGZtbV6VZKb+QLmuNwri9nvhpMf/5PLV5yFLpn8
	 NaScSqIcdhgDdHp+SK1EXDgJ+zgXdOtw+xKAniyJVmE8NfqejVfqugXmsah8ldwPiCoYz
	 homn88PLFQQD05Pl/Iehf0GXhi67lEj8goX6RJODyHhOW+DFZJFDJqVZH5ql0EjcG+qdu
	 O8nkouHWCpt7Z+hCGlEscZjlCwU+JLnBdFLMwas4sfczPU9yTZYUxDzn2IhtRPJG/idHw
	 09C2aFCrTI2Fmm3+cywjAJYQfiLAp9G8wBg217fGy1k2cZldG1FEmE7HI7Zf0R4cQZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q70o1SNh;
	arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q70o1SNh
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 90D8C81135
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Nov 2026 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795073182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
	b=Q70o1SNhD2p8uF2UCIZNBOFQb12txfw8rdKg3WuIAoAnyxYWyv7MnqVN/Dr//vnYDMuDkc
	ZFbBkTHpZaUtlF0ghiBiiAPMbL2UYlHM06SzNBga9+kThkmYvTYp85aeXuCSSwn/O5D31J
	lRPqinRGBfixQ+nxyVLWM2pQ36tmhjQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-am6syo6QPYaqjG3ENrRuGg-1; Thu, 19 Nov 2026 02:26:20 -0500
X-MC-Unique: am6syo6QPYaqjG3ENrRuGg-1
X-Mimecast-MFC-AGG-ID: am6syo6QPYaqjG3ENrRuGg_1795073179
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4903fc8537aso1416724f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Nov 2026 23:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795073179; x=1795677979;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
        b=KeDeUr6IYuElWM1tXP+1l9lZW2bZWpwd7OBITeqd8pRrb23V+5WNH3wALi925K7gyz
         kgKOWnppiUfWcYdz7/kF9D0FzEEddy4vV8IPQzJStb/fozK+DA+Q/P8xz3jMS58YGjuX
         UbfQxdlMX30JeDVubLPY5B/7uZVUxlUrnKaALf7rIEwFvzn/qObMgWJnlB5uXEwl9NDl
         kEy0smOm9Xrkf2ddmPCazve9OqyTAKlBIQdsUTam1aupO3fp8qnC9qHx3vwqupSjh3oS
         QJqldeM+z0kTG2YbsnXL8/YhkAoEmNzTDEJD0cLBbF8KQhLYWAWlyw8pOHyH95NOrJrh
         YI8w==
X-Forwarded-Encrypted: i=1; AL+hErHQ/H+C3N1oEoi42O8h58scONiXq1lqQ/yazF4KR0rRDBMY5Q9i20B2S7xT2ABLitK7cYHwzuiye48Zm/UElA==@lists.linux-foundation.org
X-Gm-Message-State: APuU4Z9JY+UFlt3eMmIQBl4qxVBdM0w9tyZqXiP/HFETfWuyl+7f0O0b
	5HoPoKBZSUQq05PMm9SWIZxa70FhgA1tAQY52Cw3JsB6naC8Nx3co4pdknB01/GLpjQ3yYImrna
	lI0T4diDLbFsPdR21Esj/CxmzzcmPzwpjeO8mS3WVLPEdS5OGvtNulvd80BX2s9eYvfGOZzkxfe
	Ay6sfCsxI=
X-Gm-Gg: AZFdTZd//dMAkVxB8iSfWBdh+W+JqIX6DbMoku4faAYixPUTEjFgQRDze3GZnO8yuIA
	2YfSNnjrw3H1USEp4/pmHI+QoO+q7SvGWjlfF0HHxoYrU22V7oVZeU6rM0Px+MrhtO2qV9JxJOm
	w5IAIRb34FV1XBkivC+s9o0o4V8L2mb7P7zcj+3uB+nTwe8jVhunMVojobUHFEkKnzJFItBkIcY
	jrEDx1CF+MQhgmvQ+7OktcE9vqDpeH0ATl9i4f0xiHsxghytZfDva8P2R+KDEDNVDA148KaFvoU
	y9XxtcizvVNpy91spsQCZvZtil3o/eWVoiI4WAzQWMuPJSQomiOIFWzDOwYyfiu/cZvq2OWFkV4
	vXlJ/Ip0s01P39kbP4cnwOKtqBP06NgzVFngu5o/1mMQ=
X-Received: by 2002:a05:6000:4703:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4a64f353379mr8871397f8f.5.1795073178846;
        Wed, 18 Nov 2026 23:26:18 -0800 (PST)
X-Received: by 2002:a05:6000:4703:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4a64f353379mr8871351f8f.5.1795073178254;
        Wed, 18 Nov 2026 23:26:18 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65541f3f7sm9540259f8f.24.2026.11.18.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:26:17 -0800 (PST)
Date: Thu, 19 Nov 2026 02:26:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bioloidgp@gmail.com, jasowangio@gmail.com, minki@morningstarsec.dev,
	mst@redhat.com, stable@vger.kernel.org
Subject: [GIT PULL] vhost: bugfix
Message-ID: <20261119022615-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o8zj_VH0hhn06_Ew6IMsf7x9FK8KQ7n4-0i8Z3Oo0Wk_1795073179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1a577f9402c1780cc1e663f48d5dd54c02051b09:

  virtio_pci: don't take the MSI mutex under cpu_hotplug_lock (2026-11-03 07:32:14 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5570a998b884c988dbe105430d7e2d8e9411e37e:

  vhost: split out-of-order used ring batches at every wrap (2026-11-12 07:44:36 -0500)

----------------------------------------------------------------
vhost: bugfix

One bugfix here. I am testing a couple more

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      vhost: split out-of-order used ring batches at every wrap

 drivers/vhost/vhost.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

