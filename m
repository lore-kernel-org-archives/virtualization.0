Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC515351C14
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618251; cv=none; b=q7fvnrqSg3q/MKOHElPpc/kUI//7E7n8klqEX0vEdQVn4ZHYZUG+eCWtAkHxDCiFGBhJQYQ3EO/hAi84e2g+xOTeKILqKfAoB31KBiSqftHEnM9LQybGSU3qyTwdaqYvEsiQqK5ICiGgEWEL4TWmIJkMQoHUX6z685oB6QVXvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618251; c=relaxed/simple;
	bh=bxcq8XVvLvRb2QMDpderqYCbiU3FJspLGdpwGMLxIQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3IMs1L+aYzS4xVEf0UB+Qe38DSdKMkSFs/vxKXSQoTvqqkXF932QTEU4M2li/rf3ZRejofc7Gs8N8O++C9hmg+K0uC0ptpLM19iTQzYb2ioypc12aJULFBWaZuZg8NWDRhIouzKtzsfUvqjTsqjs5Jo5a7idjf5SpSSQWUNS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HmbbOShx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HmbbOShx"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so69200326d6.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781618249; x=1782223049; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYWyDql/Cg87tBDufvcG34GqN5pKohUk/nA1HD30SzE=;
        b=HmbbOShxniUVzi6UU0vvYbl4zFShJGIoYgdPS3Dt4m677K0hWdTdrJT9evhUWyc16n
         R+o18zlBLzrduoLJGUOO+Y+P3em1WvZ3/4nDfOguw+I3yISApR7ERjmUl/8ecomOrIda
         Bcp+gE+Sr1x2wkb0oomuwUqZQ2W5V/iEpOv5pmXM0F4FHGbugYFDItbkBI70QxG/Qqqo
         QhhIi0/DMTNRwI3HiM55MLhiLYj8oIBRjfiWozAU49khreHiYFJFJJbzgKxbw9ckEXrt
         MB6aDvvAtYAC8n6F2+t4hO+o/WuyOO6sqwE4+2ASTx3rGi9mL5a8kkMQj16i5lM9PFrb
         wbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781618249; x=1782223049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYWyDql/Cg87tBDufvcG34GqN5pKohUk/nA1HD30SzE=;
        b=URFTWvCHZpZnFMP0ExtRr66eaXVkF1Ju3Tm5GMTJBMaDHAvHz7HDOYXwQLdtPF559W
         hJRZh2sfZJW7xWFaHXIJc/h0lO2OGZMezFrRV7MDd3MNMlkrFehIod2C42e5pG1GdSpI
         UrDalWzWiR/QQ/9fariMaisQhb67J19foJ+b8V0HtLJHyalQz02oZjiVSyJRDn0PIyCy
         pmdMu2A+oVUec/ST0+GF7eSV1mBWU/UxnHyTuQixQSVvxnumS7CzuV043JPSwHEKcLF9
         yb7NpMNGwdoVDEjRBWkQBCNzCxgQAfNbjiy8VXHGhI+y2TIrrbyqEqOblze0QSS/VsTW
         ywBA==
X-Gm-Message-State: AOJu0YzC8l6BAL/srmB8wR/IJpGtvmTM67dzFfFpwVZuDn81eXR1+SZK
	gUi9eZoa68Qjgc0HsP9cWIbaZFyQOlwPWE1T68QdgdoFTMkiDBNY6VG29KAJOLqV/Qc=
X-Gm-Gg: Acq92OGj1/TmmivUTrQFhfFTSRLw1CWlLojtb2PJ2m1bW595TgO8MXGqw51b/i2Kp9R
	4+4Rewq7VXPqu48gkindt+lARslxDnRTwPviN6tJS/xWMGPco4wJ1/BqhegWJS7zf26hjLBWQtV
	I4967ZNSLWu/a6rvjKRsJyciB3gPl7wpdFEx5BGOXLF3klCtXmDhgyJ5gfzyFr7eMAeG05w1PJV
	YFzxHvbj27ETppHX1UAtVIQj+BNRUbEC8QZq/vrZ35UGjBCtZQBNsphV8B8xnAqcMFzHYB9gnPt
	Rb9Ca+vRiMQr6tQVP1ZIse3Ds5iZrtbADF6LEGwW91ityKQmsDMr0SSywsGECjFHDhHQLw67csV
	/AY5hkK2QjQyC71qmdq9CVZknreoVMIHVG19Hv8YgcrusqwLWciu9ffHWDo/b2eaRlBofISQOWe
	chGFMuUEbKRBu5HGiKvcxVJzA2Vof0x2k=
X-Received: by 2002:a05:6214:5008:b0:8cc:2a92:11b6 with SMTP id 6a1803df08f44-8d44c5acd58mr247438456d6.9.1781618248553;
        Tue, 16 Jun 2026 06:57:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:437e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f1fb4bdasm32959256d6.20.2026.06.16.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:57:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:57:26 -0400
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
Message-ID: <ajFWRhSNsOBoUfb5@gourry-fedora-PF4VCD3F>
References: <20260513165006.2790857-1-gourry@gourry.net>
 <20260513165006.2790857-3-gourry@gourry.net>
 <feee7831-aa82-4f02-b5e4-cffe7818dc65@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feee7831-aa82-4f02-b5e4-cffe7818dc65@kernel.org>

On Tue, Jun 16, 2026 at 02:33:43PM +0200, David Hildenbrand (Arm) wrote:
> On 5/13/26 18:50, Gregory Price wrote:
> > 
> > The pull model remains available and is the default.
> 
> I don't quite see the big benefit here, really: either it's a timer in the
> hypervisor or a timer in the VM. A slow VM will, in either model, delay the
> update of stats.
> 
> If you need some "liveness detection", is virtio-balloon stats updates really
> the right mechanism?
> 
> I don't quite understand the "Latency-sensitive consumers" problem. If the VM is
> slow, it is slow and will mess with latency-sensitive consumers in either way?
>

Latency sensitive here should probably be defined as "Does not like
blocking operations".  This was prototyped in the context of
cloud-hypervisor [1] and an orchestrator trying poll 1000 VMs on a
single machine for stats. 

The poller couldn't determine the difference between "guest is slow" and
"guest is hung" and so had to block on the operation (I didn't see how
to solve this async).

Similarly, having a single thread just round-robin poll the VMs is
bluntly inefficient and provides poor guarantees about the liveliness
of the stats (a couple slow guests can cause other guests' stats to
become stale for 10s of seconds).

Definitely an RFC here because I'm not sure if I was missing something
that might help me solve the problem.

~Gregory

[1] https://github.com/cloud-hypervisor/cloud-hypervisor
