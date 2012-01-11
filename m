From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 07:59:18 +1100
Message-ID: <1326315558.23910.140.camel@pasglop>
References: <878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com> <8762gj6q5r.fsf@rustcorp.com.au>
	<4F0D8EFA.3010503@codemonkey.ws> <20120111151230.GA20570@redhat.com>
	<4F0DA7A5.7050600@codemonkey.ws> <20120111152129.GB20570@redhat.com>
	<4F0DAA9B.7060703@codemonkey.ws> <20120111154515.GD20570@redhat.com>
	<4F0DB2AB.8030506@codemonkey.ws> <20120111170859.GA22310@redhat.com>
	<4F0DE62F.6030805@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F0DE62F.6030805@codemonkey.ws>
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
Cc: Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-01-11 at 13:42 -0600, Anthony Liguori wrote:
> On 01/11/2012 11:08 AM, Michael S. Tsirkin wrote:
> >
> > Not sure what you mean. Using VQ is DMA which is pretty common for PCI.
> 
> Do you know of a network device that obtains it's mac address via a DMA transaction?

I wouldn't be surprised if we could find one, but even if we don't why
is that an issue ?

Cheers,
Ben.
