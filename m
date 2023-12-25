Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C952F8C
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkMMQUES"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8745C40127
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 13:28:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8745C40127
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GkMMQUES
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NIWCiik_ldC3
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 13:27:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 709C0400DC
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 13:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 709C0400DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703510876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eQrFSUCYGMhy2SsSQLQNb28k56c6BCyeTM61vN0o41o=;
	b=GkMMQUESaZURPC8ZfFz72h5Y9EokqUeQtYHZbcOWUYbToA5YEI3VZGGpRu9yUKP6N1tXZQ
	FeBGbTOvZeVL4tQDnp6jICRe15iK2VyTXMqktblkLmwCDo/WRzkMeRag3gguHxdFYKo6xk
	rONJoZzSvx8M9aNKqnLuy1tbdJJgGbA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-UTsNduYAMFmoVhvOAXCO8g-1; Mon, 25 Dec 2023 08:27:53 -0500
X-MC-Unique: UTsNduYAMFmoVhvOAXCO8g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3367c893deeso2827718f8f.2
        for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 05:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703510872; x=1704115672;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQrFSUCYGMhy2SsSQLQNb28k56c6BCyeTM61vN0o41o=;
        b=Mn7RdxMMRij1LiD0T1jo6InNA/I76x8HqvCuLucgaqcTahv4Enyk3EVo2EUYS08sRa
         Es6g6aNaU+tac5qLQ5lLkd1eP1242MSrrLyQCYg23aQUiH+zHd///gqibwfwkwHbREqy
         /xXFf+FSuzlHlIvmR3znfagOvuWMTKVUs2DhS+q2uOPBHabetaDDxwn2Z3UhDoXFjhmS
         1aq8VNAMYl5zVFL/BqvXhyRxv5YIPyDvjgMA+xHXs4bk3JkhJdAJHVPAFl5FklaXMDQz
         DgzgICCg+268em0niZM0O98FztjQfDb7/vWu1HMEmUB8fKyoERTTAXHYtpyv3NpIkWAi
         a3Gw==
X-Gm-Message-State: AOJu0YyAiRaiHIqmmpp+Q7tEJ1yPlqU+h/6Cjq699cuq6Y6gYyv8Gdjl
	LN8hLX3qPldLo7K/C6FKTlGnRywHmUQE/w6eAg0pLlKLwbygYd4dIbhLCQeBif2/U9LnS5MwRaO
	sdtQ0T3cxT/pKzJavUQaQz17GsjWuNkhSMUq9cp0EmDPuPjn1iQ==
X-Received: by 2002:adf:efc3:0:b0:336:6413:682 with SMTP id i3-20020adfefc3000000b0033664130682mr2892622wrp.42.1703510872088;
        Mon, 25 Dec 2023 05:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFADLrFfKMHOhtA8f351FSOXWF1tCR+mhRQi9Bja66IW8vKteZ/pT7INfLkesHcwbnd7uOsEA==
X-Received: by 2002:adf:efc3:0:b0:336:6413:682 with SMTP id i3-20020adfefc3000000b0033664130682mr2892612wrp.42.1703510871682;
        Mon, 25 Dec 2023 05:27:51 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b0033666ec47b7sm10354728wrm.99.2023.12.25.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 05:27:51 -0800 (PST)
Date: Mon, 25 Dec 2023 08:27:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hongyu.ning@linux.intel.com, jasowang@redhat.com, lkp@intel.com,
	mst@redhat.com, stefanha@redhat.com, suwan.kim027@gmail.com,
	xuanzhuo@linux.alibaba.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20231225082749-mutt-send-email-mst@kernel.org>
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

The following changes since commit cefc9ba6aed48a3aa085888e3262ac2aa975714b:

  pds_vdpa: set features order (2023-12-01 09:55:01 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to b8e0792449928943c15d1af9f63816911d139267:

  virtio_blk: fix snprintf truncation compiler warning (2023-12-04 09:43:53 -0500)

----------------------------------------------------------------
virtio: bugfixes

A couple of bugfixes: one for a regression.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Stefan Hajnoczi (1):
      virtio_blk: fix snprintf truncation compiler warning

Xuan Zhuo (1):
      virtio_ring: fix syncs DMA memory with different direction

 drivers/block/virtio_blk.c   | 8 ++++----
 drivers/virtio/virtio_ring.c | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

