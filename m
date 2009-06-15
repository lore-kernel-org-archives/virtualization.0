From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 07:48:22 -0500
Message-ID: <4A364316.5070402__7962.51927172324$1245070223$gmane$org@codemonkey.ws>
References: <cover.1244192535.git.mst@redhat.com>	
	<20090610145540.GI19375@poweredge.glommer>	
	<20090610150129.GC28601@redhat.com>	
	<200906101624.30659.paul@codesourcery.com>	
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>	
	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa>	 <4A326C7E.3020309@codemonkey.ws>
	<1244822007.30522.68.camel@blaa>	 <4A327E87.6080005@codemonkey.ws>
	<1244825333.26769.20.camel@blaa>	 <4A34ADA9.80709@redhat.com>
	<1245056955.6891.33.camel@blaa> <4A36314A.8040206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A36314A.8040206@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> On 06/15/2009 12:09 PM, Mark McLoughlin wrote:
>>>>> I think the point is that you don't need version numbers if you 
>>>>> have a
>>>>> proper device tree.
>>>>>
>>>>>          
>>>> How do you add a new attribute to the device tree and, when a supplied
>>>> device tree lacking said attribute, distinguish between a device tree
>>>> from an old version of qemu (i.e. use the old default) and a partial
>>>> device tree from the VM manager (i.e. use the new default) ?
>>>>
>>>>        
>>> -baseline 0.10
>>>      
>>
>> That's a version number :-)
>>
>> (I was responding to Anthony's "you don't need a version number")
>>    
>
> If you want to prevent incompatibilities, you need to make everything 
> new (potentially including bugfixes) non-default.  Eventually the 
> default configuration becomes increasingly unusable and you need a new 
> baseline.  You must still be able to fall back to the old baseline for 
> older guests.  I don't think games with configuration files can hide 
> that.

-M pc1
-M pc2

etc.

This is pretty easy to maintain with config files.

Regards,

Anthony Liguori
