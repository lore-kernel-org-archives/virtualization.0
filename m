Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5562A11
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097607; cv=none; b=Yq1FBv5UxbHBJU+Xqz5W4Jaoawz5XCmA6/8xWnkaQc90zb32Bq2SSx/Sgqx0fnqVQw2Xk0KYQ8PpEFm9UVtw130eq3bSxfLsCjyL5zBdBwq5UiEvBUBZ7wozVvPUrWKOm6Z4a7LKmgifMlTVObdTDQyE6r2lJcMHRPTfOfra4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097607; c=relaxed/simple;
	bh=s+U/I1kbGvtdSDHN3vLuy14cJeTvPNTBLK9/RJFkaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kLSBr4Nz7RWDiJLdOvWltrQI8O7152eLqEzo8YhbNXQXClFZVWBQ0RbrrZedLJfL74MMrjcvkLq9gMPlbfe2DJG9xWhGgGsa4lYQhfsHpc9V0HZpJqTX6gjFVIu08iVghKO2Cn29HOe2jGwSMADqnqIxOYJa3suibiDcyR5prEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UD0JkuyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UD0JkuyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706097604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EOJO21mMWm9Ve37XvF5zAOvUvne3pqlm8zmlzW92C/4=;
	b=UD0JkuyHeCT2yAXrf8eml7ceMkGXmYayeHDpf2r8w0lSNOxJUJwVqP+UAviAcDbNcvmH/n
	Qz8MMWnxdQY3ztZEJz+pKkv2mVe1JdLys6DXPMFdfPCApe88m9wiyBvWdcnu+mzmy5axaJ
	A9qSTgHBTDOsAxRuBqs0w94IAWXaDUw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-hTHzp1ECNrKOB1WIMu4y9w-1; Wed,
 24 Jan 2024 07:00:01 -0500
X-MC-Unique: hTHzp1ECNrKOB1WIMu4y9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C43F73C0F1A9;
	Wed, 24 Jan 2024 12:00:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EA262166B32;
	Wed, 24 Jan 2024 11:59:57 +0000 (UTC)
Date: Wed, 24 Jan 2024 19:59:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Cc: ming.lei@redhat.com
Subject: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Message-ID: <ZbD7ups50ryrlJ/G@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hello,

Requests are added to plug list in reverse order, and both virtio-blk
and nvme retrieves request from plug list in order, so finally requests
are submitted to hardware in reverse order via nvme_queue_rqs() or
virtio_queue_rqs, see:

	io_uring       submit_bio  vdb      6302096     4096
	io_uring       submit_bio  vdb     12235072     4096
	io_uring       submit_bio  vdb      7682280     4096
	io_uring       submit_bio  vdb     11912464     4096
	io_uring virtio_queue_rqs  vdb     11912464     4096
	io_uring virtio_queue_rqs  vdb      7682280     4096
	io_uring virtio_queue_rqs  vdb     12235072     4096
	io_uring virtio_queue_rqs  vdb      6302096     4096


May this reorder be one problem for virtio-blk and nvme-pci?


Thanks,
Ming

