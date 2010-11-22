From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH] virtio: (Partially) enable suspend/resume support
Date: Mon, 22 Nov 2010 19:15:37 +0530
Message-ID: <20101122134537.GB6979@amit-x200.redhat.com>
References: <da50daa251eb982c43fa474de8d4f1303f1ad57f.1285762305.git.amit.shah@redhat.com>
	<20101003155359.GB20285@redhat.com>
	<20101005134531.GD8207@amit-laptop.redhat.com>
	<20101005152319.GA22056@redhat.com>
	<20101006115418.GI8207@amit-laptop.redhat.com>
	<20101105101536.GA15514@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101105101536.GA15514@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Matthew Garrett <mjg@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

(Adding Matthew Garrett and Vadim Rosenfeld)

On (Fri) Nov 05 2010 [12:15:36], Michael S. Tsirkin wrote:
> I still don't see it.  why don't we reset on resume?
> If there's a reset host must either discard or
> flush out operations in progress.

OK, let me list how virtio-serial works, then let's see how Windows and
Linux differ in their suspend/resume implementations and then discuss
solutions.

virtio-serial, in its probe routine, exchanges some information over a
control vq and per-port vqs -- the number of ports, the number of open
ports, the names assigned to the ports, etc.

When Linux starts up, it goes about doing the regular init, calling the
probe routine.  Later, when it detects there is a suspended image
available, it restores that image.

After the image is restored, the vring counts in qemu reflect the
transfer that's taken place in the probe routine, whereas the vring
counts in the guest kernel reflect the pre-suspend values.

The Linux kernel's suspend/resume notifiers currently offer the
following notifications:
- Preparing to go to suspended state (tasks will be frozen now)
- Preparing to restore the image saved at hibernate-time
- Restore succeeded (called after user-space threads are thawed)


What the Windows driver does is destroy all the virtqueues before
suspend and re-init all of them on restore.  This works well, but in the
Linux case, we don't have a notifier that gets called after restore
succeeds and before user-space tasks are thawed, which means for an open
virtio-serial port, a userspace app doing non-stop writes may find the
communication channel broken because the underlying vq vanished.

Windows has one problem with the balloon driver too -- inflate a
balloon, hibernate.  Start the machine, restore image.  Windows thinks
balloon is inflated.  qemu thinks it's deflated.  This can be solved by
Windows providing a balloon size update to qemu but will most perhaps
need a change to qemu.

For network ports, I guess it'll be the same situation - getting the
network up before userspace notices.

		Amit
