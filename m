From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 05 Jun 2013 17:08:49 -0500
Message-ID: <874ndcb47i.fsf@codemonkey.ws>
References: <20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au> <20130603101136.GB8649@redhat.com>
	<87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com>
	<51AFA92B.2030203@zytor.com> <87fvwwmdmf.fsf@codemonkey.ws>
	<51AFB3DD.1050902@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51AFB3DD.1050902@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 06/05/2013 02:50 PM, Anthony Liguori wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>> 
>>> On 06/05/2013 09:20 AM, Michael S. Tsirkin wrote:
>>>>
>>>> Spec says IO and memory can be enabled/disabled, separately.
>>>> PCI Express spec says devices should work without IO.
>>>>
>>>
>>> For "native endpoints".  Currently virtio would be a "legacy endpoint"
>>> which is quite correct -- it is compatible with a legacy interface.
>> 
>> Do legacy endpoints also use 4k for BARs?
>
> There are no 4K BARs.  In fact, I/O BARs are restricted by spec (there
> is no technical enforcement, however) to 256 bytes.
>
> The 4K come from the upstream bridge windows, which are only 4K granular
> (historic stuff from when bridges were assumed rare.)  However, there
> can be multiple devices, functions, and BARs inside that window.

Got it.

>
> The issue with PCIe is that each PCIe port is a bridge, so in reality
> there is only one real device per bus number.
>
>> If not, can't we use a new device id for native endpoints and call it a
>> day?  Legacy endpoints would continue using the existing BAR layout.
>
> Definitely an option.  However, we want to be able to boot from native
> devices, too, so having an I/O BAR (which would not be used by the OS
> driver) should still at the very least be an option.

What makes it so difficult to work with an MMIO bar for PCI-e?

With legacy PCI, tracking allocation of MMIO vs. PIO is pretty straight
forward.  Is there something special about PCI-e here?

Regards,

Anthony Liguori

>
> 	-hpa
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
