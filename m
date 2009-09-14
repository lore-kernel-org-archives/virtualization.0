From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: pci: is reset incomplete?
Date: Mon, 14 Sep 2009 20:36:25 +0300
Message-ID: <20090914173625.GA3859__33662.1756469414$1252950097$gmane$org@redhat.com>
References: <20090914154822.GA3745@redhat.com> <4AAE7A31.9080600@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AAE7A31.9080600@codemonkey.ws>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 14, 2009 at 12:15:29PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> Hi!
>> pci bus reset does not seem to clear pci config registers, such as BAR
>> registers, or memory space enable, of the attached devices: it only
>> clears the interrupt state.
>>
>> This seems wrong, but easy to fix.
>>   
>
> I don't think most pci devices reset their config space in their reset  
> callbacks.

For things like BAR registers, they really must.
The PCI spec is quite specific on this point.

> I would think that making most of the config space (if not the entire)  
> qdev properties would make sense.  You can then get reset for free and  
> it's possible for users to tweak things like class codes universally.

class codes are read only registers. Your proposal might be correct for
some of these. But PCI registers that are reset, change as a result of
guest activity, and reset values are typically specified by guest spec.
So I don't think we should let users tweak these.

> Regards,
>
> Anthony Liguori
>
>> Comments?
>>
>>   
