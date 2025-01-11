Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A4154C12
	for <virtualization@lists.linux.dev>; Sat, 11 Jan 2025 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736574356; cv=none; b=ERAyoMs6ydsv1vDy4yOs1rqp730N+m3MaZCTXKZjE+KKR+hHiQ385ZBpFGbktOIjyVacVqY1EH0WVTvaRH46RYI4Che8qMKwJYRh71aqTFkrhhbUgx7GyHtnReeQQQGmQt8ORIK/bKglJSzdTt+LjioSPc2Hhs4wt3iVVz3cQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736574356; c=relaxed/simple;
	bh=w5UDPf02yjMUtRPxrqVltZiw7m+4/f0Z1d01B0JvqJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyKhmGJAmA84JSkF+CncNBUqkGTBpjjUvit32a52RU5lj5bvpgC4HbIt2iiJoFJXHYdW96v/mnPlb7a/V8aE7V+5CTONnkyTD4kgTLLDNMWx+lBN/7ygSuMpunJn5z/Ehqbyzr7rnIKBrUZV2bl+Ve4dWO5qYqaTFIy65iI+zI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/IAGKba; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/IAGKba"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f441791e40so3697964a91.3
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 21:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736574355; x=1737179155; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1Z3EPmQB5lAsqR6w+HJRVOlWNoYOrb5PkJHCsiLoH0=;
        b=G/IAGKbaxj3sRX94KQ5NURTm2hXmfb3VrtYLZ3tpdaKHeQv4n3nPmxwmiR2n6pv7sK
         9K+1qmVTpHZ4aQuWL4Pl6Fsi/WHhXGm4hedmR/huTCxI97o/1uAu/mPT6rCYRksWTasy
         X72lZtjEpmIcjYXPDPH75jcaRmnIT9QCWGr9btwkjDocniaFeLsIL1LTM8yKY4vwI5fo
         wkyR0GfJRXNPRMtqG+Y0LJkNA641y7uBofK+5wjMnTYbbG4otIkXGpU9vBjJi9L0GwcC
         hSqmjpUsiA2NOrxxDpL6T/Fvf2IbwPhSgMA/u1XxJDnOvD80yp1OtIX/CcyOpk950a95
         lkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574355; x=1737179155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Z3EPmQB5lAsqR6w+HJRVOlWNoYOrb5PkJHCsiLoH0=;
        b=WqAL7elNQFUjsuIeHP485Z4TLSkC/lEmXUpeoLhP9W6IanUEJb+I+f++WxTyxjoXvm
         T92KloI0PHEENRlOvjnK3i10ozefdc2UtOarWBGm7Hf5ePbxap2kXP2L3BphLQSiKk7r
         6IvO/TgLrCc26pcXR43Oegymmpz2AKuBTOSvU7y1S0A1lSlmqOJ4fReBs8+Wg1p8XFRp
         HvWTnfES4m+hXLJHTZnZINLlGWbucdXRjtBwnaBGzXaZwFcpyWeVpD4fKUM2KRM/n/Li
         Z9JBYNtAY2i/kEkX7f1fBzVKqtqfoyuO8HNZ+0CUSjYXmMEDUsJ92WHCrB4+EIKlyF76
         AqJg==
X-Forwarded-Encrypted: i=1; AJvYcCV53ukk4t6vdlk853ln2ytaFYjYYYkRo1l4k7DByA2qpflvDhxdn9jWit94RH/qsOJ825sI/RNix7mf/q46ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF8ov4v8mAFI1NkzhI/YCXlrrGjHROJz11BEuTqLObe0kbVbx/
	TCIOUN4mSptNQk9GVRjhF06ODMadfjwfkXBz7Q9qz2YsIyzfwhYA
X-Gm-Gg: ASbGncvKFFixE61sGcQXPiakoIQVTYIrTrcXDnZ8V6C7FWF3fz//em0zrO9vWA+Ni5h
	SBBcsOxPBd0Vb2n/4YOvnmCEMTyhjM6Oj1AXO7CgJKHEXuU/wbljx+sgTJ9IsDKZC+aRJrAMYt3
	1mUo3dPJc71IYZtD6+U5e1zXI3d2W45NG3MBIBvJ277d74tu8B9k6AQloXouHjq3fcVHtXuS9LD
	MLSh8VTAHE3FEjZJRUvvlIEc3Wz/NJSf0lghiF99C2I2LgilbYcTDQtuYBdRUhHH/L/LFj2iTVK
	4Kf3j84+
