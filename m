From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: pci: is reset incomplete?
Date: Mon, 14 Sep 2009 17:54:36 -0500
Message-ID: <4AAEC9AC.6080309__43504.2656412863$1252970514$gmane$org@codemonkey.ws>
References: <20090914154822.GA3745@redhat.com> <4AAE7A31.9080600@codemonkey.ws>
	<20090914173625.GA3859@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090914173625.GA3859@redhat.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> On Mon, Sep 14, 2009 at 12:15:29PM -0500, Anthony Liguori wrote:
>   
>> Michael S. Tsirkin wrote:
>>     
>>> Hi!
>>> pci bus reset does not seem to clear pci config registers, such as BAR
>>> registers, or memory space enable, of the attached devices: it only
>>> clears the interrupt state.
>>>
>>> This seems wrong, but easy to fix.
>>>   
>>>       
>> I don't think most pci devices reset their config space in their reset  
>> callbacks.
>>     
>
> For things like BAR registers, they really must.
>   

BARs should be registered via pci_register_bar so you should be able to 
centralize their reset.

> class codes are read only registers. Your proposal might be correct for
> some of these. But PCI registers that are reset, change as a result of
> guest activity, and reset values are typically specified by guest spec.
> So I don't think we should let users tweak these.
>   

Well, I guess my general point was that it would be good to add more 
structure to how config space is initialized.  I think a natural 
consequence of that is that it becomes easier to automatically fix the 
values on reset.

Regards,

Anthony Liguori
