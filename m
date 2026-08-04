Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053C48095D
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862513; cv=none; b=XFgvocPr5pFlt38qCqODfRSlRhFIQf1KMFuP3+/AJd6/URFCHTeVuPYG6L00rjNoM0NwGbJizV7swm09JnqPqobaeTsQT4/mri1L/F4hsFZCbqn531Zebmdquz6P/tkTJCLggSLvGoDHpH0l/FOWeCmQ1G+VEjdtCqaj3ZXzGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862513; c=relaxed/simple;
	bh=sUflDJsYbvjnmffCTcUZnBvrA7EFjekOT8diZeLjw3s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=j0CpoB/xdDzzmbOHs1dGhQrfDn4gn3HtKRTzj93mgKGwkCFypw9pazrhmBrA2KGvTz41b7eqGqebaXMQSdNtZHV2keodCQ/8G4FalCywwsknIPX2RPAMDla2dTqf90bYIrPI66XX/4eGUvljpnnyUlgOYaherDMt8jpLm2CaFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=s+Shy3+f; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="s+Shy3+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785862470; x=1786467270; i=markus.elfring@web.de;
	bh=sUflDJsYbvjnmffCTcUZnBvrA7EFjekOT8diZeLjw3s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s+Shy3+fQ3Ommi29U7545lYncz6XP6Sd6W6AZPwJJaD8qer+qL/3joOUEcDfF+rs
	 E4udupQ6ihSx7nTj11P7sOhymzqvo62RPokKzUwUpUAb0IHIWNCkSs9CLba2Ynv4b
	 dbP8inFqKcEaUj3hQElQqVaSs2kE1wCgvhLANtg1LuoTdF5C2+X0pmqwk66GYQE7g
	 0nJP0P1KFkeZC/eC9bm6nNJzprnTC+dBZyopJdbQLC3f7rsWQhzTLritAMumnIuNt
	 yr/gAWLlrtY8ae/y7CKxgupv3/55T20lDjwVZZmGIT5hE5BQyHFItcfEHn1DHTOM+
	 EBEfiTYO3hujlOodjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1wTBxW0bmq-00UMxB; Tue, 04
 Aug 2026 18:54:30 +0200
Message-ID: <c592a594-b2cf-46c5-98d0-2935b9a5ebab@web.de>
Date: Tue, 4 Aug 2026 18:54:24 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiong Weimin <xiongweimin@kylinos.cn>, virtualization@lists.linux.dev,
 Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20260804092617.1344317-1-xiongweimin@kylinos.cn>
Subject: Re: [PATCH] vdpa: solidrun: Free IRQs after request failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260804092617.1344317-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yG5IB3e2j5RYnUQLASnT0Vwaljw2dRrLrRDq9k2s8JZVDlfr/93
 7EnIKYFvSJMuU7Ipj2AX/hhXwq2iAx6tEUkPlzjxFNHzwF/JUjbejrOhyNIQPAEvZByVZKu
 C5JyixMBJFdJOlahD0S9PYAattLgiu19THNIv2gKVhCb+HCOpxwanaRQwfrtctMcY94fi8x
 tGz/bXe+1yVeZVyeaI7jQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WdetAtDezVI=;tfaH7rJjDcxwZm61exvgS5cVtia
 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
 KH/

> Unwind any IRQs already requested by snet_request_irqs() before returning
> an error so a later retry starts from a clean state.

How good does a proposed snet_free_irqs(snet) call fit to previous devm_request_irq() calls?


I suggest to avoid duplicate exception handling code for affected cases.

Regards,
Markus
