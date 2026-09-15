Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117E3B9D9A;
	Tue, 15 Sep 2026 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452862; cv=none; b=EkRUCtC2fAlkKpTESrR5Hv4mK0BUs1ZHRQblxMrlRCDwtjwauOeh0QCCM4wXy0mR306ZNp2AIieCnMrJyVw7QbGivua5jNZsFDJa4IrRRYL3ZMyZJImND1CvGb5XrEyZ1EI4HoD7XbRTBUONYlxpz0aonGMD63cUj+keTo0QkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452862; c=relaxed/simple;
	bh=P4a1orb1XWvuNrlS5k4wAp2Y4mWeduQCihTuKgxCm84=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KoArAksakQNxI2aUE6VTEzI+2hHkrB59I04qQlqitwkKkb4vEhysPlFL2tHs4p7xfpRJQvod8nCUHldjB/qLOJUpALoKB8f6T7WDoluOM7heIGkYCrGnBzHLtgZtIx5qEfxlddPM69Av/3/5eHYUXbYDSUzyyTaVnRYKHvJtIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cwwjt4nJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cwwjt4nJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3910C1F000FF;
	Tue, 15 Sep 2026 06:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789452861;
	bh=/xezU87Zq2Y1vT/o2bvpMtCWCufr1oupAxWYAhAbPVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cwwjt4nJYsaMpOAFBS96BKI8N+2+sK8qyZMEoJg8kDgjYtNT2BKKpZlwOV4sgpN7S
	 855KBpJ5y+VTkRCRPDpDh2agL14R3mMuAGVEDtM5DfVAxwgvZ+edoZhOW3rum1Pzlo
	 n7aEuG9bgOKttiqPyGo3uJh5NElBpjAtfEeOQXnI=
Date: Mon, 14 Sep 2026 23:14:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Matthew Wilcox <willy@infradead.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Kees Cook <kees@kernel.org>,
 Joel Granados <joel.granados@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Mike
 Rapoport <rppt@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 llvm@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 00/17] Treewide: enforce static storage for object
 initializers
Message-Id: <20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 23:03:18 -0400 Yury Norov <ynorov@nvidia.com> wrote:

> Declaration macros that statically initialize embedded locks require static
> storage when lockdep is enabled. Automatic objects must use runtime
> initialization so lockdep receives a persistent class key.
> 
> For automatic local objects, lockdep cannot use the lock address as a persistent
> class key and reports "INFO: trying to register non-static key" before disabling
> itself.

So why haven't we been buried in reports about this warning coming out?
