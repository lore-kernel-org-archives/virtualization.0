From: Jeff Garzik <jeff@garzik.org>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 02 Apr 2007 18:25:02 -0400
Message-ID: <461182BE.5040902@garzik.org>
References: <4611652F.700@zytor.com> <200704022312.39195.ak@suse.de>
	<4611768D.1080801@garzik.org> <200704022336.43136.ak@suse.de>
	<461178D9.402@goop.org> <46117F72.6020506@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46117F72.6020506@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, virtualization@lists.linux-foundation.org, mathiasen@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> However, one probably wants to think about what the heck one actually =

> means with "virtualization" in the absence of a lot of this stuff.  PCI =

> is probably the closest thing we have to a lowest common denominator for =

> device detection.


Sure, but let's look beyond device detection.  For instance, it does not =

necessarily follow that emulating PCI DMA is the best way to go for =

communication with a virtual device, once detected.

Outside of pci_device_id driver matching, is there much value here?

	Jeff
