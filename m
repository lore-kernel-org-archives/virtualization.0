From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Tue, 15 Nov 2016 14:50:11 +0900
Message-ID: <20161115055011.GB15992@danjae.aot.lge.com>
References: <20160820080744.10344-1-namhyung@kernel.org>
	<20160820080744.10344-2-namhyung@kernel.org>
	<20161110182611-mutt-send-email-mst@kernel.org>
	<20161115045021.GA15992@danjae.aot.lge.com>
	<20161115065658-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20161115065658-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 15, 2016 at 07:06:28AM +0200, Michael S. Tsirkin wrote:
> On Tue, Nov 15, 2016 at 01:50:21PM +0900, Namhyung Kim wrote:
> > On Thu, Nov 10, 2016 at 06:39:55PM +0200, Michael S. Tsirkin wrote:
> > [SNIP]
> > > > +struct virtio_pstore_fileinfo {
> > > > +	__virtio64		id;
> > > > +	__virtio32		count;
> > > > +	__virtio16		type;
> > > > +	__virtio16		unused;
> > > > +	__virtio32		flags;
> > > > +	__virtio32		len;
> > > > +	__virtio64		time_sec;
> > > > +	__virtio32		time_nsec;
> > > > +	__virtio32		reserved;
> > > > +};
> > > > +
> > > > +struct virtio_pstore_config {
> > > > +	__virtio32		bufsize;
> > > > +};
> > > > +
> > > 
> > > What exactly does each field mean? I'm especially
> > > interested in time fields - maintaining a consistent
> > > time between host and guest is not a simple problem.
> > 
> > These are required by pstore and will be used to create corresponding
> > files in the pstore filesystem.  The time fields are for mtime and
> > ctime and, I think, it's just a hint for user and doesn't require
> > strict consistency.
> 
> Pls add documentation. I would just drop hints for now.

Well, I'll add docmentation.  But I think just dropping might not good
since they all have host time and it's helpful to know their relative
difference in guest.

Thanks,
Namhyung
