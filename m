From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Sun, 11 Aug 2019 07:56:07 +0200
Message-ID: <20190811055607.GA12488@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190810220702.GA5964@ram.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

sev_active() is gone now in linux-next, at least as a global API.

And once again this is entirely going in the wrong direction.  The only
way using the DMA API is going to work at all is if the device is ready
for it.  So we need a flag on the virtio device, exposed by the
hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
don't take a shortcut.

And that means on power and s390 qemu will always have to set thos if
you want to be ready for the ultravisor and co games.  It's not like we
haven't been through this a few times before, have we?
