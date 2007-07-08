From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/4] Using a generic bus_type for virtio
Date: Sun, 8 Jul 2007 17:55:53 +0200
Message-ID: <200707081755.53395.arnd@arndb.de>
References: <20070706124200.988637662@arndb.de>
	<1183860930.6005.212.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183860930.6005.212.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 08 July 2007, Rusty Russell wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0I think it will come down to how neat PCI<->vir=
tio is. =A0Can we push
> further towards PCI without screwing non-PCI? =A0eg. can we use
> pci_device_id? =A0struct pci_driver? =A0(Might be pushing it, but shoul=
d
> probably be considered: it'd be neat if some platforms could #define
> virtio_driver_register pci_driver_register).

My idea was to have the virtio device as a child of the PCI device
instead. That way the PCI virtio host can do its own probing without
burdening the virtio bus layer with PCI specific implementation details.

> =A0=A0=A0=A0=A0=A0=A0=A0Standardizing how to pack the info for each dev=
ice into the config
> space would be especially useful. =A0Our drivers are going to get more
> featureful, and we're going to need a versioning/compatibility scheme
> too.

So do you like the splitting of the config space into host and driver par=
t
into 128 bytes each?
That would split the need for versioning between host and driver.

Do you think the config space needs to be writable by the driver?
For the host part, we need to have it writable in case of a PCI host,
which finds stuff like BAR sizes using write access, but requiring that
every host has writable configuration data could make it harder for
some hosts.

	Arnd <><
