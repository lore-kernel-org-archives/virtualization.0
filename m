From: David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 12/12] xfs: eagerly remove vmap mappings to
	avoid upsetting Xen
Date: Tue, 16 Oct 2007 09:04:33 +1000
Message-ID: <20071015230432.GO995458@sgi.com>
References: <20071015204840.074767068@goop.org>
	<20071015210115.506967748@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20071015210115.506967748@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Mark Williamson <mark.williamson@cl.cam.ac.uk>, Nick Piggin <nickpiggin@yahoo.com.au>, xen-devel@lists.xensource.com, XFS masters <xfs-masters@oss.sgi.com>, Keir Fraser <keir@xensource.com>, David Chinner <dgc@sgi.com>, LKML <linux-kernel@vger.kernel.org>, Morten =?iso-8859-1?B?QsO4Z2Vza292?= <xen-users@morten.bogeskov.dk>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 15, 2007 at 01:48:52PM -0700, Jeremy Fitzhardinge wrote:
> XFS leaves stray mappings around when it vmaps memory to make it
> virtually contigious.  This upsets Xen if one of those pages is being
> recycled into a pagetable, since it finds an extra writable mapping of
> the page.
> 
> This patch solves the problem in a brute force way, by making XFS
> always eagerly unmap its mappings.  David Chinner says this shouldn't
> have any performance impact on filesystems with default block sizes;
> it will only affect filesystems with large block sizes.

Looks fine, Jeremy. I'll pull this into our dev tree and it should
get pushed with the .24 XFS merge (if someone doesn't pull these
patches directly).

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
