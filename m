From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Sat, 28 Jul 2018 14:07:20 +0530
Message-ID: <986656ee-37e9-0d99-3d1f-a48466ffe0ed@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720161541-mutt-send-email-mst@kernel.org>
	<8f51d2c6-cc0c-9e42-f0fd-a8a33acc8b83@linux.vnet.ibm.com>
	<20180723120511-mutt-send-email-mst@kernel.org>
	<4062dd48-2b5b-e454-e860-c6bfe321ebdc@linux.vnet.ibm.com>
	<20180727143008-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180727143008-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On 07/27/2018 05:01 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 25, 2018 at 08:56:23AM +0530, Anshuman Khandual wrote:
>> Results with and without the patches are similar.
> 
> Thanks! And another thing to try is virtio-net with
> a fast NIC backend (40G and up). Unfortunately
> at this point loopback tests stress the host
> scheduler too much.
> 

Sure. Will look around for a 40G NIC system. BTW I have been testing
virtio-net with a TAP device as back end.

ip tuntap add dev tap0 mode tap user $(whoami)
ip link set tap0 master virbr0
ip link set dev virbr0 up
ip link set dev tap0 up

which is exported into the guest as follows

-device virtio-net,netdev=network0,mac=52:55:00:d1:55:01 \
-netdev tap,id=network0,ifname=tap0,script=no,downscript=no \

But I have not run any network benchmarks on it though.
