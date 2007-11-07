From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: Use of virtio device IDs
Date: Wed, 07 Nov 2007 00:29:13 -0600
Message-ID: <47315B39.5060204__35868.4688610539$1194417027$gmane$org@us.ibm.com>
References: <4730A15A.6070001@us.ibm.com> <4731334A.6090405@gmail.com>
	<47314FBD.1070505@qumranet.com>
	<200711071709.47192.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200711071709.47192.rusty@rustcorp.com.au>
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
Cc: Gregory Haskins <gregory.haskins.ml@gmail.com>, linux-kernel@vger.kernel.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wednesday 07 November 2007 16:40:13 Avi Kivity wrote:
>   
>> Gregory Haskins wrote:
>>     
>>>  but FWIW: This is a major motivation for the reason that the
>>> IOQ stuff I posted a while back used strings for device identification
>>> instead of a fixed length, centrally managed namespace like PCI
>>> vendor/dev-id.  Then you can just name your device something reasonably
>>> unique (e.g. "qumranet::veth", or "ibm-pvirt-clock").
>>>       
>> I dislike strings.  They make it look as if you have a nice extensible
>> interface, where in reality you have a poorly documented interface which
>> leads to poor interoperability.
>>     
>
> Yes, you end up with exactly names like "qumranet::veth" 
> and "ibm-pvirt-clock".  I would recommend looking very hard at /proc, Open 
> Firmware on a modern system, or the Xen store, to see what a lack of 
> limitation can do to you :)
>
>   
>> We will support non-pci for s390, but in order to support Windows and
>> older Linux PCI is necessary.
>>     
>
> The aim is that PCI support is clean, but that we're not really tied to PCI.  
> I think we're getting closer with the recent config changes.
>   

Yes, my main desire was to ensure that we had a clean PCI ABI that would 
be natural to implement on a platform like Windows.  I think with the 
recent config_ops refactoring, we can now do that.

Regards,

Anthony Liguori

> Cheers,
> Rusty.
>   
