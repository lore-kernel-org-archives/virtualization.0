Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435E15E5DC
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142190; cv=none; b=YDP70/iPSjMcYrui5V8dOuubf6w1zoSAhJmnz6mR/a5nxm9BUziPj1n3zpT84wdpAPMbizeEQVehUSnlTrb9Ld/+O3ofmHwlu7atb4yZW8PGrnU53m/r1oAleXxSuM+dA26uacpWO4mPhPst7F3BzcxMxErDNCJgoz+V0zwDWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142190; c=relaxed/simple;
	bh=+n513kDZ3TcIR4W2QVHnQqu/cInucM+9o9ze9SW7VLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWzcPD9OaWwnoGuFi4L3Ya4wHtMfMPPffg0vHnzMfIgcYzJx2miYIu/IUADGpQGgsgqtnfg8KlTS8KrzKEVvTexIWozXvNlMxGvgrCkBTXXXD08p4mkIVlQsbz5NmnG97HUmvTphAsELp1cmw12CbcZsCFX4lzlrofN0aLINFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxbhOuTM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxbhOuTM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0a5354da1so3789605ad.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781142189; x=1781746989; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n513kDZ3TcIR4W2QVHnQqu/cInucM+9o9ze9SW7VLw=;
        b=FxbhOuTMNpNXqTDpybaYmti1RHtmRmG/sJSh3YJsH0mfoNY17VptKl4Y9UF53t6ca1
         /CFK2tT7v9Iy3W0TSCoP1vFpe23BOuYCtNwp0GblFXsR4c3CPQqOf99zglQzyX+UnqYH
         Y1RCz/LAYwAXZ6QoBBMNcnse7fK+/HQcB/uc1RDkMot49uWEAO2hrb0JlQLZ1HeybUQI
         RfwyJ3F8J9A8SR7/RcPyVU2eOrZC/c9K7p0Cb3mQ1+/au+DIVcl8qFFZBqFPHDK07Qsg
         qgR5Th/8TERyl3Cm96rz1nRYayO8fhSfAgUbeGydELnW++0EKWOH3s9wnL3HWQaEMLrX
         yH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781142189; x=1781746989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+n513kDZ3TcIR4W2QVHnQqu/cInucM+9o9ze9SW7VLw=;
        b=fCSDt/hZa0ml3r4/5HvI2GsW/79Cd2lfHpba0SIueVUVeveLnl23k/jQz1rttgaCE3
         E0ZikPyw5fHOFDmahNSG9MfqWZ/D4jBp549to2yoolsmKA85LuPPN3Izd2Z3/nu28EXh
         uJlcHFiipNoFMzvGlhhSJzWiARPyKq0iuRRcTi8bwDxq9eSmpE7aPiBfdbjYHC/4iCum
         mEpQfjp0hsRFLLI429KrQy+MHMO/MO9YK9e/sL0XH7eljsbSwzvHaaq0ziZ49L5iQOZm
         pd9+bv4PmwSJ6GDgFE0rmiqaCYo71cqsTIaKRPhpdpqDsKTALrWUhR37JEi7YBH3I5mU
         Z29A==
X-Forwarded-Encrypted: i=1; AFNElJ+THCdEMow7W8vcpWcdrBZaNV89Ilp0rLsW9/QD26TUWMNx31n/sp5wcZ29WMScJiFKS1TqO9MBrydnU5ppNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYya8aeQx87BKWb2lUxkMzESFM/BaGyJWgdyflKU3V1kRbIRTH
	NeOnCYj07uPuYWcp4Q7dSoTySOsOt5u8k6P4eY7U2N+tRxHkS/9QwQk=
X-Gm-Gg: Acq92OFl5V5RYfB1CfSdoWp3GxxP40udu4FoD6PXdEfx8WzOICGk5GtrcGhpwgg2vTR
	Isd4fQ2wcYxZGNX1YT2OgacgLxJ29VmcKde19zMeC8iNMFJa5wHjGDogok3Oh94yIi7L1GwUveM
	AkCvlmbQKMZaxp4FXmRP6oQzmaCyJpPEiEzWXFaJQ+8Lzq9AUDknd72oAtenXy4SktRNaHqeykq
	SjUpElq16umsMupGfsSIboybXoIziupsTgdb4yMvPQFT0IcyVRnfmZgB8XN8PSCYza4i1WZ1rDf
	RNPiYdPxmSbaW/Ua+Ta45/85z0lheEzlxeCTQMmx2q+qTyrzQH1KqqxlaNWrL11QMZoDW19uaf6
	YN+Hi9zsMptbE0FtTLkCI6jTwlxLe5S6piOvOtJCV/MbF8BSNer8KbxzaBwBUt23VCnszNzK+rT
	kmeRW78eRxxsAoa0QJvACYiMFVSdTjA+edMf1L+gpliU3Nvwn63Rrm2ADnCamljlas/Ibba+y9j
	Te9iw==
X-Received: by 2002:a17:903:320e:b0:2c0:c262:b924 with SMTP id d9443c01a7336-2c2f7203258mr5001395ad.13.1781142188609;
        Wed, 10 Jun 2026 18:43:08 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm260924895ad.51.2026.06.10.18.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 18:43:08 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: bobbyeshleman@gmail.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 01:43:01 +0000
Message-ID: <20260611014301.22599-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ainvZQppoc7LfPRs@devvm29614.prn0.facebook.com>
References: <ainvZQppoc7LfPRs@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 10, 2026 at 16:12:37 -0700, Bobby Eshleman wrote:
> It looks like vmci might be an odd duck here, where sk_acceptq_added
> actually pairs with vsock_add_pending(), instead of
> vsock_enqueue_accept()...
>
> For example, if the pending work timer below fires, vsock_pending_work()
> will see vsock_is_pending() is true, and then hit sk_acceptq_removed()
> and underflow the zero backlog counter?

You're right, thank you for catching that. In vmci sk_acceptq_added()
pairs with vsock_add_pending(), not vsock_enqueue_accept(), so moving
it would cause an underflow when the pending work timer fires without
a successful connection. Patch 2/2 is unaffected.

I'll send a v2 that keeps the vmci call site as-is and only folds
the virtio and hyperv sites into vsock_enqueue_accept().

Raf
