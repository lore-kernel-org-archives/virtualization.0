Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502014;
	b=qHFaFNL2KGwcAAkx4CBis8PwYZQZZVBlGiFJ6ojYkoTYxxkzKroQNf0oPFJlvUVgIxMe
	 MLveXz/6nzZCKxt1gQjYXkzLKP3aMgCkCPhC9Nn+KJOiqyTpddB4eORjjW/tkcHqzPfqK
	 sU26wPh4GaHrKw+MxP/y7daWadtWxaSc2wXdjdzAU3XGraxaJOxiEHMsQPLZLgogi/lq9
	 wYwqJgPLM8HbPXm+2V84S6V7rJE6HpzX9g+PxXLlKt9srOvC56P4F5a5U+ntgjHoY0YBY
	 5/hu72U8RvNp3CtQ199NZtV7DQhKvdU1YWy6eHBv0U273uVjM2r1DyJr+zVFBr/OLCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502014;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=+7tqArStNBb6UzWOhpgCNro6Nr4m1kw0/PjhJKGYy3U=;
	b=kqUjMdtWXOSSSfpYdnRsdxXJoLUWZkeGWzevq4WlOBPwVHH5tzjt8Y8ypOdoik0/wJDU
	 TxxDbCh4WxWuGzLtBc7QnAYX9Syz2PMK/5NVBX6vxTWHbgQsx7Y94bLvLrf37+wMrvzLQ
	 gChdk51fpiBL6HpPMVeGR5dxDh1ByCuu5BZHaOl9/sHUV4Sq/6EZXLfr5UX/E6lwar/sl
	 ywtwr5F60ukpxcUiFjjJPXUYvc2jkqfpPkDO12fABGhPGqiEAWCYs5sJAA/BDHRDTXQ+s
	 RCeLazZmNunnLhL12n01/TUe6GL+W1Ys07B1jeJ5ElVX+rCHoMF+UrnEzywPM76afIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=W9cvOe1S;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC768606A326
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 03:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC768606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=W9cvOe1S
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A11wvZs2697238
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 20:00:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=+7tqArStNBb6UzWOhpgCNro6Nr4m1kw0/PjhJ
	KGYy3U=; b=W9cvOe1SMaIvNcvf7RfKbQOs/stp++R8dHDRsAj+aPqtErtPzNJ86
	cDIt7TsSfEZh5Rbb+wIlosutUtbS/ipiN8g/AC0MzF/o0gpKiXMoEuQ81I86VHO8
	AS6Asa5odsJcnL5cIA1gUsEzZwHuzLm+r+6ounuJeLW7WZK9PrWUI8d3BI1CDHds
	ztRvMvX7cGK5NU/rPzr2EFubZUo2Lm/JK57zb0Td+uBysyn2N2fU7p3SkKS6HFT/
	JzyfTsh18chx9aizem1PKKoRCnjp3XmzaH/SO4Nc8nUq+SX4Bew3mYXYxnZUNNUU
	rWK+HMlRkwXJXBLq2lHalpgmZgQw/RuJw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hn2wddmx6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 20:00:12 -0700 (PDT)
Received: from twshared119346.16.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Sun, 1 Nov 2026 03:00:10 +0000
Received: by devvm18200.frc0.facebook.com (Postfix, from userid 352338)
	id 8E6ED6E47EF20; Sat, 31 Oct 2026 19:59:57 -0700 (PDT)
From: Murat Seker <muratseker@meta.com>
To: <muratseker@meta.com>
CC: <amit@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <rusty@rustcorp.com.au>,
        <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_console: add console port to list before hvc_alloc()
Date: Sat, 31 Oct 2026 19:59:55 -0700
Message-ID: <20261101025955.3870851-1-muratseker@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101022435.3466820-1-muratseker@meta.com>
References: <20261101022435.3466820-1-muratseker@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: y3a3MgMZa2FKQGLtoFi_hL9iNpdJ1-ny
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAxMSBTYWx0ZWRfXytUdWcAfeSKq
 CjohA++uBqp2AcmRxgbK7UP1Di3RNbskI4Ak/ixAUW3wMQ94zit/ytRxe8GMUG8t9mnXidzCpsH
 CAqMxScjaSDnFhEW5uUhJ0kWdyyy75c=
X-Proofpoint-GUID: y3a3MgMZa2FKQGLtoFi_hL9iNpdJ1-ny
X-Authority-Analysis: v=2.4 cv=G6OJgNk5 c=1 sm=1 tr=0 ts=6ae6ab3c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=jLPmfgFi0iO_3v1wpOMA:9 a=QYH75iMubAgA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAxMSBTYWx0ZWRfX5kkae/nqH5jp
 uQ/RfL7nA2OG7Nzas/dt2r34AU0y809v/HmxnbN+1js7M0SadO19lHDLB8qUthSx9ROhnAQaT1G
 5+ukyzMwiJuNfLpxKC1wx0Qe4qXHvO26g20eTZsVHO/TNKaGIlnts5aquthUti17nvcyHF2880z
 ArAw5VH5KNugf9ObxE+XxaWX/aC634TIvsBz+5rq0Er1wcZ9joYTfjVMI7b8QwEunee5qR2cK8W
 PliGTX9uxvcaepQkR1OQvdjOmpIPfQqoIEmMLsNjUChdJ2nl1VJ1mFfZe5n7PiAwNVMSe9CYre0
 qcjBwQP2KoXmnUV60C4Wjvk8gpJVTER6XG7uVyZQ/whM5fBQBkiuu6bdFg2S86J+yo4sdUXXnHd
 OZ/+x80bw1RUH2dMqxDWa7zP/YL6PQ3ARJCLnEmRETsxhlJet7dA+HwIwyJ2jJ655WWYQ7+FDTv
 iHACkP89qfm6FlvG0RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_01,2026-10-21_02,2025-10-01_01

On Sat, 31 Oct 2026 19:24:35 -0700, Murat Seker wrote:
> Subject: [PATCH] virtio_console: add console port to list before hvc_al=
loc()

Please disregard this patch. I'll send a different fix.

Sorry for the noise.
Murat Seker
