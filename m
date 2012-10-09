From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Tue, 09 Oct 2012 12:17:56 +0200
Message-ID: <5073F9D4.5060000@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
	<507333F1.1060000@redhat.com> <874nm4u1in.fsf@codemonkey.ws>
	<87sj9o8qn7.fsf@rustcorp.com.au> <87sj9oh0pm.fsf@codemonkey.ws>
	<87haq48hds.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87haq48hds.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/09/2012 05:16 AM, Rusty Russell wrote:
> Anthony Liguori <aliguori@us.ibm.com> writes:
>> We'll never remove legacy so we shouldn't plan on it.  There are
>> literally hundreds of thousands of VMs out there with the current virtio
>> drivers installed in them.  We'll be supporting them for a very, very
>> long time :-)
> 
> You will be supporting this for qemu on x86, sure.  As I think we're
> still in the growth phase for virtio, I prioritize future spec
> cleanliness pretty high.

If a pure ppc hypervisor was on the table, this might have been
worthwhile.  As it is the codebase is shared, and the Linux drivers are
shared, so cleaning up the spec doesn't help the code.

> 
> But I think you'll be surprised how fast this is deprecated:
> 1) Bigger queues for block devices (guest-specified ringsize)
> 2) Smaller rings for openbios (guest-specified alignment)
> 3) All-mmio mode (powerpc)
> 4) Whatever network features get numbers > 31.
> 
>> I don't think we gain a lot by moving the ISR into a separate BAR.
>> Splitting up registers like that seems weird to me too.
> 
> Confused.  I proposed the same split as you have, just ISR by itself.

I believe Anthony objects to having the ISR by itself.  What is the
motivation for that?


-- 
error compiling committee.c: too many arguments to function
