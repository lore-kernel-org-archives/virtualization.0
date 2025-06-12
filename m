Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2720C031
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708819; cv=none; b=qeDemyAvpRexBm6trQMEKl35hB7ydXUDEUQZJMgqswE/BCZNGmC530x1unDIYQRTAUO7yUBvevRVex8MmwMIImgS9Yw1KI0dSbhFhIJnmfbiTZ5CsYNvqVC6IL8KknEgofnuCPDN8ztp9H0XYUMe2bijNr+uif4pLQT6vxhBNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708819; c=relaxed/simple;
	bh=howSff6VWPDUG/8EwAo2gdsK+umwDc6lyF7pREy9114=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEBR2KMwn9rnkWMXYyV0TDq/Pi17ZDj9cjnmIFPIIu2TnO9tCYT50SbFYR2EA7Ozz/Z/QnfEgL7JxlKYqi8VCwN8tgFVn2K6klMS/hqcjnUKWv/LjuZB9Pt8bu2fAlvjEB5O3e2r2Zt/GrTUOYwqmwyLD0Ekr0gfadrFPu9BemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zu+7U/l/; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu+7U/l/"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBF46406D1
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wa5BTt3ejqI7 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jun 2025 06:13:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 845E6406C6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 845E6406C6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zu+7U/l/
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 845E6406C6
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749708815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/EyBBdquzcHxre0zmx4LK4Tl/qvbbDBPGbd2Tyb9e0=;
	b=Zu+7U/l/olKLEYMa9Zm2Acxq0YJG9hBvUQ9mi1Ia0nkTY5bbwH/d9rGIomG0CTxbwFWBK+
	F9w6T9KY1+usrfp/20ufavME0BctKZCoNFt0g9chYVribqBj2010JXDdCr4Fny6mwgTTIq
	St4lha5WMgVnmlFZNa8tB5XLkrS4G94=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-E6grR8iZNR6vohWcq-r4QQ-1; Thu, 12 Jun 2025 02:13:34 -0400
X-MC-Unique: E6grR8iZNR6vohWcq-r4QQ-1
X-Mimecast-MFC-AGG-ID: E6grR8iZNR6vohWcq-r4QQ_1749708813
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so603250a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 23:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708813; x=1750313613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/EyBBdquzcHxre0zmx4LK4Tl/qvbbDBPGbd2Tyb9e0=;
        b=j0LHYZophNGP5+5D1M9OkJwx5tea+u6EX700ur5ZG5UoRwZEGSgV38HTqJ/IABGSDB
         vmsAAOHUQI1MTsvoXWoiwue+vi5VTN7LyTvH9Q7gveASDb4cOVe7UoRdyiVW7MWOBBDu
         ulXSVP8zlr5pelrQXk/H8UnWeEeJBmgZ1zibsF4KBSZ1+CgyC2A6kuzvRg++gPhJk1My
         3xoBGqxS8XWgYuR7JFIVjQRP8CTvUVMJLCzGxL7QV2I2mJt7EFiRSGSaRsSPtCU9Xfne
         q6BjL0ypInRIJX2RUSyJYRpn1mEphy3NOC+iv/e/lZpeSAhlIfxhiB5aXh7yt4jbgANU
         lrxw==
X-Forwarded-Encrypted: i=1; AJvYcCUPmYA/3/vaFUqHL4SXzYR7tj10rexxkiqS1rA73IZOxYRpf1r96dH4mTiT1VCPzzBPw89k4HjCxHEIgJTAWQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzdnbVXyqVaM8tV7LF9kt7/LpxBx116Pr2dqmAvCEmk+8rh7BbN
	ROMOzOEJ7RooOuyBTmgHSpACPakgAiaNvuuWrg/2VmT17NFTZWaPJ3qD+qDW3+nytbzYNEDI4Hi
	eU38UGT1whq1eI/goozOrH1zgoUC9iwdZ0uDnZ2cLXd0ZiD7iFBHVaWvauO2obQz1kKJ6FEchdY
	xvKdIjdIqdwFao5VePI9Nusa7ZkphqI6GDbc0d3AOagl0+P2iwlqs1j3ZNUw==
X-Gm-Gg: ASbGnctCXLD5EszB9G8ps6LvWvMRaLcoiviFSV3DXJVOUKG62sjLHtr2uuMlk/MqkHX
	yRX4HvLWvCIvvXbU7HvwTgfPkg5UgMbPuSKmziwUPVtvgovaFOqlX4519Az5jdK0mqyJLZEoLa4
	rQ+DV2
X-Received: by 2002:a17:90b:4a85:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-313af0f8588mr8593835a91.4.1749708813292;
        Wed, 11 Jun 2025 23:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRSfn+DFX99Kt8GYBgrMAVtWhiGSmX+yj9Fd1EztN/3C7R1B2uqWnhW/ZwV2Dfc16GV/gaDsxvGQ2v4NwVoR4=
X-Received: by 2002:a17:90b:4a85:b0:311:f30b:c18 with SMTP id
 98e67ed59e1d1-313af0f8588mr8593813a91.4.1749708812881; Wed, 11 Jun 2025
 23:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250609073430.442159-4-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 14:13:19 +0800
X-Gm-Features: AX0GCFtAQ6KdmUMQlRn5ycdH_MpDkwuSBIM378dLZRqlkkpE6VbNRTu4Uei-gEI
Message-ID: <CACGkMEtB_8PRt1Ag0mXV7ycTv1KG_c2PT283hnYukRJrG6h2YQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] vhost: Add configuration controls for vhost
 worker's mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qH8qH9ZBCAmVvfF76-vDPF7MlZwBIv-odxcbyvplQWU_1749708813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch introduces functionality to control the vhost worker mode:
>
> - Add two new IOCTLs:
>   * VHOST_SET_FORK_FROM_OWNER: Allows userspace to select between
>     task mode (fork_owner=3D1) and kthread mode (fork_owner=3D0)
>   * VHOST_GET_FORK_FROM_OWNER: Retrieves the current thread mode
>     setting
>
> - Expose module parameter 'fork_from_owner_default' to allow system
>   administrators to configure the default mode for vhost workers
>
> - Add KConfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL to
>   control the availability of these IOCTLs and parameter, allowing
>   distributions to disable them if not needed
>
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

