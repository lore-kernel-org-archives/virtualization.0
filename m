From: Zachary Amsden <zach@vmware.com>
Subject: Re: huh startup_ipi_hook?
Date: Mon, 30 Apr 2007 13:35:10 -0700
Message-ID: <463652FE.9080604@vmware.com>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
	<4632F653.3000102@goop.org> <46363662.40806@vmware.com>
	<46363B5D.7060101@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46363B5D.7060101@goop.org>
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
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> Of course we can create a bunch of new code to use the genapic
>> interface.  It is just a matter of copying apic.c and io-apic.c
>> verbatim and applying the sed command s/apic/vmi_apic/g. 
>>     
>
> Wouldn't it be cleaner to just change apic.c and io-apic.c to use, say,
> apic_ops to get access to the actual hardware, and then you could have
> native and vmi versions while sharing the bulk of the code.  Isn't that
> what genapic is intended to solve anyway?
>   

But the native and vmi versions would be identical.  You would be moving 
the apic_read / apic_write operations from paravirt_ops to apic_ops, 
which doesn't really solve anything, it just moves it around.

Zach
