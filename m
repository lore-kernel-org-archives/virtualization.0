From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Tue, 15 Nov 2016 15:23:36 +0900
Message-ID: <20161115062336.GA16821@danjae.aot.lge.com>
References: <20160820080744.10344-1-namhyung@kernel.org>
	<20160820080744.10344-3-namhyung@kernel.org>
	<20160913155710.3q6yj6yqdyozemul@redhat.com>
	<20160916100547.GC2474@danjae.aot.lge.com>
	<20161111004710-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20161111004710-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, "Daniel P . Berrange" <berrange@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 11, 2016 at 12:50:03AM +0200, Michael S. Tsirkin wrote:
> On Fri, Sep 16, 2016 at 07:05:47PM +0900, Namhyung Kim wrote:
> > On Tue, Sep 13, 2016 at 06:57:10PM +0300, Michael S. Tsirkin wrote:
> > > On Sat, Aug 20, 2016 at 05:07:43PM +0900, Namhyung Kim wrote:
> > > > +
> > > > +/* the index should match to the type value */
> > > > +static const char *virtio_pstore_file_prefix[] = {
> > > > +    "unknown-",		/* VIRTIO_PSTORE_TYPE_UNKNOWN */
> > > 
> > > Is there value in treating everything unexpected as "unknown"
> > > and rotating them as if they were logs?
> > > It might be better to treat everything that's not known
> > > as guest error.
> > 
> > I was thinking about the version mismatch between the kernel and qemu.
> > I'd like to make the device can deal with a new kernel version which
> > might implement a new pstore message type.  It will be saved as
> > unknown but the kernel can read it properly later.
> 
> Well it'll have a different prefix. E.g. if kernel has
> two different types they will end up in the same
> file, hardly what was wanted.

Right, I think it needs to add 'type' info to the filename for unknown
type.

Thanks,
Namhyung
