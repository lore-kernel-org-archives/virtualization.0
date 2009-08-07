From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [dm-devel] [PATCH] block: silently error unsupported empty
	barriers too
Date: Thu, 6 Aug 2009 21:50:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0908062148060.8764__5854.26560505784$1249665153$gmane$org@hs20-bc2-1.build.redhat.com>
References: <1249557257.3721.55.camel@blaa>
	<20090806114550.GL29899@agk-dp.fab.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Alasdair G Kergon <agk@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, device-mapper development <dm-devel@redhat.com>, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 6 Aug 2009, Alasdair G Kergon wrote:

> On Thu, Aug 06, 2009 at 12:14:17PM +0100, Mark McLoughlin wrote:
> > We should error all barriers, even empty barriers, on devices like
> > virtio_blk which don't support them.
>  
> Have you considered whether or not virtio_blk actually needs to
> support empty barriers?
> 
> Alasdair

This is only for request-based drivers, where it is the responsibility of 
blk-core to translate barriers. I think the empty barrier request anyway 
in blk_do_ordered, but with an error message. So the patch changes it to 
discard it early and queitly. It seems ok.

Mikulas
