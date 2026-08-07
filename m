Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E153DA7E4
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096841; cv=none; b=TB6WkHjrk3tkKCXx//Oa+Sdv3ywngkahnKB5619e/M9kBCzTUhilKvas8uBEeyQ3F8z9j9cjCwAqzMZYNdbiI5YJj0gFAyc1rDlwUKJTlEuk3GmRVUuQqdczVpS9qLuonCw2nwGUs/5RXNsKBC8oYO3vfvnbPvHgXkyaaL6ty5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096841; c=relaxed/simple;
	bh=WE8i65b9LC7lL9iQ5/lEghqFQeb0neL/8MWHHX2SAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cm7LG1jKJg2n6gKSxwoZ3Q6ICq+jVhjtn1xCkhstDbkbJbHdB7aacCTUCJp/sLGIZbkFnPhIp7h+Iwzv/WE6U4aYldlmcw25+xhOycebQgWOF9xfcyGcPJlXFnYmbuZlQhbupRlNaGTdEoeGPFPGSaelsIjaxgT0WYKXNtxKEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryBXuLQ7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryBXuLQ7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso29836865ad.3
        for <virtualization@lists.linux.dev>; Fri, 07 Aug 2026 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096839; x=1786701639; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQZgcdlI2EieaifCVQjJlrIUWRZzFN6DkbdW2khQ3hg=;
        b=ryBXuLQ7hiZEj6SSMFT31bqX+gCA/tgMoiM7z0ovFjTm9LMxEL8oXZ3TT+O9iI29M5
         d+g/AD8QkQglSR6v07cndmzFsKtjw1kcUeyMaiRHmcpwVBY7QGEhiSEAr0+IT8geUH4Q
         RYyOsEMyrtExh7AwCKIsJooLbTGSCIFEOeXtFtfiwt9H6OqMqw/3JR7LViCvhq/3uJNq
         6nxQXUP9YKUIVRqidgwhf9cRJYwg93FrIwZrzLuXAut+tD14x8QBeoNBlNwoJVSgwMUV
         cA45rEMiuEarbqC9YuLaPaFwc7fDuP1jsaidOBnrDDCBkYULn368He6CJHNBgIdEa121
         GG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096839; x=1786701639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQZgcdlI2EieaifCVQjJlrIUWRZzFN6DkbdW2khQ3hg=;
        b=JVp3gkDjJsQQYWhhTus3BaSLKDh2iVkQTRNoK7azP8bHZ+40nSxjXfdu4vtbRydXRM
         zl0zkEY2L8acnPNpoL3y9Js0nx9uTmBl5lqLGihqKqqy2TXB5okZHKWPEJknQxljnH+T
         aKf5TWVjD+rzj9+SOLQwJaNGqbe5452Up3TIncp1tChVmkP3Sts7bR85SMEnAm8qJAYP
         8WjYzoNef2BRDd54qgTG1f3UxeL5bIYGIpf5FjA0WjnhuMictt614iuOtNMHz7eq4aR1
         ZS2grU0/HlBkoCJXPwQ1WOz3KsRW8nDS/FqmnpDlDvHFZsXs6+w2U9ucFC5QPG3hU9Yp
         ImgQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/JGL8Xmf6A9w7AbFdRREcUqjrTMNfXLdGOn8OGEFpZK1L8gse0etpLlmb4Ch3b9mLZgU5tSB5A26ihBgUVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybJ6+fWvu5TCm0HQvSBQ5XbEx8siA8DQNDLTJoAL15IN1n7D0r
	Fk8iKAjqlT1pRokVwEr25tvx+NVWvjlnTqRsFg5wF3lVpzStVR8P1e3E
X-Gm-Gg: AR+sD12H5VFTxSe3Jx7tfUWp7v3loboq/tkzU+K6DHaVNMR2teCAgj2Tol/fmaZz0Nw
	1GP0ZVII5uFV711YgWub6uHiGlwsp9T78hsbKNiIkE+RSIMjuwVGAY6fEligPPx3DPITHbmP3wD
	bLxH3n/Gh0kU7ZA7Tt1obTMQIltzhKxvaS4nE4xyvQK1u2yaVyaCADU7EfenhoyqORpWbd4nR5J
	vTD2oHMxEr7yqWRNWdLyT6rAKwSf3mIEkB1o9fYKdEq2xNuguQNCN2qhx7AM7rJNkOUINK7HRq1
	YCL8opz87OdGMG/+G5c9Jqq7EAt1XrPRIEmlrRROKnWmRGHjSbeYxNjdq/yF7xIiI4Buoe7ayiL
	A63z9d3BxiufjbXadC9iuTr4GqojbPQgV76bHiYSSj9w4frcJBgIuhjK7rlqgtVHX0FRPCL2+yQ
	Ujb66xKQCElVioW22vmeqUL0HUSeWJHerJGesrwcvijJsihWVNn6ELClrTHtU4f4GpzxSwf3ARd
	1qSZCX7NVSKiAWlxZUseG50olEx9E1cPsePCvWxuyly0c0WujpErQqpxvCuKekpqpk=
X-Received: by 2002:a17:902:f60c:b0:2cc:aa36:c04c with SMTP id d9443c01a7336-2d0ca7afcabmr254341645ad.1.1786096838646;
        Fri, 07 Aug 2026 03:00:38 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a9f0fsm6500035ad.68.2026.08.07.03.00.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:00:37 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH 0/2] vhost-vdpa: fix a use-after-free on the config eventfd
Date: Fri,  7 Aug 2026 20:00:23 +1000
Message-ID: <20260807100025.19750-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_config_cb() reads v->config_ctx with no reference and no lock
while VHOST_VDPA_SET_CONFIG_CALL frees the old context, so a config
interrupt delivered at the wrong moment signals freed memory.

Patch 1 stops the fdget error value from ever being installed in
config_ctx.  It is a fix in its own right -- the callback tests only for
NULL and would signal the ERR_PTR -- and it is also what lets patch 2's
lock establish "non-NULL implies valid".

Patch 2 adds the lock that closes the use-after-free.

This is not the reopen refcount underflow fixed by f6bbf0010ba0
("vhost-vdpa: fix use-after-free of v->config_ctx"), and it is a
different bug from the vq call fd one I sent on Aug 6
(https://lore.kernel.org/all/20260806150323.2154-1-yuz08559@gmail.com/),
which is about the parent caching an eventfd_ctx it does not own.  The
three touch different functions.

Tested on v7.2-rc6 with KASAN under qemu, VDUSE as the parent: one thread
swaps the config call fd on the vhost-vdpa fd while another injects
VDUSE_DEV_INJECT_CONFIG_IRQ on the VDUSE fd.  9 of 10 30-second runs hit
the UAF; 0 of 5 with the series applied, with the workload counters
unchanged either way (~30k swaps and ~2.6M injects per run), so the race
is still being exercised rather than merely not reached.  Also clean over
5 runs with PROVE_LOCKING, and vdpa_sim shows no change on the shared
VHOST_VDPA_SET_CONFIG_CALL path (20000 install/unbind cycles plus the
bad-fd path, identical before and after).

For patch 1 specifically: with a working config fd installed, 250 injects
deliver 250 signals; after a VHOST_VDPA_SET_CONFIG_CALL with a bad fd,
delivery stops on an unpatched kernel and continues with the patch.

Yu Zhang (2):
  vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
  vhost-vdpa: protect config_ctx from being freed under the config
    callback

 drivers/vhost/vdpa.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.43.0

