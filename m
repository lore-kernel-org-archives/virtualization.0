Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D94BB266
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493471; cv=none; b=IKhHMWLQthoUmRuWGR/Npqt2JmJOWg/rEtbf67B/wueDMwQV5TcXJcItPaS6Agh1eD5F26k68to2OIXbQlutGcSZlZGsFj6IYqJMsr5bOocAvlpFTFkimgMpVpj/C/F+6dvQOAz+aPzijoPS6zRdgREApxnqGJzgLyG/lFq2Hq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493471; c=relaxed/simple;
	bh=1L41fDFcwJhnqwC3iHJYWgVyCIQZycnmy2yM9XthIjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezXCqZE/owoigrjzT9kT85ESzIwf12SlVr5OJQgbvwJyvMIXXMJhxE9qASNOrZAkpBdxNv8/c8gxRScmiHQ090a778pX10qQ4Oa/+njUiyjD9BziVM+zKrBDowAKUUAj8vlTG1r+98pFs9vtrAdXfU8YJvlqmPXoCjYWCq89RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpqxF6gd; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpqxF6gd"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982e8fa91d3so576933241.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493467; x=1790098267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RgblY6L8XKeLM/vcFnT7fWo1z7GUneU5Hum0ZMmOcJE=;
        b=XpqxF6gdI/uXAXSyj5maTJikYsnbos0mOFbq+86edKuPouZgg/xnsgEfp9tsNpYtYq
         DEuPbgAv3gBrSZb474NFYZ2eY2SUamr9+pkwFCeUvAXbEIvIZBS16EJ1vZbdya/aOuiV
         XoQuCbYwQxFJI7FRop7zr7Vfim5LncmHq2xSKngbqC13G+pYlbwLNS4L+o1kzCXV+h84
         /MX+PqmLeX98f3bJ6zgQPGsNtRhVyUNiMncUscB3sv4bYFx1T9ncKatN55mLVBjSEoBC
         68JnxsnEKpBjpBqPi76JYueZrzD+Gq8+fJ5DwVD/PZNa76gVWLRl1ix08Kh1LWMJSIN5
         QIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493467; x=1790098267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RgblY6L8XKeLM/vcFnT7fWo1z7GUneU5Hum0ZMmOcJE=;
        b=TcwOAlGZIJESwSxvI9wJkpJryruMg4k1rp6eHJOzVFXPI84LU6a/FiCDwTot66E/Cn
         bhlvjMJzv2rRtM9k6DTWamYrPzQe5KbZ+zU3NJEu2y3r3+9hiA+YO2Drfq7KgsGAwWUw
         5k30AsT4K7178Tg68mDXPFPgKe7JvePYlnrqE0u6KB3dpZ/4r2vNFyZ5i18dg7sqfzcT
         t/t6OTwyQIGqsQo47WthPxRvV15o2FfF8Fqi95Aby5fNS6yT66LClcKIfW4P5F+ngJsh
         0BT3CPc9nBlraI4mVKGkoyhdbXmaUvRMJApHwLPO5n3Nmp564s76WqQ5oCkR8ZbXhEYG
         aFLg==
X-Forwarded-Encrypted: i=1; AKwUvBzpw1jhDNhWzGw31oDx7uIWrY7K66IWH3hpilhKxC0exXeqLL3KcJAOF1wQjQYGVTS5UJvTF2wtP4at+Oslbg==@lists.linux.dev
X-Gm-Message-State: AFuF++l+H9DN4XZon053pApZn/gUWx6SUcimaPghb09wIW/t0RtVqjTC
	IGlNtJmM41kI2sRKvrz9+q7k43HZPETn8YR0Y9fbWQuupz47un4ZrYXI
X-Gm-Gg: AYBFou1EN+6xuVfaHKWio6YSz9rIsFwEWfYlbvpoqyI2EvlFcmeKzesrx0TpbqpJSSs
	EI4k6NM3IojxfabekeHUsTV9XS1mbhJPCHvcqbRGnP18Kh+yXh3SAsFWtZNJ/VidYl0fkkZGz7U
	BDYU2BY7hOopc1cPZIL/VOv2mTKXOsqaiBiyvqy0U4zLarf+I8jdQNfQ7Ii8vqsn9N0gm8Omy3/
	JwFRWYqgsIJB8AoWF3hxD48pOOgY0o6RmJRUCUHWwBLDHtzQ/+mdiCBcS+8HNObGMbETnBGZ7Wg
	ae7Dql3/UxeRqCD5vF8gn5SenUouUMYWoiwTgJg4wgM8cXGQrh8W5ayDtRjWm/2dhMk09Kq4+hU
	a+wFaG2yHvflfyR1DEb9TUq+YtpKNhlueVelMGlWxeeETM2RsuegHw+JnMGEJcyQHuo9ySzNxli
	RLk0nAL052Y1cZ09HO9HcjvtF1BQsh5+7VwczrmCWpD7labwVLCu2sl9aDsoeDb9t8
X-Received: by 2002:a05:6102:8687:10b0:799:f608:79e6 with SMTP id ada2fe7eead31-79d2319d752mr2295720137.1.1789493465871;
        Tue, 15 Sep 2026 10:31:05 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb104b2a6sm310677137.3.2026.09.15.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:31:05 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 14:30:50 -0300
Message-ID: <20260915173050.3176344-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the transfer length is zero. Its caller then reads the uninitialized enum
and may permanently store a stack-derived value in the write-once child
mode.

Return before calling __vsock_net_mode_string() when *lenp is zero so
that the helper is never invoked with nothing to parse and new_mode is
never read uninitialized. This also prevents an empty write from
locking the current mode.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v3:
  - Move the !*lenp early return before __vsock_net_mode_string()
    instead of after it, as suggested by Stefano Garzarella.
  - Add missing maintainer CCs per get_maintainer.pl.
  - Add Luigi's Reviewed-by.

Changes in v2:
  - Return early instead of initializing new_mode to the current
    value, which would silently consume the write-once transition.

 net/vmw_vsock/af_vsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..XXXXXXX 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,

 	net = container_of(table->data, struct net, vsock.child_ns_mode);

+	if (!*lenp)
+		return 0;
+
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
 	if (ret)

--
2.43.0
