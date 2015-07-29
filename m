From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 1/4] fs/anon_inodes: new interface to create new inode
Date: Wed, 29 Jul 2015 11:50:03 +0100
Message-ID: <20150729105003.GB30872__28997.6000706249$1438620810$gmane$org@techsingularity.net>
References: <1436776519-17337-1-git-send-email-gioh.kim@lge.com>
	<1436776519-17337-2-git-send-email-gioh.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1436776519-17337-2-git-send-email-gioh.kim@lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gioh Kim <gioh.kim@lge.com>
Cc: aquini@redhat.com, mst@redhat.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, minchan@kernel.org, Gioh Kim <gurugio@hanmail.net>, linux-mm@kvack.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, jlayton@poochiereds.net, koct9i@gmail.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 13, 2015 at 05:35:16PM +0900, Gioh Kim wrote:
> From: Gioh Kim <gurugio@hanmail.net>
> 
> The anon_inodes has already complete interfaces to create manage
> many anonymous inodes but don't have interface to get
> new inode. Other sub-modules can create anonymous inode
> without creating and mounting it's own pseudo filesystem.
> 
> Signed-off-by: Gioh Kim <gioh.kim@lge.com>
> Acked-by: Rafael Aquini <aquini@redhat.com>

This is my first run through the series so I'm going to miss details but
this patch confuses me a little. You create an inode to associate with
the balloon dev_info so that page->mapping can be assigned. It's only the
mapping you care about for the aops so why are multiple inodes required? A
driver should be able to share and reference count a single inode. The
motivation to do it that way would be to reduce memory consumption and
this series is motivated by embedded platforms.

anon_inode_getfd has the following

 * Creates a new file by hooking it on a single inode. This is useful for files
 * that do not need to have a full-fledged inode in order to operate correctly.
 * All the files created with anon_inode_getfd() will share a single inode,
 * hence saving memory and avoiding code duplication for the file/inode/dentry
 * setup.  Returns new descriptor or an error code.

If all we care about the inode is the aops then it would follow that
anon_inode_getfd() is ideal. The tradeoff is reference counting overhead.
The changelog needs to explain why anon_inode_getfd() cannot be used.

-- 
Mel Gorman
SUSE Labs
