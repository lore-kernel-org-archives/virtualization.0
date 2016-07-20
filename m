From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Wed, 20 Jul 2016 21:46:11 +0900
Message-ID: <20160720124611.GB5682@danjae.aot.lge.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-3-git-send-email-namhyung@kernel.org>
	<20160718100353.GA15163@stefanha-x1.localdomain>
	<20160718142118.GA16575@danjae.aot.lge.com>
	<20160720082906.GB13233@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160720082906.GB13233@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 20, 2016 at 09:29:06AM +0100, Stefan Hajnoczi wrote:
> On Mon, Jul 18, 2016 at 11:21:18PM +0900, Namhyung Kim wrote:
> > On Mon, Jul 18, 2016 at 11:03:53AM +0100, Stefan Hajnoczi wrote:
> > > On Mon, Jul 18, 2016 at 01:37:40PM +0900, Namhyung Kim wrote:
> > > > From: Namhyung Kim <namhyung@gmail.com>
> > > > 
> > > > Add virtio pstore device to allow kernel log files saved on the host.
> > > > It will save the log files on the directory given by pstore device
> > > > option.
> > > > 
> > > >   $ qemu-system-x86_64 -device virtio-pstore,directory=dir-xx ...
> > > > 
> > > >   (guest) # echo c > /proc/sysrq-trigger
> > > > 
> > > >   $ ls dir-xx
> > > >   dmesg-0.enc.z  dmesg-1.enc.z
> > > > 
> > > > The log files are usually compressed using zlib.  Users can see the log
> > > > messages directly on the host or on the guest (using pstore filesystem).
> > > 
> > > The implementation is synchronous (i.e. can pause guest code execution),
> > > does not handle write errors, and does not limit the amount of data the
> > > guest can write.  This is sufficient for ad-hoc debugging and usage with
> > > trusted guests.
> > > 
> > > If you want this to be available in environments where the guest isn't
> > > trusted then there must be a limit on how much the guest can write or
> > > some kind of log rotation.
> > 
> > Right.  The synchronous IO is required by the pstore subsystem
> > implementation AFAIK (it uses a single psinfo->buf in the loop).
> 
> The pstore subsystem in Linux may be synchronous but the QEMU device
> emulation does not have to be synchronous.
> 
> Synchronous device emulation means that no other vcpu or QEMU main loop
> processing can occur while device emulation is blocked in a syscall.
> This can make the QEMU monitor unavailable for libvirt and management
> tools.  The guest can experience jitter since vcpus freeze if they
> vmexit while device emulation is blocked (it holds the QEMU global
> mutex and prevents other QEMU threads from making progress).

Thanks for your detailed explanation.  I'll try to change pstore
implementation to deal with async devices.

Thanks,
Namhyung

> 
> You could use include/io.h for asynchronous I/O (qio_channel_add_watch()).
> 
> Stefan
