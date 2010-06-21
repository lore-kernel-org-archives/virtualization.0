From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] Remove virtio_blk VBID ioctl
Date: Mon, 21 Jun 2010 11:00:19 +0930
Message-ID: <201006211100.19719.rusty__28075.9690249853$1277083875$gmane$org@rustcorp.com.au>
References: <1276886283-1571-1-git-send-email-ryanh@us.ibm.com>
	<1276886283-1571-2-git-send-email-ryanh@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1276886283-1571-2-git-send-email-ryanh@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryan Harper <ryanh@us.ibm.com>
Cc: john cooper <john.cooper@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 19 Jun 2010 04:08:03 am Ryan Harper wrote:
> With the availablility of a sysfs device attribute for examining disk serial
> numbers the ioctl is no longer needed.  The user-space changes for this aren't
> upstream yet so we don't have any users to worry about.

If John Cooper acks this, I'll push it to Linus immediately.

Unfortunately we offered this interface in 2.6.34, and we're now removing it.
That's unpleasant.

Thanks,
Rusty.
PS.  John should have been cc'd on these patches!
