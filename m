From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio console fixes
Date: Thu, 8 Apr 2010 10:37:48 +0930
Message-ID: <201004081037.48774.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Amit Shah <amit.shah@redhat.com>, =?iso-8859-1?q?Fran=E7ois_Diakhate?= <fdiakh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Anton Blanchard <anton@samba.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 48de8cb7847d040c8892701c1ff3c55eff1f46b4:
  Linus Torvalds (1):
        Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/.../tip=
/linux-2.6-tip

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linu=
s.git master

Amit Shah (1):
      MAINTAINERS: Put the virtio-console entry in correct alphabetical ord=
er

Anton Blanchard (1):
      hvc_console: Fix race between hvc_close and hvc_remove

Fran=E7ois Diakhat=E9 (1):
      virtio: console: Fix early_put_chars usage

Michael S. Tsirkin (1):
      virtio: disable multiport console support.

Rusty Russell (1):
      virtio: console makes incorrect assumption about virtio API

 MAINTAINERS                    |   13 ++++----
 drivers/char/hvc_console.c     |    4 --
 drivers/char/virtio_console.c  |   65 +++++++++++++++++++++++++++++-------=
----
 include/linux/virtio_console.h |   23 --------------
 4 files changed, 54 insertions(+), 51 deletions(-)

commit 9a82446bd269b130a9ac270e720e65c3843d4d0c
Author: Amit Shah <amit.shah@redhat.com>
Date:   Tue Mar 23 18:23:09 2010 +0530

    MAINTAINERS: Put the virtio-console entry in correct alphabetical order
    =

    Move around the entry for virtio-console to keep the file sorted.
    =

    Signed-off-by: Amit Shah <amit.shah@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

 MAINTAINERS |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

commit 162a689a13ed61c0752726edb75427b2cd4186c1
Author: Fran=E7ois Diakhat=E9 <fdiakh@gmail.com>
Date:   Tue Mar 23 18:23:15 2010 +0530

    virtio: console: Fix early_put_chars usage
    =

    Currently early_put_chars is not used by virtio_console because it can
    only be used once a port has been found, at which point it's too late
    because it is no longer needed. This patch should fix it.
    =

    Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Signed-off-by: Amit Shah <amit.shah@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

 drivers/char/virtio_console.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

commit 9ff4cfab82d27e9fda72315f911bbaa9516e04bc
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Thu Apr 8 09:46:16 2010 -0600

    virtio: console makes incorrect assumption about virtio API
    =

    The get_buf() API sets the second arg to the number of bytes *written*
    by the other side; in this case it should be zero as these are output b=
uffers.
    =

    lguest gets this right (obviously kvm's console doesn't), resulting in
    continual buildup of console writes.
    =

    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
    Acked-by: Amit Shah <amit.shah@redhat.com>

 drivers/char/virtio_console.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

commit b7a413015d2986edf020fba765c906cc9cbcbfc9
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Wed Mar 31 21:56:42 2010 +0300

    virtio: disable multiport console support.
    =

    Move MULTIPORT feature and related config changes
    out of exported headers, and disable the feature
    at runtime.
    =

    At this point, it seems less risky to keep code around
    until we can enable it than rip it out completely.
    =

    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

 drivers/char/virtio_console.c  |   49 +++++++++++++++++++++++++++++++++---=
---
 include/linux/virtio_console.h |   23 ------------------
 2 files changed, 41 insertions(+), 31 deletions(-)

commit 320718ee074acce5ffced6506cb51af1388942aa
Author: Anton Blanchard <anton@samba.org>
Date:   Tue Apr 6 21:42:38 2010 +1000

    hvc_console: Fix race between hvc_close and hvc_remove
    =

    I don't claim to understand the tty layer, but it seems like hvc_open a=
nd
    hvc_close should be balanced in their kref reference counting.
    =

    Right now we get a kref every call to hvc_open:
    =

            if (hp->count++ > 0) {
                    tty_kref_get(tty); <----- here
                    spin_unlock_irqrestore(&hp->lock, flags);
                    hvc_kick();
                    return 0;
            } /* else count =3D=3D 0 */
    =

            tty->driver_data =3D hp;
    =

            hp->tty =3D tty_kref_get(tty); <------ or here if hp->count was=
 0
    =

    But hvc_close has:
    =

            tty_kref_get(tty);
    =

            if (--hp->count =3D=3D 0) {
    ...
                    /* Put the ref obtained in hvc_open() */
                    tty_kref_put(tty);
    ...
            }
    =

            tty_kref_put(tty);
    =

    Since the outside kref get/put balance we only do a single kref_put when
    count reaches 0.
    =

    The patch below changes things to call tty_kref_put once for every
    hvc_close call, and with that my machine boots fine.
    =

    Signed-off-by: Anton Blanchard <anton@samba.org>
    Acked-by: Amit Shah <amit.shah@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

 drivers/char/hvc_console.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)
