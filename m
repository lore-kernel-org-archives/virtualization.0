Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0099522EFF
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865162; cv=none; b=sYo7+Wi1MVODAS1TS4oplbMGzVdAO8RsnqTO2swifziAYPDGdL7HCSmI3XgzxbsMU77zjFzdHPbUGZrPMv+I12rh3vdh9QFjbvE/RNJTr3M15isHs/vgOzbEzW7zyygmC6usaVH4IH+cATm/mYNDw20I+OWbTDdSh1R/uYHQXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865162; c=relaxed/simple;
	bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm+Ry+xmy9NCLrsbc1gt6y7GCr0MS9QeZHsKZkxkDsyKfUWZCV/l55QbvCZ/xu5Pb7hlkIH/bmr2PX34r4S8DrGXOo3DHxXL1BeQ8Di+ZPi2GZP1vWuor6WCrrE7njlVXyz9mBzNltFurWNgHM1xprPwZtUfOy/0Q1IAfwfVnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0YUujc7; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0YUujc7"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so2878755a12.3
        for <virtualization@lists.linux.dev>; Thu, 01 Oct 2026 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865155; x=1791469955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
        b=H0YUujc7eeT3s14xiXX1LapqCJ5FdU4NKyBRsH3LaLBoekMavn5aIVm01eqyza5FmI
         88xFdi4/4q92whirkr2ACnylyqi2VdDexRbkNPV+YzowoDwQAVfs28ExEneFSqH6TRQ4
         BhTWdYW9UY02i9oeTI/yhHyACtsPm1mDboFW1K9ipcjL7xLWeFpIdU88HIO45AuaqJdT
         8/FqMU43DxhhLcFaALwZg/+xHWS9Bdo8JoELXOTB6fRDMg2y8cZwpUmX76jL4x1LB9j0
         WX4hhrP9QlGYlhAH5Mr0s+xjjNJdBJ/pUted6MCU1ZgXnSB2I6Yi+x1jXvFBuom7sdY0
         6RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865155; x=1791469955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
        b=C5hOfaFie8SH30Jg+H4vWt6boCsnDDow1x/cIsqjUtTadTFKt+ODtJP1jAv+GTqWEq
         1BEJ/vejIkkAEaL+lPnw2+ZXk2sAkIptK7VvLqVEO9ep0ILcMhqhu3Ki7sQjh5k5v/ag
         s9ZYJk7wP2uofkWB2ETnljZF6u3BataG+gMGEknVZM18Tdlzl1rW46S8dmySzaOi2kf5
         fAll0H3BX3J4NROl2s6FqeQ0b6RwlWoU1zacQIF4zkAN8+XfoukbsJqTPnX0L6ChdgLZ
         XwDo+TepTR/Kjo7HYrgvtQf/aUyopyMdrTyNyP3fGRtzO5VjceglSQRm23qx/WB9DiPr
         64jg==
X-Forwarded-Encrypted: i=1; AKwUvByQTqM2WBGxkYA64BwSwSKNN3Y7TKgOGjAAcZzGLfPhUsfcHgk3YlkUVE2KrrG2oyIh3FCyW63tqBDqKjAFTQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIu0ddN/1wxoYAFovScwKIZMAEWjoCfn142Jqb7lAbw8On5zZO4
	F2MFtSaK2QKrlVEkB2fZOuA9CkbyLyr7DIDKEEVGfh/HG/OUf4mevWXC
X-Gm-Gg: AYBFou2WZvR+gm1PSLAZT7EWyLsbD4vyVClylNfJJI1BOsoY5BB/ETVbsMrggbvvxqf
	p+dnVh++TO1l2kUwljDFISdJi/T7K5E7LF76CraailyoMDiWhdeoXQDMsmM1BfN8alVOzqNFfTi
	rHims2Ud0PPCE5m3ysBug+if5mYn4W1+o+1R9YU6SYLUNXA3JI3McBSlK4mf6yPmLy75lqWXsvA
	dMHVskeQt3UTyBp1G5h82KNz3Qj/EPMrP7OzF750+9mod84Nath0v6mLBzUgWP97MUwrSeMh1qc
	OIRvuhumKtm2xQKqcHs0k9ktR2ychOmBbRw6sEdYgcTT0cHXMHRDFWQztZW2ZoxdmPYoAMMh9kI
	CdHbp4v1bbu3cOxCz1JCDDspE2BlK3BK6xteOt1cujwhHBkGGhOms5uu9ZTTLkFXoHDlwLCm9HL
	g0aLRsa6VOO+jUqtFZ1hhro+/uqteGzkb94znAez9cQwK2yOp100bpWVtaKXgwjG7oGuJ1KQbpF
	IUrPjOVGqw=
X-Received: by 2002:a17:90b:2b44:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3a4d1509d61mr3979683a91.18.1790865155377;
        Thu, 01 Oct 2026 07:32:35 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e750sm4964487a91.13.2026.10.01.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:32:34 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: account only unread bytes in read_skb()
Date: Thu,  1 Oct 2026 23:32:21 +0900
Message-ID: <20261001143221.3856511-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179085716831.31693.13222203434770065965@kernel.org>
References: <20261001121541.2983379-1-4ncienth@gmail.com> <179085716831.31693.13222203434770065965@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. I found this during an LLM-assisted manual source audit of VSOCK
receive accounting while re-evaluating virtio_transport_read_skb() after
CVE-2024-50169. I then confirmed it on vulnerable and fixed kernels using a
connected CID_LOCAL stream and a real SK_SKB/SOCKMAP verdict path.

Thanks,
Daehyeon
