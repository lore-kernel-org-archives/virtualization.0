Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413439FC1
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874799; cv=none; b=SZ9j9iZ1qZBNbqk5QrtzhX29JmI5fUb9YG6iGNoU0blJ7FehsHuEznl8rYxX39jV2aHTYVrPMV4E1+Q5EYKYJ54VLuXt6stjEbNeh3wZebuwpmvKZekNqs+xYy8EDr6FzQ+zA53TgaNmxF0iorEviPNoxUonTJ1qw4UsGJBfou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874799; c=relaxed/simple;
	bh=SoQAjBBgsyMmx7FZyCs2CojnY/io37fmcb8h+s7f7Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnNoOYzUkyix+LDK33vSwXCISadX66OJtSFU1O3eEf2z1l7UAEOjq9HdIX5B+5S9FGUMIuEOg6jbJXHJTxFULs9QmfBbWD47ZlJKel+yCzQjNFjNo7RRL3e9NnDWtPnGGTLQc4YqeZS06oDPq9QsGrZGjX1673tc3gssK5vTyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clR/9OZF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clR/9OZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710874797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoQAjBBgsyMmx7FZyCs2CojnY/io37fmcb8h+s7f7Cc=;
	b=clR/9OZFyPo03bp19cdCdyoD5GCVkdGpXEhF5HzZc92kqxUs0fAYSMu7AtIrvGB2H11hwe
	Gk8176dGXqhv9PAWzjW2n87iKMzHREADvaZzUXL+rFlq+immOR7g+KnrZUYq1wPRNF3u/G
	iCNxxp6ai8IuaJVITWGANhTM8XTCwWU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-y1HlCi9QNn-YADG6YxDA4g-1; Tue,
 19 Mar 2024 14:59:53 -0400
X-MC-Unique: y1HlCi9QNn-YADG6YxDA4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6D8038009E7;
	Tue, 19 Mar 2024 18:59:52 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB83017A90;
	Tue, 19 Mar 2024 18:59:51 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:59:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240319185946.GA1134281@fedora>
References: <000000000000cfd4800613fe79b1@google.com>
 <20240319033941-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1qhB/swQVRYSNmxw"
Content-Disposition: inline
In-Reply-To: <20240319033941-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


--1qhB/swQVRYSNmxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 52998cdd8d3438df9a77c858a827b8932da1bb28

This is the last time virtio_scsi.c was touched. If the test passes then
the issue is probably in another subsystem and we can bisect more recent
commits. If it fails, then older virtio_scsi.c commits need to be
bisected.

Stefan

--1qhB/swQVRYSNmxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX54KIACgkQnKSrs4Gr
c8hI8gf9FyLEhUZ2CxIbtdgn26qHFikmHCqcXBqAx0am78njMRBof6rhTipL4nWk
QA96+1gUvZrzC/PEb1927MJmNFLUnYgCkc/DLhaCGpuOvwuIBD++thTH1/YpSvPY
q8KVxTrv+/HNzACIBlfz9sIO7/JkatQugxHpJzRysIaylhm8PuzzPEjmTjZauve+
IOGfB06zMJZqmFZuGET+M58+t9p9hOdteoEVtDVkzGa+FXOEp4g11fspqh/h55nQ
7AM8XR66MxpKL9uUKv/H8mbfumEkBwhHmdTQXUftjaXOHSwgBQxJONg1jQVcIj6O
zP98QczOTd5mIPKWs/xKQ1IBvf0RfA==
=Rx+T
-----END PGP SIGNATURE-----

--1qhB/swQVRYSNmxw--

