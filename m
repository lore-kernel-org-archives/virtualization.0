Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86351A0AFB
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Nov 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611558; cv=none; b=OKbOV+zulx+Uk44MfZiVKs03yg7x8yvw2iSXx8m4Y0DwM/UolY4JQoQKGqJs0S8Husla4uaXVrWJEUCtrbF1r/BZTf0gNZ5n7rmy43g3dHb8WpHeoSwdb+G4R0DbbFhzY6BO3Fqc8ai8KhwGdUlFmIwV95xGXN0O97Qyv+ahWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611558; c=relaxed/simple;
	bh=R2rfevJVocBUENusDjBfdBGn56SIQn8+tISCCPh0Ajw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYSBlzZU9g01GXL9qxEfqUrcZwxkO1eGByHUtmyxrtZB5WT7KEJt6Fqs+NyGDdM/G8SadEuVzQ0QPVs1F+Jj6nnnB1ONU+EO3dSkbXH5b1o4OGtp7MnzCaIZ4PyBD31U+m2+RywywXEKoit+0oqqa4NIUMyF2QgN5xAud0r6Kzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4LRg5Ss; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4LRg5Ss"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D14784679
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Nov 2024 19:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxeIp0BLLZS4 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Nov 2024 19:12:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D52A384677
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D52A384677
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L4LRg5Ss
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D52A384677
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Nov 2024 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731611552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTnUxHM1YFnozAVamOxNzXSxfyUECp/LxnWayVqEvyY=;
	b=L4LRg5Ss2giENYA9fdd124okLknWFqD/nwrk7rR5MNnY++H4GpZPuTvBB1wCXJ7AiYbTs8
	AMQwxoLuvE7dx1IPyEEv7KWHxqyAx/WyOfvFlqj8aOhOgyD+T/a0SXmTTs2d7ZfmQo4p0/
	301EOdmgsTPjx/Bq9MymaZAUNyYTrV4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-pBcLAAdEMK6uPx4OlG8gBg-1; Thu, 14 Nov 2024 14:12:31 -0500
X-MC-Unique: pBcLAAdEMK6uPx4OlG8gBg-1
X-Mimecast-MFC-AGG-ID: pBcLAAdEMK6uPx4OlG8gBg
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3e6069ec8fbso176099b6e.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Nov 2024 11:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611550; x=1732216350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTnUxHM1YFnozAVamOxNzXSxfyUECp/LxnWayVqEvyY=;
        b=v1d+hm6zk5vmC+wTETE8rYXrTd9KLNYuX9Orm2CrJrWyIe7Ui/+9G1nqs2beP0fXZH
         XL43A0/s4Sia9VCncLG3V5GzSdfIhUMjKIGoMEfDBYRf78rVO37kHWqmZ945TyOGDzBj
         jl8Gt8aFXEcSfNPYfRO9oVFhdnVKrjVSTVi2eLkztcyDg8IofPNDErXUw2w2hsVwhAj+
         KFwtSaHnu2LsO6L3mZeGJcMoL3Ge6Le38hbetUesdweuJF6X9gAJWVd9R3b2Zg8qZi8D
         AERBg3FISt7MvWjDXbU2Fk/XGlLBIg+g50BXelRECsSeK2b2CGzDyZijZznuNQNIPqIS
         j9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCW7CbeU8nLw/5DftSqxLaABfdY8ELYetvKG7NTErJ7YiaVlbpJnwwboLxajw4ogmZy9SnJ+EXJD9aH6AjDZXQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxNwUD53ea+j4SLDVDbEDJHjYQP8Ma/JJb1rG5W8Y8NGU3o+zbO
	90zjlKmYcLKCBHgdstyKBD/gRYEMpl2wWl6vEAqYjzLf78Af9rDKKtl+4SyKXr335vSygZkOHst
	FFe0WHL2b19rKmmo4ilQR2DEKDc8yNsZ5cjaNNnOnJM9EQ9VtDNX5cGPq0qLncmlaPUrlZQlESK
	/Pqf8=
X-Received: by 2002:a05:6808:13d0:b0:3e5:e889:771b with SMTP id 5614622812f47-3e7bc7c2ca1mr20341b6e.3.1731611550696;
        Thu, 14 Nov 2024 11:12:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+DBkcVdN3ZW4HYLNxmp9MfrNu93H5W+Q6GJnjy0KMRC+hmdn6+ZBLCKzeuJzDXmsT4DAl9w==
X-Received: by 2002:a05:6808:13d0:b0:3e5:e889:771b with SMTP id 5614622812f47-3e7bc7c2ca1mr20330b6e.3.1731611550297;
        Thu, 14 Nov 2024 11:12:30 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7b85bb8e6sm551264b6e.24.2024.11.14.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:12:29 -0800 (PST)
Date: Thu, 14 Nov 2024 12:12:28 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V4 vfio 0/7] Enhance the vfio-virtio driver to support
 live migration
Message-ID: <20241114121228.7d89fc1d.alex.williamson@redhat.com>
In-Reply-To: <20241113115200.209269-1-yishaih@nvidia.com>
References: <20241113115200.209269-1-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LR11_-FS6CG_HDAvGOuHDV18HXhfNUcr9U_9A27iQd0_1731611551
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 13:51:53 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> This series enhances the vfio-virtio driver to support live migration
> for virtio-net Virtual Functions (VFs) that are migration-capable.

Applied to vfio next branch for v6.13.  Thanks,

Alex

