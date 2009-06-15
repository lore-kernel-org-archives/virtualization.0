From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 16:09:15 +0300
Message-ID: <4A3647FB.9010808__8140.95064201883$1245071554$gmane$org@redhat.com>
References: <1244821292.30522.56.camel@blaa> <4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa> <20090614095016.GA7560@redhat.com>
	<1245056916.6891.31.camel@blaa> <4A3613EC.6030608@redhat.com>
	<20090615103249.GB6351@redhat.com> <4A363012.8050409@redhat.com>
	<20090615114858.GG6351@redhat.com> <4A3636FA.1040609@redhat.com>
	<20090615124101.GH6351@redhat.com> <4A364381.401@redhat.com>
	<4A364401.6010500@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A364401.6010500@codemonkey.ws>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/15/2009 03:52 PM, Anthony Liguori wrote:
> Avi Kivity wrote:
>> On 06/15/2009 03:41 PM, Michael S. Tsirkin wrote:
>>> We should just tell the user which slots are open.
>>>   This might be tricky if the config is passed in with the command line
>>> flags.
>>
>> qemu -show-available-pci-slots
>
> Why does the user care?
>
> Let QEMU allocate the PCI slot, then query it to see what slot it 
> assigned and remember that.

It's a roundabout way of doing things.

As an example, if you try to fit too many devices into the machine, you 
have to try to add all devices and watch for a qemu error.  If you know 
in advance how many slots you have, you never enter into that situation 
(and you need to show the limit to the user anyway).

>
> It's not a good idea to have management applications attempt to do PCI 
> slot allocation.  For instance, one day we may decide to make virtio 
> devices multi-function.

Non-virtio, as well.  But we can't make that the default, so the user 
will have to specify this anyway.

Given that you can't hotunplug individual functions, the user will have 
to specify exactly how functions are aggregated into devices.  My 
recommendation would be for a GUI to allow the user to select a 'quad 
port virtio NIC' or 'dual port virtio scsi controller' rather than 
trying to do anything automatic.

-- 
error compiling committee.c: too many arguments to function
