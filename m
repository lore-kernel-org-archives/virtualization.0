From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [V9fs-developer] [Qemu-devel] QEMU dies on any attempt to load
	a Linux kernel module when using a 9P rootfs
Date: Fri, 22 Aug 2014 08:37:52 -0400
Message-ID: <53F739A0.4070106@codeaurora.org>
References: <5293718E.4090508@gentoo.org> <53F64DA2.3060308@codeaurora.org>
	<20140822062744.GA12382@u-barrelet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140822062744.GA12382@u-barrelet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Richard Yao <ryao@gentoo.org>, qemu-devel@nongnu.org, kernel@gentoo.org, v9fs-developer@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Dominique,

On 08/22/2014 02:27 AM, Dominique Martinet wrote:
> Hi,
> 
> Christopher Covington wrote on Thu, Aug 21, 2014 at 03:50:58PM -0400:
>> With my 3.15.0+ kernel, qemu-system-x86_64 substituted for qemu-kvm, and the
>> path changed from your arguments I get:
>>
>> 9pnet_virtio: no channels available
>> VFS: Cannot open root device "root" or unknown-block(0,0): error -2
>> Please append a correct "root=" boot option; here are the available partitions:
>> 0b00         1048575 sr0  driver: sr
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
> 
> I'm pretty sure that's the same problem that's been reported a few times
> here, could you try again after cherry-picking this commit:
> 
> commit f15844e0777fec936f87a87f97394f83911dacd3
> Author: Dominique Martinet <dominique.martinet@cea.fr>
> Date:   Wed May 21 10:02:12 2014 +0200
> 
>     9P: fix return value in v9fs_fid_xattr_set
>     
>     v9fs_fid_xattr_set is supposed to return 0 on success.
>     
>     This corrects the behaviour introduced in commit
>     bdd5c28dcb8330b9074404cc92a0b83aae5606a
>     "9p: fix return value in case in v9fs_fid_xattr_set()"
>     
>     (The function returns a negative error on error, as expected)
>     
>     Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
>     Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
> 
> 
> It has gotten in in v3.16-rc1, so your 3.15.0+ proably doesn't have it.

Thanks for the pointer to this patch. I think I started this kernel half way
through the 3.16 merge window. The last non-cherry-picked patch I have is:

commit 6d87c225f5d82d29243dc124f1ffcbb0e14ec358
Merge: 338c09a 22001f6
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jun 12 23:06:23 2014 -0700

    Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client

So I do have the change you pointed out. Nevertheless, I'll reconfirm with the
latest torvalds/master.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
