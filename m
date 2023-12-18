Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C51498B7
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqjlJnsm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1660F60F11
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:33:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1660F60F11
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nqjlJnsm
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lrl06s3mK9Sc
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 17:33:45 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D1C760F12
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:33:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D1C760F12
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6d728c75240so1301401b3a.1
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920825; x=1703525625; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrrdb72hryOiQh+u7nxbNRimC+6/pwn0HNgKp0aqgVU=;
        b=nqjlJnsm3vhwJrgatB+D4hu3yuK9vdDraZrUQUPTTkh+W/ecJk6vKTE1stUrs/MZqk
         QaPTygLHywWZviRCOdmAHucslRnE1VRQt+QdUo5IfZKWR5pSCyalvz+h8lMDiIY2Tvuo
         8hLeWIuBYbLQndH/2CR016nlZx8zAtp2B4gwfrLELDk+QfcqOIckRYrQTRwpgdn0aJV6
         dRx0GrFPMYh9BAKoWP+MXFwjmR+3Bu030HkX4QlwKQtzCP7umTUupsIJhBrzeKd/7PQd
         Ep4tW5ZDtfiSphHDi5tOF0LOPThXtd1ygEeO3cZB30SjQcrMTon6j1vKJe0ZQlaBaYyq
         LOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920825; x=1703525625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrrdb72hryOiQh+u7nxbNRimC+6/pwn0HNgKp0aqgVU=;
        b=diVoqLG+7gMEni9MQI9BXzB6LnqgoV9dJWNhrdIrWl0g7CNT9y7l9L2c8sok+q4eCL
         bCCwVM+fszNSdoi2Ib8mMnFJHZ/RwAspAyYieGPlFvMqTebJFA4musROnYL01Hush49i
         hqJ5aobC9epGM6NdyBYmBOJlerFC/BUtSnbECHUGkuZS/4am94G3xx4fWOPQsZ1xnAd+
         4t/dXiAJ7wv+AIndRaZXYnGd5JFW6GdWxNLgkYTt9kEfWKEHvogX0LntFCvC8fAvC9q8
         7b9NIswWQ8BHGaCbBc54PKbxKcnpHyK9wBoVJToHxKO3IxjbOx4F0KHOgcNQsDxHmejM
         Ygrg==
X-Gm-Message-State: AOJu0YwTO7ga680Ud/uJPunvhZ4A10i0LXRL8DVQ86kw5ybfvrvPLa8D
	etroNLwAvZM+sC0AI3ZL4Yk5tDzPueUdW4mYea0=
X-Google-Smtp-Source: AGHT+IEl/3podabf9JW3rwvs37X8Z3eFup1Qa1APK02q/QJjpYM5BqxkB+oCv9Hiphu4seWH9LCso07CPCn6vw8c/J4=
X-Received: by 2002:a05:6a00:c81:b0:6cb:a2f4:8579 with SMTP id
 a1-20020a056a000c8100b006cba2f48579mr19678291pfv.15.1702920824664; Mon, 18
 Dec 2023 09:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-5-maxime.coquelin@redhat.com> <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 12:33:33 -0500
Message-ID: <CAEjxPJ77cdHUvxWqLzmYwjLqFiSJH4kwByx7vAvR7dLfqcLy0g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> >
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

(added Ondrej to the distribution; IMHO we should swap him into
MAINTAINERS in place of Eric Paris since Eric has long-since moved on
from SELinux and Ondrej serves in that capacity these days)

Other items to consider:
- If vduse devices are created using anonymous inodes, then SELinux
grew a general facility for labeling and controlling the creation of
those via selinux_inode_init_security_anon().
- You can encode information about the device into its SELinux type
that then allows you to distinguish things like net vs block based on
the device's SELinux security context rather than encoding that in the
permission bits.
- If you truly need new LSM hooks (which you need to prove first),
then you should pass some usable information about the object in
question to allow SELinux to find a security context for it. Like an
inode associated with the device, for example.
