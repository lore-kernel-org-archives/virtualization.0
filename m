From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [dm-devel] [PATCH resend] block: silently error unsupported
	empty barriers too
Date: Thu, 15 Oct 2009 15:11:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910151510340.22075__14483.0465470024$1255634019$gmane$org@hs20-bc2-1.build.redhat.com>
References: <1251992870.3084.125.camel@blaa>
	<20091015002350.GV16950@agk-dp.fab.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091015002350.GV16950@agk-dp.fab.redhat.com>
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
Cc: Mark McLoughlin <markmc@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org



On Thu, 15 Oct 2009, Alasdair G Kergon wrote:

> On Thu, Sep 03, 2009 at 04:47:50PM +0100, Mark McLoughlin wrote:
> > We should error all barriers, even empty barriers, on devices like
> > virtio_blk which don't support them.
> 
> Acked-by: Alasdair G Kergon <agk@redhat.com>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>
