From: freevanx <freevanx@gmail.com>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Sat, 8 Nov 2008 13:50:20 +0800
Message-ID: <fe8256d20811072150o1d82e8bdq40bf61df0a3faebe@mail.gmail.com>
References: <20081106043235.GA30292@kroah.com> <4913B8A5.5010806@intel.com>
	<20081107061603.GC3860@kroah.com> <4913F34A.8020805@intel.com>
	<20081107080222.GA6284@kroah.com> <4913F97E.7030408@intel.com>
	<20081107082432.GA6601@kroah.com> <4913FDE3.8050804@intel.com>
	<20081107185325.GE2320@kroah.com> <49151CED.8060507@uniscape.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6163895187357700766=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49151CED.8060507@uniscape.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@uniscape.net>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

--===============6163895187357700766==
Content-Type: multipart/alternative;
	boundary="----=_Part_32838_23791627.1226123420884"

------=_Part_32838_23791627.1226123420884
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

I'm glad to hear this. In fact, I'm developing for BIOS area. This feature
is very useful when your system have one or more PCI/PCIe hotplug slot.
Generally, BIOS reserve amount of resource for empty hotplug slot by
default, but it is not always enough for all device. We have many kind of
Express Modules which consume different amount of resouce, generally we
reserve a small number of resouce for this, so, sometime, some Express
Modules hotplug without card installed at boot time, it will not useable.

Then, Microsoft say they implement PCI Multi-level Resource Rebanlence in
Vista and Server 2008, you can refer
http://www.microsoft.com/whdc/archive/multilevel-rebal.mspx
http://www.microsoft.com/whdc/connect/pci/PCI-rsc.mspx

They use a method of ACPI to tell OS that you can ignore the resource
allocation of PCI devices below the bridge. I think this is more useful than
specify the BUS number to ignore resouce allocation, because the BUS number
often change due to some need by BIOS or new PCI/PCIe device added in
system. Users generally do not know the system architecture and can not
specify the BUS number of the root bridge, while if you specify the _DSM
method like MS to the root bridge of hotplug slot, it is a much easier way
to archive for BIOS writers.

PS:
Since my mail address was blocked by the maillist, this mail may not reach
people who only in linux kernel maillist.

Thanks.
Jensen

On Sat, Nov 8, 2008 at 1:00 PM, Yu Zhao <yu.zhao@uniscape.net> wrote:

> Greg KH wrote:
>
>> On Fri, Nov 07, 2008 at 04:35:47PM +0800, Zhao, Yu wrote:
>>
>>> Greg KH wrote:
>>>
>>>> On Fri, Nov 07, 2008 at 04:17:02PM +0800, Zhao, Yu wrote:
>>>>
>>>>> Well, to do it "correctly" you are going to have to tell the driver to
>>>>>> shut itself down, and reinitialize itself.
>>>>>> Turns out, that doesn't really work for disk and network devices
>>>>>> without
>>>>>> dropping the connection (well, network devices should be fine
>>>>>> probably).
>>>>>> So you just can't do this, sorry.  That's why the BIOS handles all of
>>>>>> these issues in a PCI hotplug system.
>>>>>> How does the hardware people think we are going to handle this in the
>>>>>> OS?  It's not something that any operating system can do, is it part
>>>>>> of
>>>>>> the IOV PCI spec somewhere?
>>>>>>
>>>>> No, it's not part of the PCI IOV spec.
>>>>>
>>>>> I just want the IOV (and whole PCI subsystem) have more flexibility on
>>>>> various BIOSes. So can we reconsider about resource rebalance as boot
>>>>> option, or should we forget about this idea?
>>>>>
>>>> As you have proposed it, the boot option will not work at all, so I
>>>> think we need to forget about it.  Especially if it is not really
>>>> needed.
>>>>
>>> I guess at least one thing would work if people don't want to boot twice:
>>> give the bus number 0 as rebalance starting point, then all system resources
>>> would be reshuffled :-)
>>>
>>
>> Hm, but don't we do that today with our basic resource reservation logic
>> at boot time?  What would be different about this kind of proposal?
>>
>
> The generic PCI core can do this but this feature is kind of disabled by
> low level PCI code in x86. The low level code tries to reserve resource
> according to configuration from BIOS. If the BIOS is wrong, the allocation
> would fail and the generic PCI core couldn't repair it because the bridge
> resources may have been allocated by the PCI low level and the PCI core
> can't expand them to find enough resource for the subordinates.
>
> The proposal is to disable x86 PCI low level to allocation resources
> according to BIOS so PCI core can fully control the resource allocation. The
> PCI core takes all resources from BARs it knows into account and configure
> the resource windows on the bridges according to its own calculation.
>
> Regards,
> Yu
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

