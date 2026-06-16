Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBA3A2549
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621055; cv=none; b=gwbN4/ONVHVhRDGTdLs6FCJbxHu8M+/84gCLUWQJLHbOxaxLbWqJ/ya2H4xcQNAXJgMFrQrjloUn0nU8W7VnCo0Yt8QNtIb3d2xFwKrb5odrr5BgyyaWtcYbVEPYA4mXaYw2F3trsydxg1VS3gsAGwZS574RPeBK05XcMcD59mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621055; c=relaxed/simple;
	bh=bHpCRDwckh4ub9wb+5WPyyqdykBdrDJa1C49QS5Ex64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFxw4hBUq4hWfNsYrGRUq1k1L6g0kvUCNlWhHAnD2kvaS+DGsDGO/srRLVl1f8ODzC+yzeX+6qnh8rUbj7vWao+lgTxhVkMRlV0hsp/e4YlOFqnK+yqES4pZAISJ6Dfg6FMUZc/mfyGSftbGrkNdsBzBO7n4KUY3fBbLoZDxmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q/rU24z7; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q/rU24z7"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9639130b20fso2645274241.3
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781621052; x=1782225852; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9y9SsmX6da4zCwczs56RZQXAobBsGViVr/AE0Fsa594=;
        b=q/rU24z71hGsaCf39xuKZFI3NblO0yjwl6q6biVwlp4HdGkggZVn3LANJUa9fn3Xya
         kqKz+LECZmNVePMxRYmeWGmNFwICe76TqIuHjzICQN6dYykD4NVMD4qkgOS9j62z+tkl
         yEra+v3i7Hsh/+mjc3UvJM5Sr7+GY8X24md0CMK4sUObFtuLyMKp5YzPIdzwqC+yV4J8
         WbJZsNO9PahX7GHF/YiGcIGe2G3jPDYZBMnFIT/aE13dV4SshYMObpYSdTTNdbzGISbC
         9ZuO/261HtEOz48i6PZzep99Sgdea9hufW2735KL/CaYJhzjXQdwi14i7Qjy7Aeo+T3R
         eAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621052; x=1782225852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y9SsmX6da4zCwczs56RZQXAobBsGViVr/AE0Fsa594=;
        b=CeXCOtDLVfUoYBI4ZWM0GV9asTNCyuET3WY4ITEU5zdQwn6EBrLX5Mln+ielSozkFH
         MDVS2Y2WEmM5liJTEebYddu56lO9QoFsLU9CSWoEg9PDiBqzd+R5zTBqq01v6CEzMkvT
         INz0cKFSMbew1md7cGP7fmQyXagEUEPKyUCJKMyqEKIDeOtnfQazCM5bH90Fz0JGyxdg
         wISHKn1wGlQ/AjrAGComneMQxQjufremg6hjiHTWayTebVi6Vbgs830LbbGF1eIOU31U
         +7TOtz798WIz6xUcMsXTz5N+g8c3mM4x7iBWVjm90T75X7Xjn2S2U99yPUt0G0AY8HpH
         5hIA==
X-Gm-Message-State: AOJu0YyCBvjYQelGJr30Sh+4wRZ0wJdAAlGrBeosXUMa0F0JhH+A1JHn
	XivUZuBZ+Sc3AFrLNaqvTQX9HmxlYj6bYvro4Hvvbz9TWrASwdUMMWL2dUdJUSurNVg=
X-Gm-Gg: Acq92OG1V2HYUQ/Ax/TqbYxk1XfJyLPXKjwpmL5b0OvEOvuetAkciy2L3kigaHGOxuj
	rLAXLhC6+GJ73G6EvAWIg6otZfGqytFaYzoTGCs+pZfHXaTRgrGQMsHJ2eR3DQHI6BZMDwW6vwf
	thtTsnu93DawIHntfRLj5nV0LQERfh5SJdCSfvzl8/0HI5sn0BpooZ7pudVdrEWa+V42SDOzRe+
	qm5PxRswvwmvZePzGaAaeKra+C0xlSwvKEC2eb8motXpo3VMvcE771CWjFS/GHlIfw8aYciH6BE
	V/KEek8vlmOlaAknFrLKQudnX9Uk7Q9KJn9PqU2urGYsljyeZkyhQdtZ8tvjvL3XN/J27EdqD2+
	WDyvlGG3AycYVam2oqX2fvEER92FErG1n4+oSBuyZj7JeMdZBwhWtwho/1kJtJNEq6PhkkKFvN0
	1o4R5Wuza8gj/06xw//0DW
X-Received: by 2002:a05:6102:c49:b0:6ce:7e04:ddae with SMTP id ada2fe7eead31-722da09df95mr2055640137.18.1781621051871;
        Tue, 16 Jun 2026 07:44:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:a3aa])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fd1sm1484310085a.11.2026.06.16.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:44:11 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:44:09 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, hannes@cmpxchg.org,
	surenb@google.com, peterz@infradead.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com
Subject: Re: [RFC PATCH 2/2] virtio-balloon: add stats push mode
Message-ID: <ajFhOa5kEkPfqPVD@gourry-fedora-PF4VCD3F>
References: <20260513165006.2790857-1-gourry@gourry.net>
 <20260513165006.2790857-3-gourry@gourry.net>
 <feee7831-aa82-4f02-b5e4-cffe7818dc65@kernel.org>
 <ajFWRhSNsOBoUfb5@gourry-fedora-PF4VCD3F>
 <4d8ddf50-e032-44a9-84d4-ddf2cd0c5bf6@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8ddf50-e032-44a9-84d4-ddf2cd0c5bf6@kernel.org>

On Tue, Jun 16, 2026 at 04:32:46PM +0200, David Hildenbrand (Arm) wrote:
> On 6/16/26 15:57, Gregory Price wrote:
> > 
> > Definitely an RFC here because I'm not sure if I was missing something
> > that might help me solve the problem.
> 
> Well, in QEMU we just run a timer internally that does the polling.
> 
> Then, upper layers in the stack can ask QEMU for the latest stats.
> 
> There, you just get the stats along with a "last-update" timestamp.
>

That makes sense, although don't you just push the blocking operation
into yet another thread on the host?

Assuming it's not cancel-able, there's a blocked thread there you have
to reap.  Vs the guest being unresponsive and not sending updates, you
just reap the whole guest or take some other corrective action.

I suppose to the orchestrator reaping QEMU and reaping the guest looks
the same.  The difference is just where the thread lives, hmmmm

I'll make a note to inspect QEMU's solution to see if that's handled
or if it would be subject to the same issue.

Thanks!
~Gregory
