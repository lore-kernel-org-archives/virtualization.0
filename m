From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC/PATCHSET 0/7] virtio: Implement virtio pstore device (v2)
Date: Thu, 28 Jul 2016 11:46:13 +0900
Message-ID: <20160728024612.GA4371__32151.3884970502$1469674892$gmane$org@sejong>
References: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
	<20160728011602-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728011602-mutt-send-email-mst@kernel.org>
Content-Disposition: inline
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
Cc: Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Anton Vorontsov <anton@enomsg.org>, Will Deacon <will.deacon@arm.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Thu, Jul 28, 2016 at 01:18:42AM +0300, Michael S. Tsirkin wrote:
> On Thu, Jul 28, 2016 at 12:08:24AM +0900, Namhyung Kim wrote:
> > Hello,
> > 
> > This is v2 of the virtio-pstore work.  In this patchset I addressed
> > most of feedbacks from previous version.  Limiting disk size is not
> > implemented yet.
> 
> For some reason, only parts of the patchset were received.
> Pls post all patches to all lists.
> 
> If you are changing the virtio interface with host,
> like a new device, they you must copy the virtio TC
> so make sure there are no objections from there.
> 
> https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback

Hmm.. I think I've CC-ed all the kvm, qemu and virtualization lists
but missed the virtio list, sorry.  Will add next time.

Thanks,
Namhyung
