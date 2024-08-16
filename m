Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14561C231B
	for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831836; cv=none; b=mYYQM6kvAKZHcgYZKyfFNh6daPTesa0ioIuZ++6dHPj4QSwMofCxFgxfzNf/1+7sRJ2+djMXQIgjiIZV/w44OXe4vojs57+dw8unRciKyHCv3gidgQA8a9dsCMWkjPLLu43/T+T0kyu0X54RkW8KMF3JNyz8+fweeR6yJcBUCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831836; c=relaxed/simple;
	bh=xHQoPuqd+D9OllJ85LC8A6kuHS0jVMOrx5MVSJ99RK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r4cBlL4rEXsuDeivYY8gEnYukvTeKc/yePeDdbleU/vQHaNn88DHhEMeeyvOz0G+DUW7ujULW0kOy284h44eWDQdZdfFDuyrkY82hX1wySePmB+tMWpgyxF7htlyNLTkmI8z/k+mvY9ak5NNMh4VBi7xDaVM1DsAvXf+9DKHp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNIqOrA2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNIqOrA2"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ad78c1a019so2067382a12.2
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723831834; x=1724436634; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKLhc9rN0MWqFTzo18sKWvguSCEcuhqaVkCHFGI4wZg=;
        b=BNIqOrA2rkGy4SIMgRMktYs3N3TTLMbNfqZmQszQk+kluowVFKZx+O6W7Ybxyqdv6J
         WSyXYcRZjRgTY0eJLgtlaKcUhbhqFwzxbgfQq5wpuPhaJOAo3LY1jhiWa3WDB0XZyWp/
         vCB8GzgB9qRQ5dUQ1rbsbQZ94CROErKhFi47jnER2KYBtXnAtFMePZ4S6XQ6N0kG1A0J
         c264bAMgrdIsbeXvv5Sw13aDfDv4qlDC5sqITwT7iYG6/e6RBOf4gfrnJKZsULJz9zNs
         jnh4y7D9vU4WYW3E3ipflCIA05AY8dNSvuZfnho3srZ2u46nBVxmgFx9GcKgNX8NDvTo
         nW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831834; x=1724436634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKLhc9rN0MWqFTzo18sKWvguSCEcuhqaVkCHFGI4wZg=;
        b=htY8534vql0jlQzXf2KV/SnQRJgB+6Pqxcl1W9Iq/QP68I6+oaIZqGc48OMJ4iY+yy
         hgyiY9O1RmT4cVfdzvhbvrgNo2FhRzjT3BqL6NGEpOQY9+0+v+bse+XPCpRZlX7Zqt8T
         UKDqGAltojazn6wHDYpqolmAC5PYeYqzHpvuYNlo3mt/iRs5HeKnO8Gjb2wTs0NeA2x5
         93uYWxiXIhV37/P2RwZO6r0JDSaiJrr/0/x97CT49Vuk61971KyAgusYeD7yp+NACRJV
         CH8s2za8ULzYyWWorW67BlMVmvnKsDT4Xl47pXmRUnH83Xl1B3qU5spdvp1SROkG+XXs
         0zcA==
X-Forwarded-Encrypted: i=1; AJvYcCV2BCnUu+YBl+WH3xLAv4bNC/e31sEC0mHAvvTAQhLTqii0fQHcbQMlwKORCH/Q0sIK4Hy1SjGrIG0SASLvVHkbt3+YeAJG/XXSXgTJxas=
X-Gm-Message-State: AOJu0YxHhOUswwXjeMmQFzbJarrpb6TYPgOt2CEeay/hqmGiSWOP57q+
	X3iD20EAVVt3s1RHB5KR58lYeVtKxQuI+Na+bHHyZNfCWm4w8e9QXhSNCcKOfZ4VdCmN3yEUROy
	A2A==
X-Google-Smtp-Source: AGHT+IETDCf7j3tWXi0l8Zbb8sKAD0O6am89PjJGOYdyX0iluckeLErw8vyRXlL+vHPvSkgy+0M3cMXJJsI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:622:b0:7c6:b68e:de7e with SMTP id
 41be03b00d2f7-7c97ad6bbd0mr6141a12.6.1723831834162; Fri, 16 Aug 2024 11:10:34
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:10:32 -0700
In-Reply-To: <000000000000fd6343061fd0d012@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <Zr-VGSRrn0PDafoF@google.com> <000000000000fd6343061fd0d012@google.com>
Message-ID: <Zr-WGJtLd3eAJTTW@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 16, 2024, syzbot wrote:
> > On Wed, May 29, 2024, syzbot wrote:
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >> 
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >> 
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com
> >
> > #syz unset kvm
> 
> The following labels did not exist: kvm

Hrm, looks like there's no unset for a single subsytem, so:

#syz set subsystems: net,virt
