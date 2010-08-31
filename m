From: Alexander Graf <agraf@suse.de>
Subject: Re: hv block drivers
Date: Tue, 31 Aug 2010 12:46:30 +0200
Message-ID: <DA48E656-CCCF-4B2B-B930-8AAB92E08108@suse.de>
References: <201008301643.42253.arnd@arndb.de> <8AFC7968D54FB448A30D8F38F259C56224274727@TK5EX14MBXC118.redmond.corp.microsoft.com> <4C7BEBE7.8060502@goop.org> <201008302119.00069.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201008302119.00069.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org, "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


On 30.08.2010, at 21:18, Arnd Bergmann wrote:

> On Monday 30 August 2010 19:35:35 Jeremy Fitzhardinge wrote:
>> On 08/30/2010 10:31 AM, Hank Janssen wrote:
>>> For a more general question, When/if we make it out of staging, where should these drivers live?
>>> 
>>>      drivers/hyper-v or drivers/scsi and drivers/ide.
>>> 
>>> Is there a standard that is being followed?
>> 
>> If they're not actually scsi/ide subsystem drivers, then drivers/block
>> would seem like the best place (and drivers/ide is truly ancient stuff,
>> I think).
> 
> Agreed, although I was suggesting to make them SCSI drivers, so they
> would go to drivers/scsi/ or a subdirectory of it in that case.

It's basically the same as the VMware PV SCSI driver, no? And that one is in drivers/scsi/vmw_pvscsi.c.


Alex
