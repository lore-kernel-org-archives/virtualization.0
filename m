From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [dm-devel] [PATCH] block: silently error unsupported empty
	barriers too
Date: Thu, 6 Aug 2009 08:22:21 -0400
Message-ID: <20090806122221.GA5175__5798.94154002449$1249561441$gmane$org@infradead.org>
References: <1249557257.3721.55.camel@blaa>
	<20090806114550.GL29899@agk-dp.fab.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090806114550.GL29899@agk-dp.fab.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>, device-mapper development <dm-devel@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 06, 2009 at 12:45:50PM +0100, Alasdair G Kergon wrote:
> On Thu, Aug 06, 2009 at 12:14:17PM +0100, Mark McLoughlin wrote:
> > We should error all barriers, even empty barriers, on devices like
> > virtio_blk which don't support them.
>  
> Have you considered whether or not virtio_blk actually needs to
> support empty barriers?

virtio_blk on kvm does not support any barriers at all, similar to many
other drivers out there.  If the queue flags say we don't support
barriers higher layers should not submit any barrier requests.
