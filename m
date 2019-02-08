From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Fri, 8 Feb 2019 17:02:41 +0100
Message-ID: <20190208170241.2fa28dff__10317.6892896713$1549716090$gmane$org@carbon>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
	<b8c97120-851f-450f-dc71-59350236329e@gmail.com>
	<20190204125307.08492005@redhat.com>
	<bdcfedd6-465d-4485-e268-25c4ce6b9fcf@gmail.com>
	<140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Saeed Mahameed <saeedm@mellanox.com>
Cc: "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, brouer@redhat.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "thoiland@redhat.com" <thoiland@redhat.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "borkmann@iogearbox.net" <borkmann@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 6 Feb 2019 00:06:33 +0000 Saeed Mahameed <saeedm@mellanox.com> wrote:

> 2) Driver should keep track of XDP decisions statistics, report them in
> ethtool and in the new API suggested by David. track even (XDP_PASS) ?
> 
> Maybe instead of having all drivers track the statistics on their own,
> we should move the responsibility to upper layer.
> 
> Idea: since we already have rxq_info structure per XDP ring (no false
> sharing) and available per xdp_buff we can do:
> 
> +++ b/include/linux/filter.h
> @@ -651,7 +651,9 @@ static __always_inline u32 bpf_prog_run_xdp(const
> struct bpf_prog *prog,
>          * already takes rcu_read_lock() when fetching the program, so
>          * it's not necessary here anymore.
>          */
> -       return BPF_PROG_RUN(prog, xdp);
> +       u32 ret = BPF_PROG_RUN(prog, xdp);
> +       xdp->xdp_rxq_info.stats[ret]++
> +       return ret;
>  }
> 
> still we need a way (API) to report the rxq_info to whoever needs to
> read current XDP stats 

I'm capturing this as tasks under the XDP-project github page:
 https://github.com/xdp-project/xdp-project/pull/13/files

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
