From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 17:34:06 +0300
Message-ID: <20090615143406.GA14405__13952.6974679486$1245076692$gmane$org@redhat.com>
References: <4A326C7E.3020309@codemonkey.ws> <1244822007.30522.68.camel@blaa>
	<4A327E87.6080005@codemonkey.ws>
	<1244825333.26769.20.camel@blaa> <4A34ADA9.80709@redhat.com>
	<1245056955.6891.33.camel@blaa> <4A36314A.8040206@redhat.com>
	<4A364316.5070402@codemonkey.ws> <1245074447.3222.53.camel@blaa>
	<4A365890.1050106@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A365890.1050106@codemonkey.ws>
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
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 15, 2009 at 09:20:00AM -0500, Anthony Liguori wrote:
> Mark McLoughlin wrote:
>> On Mon, 2009-06-15 at 07:48 -0500, Anthony Liguori wrote:
>>   
>>>> Eventually the default configuration becomes increasingly unusable 
>>>> and you need a new baseline.  You must still be able to fall back 
>>>> to the old baseline for older guests.  I don't think games with 
>>>> configuration files can hide that.
>>>>       
>>> -M pc1
>>> -M pc2
>>>
>>> etc.
>>>
>>> This is pretty easy to maintain with config files.
>>>     
>>
>> I think this would be reasonable, but it is essentially just a version
>> number which you objected to on the basis that it would make
>> cherry-picking harder for distros.
>>   
>
> It doesn't have to be pc1, pc2.  It could be pc-with-usb or  
> pc-with-balloon.  If a distro cherry picks in such a way that their pc  
> is not a standard QEMU pc, they would add a new PC type that's specific  
> to their distro.
>
>> One thing that would be nice with this '-M pc1' thing would be to retain
>> '-M pc' as a symlink to the latest version. We'd also need a way to read
>> the symlink too, so that you can query what the current latest version
>> is and use that in future.
>>   
>
> Another option is an explicit -M default which always uses the default  
> machine for the architecture.  Likewise, we would need a way to query  
> what the default machine was for an architecture.
>
>> How would this machine type version relate to e.g. changing the default
>> PCI class of virtio-blk? Would we bump the version number of all machine
>> types can use virtio-blk?
>>   
> You would introduce a new machine type.  For instance,  
> pc-virtio-class-other.  The names don't have to look like that, I'm just  
> doing that to make a point.  This may mean that you end up with dozens  
> of machine types but you preserve compatibility, which is a good thing.

And then pc-virtio-class-other-with-balloon-without-usb? Wouldn't it be
more straightforward to have capability bits which can be switched on
and off independently rather than trying to fit unrelated features into
a machine type?  IMO it only seems more work at first, and QA gets a bit
nervious that they can't exhaustively test all options. But in the long
run it simplifies things as you don't have to set policy and invent
silly names.

> Of course, the flip side is that you make preserving the machine config  
> the duty of the user and we don't maintain compatible machine types.   
> This won't work without a proper config file though so for now, we're  
> stuck maintaining machine types.
>
> Regards,
>
> Anthony Liguori
