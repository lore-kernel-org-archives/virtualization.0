Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE01476CD5
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861173; cv=none; b=fRVCwPwyTmSwxaO9D1OnmLxu1fICVEgfUyFotE8Dnp2ijuad3UC0kJTRmtwn3rur9y7bMNOvBhdagi65uYwwk9/W2JAyRg6b2SHsa5ddoouZkSUxLePtTdAQh9OJnPU77twsQ6gJJyW8obshh3+0kzClmtV032RF1sZTHf/iX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861173; c=relaxed/simple;
	bh=roPTW6/U3j+BMwk4hvKJ5OSTXYAaGRPpbjPJHc+JEP4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=anTyuqJOyz2cvRICZ8P4m/zicXyn0HhILYjvpBivXZJlfzML11CyLDLBZxgs8nqOpkVA6xe6e33y0wBMNkxpBptuOf1MAJHxqycFu5s6xafyxqlSLMbH0+GyXn1BCsgtPh7bYMerjnB1NjEvZdDxh5K3ErYchDvFU7eZce5atBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Z924gvCF; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Z924gvCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785861141; x=1786465941; i=markus.elfring@web.de;
	bh=roPTW6/U3j+BMwk4hvKJ5OSTXYAaGRPpbjPJHc+JEP4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z924gvCFMMFRdOyKg1Dk4wdaapAy604IBdxhZ8kPR9LDXj0rjI0eRmXiwt7DanCZ
	 QJdVE2Cd7nm1DKOC3KAHteunBqXpKNUwfDt64xMT9KNKpsdUTfvOVXKns2fwC5iW3
	 bOCSdiQGTUJurGy3FV1x5iE+UZDcfXgo7KuI4cQL8+u8VrU5Ru7Wkgmzo9I7V9tKU
	 8hqn+xbNz5Lh8e8j5otthQ06qrqbBsxDid7FFas2EwXhnfHAPq0LCgbZn/uhTB8Pl
	 LRmw5du+Mw4VHISTljkNKpl4cwih4fFsWhSj1u7E4ywFklUQxPw2h6iqmug+jLh80
	 54F7KAsw+3PgB4wnAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzmv-1wa2KK3Fo1-00M3h7; Tue, 04
 Aug 2026 18:32:21 +0200
Message-ID: <c972f4a9-ed10-45bd-9541-25fa8d7b825a@web.de>
Date: Tue, 4 Aug 2026 18:32:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiong Weimin <xiongweimin@kylinos.cn>, virtualization@lists.linux.dev,
 Zhu Lingshan <lingshan.zhu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20260804092626.1344371-1-xiongweimin@kylinos.cn>
Subject: Re: [PATCH] vdpa: ifcvf: Put device on unsupported feature error
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260804092626.1344371-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZHSgCSSQWu8MO4siCPWpAdB2brKA+h71CAwU8RirkjkkyDwqkPJ
 jHyFu5e+YQud8K6QYlbzwMzNYJ6Wsiedl1vhuBH9gyDUfw6PGShnTMaru+lox6AQiVSNqVs
 J9CUqyt7224hFLfW6b2grJaOcEMkHRORWR+Nc7yhPccxUOiomaqeLli/8PRfeVn20la8Uln
 Dmp5siwFeWfZsNN+sX71g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s1Arbht0fzY=;Gz0as7WlVgJH8UhVzbp6qg35PQ/
 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
 u51

> Route unsupported provisioned features through the common error path aft=
er
> vdpa_alloc_device() so the allocated device and adapter pointer are
> released consistently.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc6#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc6#n34


Regards,
Markus
