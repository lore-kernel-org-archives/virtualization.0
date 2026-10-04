Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B645040B;
	Sun,  4 Oct 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119071; cv=none; b=J1Pe6i60QetdLbw49TsliGDqF0oBTy300YFZ0wWByaM+fkd8aG+T/GITsoOzI3Xx4d7KsPay1I0wpaRL5I+zgGOPEIYbFiVuaQK9oLev9PYbox5iAyWjdBVH+hBSHyAgLIqKSNt9yy2srOUq7IkKCVse8GnknD5YRU7Z13GJLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119071; c=relaxed/simple;
	bh=VvpL7/jS27aEMVBz78ArV0ueZqdb0AcM3oTX0rxFptU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YdFKF9JZ3EUXOdq6Ja5Lm83I6O90T3bCLkIHVwYlhFrt1p3MfDY3UO18m+cAbBAfGNSkuJXYsRwv9hTfL8my3xbAzGn7a8hWc4SfB3F3+f2wMrQYKJul6t8P0roK/gfuvK4qbbx8Rx3zO/rFFW6D39rKhQ7YP0j1LIsXosKKgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O0wHyuIL; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O0wHyuIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791119064; bh=uzRS4yFR6AumHCkERSa+89uFhChWocAdxVFoUjMRQSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0wHyuILQ3pdJ8LuwuI4qy21zcMQOhF9nklQvko7gImG/pX7hNQoXpJbIrR8maH9t
	 CCH6wyNgnejkgKyoKhRajIfkr8uaiRZpclE1rGyhXZX8GRQS34tNePs4k8mZCMUhDv
	 EjI3ce/Q9/f4JJmRH4Z1QGvOB+rAD3buypNjG2VA=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 112866B8; Sun, 04 Oct 2026 21:04:18 +0800
X-QQ-mid: xmsmtpt1791119058t5fb74n6a
Message-ID: <tencent_93CC5A85EA5ED64E556670FF6FA21D4B7D0A@qq.com>
X-QQ-XMAILINFO: NhlrMjhcHpE/XBp2d+IDCt2wXcboY29WL4wVWqFM+3+3EevxoVJSwaHXnY7qYr
	 Bhp/HWG8bZoEx71WEWctpaMmFqusIst3s6UzkJBn9n2miYSSQqNRqf6gBYoFTZlLSl1EXPg1m3Zn
	 /zpnr6M6Ah1b8oaj7H6DTPwNn48l3LjFX2dHlmN40G8RWN3yeHi+5AJWVmC+MRP+/+pQNGIDCSps
	 FOSlq9m6WU3cBEYS8DF0/91rs7wGryHScL5isnEs74HNBVH7YDpmGlBxKAsYFXH308dy5dddAilM
	 XNKcu22IXD6iPZ87403LqAlMLsPn1exdZs5TmgeHTO2Ax9WKo5hPanMnNeCanhYzvkv3D/GtwUHC
	 IMPBl56p4n9LUvmfJuC/jOEVoGjyn75a0GknUoPzCf5LfXHkwKPpllxtXczuCOWTo4z5nCLOnwun
	 1IlNpu36NRnzKp2PoPBNaVFMwJiywdA9Vi9KH7iZ0+EZFuMOWRli4O7FG8YoS27UEI0SVO7FKzL6
	 3DyRHOzu2ZItXPzIr2PxcxuKm91HlJQY9ioWUTi4CgcQYfj6Ll5LsHY8dAw/cAJSvEPSrrLJqCXy
	 zAP5wFj3nFzUsrjrKS516T+kr+3mEQPSE4h3atMZnywtcnHQipGs6BZ3m57VWDZffogGjJaZ54Ap
	 lm2XSHVmjR99a2b3meUMPzbqlGks0M9CWsyBMTxxZaJVmWEGew9vU01tHB+zg0+5Ua0gE8SNR4kW
	 bq+6o2S2MK2LIoqFK00hwDGMtmG56a1U6dP59y3xPRIR02JR9krxACyzkfZ0n+9MWsVp1fp4uCT/
	 Ry28gYVEvG83n7JHY+rWGoKf0NXK1T907ueiozNrlv0DedFa8cFq/7WrMWqm6O6BH4qrUFKHhr7E
	 onwd7sy9dLnAOfZkjZIw+YXAm3CDQyRjfEzSp7445c38ckdu6RDDvT7pkpwuz9Ti9YRV4Stn9C4D
	 jNgYSpJVDM46ikhjCobmHq5yZm0Y9EE7zusBKfNCvY3kRChB0JvCmVJjEGhwkwnqhOZxlpph9K7m
	 gZ+t8/FfYpVOTuTuKO2CkHr1c81DSZaeJDGX0GOKRPEVpJOJBQLGv7kDsg9Yotniz7HzNJcCFHK7
	 mBtd0two0zOwFIxCyCmGAk/Dxy6tx29TLmf1Aa8dNAJI9DPXw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Anlai Lu <agicy@qq.com>
To: sashiko-bot@kernel.org
Cc: virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH 6/6] iommu/virtio: batch the mapping replay on domain attach
Date: Sun,  4 Oct 2026 13:04:18 +0000
X-OQ-MSGID: <20261004130418.3226279-1-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004121049.590941F0089A@smtp.kernel.org>
References: <20261004121049.590941F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the same issue as the report on 4/6: with the device removed,
viommu_sync_req() returns without draining, and the requests left on
viommu->requests are not freed anywhere either.

Batching does not change its size: once the device is gone nothing can be
queued anymore, and a request only enters the list together with a free
descriptor in the request virtqueue, so what can be left behind is bounded
by that queue's depth.  It is a leak all the same.

Please see my reply to 4/6 for the cleanup and the reasoning:

 - the objects cannot be freed before the queues are torn down: the
   virtqueue owns them (it holds them as the buffer data and has their
   scatterlists mapped) and the device may still use them until it is
   reset;
 - after the reset, virtqueue_detach_unused_buf() releases both the object
   and its mapping, which is where the loop belongs;
 - the baseline did not clean up either, and would use-after-free the
   deleted virtqueues instead.

That cleanup is in the v2 I just sent.

Thanks,
Anlai

