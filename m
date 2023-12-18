Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE55BF88
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMtEK1qv"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49FC5408E6
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:21:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49FC5408E6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XMtEK1qv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hg-jy_gRvg_5
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 17:21:30 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BAE9440876
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:21:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAE9440876
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28b4563a03aso927174a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 09:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920090; x=1703524890; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ+d8lXK8t7tOQUPKwNZqHs+rv31L7RvHxCGty4EDjQ=;
        b=XMtEK1qvJUganBHqJ0DzDLRmS4sSxSfedvbYKwVN79ybUG1cC7qk2pgYqSuSSaSgg9
         caq5OFAHOwPBYkmIbCINfmhn97mQ4CqMoD8v7+A/7Z2vlkPUitnwxZID15FJzGBMymLk
         RfsCOd2cwRASemL6J2GsQsU9OmPniJTLdL8UfDCrJjDiv5Hnrp0+tV++lNFzve8AD/Pb
         NPOb1paUjccSWrUqvpoTumVxYgOyAFjn5InibqolKoU7qZ3DeMTu2PU3WffqlMPSXEKP
         /zq1L7mDLdMiRgtpKxWwiHhfgMZMDDxjyqziC+aBErDyajug0ctZlY92aL3OzEwGUr5L
         uGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920090; x=1703524890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ+d8lXK8t7tOQUPKwNZqHs+rv31L7RvHxCGty4EDjQ=;
        b=cHbDOL5BBVXoQuXpQqP6I/x5raYYv3S097Uc7xrqy82Dfol9rCQjTqTRbJjH4oNcUQ
         acSgjKKhAgBaR7mQrliI+Fxm5lm33+ikPzLSf6vEVn0e3SXeiwJgB+BsbbVVfNxrEeAK
         CAEVawwjBDKIqZoUeEXbIiMX5PUuBxlfWRO8s2urOmLOZorK9kXt9+51rEJddYD2y/fu
         3BdH6pC1nyOu4OujJWJdK6EtB3JTSCNoRBenbkw/vLK/M2kTjLLtQOtnHClw/RIjqaAk
         SsmhmjIIKaZmHw04wKLahDfCcasbQpuwDNCAY+eD87qLQObHmUEQuU1xbW7rm+yIN32P
         Gr3w==
X-Gm-Message-State: AOJu0Yw9TFfvRqR/w6BhjCIOSQZPDsFRmvJ3BKmBoqto44EuRUYM027I
	1NCYq4/6NtDN57Um3fL0qJXDgZtJ2t6ro/n43ec=
X-Google-Smtp-Source: AGHT+IGJW2/B2t4Qp6LNhtCnwLtLP+FY/akR5Dr+slxmOtIJLVsP964rNYKe6kurtd9STJLyyUO3NKHkMR6dwVBC5Jw=
X-Received: by 2002:a17:90b:1495:b0:28b:4d97:e53c with SMTP id
 js21-20020a17090b149500b0028b4d97e53cmr978070pjb.99.1702920089836; Mon, 18
 Dec 2023 09:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com> <20231212131712.1816324-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231212131712.1816324-5-maxime.coquelin@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 12:21:18 -0500
Message-ID: <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch introduces a LSM hook for devices creation,
> destruction (ioctl()) and opening (open()) operations,
> checking the application is allowed to perform these
> operations for the Virtio device type.

Can you explain why the existing LSM hooks and SELinux implementation
are not sufficient? We already control the ability to open device
nodes via selinux_inode_permission() and selinux_file_open(), and can
support fine-grained per-cmd ioctl checking via selinux_file_ioctl().
And it should already be possible to label these nodes distinctly
through existing mechanisms (file_contexts if udev-created/labeled,
genfs_contexts if kernel-created). What exactly can't you do today
that this hook enables?
