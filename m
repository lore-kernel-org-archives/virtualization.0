From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 08:16:08 -0600
Message-ID: <479F3528.9040203@us.ibm.com>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<200801291421.00278.rusty@rustcorp.com.au>
	<479EDDCE.8000000@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479EDDCE.8000000@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Rusty Russell wrote:
>> On Tuesday 29 January 2008 02:59:59 Anthony Liguori wrote:
>>  
>>> As Avi pointed out, as we continue to massage the virtio PCI ABI, we 
>>> can
>>> make things a little more friendly to users by utilizing the PCI 
>>> revision
>>> field to indicate which version of the ABI we're using.  This is a 
>>> hard ABI
>>> version and incrementing it will cause the guest driver to break.
>>>
>>> This is the necessary changes to virtio_pci to support this.
>>>
>>> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>>>     
>>
>> Applied, thanks.
>>
>>   
>
> But that's done at the wrong level.  Anthony agreed the revision ID 
> should indicate the device ABI, not just the virtio ABI.  If we move 
> to that level, bumping just one device rev id on the host will break 
> all devices on the guest.

That's not what I was agreeing too.  I don't want to plumb an ABI 
interface through virtio for each device.  This is what I didn't like 
about having an ABI field in the first place.  I'm thinking we should 
just drop both of these and instead just rely on feature bits.

Regards,

Anthony Liguori
