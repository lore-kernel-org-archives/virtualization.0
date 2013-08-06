From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/5] Intel MIC Host Driver Changes for Virtio Devices.
Date: Tue, 06 Aug 2013 13:17:46 +0930
Message-ID: <87li4fqy3h.fsf__39348.7170724713$1375761376$gmane$org@rustcorp.com.au>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
	<43d0932810d066e52bd6ee996b3cb59da8c42e85.1374717252.git.sudeep.dutt@intel.com>
	<20130729070000.GA2308@redhat.com>
	<1375404051.61060.75.camel@blbiskey-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1375404051.61060.75.camel@blbiskey-desk1.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Sudeep Dutt <sudeep.dutt@intel.com> writes:
> On Mon, 2013-07-29 at 10:05 +0300, Michael S. Tsirkin wrote: 
>> On Wed, Jul 24, 2013 at 08:31:34PM -0700, Sudeep Dutt wrote:
>> > From: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> > 
>> > This patch introduces the host "Virtio over PCIe" interface for
>> > Intel MIC. It allows creating user space backends on the host and
>> > instantiating virtio devices for them on the Intel MIC card. A character
>> > device per MIC is exposed with IOCTL, mmap and poll callbacks. This allows
>> > the user space backend to:
>> > (a) add/remove a virtio device via a device page.
>> > (b) map (R/O) virtio rings and device page to user space.
>> > (c) poll for availability of data.
>> > (d) copy a descriptor or entire descriptor chain to/from the card.
>> > (e) modify virtio configuration.
>> > (f) handle virtio device reset.
>> > The buffers are copied over using CPU copies for this initial patch
>> > and host initiated MIC DMA support is planned for future patches.
>> > The avail and desc virtio rings are in host memory and the used ring
>> > is in card memory to maximize writes across PCIe for performance.
>> > 
>> > Co-author: Sudeep Dutt <sudeep.dutt@intel.com>
>> > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> > Signed-off-by: Caz Yokoyama <Caz.Yokoyama@intel.com>
>> > Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
>> > Signed-off-by: Nikhil Rao <nikhil.rao@intel.com>
>> > Signed-off-by: Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>
>> > Signed-off-by: Sudeep Dutt <sudeep.dutt@intel.com>
>> > Acked-by: Yaozu (Eddie) Dong <eddie.dong@intel.com>
>> > Reviewed-by: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>
>> 
>> I decided to look at the security and ordering of ring accesses.
>> Doing a quick look, I think I found some issues, see comments below.
>> If it were possible to reuse existing ring handling code,
>> such issues would go away automatically.
>> Which brings me to the next question: have you looked at reusing
>> some code under drivers/vhost for host side processing?
>> If not, you probably should.
>> Is code in vringh.c generic enough to support your use-case,
>> and if not what exactly are the issues preventing this?
>> 
>> Thanks,
>> 
> We had implemented our custom MIC vring host access logic before the
> VRINGH infrastructure was merged to mainline in v3.10. Based on your
> feedback, we have a proof of concept implemented this week, by reusing
> the VRINGH infrastructure and it works nicely for us!

Nice!  Good suggestion MST, thanks for the plug :)

> One of our goals is to issue the  buffer transfers using DMA with future
> patches. The CPU copy in our current patches is also slightly different
> compared to VRINGH since we are copying from card buffers to user space
> and vice versa. In order to do meet these goals, we are obtaining the
> next available descriptor via vringh_getdesc_kern(..), then triggering
> the copy (CPU or eventually DMA) via a custom MIC API and then
> publishing the descriptor via vringh_complete_kern(..). Are there any
> plans of enhancing VRINGH to allow overriding the xfer mechanism in
> vringh_iov_xfer(..)? This will allow drivers with custom xfer routines
> to reuse APIs like vringh_iov_push_kern(..) and vringh_iov_pull_kern(..)
> as well. That said, the existing VRINGH infrastructure is generic enough
> for our use case as is today.

We'll have to look at exposing the internals.  vringh_iov_xfer() works
well because it's internal and inlined.  It'll be much easier to
evaluate when we're dealing with specific patches.

Cheers,
Rusty.
