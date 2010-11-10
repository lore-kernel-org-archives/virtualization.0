From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: fix format of sysfs driver/vendor files
Date: Wed, 10 Nov 2010 23:21:25 +1030
Message-ID: <201011102321.26288.rusty@rustcorp.com.au>
References: <20101109222029.65f3e192@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101109222029.65f3e192@nehalam>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Greg KH <greg@kroah.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 10 Nov 2010 04:50:29 pm Stephen Hemminger wrote:
> The sysfs files for virtio produce the wrong format and are missing
> the required newline. The output for virtio bus vendor/device should
> have the same format as the corresponding entries for PCI devices.
> 
> Although this technically changes the ABI for sysfs, these files were
> broken to start with!

Agreed, and I don't think anyone currently uses them.

Applied,
Rusty.
