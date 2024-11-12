Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BE21C167
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454251; cv=none; b=c3RqVFuZCGfDL5R1034O/SeQavwX11Nlc/6y0/OMfkyrGqH5Yx722rqKo7GjY+GDNIkwW6XzI68baen4TL5m5fXRv7GLhmrU5A2wRSQCMycpC1pn1+6JRn+8RS1oQBhMBXHz0bLn9bUwl3l3YZas8mLI4hMRwb54GO1lYoM3DY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454251; c=relaxed/simple;
	bh=QPZOFakwbsms/8IqUz2OaUZCjNqpmAIZnLYHPR78u4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CHyfrJWZMBod1IcyKw9q4Z1S0RrqewlB7vk+8djXbb5ifZfNiAXC1T34jdimLWFbw98IiYfQQA9XLHJJ9u+2MCf5B4xicecMSG9sCUYwneJtfircWqfCjMvXUJuVR7K46ik3xfvCdLlp0y4h66Yd6FjGRFrMnlqK+D8ejE2J5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoIzRvBg; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoIzRvBg"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 787AE409F7
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 23:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQuUv-QXys90 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Nov 2024 23:30:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6A019409EF
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A019409EF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HoIzRvBg
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A019409EF
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 23:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731454246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pahYg5ShvYI1JYFWF5WGQMVXj9AMRp+maWU01U95G10=;
	b=HoIzRvBg+IFws7rUo/HZgj6MrkSA4WBfKdpd4/2nkkmbJSh/2xIrFt5u/22UrJmAKhXF5V
	a//D86x4uCMRK43GUyYnShFNI4+VXSVtyBsRr/b5YRXcmLSbnol0/tsB1LsHsdHfbAXD7C
	/IWxJa9s4jmInUbgy7CrGbrY0736MfA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-BtaZ76pUOV-npyQ8JTDdzw-1; Tue, 12 Nov 2024 18:30:43 -0500
X-MC-Unique: BtaZ76pUOV-npyQ8JTDdzw-1
X-Mimecast-MFC-AGG-ID: BtaZ76pUOV-npyQ8JTDdzw
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ff13df3759so55598051fa.0
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 15:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731454242; x=1732059042;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pahYg5ShvYI1JYFWF5WGQMVXj9AMRp+maWU01U95G10=;
        b=g0orJ5St5ksdtoJzR4CZzEyrlfJBVG3Jt/S47vRWAXHosbDKu4oUbUESerP17Qq2/D
         0CCRF9qC3wGW4+hkymrNecdoe/xJU5izZftv10BvvWH16dPKIwMnpQ6V3neBOoTUxfWC
         XOUzfKrpCGFW8aenMUVGza0WyswqL8C7ARhMbdB2DJ4TglT1fum55pQwHvw5gbnguPtj
         08I37/FDB2nWa3sGrc1wYzXW4/VotbYnGi5iLdFM4BwasEtr3MHg1LpZP8L1po9sWliO
         uuCMJaFgO4JQWicezHRBjttbBltbtNeBqk6G7VacvIUV84a8Nk4V98EXSAn6/EuTTk88
         1LFA==
X-Forwarded-Encrypted: i=1; AJvYcCVTL1TAG0I6zhQvDxwMrdJ6x5y+HNQercFf1erRukF7rNHIvX7axO7kyD/hcVXjbG+1xCHfWF4icS/8Bp+mIg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz6DIjZmro4Kg/r60POOkOjFtgtG6zxZYVzaRPLrYtpQBfqqjOU
	nI7PT6qETBjpTxRZ/WAwJyOQoPaJdqpGoKpvZtFJi6Ef1Jn8nmGtawcgPCJ0XsCELkV75yjISGi
	U87RSXK4KClcIjyOwbICy97pfoOWwlOFmPaslMAzTzUYkCeJnFcV8QAlsjXi4Cwh92jc/hNcP2+
	Op3SI=
X-Received: by 2002:a2e:b896:0:b0:2fa:fdd1:be23 with SMTP id 38308e7fff4ca-2ff2028aadamr130045311fa.28.1731454242085;
        Tue, 12 Nov 2024 15:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ8235xoIzEDFqX8Iqts1f1b/TTKzRbzsKbik0jYFi7YnSriOxnAuUaNNRZk63pcxv8z4I2w==
X-Received: by 2002:a2e:b896:0:b0:2fa:fdd1:be23 with SMTP id 38308e7fff4ca-2ff2028aadamr130045111fa.28.1731454241621;
        Tue, 12 Nov 2024 15:30:41 -0800 (PST)
Received: from redhat.com ([31.187.78.204])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17662sm796178366b.28.2024.11.12.15.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:30:40 -0800 (PST)
Date: Tue, 12 Nov 2024 18:30:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com,
	si-wei.liu@oracle.com
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20241112183037-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VMa27cixAJU96qA6F3tir61ubcLM89pW-H4_dQUW0EY_1731454242
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 83e445e64f48bdae3f25013e788fcf592f142576:

  vdpa/mlx5: Fix error path during device add (2024-11-07 16:51:16 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 29ce8b8a4fa74e841342c8b8f8941848a3c6f29f:

  vdpa/mlx5: Fix PA offset with unaligned starting iotlb map (2024-11-12 18:05:04 -0500)

----------------------------------------------------------------
virtio: bugfix

A last minute mlx5 bugfix

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Si-Wei Liu (1):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map

 drivers/vdpa/mlx5/core/mr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

