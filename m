From: john cooper <john.cooper@redhat.com>
Subject: Re: [PATCH 2/2] Remove virtio_blk VBID ioctl
Date: Mon, 21 Jun 2010 01:07:53 -0400
Message-ID: <4C1EF3A9.6080703__48430.2889592529$1277098010$gmane$org@redhat.com>
References: <1276886283-1571-1-git-send-email-ryanh@us.ibm.com>
	<1276886283-1571-2-git-send-email-ryanh@us.ibm.com>
	<201006211100.19719.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: john.cooper@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Sat, 19 Jun 2010 04:08:03 am Ryan Harper wrote:
>> With the availablility of a sysfs device attribute for examining disk serial
>> numbers the ioctl is no longer needed.  The user-space changes for this aren't
>> upstream yet so we don't have any users to worry about.
> 
> If John Cooper acks this, I'll push it to Linus immediately.

Actually I'm the one who suggested removing it.
The code in question was only intended as example
usage of accessing the s/n data in the driver, for
the /sys interface under discussion back then.
That effort subsequently stalled and Ryan had
recently picked it up.  As such I believe this
overshadows the general need for an ioctl.  Even if
for some reason an ioctl would be justified going
forward, a more usage friendly form would be better.
So let's just drop it for now as the corresponding
qemu-side code hasn't been merged.
 
> Unfortunately we offered this interface in 2.6.34, and we're now removing it.
> That's unpleasant.

Indeed.  This entire effort, aside from being an exercise
in protracted agony, probably violates a Rube Goldberg
patent.

Thanks,

-john

-- 
john.cooper@redhat.com
