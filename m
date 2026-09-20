Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAC2BEFF5
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865269; cv=none; b=avhkb4UU21Ovrhok7bkrVJ6AEa0CjxxfmtECUpzwMimQ2JONOXquN+fwGT1vLhKS/jdYjb0LOx41HTqW83BjTGfeUEA11I0JAJt/4CG/XhR31tyN1I/ZnUqj6QP4F5zM5ZLmakI+YDAkFmP0lcUxEJ2u20mjY8J1j58R0Pvp9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865269; c=relaxed/simple;
	bh=MJvGxSsNpYy/kU91KFXt9TSv8kDRgzqAw11+tcx0VCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJsrK5icV9zlBgwj1Aljr3u2EUUKZLpGninvmHndRCkQg3Uf80+iVxmWiB/ciCMVszrXQKc5tK75gnsKZ1QPZYeXHk0/S9iSLG3TF2jpqnU5mF7QJADKEUJUd6T4dZo1e0PUA+tnKK24ItfEXusRJTjqp+uDDYivy3KcLENHVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rO0qgA9h; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO0qgA9h"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e4so19962956d6.3
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 17:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789865267; x=1790470067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X2mvB3CBHopypng5GIwWVc/CrGw3Rh9PvRGGQJXfiH0=;
        b=rO0qgA9hjVbILEtuBsQ4uaQr8le5j1Buhn1vdiHJrqZlaFJBfXkyCnuY3qyq0fozvQ
         KxIaWn0f+1sS+Hz1OdI0JG26pbeZramVJxiINAfoZucFB+zfeBs+8+TOgjlwTiJmNIsL
         flpubObYkf4SPeEs1jcq0tn8wad/kq0hgmgafrLFZg/4/EwoJjynElWkkJvAMF4J9As4
         0bLkcUZ0vw/E34espqcKR6n53RdmOSw5/ND4bFc+TglTiU19PgGv8AMmvO26KGUSXqxJ
         cJd13P96RBRe5bLIvkhmhjKVzwluxvDhw6THRlHTPgJNOapYBQ7STeXf5h1VqP/SDOTs
         oFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789865267; x=1790470067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2mvB3CBHopypng5GIwWVc/CrGw3Rh9PvRGGQJXfiH0=;
        b=Oc5dCVOU8l92ixU8otLPs3hVzgzMO/NqpQ767DR7tTpy22ti3RXj4yF4L40g3b4Caj
         436ygNBxc9VdPpKkzesq7jRWH6sOWqAAjcS2Jg7rQj+VaSgF2TgmVR8UpVSfpFjKjyAi
         U9n5NhFItB7h4ACHlpARBB2YeAjepAU5tZRGLVTcoPnhyGSazqyIIrPkYnjsmx7w3r/Q
         hV+BNqGO96WSvYLuYpiXi1SjqjSyDovgf/IuJq4a8l9hxY/rbY2MU9wqZryY1zeyc5E2
         2gmKpTvTPwhe4JHvXnbLC+GbHj0PVF/vC1f1Yl3z2sYT53tDkVdzsYXQEH741iybRGBx
         93Uw==
X-Forwarded-Encrypted: i=1; AKwUvBy8VkzIC3iYfy+82kX+D59NOSUOXESksVCBh8wdVeHE8fG6jf69RhnrR/cgaHQHxD4FNZFubbZ6LwWf7YpHiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nlXyALZiqwGE2S3UKgnvA5QapZC9eJ7s9dPDU4v10Ys14WC+Lz
	RY/AfdV0DFMUxeDOBkmsVo3MHtOzZY9kVEM0jeddzrDkKmkmELW74Pjy
X-Gm-Gg: AYBFou23raWsQqWuSL//1J8Vw8abOApZADmqxXf4fBcBr1zpN8kxPpF+3ZJn3eIZF0P
	2IIPiMcIVtFjd2Ee7ncP8XDNsY9ZXM9Hk7vu8dc4r5BttNNMOyu7GuGk2i4ZmDnXUt0OyeSkPaj
	iTXL9zib9FBmWPwWkyOCLp54H9HQ8TtTRl2K1NSV1SadvAUYcA6ZV4VYuSuZR8TGP4dtUHSHcmP
	izIzKmRBc0iAvVjtOhLDGMnzBdcAA1JtAvcR35u+8HUvZohv7GlRjY4e3R+sNOwgxxow8a0ofP5
	I9PzmcaRc7OwpDoxLjpvhtxJHWs7fYWZMvF8Yb9D1dGQfG4BMl6ySzDQb/fXaMj7UzBTluJFo+O
	+i4Hixg9RzyxA/mGvYaUAoRr0mXIbv152IiZL9tr1fM4OXckTvjlRqkGN5EwYnsII/kfnSJ/d5I
	We+Zj9FaJp+Vp0YD9YYJRZO+KrqpzjPRxa5zhMflSGyBH/AgiMDp2bP8BA5RljYqDFapjhLsH5G
	PRGmrvLWSb+7sDEzyUAhASJO47GiBjPpHamK43A1VBzkQ9AUtemDEapy4JuX3eXlIK2BwvF
X-Received: by 2002:a05:6214:434a:b0:910:63c3:5c70 with SMTP id 6a1803df08f44-9129c780e53mr36692256d6.19.1789865267075;
        Sat, 19 Sep 2026 17:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:c8b1:39dc:7ddc:dd0c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9126078cab2sm32122436d6.0.2026.09.19.17.47.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 17:47:46 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	hannes@stressinduktion.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/2] net: prevent partial checksums from modifying IPv4 headers
Date: Sat, 19 Sep 2026 20:47:31 -0400
Message-ID: <20260920004733.6473-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A TUN or virtio-net user can supply CHECKSUM_PARTIAL metadata whose
checksum start resolves inside the IPv4 header after link-layer headers
are removed. On the IPv4 fragmentation path, skb_checksum_help() may then
modify an IHL which was already parsed and validated. ip_do_fragment()
subsequently trusts the changed IHL and can copy beyond the skb's logical
linear head into emitted IPv4 options.

Patch 1 validates the checksum start relative to skb_network_header().
Patch 2 independently validates and retains the IPv4 header length before
checksum completion.

The issue and this series were reviewed privately. The source reproducer
and complete runtime evidence remain available privately.

Validation included strict checkpatch, focused W=1 builds, a complete
build, two test boots, a legitimate fragmented CHECKSUM_PARTIAL control,
and both forged cases.

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ipv4: reject partial checksums covering the IP header

 include/linux/virtio_net.h |  5 +++--
 net/ipv4/ip_output.c       | 23 +++++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

base-commit: 9d565b6b72fe3f41fd43636e143072848105189f
