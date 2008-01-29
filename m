From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/2] virtio reset support
Date: Tue, 29 Jan 2008 19:27:02 +0200
Message-ID: <479F61E6.4010600@qumranet.com>
References: <200801240116.26160.rusty@rustcorp.com.au>
	<200801240118.09032.rusty@rustcorp.com.au>
	<479C8599.60007@qumranet.com> <479DF787.2020100@us.ibm.com>
	<479DF952.9040201@qumranet.com> <479E5B9B.4070409@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479E5B9B.4070409@us.ibm.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Dor Laor <dor.laor@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Avi Kivity wrote:
>> Anthony Liguori wrote:
>>>
>>> PCI-e has a common reset concept (warm and cold).  I've been looking 
>>> around and I can't seem to find any common reset mechanism for PCI.  
>>> Is FLR something that is per-device or a standard PCI mechanism?  If 
>>> it's the former, than we've basically implemented FLR using this bit 
>>> in the config space.
>>>
>>
>> I believe it is a standard mechanism, albeit new, so perhaps many 
>> devices don't implement it.
>
> I don't have a copy of the PCI specification handy.  Can you dig up 
> how it's implemented?  I don't see any references in my local 
> documentation and I couldn't find anything in Linux that referenced it 
> at the PCI level.
>

I think it's NDA material, so even if I found it, I couldn't publish 
it.  It can probably be reverse-engineered from the Xen patches, or 
perhaps your employer is a PCI-SIG member so you can get access to it.

-- 
error compiling committee.c: too many arguments to function
