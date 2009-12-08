From: Avishay Traeger1 <AVISHAY@il.ibm.com>
Subject: Re: [PATCH] virtio spec: add virtio-blk max sectors feature
Date: Tue, 8 Dec 2009 11:44:18 +0200
Message-ID: <OFD98AF5A9.4296A91C-ONC2257686.00353E3A-C2257686.00357FE1__4530.87594728476$1260288470$gmane$org@il.ibm.com>
References: <OF38B713F7.02DD66D1-ONC2257681.002F3CAD-C2257681.002FDEA6@il.ibm.com>
	<4B178BCE.7030003@redhat.com>
	<200912081618.00714.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200912081618.00714.rusty@rustcorp.com.au>
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
Cc: virtualization <virtualization@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> wrote on 12/08/2009 07:48:00 AM:
> Avishay; this would be the total sectors in an I/O, as separate from
SIZE_MAX
> (maximum size of any single scatterlist entry) and SEG_MAX (maximum
number of
> scatterlist entries)?

Correct.  In the guest virtblk driver, it changes the call to
blk_queue_max_sectors().

> Seems like a reasonable idea; esp if you need it.

I do.

> Thanks!
> Rusty.

Sure.  Avi - do you want me to resubmit the kvm and qemu patches?

Thanks,
Avishay
