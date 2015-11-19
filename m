From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC] kvmtool: add support for modern virtio-pci
Date: Thu, 19 Nov 2015 15:55:02 +0100
Message-ID: <1447944902.25140.74.camel__33718.5143646368$1447944933$gmane$org@redhat.com>
References: <1447823472-17047-1-git-send-email-sasha.levin@oracle.com>
	<1447834972.23726.92.camel@redhat.com> <564C9805.8080800@oracle.com>
	<1447869140.23691.15.camel@redhat.com> <564D496D.2010105@oracle.com>
	<564D49A7.30400@oracle.com> <1447917670.25140.3.camel@redhat.com>
	<564DD178.9010904@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <564DD178.9010904@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, andre.przywara@arm.com, will.deacon@arm.com, josh@joshtriplett.org, virtualization@lists.linux-foundation.org, penberg@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> That was indeed the ISR field. Fixing that makes seabios reach the same point as
> legacy virtio before failing.
> 
> I don't see the original correspondence about seabios failures you've reported, if
> you want to forward them over we can look at it further.

It was a few months back, when I posted the seabios patches for kvmtool
to both seabios and kvm lists.

Issue #1 is that kvmtool adds a bunch of kernel command line options,
not only for stuff like rootfs configuration, but also to force specific
things the kernel fails to autodetect (or to speedup boot by
shortcutting hardware probing).  Among them is "pci=conf1", without that
the kernel doesn't find a pci bus and therefore also doesn't find the
virtio-{blk,net} devices.

So, when booting with seabios and let grub or another boot loader load
the kernel from the guest disk image those kernel arguments are not
there.  Of course you can boot the image with qemu, add "pci=conf1" to
grub.cfg (maybe others are required too, don't remember exactly), then
try again with kvmtool.  That gets the boot one step further and leads
to ...

Issue #2: virtio kernel drivers fail initialize the virtio devices.
I suspect virtio device reset is not implemented properly and because of
that the state of the device as left by seabios confuses the kernel
driver.  Didn't check that in detail though.

cheers,
  Gerd
