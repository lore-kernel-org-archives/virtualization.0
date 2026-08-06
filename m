Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BE78F2F
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998923; cv=none; b=BvNC31qafPjAE6C1v5Gfo0wHxdMzxhex8SvTzZ9EBTmmFY+1opHUDi0JO3ynQuiP8S3/dEX6q8QQPwX+1/eW+6VbuLiwkavceWwbm41Fi9+EYsWQRQDXJsY+bjzbh4D4go+MqoKpi7BR8lXyvqaHbFXq4ajrwOERTp3BgaurxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998923; c=relaxed/simple;
	bh=UlSxC/IGkFSyEWyf+H6ebBeCR5E2aPJizh7NpsgGceU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prDwDLge+TEu+rFK2hJEorGU6MjEtp0ogla/mCVpYvQkFeuf6rwnU6L6A9XKAlRXes7W2eY7n4IUCbxVGJCOJUkHPGz1hwMfgDKUu/kKwdD4ffsyyArRaO4PwLZekG6JorXci2fx6GXjR2NCgQpvTJu9CFQyMaZ2m8ghiR3PnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jI5BYCug; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jI5BYCug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pa
	6OiqX1zb8L5xDXhjVSQYi7w3Th9fBmhxjtWgy3xM0=; b=jI5BYCugPDGGpsrCUl
	lz7lduzxWVyY6RhVBHFoul2J8scQggPC2cmzs0LvkJlfb09RD5jykZmSCqy9E0x/
	12361wF/hxKDsMzHL/0sQigXC63MG0Ey/YhK2UqYkr3k1cydLK5AS3gjQ8sufqzm
	UAh35083LT3ls6QsahgAqDJqg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAX4vg_LnRq_fcuKA--.37967S2;
	Thu, 06 Aug 2026 14:48:33 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: virtualization@lists.linux.dev
Cc: eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/virtio: add --features-array switch
Date: Thu,  6 Aug 2026 14:48:31 +0800
Message-Id: <20260806064831.45871-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804080125.79403-4-r4o5m6e8o@163.com>
References: <20260804080125.79403-4-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAX4vg_LnRq_fcuKA--.37967S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R_J5FDUUUU
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzgJTyGp0LkKkTAAA3N

This is expected, not a bug in the test.

The clear_user() start-address issue in VHOST_GET_FEATURES_ARRAY is the
pre-existing kernel bug that the separately posted fix [1] (Acked-by:
Eugenio) addresses.  Patch 3 here is its regression test, so it
intentionally aborts in verify_get_features_array() against an unfixed
kernel and passes once [1] is applied; the dependency is noted in the
cover letter.

[1] https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@163.com/

No virus found
		Checked by Hillstone Network AntiVirus

