From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Tue, 15 Nov 2016 23:36:29 +0900
Message-ID: <20161115143629.GA29740@danjae.aot.lge.com>
References: <20160820080744.10344-1-namhyung@kernel.org>
	<20160820080744.10344-2-namhyung@kernel.org>
	<20161110182611-mutt-send-email-mst@kernel.org>
	<20161115045021.GA15992@danjae.aot.lge.com>
	<20161115065658-mutt-send-email-mst@kernel.org>
	<f514ac65-3105-a12c-9e10-2d3b1e8a0516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f514ac65-3105-a12c-9e10-2d3b1e8a0516@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On Tue, Nov 15, 2016 at 10:57:29AM +0100, Paolo Bonzini wrote:
> 
> 
> On 15/11/2016 06:06, Michael S. Tsirkin wrote:
> > On Tue, Nov 15, 2016 at 01:50:21PM +0900, Namhyung Kim wrote:
> >> Hi Michael,
> >>
> >> On Thu, Nov 10, 2016 at 06:39:55PM +0200, Michael S. Tsirkin wrote:
> >>> On Sat, Aug 20, 2016 at 05:07:42PM +0900, Namhyung Kim wrote:
> >>>> The virtio pstore driver provides interface to the pstore subsystem so
> >>>> that the guest kernel's log/dump message can be saved on the host
> >>>> machine.  Users can access the log file directly on the host, or on the
> >>>> guest at the next boot using pstore filesystem.  It currently deals with
> >>>> kernel log (printk) buffer only, but we can extend it to have other
> >>>> information (like ftrace dump) later.
> >>>>
> >>>> It supports legacy PCI device using single order-2 page buffer.
> >>>
> >>> Do you mean a legacy virtio device? I don't see why
> >>> you would want to support pre-1.0 mode.
> >>> If you drop that, you can drop all cpu_to_virtio things
> >>> and just use __le accessors.
> >>
> >> I was thinking about the kvmtools which lacks 1.0 support AFAIK.
> > 
> > Unless kvmtools wants to be left behind it has to go 1.0.
> 
> And it also has to go ACPI.  Is there any reason, apart from kvmtool, to
> make a completely new virtio device, with no support in existing guests,
> rather than implement ACPI ERST?

Well, I know nothing about ACPI.  It looks like a huge spec and I
don't want to dig into it just for this.

What I want is to speed up dumping guest kernel message (especially
for ftrace dump).

Thanks,
Namhyung
