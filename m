Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E237D1E
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XtWM25UL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F5B360E43
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 18:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F5B360E43
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XtWM25UL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWaGPLL31FJO
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 18:20:44 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03F6860BEC
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 18:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03F6860BEC
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-dbccfd048d4so3544945276.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 10:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703010043; x=1703614843; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgph0xx62tfEVrK2mU0HsXwH2WGhvP+EnxtPD5Kw9NY=;
        b=XtWM25ULaNW3FgKAwRT9rzlGYzOXN3k2Vpv3V6ftKKtXv/L5KPuDqpGsBAber3tm96
         Ff27vgl4OE3gfwGOKoFuzNg7pHyIX+7lLR/VPFDjz6RGqMO60qMUZLySc8cwJZkXdUNH
         cP7GZGwRWYtr48zzz+yItepwk5mAifI3JuTnj6MPl0Mgpu8pjkxcN8/El5gMvfdYh9F5
         bANeMCe8aVZEv7mk6BCP1p9kNVLvgaU2fgFeihusL4lkBAec2Qm95+l8uMETyRNjfIq7
         bOIHYHLrnuVv5lJYT9ahKIbi1JdxhXCaFNkHHuoVX1qbToLJeS/qfxmF6dHkMF8VVouz
         m9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010043; x=1703614843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgph0xx62tfEVrK2mU0HsXwH2WGhvP+EnxtPD5Kw9NY=;
        b=IjuGh8FuWMYw6oKQlV8KpmbEejpbuSooCXCl4uGkOMTeiv/7qf4P+JhwPtJZ6RTtNx
         knh9tEUlpDjKp8T6dfcqSQJCBuUHqOUC1nvNQXKT4CfRGVhXKeKATRfU8pB9/p79TbfV
         otALNjc/dWvEoek/j9Mr0NT446ORQjCLqN31MY6ATyy+mdBQgKkZdVA/KDtcQh9cKLme
         5Gs554+L64n6nWdEJVmErukc7KPtXBCRRWYUodTZVt50Aay/ZYSZnXTNP/XAc906ijtn
         3TOOjobm7e/ISr9eB1AxjD5QQrWQpfhUixdzZA+PEmSLlQK9twWkwFFYSlmqeMk2WUZ9
         qW6Q==
X-Gm-Message-State: AOJu0YyXCJC4pXoFk15sLqLVOkzHpR6NQPR7lQlxH+IXbOkxfnDbRMd8
	45iOudcepy+ab6IpdijVGlxj1NGN2vPyd5Op6NmM
X-Google-Smtp-Source: AGHT+IG2ONgtcoT47Z9l781a7bW2xcjjJeRGvkYkQbojW55k5C8WrZ/0wZW5Ybv1u01qKlii34AZLXUE8IlWaWZfrbo=
X-Received: by 2002:a25:ac01:0:b0:dbc:efce:f34c with SMTP id
 w1-20020a25ac01000000b00dbcefcef34cmr4115248ybi.0.1703010042731; Tue, 19 Dec
 2023 10:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-5-maxime.coquelin@redhat.com> <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Dec 2023 13:20:31 -0500
Message-ID: <CAHC9VhSkGwzWV8T06LdoGXyvrnP7tiYMPYmbmVxWoQg6wzEDiQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> > This patch introduces a LSM hook for devices creation,
> > destruction (ioctl()) and opening (open()) operations,
> > checking the application is allowed to perform these
> > operations for the Virtio device type.
>
> Can you explain why the existing LSM hooks and SELinux implementation
> are not sufficient? We already control the ability to open device
> nodes via selinux_inode_permission() and selinux_file_open(), and can
> support fine-grained per-cmd ioctl checking via selinux_file_ioctl().
> And it should already be possible to label these nodes distinctly
> through existing mechanisms (file_contexts if udev-created/labeled,
> genfs_contexts if kernel-created). What exactly can't you do today
> that this hook enables?

I asked something similar back in the v4 patchset to see if there was
some special labeling concerns that required the use of a dedicated
hook and from what I can see there are none.

> Other items to consider:
> - If vduse devices are created using anonymous inodes, then SELinux
> grew a general facility for labeling and controlling the creation of
> those via selinux_inode_init_security_anon().

For the vduse folks, the associated LSM API function is
security_inode_init_security_anon(); please don't call into SELinux
directly.

> - You can encode information about the device into its SELinux type
> that then allows you to distinguish things like net vs block based on
> the device's SELinux security context rather than encoding that in the
> permission bits.
> - If you truly need new LSM hooks (which you need to prove first),
> then you should pass some usable information about the object in
> question to allow SELinux to find a security context for it. Like an
> inode associated with the device, for example.

I agree with Stephen and I still remain skeptical that these hooks are
needed.  Until I see a compelling case as to why the existing LSM
hooks are not sufficient I can't ACK these hooks.

--=20
paul-moore.com
