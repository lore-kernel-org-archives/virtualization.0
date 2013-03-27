From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Wed, 27 Mar 2013 13:25:35 +0200
Message-ID: <20130327112535.GE24243@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com>
	<8738vjer43.fsf@rustcorp.com.au>
	<20130326193911.GA19251@redhat.com>
	<87ip4d4sef.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ip4d4sef.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: hpa@zytor.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2013 at 10:37:20AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Mon, Mar 25, 2013 at 08:30:28PM +1030, Rusty Russell wrote:
> >> Let's go back a level.  Do we still need I/O bars at all now?  Or can we
> >> say "if you want hundreds of vqs, use mem bars"?
> >> 
> >> hpa wanted the option to have either, but do we still want that?
> >
> > hpa says having both is required for BIOS, not just for speed with KVM.
> 
> OK so the offset must not be applied to the I/O bar as you suggested.

Aha. Yes, good idea.  As for how large the offsets are,
I am guessing we should either just say offset is vqn * X and data is
vqn, or give hypervisors full flexibility with 32 bit offset and
arbitrary data.
16 bit offsets seem neither here nor there ...
Not a strong preference.

> Since AFAICT I/O bars are deprecated, should we insist that there be a
> memory bar, and the I/O bar is optional?  Or just leave it entirely
> undefined, and say there can be either or both?

I would make the memory bar required and the I/O bar optional.
Again not a strong preference.

> I dislike the idea of BIOS code which assumed an I/O bar and thus won't
> work with a compliant device which doesn't provide one.  I'd prefer all
> compliant drivers to work with all compliant devices.
> 
> Cheers,
> Rusty.

In any case, the only thing we would want in the IO BAR is the
notification.  So we should add a way to control device
configuration through PCI configuration. An offset/data pair
will do the trick.

-- 
MST
