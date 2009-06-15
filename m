From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 12:38:48 +0300
Message-ID: <4A3616A8.5020801__28382.6238628992$1245058944$gmane$org@redhat.com>
References: <20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa> <4A326C7E.3020309@codemonkey.ws>
	<1244822007.30522.68.camel@blaa> <20090614093411.GA6959@redhat.com>
	<4A34C4C9.8030105@redhat.com> <20090614094754.GC6959@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090614094754.GC6959@redhat.com>
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

On 06/14/2009 12:47 PM, Michael S. Tsirkin wrote:
> Michael S. Tsirkin wrote:
>>> If we want to remove a device from under a running guest, you need
>>> hotplug. So we can't just remove several lines from the config and hope
>>> that it'll work simply because the PCI address is stable.
>>>
>>>        
>> Why not?
>>      
>
> E.g. configuration cycles address a specific bus/slot.
> You need cooperation from guest if you want to move
> a device.
>    

By "remove several lines from the config" I understood the guest needs 
to be restarted.  Of course if you don't restart the guest you need true 
hotplug.

-- 
error compiling committee.c: too many arguments to function
