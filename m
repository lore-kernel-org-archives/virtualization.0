From: Markus Armbruster <armbru@redhat.com>
Subject: Re: Configuration vs. compat hints
Date: Mon, 15 Jun 2009 07:32:31 +0200
Message-ID: <87zlcakqog.fsf__37766.2647668787$1245044316$gmane$org@pike.pond.sub.org>
References: <cover.1244192535.git.mst@redhat.com>
	<20090610145540.GI19375@poweredge.glommer>
	<20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org> <1244796209.16425.20.camel@blaa>
	<4A326C7E.3020309@codemonkey.ws> <1244822007.30522.68.camel@blaa>
	<4A327E87.6080005@codemonkey.ws> <1244825333.26769.20.camel@blaa>
	<4A34ADA9.80709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A34ADA9.80709@redhat.com> (Avi Kivity's message of "Sun\,
	14 Jun 2009 10\:58\:33 +0300")
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
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Carsten Otte <cotte@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity <avi@redhat.com> writes:

> Mark McLoughlin wrote:
[...]
>>> NB the device tree contains no host configuration information.
>>>     
>>
>> So, it wouldn't e.g. include the path to the image file for a block
>> device? That would always be specified on the command line?
>>   
>
> Or in a different file.  I agree splitting host and guest
> configuration is a must-have, this ensures portability of virtual
> machines across hosts and time.

Splitting into two separate sections should suffice, they could live in
the same file for convenience.
