From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Using virtio as a physical (wire-level) transport
Date: Fri, 6 Aug 2010 00:30:50 +0300
Message-ID: <20100805213050.GA24984__7494.55847912959$1281047048$gmane$org@redhat.com>
References: <20100804230441.GJ23951@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100804230441.GJ23951@ovro.caltech.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: netdev@vger.kernel.org, Zang Roy <r61911@freescale.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Ira,

> Making my life harder since the last time I tried this, mainline commit
> 7c5e9ed0c (virtio_ring: remove a level of indirection) has removed the
> possibility of using an alternative virtqueue implementation. The commit
> message suggests that you might be willing to add this capability back.
> Would this be an option?

Sorry about that.

With respect to this commit, we only had one implementation upstream
and extra levels of indirection made extending the API
much harder for no apparent benefit.

When there's more than one ring implementation with very small amount of
common code, I think that it might make sense to readd the indirection
back, to separate the code cleanly.

OTOH if the two implementations share a lot of code, I think that it
might be better to just add a couple of if statements here and there.
This way compiler even might have a chance to compile the code out if
the feature is disabled in kernel config.

-- 
MST
