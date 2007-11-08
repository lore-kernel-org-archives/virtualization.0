From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio config_ops refactoring
Date: Fri, 9 Nov 2007 09:24:28 +1100
Message-ID: <200711090924.28659.rusty__30523.5204090879$1194560867$gmane$org@rustcorp.com.au>
References: <4730A8F3.6020008@us.ibm.com>
	<200711081320.35844.rusty__6233.15023626692$1194488552$gmane$org@rustcorp.com.au>
	<4732774C.6020903@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4732774C.6020903@codemonkey.ws>
Content-Disposition: inline
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 08 November 2007 13:41:16 Anthony Liguori wrote:
> Rusty Russell wrote:
> > On Thursday 08 November 2007 04:30:50 Anthony Liguori wrote:
> >> I would prefer that the virtio API not expose a little endian standard.
> >> I'm currently converting config->get() ops to ioreadXX depending on the
> >> size which already does the endianness conversion for me so this just
> >> messes things up.  I think it's better to let the backend deal with
> >> endianness since it's trivial to handle for both the PCI backend and the
> >> lguest backend (lguest doesn't need to do any endianness conversion).
> >
> > -ETOOMUCHMAGIC.  We should either expose all the XX interfaces (but this
> > isn't a high-speed interface, so let's not) or not "sometimes" convert
> > endianness. Getting surprises because a field happens to be packed into 4
> > bytes is counter-intuitive.
>
> Then I think it's necessary to expose the XX interfaces.  Otherwise, the
> backend has to deal with doing all register operations at a per-byte
> granularity which adds a whole lot of complexity on a per-device basis
> (as opposed to a little complexity once in the transport layer).

Huh?  Take a look at the drivers, this simply isn't true.  Do you have 
evidence that it will be true later?

Plus your code will be smaller doing a single writeb/readb loop than trying to 
do a switch statement.

> You really want to be able to rely on multi-byte atomic operations too
> when setting values.  Otherwise, you need another register to just to
> signal when it's okay for the device to examine any given register.

You already do; the status register fills this role.  For example, you can't 
tell what features a guest understands until it updates the status register.

Hope that clarifies,
Rusty.
