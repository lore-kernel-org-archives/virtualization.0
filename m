From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: fix lockdep warning on 32 bit
Date: Wed, 06 May 2020 13:42:09 -0700 (PDT)
Message-ID: <20200506.134209.2202487070619689100.davem@davemloft.net>
References: <20200506000006.196646-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506000006.196646-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, eric.dumazet@gmail.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 5 May 2020 20:01:31 -0400

> -		u64_stats_update_end(&rq->stats.syncp);
> +		u64_stats_update_end_irqrestore(&rq->stats.syncp);

Need to pass flags to this function.
