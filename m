Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19810A1F
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715578; cv=none; b=EZH2yEMjisD+qcHTNodDgiFXx4i0DZQmmzB29g/OTSu/w1kTXfjEHuOQLuqCldBmLXVz2uva0Usn9xZqrSXQd2W6SQp1MpTct/XWZxv1m3pAFZ0xUxPod8xOi1CwTwh62SdqYg7EqDL9HgoirrxRRP8G7W3YE53igjZRgiIryKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715578; c=relaxed/simple;
	bh=gxAUpE8VBN7v0rV0nMnestBQ5EL+ueS4F4ZJIgcrVHA=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=UG1fmhr8Im8AjgIxlQN+RT9W4MMh2C0a/seAsDQ6JnjOnGlA4Dd/1nH8Ju0UvZiOkatW46Te3Gh785xaEtCA/H7LDCGuyLL7y+kE3eESiSIB1NpcNWSJc35UzzlZswVRpHtj12K5Np+eTsG1M2t2auqEV4IJWL7tVKLP9RHGD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bjFcX5h0Vz8Xs6x;
	Thu, 17 Jul 2025 09:26:04 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 56H1PoN0037389;
	Thu, 17 Jul 2025 09:25:50 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 17 Jul 2025 09:25:51 +0800 (CST)
Date: Thu, 17 Jul 2025 09:25:51 +0800 (CST)
X-Zmail-TransId: 2af96878511fffffffffe78-dc0f4
X-Mailer: Zmail v1.0
Message-ID: <20250717092551456yMDDlrv0yFKFOsnqotOlG@zte.com.cn>
In-Reply-To: <20250716095046-mutt-send-email-mst@kernel.org>
References: 20250705105803198ff11jYCkg1TxntcCEb00R@zte.com.cn,20250716095046-mutt-send-email-mst@kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <mst@redhat.com>
Cc: <jasowang@redhat.com>, <krzk@kernel.org>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gdmlydGlvOiBVcGRhdGUga2VybmVsZG9jIGluIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19kbWFfYnVmLmM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56H1PoN0037389
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: jiang.peng9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 17 Jul 2025 09:26:04 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6878512C.000/4bjFcX5h0Vz8Xs6x

> The extra documentation unfortunately just mechanically repeats what the
> code does. Code comments should explain the reasoning behind the code,
> instead.

Thanks for the helpful feedback - I appreciate you taking the time to review this.

In v3 I'll:

1.Remove the parentheses from function names to match virtio conventions;

2.Simplify all descriptions to focus on purpose rather than repeating code mechanics;

3.Consolidate return value documentation to essential information only.

The revised patch will maintain W=1 warning fixes while aligning with the kernel's documentation philosophy. I'll send the update shortly.

Best regards,
Peng Jiang
