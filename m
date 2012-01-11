From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 11 Jan 2012 23:58:09 +0200
Message-ID: <20120111215808.GB27292@redhat.com>
References: <20120111151230.GA20570@redhat.com>
	<4F0DA7A5.7050600@codemonkey.ws>
	<20120111152129.GB20570@redhat.com>
	<4F0DAA9B.7060703@codemonkey.ws>
	<20120111154515.GD20570@redhat.com>
	<4F0DB2AB.8030506@codemonkey.ws>
	<20120111170859.GA22310@redhat.com>
	<4F0DE62F.6030805@codemonkey.ws>
	<20120111201436.GA27292@redhat.com>
	<4F0DF08F.7010706@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F0DF08F.7010706@codemonkey.ws>
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
Cc: Pawel Moll <pawel.moll@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2012 at 02:26:55PM -0600, Anthony Liguori wrote:
> On 01/11/2012 02:14 PM, Michael S. Tsirkin wrote:
> >On Wed, Jan 11, 2012 at 01:42:39PM -0600, Anthony Liguori wrote:
> >>On 01/11/2012 11:08 AM, Michael S. Tsirkin wrote:
> >>>
> >>>Not sure what you mean. Using VQ is DMA which is pretty common for PCI.
> >>
> >>Do you know of a network device that obtains it's mac address via a DMA transaction?
> >
> >Sure.
> >See mlx4_replace_mac in drivers/net/ethernet/mellanox/mlx4/port.c
> 
> I'd say that's a special case but I see what you're getting at here.
> 
> So what about keeping the config space read-only and using control
> queues for everything else?

Not just read-only - constant.

> Regards,
> 
> Anthony Liguori
> 
> >
> >>Regards,
> >>
> >>Anthony Liguori
> >>
> >>>
> >>>>>
