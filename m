From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH (repost) RFC 2/2] virtio-pci: recall and return msix
	notifications on ISR read
Date: Thu, 03 Nov 2011 17:52:45 +0100
Message-ID: <4EB2C6DD.30702@siemens.com>
References: <cover.1320259840.git.mst@redhat.com>
	<6dc9aa9764b1cfddf557a98f269e0f7d31ce03ac.1320259840.git.mst@redhat.com>
	<4EB27E3F.2030503@siemens.com> <20111103120712.GE18296@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111103120712.GE18296@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Blue Swirl <blauwirbel@gmail.com>, Stefan Weil <weil@mail.berlios.de>, Avi Kivity <avi@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On 2011-11-03 13:07, Michael S. Tsirkin wrote:
> On Thu, Nov 03, 2011 at 12:42:55PM +0100, Jan Kiszka wrote:
>> On 2011-11-02 21:11, Michael S. Tsirkin wrote:
>>> MSIX spec requires that device can be operated with
>>> all vectors masked, by polling pending bits.
>>> Add APIs to recall an msix notification, and make polling
>>> mode possible in virtio-pci by clearing the
>>> pending bits and setting ISR appropriately on ISR read.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  hw/msix.c       |   26 ++++++++++++++++++++++++++
>>>  hw/msix.h       |    3 +++
>>>  hw/virtio-pci.c |   11 ++++++++++-
>>>  3 files changed, 39 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/hw/msix.c b/hw/msix.c
>>> index 63b41b9..fe967c9 100644
>>> --- a/hw/msix.c
>>> +++ b/hw/msix.c
>>> @@ -349,6 +349,32 @@ void msix_notify(PCIDevice *dev, unsigned vector)
>>>      stl_le_phys(address, data);
>>>  }
>>>  
>>> +/* Recall outstanding MSI-X notifications for a vector, if possible.
>>> + * Return true if any were outstanding. */
>>> +bool msix_recall(PCIDevice *dev, unsigned vector)
>>> +{
>>> +    bool ret;
>>> +    if (vector >= dev->msix_entries_nr)
>>> +        return false;
>>> +    ret = msix_is_pending(dev, vector);
>>> +    msix_clr_pending(dev, vector);
>>> +    return ret;
>>> +}
>>
>> I would prefer to have a single API instead to clarify the tight relation:
>>
>> bool msi[x]_set_notify(PCIDevice *dev, unsigned vector, unsigned level)
>>
>> Would return true for level=1 if the message was either sent directly or
>> queued (we could deliver false if it was already queued, but I see no
>> use case for this yet).
> 
> It's a matter of taste: some people like functions with flags, some
> prefer separate functions.  I really prefer two functions.
> 
> But I agree it woulkd be better to have a name that makes it clear that
> what we recall is a notification.
> msix_notify_queue/msix_notify_dequeue?

OK, that doesn't sound bad.

> 
> 
>> Also, I don't see the generic value of some msix_recall_all. I think
>> it's better handled in a single loop over all vectors at caller site,
>> clearing the individual interrupt reason bits on a per-vector basis
>> there. msix_recall_all is only useful in the virtio case where you have
>> one vector of reason A and all the rest of B. Once you had multiple
>> reason C vectors as well, it would not help anymore.
>>
>> Jan
> 
> The reason I wanted to have it is to reduce the overhead this adds:
> since PBA is packed, it's much faster to check whether any bits are set
> than by going through them all, one by one. Typically all PBA
> bits are clear ...
> 
> I agree it might not help non-virtio devices, but to me it looks like a
> harmless little helper - what's the issue with it?

*If* there is a noticeable performance gain, I'm fine with
msix_notify_dequeue_all (about how may vectors are we talking in the
vitio case?). But the code would be more regular the other way around.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux
