Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394A192D71
	for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707433; cv=none; b=Mu/Iuqq/fGGePfSO7eV/AaLavDg2KscKPLI6Y33vOQgpmkrCLstntWCeJ9gJCCAwHwxIwF4ku3SlbLebiALnlk1Gh3cptJz3CwNchgoO3sAFP96cN11Y71b2nbYnbMRWb6T6G5D2zYnH0UmTgbB0QWIcgjeKivlmvD1e3eAnM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707433; c=relaxed/simple;
	bh=uposKn/p+RXVVaJ13hyjFB5pwStx2I7diBnj3Ss0lRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/q+p3vOwFrvw+pTN1/vyqHjxB5QLvmvsZ3fhsX3Es4Puu5t/gXsXTbkpdItMeRAYCKtHVszOVye41SZ8vK+iRvL7Emll4JRrxBZIx/s/AiEUsyq/tgbmngdH9mHmaaOruZPV4A4FKZM0V8nGT08M2xnG61XxHht8QkUU9WOugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=L7tcFppN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L7tcFppN"
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2FFBC3F690
	for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727707429;
	bh=W/CpSjXnAbCC5PhjkBvCzNNH6T78kZp9wxS/oiXqX4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=L7tcFppNyMGb1j3S1gxkMlU+uLkxgg0kHYzstnZwvnHEZl3E8c3r7Axqdp7QCY9qJ
	 RQjA3ntRuJVKi2yeEojzHd27ztKWM27il+Vx7aUFTW8wBa1CMhx01QrfKqpQnJ9O8V
	 etwrZP9gvP6Cc+Kl5cmdCTdtEH09AehYowDERfdkOMKMMV6ZR9EW6qIhNNmpVPfJrB
	 hfa+BbNy1YIrZZ9xW4BBJy9MnUCblUeKpoDWwysSwhHRMRn7gbveGzDrKEmy1m6e0y
	 lrXlblk/Ww8G84S72rddT3JeJfIcHjosekEK+HEfewJTBdxEsbpj0oz3fV5NoA1jRf
	 PmB8uRYCLfowA==
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-84eed724693so190947241.2
        for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 07:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707428; x=1728312228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/CpSjXnAbCC5PhjkBvCzNNH6T78kZp9wxS/oiXqX4o=;
        b=oOwWty3q/8Cn/0M7QLSvX/L8C2N4UpSUmkar7fXbCYsOrGtju7gxCDLI3S51cHdjci
         xviUWj8yxzzV96L9iF3dGxAcAwvMS3e08DzKqD1o2tU7utdIehUtUpMXyLOjEuove8X8
         7YhPGD2f1ke2UDw26+Kic2A3kGF3gtGudM1VyULhUbqHygS+wV2NloJKDdWHaGutP2iY
         ivbKuyj+Oo7EgOq+J/Bid6knGYYFXFtfDZ2kZW8dKm6exkkBWTwm0x2KShphDerTnDkF
         mXEgf1sqxKifMiTii0m50Sa9EuoJmEL94MHCHNmjJCxv7+pGtlwh8VycBGBaXhxPaPmv
         VGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN41bxaN5aoPZebokT0tZiAyVm1uiSkzn4ldJA0GVRW8jAXIqVptaZ7d6f1+nvzrazVATBSa8mT4fKjKne8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDe5zUxAIlnk4NflWX0icjQ3l9+1GRXslRxzpyo+rgfKwOz+Z7
	KB20liZRPp2X4P18zWf0IQWnK921RlNLd/Kek/rPefdQFYTxs55ZXlNlgZaYL0cQN8gy5/ALAsC
	vl8GQvpRt43OdL+3qzogU8YlFmz1TEJmNOwsZOtEAqZN5ifAKV41DL2E2hRg2kuA8yyNdeUd0PU
	3o+GDW2nlHJCUrUPbvjAYipm3FfqC+nyun3+8KtLJ5L6eJrGOk402riEa3D/WK4VZwNA==
