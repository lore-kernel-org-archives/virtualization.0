From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 02 Apr 2007 15:04:25 -0700
Message-ID: <46117DE9.6060506@goop.org>
References: <4611652F.700@zytor.com> <200704022312.39195.ak@suse.de>	<4611768D.1080801@garzik.org> <200704022336.43136.ak@suse.de> <461178D9.402@goop.org> <46117B62.9030902@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965977AbXDBWEe@vger.kernel.org>
In-Reply-To: <46117B62.9030902@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeff Garzik <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> The actual PCI bus could paravirtualized.  It's just a question of
> whether one reinvents a device discovery mechanism (like XenBus) or
> whether one piggy backs on existing mechanisms.
>
> Furthermore, in the future, I strongly suspect that HVM will become
> much more important for Xen than PV and since that already has a PCI
> bus it's not really that big of a deal. 

Well, obviously it keeps things simple for me to not worry about PCI
support in Xen at this point.  But I was thinking more of lguest; I
think PCI emulation would kill puppies.

    J
