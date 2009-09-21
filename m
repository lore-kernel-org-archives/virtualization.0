From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Mon, 21 Sep 2009 11:06:38 +0100
Message-ID: <20090921110638.02a2e3e1__6876.97305479578$1253527936$gmane$org@linux.intel.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090911163806.GB25535@amit-x200.redhat.com>
	<4AAA8838.1080106@codemonkey.ws>
	<20090911173307.GB27046@amit-x200.redhat.com>
	<4AAA8A56.3040707@codemonkey.ws>
	<20090916112332.6bf981a5@linux.intel.com>
	<4AB164A0.8000402@codemonkey.ws>
	<20090918170048.53ba8cf6@linux.intel.com>
	<4AB3C988.2040303@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AB3C988.2040303@codemonkey.ws>
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

> Again, this is paravirtual serial device and I think it's entirely 
> reasonable for people to hook up these ports in the guest directly to 
> physical serial devices in the host.

virtio doesn't support all those features.

> I fail to see how this is at all relevant.  This is a virtual
> machine, we're presenting virtual hardware that behaves like a serial
> device.

The more important question is what you are using it for, and when you
ask that question it looks remarkably unlike a tty or serial port and
rather more like a message and status passing bus ?
