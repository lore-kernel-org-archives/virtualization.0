Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427AC221F15
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575062; cv=none; b=qYB5KbbheQ74XrpDyySt9i7dAWQlYX+Ky3k+ScoNN3LTpQA56Zk+B2UUwAH21CVWWbN671qGX6fcdOtVrOPeX/AmVL+0pHfXFFhj9kpCugCkDbQtc1ZZBkUR5BCI6eUtlWWwcONn64x55/M0w/4SqDDFHnkiHzbPjqNYx+Hfyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575062; c=relaxed/simple;
	bh=IR27taLTFITOYV4B00ku0qQKC4bEZ+4qpChrvPMvsvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn+zWAqPXKjqtKPt6HDpsuu4F4RhEPrsiFYN8lGvyb4Z81JtmSomelkKGAjDOkLpFsuu9K6a0zrI1Evl1yAZIfX0qxjIAHF0gIelb5whLrc5rcPv+ADYH+BljmNbtFwHEjTqHN2NVTJfo0VK57UULT44mUAjZp4uNdZgpc5Q4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6A5L/gu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6A5L/gu"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so5305504a12.2
        for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758575058; x=1759179858; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=H6A5L/guerjaTzh3j8frLW5EuLlykJfbup0oFDVHTQdXs0HroXAupLsnN/l+pKLeR4
         csV+0ftR8apyUIsUfAS7YESsSkPpID8smdILTRUEvJVzbjvkOlDlI9Kv50NT6DIqO+r4
         6aJ5qjBBD4TshzW3hWGHo18uCoMvZsqET5hn/I1aM40MctQMP+Z1c6SpPIR9yri7uoTF
         pyJo6i3u2q/LZU8A/HAY45M9UXKTGBDNTnC9kzwVpiM2Qmt8SL/taOuPmQxGX0uk8v7n
         5ZAD9lum9KqnUdcDNC9gTanwsci7ShTxCJLdKVW6PV/ExL/ctm6eMf3BJfhihfnXcHVK
         90tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575058; x=1759179858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=r4DDjHD50NmQsU9jGAENT4+IubxFwpnPmBd+H2ASod1x7x3TLW9vGzkCav1HMNQJC/
         mIAyDE1GjbFi+gZD9TwinuW4MRKex7qODIZDDX6Fk6CARaFddJWR593G2nF1Rqln5c0G
         h7BdL9ygbBTg0tprwhb66u9AaZxT36i8fFPWgWaxZto8b3ic4neypYQukTnO9UxNt8SS
         0IWZAptKXxuqmczYdtKtMorNpWzADQcc+cSOzZVl2qgPTxNL9WycpwUVPte9TH/Y1qZZ
         JsFVHM6n6SOFDUGPG0w9XrNRRuxEEBl9Ih6UaoF2lVRcrwIYtpB7ohG1NzWHrna6XSYj
         85Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXPFt40CgQiEN8N0CvqpW/98zRBADjcsx/67bHXvRzSSL9v/fEepVeUISzSmWO8M6bPyFNJgOGTzmjXhLNDvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjLQ7DdvOXpNhsPrBSnR9V4G1xa0LiP1r9/ia3l1CNC9xOZE/Y
	jfAx+wLKxkq8A0MOELxT4lqEZjG+wWmnuDGhxKc7WfzXPGsyRvt8IpBv0/zsqtir9ZfLYnmcIAz
	KogcM/zIQFftTfw2+DF8xZ8EO/yKgLts=
X-Gm-Gg: ASbGncuAPi4AW5v3QGUcnHtrUndb4ijW3bT4jDQA7l0JQCZFQ2KsupCr/AKtgyvCLkH
	VFTIxVof+uvTNnkUry1qR1lBSdUl4pcPVwFzT5SvG7bij4nYnDUf83cXSyY3rEQiq+/GYyn3JOS
	WklfKKLupmilPU905xjswjPliE/EzXo0YAQ277mMyja9zolhfAZ7+KRYH0UFzq53NHJf04aFdZS
	GjJSaGHyjop0KNlOw8=
X-Google-Smtp-Source: AGHT+IFr06URzpJ6aUp4DpRFc3gqIF/QKzvPatkXOguRNAK+5vyBht27Wi77YYUi7cw/QJFO8eHWzN6Nc8/pR3lh7aU=
X-Received: by 2002:a17:907:72cb:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b3026c84e0cmr5356866b.20.1758575058272; Mon, 22 Sep 2025
 14:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
In-Reply-To: <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 22 Sep 2025 23:04:06 +0200
X-Gm-Features: AS18NWDVFMZZnWEreuo7vPXyYUB8RQkWA0R_TESbZnVi7LcEMvax5dEHcVzVJVI
Message-ID: <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Alpha doesn't need struct *page and can perform mapping based on
> physical addresses. So convert it to implement new .map_phys callback.


Hi,

SInce this patch affects the Alpha platform I got curious and decided to
try it out. The patch series requires some preparatory patches. Leon
provided me with links to his dmabuf-vfio branch, which had the
patches (and some prerequisite stuff) applied already.

Based on the dmabuf-vfio branch,  I've built a kernel and tested it on
my ES40 Alphaserver, the kernel booted fine but after a while of
moderate filesystem load I started seeing some ext3/4 related error
messages in the system logs. Rebooting with my old kernel into
single user mode, I was able to recover the filesystem using fsck.
Clearly this set of patches breaks things (at least on Alpha).

I haven't yet dug any deeper into the root causes of the file system
corruptions and I've only tested this on Alpha, maybe there has been
more testing done on other platforms targeted by this set
of patches?

Regards

Magnus Lindholm
