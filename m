Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833724466D
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081046; cv=none; b=Tjpsg0eAgtn1xbYC8mvSFQXZYPAK+J2pH9CB2DH9WlD4iPlCTEriqXOP9DeLB5nNBCJdwKytcVSHN6R++2C3rZU7bELg2/UtckO3ZQ4TjR4iPb+fX+3T8hXdsKLE4kSb22VgB3meo4oIonOa4KtnabsANLCFWQ6QHx4QRtgo4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081046; c=relaxed/simple;
	bh=Jg+d4M7SD0tg1BCcESORZKIiOOrCQxdG8BTeosz9N8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CMFr9LQxGaVCR2fgmbNbSZb61/Joxz9aoTqgPVSE0HkPXL1cdRQ8qfaRE2K7qNX16mC1O4omsgRA/M0fmn1mJfEVh3pLnoWafe/63H6b8fEroFYA/yYSLgSeqncryGlBCnvtK0sYSuGu3fkAi8bT4qwd+PP5YAgywhJ/8S759Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8877131dec5so488399439f.2
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 00:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081044; x=1760685844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85c0lO31mJmxX7OG2HQ6romLReQO9OCVh5cFYAjQiA4=;
        b=QQ1LrWajh0fthLigoDeRMpPmRSUVKoEtSFIHHRr/aRzl8Be22Tf1WIpqzSpnYCNODP
         ZMWKn91Shpl98M5fQ4NE9TQE8Ibv4WwJ5AnKuRXhLarQMEZO9Kb6gP5ZgzBMDE4vl1em
         cCkPadMz+/EbF3La6ux5IRkd+/J1GVXvhbryv6ssRVepeLDWSm+tSYnhh4ZICn9RYiuF
         t0ppEArIC6yC1qhDl+hBhn+7gvQpz1DrpOukKOFGe2TXdMbaKy1rxukTstdUyYqma50R
         pG1XJpXJKxUY/2PlrmA4oX6hKZJm4+5oM5NPEp/+1hAHPrif63aoAy+/Av/EyP96Y7Lx
         GrOg==
X-Forwarded-Encrypted: i=1; AJvYcCWn9ss29oJ/OyDRGYXCzhCuntj60S9jHdwgXZriv5Rkab6Kv9K/47nWOZqmVTrABdSQRBWwUoblRusFFHX5og==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzix2U+uAvI8AXi3GhOVaoFmH2473KqsjejAjG3kP14a7Phcs+j
	EmlFPDPRDvOshpa/EA+AKNWdAhYkU0jUOkLWUVVfwVjUK4Oh5KljB6mBzVA+xI1JSUQLEA+wqaX
	JJfFSBHT6uCyyAojmMOuI+SYWVSs1b6Iy1VbsZuC9pXxNSzwhyRXymbCn1RI=
X-Google-Smtp-Source: AGHT+IH9YdmnB2MPeJu4hJxqiBrxo57sGfjXN0vwjr7W+/+/+p6zwPPzsFWiRrpzBzWe7uajTaaIEEhiQD3ZQbKbM5mUjQccgD7r
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1514:b0:8fc:2095:302b with SMTP id
 ca18e2360f4ac-93bd191f136mr1284776739f.16.1760081044336; Fri, 10 Oct 2025
 00:24:04 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:24:04 -0700
In-Reply-To: <20251010033310.8501-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8b494.050a0220.1186a4.0007.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from
 invalid context in __set_page_owner
From: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
To: ast@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com
Tested-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com

Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178251e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120851e2580000

Note: testing is done by a robot and is best-effort only.
