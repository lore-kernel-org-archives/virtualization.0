From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Fri, 07 Jun 2013 11:28:04 +0930
Message-ID: <87obbir8b7.fsf@rustcorp.com.au>
References: <20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au> <20130603101136.GB8649@redhat.com>
	<87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com>
	<87li6obd2r.fsf@codemonkey.ws> <87y5anrjlf.fsf@rustcorp.com.au>
	<874ndbp9nf.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <874ndbp9nf.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <aliguori@us.ibm.com> writes:
> Hi Rusty,
>
> Rusty Russell <rusty@rustcorp.com.au> writes:
>
>> Anthony Liguori <aliguori@us.ibm.com> writes:
>>> 4) Do virtio-pcie, make it PCI-e friendly (drop the IO BAR completely), give
>>>    it a new device/vendor ID.   Continue to use virtio-pci for existing
>>>    devices potentially adding virtio-{net,blk,...}-pcie variants for
>>>    people that care to use them.
>>
>> Now you have a different compatibility problem; how do you know the
>> guest supports the new virtio-pcie net?
>
> We don't care.
>
> We would still use virtio-pci for existing devices.  Only new devices
> would use virtio-pcie.

My concern is that new features make the virtio-pcie driver so desirable
that libvirt is pressured to use it ASAP.  Have we just punted the
problem upstream?

(Of course, feature bits were supposed to avoid such a transition issue,
but mistakes accumulate).

Cheers,
Rusty.
