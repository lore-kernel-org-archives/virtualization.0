Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62936FB9
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876718; cv=none; b=JzaLL+WrBJgpbmRMZb/qIHNu4e2+QfoHVvAe/FUOcZFQ+j/3hpnOhowe4LOcJXpTvs6YbBqyDCjDA5DVlCjm/Sjf7zmmZROQ0Bwg2p6MUuAPnurRa8famZxL3800lJuAciuLwyZNFLCy6Ip4UJUuTWRIKUKseSvy1bnS+H52E0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876718; c=relaxed/simple;
	bh=Ra3d4yk79GRZayeWZZmeTZHAUr1GECTgXY/nJ5YTfco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JljyvZWdLyTqnLr4/7KLEcENNXiP/yY5W55CIQe+Tb7oWmJl3tKWg4UBo9UUTU9Nq6MC+fUn5kKhAbncxelhmuO1bFoA7dfaZX/XMkCAKDuNkK5Ayw/KHPdYSZKia/0XNVs+pUxMq2cp839p7CvJFeUza1Qh93j8cDmXMizkBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Iv1hdlXK; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Iv1hdlXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752876714;
	bh=/07EaF41gnn4gEnfBX30qAY9V6Nyv0EgPAskka0SJFg=;
	h=From:Subject:Date:Message-ID;
	b=Iv1hdlXK5Zdbubj7qRgpEbvtNVZy2+m20W0MFokgKCdZgcBvog/IRM/HleVyOXwju
	 B9a5SF6T0W3oFkUuHqy+43BPBssBYc7gZ0ZbKE/lLtunGnCJot/jSD9iNr7HFsWVir
	 BH4zuEXD7ewL3oo5kQyUB61nGEtOzehbVEpfHxSg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 687AC6A400005A43; Fri, 19 Jul 2025 06:11:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6668606816158
X-SMAIL-UIID: BD9A24E909A44BBEA68488125BCB5FA3-20250719-061149-1
From: Hillf Danton <hdanton@sina.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio Peterz <eperezma@redhat.com>,
	Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH] vhost/net: Replace wait_queue with completion in ubufs reference
Date: Sat, 19 Jul 2025 06:11:36 +0800
Message-ID: <20250718221137.2432-1-hdanton@sina.com>
In-Reply-To: <20250718132414.1572292-1-kniv@yandex-team.ru>
References: <20250718124657.2394-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 16:24:14 +0300 Nikolay Kuratov wrote:
> > reinit after wait, so the chance for missing wakeup still exists.
> 
> Can you please provide more details on this? Yes, it is reinit after wait,

The missing wakeup exists if complete_all() is used in combination with
reinit after wait, with nothing to do with vhost.

Your patch was checked simply because of reinit, which hints the chance for
mess in mind without exception.

Of course feel free to prove that missing wakeup disappears in vhost
even if reinit is deployed.

> but wait should not be concurrent. I checked multiple code pathes towards
> vhost_net_flush(), they're all protected by device mutex, except
> vhost_net_release(). In case of vhost_net_release() - it would be a
> problem itself if it was called in parallel with some ioctl on a device?
> 
> Also rationale for this is that put_and_wait() is waiting for zero
> refcount condition. Zero refcount means that after put_and_wait() calling
> thread is the only owner of an ubufs structure. If multiple threads got
> ubufs structure with zero refcount - how either thread can be sure that
> another one is not free'ing it?
> 
> 
