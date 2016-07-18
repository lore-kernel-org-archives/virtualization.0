From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Mon, 18 Jul 2016 11:02:27 +0200
Message-ID: <20160718110227.6ff6d1a2.cornelia.huck@de.ibm.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-2-git-send-email-namhyung@kernel.org>
	<20160718095439.1eabb340.cornelia.huck@de.ibm.com>
	<20160718082955.GA12086@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160718082955.GA12086@danjae.aot.lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S.
	Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 Jul 2016 17:29:55 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Mon, Jul 18, 2016 at 09:54:39AM +0200, Cornelia Huck wrote:
> > On Mon, 18 Jul 2016 13:37:39 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:

> > > +#define VIRT_PSTORE_ORDER    2
> > > +#define VIRT_PSTORE_BUFSIZE  (4096 << VIRT_PSTORE_ORDER)
> > 
> > It may make sense to make the size of the buffer configurable through
> > the config space.
> 
> Right.  I'm considering it too, but it needs a buffer larger than
> kmsg_bytes (= 10K) to work properly in the current implementation.  As
> this version is just to verify the idea is sane and useful, I used a
> fixed size buffer.  Will change in the next version.

Sure, that makes sense for a prototype. We can guard any config space
entry with a feature bit, but this one makes sense to add from the
beginning.

> > Speaking of the standard: I think it makes sense to at least reserve a
> > device id for pstore, as the idea is sound. Maybe prepare a patch to
> > the standard as well if you have time?
> 
> I'd love to.  As I mentioned earlier, I don't have enough knowledge in
> this area.  Could you please provide some links about how can I do that?

See the virtio page at OASIS
(https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio)
for a link to our subversion (yes...) repository. Just do two patches:
one to reserve a device id, and one that specifies how device and
driver work. (For examples, look at the proposed device types that have
been posted to the virtualization lists, e.g. virtio-crypto or
virtio-sdm). You just need to be patient, we're currently a bit
stalled...
