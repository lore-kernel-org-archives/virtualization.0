From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] virtio_net: fix lockdep warning on 32 bit
Date: Thu, 07 May 2020 07:58:04 -0700 (PDT)
Message-ID: <20200507.075804.1424387208635118.davem@davemloft.net>
References: <20200507072525.355222-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507072525.355222-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, eric.dumazet@gmail.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 7 May 2020 03:25:56 -0400

> When we fill up a receive VQ, try_fill_recv currently tries to count
> kicks using a 64 bit stats counter. Turns out, on a 32 bit kernel that
> uses a seqcount. sequence counts are "lock" constructs where you need to
> make sure that writers are serialized.
> 
> In turn, this means that we mustn't run two try_fill_recv concurrently.
> Which of course we don't. We do run try_fill_recv sometimes from a
> softirq napi context, and sometimes from a fully preemptible context,
> but the later always runs with napi disabled.
> 
> However, when it comes to the seqcount, lockdep is trying to enforce the
> rule that the same lock isn't accessed from preemptible and softirq
> context - it doesn't know about napi being enabled/disabled. This causes
> a false-positive warning:
> 
> WARNING: inconsistent lock state
> ...
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> 
> As a work around, shut down the warning by switching
> to u64_stats_update_begin_irqsave - that works by disabling
> interrupts on 32 bit only, is a NOP on 64 bit.
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied and queued up for -stable, thanks Michael.
