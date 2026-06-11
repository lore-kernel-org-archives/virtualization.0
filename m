Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C33BE147
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171719; cv=none; b=duBi0MG7S+YgoSQi5AWa6iIaMkO7DmaWJx5aENHQfJIYA9Ae8fFllWLN4iiyI8XwIiU3WxL+lZvWJMS/5kzAH+ln4WKosRpdm5HqVWUdrEZSv9cucgPaHEHIOK6aHIfBEt5GBrtgxgDOzn+C2aoRut7NdkU2IUJdv+ghfWnwBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171719; c=relaxed/simple;
	bh=E9SO15uyyAfjDeXbLMmzKutv8CUXv7r2wvapvsQuH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nmg7DRgZMLJ7TCe2NFuX0xUKE18XKAlieU3q9HFqPkT5CQ/2vlX5+efvlLkTABJ9r9msL4opHAHF/9YH/wDguFneQ7Yg40s/oMC1lZxuKKmvMQ1ieuhvlJEpUdzAmnpXJtw7E2uYNCupHp4zPrpSMYZLJUSS9KwTNvX5ImTJoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4UDOeCc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4UDOeCc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c857fba35cfso3859827a12.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171718; x=1781776518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKIDXrzOU4smjqzdZP/hOemMYW/zVaqgrAinWNvJwIM=;
        b=S4UDOeCcaYwygxxJ3K69dz+5rfAqU8vR9TLwCWu2Hv4Fcb7hLR0n3XsC9c555UyffL
         KGagP2IwiUVDVv/6/x4iZfgau5+NwXylCWttp0CtMirXt7e2+Hr+4q7BEo5ksryIq1Yr
         ZcQgJjLN7a0CVKSBQ4MfeVG13wVb5apSDfQDbp3HuohL5n97f/gJLp8BbMLFds6pOTsV
         AKhELWugPgx6ZwjiHfWoOPiJqtuvzY9/qvdX2neDdqUcmhTb1N6HtjDeCm4obhb/JOpH
         DVDqSa6u9+WUuj0mxdeuFUwIYRY+FCK4TIAgeJ9ZoyV6HOaYBCuheGVIe9z6Wfvq4PQ4
         L06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171718; x=1781776518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKIDXrzOU4smjqzdZP/hOemMYW/zVaqgrAinWNvJwIM=;
        b=evqFekx5kJPz101qgelnY0MKvuCa6UNCjZb0hOk04cF9CiCSV/NL5MyrsHDltCQDu3
         xZnWIJiSgb5rP4QBmzEBcZUI2tGy/75vBiXfoxwkWK4PcnNqxGWRacvzn61cECqoidwL
         8HVBSn0fygLJYYuzPm3zt7j7CwRwASgj1rJejcWszDJdWU3D+YxcfmCgnAo4TOPPgYVe
         IAeuv25uXmo7t/7c0jIp8LfemtrBtAPgAFT5Q39Fkm39RNI9UA1Cv0uiPNGY+5Nd2nwt
         cfsN1ugbYMKnNlToTkjZDyr/sMtM7jLfQCzv2x669/tN4r2vU6W2ggSbZ0dcBqfbLqEe
         nYCA==
X-Forwarded-Encrypted: i=1; AFNElJ+4plUvs7P2Pfqu6W0ojuJ+goxq/lio1UMshz3L4TxJ+l1cH5F+f/31oznqiQOPpgtJj2BroB0H8cUwXy4c5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwM/r/lKAUVTi5DpJX+t2pRK6TDZhC8wdMtfdSnM63Y8dkht0zX
	oGzGYZ60Py/+0O4MNihhNEUmd1GO33AlPVCU/26D/GPOZ1+byKl5JlU=
X-Gm-Gg: Acq92OFwy08ntmm2P/asnf9ep0vmLpjqbHc+ondpYsAkaTIAAM5/F0Ky6udqTczlyqI
	1kC8NNgtzPsXFxfBeMfSrKnCKCq1FUcX/kw7g5vht6PjquN/e55nYejxJQj3lLy/Y1PJkjdFoIs
	U5AqcptUm1huGUQjW5mfDMybtm4b2v7GuNImO0jUIs0grwZTDcrEAukQkSpm9bMZHa6XB4OG87p
	zvz4hmB3bixU/LJWhLM1Rcem36ZhFqo4RRO6dKKHtzOz8uWm51hK1bIylnhFUHHNwpONtsXE2RF
	RsuHbIvCrXFq8tr+goiAWjNRNVsj4xorLTOQ8NX7ahx3n1wbot4RltCklWLueyF5nx87ANdEqsf
	lyQ6Rs8UI+RNbo/leAonEsO7s5F1IUhXNHm6LmSQJrr/uCQJD6OhsoiuVbO3WMUmw17r0gn6TbC
	SpFaxaT2LpcW2kd4t6l8mrO9krCaFRRO+maSRgdrC3aCXMfwkSMO0m6ndX5+7l3r7fvt1gLq191
	EwlAQ==
X-Received: by 2002:a05:6300:2204:b0:39b:fbb2:5e46 with SMTP id adf61e73a8af0-3b5e342bc24mr2324793637.40.1781171717811;
        Thu, 11 Jun 2026 02:55:17 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8658827a74sm1095337a12.31.2026.06.11.02.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:55:17 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 09:55:09 +0000
Message-ID: <20260611095509.19125-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
References: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 09:42:12AM +0200, Stefano Garzarella wrote:
> Okay, but VMCI still need to call vsock_add_pending() and
> sk_acceptq_added() in vmci_transport_recv_listen(), no?

Yes correct, vsock_add_pending() and sk_acceptq_added() stay in
recv_listen(). vsock_pending_to_accept() only replaces the
vsock_remove_pending() + vsock_enqueue_accept() calls in
recv_connecting_server() once the handshake completes.

So the v3 series will be 4 patches:
  1/4: introduce vsock_pending_to_accept()
  2/4: fold sk_acceptq_added() into vsock_add_pending()
  3/4: fold sk_acceptq_added() into vsock_enqueue_accept() (virtio/hyperv)
  4/4: fold sk_acceptq_removed() into vsock_remove_pending()

Raf
