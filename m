From: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH resend] block: silently error unsupported
	empty barriers too
Date: Thu, 15 Oct 2009 01:23:50 +0100
Message-ID: <20091015002350.GV16950__46205.1290473484$1255566288$gmane$org@agk-dp.fab.redhat.com>
References: <1251992870.3084.125.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1251992870.3084.125.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark McLoughlin <markmc@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 03, 2009 at 04:47:50PM +0100, Mark McLoughlin wrote:
> We should error all barriers, even empty barriers, on devices like
> virtio_blk which don't support them.

Acked-by: Alasdair G Kergon <agk@redhat.com>
