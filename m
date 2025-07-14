Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7042E3706
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473864; cv=none; b=H7gp27FL6O8KiLyIuklllYRQs1MThFMrmf+V/UMPcFN06VWSMTpYRH/wI/+UXZUf7/dQKosQNhigZqsTianSShjpo9oY7n5G9MpSanIqI2vmwHUTxwEVp7elUazQUU5XuzR+6iffMJ+d50WtgasW8q68oESuZ8+AitFzmCY/LAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473864; c=relaxed/simple;
	bh=VBy6PDnHPih2lBK2ZZwSq9hR6E2HRl5WrI7AEF/MP7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oVQoQIFdPoxeS0FJ8CrJbtY7sDg5Tuhqj7C3MtKaBC2xC5Cds0Rwuzpof/zDMFAzReXpek2Irpe6PyOwT0cbMpu5v16vEc9c5xXVw/P25vhIlMFomdqe4COrEhM6/Suyh/t6EV9OmLEh9hY6Bk+HKy75Zw7KyAdNmF0dZli9uQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhCyYDKb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhCyYDKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752473860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw7vr1HISEyMElnJL1/B0+9vBI9ECMEq3eIFOntmoI0=;
	b=UhCyYDKbIUMUFQ7AzuzUXEcxpcwFYBPETN3p8dLafarA8oWFLroPPSlVELWm9/t2mgGQU5
	d9VK6vP0mwnriHLVbQeFSfL+yKyD7k0oycx8ibh08QB9VudQE2Jys+eXdcNA9yio69lWNa
	qRF/965Rjf3E5wcJEYDJyoKkMnsjMio=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-y2-LboEPNWGrJIuQsn1lOQ-1; Mon, 14 Jul 2025 02:17:36 -0400
X-MC-Unique: y2-LboEPNWGrJIuQsn1lOQ-1
X-Mimecast-MFC-AGG-ID: y2-LboEPNWGrJIuQsn1lOQ_1752473855
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so24989735e9.2
        for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 23:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473855; x=1753078655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw7vr1HISEyMElnJL1/B0+9vBI9ECMEq3eIFOntmoI0=;
        b=BNwSOMGkFn6extfv+9wGgzSVouuUVihTdD7UymkUH5X2offYKA71rr/YQMaEvQTUM3
         9EZsDjZUyy713Kb+MvaC8vjdMJTpA4EPRC2rmkXUBN9WYk3cqJT2YqzxmliW5J3i2Bj2
         /E9bM7vr3ttbhrBJIhr0ltqfjlra0mk/y1jVCwlqkTtY/izBz+YlWyhlVWEc3wWeSrh0
         02vDNWXkt9FSae7pu8ku3Kdl3kYAf2xwyrAWhSJRKsl5mjJ9IoRA5tqOJJi/ji8thvVi
         xAD7r42BQumLGFo+L2Jl9/r+lkVSQxFGQVGZ9GTxZtUo0OjWNt3ED9hQuKmWOOH8DMXS
         3wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+drkZFR34RsuqBRcA9ZdCyhQi1fxmjKg5CNRQ0CtK5DSbcKmQ4OGUDGLgmdtJn5KQBf0ZUtgtf2xAlllURQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4uHxtk+yq7h2wib5BpZQZdnKMS1zef9Mh62PKxwmBHV7pToiw
	xvy/Id3Z0z7uMKGegkheKFDvfR5WrU/N54lH+UJnVKsl06eiRGSAtEy8hXlnXrvnKmtymbId3uQ
	/HeedHxVO08m9Z14xoTP6jY1NRyCyqBti5tgfmMBf2e7Q8hj5vH1kBylAqCz9alx8hwbd
X-Gm-Gg: ASbGnctfomZW9GknRZP4Prqxr9CjyOJ4UIUsQClGhZQFioGY9cS8zzfOuhuLnhaiGS2
	0fAzDZ+xgu9LhJy69tLssx9vukKiOrZ28G3JX4ihROZ491PZTYUlv4NDHbLYtC28/BB30ollcjc
	2q5G/qeaOBwwLlXq6wR3CzFRa4cFZmjnStyasJGD0P4iXJR5Q/E/P8YQBTJU64LhqxVn1zgtCIX
	ni/N42XY/b1yfLpr71ZyXH5AMKqOOGTjc3EKHKlyYdhuSPjXgZ7nFB+JlqiasA0qA5c+CS6zF1N
	8GopPXARB74nXxF46C8lk/OYKxz7jXQ+
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4560f854858mr44020545e9.25.1752473854995;
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQCJSWHskQAdK6/40s2GNLhe1adxKFpy3e1bkD6X5SdYIshLCkbO2SV3+P2shMcWDz9uD6pg==
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4560f854858mr44020205e9.25.1752473854492;
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm162665575e9.6.2025.07.13.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:17:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714021713-mutt-send-email-mst@kernel.org>
References: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <20250709233820.GA2212185@bhelgaas>
 <aG8BZcQZlbNsnrzt@kbusch-mbp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aG8BZcQZlbNsnrzt@kbusch-mbp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5fvl-j0PspnbMqDTauZ1bXFjs-BNVpssA8Uh1EZSAes_1752473855
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2025 at 05:55:17PM -0600, Keith Busch wrote:
> On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > This relies on somebody (typically pciehp, I guess) calling
> > pci_dev_set_disconnected() when a surprise remove happens.
> > 
> > Do you think it would be practical for the driver's .remove() method
> > to recognize that the device may stop responding at any point, even if
> > no hotplug driver is present to call pci_dev_set_disconnected()?
> > 
> > Waiting forever for an interrupt seems kind of vulnerable in general.
> > Maybe "artificially adding timeouts" is alluding to *not* waiting
> > forever for interrupts?  That doesn't seem artificial to me because
> > it's just a fact of life that devices can disappear at arbitrary
> > times.
> 
> I totally agree here. Every driver's .remove() should be able to
> guarantee forward progress some way. I put some work in blk-mq and nvme
> to ensure that happens for those devices at least.
> 
> That "forward progress" can come slow though, maybe minutes, so we do
> have opprotunisitic short cuts sprinkled about the driver. There are
> still gaps when waiting for interrupt driven IO that need the longer
> timeouts to trigger. It'd be cool if there was a mechansim to kick in
> quicker, but this is still an uncommon exceptional condition, right?

It's uncommon, yes.

-- 
MST

