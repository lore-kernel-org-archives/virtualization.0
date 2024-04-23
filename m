Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39F17C66
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842662; cv=none; b=lnb9G8TViJDOXMCoDc7IemhoEM/+oPm0ZqDNeNrK9ktt+FtLZadRKSeQvsX4pZM2foIHtoNua/mtHJHMmELvt3k8qBw23R8xQQJ1EBTYszhAksbUaJu99Q7TqSOXG+ddQqZLRpPmjVqVGCtVrAtrRKlG9HkeGa7XEh7aScJO8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842662; c=relaxed/simple;
	bh=vJd/n/kLvdmg0NXk8w7mFiI4hyLJQTdFN7rDrDQQPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ua7X6r+sm1eaAieiiLD4rsOKxL4qkBv9a2amyt8vj/AGCFzXUrCz0ebbuqRyb5QducOHNAuTpA9b4S6psoWLa8VwMQhDuhkLnkgY/UwdDKMpT1Bzizi/l+LWDP4IAT6Fdki5ueyQGVnqvbbZrwGOpfFIFXJz0YZ/xH0LM84JQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+ZMNK1n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+ZMNK1n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713842659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uscwOeRn66pE3jopQy+2n8hg6XRUl6ziX3+2s+Zw8uc=;
	b=N+ZMNK1nUFfbXIm9hNI1675REZKUW3c0vHp2qtuL+EAxQN7Fy1TlNghYRKi05dBI4piWZW
	Ht1XcTKoIhTELK/oIujokZZayKCb8GkHz7W60LdEiR2q5n3swdXOIWXoTLo1qhm7dAFwE+
	5kZ9y5FeJMuXfEj0FY8DK5OQ6Igq/9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-6yDpHTlLPuuE7jwtjYSyOw-1; Mon, 22 Apr 2024 23:24:15 -0400
X-MC-Unique: 6yDpHTlLPuuE7jwtjYSyOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E6228943A4;
	Tue, 23 Apr 2024 03:24:15 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4334C1BDAA;
	Tue, 23 Apr 2024 03:24:12 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 0/4] vhost: Cleanup
Date: Tue, 23 Apr 2024 13:24:03 +1000
Message-ID: <20240423032407.262329-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This is suggested by Michael S. Tsirkin according to [1] and the goal
is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
the caller of the function needn't to worry about memory barriers. Since
we're here, other cleanups are also applied.

[1] https://lore.kernel.org/virtualization/20240327075940-mutt-send-email-mst@kernel.org/

PATCH[1] drops the local variable @last_avail_idx since it's equivalent
         to vq->last_avail_idx
PATCH[2] improves vhost_get_avail_idx() so that smp_rmb() is applied if
         needed. Besides, the sanity checks on the retrieved available
         queue index are also squeezed to vhost_get_avail_idx()
PATCH[3] improves vhost_get_avail_head(), similar to what we're doing
         for vhost_get_avail_idx(), so that the relevant sanity checks
         on the head are squeezed to vhost_get_avail_head()
PATCH[4] Reformat vhost_{get, put}_user() by using tab instead of space
         as the terminator for each line

Gavin Shan (4):
  vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
  vhost: Improve vhost_get_avail_idx() with smp_rmb()
  vhost: Improve vhost_get_avail_head()
  vhost: Reformat vhost_{get, put}_user()

 drivers/vhost/vhost.c | 199 +++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 111 deletions(-)

-- 
2.44.0

