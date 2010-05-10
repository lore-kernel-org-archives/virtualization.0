From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: Patch to auto-load MSFT PV NIC driver
Date: Mon, 10 May 2010 17:05:02 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5621AFFC507@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <4BE453510200003000084906@sinclair.provo.novell.com>
	<8AFC7968D54FB448A30D8F38F259C5621AFFB3F9@TK5EX14MBXC114.redmond.corp.microsoft.com>,
	<20100508142716.GA32133@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20100508142716.GA32133@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <greg@kroah.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Virtualization@lists.osdl.org" <Virtualization@lists.osdl.org>, Ky Srinivasan <ksrinivasan@novell.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org


>Sent: Saturday, May 08, 2010 7:27 AM -  Hank Janssen
>>On Sat, May 08, 2010 at 01:52:01PM +0000, Hank Janssen wrote:>
>>
>> I am not sure if this is the right approach. hv_netvsc takes a dependency on hv_vmbus.
>> hv_vmbus does have the same DMI detection logic in it. But unless hv_vmbus has loaded
>> up competely, hv_netvsc will fail on loadup. And I do not think we can guarantee that
>> hv_vmbus has loaded yet.
>
>Yes you can, the dependancies in the module will take care of it.  Try
>it, if you try to load the hv_netvsc module before hv_vmbus, modprobe
>will load hv_vmbus first.

In my testing I have seen issues with timing.   It takes a little while for VMBus to start
getting the initialization taken care of with Hyper-V. And I have seen netvsc error with
unresolved symbols because vmbus had not completed the initialization yet.

Thanks,

Hank.
