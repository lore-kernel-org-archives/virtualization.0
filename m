Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE22555C
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AO/Q7CLd"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B7F540512
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:38:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B7F540512
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AO/Q7CLd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QxlxnMIsx7eX
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 13:38:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 862FD404A9
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 862FD404A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701697102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5akfcmS88aMdBOZU2tgTkzn2BZ024jWxw0fAikE98gA=;
	b=AO/Q7CLdpiXz7hpGmPaa0wMn9EVT7OUNBSOMTC9HcWIMOIQP0pVRQTmJQOi/cvxlqDmwu4
	F+XkHuKg964x6EOu8wQYCxl10BTw1x5bFjdQRzhX18fUUz68k1mQuikItOHFUKSnxLn+Ml
	nuG/Qc7UpvzJtIXB07+a78aMPwZdgKQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-FVPyStl9PAeE1fwoyDy7NA-1; Mon, 04 Dec 2023 08:38:15 -0500
X-MC-Unique: FVPyStl9PAeE1fwoyDy7NA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423e684dc6eso63171091cf.1
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 05:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697094; x=1702301894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5akfcmS88aMdBOZU2tgTkzn2BZ024jWxw0fAikE98gA=;
        b=hiWsAOJTmy8uQnmsksVguhg6E3cSEpcJQtGAigKXmO3Sw4QkO6V3L6xoDDhKj6/6WL
         ANq6ozdWhGVDmo6XuxuYKR0RbXWpmdbX+FhJkjqqIrzommRmomH3R0qOHy1MWsVhlqdt
         bgqKTsZMH/bQ+xAIIpU6xqADw3aICK1sQz8buzNb598OHoHkD+PSyJwQxgckU1ZpYygk
         UVMaz10ylG/KLSueMWU5h/WYqWmt3bleJu4F9RyFu8Ce4eK+ItS0lc0h+C5qRzgn/8Je
         ZVQsFMqJ8t+4t9McS9uuGzskZh5hYkKcyozs4d+QprtEt9mFUu6UyValTT3629UIfSwO
         CZ6Q==
X-Gm-Message-State: AOJu0YxWIK06LQFYELktYg6Np8CLI6q49Mc9ub7maoJ/bcYiz4sBCNjQ
	oGfaLzzfmMRnEuwvvfDRfxWSSZj3Q4JrorCUdM/N7iECLPN4RA/SmwghYkrhie4D1ovjxl/TAti
	z3TPQ6LZ3m0XCffsMPfQVcPhZgbGLE88wEkfhZy5I3w==
X-Received: by 2002:a05:622a:282:b0:425:4043:18d0 with SMTP id z2-20020a05622a028200b00425404318d0mr5350674qtw.131.1701697094707;
        Mon, 04 Dec 2023 05:38:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+uydVke1bj6K3+VpqcvkS7K82S/AfCUqWL9s3clAKf0dXgfm1gbib9FuloJn1VamCnIS2mQ==
X-Received: by 2002:a05:622a:282:b0:425:4043:18d0 with SMTP id z2-20020a05622a028200b00425404318d0mr5350660qtw.131.1701697094341;
        Mon, 04 Dec 2023 05:38:14 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm4284873qtq.74.2023.12.04.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:38:13 -0800 (PST)
Date: Mon, 4 Dec 2023 08:38:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	eperezma@redhat.com, jasowang@redhat.com, lkp@intel.com,
	mst@redhat.com, shannon.nelson@amd.com, steven.sistare@oracle.com
Subject: [GIT PULL] vdpa: bugfixes
Message-ID: <20231204083808-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There's one other fix in my tree but it was only posted very
recently so I am giving it a week in linux next, just in case.

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cefc9ba6aed48a3aa085888e3262ac2aa975714b:

  pds_vdpa: set features order (2023-12-01 09:55:01 -0500)

----------------------------------------------------------------
vdpa: bugfixes

fixes in mlx5 and pds drivers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Shannon Nelson (3):
      pds_vdpa: fix up format-truncation complaint
      pds_vdpa: clear config callback when status goes to 0
      pds_vdpa: set features order

Steve Sistare (1):
      vdpa/mlx5: preserve CVQ vringh index

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
 drivers/vdpa/pds/debugfs.c        | 2 +-
 drivers/vdpa/pds/vdpa_dev.c       | 7 ++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

