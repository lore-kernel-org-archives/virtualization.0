From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v1 03/19] fs/anon_inodes: new interface to create new inode
Date: Fri, 11 Mar 2016 08:05:03 +0000
Message-ID: <20160311080503.GR17997__15808.0673696988$1457683542$gmane$org@ZenIV.linux.org.uk>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
	<1457681423-26664-4-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1457681423-26664-4-git-send-email-minchan@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 11, 2016 at 04:30:07PM +0900, Minchan Kim wrote:
> From: Gioh Kim <gurugio@hanmail.net>
> 
> The anon_inodes has already complete interfaces to create manage
> many anonymous inodes but don't have interface to get
> new inode. Other sub-modules can create anonymous inode
> without creating and mounting it's own pseudo filesystem.

IMO that's a bad idea.  In case of aio "creating and mounting" takes this:
static struct dentry *aio_mount(struct file_system_type *fs_type,
                                int flags, const char *dev_name, void *data)  
{
        static const struct dentry_operations ops = {
                .d_dname        = simple_dname,
        };
        return mount_pseudo(fs_type, "aio:", NULL, &ops, AIO_RING_MAGIC);
}
and
        static struct file_system_type aio_fs = {
                .name           = "aio",
                .mount          = aio_mount,
                .kill_sb        = kill_anon_super,
        };
        aio_mnt = kern_mount(&aio_fs);

All of 12 lines.  Your export is not much shorter.  To quote old mail on
the same topic:

> Note that anon_inodes.c reason to exist was "it's for situations where
> all context lives on struct file and we don't need separate inode for
> them".  Going from that to "it happens to contain a handy function for inode
> allocation"...
