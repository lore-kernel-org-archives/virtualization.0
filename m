From: Milton Miller <miltonm@bga.com>
Subject: Re: virtio-pci: add softlinks between virtio and pci
Date: Fri, 07 Jan 2011 02:54:31 -0600
Message-ID: <virtio-pci-whynotsimplify__19985.1343794309$1294419471$gmane$org@mdm.bga.com>
References: <20110105191711.GA27489@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <aliguori@us.ibm.com>, Jamie Lokier <jamie@shareable.org>, Thomas
List-Id: virtualization@lists.linuxfoundation.org


On: Wed, 05 Jan 2011 at about 19:17:11 -0000, Michael S. Tsirkin wrote:
> We sometimes need to map between the virtio device and
> the given pci device. One such use is OS installer that
> gets the boot pci device from BIOS and needs to
> find the relevant block device. Since it can't,
> installation fails.
> 

> Supply softlinks between these to make it possible.
> 
> Gleb, could you please ack that this patch below
> will be enough to fix the installer issue that
> you see?
> 

why not remove this device anchor and put the devices
under the pci device?   Proposed patch follows as a
reply.

milton
