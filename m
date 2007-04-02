From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 02 Apr 2007 14:42:49 -0700
Message-ID: <461178D9.402@goop.org>
References: <4611652F.700@zytor.com> <200704022312.39195.ak@suse.de>
	<4611768D.1080801@garzik.org> <200704022336.43136.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704022336.43136.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Jeff Garzik <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> The implementation wouldn't need to use PCI at all. There wouldn't =

> even need to be PCI like registers internally. Just a pci device
> with an ID somewhere in sysfs. PCI with unique IDs
> is just a convenient and well established key into the driver module
> collection. Once you have the right driver it can do what it wants.

But I understood hpa's suggestion to mean that there would be a standard
PCI interface for a hardware RNG, and a single linux driver for that
device, which all hypervisors would be expected to implement.  But
that's only reasonable if the virtualization environment has some notion
of PCI to expose to the Linux guest.

    J
