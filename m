From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 18:02:57 +0200
Message-ID: <479F4E31.3040808@qumranet.com>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<479F3E8D.8000308@us.ibm.com> <479F4704.8080107@qumranet.com>
	<200801291639.59184.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801291639.59184.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Am Dienstag, 29. Januar 2008 schrieb Avi Kivity:
>   
>> Yeah, okay.  We'll bump it one last time when 2.6.25 is released.
>>
>> I'll merge the userspace side.
>>     
>
> Do we really want to freeze the interface for virtio already with 2.6.25? 
> Maybe every possible issue is found then, but I would prefer to have a more
> flexible schedule on finalizing virtio. Dont know if I am just paranoid...
>   

We can always bump it again if we find out we suck.  But I hope three 
months ought to do it.

-- 
error compiling committee.c: too many arguments to function
