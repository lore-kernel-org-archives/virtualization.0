From: Markus Armbruster <armbru@redhat.com>
Subject: Re: Configuration vs. compat hints
Date: Mon, 15 Jun 2009 15:04:32 +0200
Message-ID: <87bpop4pi7.fsf__48168.7834290371$1245071272$gmane$org@pike.pond.sub.org>
References: <20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org> <1244796209.16425.20.camel@blaa>
	<4A326B5C.5010501@codemonkey.ws> <1244821292.30522.56.camel@blaa>
	<4A327E4A.7010300@codemonkey.ws> <1244825303.26769.19.camel@blaa>
	<20090614095016.GA7560@redhat.com> <1245056916.6891.31.camel@blaa>
	<4A3613EC.6030608@redhat.com> <4A36415F.6080206@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A36415F.6080206@codemonkey.ws> (Anthony Liguori's message of
	"Mon\, 15 Jun 2009 07\:41\:03 -0500")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <anthony@codemonkey.ws> writes:

> Avi Kivity wrote:
>> On 06/15/2009 12:08 PM, Mark McLoughlin wrote:
>>>> This last option makes sense to me: in a real world the user has
>>>> control over where he places the device on the bus, so why
>>>> not with qemu?
>>>>      
>>>
>>> Yep, most people seem to agree that it makes sense to allow this, but
>>> some believe it should only be via a machine description file, not the
>>> command line.
>>>    
>>
>> I don't understand this opposition.  It's clear a machine config
>> file is a long way in our future.  It's also clear lack of stable
>> PCI addresses hurts us now.
>
> Is there opposition?  I don't ever recall seeing a patch...

http://www.archivum.info/qemu-devel@nongnu.org/2009-01/msg01458.html

> I think it's a perfectly fine idea.

Off to dust off my patch series.
