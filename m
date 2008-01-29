From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 17:32:20 +0200
Message-ID: <479F4704.8080107@qumranet.com>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<479EDDCE.8000000@qumranet.com> <479F3528.9040203@us.ibm.com>
	<200801291529.53808.borntraeger@de.ibm.com>
	<479F3B58.9000301@qumranet.com> <479F3E8D.8000308@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479F3E8D.8000308@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Avi Kivity wrote:
>> Christian Borntraeger wrote:
>>> Am Dienstag, 29. Januar 2008 schrieb Anthony Liguori:
>>>  
>>>> That's not what I was agreeing too.  I don't want to plumb an ABI 
>>>> interface through virtio for each device.  This is what I didn't 
>>>> like about having an ABI field in the first place.  I'm thinking we 
>>>> should just drop both of these and instead just rely on feature bits.
>>>>     
>>>
>>> Me also updating the our prototype code to the latest levels...
>>>
>>> And I agree with Anthony. Feature bits seems to be a much better 
>>> solution than ABI versions.
>>>   
>>
>> I agree that feature bits are the long term solution; but we need a 
>> short term solution before the ABI is stabilized.  We don't want to 
>> add feature bits now, since that will encode virtio development 
>> history into those bits (likely consuming most of them).
>
> Well then let's stick with the current patches I put out.  It gives us 
> a safe guard where we can gracefully break things.  I'm inclined to 
> think that we should not bother just "breaking" a particular device 
> but break all of them at once.  I don't want to overcomplicate 
> something that we expect to never use.
>

Yeah, okay.  We'll bump it one last time when 2.6.25 is released.

I'll merge the userspace side.

-- 
error compiling committee.c: too many arguments to function
