From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: xen-blkback: move free persistent grants code
Date: Tue, 4 Dec 2012 00:14:26 +0300
Message-ID: <20121203211425.GB22569@mwanda>
References: <20121203211148.GA3335@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121203211148.GA3335@elgon.mountain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: roger.pau@citrix.com
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 04, 2012 at 12:11:48AM +0300, Dan Carpenter wrote:
> Hello Roger Pau Monne,
> 
> The patch 4d4f270f1880: "xen-blkback: move free persistent grants
> code" from Nov 16, 2012, leads to the following warning:
> drivers/block/xen-blkback/blkback.c:238 free_persistent_gnts()
> 	 warn: 'persistent_gnt' was already freed.
> 
> drivers/block/xen-blkback/blkback.c
>    232                  pages[segs_to_unmap] = persistent_gnt->page;
>    233                  rb_erase(&persistent_gnt->node, root);
>    234                  kfree(persistent_gnt);
>                         ^^^^^^^^^^^^^^^^^^^^
> kfree();
> 

Also persistent_gnt is the list iterator inside a foreach_grant()
loop.  It needs a _safe() version like list_for_each_safe() where it
saves the next entry in the list at the start so we don't
dereference a freed entry.

regards,
dan carpenter
