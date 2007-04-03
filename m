From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 22:50:19 +0200
Message-ID: <200704032250.19875.arnd@arndb.de>
References: <4611652F.700@zytor.com> <200704032142.51976.arnd@arndb.de>
	<4612B123.2040105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4612B123.2040105@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 April 2007, Jeremy Fitzhardinge wrote:
> > Doing a SCSI driver has been tried before, with ibmvscsi. Not good.
> > =A0 =

> =

> OK, interesting. =A0People had proposed using SCSI as the interface, but I
> wasn't aware of any results from doing that. =A0How is it not good?
> =


SCSI is really overengineered for something as simple as a block interface.
A large part of the SCSI stack deals only with error handling, which
you don't want to burden the guests with at all, since most error conditions
can be handled fine by the host.
Another big aspect of SCSI is device enumeration and probing. Doing it
the SCSI way is particularly pointless. It's much simpler to have one
device with its own I/O interface at the hcall layer, and one interrupt
number for the block device, instead of faking the full hca/bus/dev/lun
hierarchy.

	Arnd <><
