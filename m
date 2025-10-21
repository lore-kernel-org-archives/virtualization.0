Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193372EFDB7
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041464; cv=none; b=seeebj+RkOH1YzrV5YAbeFsDsnIZdUf3HikmKWzm4F0kSyOSKKAVYyMN9xVAmE9ALfp/uAhDcsKdMcO1MCwGtgMebLIMm9k7vlHfE9s/WILMemjnN3lPNn1hSyFvTv4Q9SNhXIRgJwnEpzH1XgKwIFQaH9wxgcSA3I43zVPusrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041464; c=relaxed/simple;
	bh=vpXQiflVU7E/srPq9JfjysqPUwZeetf3iBJFxoNFNfA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hv08sx6+II871cLYjznmQ8+62+3x7WoVoOEhtq0rtO63t8tAmacPaGjq+BkP8E5SrGPk/i0O0VxI9rUFKYZ8KYkrFueUUGUqCVMH+2fyhzpBA/pc2Maa6D/lgb7zas/YS4/rKBF+sbIXAK4BfPqiTyJRHF4Q87VN+Jx+JSzrJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso1625238139f.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041462; x=1761646262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijl+KuktG6GVPgjZkCiCYwgydFvbdcvzoiJcnFOxm7I=;
        b=QZoGF44MFYl1NlgdPHmF4kU3dZLYOTkrlliYfLjV9t3W/lmTK20+3gCiPeXe2nk5mm
         F1m8UZc4fG4irT6ygNeGMWYFlt+ltCs5Ej/AgrWFmzdCA1Dn5WN2IiFb1J6A9gGpp99i
         1JZ1dnL0pQ0N3dGUG7PA8X5qha7x09DRElbWCLGYq14RohZEtfDUXifTfUyzFodwEP3h
         xWy5DABhzlRMktglx0nctj8t9Zn7Ggb+/FqV4hymI9jncmmu6ATa3edbfLkGmQvineYx
         oWlIJvByvgKSRkmIlXk4KSoUHfc/ox7mAZQI95lnppw2Vw6Pt/S1pOiQT4nDoeAnuNPV
         IDjg==
X-Forwarded-Encrypted: i=1; AJvYcCXwiwQw4vGnufx9PQ/3JMXtwWo17l41xrij46fu8PtdGZRrSHV4qgdisnO8fXjymTAMkWruTjfxSmPlOi4DPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwafgDMeSsEolZRSsCCnPPfLsfEcr90Exc3IZLE6+9qBQ5NrH8E
	XViXtZsxLkHQkDF/KM6COUaNIDHjQG7yE0jdHhH/E/h8vYTsQiYcl6KHv5kT0QGmns8Vcu+0CNO
	TiZ7LLFqHUWJZMsj3EN0rQXke7cXrS/8O+VRl6CD8k7Q3mdE7uuVkegtO9gc=
X-Google-Smtp-Source: AGHT+IFO/PptUIaZovR6keuCooSX+DOI1vkk7sEagxXGmiTLgzZnl5FSVhzaAIb+vmqRsREXvQCYmlgS7kfKa9KhO/ZMeJlBHq+0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:718a:b0:893:65c1:a018 with SMTP id
 ca18e2360f4ac-93e7627ad1fmr2655618139f.3.1761041462284; Tue, 21 Oct 2025
 03:11:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:11:02 -0700
In-Reply-To: <mpv4ljrxyucr23x4hj7k7s4vmtvv3bgeq7uct3t44ghaw35l4r@wanp7mklhw7x>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f75c36.a70a0220.3bf6c6.0003.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mhal@rbox.co, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/vmw_vsock/af_vsock.c
patch: **** unexpected end of file in patch



Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17204e7c580000

