From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Thu, 7 Dec 2017 08:45:33 -0800
Message-ID: <CAKgT0UfC2o4P8DeRHnnPV9fvUzJYbkCKVHr=zHOfbEQdLn=3nA__1737.77023233033$1513195161$gmane$org@mail.gmail.com>
References: <0fb552d4-1bfc-e130-4fc1-87b83873916d@redhat.com>
	<CAEHy93LneRXNWo64uyN2dfyDX6t18WN+YwVF2RXXLRnr0=Jhww@mail.gmail.com>
	<20171130155612-mutt-send-email-mst@kernel.org>
	<780cf854-83e1-b2a4-0f07-74372a972ca6@oracle.com>
	<20171203065759-mutt-send-email-mst@kernel.org>
	<CAEHy93+yhRtTQub0xk5W1jKRNisrcRBtNexcwRfWdSKPm5a4Gw@mail.gmail.com>
	<20171203093524.26491cd0@xeon-e3>
	<CAEHy93LEr5h81KGfJBr5Z4ZKaeWEWwQL1LYfZNXoVF_HB6TQGw@mail.gmail.com>
	<CAKgT0Uf5gta+CNM3ReybV3qNMJXqoT9BHvMjKRbd=PYOPQrQaA@mail.gmail.com>
	<CAEHy93Kw-GePsraaAkVZNbOwt=rDPMVjmwuU22004LHCAoSSFA@mail.gmail.com>
	<20171205211603-mutt-send-email-mst@kernel.org>
	<CAEHy93JG-X-5qtrU2wUmxfMzKc9G3GDNL_H-FXsmAmfwvoO+vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAEHy93JG-X-5qtrU2wUmxfMzKc9G3GDNL_H-FXsmAmfwvoO+vg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: achiad shochat <achiad.mellanox@gmail.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Hannes Frederic Sowa <hannes@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Shannon Nelson <shannon.nelson@oracle.com>, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, netdev <netdev@vger.kernel.org>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 6, 2017 at 11:28 PM, achiad shochat
<achiad.mellanox@gmail.com> wrote:
> On 5 December 2017 at 21:20, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Tue, Dec 05, 2017 at 11:59:17AM +0200, achiad shochat wrote:
>>> Then we'll have a single solution for both netvsc and virtio (and any
>>> other PV device).
>>> And we could handle the VF DMA dirt issue agnostically.
>>
>> For the record, I won't block patches adding this kist to virtio
>> on the basis that they must be generic. It's not a lot
>> of code, implementation can come first, prettify later.
>
> It's not a lot of code either way.
> So I fail to understand why not to do it right from the beginning.
> For the record...

What isn't a lot of code? If you are talking about the DMA dirtying
then I would have to disagree. The big problem with the DMA is that we
have to mark a page as dirty and non-migratable as soon as it is
mapped for Rx DMA. It isn't until the driver has either unmapped the
page or the device has been disabled that we can then allow the page
to be migrated for being dirty. That ends up being the way we have to
support this if we don't have the bonding solution.

With the bonding solution we could look at doing a lightweight DMA
dirtying which would just require flagging pages as dirty after an
unmap or sync call is performed. However it requires that we shut down
the driver/device before we can complete the migration which means we
have to have the paravirtualized fail-over approach.

As far as indicating that the interfaces are meant to be enslaved I
wonder if we couldn't look at tweaking the PCI layout of the guest and
use that to indicate that a given set of interfaces are meant to be
bonded. For example the VFs are all meant to work as a part of a
multi-function device. What if we were to make virtio-net function 0
of a PCI/PCIe device, and then place any direct assigned VFs that are
meant to be a part of the bond in functions 1-7 of the device? Then it
isn't too far off from the model we have on the host where if the VF
goes away we would expect to see the traffic on the PF that is usually
occupying function 0 of a given device.
