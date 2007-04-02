From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 02 Apr 2007 15:30:40 -0700
Message-ID: <46118410.2060904@zytor.com>
References: <4611652F.700@zytor.com> <200704022312.39195.ak@suse.de>
	<4611768D.1080801@garzik.org> <200704022336.43136.ak@suse.de>
	<461178D9.402@goop.org> <46117F72.6020506@zytor.com>
	<461182BE.5040902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <461182BE.5040902@garzik.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, virtualization@lists.linux-foundation.org, mathiasen@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeff Garzik wrote:
> =

> Sure, but let's look beyond device detection.  For instance, it does not =

> necessarily follow that emulating PCI DMA is the best way to go for =

> communication with a virtual device, once detected.
> =


This is true, of course.  However, there are going to be a set of =

virtual devices which don't necessarily have to have super-high =

performance.  In the case of a hwrng device, even doing DMA is probably =

overkill.

> Outside of pci_device_id driver matching, is there much value here?

If we can get a set of device drivers that if not all then at least a =

number of hypervisors and/or emulators can agree upon, I think that's =

much won.

	-hpa
