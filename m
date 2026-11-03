Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704662;
	b=YUAdXGeE4RjC7dAkjx8HntEopjr9L8tFRVDQkWO5rnQ2RpoaTvawo5xGXfCfgUeDqcRh
	 z51fD4V5tIqIXUKpPqyWWbxFt0tw2koU9L86V+nRSGS3DiI8hV/qj1yPOecP0CamT35z/
	 7hb0DgZu3svDIW8Grvs+1AG2mVRrwpcJWySW91yzWBb1nH5QeIN5uo+6msIfS5x6s48L7
	 45rkdH0BU5qpLY/3dNzbNmOqGNcLOXPIXAoDLrqE2VnJB5DSSL47+jHI3iBTpf923UOCx
	 AJbVZzqVEfIAwx+RXRegTPnedLT/F1ayDi9VizPjxsekOaEH8IlbpdGIhWUg9F7mynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704662;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TKM19QPJ4Jj0dvfeqi6UnxgPl3NHO8xYpykL+RJDXAE=;
	b=ltUsb5eONf3TbOHJgU/A+xqJ0RpP+k+JR4UaUEu/PRFAQsoBmT8Hg+4q4y9CIN+fanow
	 H3eKspcTjFsU6JhWq0bvaKLqW9dvVnLGjZK7s08+jz4oJnDyvK1dmfF/d7XRqdHLD24i3
	 RiqaGSXNhWl+0edo6WD0Gd/GRV0SjaXavlUvnBb4feWsMDlSws6C7Enl+yqeiEQ60L/yp
	 l0BALNdnVhRdapr8+TkMlh33DMOP8mky5T7X2T2Mc5AUZNYw73CanROdiBH700M7X2mJQ
	 EVmHBjZYLrjFTj2FlWvj9u96D7uqR0RlVP/Z+K56uKJYg/kmfu9foDI52n8MC1f9O7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=P0EcXAcn;
	arc=none smtp.remote-ip=115.124.28.148
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D05606D80F
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 11:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D05606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=P0EcXAcn
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793704657; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TKM19QPJ4Jj0dvfeqi6UnxgPl3NHO8xYpykL+RJDXAE=;
	b=P0EcXAcnISjh32z1T6WwP79693WDdqGD8D1sftsLOjAhhg+1DJazQb28cJPmUwelJpJEEX0bhWp1v9uWrGUi9bLJph88AvOWSVC+JHKOGRRK7YYrMJAnAP8O5Oqz5XE83khhl21GKnJq3RBYyvGOQEMRvzy8rq5SkvgPKP01HnA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2805699|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0110284-0.00355894-0.985413;FP=18282358029834381283|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvnrQTN_1793704654;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvnrQTN_1793704654 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 19:17:36 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: mst@redhat.com
Cc: amit@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com
Subject: Re: [PATCH] virtio: console: check the control packet size before parsing it
Date: Tue,  3 Nov 2026 19:17:34 +0800
Message-ID: <20261103111734.472283-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103043238-mutt-send-email-mst@kernel.org>
References: <20261103043238-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You are right, the impact statement does not hold up: the reused
buffer still contains a previously valid control message, so a short
packet makes the driver parse stale - not attacker-controlled - data,
and that is not worth carrying an extra check for.  Please drop this
patch.

Sorry for the noise, and thanks for the review.
