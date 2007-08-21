From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 0/4] Virtual Machine Time Accounting
Date: Tue, 21 Aug 2007 15:54:46 +0300
Message-ID: <46CAE096.4060606__7765.48278886384$1187701268$gmane$org@qumranet.com>
References: <46C99371.7070705@bull.net>
	<18121.39541.790665.686081@stoffel.org>	<46C9A7AB.1030003@bull.net>
	<46C9BD8F.4070807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C9BD8F.4070807@goop.org>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Laurent Vivier <Laurent.Vivier@bull.net>, John Stoffel <john@stoffel.org>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Laurent Vivier wrote:
>   
>> functionnalities:
>>
>> - allow to measure time spent by a CPU in a virtual CPU.
>> - allow to display in /proc/state this value by CPU
>> - allow to display in /proc/<pid>/state this value by process
>> - allow KVM to use these 3 previous functionnalities
>>   
>>     
>
> So, currently time spent in a kvm guest is accumulated as qemu-kvm
> usertime, right?  Given that qemu knows when its running in qemu vs
> guest context, couldn't it provide the breakdown between user and guest
> time (ditto lguest)?
>   

qemu doesn't (and shouldn't) do accounting; that's best done by 
interrupt driven code.

The patches do account for guest time in a separate counter; guest time 
is added to both user time and the new counter.  This allows an old 
'top' to see guest time (accounted as user time), and a new 'top' to 
separate guest time and user time by performing the appropriate 
mathematical operation.


-- 
error compiling committee.c: too many arguments to function
