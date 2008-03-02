From: Avi Kivity <avi@qumranet.com>
Subject: Re: I/O bandwidth control on KVM
Date: Sun, 02 Mar 2008 18:45:59 +0200
Message-ID: <47CAD9C7.90900__14524.7516026304$1204476560$gmane$org@qumranet.com>
References: <20080229.210531.226799765.ryov__28298.7898834564$1204287044$gmane$org@valinux.co.jp>
	<47CA2A7B.8000400@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47CA2A7B.8000400@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel@lists.sourceforge.net, dm-devel@redhat.com, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Hi Ryo,
>
> Ryo Tsuruta wrote:
>   
>> Hello all,
>>
>> I've implemented a block device which throttles block I/O bandwidth, 
>> which I called dm-ioband, and been trying to throttle I/O bandwidth on
>> KVM environment. But unfortunately it doesn't work well, the number of
>> issued I/Os is not according to the bandwidth setting.
>> On the other hand, I got the good result when accessing directly to
>> the local disk on the local machine.
>>
>> I'm not so familiar with KVM. Could anyone give me any advice?
>>     
>
> If you are using virtio drivers in the guest (which I presume you are 
> given the reference to /dev/vda), try using the following -drive syntax:
>
> -drive file=/dev/mapper/ioband1,if=virtio,boot=on,cache=off
>
> This will force the use of O_DIRECT.  By default, QEMU does not open 
> with O_DIRECT so you'll see page cache effects.
>
>   

Good point.  But IIRC cache=off is not limited to virtio?


-- 
error compiling committee.c: too many arguments to function
