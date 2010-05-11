From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: Patch to auto-load MSFT PV NIC driver
Date: Tue, 11 May 2010 07:55:08 -0600
Message-ID: <4BE90D5C0200003000084B90@sinclair.provo.novell.com>
References: <4BE453510200003000084906@sinclair.provo.novell.com>
	<8AFC7968D54FB448A30D8F38F259C5621AFFB3F9@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20100508142716.GA32133@kroah.com>
	<8AFC7968D54FB448A30D8F38F259C5621AFFC507@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20100510172125.GA1482@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20100510172125.GA1482@kroah.com>
Content-Disposition: inline
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <greg@kroah.com>, Hank Janssen <hjanssen@microsoft.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Virtualization@lists.osdl.org" <Virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



>>> On 5/10/2010 at  1:21 PM, in message <20100510172125.GA1482@kroah.com>, Greg KH
<greg@kroah.com> wrote: 
> On Mon, May 10, 2010 at 05:05:02PM +0000, Hank Janssen wrote:
>> 
>> >Sent: Saturday, May 08, 2010 7:27 AM -  Hank Janssen
>> >>On Sat, May 08, 2010 at 01:52:01PM +0000, Hank Janssen wrote:>
>> >>
>> >> I am not sure if this is the right approach. hv_netvsc takes a dependency 
> on hv_vmbus.
>> >> hv_vmbus does have the same DMI detection logic in it. But unless hv_vmbus 
> has loaded
>> >> up competely, hv_netvsc will fail on loadup. And I do not think we can 
> guarantee that
>> >> hv_vmbus has loaded yet.
>> >
>> >Yes you can, the dependancies in the module will take care of it.  Try
>> >it, if you try to load the hv_netvsc module before hv_vmbus, modprobe
>> >will load hv_vmbus first.
>> 
>> In my testing I have seen issues with timing.   It takes a little while for 
> VMBus to start
>> getting the initialization taken care of with Hyper-V. And I have seen netvsc 
> error with
>> unresolved symbols because vmbus had not completed the initialization yet.
> 
> Odd, that shouldn't happen, unless you are loading modules in parallel.
This is indeed strange. Given the module dependency, modprobe is supposed to load all the dependencies first before loading the dependent module. I am wondering if there is some other race in the modules that may be causing this problem.

K. Y
> 
> If we switch to a proper discovery type bus, this should not be an
> issue.
> 
> thanks,
> 
> greg k-h
