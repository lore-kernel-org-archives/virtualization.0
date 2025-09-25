Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FE2E8E00
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784745; cv=none; b=ovq2iJR3L/3zsHT/ROkR6mNZ0lsVkWH96w6v2NqoVH9E4q1Op71ktyoDLxOqseojW0szCpKFOGYbdI8YkyYJCEZ6Z44TqmfS7UMKLndL8P56No/9dBLiljX3+pF3g1zwq8G56rL5syruAQrR4yJqnujkM+vxNzqaWYiIh3G3Xog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784745; c=relaxed/simple;
	bh=Ka6Xvi4Yww6lCaGWo00VHFXKK6uSJ9eN8nTKNsJT8aM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Vxkytro8Ok4tTj/lWZSyODbMqbaDzFbq6C854Iu67q2bcVWr5ykutLKCLHmzkaFnC2f1xePR1dmmF7t3r0BOZvq62x/sDMFVIiOnouEXdwqw+adZpRQ8XsgBdtpY3L4LglZA6VXAipndj4YJ+4KeMTkQmhyVERGmmjzaF/hlcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8936161680bso68206139f.0
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 00:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784742; x=1759389542;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka6Xvi4Yww6lCaGWo00VHFXKK6uSJ9eN8nTKNsJT8aM=;
        b=HSZDNHd27IOy63y3FiBOoXOy70OaUJJMtS48uOjLsPNCVMWKTajnWc6KSVHcjC7YpU
         HPj+28x79oAujVDWhwJfXMJj1D+Me8h4HHQCbiBr6nVYAeczJiP0qXzuZCuYdAzQnihE
         D9PeunPDfsjDRfxr/Lc8LAbJreAk51urRcsUqOn69Jea5WreWLbAdHcqwNqxYMte6UOm
         6CApcGpgm3dRWWqYkFpet3zzJOaz+hql5TdxZv3zhJpjqb+R957jMRBwKYNXq2zwjFnO
         /0Anwl2HuKThiXtT7RQ5ROAc8Xt3vsaQInx320/wJxTh/L4O7dZ2Fsa8GqN6PDJ1vSKq
         XiUA==
X-Forwarded-Encrypted: i=1; AJvYcCUn28E77Aa3QPb7LlJ4oUvIi8kx4qGltpyZMk4dYbfq35qoTC+4muZE1IPItifXp7moMquY+M9p6QWq9Py4zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNvAiH/W53OqNcVq9+64ltWkLXQJUDGWzi8EaeBiOiAKfCqDv1
	fBalyFHSt1YH/dilKnhU5c+LiVhVYlHuTs5EBwr4W1GHGlK95DvdE8b4j1eVYtKUCO+xr7kvgWx
	atLJ1ojuQRZ4Mm8+FkQeGlxr/dZ6fvW9Q08uQtBnIGemsZ8YacO3O4E4yawI=
X-Google-Smtp-Source: AGHT+IFhvykbd4EPbrKfpqQ6rCbpWctQsXUWlvAS1AXrjYMd7F7GLkmW3ZINEeZTv6e4obpuAhGzkd+zVdFxfjKZ2tBjxKdeeQcI
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:424:7ef5:aeb with SMTP id
 e9e14a558f8ab-4259563befbmr33661665ab.17.1758784742302; Thu, 25 Sep 2025
 00:19:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:19:02 -0700
In-Reply-To: <CANpmjNM7cCDoLUGV4J+MfAbQFedmEXhNrhf7fYiFs7Gi7Yz0mg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4ece6.a00a0220.303701.0004.GAE@google.com>
Subject: Re: Re: [syzbot ci] Re: fixes two virtio-net related bugs.
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: elver@google.com
Cc: alvaro.karsz@solid-run.com, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, elver@google.com, eperezma@redhat.com, 
	hengqi@linux.alibaba.com, jasowang@redhat.com, jiri@resnulli.us, 
	kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, willemb@google.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"


Failed to process the command. Contact syzkaller@googlegroups.com.

