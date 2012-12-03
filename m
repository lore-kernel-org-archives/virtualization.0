From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: xen/blkback: Persistent grant maps for xen blk drivers
Date: Tue, 4 Dec 2012 00:06:17 +0300
Message-ID: <20121203210617.GA1513@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

Hello Roger Pau Monne,

The patch 0a8704a51f38: "xen/blkback: Persistent grant maps for xen 
blk drivers" from Oct 24, 2012, leads to the following warning:
drivers/block/xen-blkfront.c:807 blkif_free()
	 warn: 'persistent_gnt' was already freed.

   807                  llist_for_each_entry(persistent_gnt, all_gnts, node) {
   808                          gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
   809                          __free_page(pfn_to_page(persistent_gnt->pfn));
   810                          kfree(persistent_gnt);
                                      ^^^^^^^^^^^^^^
We dereference this to find the next element in the list.  It will work
if you don't have poisoning enabled or if the memory is not used
immediately by another process.  In other words, there will be rare
bugs where this causes a hard to debug crash or if you have poisoning
enabled it will have an easy to debug crash.

   811                  }

regards,
dan carpenter
