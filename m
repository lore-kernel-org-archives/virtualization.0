From: Ryan Harper <ryanh@us.ibm.com>
Subject: Re: [PATCH 2/2] Remove virtio_blk VBID ioctl
Date: Sun, 20 Jun 2010 21:30:24 -0500
Message-ID: <20100621023024.GE1647__1534.70215523175$1277087471$gmane$org@us.ibm.com>
References: <1276886283-1571-1-git-send-email-ryanh@us.ibm.com>
	<1276886283-1571-2-git-send-email-ryanh@us.ibm.com>
	<201006211100.19719.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006211100.19719.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: john cooper <john.cooper@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* Rusty Russell <rusty@rustcorp.com.au> [2010-06-20 20:31]:
> On Sat, 19 Jun 2010 04:08:03 am Ryan Harper wrote:
> > With the availablility of a sysfs device attribute for examining disk serial
> > numbers the ioctl is no longer needed.  The user-space changes for this aren't
> > upstream yet so we don't have any users to worry about.
> 
> If John Cooper acks this, I'll push it to Linus immediately.
> 
> Unfortunately we offered this interface in 2.6.34, and we're now removing it.
> That's unpleasant.

Yes; well.  There's a story as there always is.  John can tell it better
than I, but it goes something like:

John cooked up some patches, one of which was an example use of the
serial string including a VBID ioctl.  No one got around to doing a
sysfs interface and somehow the ioctl side in virtio-blk got picked up.

Working with what was available, I pushed some patches to linux-hotplug
to get this whole virtio-blk serial and disk/by-id symlinks working and
was met with:  why does a new kernel driver have an ioctl interface and
we don't want to collect additional single-use binaries in the udev
tree.

So now, the sysfs serial attribute patch and with it, no need and no
users of ioctl.

*whew*

> 
> Thanks,
> Rusty.
> PS.  John should have been cc'd on these patches!

He's cc'ed on the others, just not on this removal one.

I need to learn git-send-email better, I explicitly added him as --cc on
when sending; next time I'll look closer at the headers during
--dry-run.



-- 
Ryan Harper
Software Engineer; Linux Technology Center
IBM Corp., Austin, Tx
ryanh@us.ibm.com
