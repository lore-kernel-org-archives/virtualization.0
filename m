From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for generic
	guest and host communication
Date: Tue, 15 Sep 2009 16:08:24 +0200
Message-ID: <4AAF9FD8.1010008@redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090915123752.GB5247@amit-x200.redhat.com>
	<4AAF8F26.8030503@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AAF8F26.8030503@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/15/09 14:57, Anthony Liguori wrote:
> That's probably not what we want. I imagine what we want is:
>
> /dev/ttyV0
> /dev/ttyV1
> /dev/ttyVN

Yes.

> And then we want:
>
> /sys/class/virtio-console/ttyV0/name -> "org.qemu.clipboard"

Yes.

> Userspace can detect when new virtio-consoles appear via udev events.
> When it sees a new ttyVN, it can then look in sysfs to discover it's name.

No.  udev can create symlinks for you, so apps don't have to dig into 
sysfs.  You'll need a rule along the lines (untested):

    SUBSYSTEM=="virtio", \
    DRIVERS="virtio-console", \
    SYMLINK+="vcon/$attr{name}"

then udev will create a /dev/vcon/org.qemu.clipboard symlink pointing to 
dev/ttyV0.  Apps can just open /dev/vcon/$name then.

cheers,
   Gerd
