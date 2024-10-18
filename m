Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08918200C81
	for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262982; cv=none; b=DirSwFeWukEyw9ychE5tbt2maChHp6nYkzzAjfXbLHyvli+qNN+hAMT47+3iodIsjN6vASveq2MmBWGZGTGFUzaz6hwcVsiBqhimGTpAge213/KA4AOwo1a1DPxx75OMgb7MJxOWXz7MCgB13s5U/BUd9q65/Kagy4di2BnoYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262982; c=relaxed/simple;
	bh=OFVzv/Bzy5SEVC2fr38Gqy63G+CyJt1NjMHppf2By3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mUHpmnXs6WbpX+TJxdqPyPHb3Z1xPx1fB53mHHpvg13oG62OIpq7UqCTbTuHA7LmgWq60QxvSsk2e6rliSxv+5Q/z14OcCkRZ5GMkKvLfYeUGaO/6sJUoBwgTI8iklmgi+ebqCFMujVbVyblkiLF7ec+IiCEZo9sxVaxDy8f+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTe3ul7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTe3ul7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729262979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLK06kjenlDOhOsBFo7iWO+e34B5cBf5XFw1B3ccV2U=;
	b=iTe3ul7gt8Ctz03GXvi465eB+j/B4mQkW9yZ8FCSjEeE0Dl35L3gQmAhDNolHCumkxVHPu
	K8NDn4XVdh+hN7FcJOLBtXL1SMJDBR7HASZjhwwj6+DgmAtqIn0GLkH00/ZyowYc2O9+OH
	br7/L3oEmFVTP1unkEN+9/9pbOLLzYc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-vgFRS3VjMb2RDLxYhDQotw-1; Fri, 18 Oct 2024 10:49:38 -0400
X-MC-Unique: vgFRS3VjMb2RDLxYhDQotw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a7fa073718so335495785a.3
        for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 07:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262978; x=1729867778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLK06kjenlDOhOsBFo7iWO+e34B5cBf5XFw1B3ccV2U=;
        b=r1h5BemROiJQ59Dia+BlPL6q2e5j/tweS2z4gjoVuKEkpsEwMvb6h0yruadsYs9hVU
         uIGjIvzzriPFF4AkZH5OudOT6vV65XcCLQV/tUtTEx9mWSVXf09J7WyeMYsAnTsyjeP/
         gXSRy2UJSgtnhDhg1DzGLkZHLgFtFKAMA0675HhgL1VZrk4PZ4gd1YZ95LWMLLcvWmv+
         m1h/sESlTsyrzGqjY2hMHxkbOo/vjwndc6Fa4koCMfMqRA143X67Xtr6yGYYmg1OIKA7
         oT5pC4f3M3v1KFo02cyUi0mJBjea17C08v17kRipguDJlyihrmjq0QGbJ10mecAgy74o
         z7jA==
X-Forwarded-Encrypted: i=1; AJvYcCXgMBkkYpE4vlf3+bPPFIQuqcYVP1KUvBHTI8zBzglHk6m0Nw8Exb/f8R48Pgy2/dNpLXVp814nI7yizhWdPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YynRdvSca+sO3lNsNhDR1NlULZtwgwT2Du70+pEZLpaJhmIB4k+
	ySaUQoA/809pqo36PJsAFYWq20A8Cnd6v9tfNaF8zxsFBqvhMBR+aYXqFxsIOlS9gRXLTJ79FAA
	E1XUwWNFaYL6fldJ5Gp9YXfjj2lcBDVyjMLJcysooSCN3r4zDSiQtyTMlDmEJZtUb
X-Received: by 2002:a05:620a:28ca:b0:7ac:b3bf:c30c with SMTP id af79cd13be357-7b157be329dmr296849585a.45.1729262978350;
        Fri, 18 Oct 2024 07:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdfckV/4mq/+sa6eyJY9yg4483MucXF6w+/neilLz6xBQ/bACL6PpfbLYrwxMWUXC6aOTZ6A==
X-Received: by 2002:a05:620a:28ca:b0:7ac:b3bf:c30c with SMTP id af79cd13be357-7b157be329dmr296846185a.45.1729262977922;
        Fri, 18 Oct 2024 07:49:37 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156f9509fsm75604885a.30.2024.10.18.07.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:49:37 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:49:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
Message-ID: <xyv4vzeq7tqq6qqfafaqxfohgmwu5tx4sb4pgg6dilpgqou32m@l4c5il7euzpb>
References: <20241016072553.8891-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241016072553.8891-2-pstanner@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
>In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
>pcim_iomap_regions() is placed on the stack. Neither
>pcim_iomap_regions() nor the functions it calls copy that string.
>
>Should the string later ever be used, this, consequently, causes
>undefined behavior since the stack frame will by then have disappeared.
>
>Fix the bug by allocating the strings on the heap through
>devm_kasprintf().
>
>Cc: stable@vger.kernel.org	# v6.3
>Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
>Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
>Suggested-by: Andy Shevchenko <andy@kernel.org>
>Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>---
> drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
>index 99428a04068d..c8b74980dbd1 100644
>--- a/drivers/vdpa/solidrun/snet_main.c
>+++ b/drivers/vdpa/solidrun/snet_main.c
>@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>
> static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> {
>-	char name[50];
>+	char *name;
> 	int ret, i, mask = 0;
> 	/* We don't know which BAR will be used to communicate..
> 	 * We will map every bar with len > 0.
>@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> 		return -ENODEV;
> 	}
>
>-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
>+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
>+	if (!name)
>+		return -ENOMEM;
>+
> 	ret = pcim_iomap_regions(pdev, mask, name);
> 	if (ret) {
> 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>
> static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
> {
>-	char name[50];
>+	char *name;
> 	int ret;
>
>-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
>+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
>+	if (!name)
>+		return -ENOMEM;
>+
> 	/* Request and map BAR */
> 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
> 	if (ret) {
>-- 
>2.46.1
>
>

