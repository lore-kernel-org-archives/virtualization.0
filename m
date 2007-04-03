From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 03 Apr 2007 14:00:39 -0700
Message-ID: <4612C077.60502@goop.org>
References: <4611652F.700@zytor.com> <200704031951.00544.arnd@arndb.de>
	<4612A5F0.2080609@goop.org> <200704032142.51976.arnd@arndb.de>
	<4612B123.2040105@goop.org> <4612B303.5000109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4612B303.5000109@zytor.com>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Arnd Bergmann <arnd@arndb.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> However, there are other things; console is some, or my original
> example, which was random number generation.  For those, the benefit
> of unification is proportionally greater, simply because the win of
> anything hypervisor-specific is much smaller. =


So, what you're saying is:

   1. assuming there's going to be a vast number of miscellaneous devices
   2. it would be best if there were one per device rather than one per
      hypervisor per device
   3. so we'd have one linux device driver

But this implies that the work is just pushed off into all the
hypervisors to support this new device over the generic interface;
there's no overall reduction of code or complexity, other than making
"wc" on the kernel source smaller.

That said, something like USB is probably the best bet for this kind of
low-performance device.  I think.  Not that I really know anything about
USB.

    J
