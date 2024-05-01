Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3320ED9
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522586; cv=none; b=pcIivLpWCrOPn8Z/tWGwKNfZvS3E2aCgnzrInNIC2X/TCmjIOIUh5auKyKyNdvYW+EcZmJ+CPIHkaWe7ll/O+pUDVESS7vMsHj3kEeXELLTv8l6Pbo+nc+7TBrFAcLVBdWdgOZ9qudnvvXnUFGqwIRSVJHjb0X0BZCfjhaOySwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522586; c=relaxed/simple;
	bh=nL5c8XNclkvqZv1Vzc756f7bzufCJeq11kAFTQAbigI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgA8BrF9Fv2a4D6q5ZdmwHptnjQLLKMVqMAANSTkWeocqc3z88p8zv/rKA62RvUhoy/A122PpzRoax4Jmc0tWNHbm0z2z89hL58OmiTi5W9U5acbg/u7ti8PfgLnGTimPNKN+k6CUrhuraFZUfnupAkSGkuG5e/NJKgKlEHMZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.115])
	by sina.com (172.16.235.24) with ESMTP
	id 663189AB00000C1A; Wed, 1 May 2024 08:15:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 72843945089313
X-SMAIL-UIID: 7A00621F2F04402EAA292C9DDB7F6377-20240501-081542-1
From: Hillf Danton <hdanton@sina.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not be accessed in vhost_task_fn
Date: Wed,  1 May 2024 08:15:44 +0800
Message-Id: <20240501001544.1606-1-hdanton@sina.com>
In-Reply-To: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> >  static int vhost_task_fn(void *data)
> >  {
> >  	struct vhost_task *vtsk = data;
> > @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> >  			schedule();
> >  	}
> >  
> > -	mutex_lock(&vtsk->exit_mutex);
> > +	mutex_lock(&exit_mutex);
> >  	/*
> >  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> >  	 * When the vhost layer has called vhost_task_stop it's already stopped
> > @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> >  		vtsk->handle_sigkill(vtsk->data);
> >  	}
> >  	complete(&vtsk->exited);
> > -	mutex_unlock(&vtsk->exit_mutex);
> > +	mutex_unlock(&exit_mutex);
> >  
> 
> Edward, thanks for the patch. I think though I just needed to swap the
> order of the calls above.
> 
> Instead of:
> 
> complete(&vtsk->exited);
> mutex_unlock(&vtsk->exit_mutex);
> 
> it should have been:
> 
> mutex_unlock(&vtsk->exit_mutex);
> complete(&vtsk->exited);

JFYI Edward did it [1]

[1] https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/
> 
> If my analysis is correct, then Michael do you want me to resubmit a
> patch on top of your vhost branch or resubmit the entire patchset?
