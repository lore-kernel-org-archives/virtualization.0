From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-pci: also bind to Amazon PCI vendor ID
Date: Tue, 16 Sep 2014 10:54:55 +0200
Message-ID: <1410857695.32607.3.camel@nilsson.home.kraxel.org>
References: <1410751773-10519-1-git-send-email-anthony@codemonkey.ws>
	<20140915082015.GB6480@redhat.com>
	<CA+aC4kvj8B3vsxfq8FSSc9AzQc=4+4poY=Ro2tbH7Yt2FFGFQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+aC4kvj8B3vsxfq8FSSc9AzQc=4+4poY=Ro2tbH7Yt2FFGFQw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: virtualization@lists.linux-foundation.org, kernel@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>, Matt Wilson <msw@amazon.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> But this is independent of WHQL certification.  My understanding is
> that Microsoft will only allow the owner of the PCI Vendor ID to WHQL
> drivers.  As best as I know, this is not a publicly documented
> process.
> 
> Do you have any examples of anyone else successfuling WHQL'ing drivers
> by just changing the subsystem ID?  Microsoft has specific rules about
> the usage of the subsystem ID.  See
> http://msdn.microsoft.com/en-us/library/windows/hardware/dn653567%28v=vs.85%29.aspx.
> I don't think it is intended to enable a totally different
> implementation of the driver based on subsystem ID.
> 
> Certainly, this is not expected with typical PCI devices.

Well, no.  It is the whole point why the subsystem ids exist in the
first place.

Manufacturer A builds a pci chip.
Manufacturer B builds a pci card using that chip, but custom hardware
around it.

PCI ID is the one of manufacturer A.
PCI subsystem ID is the one of manufacturer B.
Of course manufacturer B writes, certificates and ships the drivers for
the device.

Example: es1370 sound card chip.  The es1730 emulation in qemu has *not*
the default qemu subsystem id, exactly because the drivers need the
subsystem id to figure what the correct driver is.

Other example: There have been tons of TV cards in the late 90ies, all
based on the bt848/bt878 pci chip, but all with different tuner chips
hooked up, and you need to look at the subsystem id to figure what card
it is, which tuner it has and which tv standards and frequencies it can
handle.

cheers,
  Gerd
