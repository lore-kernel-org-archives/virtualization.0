Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EC2F2D
	for <virtualization@lists.linux.dev>; Sun, 21 Apr 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713668778; cv=none; b=YjBYpq87Y4lSQhjHUUbrWJsDEX/T86UEkWkC/MvFsDHB0mGxGJ3kkdrrM9aTQcqOLGHe2eDAYMVAjTswR8nN9vSX2eHbChiqRBip4bAw3OdJ6XooYA/3a/fI24WzepreP1TNfSkfFqbNU9SWqAcdYukokfJv1qhqw0sECP+4t1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713668778; c=relaxed/simple;
	bh=dG2jxD0m2zlXpqbBZqrDlEe0w3/A68n3Nqilq4yA1Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9Eq8YGfn6xFDYcTjCoZp+ryI8BlZmqu9pytoTN9153wDXXOxWo/xHTsQGfnZM7N9whTsMvwmowWNl9w2CtqhJ/1OFOcP1cutPNeDh5oW4IjPFBKknDaJ2gxKRHzDMRNtexFU2KVvEVEZTImwJeVuMeyUwsuY9zA68HPX46eCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLZ9t3xr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLZ9t3xr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so3298873b3a.2
        for <virtualization@lists.linux.dev>; Sat, 20 Apr 2024 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713668773; x=1714273573; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glNPfgGzKTb1W9Dy01P+rKaDaZjQlT5/vID4o6dvk0E=;
        b=nLZ9t3xrAs8Y/F+L5M4AIoUwRVsEs0c7swIRWI7f8v1vxhvL5cMkPQXetIt/JtZO03
         w9pwW8HXTsSTT24UWN77XQj+qc9bbC9q01+lEkFQ8btdRkJEg57vjX+nWz0R1jgdfAOB
         vDE6sSorzmJa/uSsYuq82nvqPiP7A/O23XZJMuwG4fVyxRW0o6Abj8rxNoHwRDVaf+oI
         SHDLO7vLCQO1yz4PxT+BNolmzrBDzbH9iJZ57Zt9QQ6arxAb1psZpbXSupAoJz/ZYtBK
         AA+uGMDVOjnHXN2UOvr+ORr6tCs4Nx2VpM8N2xnHGv8RO3sPrHUh3jVFsBQfr6oSzjAJ
         mvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713668773; x=1714273573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glNPfgGzKTb1W9Dy01P+rKaDaZjQlT5/vID4o6dvk0E=;
        b=cU1ca36J3YfRRSpC9Dk+F7oFGv5IB6hWCvLXzMUhXsnXBMipFC67sQuvbbTB02hUDD
         bKubMaEd+79A1BVtrp7PkTRjULZtzZsQAwMqoPHTx7kT2eEp2TMXbOiKHyM5J8FqNkYV
         JI8nVxcpX+OLVnjKMffJSEOuZ7YkVy/sGR+bbEhxCv4XaLmiJnzlZFGPI4J6bD6H0WNs
         6kzij37MsG+mTSfL2uLmCJmTHDd7xhx1VN/8rIgB0YQ9QNkGlYoDak6+43NHhgGSTWer
         Nh3gsO3T2+jnBTXzDg8E3JniB7yERaqv6Ebc0+0PFpBp7z6NxJbFgKfvTYgKeUVJRmjw
         ndXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBFk1IrBt2hsymcVK3g2IcbfdSV+i6slzE9QRFYAnD7hKHXNntB1UAApS0XA3ScNqfdkapLy1AW9zPcwTnjja5TWMtYR0c7BJ+zQ+cv9I=
X-Gm-Message-State: AOJu0Yz0kEMjROnmrKUI4CmsZ5rk79tZSYGohfdVmxCi+4Mq9n4GghC2
	Wohc4I2aL7xETJcEx0NYh6heiZ3prDHTru5dGIxOC42zIMWf9t/A
X-Google-Smtp-Source: AGHT+IEIMHDG6CBHSCkblxM+iZEy+BtAoE3Ui1rKcYDeCHMBuit3cK4kprSZ7cQxAkqRomJqeCCmGA==
X-Received: by 2002:a17:90b:30d5:b0:2a7:d619:8e14 with SMTP id hi21-20020a17090b30d500b002a7d6198e14mr5251645pjb.5.1713668772846;
        Sat, 20 Apr 2024 20:06:12 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090ac88e00b002abb4500e97sm5340655pjt.41.2024.04.20.20.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 20:06:11 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH virt] virt: fix uninit-value in vhost_vsock_dev_open
Date: Sun, 21 Apr 2024 12:06:06 +0900
Message-Id: <20240421030606.80385-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420060450-mutt-send-email-mst@kernel.org>
References: <20240420060450-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

static bool vhost_transport_seqpacket_allow(u32 remote_cid)
{
....
	vsock = vhost_vsock_get(remote_cid);

	if (vsock)
		seqpacket_allow = vsock->seqpacket_allow;
....
}

I think this is due to reading a previously created uninitialized 
vsock->seqpacket_allow inside vhost_transport_seqpacket_allow(), 
which is executed by the function pointer present in the if statement.

Thanks
