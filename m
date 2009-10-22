From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PULL] virtio fixes
Date: Thu, 22 Oct 2009 16:43:44 +1030
Message-ID: <200910221643.44411.rusty__32142.749525565$1256192077$gmane$org@rustcorp.com.au>
References: <200910191301.24726.rusty@rustcorp.com.au>
	<alpine.LFD.2.00.0910220831090.9771@eeepc.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0910220831090.9771@eeepc.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Oct 2009 10:01:43 am Linus Torvalds wrote:
> =

> On Mon, 19 Oct 2009, Rusty Russell wrote:
> > =

> >   ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-=
linus.git master
> =

> "Already up-to-date.".
> =

> Forgot to push?

Oops, overzealous master.kernel.org space reclamation from me :

This time for sure!
Rusty/

The following changes since commit 2fdc246aaf9a7fa088451ad2a72e9119b5f7f029:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../bp/bp

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linu=
s.git master

Christian Borntraeger (1):
      virtio: let header files include virtio_ids.h

Christoph Hellwig (1):
      virtio_blk: revert QUEUE_FLAG_VIRT addition

Rusty Russell (1):
      virtio_blk: Revert serial number support

Uwe Kleine-K=F6nig (2):
      move virtballoon_remove to .devexit.text
      move virtrng_remove to .devexit.text

 Documentation/lguest/lguest.c       |    1 -
 drivers/block/virtio_blk.c          |   39 ++-----------------------------=
---
 drivers/char/hw_random/virtio-rng.c |    3 +-
 drivers/char/virtio_console.c       |    1 -
 drivers/net/virtio_net.c            |    1 -
 drivers/virtio/virtio_balloon.c     |    3 +-
 include/linux/Kbuild                |    1 +
 include/linux/virtio_9p.h           |    1 +
 include/linux/virtio_balloon.h      |    1 +
 include/linux/virtio_blk.h          |    5 +---
 include/linux/virtio_console.h      |    1 +
 include/linux/virtio_net.h          |    1 +
 include/linux/virtio_rng.h          |    1 +
 net/9p/trans_virtio.c               |    1 -
 14 files changed, 12 insertions(+), 48 deletions(-)
