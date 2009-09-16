From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Wed, 16 Sep 2009 11:23:32 +0100
Message-ID: <20090916112332.6bf981a5__19743.4839014479$1253097069$gmane$org@linux.intel.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090911163806.GB25535@amit-x200.redhat.com>
	<4AAA8838.1080106@codemonkey.ws>
	<20090911173307.GB27046@amit-x200.redhat.com>
	<4AAA8A56.3040707@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AAA8A56.3040707@codemonkey.ws>
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
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> This device is very much a serial port.  I don't see any reason not
> to treat it like one.

Here are a few

- You don't need POSIX multi-open semantics, hangup and the like
- Seek makes sense on some kinds of fixed attributes
- TTY has a relatively large memory overhead per device
- Sysfs is what everything else uses
- Sysfs has some rather complete lifetime management you'll need to
  redo by hand
- You don't need idiotic games with numbering spaces

Abusing tty for this is ridiculous. In some ways putting much of it in
kernel is ridiculous too as you can do it with a FUSE fs or simply
export the info guest-guest using SNMP.

Alan
