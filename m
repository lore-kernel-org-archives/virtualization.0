Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0650278
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549867; cv=none; b=b8OXr6u+J+wdPhB6tfj0Tf5B/Ys0VG3gDJkmof4AKNquMCHinaS1WpGsQO8AupRxZbTW59pVrhsX2xd6gmzCVoR27CCXUKD2tnsYnE/kbYkIcn3rhzThg/pKXHzLHg5X4GCPSZodVCmVq2O3ZWjEO8Q/qhM2r7zMF/qeQ9Dvxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549867; c=relaxed/simple;
	bh=Nvscq/NT9/+j/DykFVg7/tQ7d07STWFJVXZA2SanBcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyWx26Umeza9ovOBrpF009vPJe8vHl47rFbOBYPH0I5e6micSGnMJcnxGvXKeYtRA9+hDNcteIZ7uMPSUYDPcyG2+SslJojQnP+GHuEzGjpOa86/r8OSBqJXuO/b9zr+9I17PzuN3/AvdLVo96gYMdE/xkIONZ+oy9dW0jujp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.115])
	by sina.com (172.16.235.24) with ESMTP
	id 6631F45C00003840; Wed, 1 May 2024 15:50:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 99969545089450
X-SMAIL-UIID: 6B92299AF328438ABAD25F19B01E92F2-20240501-155054-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not be accessed in vhost_task_fn
Date: Wed,  1 May 2024 15:50:57 +0800
Message-Id: <20240501075057.1670-1-hdanton@sina.com>
In-Reply-To: <20240501020057-mutt-send-email-mst@kernel.org>
References: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com> <20240501001544.1606-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 May 2024 02:01:20 -0400 Michael S. Tsirkin <mst@redhat.com>
> 
> and then it failed testing.
> 
So did my patch [1] but then the reason was spotted [2,3]

[1] https://lore.kernel.org/lkml/20240430110209.4310-1-hdanton@sina.com/
[2] https://lore.kernel.org/lkml/20240430225005.4368-1-hdanton@sina.com/
[3] https://lore.kernel.org/lkml/000000000000a7f8470617589ff2@google.com/
