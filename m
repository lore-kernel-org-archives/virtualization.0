From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/2] v2: Add 'serial' attribute to virtio-blk devices
Date: Fri, 25 Jun 2010 12:34:28 +0930
Message-ID: <201006251234.30808.rusty__29475.4223469228$1277435119$gmane$org@rustcorp.com.au>
References: <1277349598-24559-1-git-send-email-ryanh@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1277349598-24559-1-git-send-email-ryanh@us.ibm.com>
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

On Thu, 24 Jun 2010 12:49:56 pm Ryan Harper wrote:
> Using Rusty's suggestion I've respun the patch removing the special copy
> function.  I've tested this patch in a guest kernel with and without qemu
> supplying serial numbers for the block devices and it's working as expected.
> When qemu supplies serial numbers, the correct value is supplied to
> /sys/block/vdX/serial and can be used by udev for generating disk/by-id paths
> (without separate utility).  When running without serial number support the path
> still exists in sysfs but produces no output.
> 
> Signed-off-by: Ryan Harper <ryanh@us.ibm.com>

Great, both applied.

BTW, a mail without a patch doesn't need a sign off, does it?

Thanks,
Ruty.
