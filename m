From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 24/26] Xen-paravirt_ops: Add the Xenbus
 sysfs and virtual device hotplug driver.
Date: Fri, 16 Mar 2007 09:57:26 -0700
Message-ID: <45FACC76.1020902@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232529.271605211@goop.org>
	<20070316084704.GB23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316084704.GB23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> This communicates with the machine control software via a registry 
>> residing in a controlling virtual machine. This allows dynamic 
>> creation, destruction and modification of virtual device 
>> configurations (network devices, block devices and CPUS, to name some 
>> examples).
>>     
>
> should be reviewed by the driver-core folks too i guess?
>
>   
>> +//#include <asm/maddr.h>
>>     
>
>   
>> +//#include <xen/xen_proc.h>
>> +//#include <xen/evtchn.h>
>>     
>
>   
>> +//#include <xen/hvm.h>
>>     
>
>   
>> +//		.shutdown = xenbus_dev_shutdown,
>>     
>
> hm?
>   

Yeah, gunk.  I'll clean that out.

    J
