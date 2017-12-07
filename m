From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Thu, 7 Dec 2017 18:53:05 +0200
Message-ID: <20171207184829-mutt-send-email-mst@kernel.org>
References: <780cf854-83e1-b2a4-0f07-74372a972ca6@oracle.com>
	<20171203065759-mutt-send-email-mst@kernel.org>
	<CAEHy93+yhRtTQub0xk5W1jKRNisrcRBtNexcwRfWdSKPm5a4Gw@mail.gmail.com>
	<20171203093524.26491cd0@xeon-e3>
	<CAEHy93LEr5h81KGfJBr5Z4ZKaeWEWwQL1LYfZNXoVF_HB6TQGw@mail.gmail.com>
	<CAKgT0Uf5gta+CNM3ReybV3qNMJXqoT9BHvMjKRbd=PYOPQrQaA@mail.gmail.com>
	<CAEHy93Kw-GePsraaAkVZNbOwt=rDPMVjmwuU22004LHCAoSSFA@mail.gmail.com>
	<20171205211603-mutt-send-email-mst@kernel.org>
	<CAEHy93JG-X-5qtrU2wUmxfMzKc9G3GDNL_H-FXsmAmfwvoO+vg@mail.gmail.com>
	<CAKgT0UfC2o4P8DeRHnnPV9fvUzJYbkCKVHr=zHOfbEQdLn=3nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKgT0UfC2o4P8DeRHnnPV9fvUzJYbkCKVHr=zHOfbEQdLn=3nA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Hannes Frederic Sowa <hannes@redhat.com>, achiad shochat <achiad.mellanox@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Shannon Nelson <shannon.nelson@oracle.com>, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, netdev <netdev@vger.kernel.org>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 07, 2017 at 08:45:33AM -0800, Alexander Duyck wrote:
> As far as indicating that the interfaces are meant to be enslaved I
> wonder if we couldn't look at tweaking the PCI layout of the guest and
> use that to indicate that a given set of interfaces are meant to be
> bonded. For example the VFs are all meant to work as a part of a
> multi-function device. What if we were to make virtio-net function 0
> of a PCI/PCIe device, and then place any direct assigned VFs that are
> meant to be a part of the bond in functions 1-7 of the device? Then it
> isn't too far off from the model we have on the host where if the VF
> goes away we would expect to see the traffic on the PF that is usually
> occupying function 0 of a given device.

This pretty much precludes removing them with hotplug.

But as long as we are happy to limit this to pci devices,
maybe we should put them behind a pci bridge.

All devices behind a bridge would be assumed to have
the same backend.

QEMU has pci-bridge-seat which we could reuse for this -
just need to build a similar pci express bridge.

-- 
MST
