Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F521ADAE
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111067; cv=none; b=kyYr/jseNgxpq9Z4ggqzxoPBIHVcHoJdVcuTtzkD4qCGj2Enc83vQ0C+fvm+kmbYu4PiW/rWvatSy6nvyZnsxoJwYqywt0eyyDAuvSb7v+q3y1NmNRW2XgLp62n3qiW+ISCv+Nl4P9xSGkLoq2H2YtZF9HeFn75+EN0L09puznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111067; c=relaxed/simple;
	bh=3bA+vF5JVbmC0TnjptRY4rNilWV3bxvP9R94bb5l30E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Rme4MeMJA0hOT2hFm2WZKpi2Szoee64SZCbv9EYytCitdJWNU6VD6G1eViBuaaRmRY2ikRPkvSXDzUv1B5sXr6UFzJ1b/jrQa4S0diSb1ItCpQT3HKURzw+gvvg9Fzac98gW6okI/mYUu6sQM7ZCEzj6S7MYVZ8O9UsVzvM5pQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bEZ7rxTS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bEZ7rxTS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E8B9419EF
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 11:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.592
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eEHk-i1bGJbe for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Apr 2025 11:17:41 +0000 (UTC)
X-Greylist: delayed 330 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 08 Apr 2025 11:17:40 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1D19141A58
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D19141A58
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=bEZ7rxTS
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D19141A58
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744111056; x=1744715856; i=markus.elfring@web.de;
	bh=qW4+zeMTplvB06ndGSbY7x8YIfv7UeLRUmB1CtDRzyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bEZ7rxTSOz736sZzFqQn6P/PZKpOr62RE4VakJhKiNroSm2Kc1obQ73ORfrwjgZT
	 ZUBvlJWQY0OIDaztAQ1+ZKlgW3OcP76VSHqK+vC6KTXUnC3Bw53q2tmdcvaPQjdKy
	 AhqmErgmYMy+jrLqE6IeTykvMhgpyQ0Cp8kSlRVUTVnuQgZRq0SydBY30GIwkmJvJ
	 X4a/cPIVyj0aDWpE4btE/oV0YgcAH+rDe7mrpThJDlDIPnenkH3M7lH1Opspoo62l
	 E6slZK30pF7Z/PgEhf+bvPtcSlVhVOpsGd0JwC/AVcwzD9ZXxkIOX0/o32K2JLS5d
	 TU5TTDWVTJNFZUdO9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.41]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1typcg3iV2-00GmSL; Tue, 08
 Apr 2025 13:12:06 +0200
Message-ID: <377e2597-fc15-473d-a191-15281c6c4149@web.de>
Date: Tue, 8 Apr 2025 13:11:56 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250328100359.1306072-4-lulu@redhat.com>
Subject: Re: [PATCH v8 3/8] vhost: Add the cgroup related function
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250328100359.1306072-4-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UlJYAawipnbT5ZM/bbEThLglIdknanN63vVE3V7Hn+4+qkYtUgz
 sE7aaLgutmAhXuf/9PkW/jRAXLbP4EQxBNEo3oTgQSJeelUvsofQvOG8PLLwKERWGl3gKvu
 Tb89+UTofWmNHFT6ME8l60YegHktrxQ3jIf8ykDsSMx2EmzMwW7xt+PgXbh7Ngh2rb2RG5X
 G3p3+g2WX8jawMbH0H7Ag==
UI-OutboundReport: notjunk:1;M01:P0:42fKllgdVCg=;gkzvr0BFcuDpz9NcKyNWzrOwRbs
 /AcRvLKzPNewQY2NuLQ/2C61Haqu0Z8kupAmcXFmPVa7H5EAjJaIWYWMuYiWtUhR2EdvCVXko
 qLjTfWm7okWPMU5jvKm87WFqTHZKgFqovjfibiOjR6efgoXYo1bkdBLZobjqs29BEKajHzY7s
 nKYEZz0GP4O1fSiBBkXf+HQOI6Zz+ItYH50n8sXnNAFCToK/9qWwp/r2pc1GHpKpnI5LU7OIz
 iakPpyvTvCJFQPP76rXUvDlleweo6/1DiJslIDLiDAB6XzsZhe3mg3qB/n8AhtxZfSD1gKbBJ
 sJgjgVWL6UrkO2hOV/DWzFBNuRY1elPJ0szG4huOYaTxA9NB7b4M3cnktIgBhi71T2Htctl64
 +idpZjRReef8yShR7Pz+WUBmXoQE7+DaC1We87mmFrwft6OVuc7bZvXDJo5IfxfOW+vuZcWqr
 uBI287540b/ulO4jiEIcLvf+3oe+g5rjQUFdaR4o1yI7NAqks4EBMyGiBKgwJAjJrHaC+5ZVU
 nso4w/48KO0acW5NC8J9s8+CboeJj723iBptEGmiYjMsXko0wOFhFu/v+qdG/drEvPKjlz8Nd
 QzKwRG9/Myh2EDsyPrwm6SI1LSRHoWUTm/0dfTV0Nk8+ExrSKnZ3bIzuNcjSY16yjtmM+9o4n
 uWjOs8XlvLiJARV4JfN8gtnQYKG+rfYq4PQshKbHNPqFGzXfAcCqiXAPUhbW+WEyDcGRPb6DE
 Ngheho6Ox8zzthnKCGKWHgW/wUfAaQftKPGeH+5D45mkNU6X5WuMwXrzA5LtnQZP4kF/KdZPw
 hD0diWdsIJ0mmT6tNFj31/wGJAfFMILwmECDsgwtp/dyhIWJf8i+Ure0d0TqZuJyYazt00dgn
 yx9EEwmeMQH0GEzYi4qcsywS2Pu6ppd0zmXSfapRNYGRMxhSVzn9ZiVSIwZShTvHHTga+SrVl
 o1QHkZAcb2wNfCmeXZaTnOPmfgLg9TAyWgEyBBoY0fepOMCe7TybqiUpLCHIvuKNFrysWpH8Y
 eu8ZS6tv/QVnfbFiVc0jr4bQZrqEl10e5jNmefxY4S0mZmAB48dehrJFLuCYE+CDkWmfkCqwg
 1Nnj9GDn3r5kuGHOaVYCDr2NhqsXCk2fK23ulxV2Unw1D+PqYnnV8WvPBkhQ0EEUiNX7wmhwr
 xWTROWRlJnd6wlfH84uV2oNDGmAVvT6a0CgVQPpqD9XDy7kWOEMGByUYc5y5CQ1vfZNNrBweY
 DmAeyWICQ8pPv+M2dBH3qo5/UFR+vXRYXpuuOEisqDtcAi3ss0pvZRKiICiyX1c/yDGKOQl0v
 kQVX6eEwbDEtjJKwDJzsdXVvPYsGk8QiNovngKeumKDnnhrK1Ti1+peX59ZNrbqiYIaZk4Bt7
 QS+DMTx9wZop0xFIErAfWDADuKbQK1yq0V+0FIuiCX4FIsd2cwtfO4bUEE/1MV5V3/dkSCTJd
 zntiZ8p1uBk8nsJImzDYRqJQH2IFwv6N74Ki4y2rUhjxEUgWf

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
> +	mutex_unlock(&worker->mutex);
> +
> +	return attach.ret;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&worker->mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.14-rc6/source/include/linux/mutex.h#L2=
01

Regards,
Markus
