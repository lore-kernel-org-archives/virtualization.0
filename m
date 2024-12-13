Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3A1DFD86
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092358; cv=none; b=KH6gZsYfW12MYQFqwqgX+zPK/aSTobv3roc6z18U+yQgSvr0/M1/N90evqJcA2XQdrBBvnbeRzXV89zqDBsrTErojCmJWMNWk9n3mCSRVDRTYERsfDThQlvPn7yiEgrwOHo7z5zZ83VOSjoPBN+uTIpa7I5KITlCEQfTUoWMIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092358; c=relaxed/simple;
	bh=+agX/hxnK7PsbXVWPwKhiB1V054xuEENK8nIoWK3fi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7JYXvk1ArpU2E23GBkNh5Z3t//l0jGMlgxNcqiu0TuugJjg2NL1SfqjjuLzc19PlY+AJmfyId8dqtGURmVAx+49e4rNyGxM+5mTsiHG0W+ScmKiopBb9bS7U1qd8k5rntKrymIi4ZaYbJDcHm6dAbq0gia2g5kkIV3ifkNVYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aEphx9n; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aEphx9n"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6837480D36
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 12:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -15.102
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5TEp-z0ABXmD for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Dec 2024 12:19:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=edumazet@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 34B1580BBA
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34B1580BBA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=3aEphx9n
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34B1580BBA
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 12:19:15 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so2876632a12.2
        for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734092353; x=1734697153; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rswNLiWFuDKiW42rbnE3/FFvogIGFwro7QX3xwapVa8=;
        b=3aEphx9nMFoh/M7/76eljVBl4Y0jUDP1KT9HHSOkK3QJ/Shno8TIomIW9ejyIhQWbz
         9NHtCWV8BIu6yvPeqW0CSZsxifEElyUXYeNaxyv4ar5ZWpi6ouPLO85h2QCGD2Mw9CdU
         keH3BY6yH/aCBahbj6cr6K3X7M7TCvWxBOp+vWuPSgCq4ez5tLbo0hZauFrYZhBVjoN7
         yxziu5c24pKXsEtRf3GvJWnQ5LLeZ3vKrjmleipz8sCJWJY/X8NqEvcSrnKJbuRssMPT
         HQ09HZ30KY9XhLjxc8ucSJt+7d/dAvg6T+zRVY+7jtk7fkoZ+wP/rUoCEOEEXRUuWOqx
         ptqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734092353; x=1734697153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rswNLiWFuDKiW42rbnE3/FFvogIGFwro7QX3xwapVa8=;
        b=Z1VTcFK6xAU7iVk25vtolPYw22aFrBZi1szQHj0J/LTY7m2VzBT72I6gioW6guqihK
         xOnnO/IW070rNl6yLbpSRb8VyYwx+Z+fDKT+r65IE8P6fbGv0xADlGXCICq4b62VXnyC
         9EEP48PHn3wLjd4/mIn0CC7c877aWcriKR0ybHY/g0jQ9gFXRGmGzS609d9YO2es2o4X
         hLaSBZaomT1t2A3dY/e1Fl/QmQzXIJX5aI2IiI+oyJV/B1sj7fnEzpqoptx7a5hV/tYf
         vD4LHY9lZtPaXCjYSYexwbQCZU7RTzO7CZylLqxommqyyXchqyLD+UR1saDhIk0WIhYe
         NwqA==
X-Forwarded-Encrypted: i=1; AJvYcCVHGGmqUBIomtWblj+o1AH0E38v60Tvzk1MN5BMJAOYPTJ6scwTM242xleNnEFpkOObGBDnK4P/Gfdem+tvbg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzaPGjyLIGFCccufMESHIKfZKQ4nP9i/V1iNeHBGOdN7/YMAJnJ
	F9YG3uDui8acS/RbrB2WglWs2TjuMkrF1qJ2Qe/E+kuqYTyCNxJWjHJbhphsXGiKt4fun1bBAZi
	hi6rDTNP47BXXW4gMfkcg2AkSmwLbRkgtPISz
X-Gm-Gg: ASbGncvId92QViOrJDlJgBpcqBMDF7FHjq7MBGjB8uqPkDDGEajy8291eEF0vlTqRHK
	BE2bHAE8J+6FDM2f2uDNCUsKfoV3z3Orv8w7g7g==
X-Google-Smtp-Source: AGHT+IGRpkdDBASQbA4W9W4t1BgK2dSzLTzvJG9Vc9UhANfCeYe2U4Z/qo2tMOoP0ps7OytKBednRAPV6i81BAZBwaE=
X-Received: by 2002:a05:6402:2790:b0:5d0:b51c:8478 with SMTP id
 4fb4d7f45d1cf-5d63c3158c3mr1721305a12.12.1734092352701; Fri, 13 Dec 2024
 04:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <675b61aa.050a0220.599f4.00bb.GAE@google.com> <675c1dc6.050a0220.17d782.000c.GAE@google.com>
In-Reply-To: <675c1dc6.050a0220.17d782.000c.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Dec 2024 13:19:01 +0100
Message-ID: <CANn89i+Zm_0a5jqtsL5m-S4=E06mdQXA8RLaFEF75Y6umFWxpQ@mail.gmail.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
To: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
Cc: alsa-devel@alsa-project.org, asml.silence@gmail.com, axboe@kernel.dk, 
	clm@fb.com, davem@davemloft.net, dennis.dalessandro@cornelisnetworks.com, 
	dsterba@suse.com, eric.dumazet@gmail.com, horms@kernel.org, 
	io-uring@vger.kernel.org, jasowang@redhat.com, jdamato@fastly.com, 
	jgg@ziepe.ca, jmaloy@redhat.com, josef@toxicpanda.com, kuba@kernel.org, 
	kvm@vger.kernel.org, leon@kernel.org, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, miklos@szeredi.hu, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	pbonzini@redhat.com, perex@perex.cz, stable@vger.kernel.org, 
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, tiwai@suse.com, 
	viro@zeniv.linux.org.uk, virtualization@lists.linux-foundation.org, 
	ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:43=E2=80=AFPM syzbot
<syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit de4f5fed3f231a8ff4790bf52975f847b95b85ea
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Mar 29 14:52:15 2023 +0000
>
>     iov_iter: add iter_iovec() helper
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1742473058=
0000
> start commit:   96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
> git tree:       net-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14c2473058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c2473058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1362a5aee630f=
f34
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4f66250f6663c0c=
1d67e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D166944f8580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1287ecdf98000=
0
>
> Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
> Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Great, thanks syzbot.

Patch is under review :

https://patchwork.kernel.org/project/netdevbpf/patch/20241212222247.724674-=
1-edumazet@google.com/