X-Google-Smtp-Source: AGHT+IHoyaim4PFSUoWf+l1fZq8aXgC6U/STMs5zRin/hXJAzkXTfotBKoZoyfn6mdvVHEXHOl6Ogg==
X-Received: by 2002:a17:90b:4d10:b0:2ee:cd83:8fe7 with SMTP id 98e67ed59e1d1-2f5490edb9emr19348033a91.35.1736574354440;
        Fri, 10 Jan 2025 21:45:54 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21ada1sm21233845ad.138.2025.01.10.21.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 21:45:53 -0800 (PST)
Date: Sat, 11 Jan 2025 13:45:50 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Haoran Zhang <wh1sper@zju.edu.cn>
Cc: mst@redhat.com, jasowang@redhat.com, michael.christie@oracle.com,
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/scsi: Fix improper cleanup in
 vhost_scsi_set_endpoint()
Message-ID: <Z4IFjgpYEn3NuMZM@visitorckw-System-Product-Name>
References: <20250111033454.26596-1-wh1sper@zju.edu.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111033454.26596-1-wh1sper@zju.edu.cn>

Hi Haoran,

On Sat, Jan 11, 2025 at 11:34:18AM +0800, Haoran Zhang wrote:
> Since commit 3f8ca2e115e55 ("vhost scsi: alloc cmds per vq instead of session"), a bug can be triggered when the host sends a duplicate VHOST_SCSI_SET_ENDPOINT ioctl command.
> 
> In vhost_scsi_set_endpoint(), if the new `vhost_wwpn` matches the old tpg's tport_name but the tpg is still held by current vhost_scsi(i.e. it is busy), the active `tpg` will be unreferenced. Subsequently, if the owner releases vhost_scsi, the assertion `BUG_ON(sd->s_dependent_count < 1)` will be triggerred, terminating the  target_undepend_item() procedure and leaving `configfs_dirent_lock` locked. If user enters configfs afterward, the CPU will become locked up.
> This issue occurs because vhost_scsi_set_endpoint() allocates a new `vs_tpg` to hold the tpg array and copies all the old tpg entries into it before proceeding. When the new target is busy, the controw flow falls back to the `undepend` label, cause ing all the target `tpg` entries to be unreferenced, including the old one, which is still in use.
> 
> The backtrace is:
> 
> [   60.085044] kernel BUG at fs/configfs/dir.c:1179!
> [   60.087729] RIP: 0010:configfs_undepend_item+0x76/0x80
> [   60.094735] Call Trace:
> [   60.094926]  <TASK>
> [   60.098232]  target_undepend_item+0x1a/0x30
> [   60.098745]  vhost_scsi_clear_endpoint+0x363/0x3e0
> [   60.099342]  vhost_scsi_release+0xea/0x1a0
> [   60.099860]  ? __pfx_vhost_scsi_release+0x10/0x10
> [   60.100459]  ? __pfx_locks_remove_file+0x10/0x10
> [   60.101025]  ? __pfx_task_work_add+0x10/0x10
> [   60.101565]  ? evm_file_release+0xc8/0xe0
> [   60.102074]  ? __pfx_vhost_scsi_release+0x10/0x10
> [   60.102661]  __fput+0x222/0x5a0
> [   60.102925]  ____fput+0x1e/0x30
> [   60.103187]  task_work_run+0x133/0x1c0
> [   60.103479]  ? __pfx_task_work_run+0x10/0x10
> [   60.103813]  ? pick_next_task_fair+0xe1/0x6f0
> [   60.104179]  syscall_exit_to_user_mode+0x235/0x240
> [   60.104542]  do_syscall_64+0x8a/0x170
> [   60.113301]  </TASK>
> [   60.113931] ---[ end trace 0000000000000000 ]---
> [   60.121517] note: poc[2363] exited with preempt_count 1
> 
> To fix this issue, the controw flow should be redirected to the `free_vs_tpg` label to ensure proper cleanup.
> 
> Fixes: 3f8ca2e115e55 ("vhost scsi: alloc cmds per vq instead of session")
> Signed-off-by: Haoran Zhang <wh1sper@zju.edu.cn>

checkpatch.pl generated the following errors and warnings:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#59:
Since commit 3f8ca2e115e55 ("vhost scsi: alloc cmds per vq instead of session"), a bug can be triggered when the host sends a duplicate VHOST_SCSI_SET_ENDPOINT ioctl command.

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from control queue handler")'
#59:
Since commit 3f8ca2e115e55 ("vhost scsi: alloc cmds per vq instead of session"), a bug can be triggered when the host sends a duplicate VHOST_SCSI_SET_ENDPOINT ioctl command.

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from control queue handler")'
#91:
Fixes: 3f8ca2e115e55 ("vhost scsi: alloc cmds per vq instead of session")

total: 1 errors, 2 warnings, 15 lines checked


Regards,
Kuan-Wei
