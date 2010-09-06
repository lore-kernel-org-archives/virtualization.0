From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Using virtio as a physical (wire-level) transport
Date: Mon, 6 Sep 2010 14:19:36 +0300
Message-ID: <20100906111936.GB15608__26842.1330758885$1283772382$gmane$org@redhat.com>
References: <20100804230441.GJ23951@ovro.caltech.edu>
	<20100805213050.GA24984@redhat.com>
	<20100805230102.GD4757@ovro.caltech.edu>
	<20100805232042.GA27651@redhat.com>
	<20100806153427.GB12392@ovro.caltech.edu>
	<4C336074-FC8C-4BDF-B945-5295133CDB38@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C336074-FC8C-4BDF-B945-5295133CDB38@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Zang Roy <r61911@freescale.com>, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 14, 2010 at 07:34:19AM -0400, Alexander Graf wrote:
> I'd vote for defining virtio v2 that makes everything LE. Maybe we
> could even have an LE capability with a grace period of phasing out
> non-LE capable hosts and guests.

So there are multiple ideas floating for modifying the ring,
and together they might warrant virtio2.
This includes removing available ring, publishing consumer indexes,
possibly some interrupt mitigation ideas, and we can put
endian-ness there.

-- 
MST
