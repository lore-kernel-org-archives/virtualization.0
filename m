Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA828000A
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605391; cv=none; b=nJwaPgQFo8vyhZ5NyNjwh7ByncAVSunSkU1CPQXVkw+zzGQN647frcQpiL2YlUegI0wYsHf0yni8vt7eVXnApnRMOQjzYwJBoLbWGgdukY8TTpH4Sq4X9sXO/Km3so8BEs7Jt2cdUVEhlzzFww8fWSRisu9Y0QxLhfkEeix9T+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605391; c=relaxed/simple;
	bh=iFd9GaUwBZZ8hKLWk61RAMzqE4jTygDop/hnKYS6V/4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BDvpjzDbjep5bCk9vHm15Snbv4m9sLfeKXX2QCUBfltlqnzO+x5DMzPB5KlhiaXxXWGEpBXIeIJQ5PcOb5K0mD6pgHjhdb0r+S7Goz6jYM86MPE/jL9FNJLACKw9gMPPjmxf1/uhECJPxVxiovMMGY+QuOReh+Hwvk0qrQN7cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=A/t48Lhb; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="A/t48Lhb"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3D6340B87
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 18:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.488
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ULX7o84f9LGV for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jul 2025 18:49:48 +0000 (UTC)
X-Greylist: delayed 322 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 15 Jul 2025 18:49:47 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B4C3D40ACF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4C3D40ACF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=A/t48Lhb
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4C3D40ACF
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752605385; x=1753210185; i=markus.elfring@web.de;
	bh=tkko6bLjsxZ5JFjBU07V5JcT/pFFwCD8KRbhylid18U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A/t48Lhbr/csNuHUh5JEpqytdptf0ku9jcruFsaKzq2oVsYZ7YC6Z9QbYIT/VNwa
	 tyzOmyFSe3ApNuoeQJ28zcMgZHoUQpT2gNHvOizMrKgDu+cJ56RvIHfpbF4067fBq
	 GFCPHgTs9OEIZhXMBU1njaicz3jXMc/o7WCRgDUWrWGkSBA0EP8wKLoeHQ3/+NTLU
	 JSWG48lBcXeHqYKa6UYVHSWLuQLiUqkcZtNtUfEMI2boFRc8zwxS9Y2eI73YWEJDq
	 qhzx+rqRozr5Nr3WCmx/MAxpXdnWSl5uwSQ7safaQ/pPocAVcqfbzjOqQ8L5zJFx3
	 VLB0FE672MsJfTLvrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nig-1uYTua0Uhw-00GfnV; Tue, 15
 Jul 2025 20:43:48 +0200
Message-ID: <9dd21a72-9451-4b77-9ab4-d9b31b408e25@web.de>
Date: Tue, 15 Jul 2025 20:43:45 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250714071333.59794-2-lulu@redhat.com>
Subject: Re: [PATCH v13] vhost: Reintroduces support of kthread API and adds
 mode selection
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250714071333.59794-2-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sUaZL8+JVg34mBLItXeLK8kPlW/5K4UgwziQgnDobooT3ypkWjw
 mNyDGVqJP6mhZHiKJRaDutRDxX9lezBc77EWyGJKkFwdt/eD1eydQw+u2Wpd16gRiGuLwxK
 IhDQLYvllls+kgePQASUFNNu9sVgyvl40jHkK6hDiJ3LvnAfl7SGmTgCc+MUiHFiMX1s+7F
 BI+3Ec1rYau9E/6TgaLbA==
UI-OutboundReport: notjunk:1;M01:P0:aFIhqEv7IXg=;1Gtf5Sw6f7b1xlf7nw+QEt/jDww
 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
 TRNGrms6UadIPyEjQVSnMv+7EiJR1M8vorD

> This patch reintroduces kthread mode for vhost workers and provides
> configuration to select between kthread and task worker.
=E2=80=A6

Is there a need to reconsider the relevance once more for the presented
cover letter?


=E2=80=A6
> +++ b/drivers/vhost/vhost.c
=E2=80=A6
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
=E2=80=A6
> +	vhost_worker_queue(worker, &attach.work);
> +
> +	mutex_lock(&worker->mutex);
=E2=80=A6
> +	worker->attachment_cnt =3D saved_cnt;
> +
> +	mutex_unlock(&worker->mutex);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&worker->mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L2=
25

Regards,
Markus
