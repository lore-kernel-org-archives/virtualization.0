Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB91361B9
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159009; cv=none; b=psnxoBXqLDtOuupx2OdABcBAEfUDX45lBcY2DqIu1ALUV4Plwv0JfJ3TFP2p/1zsamN6ihfK7QNt/NryuelZ83J+8aBtiILuz9/Xrltb9bL6UE5go6yLWzZVnkd6wDDYAfiy7wwdVRTW2DNF3CVC7UeBTFh1Lw+NSPiPUmk5TS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159009; c=relaxed/simple;
	bh=efAARcR7gFpwaoDBRFOeE7SvyonXSekFYYuK9/IJfAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSat+/jej1nMq9loSpphDKeKggXE0ZcE6dgFDxJ9hzbfuPjPnDAB8k1T95GvO04tV7YzXOX+1kpRdAwMJZLrlZ3hKqKdA5QZBMA+OP+gCuanky8k5X8pqE0Sc8BgFBTNssURewX+s9lbMXIpruSCIpH1FL/ivHuwdwUk6RIm/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2ENvbEv; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ENvbEv"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a0919f2022so119208eaf.1
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709159007; x=1709763807; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqwfgf5Oxmdk/q9s8w3xjmRByoPtFa5KtuN8A69uJIE=;
        b=i2ENvbEvME3ifzxEFPWeTUclxQiwp1ISGs1YFbc42dAV56UoXf0VWyERZ9NRcajuv1
         nRvhTB+2QtRlTWZkeuXnrw/qrJp/u8d1C5XRobSuV8DyFarsSIuWPt+2PiG3iY0gcCcS
         fZh0MeHvU0dVTrPMeOr6F59LxX93zxWX1mcZz76g3Ce0AppZ4N3DgdHNzwLNxl/Ttyto
         Nu8qYheWTxRpb1k3ZrmM1bpWNS8mkbs0hKz75MwGZC/0QM0isyg4ZzQaeObcXwXz+jvl
         /oPNV0VgYy7anuLMfPWe09uAlA9Dlp8PhQOfjnE18Ft4TkGKXoxyGrtvb/+9wp+SiGB1
         BomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159007; x=1709763807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hqwfgf5Oxmdk/q9s8w3xjmRByoPtFa5KtuN8A69uJIE=;
        b=ryn3dQPgD5DXJAdCimBZDgC2wzhA8OIOebnWyjjTiYQINxbjF+j+69q8+YkKhlmkvL
         m19UXUW6l6nXymvJhJbE37IyPIRomHJojQAn0tVajUXnszkX5MeLWC9OBDIgeYhvruO3
         tESWn1UHfdPN1MVwaW7wEYTxMvUKk01DmEQKhxC9u5iTI19tbBVfKM7DIdlUMfsSE1Rv
         0khIjNVRhv+lPE3M9Z6Gm5yOYiCNKJTvtmHIchETE2TDV5m7mhKc26WuaJBSeD/2f6dr
         WgtC+8FHg37ZthJX2AjEiywQ1WFYuRXcJmoyAPo3ldgViCD7mTIbwWwcrZR8nAfGr4Bb
         MMEg==
X-Forwarded-Encrypted: i=1; AJvYcCWBvjpFLrupiLZ2lJxt8bz454BuZk8Hm1YvORhQTIUdv9YBzffAurjYl6ep6AIbAk/BTjkZtBecWK4HPaPtRwjUpNV8QdxxIzC1Ynp+WWs=
X-Gm-Message-State: AOJu0Yx5htoKF0gA4jFt/LsOImP+BKe1r/kzr3xW3vp6uuj8GOQo1kku
	MDldJN23VSGaWVuQ47qnXF7gGbixJBRU4eX4+bL/DvkezZgbrQEIJZmscrCoPUKWIWxO2ITS1jy
	uiSGOTBak8LU4N+iJunjbw5gOCi4=
X-Google-Smtp-Source: AGHT+IEgO7bdA+0K92kgCyeW17cOUPxkEoTj0hyMJup6CuZLnUAJDI0zyamr20pz3eFYcj2nq3v1fbrN42DMo7oQ3Ss=
X-Received: by 2002:a4a:3c02:0:b0:5a0:993a:3839 with SMTP id
 d2-20020a4a3c02000000b005a0993a3839mr388209ooa.8.1709159006619; Wed, 28 Feb
 2024 14:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240228214708.611460-1-arnd@kernel.org>
In-Reply-To: <20240228214708.611460-1-arnd@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Feb 2024 17:23:13 -0500
Message-ID: <CAJSP0QX6wowdwuSCz+a-2mBsp5KDUjSZeFJL82JuqsC0z6vhfg@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: don't mark virtio_fs_sysfs_exit as __exit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Williams <dan.j.williams@intel.com>, Jane Chu <jane.chu@oracle.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 16:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Calling an __exit function from an __init function is not allowed
> and will result in undefined behavior when the code is built-in:
>
> WARNING: modpost: vmlinux: section mismatch in reference: virtio_fs_init+0x50 (section: .init.text) -> virtio_fs_sysfs_exit (section: .exit.text)
>
> Remove the incorrect annotation.
>
> Fixes: a8f62f50b4e4 ("virtiofs: export filesystem tags through sysfs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, Arnd. Please see the duplicate patch that Miklos applied:
https://lore.kernel.org/linux-fsdevel/CAJfpegsjcZ-dnZYft3B5GBGCntmDR6R1n8PM5YCLmW9FJy1DEw@mail.gmail.com/T/#t

Stefan

>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 3a7dd48b534f..36d87dd3cb48 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1595,7 +1595,7 @@ static int __init virtio_fs_sysfs_init(void)
>         return 0;
>  }
>
> -static void __exit virtio_fs_sysfs_exit(void)
> +static void virtio_fs_sysfs_exit(void)
>  {
>         kset_unregister(virtio_fs_kset);
>         virtio_fs_kset = NULL;
> --
> 2.39.2
>
>
