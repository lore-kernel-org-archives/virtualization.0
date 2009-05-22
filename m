From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] xen/blkfront: beyond ARRAY_SIZE of
	info->shadow
Date: Fri, 22 May 2009 09:16:09 +0200
Message-ID: <20090522071609.GF11363@kernel.dk>
References: <4A15A0D2.7090209@gmail.com> <4A15A208.5070206@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <4A15A208.5070206@goop.org>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, xen-devel@lists.xensource.com, Roel Kluin <roel.kluin@gmail.com>, jeremy@xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 21 2009, Jeremy Fitzhardinge wrote:
> Roel Kluin wrote:
>> Do not go beyond ARRAY_SIZE of info->shadow
>>
>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>>   
> Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
>
> Jens, can you put this into a next-merge-window branch?

Sure, will do.

-- 
Jens Axboe
