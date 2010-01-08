From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] Re: [PATCH v2] virtio-blk physical block size
Date: Fri, 8 Jan 2010 16:40:44 +0100
Message-ID: <20100108154044.GB14634__30780.4605960429$1262965410$gmane$org@lst.de>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
	<201001041338.52621.rusty@rustcorp.com.au>
	<20100104083035.GA7461@lst.de>
	<201001052326.33216.rusty@rustcorp.com.au>
	<4B433783.6090400@redhat.com>
	<20100105201615.GJ14376@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100105201615.GJ14376@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 05, 2010 at 08:16:15PM +0000, Jamie Lokier wrote:
> It would be good if virtio relayed the backing device's basic topology
> hints, so:
> 
>     - If the backing dev is a real disk with 512-byte sectors,
>       virtio should indicate 512-byte blocks to the guest.
> 
>     - If the backing dev is a real disk with 4096-byte sectors,
>       virtio should indicate 4096-byte blocks to the guest.
> 
> With databases and filesystems, if you care about data integrity:
> 
>     - If the backing dev is a real disk with 4096-byte sectors,
>       or a file whose access is through a 4096-byte-per-page cache,
>       virtio must indicate 4096-byte blocks otherwise guest
>       journalling is not host-powerfail safe.
> 
> You get the idea.  If there is only one parameter, it really should be
> at least as large as the smallest unit which may be corrupted by
> writes when errors occur.

It's not that easy.  IDE only supports larger sectors sizes with the
physical sector size attribute, not native larger sectors.  While scsi
does support it it's untypical and I would not expect the guests to
not always get it right.  So the best is to use the transport native
way to express that we have larger sectors and expect the guest to do
the right thing.

I've done some work on the autodetection of the larger sector sizes
a while ago.  But now that people brought up migration I wonder if that
makes sense - if we migrate from a 512 byte sector size disk to a 4096
byte sector size disk we can't simply change guest visible attributes.

Maybe we should pick one on image creation and then stick to it.  For an
image format we could write down this information in the image, but for
a raw images that's impossible.
