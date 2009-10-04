From: Kevin Bowling <kevinb@analograils.com>
Subject: Re: INFO: task journal:337 blocked for more than 120 seconds
Date: Sun, 04 Oct 2009 00:12:37 -0400
Message-ID: <4AC820B5.2050504__9363.76474933258$1254762575$gmane$org@analograils.com>
References: <1254345112.8837.9.camel@localhost.localdomain>
	<4AC646D7.5030709@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AC646D7.5030709@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org, Shirley Ma <mashirle@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/2/2009 2:30 PM, Jeremy Fitzhardinge wrote:
> On 09/30/09 14:11, Shirley Ma wrote:
>    
>> Anybody found this problem before? I kept hitting this issue for 2.6.31
>> guest kernel even with a simple network test.
>>
>> INFO: task kjournal:337 blocked for more than 120 seconds.
>> "echo 0>  /proc/sys/kernel/hung_task_timeout_sec" disables this message.
>>
>> kjournald	D 00000041	0	337	2 0x00000000
>>
>> My test is totally being blocked.
>>      
> I'm assuming from the lists you've posted to that this is under KVM?
> What disk drivers are you using (virtio or emulated)?
>
> Can you get a full stack backtrace of kjournald?
>
> Kevin Bowling submitted a RH bug against Xen with apparently the same
> symptoms (https://bugzilla.redhat.com/show_bug.cgi?id=526627).  I'm
> wondering if there's a core kernel bug here, which is perhaps more
> easily triggered by the changed timing in a virtual machine.
>
> Thanks,
>      J
>    

I've had a stable system thus far by appending "clocksource=jiffies" to 
the kernel boot line.  The default clocksource is otherwise "xen".

The dmesg boot warnings in my bugzilla report still occur.

Regards,
Kevin Bowling
http://www.analograils.com/
