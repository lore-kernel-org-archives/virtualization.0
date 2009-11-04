From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv8 0/3] vhost: a kernel-level virtio server
Date: Wed, 4 Nov 2009 18:23:39 +0200
Message-ID: <20091104162339.GA311__17472.5461671644$1257352639$gmane$org@redhat.com>
References: <20091104155234.GA32673@redhat.com> <4AF1A587.8000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AF1A587.8000509@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 04, 2009 at 11:02:15AM -0500, Gregory Haskins wrote:
> Michael S. Tsirkin wrote:
> > Ok, I think I've addressed all comments so far here.
> > Rusty, I'd like this to go into linux-next, through your tree, and
> > hopefully 2.6.33.  What do you think?
> 
> I think the benchmark data is a prerequisite for merge consideration, IMO.

Shirley Ma was kind enough to send me some measurement results showing
how kernel level acceleration helps speed up you can find them here:
http://www.linux-kvm.org/page/VhostNet

Generally, I think that merging should happen *before* agressive
benchmarking/performance tuning: otherwise there is very substancial
risk that what is an optimization in one setup hurts performance in
another one. When code is upstream, people can bisect to debug
regressions. Another good reason is that I can stop spending time
rebasing and start profiling.

> Do you have anything for us to look at?

For guest to host, compared to latest qemu with userspace virtio
backend, latency drops by a factor of 6, bandwidth doubles, cpu
utilization drops slightly :)

> I think comparison that show the following are of interest:
> 
> throughput (e.g. netperf::TCP_STREAM): guest->host, guest->host->guest,
> guest->host->remote, host->remote, remote->host->guest
> 
> latency (e.g. netperf::UDP_RR): same conditions as throughput
> 
> cpu-utilization
> 
> others?
> 
> Ideally, this should be at least between upstream virtio and vhost.
> Bonus points if you include venet as well.

And vmxnet3 :)

> Kind regards,
> -Greg
> 
-- 
MST
