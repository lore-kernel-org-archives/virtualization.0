Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D31495057
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157245; cv=none; b=QPpZEga4yFTdIbPMlfQwR71pJ6Tl/sJONn4NLCryK/B9ZSoj+LapE+ytTky1TUTux6VhV+01q1fqjANnzpQe52FFlIrPZYdnzEB4WrWuhuj4YHDW/d/iFrqvq/tjVc67eDdJDMmltr8TU864VUXeYbLGnkiulz7Xdi3mE/WoKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157245; c=relaxed/simple;
	bh=6494+ZvYu8FHV5Xw+CZy5G3PfZ+nMzT4PcwZU8DlDjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hye+VTEAZ+7CubhtCERyqOmkoCtmBw2c0LoAKiIe+Zv110Hyb9IAeiIJkA1QxrparFDb+1/CKNd8orYwIE0DHVGmvLrrhqbpgPXIE11AgLHZ/r94VzK0bTzmmec4WCUO8qy4aYsI9d1ecKjXXI18oewqDb/o/52EKhFdKCvfKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eABNS8F2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eABNS8F2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso12101745e9.0
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157240; x=1792762040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifcJs/P3/5U0EMJlqsFCLeJP9WV/BCVB8uVBDkA2xCw=;
        b=eABNS8F2HJqZeSt+J3oiB4lMhijvbL2XTcZEFtnPeLMSlMY7j0cP4GiIkZ3ABIAPj8
         P8iz1p0nzmEuIWB6cV7TcDNrCSHuon+ZeN9YHc6i0AKhmJT9FxS+rKklFIYmVUY4xpt4
         KhIrC5x1g02PoBKOSfUbwyD+PaKr3/0poYCHQmyp+M7DD/wNCKzrXGTK66ZDgKx8FnOX
         wjSGSbycRLw1UBHUZ6Yr+cwHgRsonSouAosH+Rwl7nq3dz8KPbPPn6632wcPg7Z4TYcq
         GUI2Etj2Zfsk/dzWj9y84V0Pz+kZUl0Jm49EiQAPIzix14/s3U2aP1nJIx6qK/n4TWy5
         mosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157240; x=1792762040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifcJs/P3/5U0EMJlqsFCLeJP9WV/BCVB8uVBDkA2xCw=;
        b=ese80g/kUyjNBxC9nELMlGInW8Q3SGMW1gXxbU8eAzNTb2+Mr3ZOVqoXT3J4WRwbov
         qCfBJ/He91RROUZvtdMcgXVPKnPfH4x1a4Emip00Gmo162i+AztBwWWVyHKBtmcfOAll
         I250MXw+k1Y5SvQbslbVzoapSCuPz+MOIUmnv5vZddl3AjJHfKoKWCYFnxAaQoRw1e+D
         TCOq8vKXxgpo3gp83j7/esJAch3SpnHBImWrs2yRs7ShWieuwikABdsgblUk/7Zd/XPS
         lio2DYMvvJ9FX53e0432lcS5G6GUJHGRDZlKYFiFMJUSUcbsHSf8C+f5c0SHrVBLIh1u
         Yz3g==
X-Forwarded-Encrypted: i=1; AKwUvBwr4VtnpC5PdEGwfNFi0MuOjOi2nCBMxGtkOv9xr9LJTdlnI68XvXyDkwJIxkfk+jB2CiT6ucLkCOt+swmOYw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKpDh3xENuBjJBShPLWWa4bDSYROhYyFGNVEVZDn1Iojm+MJ9zY
	HcZ0/d5dyHvS7yOz3e/F4SnfkToIkwMz+uQSfIsSA/3NCKoXi1xQjhoh
X-Gm-Gg: AYBFou10JhQ1Wnp4v38i/VCBi4vrW8aji7AD+0wXS8OatJQe16Bk8uH8M+iuXsXg/nH
	zwlfjW6NhHkcLj4YoTyfPYJ5sr0lIEkJRrSPSTcw/27F5SO1VGVrkuW4p3t73NVE7BctcNczzjE
	dLKuQbzqcQXwF518+GfNCOzyWRCdSSGZNWBmUOWDC3qzR7+AUVo8IngRDncKGzia8HbOz93Pt5A
	vkrg7uBYWcZrChFnWckkNhzlnbLbRa6urF+mm5N84M6fDgBNR/F7liq/n1H2EzNwEXp3ONV6qOU
	Rl0jriwfAwyHZH1t1yuqP14O+98Ovkj+HeR9+6g/zbZjhSSkZjTQgUZ23F82zaueAqQbj6E041A
	NDTnxPIEXpO3eR2yGd9djEWuT5gNDx4edAZa//Iveei/7CCIgsEAHco0sON3wZkwURZkVb5/aVu
	G/5C71b4VwSs24zGljAQ0hUW2752+t361ZboMSMrZ+Q5akN8BV61vNWSECZnK9OJX/prGSpeNAN
	MD9KyDUjP7gzWsCWHAMP6PqUHIUi4xybqYD1b73FSHZPkHWNtsqxX/Cvms=
X-Received: by 2002:a05:600c:1f86:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4a1c6672f2emr64239555e9.10.1792157240153;
        Fri, 16 Oct 2026 06:27:20 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm58114275e9.14.2026.10.16.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:27:19 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v3 0/3] vsock: SO_INQ for stream sockets
Date: Fri, 16 Oct 2026 14:27:13 +0100
Message-ID: <20261016132716.272018-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the follow-up announced in the receive queue hint series [1]:
SO_INQ and SCM_INQ for AF_VSOCK stream sockets, as AF_UNIX has.

Patch 1 moves the SOL_SOCKET option handling to a helper without
functional change, patch 2 adds SO_INQ and patch 3 covers it in
vsock_test.

The value is the one SIOCINQ returns, so on Hyper-V it covers the
current packet only. Accepted sockets inherit the flag from the
listener, and the sockmap receive path does not report it.

Tested over loopback with vsock_test and vsock_uring_test.

v3:
 - split the SOL_SOCKET refactor out of the SO_INQ patch (Stefano)
 - rename vsock_custom_sockopt() to vsock_sol_socket_custom() (Stefano)
 - parse the value in vsock_sol_socket_get_bool() after the per option
   checks, so SO_INQ on SOCK_SEQPACKET always fails with ENOPROTOOPT
   (Stefano)
 - reflow the comment to 80 columns (Stefano)
 - carry Reviewed-by and Acked-by on the test patch; Bobby's Acked-by
   on the v2 kernel patch is dropped since it was split and reworked
v2: https://lore.kernel.org/netdev/20261015154334.3217358-1-devnexen@gmail.com/
v1: https://lore.kernel.org/netdev/20261012235524.41468-1-devnexen@gmail.com/

[1] https://lore.kernel.org/netdev/20260923184008.153541-1-devnexen@gmail.com/

David Carlier (3):
  vsock: move SOL_SOCKET options to vsock_sol_socket_setsockopt()
  vsock: support SO_INQ on stream sockets
  vsock/test: cover SO_INQ

 include/net/af_vsock.h           |   1 +
 net/vmw_vsock/af_vsock.c         | 125 ++++++++++----
 tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+), 28 deletions(-)


base-commit: a4057f51efc2b74ddf46721e83f45e9efb13649d
-- 
2.55.0

