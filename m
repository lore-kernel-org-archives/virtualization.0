Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82D1CAA8
	for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083249; cv=none; b=rdomA1E7fM3LTqid0pSXE/c8JlHyQ6l87wLpcM2zEcCv+u8yZ0B8omSC6p2YkB0WxNuJbZrleEV7Gqh243YMqyNJQa7Cq2j30t6I5ADst3sqRb2/nmQkOyNB9ybp3WguGN4qP3komJT4qGPU7jQnoSbLH4xGPOfSPc6C9BV4JA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083249; c=relaxed/simple;
	bh=g9g7W9dRjFnnmcIhBA8COuq//kRWVgC968TWF7npr3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMA1KQlUKrlPDQmg9U3dhgpcVrccneQy5vnQNp/LoK9M9IB1eFylejidIUihpODpSukpd7LPf2oQfSokN4Sa3UzUjd7h2uJ/aglhpT4mLci8HVyaTJ9kVyKSludb52RsWZ1iB/u54tTaNBRZj4pdOqPQOjX7TX3xpgsGySpY8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=t26R2MBY; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="t26R2MBY"
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vvBdrWaH5A2vSvvBdrpztt; Sun, 14 Apr 2024 10:26:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713083167;
	bh=E/95b58pRdlETX2FBhKOQ8sHn6Id8wFl4e2YyFmV+PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=t26R2MBYEryhnb3fr0GVe0bUrJSy66cl3pnhuzUjxJEHnCzJLilAmM2tmOQOLpU2r
	 TB+MGsHq8MOHayvTnsqMJ7iioHNDMtW+/zRVjT4WsBp9Dka4Ej/CA3W3NfCTuZzkqs
	 1a8dMOXIxnq9rL2PMHeJ0t8ImzTNivavt/3feGOIb6OcjG+NafjZkjM9LgG8BlqRvC
	 /lKaH6iDFG83QiddAQatJ9/Dr3ZN4lrRnybefJcn2k4vSvOFaP+4KEhgNO/EiPnVA5
	 A9vLR60pr7GsnLzK4psbK2GKL5jgkh0/AwH+POJtjbKVdQGhBYS0nQPGTBUH9nTE3O
	 da8rtH49+TejA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 10:26:07 +0200
X-ME-IP: 86.243.17.157
Message-ID: <93a3a465-01b1-4ca6-9b77-55d1024ae88a@wanadoo.fr>
Date: Sun, 14 Apr 2024 10:26:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
To: Simon Horman <horms@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>
 <20240116145727.GT392144@kernel.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240116145727.GT392144@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/01/2024 à 15:57, Simon Horman a écrit :
> On Mon, Jan 15, 2024 at 09:35:50PM +0100, Christophe JAILLET wrote:
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> Note that the upper limit of ida_simple_get() is exclusive, buInputt the one of
>> ida_alloc_max() is inclusive. So a -1 has been added when needed.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> 
> 

Hi,

polite reminder ;-)

CJ