------=_Part_32838_23791627.1226123420884
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>I&#39;m glad to hear this. In fact, I&#39;m developing for BIOS area. This feature is very useful when your system have one or more PCI/PCIe hotplug slot. Generally, BIOS reserve amount of resource for empty hotplug slot by default, but it is not always enough for all device. We have many kind of Express Modules which consume different amount of resouce, generally we reserve a small number of resouce for this, so, sometime, some Express Modules hotplug without card installed at boot time, it will not useable.<br>
<br>Then, Microsoft say they implement PCI Multi-level Resource Rebanlence in Vista and Server 2008, you can refer<br><a href="http://www.microsoft.com/whdc/archive/multilevel-rebal.mspx">http://www.microsoft.com/whdc/archive/multilevel-rebal.mspx</a><br>
<a href="http://www.microsoft.com/whdc/connect/pci/PCI-rsc.mspx">http://www.microsoft.com/whdc/connect/pci/PCI-rsc.mspx</a><br><br>They use a method of ACPI to tell OS that you can ignore the resource allocation of PCI devices below the bridge. I think this is more useful than specify the BUS number to ignore resouce allocation, because the BUS number often change due to some need by BIOS or new PCI/PCIe device added in system. Users generally do not know the system architecture and can not specify the BUS number of the root bridge, while if you specify the _DSM method like MS to the root bridge of hotplug slot, it is a much easier way to archive for BIOS writers.<br>
<br>PS:<br>Since my mail address was blocked by the maillist, this mail may not reach people who only in linux kernel maillist.<br><br>Thanks.<br>Jensen<br><br><div class="gmail_quote">On Sat, Nov 8, 2008 at 1:00 PM, Yu Zhao <span dir="ltr">&lt;<a href="mailto:yu.zhao@uniscape.net">yu.zhao@uniscape.net</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">Greg KH wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, Nov 07, 2008 at 04:35:47PM +0800, Zhao, Yu wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Greg KH wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, Nov 07, 2008 at 04:17:02PM +0800, Zhao, Yu wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Well, to do it &quot;correctly&quot; you are going to have to tell the driver to<br>
shut itself down, and reinitialize itself.<br>
Turns out, that doesn&#39;t really work for disk and network devices without<br>
dropping the connection (well, network devices should be fine probably).<br>
So you just can&#39;t do this, sorry. &nbsp;That&#39;s why the BIOS handles all of<br>
these issues in a PCI hotplug system.<br>
How does the hardware people think we are going to handle this in the<br>
OS? &nbsp;It&#39;s not something that any operating system can do, is it part of<br>
the IOV PCI spec somewhere?<br>
</blockquote>
No, it&#39;s not part of the PCI IOV spec.<br>
<br>
I just want the IOV (and whole PCI subsystem) have more flexibility on various BIOSes. So can we reconsider about resource rebalance as boot option, or should we forget about this idea?<br>
</blockquote>
As you have proposed it, the boot option will not work at all, so I<br>
think we need to forget about it. &nbsp;Especially if it is not really<br>
needed.<br>
</blockquote>
I guess at least one thing would work if people don&#39;t want to boot twice: give the bus number 0 as rebalance starting point, then all system resources would be reshuffled :-)<br>
</blockquote>
<br>
Hm, but don&#39;t we do that today with our basic resource reservation logic<br>
at boot time? &nbsp;What would be different about this kind of proposal?<br>
</blockquote>
<br></div>
The generic PCI core can do this but this feature is kind of disabled by low level PCI code in x86. The low level code tries to reserve resource according to configuration from BIOS. If the BIOS is wrong, the allocation would fail and the generic PCI core couldn&#39;t repair it because the bridge resources may have been allocated by the PCI low level and the PCI core can&#39;t expand them to find enough resource for the subordinates.<br>

<br>
The proposal is to disable x86 PCI low level to allocation resources according to BIOS so PCI core can fully control the resource allocation. The PCI core takes all resources from BARs it knows into account and configure the resource windows on the bridges according to its own calculation.<br>

<br>
Regards,<br><font color="#888888">
Yu</font><div><div></div><div class="Wj3C7c"><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel&quot; in<br>
the body of a message to <a href="mailto:majordomo@vger.kernel.org" target="_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at &nbsp;<a href="http://vger.kernel.org/majordomo-info.html" target="_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at &nbsp;<a href="http://www.tux.org/lkml/" target="_blank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br>

------=_Part_32838_23791627.1226123420884--

--===============6163895187357700766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============6163895187357700766==--