X-Received: by 2002:a05:6102:2ac3:b0:4a3:cb2b:973f with SMTP id ada2fe7eead31-4a3cb2b99famr2323752137.28.1727707427966;
        Mon, 30 Sep 2024 07:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT2J/m0NVC75kbEvfn4OfZt54LSw4OCiDc5FsVbH2mUHDoOJEzl4v18NtheL7cofpCqo9z3D4+bYZ//SP/5ks=
X-Received: by 2002:a05:6102:2ac3:b0:4a3:cb2b:973f with SMTP id
 ada2fe7eead31-4a3cb2b99famr2323716137.28.1727707427631; Mon, 30 Sep 2024
 07:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com> <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
In-Reply-To: <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 30 Sep 2024 16:43:36 +0200
Message-ID: <CAEivzxe6MJWMPCYy1TEkp9fsvVMuoUu-k5XOt+hWg4rKR57qTw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: specify module version
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kuba@kernel.org, stefanha@redhat.com, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:27=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Sun, Sep 29, 2024 at 08:21:03PM GMT, Alexander Mikhalitsyn wrote:
> >Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsoc=
k module.
> >
> >It is useful because it allows userspace to check if vhost_vsock is ther=
e when it is
> >configured as a built-in.
> >
> >This is what we have *without* this change and when vhost_vsock is confi=
gured
> >as a module and loaded:
> >
> >$ ls -la /sys/module/vhost_vsock
> >total 0
> >drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> >drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> >-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> >drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> >-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> >-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> >drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> >-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> >drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> >-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> >-r--r--r--   1 root root 4096 Sep 29 20:05 taint
> >--w-------   1 root root 4096 Sep 29 19:00 uevent
> >
> >When vhost_vsock is configured as a built-in there is *no* /sys/module/v=
host_vsock directory at all.
> >And this looks like an inconsistency.
> >
> >With this change, when vhost_vsock is configured as a built-in we get:
> >$ ls -la /sys/module/vhost_vsock/
> >total 0
> >drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> >drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> >--w-------   1 root root 4096 Sep 26 15:59 uevent
> >-r--r--r--   1 root root 4096 Sep 26 15:59 version
> >
> >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.co=
m>
> >---
> > drivers/vhost/vsock.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 802153e23073..287ea8e480b5 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> >
> > module_init(vhost_vsock_init);
> > module_exit(vhost_vsock_exit);
> >+MODULE_VERSION("0.0.1");

Hi Stefano,

>
> I was looking at other commits to see how versioning is handled in order
> to make sense (e.g. using the same version of the kernel), and I saw
> many commits that are removing MODULE_VERSION because they say it
> doesn't make sense in in-tree modules.

Yeah, I agree absolutely. I guess that's why all vhost modules have
had version 0.0.1 for years now
and there is no reason to increment version numbers at all.

My proposal is not about version itself, having MODULE_VERSION
specified is a hack which
makes a built-in module appear in /sys/modules/ directory.

I spent some time reading the code in kernel/params.c and
kernel/module/sysfs.c to figure out
why there is no /sys/module/vhost_vsock directory when vhost_vsock is
built-in. And figured out the
precise conditions which must be satisfied to have a module listed in
/sys/module.

To be more precise, built-in module X appears in /sys/module/X if one
of two conditions are met:
- module has MODULE_VERSION declared
- module has any parameter declared

Then I found "module: show version information for built-in modules in sysf=
s":
https://github.com/torvalds/linux/commit/e94965ed5beb23c6fabf7ed31f625e66d7=
ff28de
and it inspired me to make this minimalistic change.

>
> In particular the interesting thing is from nfp, where
> `MODULE_VERSION(UTS_RELEASE);` was added with this commit:
>
> 1a5e8e350005 ("nfp: populate MODULE_VERSION")
>
> And then removed completely with this commit:
>
> b4f37219813f ("net/nfp: Update driver to use global kernel version")
>
> CCing Jakub since he was involved, so maybe he can give us some
> pointers.

Kind regards,
Alex

>
> Thanks,
> Stefano
>
> > MODULE_LICENSE("GPL v2");
> > MODULE_AUTHOR("Asias He");
> > MODULE_DESCRIPTION("vhost transport for vsock ");
> >--
> >2.34.1
> >
>
