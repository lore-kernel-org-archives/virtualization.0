From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Wed, 9 Mar 2016 06:18:00 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04148E3A__8380.31852986223$1457504300$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<20160303174615.GF2115@work-vm>
	<F2CBF3009FA73547804AE4C663CAB28E03770E33@SHSMSX101.ccr.corp.intel.com>
	<20160304081411.GD9100@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E0377160A@SHSMSX101.ccr.corp.intel.com>
	<20160304102346.GB2479@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E0414516C@shsmsx102.ccr.corp.intel.com>
	<56D9B6C2.3070708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56D9B6C2.3070708@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> On 04/03/2016 15:26, Li, Liang Z wrote:
> >> >
> >> > The memory usage will keep increasing due to ever growing caches,
> >> > etc, so you'll be left with very little free memory fairly soon.
> >> >
> > I don't think so.
> >
> 
> Roman is right.  For example, here I am looking at a 64 GB (physical) machine
> which was booted about 30 minutes ago, and which is running disk-heavy
> workloads (installing VMs).
> 
> Since I have started writing this email (2 minutes?), the amount of free
> memory has already gone down from 37 GB to 33 GB.  I expect that by the
> time I have finished running the workload, in two hours, it will not have any
> free memory.
> 
> Paolo

I have a VM which has 2GB of RAM, when the guest booted, there were about 1.4GB of free pages.
Then I tried to download a large file from the internet with the browser, after the downloading finished,
there were only 72MB of free pages left, as Roman pointed out, there were quite a lot of Cached memory.
Then I tried to compile the QEMU, after the compiling finished, there were about 1.3G free pages.

So even the cache will increase to a large amount, it will be freed if there are some other specific workloads. 
The cache memory is a big issue that should be taken into consideration.
 How about reclaim some cache before getting the free pages information?  

Liang 
