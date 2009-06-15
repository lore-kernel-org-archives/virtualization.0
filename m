From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 14:56:42 +0300
Message-ID: <4A3636FA.1040609__3945.61367943442$1245067215$gmane$org@redhat.com>
References: <1244796209.16425.20.camel@blaa> <4A326B5C.5010501@codemonkey.ws>
	<1244821292.30522.56.camel@blaa> <4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa> <20090614095016.GA7560@redhat.com>
	<1245056916.6891.31.camel@blaa> <4A3613EC.6030608@redhat.com>
	<20090615103249.GB6351@redhat.com> <4A363012.8050409@redhat.com>
	<20090615114858.GG6351@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090615114858.GG6351@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 06/15/2009 02:48 PM, Michael S. Tsirkin wrote:
>> A slot needs to be configured in ACPI,
>>      
>
> Can we configure all possible 32 slots?
>    

That's what we do.  But one is always taken.  In the future, perhaps more.

>> and not be taken by onboard chips
>> (piix takes slot 0, for example).
>>      
>
> piix is the root complex, isn't it? Are there other examples? If not,
> we could teach management about the root complex being special ...
>    

We should just tell the user which slots are open.

-- 
error compiling committee.c: too many arguments to function
