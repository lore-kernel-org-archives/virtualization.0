From: Venkatesh Srinivas via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] virtio_ring: Shadow available ring flags & index
Date: Tue, 17 Nov 2015 20:28:39 -0800
Message-ID: <20151118042839.GA24662__674.542217939411$1447820935$gmane$org@google.com>
References: <1447201267-30024-1-git-send-email-venkateshs@google.com>
	<20151111142647-mutt-send-email-mst@redhat.com>
	<20151113234140.GA6512@google.com>
	<C37D651A908B024F974696C65296B57B4B1942C3@SHSMSX101.ccr.corp.intel.com>
	<20151118040818.GA17436@google.com>
Reply-To: Venkatesh Srinivas <venkateshs@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151118040818.GA17436@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Xie, Huawei" <huawei.xie@intel.com>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Venkatesh Srinivas <vsrinivas@ops101.org>, "luto@kernel.org" <luto@kernel.org>, David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 17, 2015 at 08:08:18PM -0800, Venkatesh Srinivas wrote:
> On Mon, Nov 16, 2015 at 7:46 PM, Xie, Huawei <huawei.xie@intel.com> wrote:
> 
> > On 11/14/2015 7:41 AM, Venkatesh Srinivas wrote:
> > > On Wed, Nov 11, 2015 at 02:34:33PM +0200, Michael S. Tsirkin wrote:
> > >> On Tue, Nov 10, 2015 at 04:21:07PM -0800, Venkatesh Srinivas wrote:
> > >>> Improves cacheline transfer flow of available ring header.
> > >>>
> > >>> Virtqueues are implemented as a pair of rings, one producer->consumer
> > >>> avail ring and one consumer->producer used ring; preceding the
> > >>> avail ring in memory are two contiguous u16 fields -- avail->flags
> > >>> and avail->idx. A producer posts work by writing to avail->idx and
> > >>> a consumer reads avail->idx.
> > >>>
> > >>> The flags and idx fields only need to be written by a producer CPU
> > >>> and only read by a consumer CPU; when the producer and consumer are
> > >>> running on different CPUs and the virtio_ring code is structured to
> > >>> only have source writes/sink reads, we can continuously transfer the
> > >>> avail header cacheline between 'M' states between cores. This flow
> > >>> optimizes core -> core bandwidth on certain CPUs.
> > >>>
> > >>> (see: "Software Optimization Guide for AMD Family 15h Processors",
> > >>> Section 11.6; similar language appears in the 10h guide and should
> > >>> apply to CPUs w/ exclusive caches, using LLC as a transfer cache)
> > >>>
> > >>> Unfortunately the existing virtio_ring code issued reads to the
> > >>> avail->idx and read-modify-writes to avail->flags on the producer.
> > >>>
> > >>> This change shadows the flags and index fields in producer memory;
> > >>> the vring code now reads from the shadows and only ever writes to
> > >>> avail->flags and avail->idx, allowing the cacheline to transfer
> > >>> core -> core optimally.
> > >> Sounds logical, I'll apply this after a  bit of testing
> > >> of my own, thanks!
> > > Thanks!
> >
> 
> > Venkatesh:
> > Is it that your patch only applies to CPUs w/ exclusive caches?
> 
> No --- it applies when the inter-cache coherence flow is optimized by
> 'M' -> 'M' transfers and when producer reads might interfere w/
> consumer prefetchw/reads. The AMD Optimization guides have specific
> language on this subject, but other platforms may benefit.
> (see Intel #'s below)
> 
> > Do you have perf data on Intel CPUs?
> 
> Good idea -- I ran some tests on a couple of Intel platforms:
> 
> (these are perf data from sample runs; for each I ran many runs, the
>  numbers were pretty stable except for Haswell-EP cross-socket)
> 
> One-socket Intel Xeon W3690 ("Westmere"), 3.46 GHz; core turbo disabled
> =======================================================================
> (note -- w/ core turbo disabled, performance is _very_ stable; variance of
>  < 0.5% run-to-run; figure of merit is "seconds elapsed" here)
> 
> * Producer / consumer bound to Hyperthread pairs:
> 
>  Performance counter stats for './vring_bench_noshadow 1000000000':
> 
>  343,425,166,916 L1-dcache-loads
>       21,393,148 L1-dcache-load-misses     #    0.01% of all L1-dcache hits
>   61,709,640,363 L1-dcache-stores
>        5,745,690 L1-dcache-store-misses
>   10,186,932,553 L1-dcache-prefetches
>            1,491 L1-dcache-prefetch-misses
>    121.335699344 seconds time elapsed
> 
>  Performance counter stats for './vring_bench_shadow 1000000000':
> 
>  334,766,413,861 L1-dcache-loads
>       15,787,778 L1-dcache-load-misses     #    0.00% of all L1-dcache hits
>   62,735,792,799 L1-dcache-stores
>        3,252,113 L1-dcache-store-misses
>    9,018,273,596 L1-dcache-prefetches
>              819 L1-dcache-prefetch-misses
>    121.206339656 seconds time elapsed
> 
> Effectively Performance-neutral.
> 
> * Producer / consumer bound to separate cores, same socket:
> 
>  Performance counter stats for './vring_bench_noshadow 1000000000':
> 
>    399,943,384,509 L1-dcache-loads
>      8,868,334,693 L1-dcache-load-misses     #    2.22% of all L1-dcache hits
>     62,721,376,685 L1-dcache-stores
>      2,786,806,982 L1-dcache-store-misses
>     10,915,046,967 L1-dcache-prefetches
>            328,508 L1-dcache-prefetch-misses
>      146.585969976 seconds time elapsed
> 
>  Performance counter stats for './vring_bench_shadow 1000000000':
> 
>    425,123,067,750 L1-dcache-loads 
>      6,689,318,709 L1-dcache-load-misses     #    1.57% of all L1-dcache hits
>     62,747,525,005 L1-dcache-stores 
>      2,496,274,505 L1-dcache-store-misses
>      8,627,873,397 L1-dcache-prefetches
>            146,729 L1-dcache-prefetch-misses
>      142.657327765 seconds time elapsed
> 
> 2.6% reduction in runtime; note that L1-dcache-load-misses reduced
> dramatically, 2 Billion(!) L1d misses saved.
> 
> Two-socket Intel Sandy Bridge(-EP) Xeon, 2.6 GHz; core turbo disabled
> =====================================================================
> 
> * Producer / consumer bound to Hyperthread pairs:
> 
>  Performance counter stats for './vring_bench_noshadow 100000000':
> 
>     37,129,070,402 L1-dcache-loads
>          6,416,246 L1-dcache-load-misses     #    0.02% of all L1-dcache hits
>      6,207,794,675 L1-dcache-stores
>          2,800,094 L1-dcache-store-misses
>       17.029790809 seconds time elapsed
> 
>  Performance counter stats for './vring_bench_shadow 100000000':
> 
>     36,799,559,391 L1-dcache-loads
>         10,241,080 L1-dcache-load-misses     #    0.03% of all L1-dcache hits
>      6,312,252,458 L1-dcache-stores
>          2,742,239 L1-dcache-store-misses
>       16.941001709 seconds time elapsed
> 
> Effectively Performance-neutral.
> 
> * Producer / consumer bound to separate cores, same socket:
> 
>  Performance counter stats for './vring_bench_noshadow 100000000':
> 
>     27,684,883,046 L1-dcache-loads
>        809,933,091 L1-dcache-load-misses     #    2.93% of all L1-dcache hits
>      6,219,598,352 L1-dcache-stores
>          1,758,503 L1-dcache-store-misses
>       15.020511218 seconds time elapsed
> 
>  Performance counter stats for './vring_bench_shadow 100000000':
> 
>     28,092,111,012 L1-dcache-loads                     
>        716,687,011 L1-dcache-load-misses     #    2.55% of all L1-dcache hits 
>      6,290,821,211 L1-dcache-stores 
>          1,565,583 L1-dcache-store-misses                                    
>       15.208420297 seconds time elapsed
> 
> Effectively Performance-neutral.
> 
> * Producer / consumer bound to separate cores, cross socket:
> (Sandy Bridge-EP appears to have less cross-socket variance than Haswell-EP)
> 
>  Performance counter stats for './vring_bench_noshadow 100000000':
> 
>     35,857,245,449 L1-dcache-loads
>        821,746,755 L1-dcache-load-misses     #    2.29% of all L1-dcache hits
>      6,252,551,550 L1-dcache-stores
>          4,665,405 L1-dcache-store-misses
>       46.340035651 seconds time elapsed
> 
>  Performance counter stats for './vring_bench_shadow 100000000':
> 
>     39,044,022,857 L1-dcache-loads
>        711,731,527 L1-dcache-load-misses     #    1.82% of all L1-dcache hits
>      6,349,051,557 L1-dcache-stores
>          4,292,362 L1-dcache-store-misses
>       42.593259436 seconds time elapsed
> 
> Runtimes for the cross-socket test have somewhat higher variance, but the
> pattern in counts of L1-dcache-loads and L1-dcache-load-misses for nonshadow
> vs. shadow code is very stable.
> 
> noshadow (w/o this patch) reliably clocks in at ~46 seconds, shadow ranges
> from ~48 to ~42 (-2.8% to +8.0%).
> 
> Two-socket Intel Haswell(-EP) Xeon, 2.3 GHz; core turbo disabled
> ================================================================
> 
> * Producer / consumer bound to Hyperthread pairs:
> 
>  Performance counter stats for './vring_bench_noshadow 10000000000':
> 
>    474,856,463,271 L1-dcache-loads
>         74,223,784 L1-dcache-load-misses     #    0.02% of all L1-dcache hits
>     87,274,898,671 L1-dcache-stores
>         31,869,448 L1-dcache-store-misses
>      243.290969318 seconds time elapsed
> 
>  Performance counter stats for './vring_bench_shadow 10000000000':
> 
>    466,891,993,302 L1-dcache-loads
>         80,859,208 L1-dcache-load-misses     #    0.02% of all L1-dcache hits
>     88,760,627,355 L1-dcache-stores
>         35,727,720 L1-dcache-store-misses
>      242.146970822 seconds time elapsed
> 
> Effectively Performance-neutral.
> 
> * Producer / consumer bound to separate cores, same socket:
> 
>  Performance counter stats for './vring_bench_noshadow 10000000000':
> 
>    357,657,891,797 L1-dcache-loads
>      8,760,549,978 L1-dcache-load-misses     #    2.45% of all L1-dcache hits
>     87,357,651,103 L1-dcache-stores
>         10,166,431 L1-dcache-store-misses
>      229.733047436 seconds time elapsed
> 
>  Performance counter stats for './vring_bench_shadow 10000000000':
> 
>    382,508,881,516 L1-dcache-loads
>      8,348,013,630 L1-dcache-load-misses     #    2.18% of all L1-dcache hits
>     88,756,639,931 L1-dcache-stores
>          9,842,999 L1-dcache-store-misses
>      230.850697668 seconds time elapsed
> 
> Effectively Performance-neutral.
> 
> * Producer / consumer bound to separate cores, different sockets:
> 
> Unfortunately I don't have useful numbers for this case -- even with
> core turbo disabled, runtime variance is very high (10 - 30% run-to-run).
> 
> > For the perf metric you provide, why not L1-dcache-load-misses which is
> > more meaning full?
> 
> L1-dcache-load-misses is a better metric, you're right; for the original
> AMD Piledriver run I posted:
> 
>  Performance counter stats for './vring_bench_noshadow':
>      5,451,082,016      L1-dcache-loads
>         31,690,398      L1-dcache-load-misses
>         60,288,052      L1-dcache-stores
>         60,517,840      LLC-loads
>              9,726      LLC-load-misses
>        2.221477739      seconds time elapsed
>  
>  Performance counter stats for './vring_bench_shadow':
>      5,405,701,361      L1-dcache-loads
>         31,157,235      L1-dcache-load-misses
>         59,172,380      L1-dcache-stores
>         59,398,269      LLC-loads
>             10,944      LLC-load-misses
>        2.168405376      seconds time elapsed
> 
> There is a 1.6% reduction in L1-dcache-load-misses, which lines up with
> about a 2% reduction in runtime.
> 
> Summary:
> * No workload on Westmere 1S, Sandy Bridge 2S, and Haswell 2S got worse;
> * Westmere 1S cross-core improved by ~2.5% reliably;
> * Sandy Bridge 2S cross-core cross-socket may have improved. (cross-socket
>   run variance makes it hard to tell)
> * AMD Piledriver tests improved by ~2%;
> * Other virtio implementations (over PCIe for example) should benefit;
> 
> HTH,
> -- vs;

I'm sorry -- I appear to have added an unintentional HTML draft part to my
reply. This would prevent the message from appearing on the kvm@ mailing list
at the minimum.

Re-posting with the HTML part scrubbed.

Sorry,
-- vs;
