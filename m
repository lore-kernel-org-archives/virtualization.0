From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 9 Jul 2007 13:38:19 +0200
Message-ID: <200707091338.20288.arnd@arndb.de>
References: <20070706124200.988637662@arndb.de>
	<200707091318.48261.arnd@arndb.de> <46921EDF.7080602@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46921EDF.7080602@qumranet.com>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 09 July 2007, Avi Kivity wrote:
> > The problem with hotplugging devices on PCI is that there is not a go=
od
> > standard for this yet. The best option we have is probably PCI expres=
s
> > hotplug, but I'm not sure how many legacy operating systems already s=
upport
> > this.
>=20
> This is indeed a problem. =A0Perhaps we should have a virtqueue for=20
> reconfiguration (with a couple of read messages always queued for=20
> host-side changes, and a write message sent when the guest reconfigures=
).

Yes, that would be my preferred solution as well. For devices that need
reconfiguration capability, one virtqueue for all out-of-band information
should be enough, with device specific messages.

Why do you think we want to have multiple outstanding read messages?
I would guess that a single message is enough, you can always requeue
it after one event gets processed.

	Arnd <><
