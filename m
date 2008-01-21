From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio: remove explicit pci ids from virtio_pci.c
Date: Mon, 21 Jan 2008 11:12:46 +0200
Message-ID: <4794620E.7010900__39383.1111294732$1200906909$gmane$org@qumranet.com>
References: <200801211130.51401.rusty@rustcorp.com.au>
	<479420D2.7050902@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479420D2.7050902@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Rusty Russell wrote:
>> Qumranet let us use their PCI vendor ID, with device ids >= 0x1000.
>> We can specify that we accept all of them in the device ID table, and
>> then return -ENODEV in the probe routine.
>>   
>
> I thought the device id range was smaller.  Avi?
>

Yes, 0x1000-0x10ff IIRC.

Also, if we break compatibility in the future, won't this claim devices 
we don't actually support?

-- 
error compiling committee.c: too many arguments to function
