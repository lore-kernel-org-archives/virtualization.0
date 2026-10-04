Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999A39CCFE;
	Sun,  4 Oct 2026 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119001; cv=none; b=QSS/E2ud+LNGdolNBL2gvUqrRRC3ZPnpgfT1rLRH5uJ+L3eNGin0a/gvAM2+djxceaX8o7756BwgJ1GP/Rv6SeRHBITYp399ug2yaulGOVXTV86hMl9u1zcVJqManm+r7i8Cc5hpkHuy5ei1wCjBrJK/IynC5RYZ3CrjRiYQYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119001; c=relaxed/simple;
	bh=2GWJESrEnQCGfV7YDGyLOGugS7dMlTqZM/OpNxTWUEo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ef084RGMtiXrfClTYYJiasqw4tsDVpW5BOT7YE6qzs9pLTPnVmKOOzGpQDCyi3SEKcNv5uR5FSMkexh3uR/iVqaEIjwPqhucghSBsnYM4eY0eKKtZ6KX2lOw9tM2sDADt4Y225Clw8piUknFJk2DB83UiFIruiXP3bJGlAi9AJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=USgVBA+a; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="USgVBA+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118994; bh=/jSyFVpBj1H5coY+WG6g1BpkBwLD4Tj8rf0lzvZEY2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USgVBA+aFOJju2WjRcPd9ZQ993vbNTPEHUh77Iw6fi/2n84TxbcYbL/w0OGfu3KlM
	 CBfyLHhhPGyX6nLxGmL1tBEVc5ipDFiJSErjzFeTuUMfS2BZXFOkyBPgPeINZbKpbL
	 Pm1o46Y2v7dF00RBB456T8PbzYIPLsTqKXw6pLGk=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id BB1B629; Sun, 04 Oct 2026 21:02:59 +0800
X-QQ-mid: xmsmtpt1791118979tyvbsivrb
Message-ID: <tencent_5B39F7D3E6FAF1C347B6158C6E71ED66E506@qq.com>
X-QQ-XMAILINFO: Npv5yIQT4nxMw+qkM5H01NnRA1Jp8prtziatVLGFccRKwxrHnOvQNWjbCbqplS
	 EANGXKfW7ksAzQkKBVUhKsJntXrtNppq+fb0/l6T8xrkFJSeEuvdSfDq0vjixLPm7gGUtLS5Ps4r
	 3X61WhhALjmEYoqs5bR9M3ZVhvSXOZgy1nDFOXYEgzIcIbhB+Ku+PYPe353/HamH34ui4Jmm2SrA
	 Hjrnzk6QQ64XbygZ4+PvxLH0U6RpDiIrphujf5J99K5Es6ITgc9glY658vi04T9srriYIHGHlzgi
	 Y8KMH7x88lVRxohAgUxVHsYackDT47G6CjSpZoBTUxkoZS0zApgPOf2PlPjwdA37qrh9ggX+E9Jy
	 L5AnqhJ4CYlB6yKjgh9JYBN4bQMvyNrIMpfgd3s+Lzm0/QeJWtLcEs3KDPmE3ovSWhLwLOV8dTYo
	 VlCLyxeYzojinUzSn3/vCPdtSsjGfDaSO9w/SIfxXRF1w4LlFgBtEPOHnkRj8aEDW5Lkv42RDclb
	 y5Sp000tx3qSALJeSN2nPHyx86lrVkqLCQrOmkj+oH6ObDgdjrqED/kDathBis7dV4OV1+6+9Qt5
	 A1fc5U/50g3iQNvp5hyASlfL0RHcZpedUqxxIJEG/1pvqPSrDONPv/ZAFnF2htIYjUFTMjxmpRjj
	 BZV82NB+OcxInMjGGGfdnlxMjsSAv1RUeZLlaw1PMOrZQpUUZYP7bPXSBxV4fxtN7jq4UY4CIUpB
	 n2PrFWiqQeiFEOPI716y/uukZjyQei3VuIg1B5f5n63UefCRWR/7M2YsB4CvOdapoTfqu5IC6MuU
	 KDgixuBlC8Lfc/CA9UWapr/ps1XljRS6BrRkvNL1B8AuY8O3BhKE96iLU8irVrcfUOqtEtGjXKOO
	 wX/Du9gmLuPK1hnhlwAKRo1jbF4o/0y/Xhr4Oo3UnN5xnGrxY/nfODRtHCKoTfFmFZpSVHWENYsl
	 lI41hPYz8ZPVjeWzWIlhEbKkTEyVa8nEDqqUB+4xm6nMPg8jNHAlrrbkhESiwQLOZAQerXLaxJ0m
	 3209y5Jf9D9ssWpCRo6MKMOK2OKgfthzCXNairsBVsx1S+pG/LeIt4vf5S26f5DXfrA6KT9Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Anlai Lu <agicy@qq.com>
