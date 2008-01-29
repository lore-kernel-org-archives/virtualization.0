From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 10:03:42 -0600
Message-ID: <479F4E5E.6070909@us.ibm.com>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<200801291421.00278.rusty@rustcorp.com.au>
	<479EDDCE.8000000@qumranet.com>
	<200801292338.03916.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801292338.03916.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tuesday 29 January 2008 19:03:26 Avi Kivity wrote:
>   
>> Rusty Russell wrote:
>>     
>>> On Tuesday 29 January 2008 02:59:59 Anthony Liguori wrote:
>>>       
>>>> As Avi pointed out, as we continue to massage the virtio PCI ABI, we can
>>>> make things a little more friendly to users by utilizing the PCI
>>>> revision field to indicate which version of the ABI we're using.  This
>>>> is a hard ABI version and incrementing it will cause the guest driver to
>>>> break.
>>>>
>>>> This is the necessary changes to virtio_pci to support this.
>>>>
>>>> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>>>>         
>>> Applied, thanks.
>>>       
>> But that's done at the wrong level.  Anthony agreed the revision ID
>> should indicate the device ABI, not just the virtio ABI.  If we move to
>> that level, bumping just one device rev id on the host will break all
>> devices on the guest.
>>     
>
> OK, I'll drop it.
>   

Please pull in the patch again.

> It's dumb anyway, since we can just change the ID if we want to break drivers.  
> Having multiple ways of doing something we don't want to do seems silly.
>   

I considered that too but there's no point in burning through the device 
IDs.  This is what PCI revision IDs are meant for so we might as well 
use them.

Regards,

Anthony Liguori

> Cheers,
> Rusty.
>   
