Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186D421251;
	Sun,  4 Oct 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119061; cv=none; b=dbFvqR+pV46YMque4PEe1C6Bbcqc/yJ+ON7i0F3+W+NUFi23htxqD6/0kELxZyqJ0tzcxhUfpSIUCYtsespiSA3ILOn4bTPP6Puw532bAjLOdLvi0D8++t724saEXGlMlAgKA+4M10tXYQKregFeoRTdp4YAtugV+8O4ZMEyAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119061; c=relaxed/simple;
	bh=rTrPGs/6gIYXgawRDaWv1j0V8mqrl6e2mJv8wMh56MU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LPn1ISxQUhTdQh5y8p2UQB0EqO6IWn+TMsumhTxxUa7gbEbdS/PzQ+XMVolsPNaXKbplj/njSIWFm+/161tBPaiO9codDjofH3AS3hF4+LmnpUNkwExkQrIhVxPvU7A8tu39kt60laA61KRM8jXZXzOI6rMQBYRMC3khvVSDqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mtRHSUJf; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mtRHSUJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791119055; bh=1sUK1jwzkfXeuosRyWgebZbS7VsC96r41xwmpwXMUQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mtRHSUJfGIxbE3UQMBSNTwEXX4KHlcRUqBMVZ+YsU5+oOYc8iuK5EZkj7gRnFnbUy
	 q9A0dQITucL13wBQVI8ZZyHyi613vC8kca17JQZP65jZ9cSJ2WFZ+3tceX2mr8mlKt
	 phNzq+evbs9TwBGnbZWL99/GBYgkbz9V9dz4O2co=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1070AA28; Sun, 04 Oct 2026 21:04:07 +0800
X-QQ-mid: xmsmtpt1791119047t3apx62qw
Message-ID: <tencent_0775C96A4F2A7BB91937DF8EA13FEAACAA09@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7iatHntpbBYiOSPtdbAHahXXXGypKHpgKYr2YnfIg3h2Lx2mMhz
	 GlrqVDrgjg/wyj3O5pdyW1aWisVVm2k36TZrTTIAhWwCql0m7Vo4/nPX4mbTlVIqtpvZ32TaWhwv
	 3m8Qh1QO4R9AXOiUm/NWQJesbJNFiDIwKEdqKMbjckzccwOyhN2Wqm/0ZMR0AHxBpG/WQvQcryN/
	 TxJfduy6NBHjZk7p4f8OsJ0/fS3eQ2bDX5Duf4FyyTQseFnhLbh6WnYc6vBYlzY2KC8g8oHA5JWf
	 rSB6QI2QG0MkpfPccFQ0lcUfoXfHNHXDkLKz8UgpSA7LFb1Kd0CxY+4zi7Wh667aN+44s1AQaLb+
	 8PkINq+oq+Kak9mdBOg5sK27CEEF+UkBcA57Tl+Zi6Bl3TTbYr2m/nuzmmTKQJ5Xljk9yXSMWVc2
	 BctqQqqr7bqfeHa1k0ne+dBA0QoWdetQKFIsyGSA14ELqLWd9Fa0KASPTccpmMH/G9/ItcnuzS2W
	 41+lne+7qg5/JkUk8SbDUhDwq5Xs/MfdMKBJMviJ93tiaecJ+qAfYAEjb48Qpxa0eiIz0HW3vCh7
	 HiY/t6jR61SVv9LHcuGilKdAvJayNSvrWjMK4CahxOC6ruOhT0Ivf/eFqUm89tQLnIHtavI/MeV8
	 79+xe9lWbwTiOXB0r5ATl7W5ojPxYZwJw+DOPXi8RygrA8Hl9CacUuScVtcyVruiANhm4CN+Ok/N
	 iDmNOQcWXDslUdi7vEl6q+7hF08kFGTYeYfb/VJnWAI/UZjYlgQsSGggqxfeFU8U44Tx/I3eKlBg
	 5HKExglpMolgxps+R2MqWhWx4F4FIQvjQRQeLasOdaqcqpOKBaMLUwVxN4KRO37cc4mKw8oiyuXh
	 YWt2pSoFa/FQZU1LSBDrVVDWWhn3ShfuOX9EDOi/xjITW78tXhKm+aRMbE62xM5heItpVhBnB7vV
	 r1ucE4rHZ6SfppSwfs7ZSYrl0NZ0K4pDYl1mK6i1K58Q+FsyrQkDWcNIj5cQ1fPqazEO1xX5mLc2
	 2hw5s/04vt8n6ixY/KbnFQxQnVJ1b2VsjmvPCakHeFB0d6DsCVMGAJ96VOUmW2aS27Q9Pp28u37p
	 /9WwsmONbnN7QdYOV2P+RVzvl1cvt3RkEs4MMhDi/HsCQAAuo=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Anlai Lu <agicy@qq.com>
To: sashiko-bot@kernel.org
Cc: virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH 4/6] iommu/virtio: stop queueing and draining once the device is removed
Date: Sun,  4 Oct 2026 13:04:07 +0000
X-OQ-MSGID: <20261004130407.3226174-1-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004120957.CEB961F000FF@smtp.kernel.org>
References: <20261004120957.CEB961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: Medium]
> If a device is removed while IOMMU requests are queued but not yet synced,
> does this early return bypass __viommu_sync_req() where those pending
> requests would normally be freed?
> When setting viommu->removed to true during teardown, do we also need to
> iterate over the viommu->requests list and free any abandoned
> viommu_request objects?

Yes, they are left behind, and it is a real leak.  They cannot be freed at
that point, though: the virtqueue still owns them - it holds them as the
buffer data and has their scatterlists mapped - and the device may still be
using them until it is reset a few lines later.

The cleanup belongs after the reset and before the queues are deleted,
where virtqueue_detach_unused_buf() releases both the object and its DMA
mapping, as other drivers do at removal - and that is what the v2 I just
sent does:

	vq = viommu->vqs[VIOMMU_REQUEST_VQ];
	while ((req = virtqueue_detach_unused_buf(vq))) {
		list_del(&req->list);
		kfree(req);
	}
	vdev->config->del_vqs(vdev);

The baseline did not clean up either, but worse: with no removal state it
would call virtqueue_get_buf() on the already-deleted virtqueues, i.e.
use-after-free, rather than leak.  The flag turns that into "queueing and
draining stop"; the loop above closes the loop on what is left.

Thanks,
Anlai

