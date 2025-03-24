Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51625EFA6
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842443; cv=none; b=K5AKrpb6PrACaR94qEs08DELfDUEPMZ2dtMd7zv+7iKpVGkqDKoCfVGt/iAxhFbnYZNe/7uPrzgckE+Nmwb5/oMGyodmyFu+1PVpZle9tqIeK3LzFkqPN7TyeT5i1LnrTk+vEi+LjtNHuylMpvRKlpL3ArKCFyenahKWONDLZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842443; c=relaxed/simple;
	bh=5Oc9X4WPpkb0I7xxxkTExY9Kqtnuab39zq/DpuRW+9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BwXJz9rRF9ZVSTvG12I4WFoIX4ALZxoRoErocLR3/hMl8d+0Y0guxRMgONcnap44ryqswG7/hLQ/2go9DHFi+E14eZNolSOPtVyoOxFZGSYvbtX+t+c46etRaQX4nX5EpC6IeTIWPEucAYPLljrpudw3wSfmM9Qzb2FLxsXN9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=An1HGXvN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="An1HGXvN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223f3357064so63073595ad.3
        for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742842441; x=1743447241; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Oc9X4WPpkb0I7xxxkTExY9Kqtnuab39zq/DpuRW+9k=;
        b=An1HGXvNoauhD2PRO4QCA5z9j2IKk2sApwt2ixMbqYepBJaqDeTja6c67AUR3NC6F3
         LQ+4xuJV4qQzqYw8Js8ziB7OEd3fsQgncm5r9uZ/rK3JZ5tDnDSGyyGyN3LtcGrDv4g5
         3+v6lHRiXJFv1lxgcp0xd89yFCqbkzYff9Z8qGRC1uyv86k6j69vNAJLop9Uh/HYQmn+
         mDzc3VRV9h4TF428kUmYaiAWBVG+a3ymOEZKWaEDOqgztI1k9vqEPiF/i8mchm91vqQ5
         ZiBkyK6jOaXWyCPsmsjx90b6bC7XehSZWFb68yNSIeICsFIfqeAZlyE5R15hb/BPauep
         ypbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842441; x=1743447241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Oc9X4WPpkb0I7xxxkTExY9Kqtnuab39zq/DpuRW+9k=;
        b=AA1Yd+nbxMyB6D3qNNxvigYBpGBJsvftY08a+7WhentN1LEwSTWzBTHYV6xjIsPBAR
         Q2Ka2Roa2t2RD44AlbbF9yI0EsoXKfPM1PM11xhqN8Z2cUFy6r9WgMzWXYaZcmlButDk
         5i81xEs0vWaZKP+VikaXTQVDdYaZRp3FXH5dDnaSmnvlIIVBUhZ+wbYTlZB1ZI8Nuctc
         he2oE2HuHZvj6zqWhaA4eTtHyo11fPfdUaoUYykMLiyxcDZjnyq/kP1JbPXmhe8kBhO8
         unOkpsNEPeGQVe0pcF4DA/GPuFf9ZdvjQyrkT9DvfeCbyz/Njq8aFydIL3zbW4Oyy5fb
         nvnA==
X-Forwarded-Encrypted: i=1; AJvYcCXvUXFEW/XBR4U1E1bjg9KmB4D12Beyi2aYyfoaUjOB1QAGoni/jP0o6IgMbbaHKqsAuv1a8TUkwl7a2md3CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKe6PgetK9Y8Bfqb89J66dL/bErMgObZ6dzIKNISyLUJ5EhkVr
	s+H9SVVf8sdIkOkao8iS0SG2bxiXMsKcnORBozuBaZ+kxO10PtwY3tbkoXNyk3FahcxtZkAnzLm
	6URsG7g==
X-Google-Smtp-Source: AGHT+IFgmKsprpaGDjxSOAFPcgtylxDFAlGJWR3zzYK2eH1W43TjKeWbEuCfuwWXukUdHLsJ/AaSlcsX4NnQ
X-Received: from plj11.prod.google.com ([2002:a17:902:c14b:b0:21f:651b:6fd6])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c9:b0:216:7926:8d69
 with SMTP id d9443c01a7336-22780e26127mr200986085ad.47.1742842441044; Mon, 24
 Mar 2025 11:54:01 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:53:53 +0000
In-Reply-To: <20250228014416.3925664-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250228014416.3925664-1-vannapurve@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324185353.1974105-1-afranji@google.com>
Subject: Re: [PATCH v7 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
From: Ryan Afranji <afranji@google.com>
To: vannapurve@google.com
Cc: ackerleytng@google.com, afranji@google.com, ajay.kaher@broadcom.com, 
	ak@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, bp@alien8.de, 
	chao.p.peng@linux.intel.com, dave.hansen@linux.intel.com, 
	erdemaktas@google.com, hpa@zytor.com, isaku.yamahata@gmail.com, 
	jgross@suse.com, jikos@kernel.org, jxgao@google.com, kai.huang@intel.com, 
	kees@kernel.org, kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com, 
	peterz@infradead.org, sagis@google.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, tony.luck@intel.com, 
	virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested with the specjbb2015 benchmark. It has heavy lock contention which leads
to many halt calls. TDX VMs suffered a poor score before this patchset.

Verified the major performance improvement with this patchset applied.

Tested-by: Ryan Afranji <afranji@google.com>
