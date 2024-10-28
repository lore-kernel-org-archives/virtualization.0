Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27841DEFD2
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139474; cv=none; b=CewvoDgKNjLlATSvuyeZvJx4ODBXO03lXuJgiII1Ml0i6yblC9MyR5djBH2N450rDe6xwRZgW2VvUzGw8cRs0DsqNppC8aOs3RS5D7dlTIehObW9kdXk8cFWKcx7dhVkjcUBjzYKsPizFLcprkA/G9dtCZ7+KPXo7BdaOdPzxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139474; c=relaxed/simple;
	bh=BI0TiyriFR9sBLWv0MTNVLSTtiBR6zB5VM599YILyhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfgVeGXUzB8c3oOkb5E2SaaoBgi+HXrimTi/UIo0SZnI6UeBN6jqBtP0QAbBY6Np0BE/eIksH17JBNQghhElZcwMpdFyxusFObJO3hAoN+mRJk0ZavWzXiV18AUAXJm30fSdetZBj39Aph8n2SbrdG4oagOsJB+i92/0LugR/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeaUMXhd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeaUMXhd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B7BC4097C
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 18:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzXXofM2UXgK for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Oct 2024 18:17:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 640F2409A8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 640F2409A8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JeaUMXhd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 640F2409A8
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730139469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow6yg5EfDFU7n7Pa/d9u/odwnb2QoL21BBF3d5MTEfc=;
	b=JeaUMXhdP+SIk4w6v9LI6vM8VaJ3n7hdZ45QJytk7yGMC3wgI+Oo7S5hME9j5eSFXmrVXc
	IbTX9sQlax++nKA0LbWt7I7dZ8nkOZMEGZ+5ZSRfuD+priWRTVYCjeKsOy3M3HBkT8VTc4
	iY/Wb8/1e1Mczfc/PX1tOTLLSmY+mXE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-XX_LQ8WFPKG1pc7V_cWVdg-1; Mon, 28 Oct 2024 14:17:48 -0400
X-MC-Unique: XX_LQ8WFPKG1pc7V_cWVdg-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aaad1b050so50965639f.1
        for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 11:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139468; x=1730744268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow6yg5EfDFU7n7Pa/d9u/odwnb2QoL21BBF3d5MTEfc=;
        b=YfFSC8Dl6mm5MBB0nzZjYLQfcu9WzeTkxkz5ofN9438GexziG/Jt22YHUFEpIynURL
         d7IBJBrY7dXkGqRWX661mDmDR4PnFwjAPFCIylA8kS+X79FOhK+Fh6HxB+1yAdCA5R8B
         Dm5l9xTo+bvD49Ne6ISxeD6d7ZKO97Atm2wSkQ0dJ4Ao3LjdeJ5qPLto+7vJggpwvoBf
         LuKG0WLThaVHnAYA3WJiokT+jHq7ZE0p940mVFyOhfnOkO06WHn9T+ckoPxlQETgJmjy
         jbnAXQ4nNM7npQ2ICZ9KtOBeq9B17qnynEmxYPdY7C/6tj7wS7bOaDmqgu2y2PT7Okfj
         Z8cA==
X-Forwarded-Encrypted: i=1; AJvYcCWCnMqB/baCFCymGauWPqybWeQCe0PD+zENmoSr0J/xzIY44uGdtW2nmtiHN0UmweT8oesdRD8n/7ko5Yt42A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzymx8AovjikctrVb07mYYXVyrpCHJ5plucVNzkLTAZeTnATwpu
	qYHNUXGZZYJ/FgVeJXiiyEYKbvrQvhmVkdt9CpIYwbE1ul270qhX2kjiqXhkTs+LfgCWc3L0eSc
	PcBbu7Egz8Grw9d0s4obh3V/Fv8csg3/qZTY6NHms91BFz7R69Kh7IdQiSOJTu39cmhiLu981JD
	ID6UA=
X-Received: by 2002:a05:6e02:1d19:b0:3a2:6cd7:3255 with SMTP id e9e14a558f8ab-3a4ed30c266mr22182745ab.6.1730139467888;
        Mon, 28 Oct 2024 11:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyaCZsOb3OubpwLQK2tvyyyBnC7J+AwIr3XfWRoJc04SSKzCg6MWaZngCwZ2ehfEY79ESAGQ==
X-Received: by 2002:a05:6e02:1d19:b0:3a2:6cd7:3255 with SMTP id e9e14a558f8ab-3a4ed30c266mr22182605ab.6.1730139467445;
        Mon, 28 Oct 2024 11:17:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc725eb673sm1826022173.16.2024.10.28.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:17:47 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:17:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH vfio 0/7] Enhances the vfio-virtio driver to support
 live migration
Message-ID: <20241028121745.17d4d18c.alex.williamson@redhat.com>
In-Reply-To: <20241027100751.219214-1-yishaih@nvidia.com>
References: <20241027100751.219214-1-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 12:07:44 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> This series enhances the vfio-virtio driver to support live migration
> for virtio-net Virtual Functions (VFs) that are migration-capable.

What's the status of making virtio-net VFs in QEMU migration capable?

There would be some obvious benefits for the vfio migration ecosystem
if we could validate migration of a functional device (ie. not mtty) in
an L2 guest with no physical hardware dependencies.  Thanks,

Alex

