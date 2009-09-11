From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for generic
	guest and host communication
Date: Fri, 11 Sep 2009 12:26:16 -0500
Message-ID: <4AAA8838.1080106__16696.7489444234$1252690048$gmane$org@codemonkey.ws>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090911163806.GB25535@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090911163806.GB25535@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> Right; there was some discussion about this. A few alternatives were
> suggested like
>
> - udev scripts to create symlinks from ports to function, like:
>
>   /dev/vcon3 -> /dev/virtio-console/clipboard
>
> - Some fqdn-like hierarchy, like
>
>   /dev/virtio-console/com/redhat/clipboard
>
>   which again can be created by udev scripts
>   

And I dislike all of them.  What I'd rather have is these devices 
exposed as tty's with a sys attribute that exposed the name of the device.

This is not all that different to how usb serial devices work.

Regards,

Anthony Liguori