To: sashiko-bot@kernel.org
Cc: virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH 1/6] iommu/virtio: publish the endpoint before replaying it
Date: Sun,  4 Oct 2026 13:02:58 +0000
X-OQ-MSGID: <20261004130258.3225640-1-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004120832.082DA1F000FF@smtp.kernel.org>
References: <20261004120832.082DA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: High]
> Does this ignore the immediate need to restore mappings for the current
> reverted endpoint?

That path is the ATTACH request *failing*, and there the endpoint cannot
have moved: the request could not be queued, so nothing reached the device.
I checked this with a failslab injection on the ATTACH request: the trace
shows no ATTACH for the target domain at all, and the endpoint stays on the
domain it was on - which, in the flows here, is the core's empty blocking
domain.

In the other failure mode - a device rejecting an ATTACH it has received -
the driver still assumes the endpoint stayed where it was; that is the same
assumption the baseline made.  With QEMU, the only rejection that happens
after it detached the endpoint from its old domain needs a bypass flag that
does not match the target domain, and this driver cannot send one: it only
sets BYPASS for the domain it reserved at probe time.

So the old domain still holds the endpoint and all of its mappings, and
there is nothing to restore here.  replay_pending is only re-armed
conservatively, for the case where the old domain's count had reached zero
while the endpoint was retired.

> [Severity: High]
> If viommu_replay_mappings() fails during viommu_attach_dev(), the endpoint
> is reverted to its old domain on the hardware.
> Since the old domain's mappings were dropped by the device when the
> endpoint initially moved, does the reverted domain now lack all mappings
> on the physical device?
> Could this cause all subsequent DMA from this device to fault silently, as
> the OS assumes the old domain is still fully intact?

This one is deliberate, and it is bounded.  After a failed replay the
endpoint is put back on the old domain, whose device-side mappings the
device dropped when the endpoint left it; they are re-sent by the next
attach to that domain, which replay_pending forces - the flag is set
exactly when the old domain's count reached zero, i.e. when the device
dropped it.

What bounds the window until then: in the flows this series targets, the
old domain is the empty blocking/identity domain that the core attaches
before the user's domain, so there is nothing that can be missing.  If the
old domain is a populated one, the state is still better than the
baseline's: the baseline left the device on the *new* domain (with its
partial mappings) while the driver and the core believed the endpoint was
on the old one - the same missing mappings on the wrong domain, plus a
count that the next attach would underflow.

If you would rather have the old domain whole again before the failing
attach returns, that is one extra call: replay old_vdomain right after a
successful revert (a failure there leaves replay_pending set, as now).  I
left it out because it adds a full replay - potentially as expensive as the
one that just failed - to an error path that the next attach to that domain
repairs anyway.  Happy to add it if that is preferred.

The comments in the v2 I just sent say this in the code, so a reader does
not need this thread: the ATTACH-failure exit states that the endpoint is
still on the old domain with its mappings and that nothing has to be
replayed, and the failed-replay exit states that the old domain's replay
is left to its next attach.

Thanks,
Anlai

