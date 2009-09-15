From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for generic
	guest and host communication
Date: Tue, 15 Sep 2009 09:09:41 -0500
Message-ID: <4AAFA025.3050401@codemonkey.ws>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090915123752.GB5247@amit-x200.redhat.com>
	<4AAF8F26.8030503@codemonkey.ws> <4AAF9FD8.1010008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AAF9FD8.1010008@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
>> Userspace can detect when new virtio-consoles appear via udev events.
>> When it sees a new ttyVN, it can then look in sysfs to discover it's 
>> name.
>
> No.  udev can create symlinks for you, so apps don't have to dig into 
> sysfs.  You'll need a rule along the lines (untested):
>
>    SUBSYSTEM=="virtio", \
>    DRIVERS="virtio-console", \
>    SYMLINK+="vcon/$attr{name}"
>
> then udev will create a /dev/vcon/org.qemu.clipboard symlink pointing 
> to dev/ttyV0.  Apps can just open /dev/vcon/$name then.

That works equally well.  I don't necessarily think that naming is more 
useful.

Regards,

Anthony Liguori
