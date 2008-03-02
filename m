From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: I/O bandwidth control on KVM
Date: Sun, 02 Mar 2008 12:08:39 -0600
Message-ID: <47CAED27.10308__4208.54733461073$1204481622$gmane$org@codemonkey.ws>
References: <20080229.210531.226799765.ryov__28298.7898834564$1204287044$gmane$org@valinux.co.jp>
	<47CA2A7B.8000400@codemonkey.ws> <47CAD9C7.90900@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47CAD9C7.90900@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, dm-devel@redhat.com, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>>
>> If you are using virtio drivers in the guest (which I presume you are 
>> given the reference to /dev/vda), try using the following -drive syntax:
>>
>> -drive file=/dev/mapper/ioband1,if=virtio,boot=on,cache=off
>>
>> This will force the use of O_DIRECT.  By default, QEMU does not open 
>> with O_DIRECT so you'll see page cache effects.
>>
>>   
>
> Good point.  But IIRC cache=off is not limited to virtio?

Nope.  I just wanted to give the exact syntax to use and it looked like 
he was using virtio.

Regards,

Anthony Liguori
