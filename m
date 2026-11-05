Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920347;
	b=OpotkZoq7GLF5OGMjinD4os439VDrOMld+uRYCshd+F0hNFvw7/wsQtrX+mtALVHV28b
	 5ibFzM8reOufIqL58bC17EXJPcZMeq7Lo/CESQsA4XNPzSH0NnJby0qK8zZDg1zh2/y0p
	 HyQnLoKCmlXHUxhMev/fziyHQZd/AhcMDCk+WexQ6/Iapl5fWFajSguM16lKhMF1NCZBv
	 qM0rPVVIMaZy/C38Ha94bMobAJFEvs49bgV1HTTt6wwXJthhoFWhMJG7tDdXmHvmY13f8
	 JZWmcU/9hxhWgzJ+xAJWEmEBhVyMSBT6DLfj4ssGOH1JV6oF+zmvbhozRzSGcL2jnsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
	b=zwP7yFPU7HIG7jBcg61G+kmI2hpSJNss3zO84ARav/EDJLbciodPUyyAJMkzlt1/+AcQ
	 GBqeitpROULac0hN14r/7+RmMwS6Bju3pXxsJtOZRAS9Qwebe5PQaLF3YIwLCo0aCmFfD
	 NI1rJldPxeFj+++wrMs2aCMr6USou6/nGBfeNG8yqNKbiAYDioHSbuI5GJSvPLM+kSahm
	 3YCs/c8NsSw4RSzYbQm+JOCN9aua3U8S2XsFzuxilvL33m2LSjs2mLlFxzBDT3MKlLCxs
	 1RjpOSyzms09BOUnvtHrPL5qLjTKSNTt7nnFjDVCj6HXKjq2y8YDinb4aaFcdGzJ6CA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ebuKcNDO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE7606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 23:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EE7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ebuKcNDO
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso13073a12.3
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 15:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=IjGB7qzpsnkAhbsvVbbl6w1GrQ+9yL4sVqAlieYB31K6SQwIa2a87MpbaybwHfeZuX
         leb4LcaAgUgeeVBpb/iLvIvp0Wg+p/U8nssllXPGP3BpuuHQtkhzBeK2khselW0VWd5Q
         FLcyfbe37XL/0diMkJLwTIWwwguAQ94UIYK5LGkvyZ10jo7CuDeQS440OjBsgXJSEL1o
         vFhG0rU/+UR7r8AE3IkqPm7SSxssbM66Q0/RYcLhwJ3lJvK6W1czLUHZfFuqFoQ/aEJA
         xcMvVCg06IQgUBPo1JzxvpVx195AZfWORRyhblQIjpnlHv2YZ7Esz7VjHoy+XkAmK5MC
         Cs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=Vua7pDgM+aJXqHE8DgqkrOOwbfLCOFdR4JQo+a28jBU=;
        b=rxnl9HkIct8d0x0YU84x+vfJFZDuLPjtw9Kokmww8O8qlRwdnK5/k8nWJz9bnNvxrb
         DqmgvkTQ8+lB5E0AEB/m1cQ/wVZI3K42k9gXTys8VRexYJhZH7DDn2TIAiIZXroL4nXo
         RKQFhox/E6OQJNKOzpnLpWp70ygu0U8MN/xc5k/jzWpf2JXhcZVDIS55LAQZ8QlY75Qw
         c82QJgs3Zel9T40wqwzryTzgsqoZRlMjJCy+hvWe8fQfXpQO2qAiUsXSmfOi7qrRq5Hf
         jcT9MJNb1EQXNz1E7HodUduaxQNqDCYCpcYt85Rf6YPMMKezcancdjwyb7GOJiAHeEmJ
         JYzQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=ebuKcNDO30LfGCCq5veHLPuo1ddlK0iQX9IKU9VXku91AZ9m+oPcJrb1GMmWsDFpFd
         o6z6arIxNPZJwy23OASv0dq2L+ErtMC4IPrExZgkVdCN8o6jFd9DX8K7l4PUR7WQDL7Z
         mK5TF02AgOD8hUgx2bt06Y3NDmRjc3thwsUsJaLe3m6iNSxi51IXGKWHZ90svR9+LHrx
         BHLzrlfKfCL3NgnXtra7pXkn64C0xL/V4CtnOUg4yGTYrwH0ObXyw6ya3Q6pc26DjsZI
         3yRCwwfuqch1YFwrOmZPn7Lb0bJNxqbmdUU9ql4ytALKJSYt+64P7HzmzPPWmn7ojnhv
         LLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=blxeQ4LDe/cQC/4reB1vdc1RakqK+6Um9luxY87SuitsA+Y/FFut2w8ayppbwoaifa
         4N9TL9EHghms7rhS3eUTelRVA/DQm2J2RpkzbE2iNCBd+ggREn3svVAgkKlyI9VmJ3+r
         T8z+H7hlwktYwZKiilVvJ8r/LiHi0HsfMFDNGqLnjQkskKpJa4CAgj33+LAQyH31JXBf
         gWR0OWbFBpcxNTbrB/gJEKldskDcy81+PIZVSlz5esASJK2pvRp/FQqNsUXuep0eNQ69
         GnVdQ1T53Jknu1VnGQLcqbundxBwUAJZSQXnLol82LYk5lXF4bIfjJhLYxGbcEVDFQTs
         2VIw==
X-Forwarded-Encrypted: i=1; AKwUvBy7Oo01wjhw7mJh3MXg3VT4VE6JQ+RhEjHBL8a/62wpUysfOyxWjvGghFIedO2uiJVxISXSguc7Je+3MW/Rag==@lists.linux.dev
X-Gm-Message-State: APuU4Z/PPW7/YyRfSMhF6kv9+TZluzP3xstZnXYb0PxH4KOZFLrz1Ls7
	Qg/EbPsM+qBPlHInezNK4aRTwtgTjhQUNa4tl/V+CjYsGeczpc2+zMWpWq6Wewh+Rl6Wtovm6mZ
	ZnvFFw4bUyohXPeLHHY31wvKDKtOQ8kOp/QcfpI8r
X-Gm-Gg: AYBFou1GC5wt5SivlE7sTVfOhkmYgpwlhit3wvnzUprkUWfSHGWxTZ9wkV5IoB3b4pn
	KnG5jDFuWT/m8GVr7epA9ikgUoJo6cBnlrYeRRgK8DVSrFvm2HrFZSE5lo/eoJrquOx3rebG6h8
	SV3zCNJbHsuTgApi/SRHIqqwp4B2V6LCIBJ8x1dhxd8LaI7u+IWZlOd+zLaoqnb7joZu+VmfGQG
	izFYLX15WB2qUMUlkTXyUbQUHWsCzTAbbaY7vcP/lbowOMC/gO6btj09QPIgaCt6TL5jH/MUv9f
	Ki1MvTBOksqORt+DJYkFFXw14dghkBnNCgf0ej5DUE+YCScu8sbhW+eWlcqB7mwsao5NtM0FWRQ
	ZedRDqXbXJBF2IPKiHyxKp4KfaccKhJTidNqRAV+g3+XWf/C+6q5CvLyUuDdHXapbGiMP
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com
