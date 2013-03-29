From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Fri, 29 Mar 2013 09:14:14 +0100
Message-ID: <51554D56.5080004@redhat.com>
References: <8300718.16452772.1364465611936.JavaMail.root@redhat.com>
	<1364525606.10253.69.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364525606.10253.69.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Kevin O'Connor <kevin@koconnor.net>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 29/03/2013 03:53, Nicholas A. Bellinger ha scritto:
> On Thu, 2013-03-28 at 06:13 -0400, Paolo Bonzini wrote:
>>> I think it's the right thing to do, but maybe not the right place
>>> to do this, need to reset after all IO is done, before
>>> ring memory is write protected.
>>
>> Our emails are crossing each other unfortunately, but I want to
>> reinforce this: ring memory is not write protected.
> 
> Understood.  However, AFAICT the act of write protecting these ranges
> for ROM generates the offending callbacks to vhost_set_memory().
> 
> The part that I'm missing is if ring memory is not being write protected
> by make_bios_readonly_intel(), why are the vhost_set_memory() calls
> being invoked..?

Because mappings change for the region that contains the ring.  vhost
doesn't know yet that the changes do not affect ring memory,
vhost_set_memory() is called exactly to ascertain that.

Paolo

> 
>> Remember that
>> SeaBIOS can even provide virtio-scsi access to DOS, so you must
>> not reset the device.  It must remain functional all the time,
>> and the OS's own driver will reset it when it's started.
>>
> 
> Mmmm, so a vp_reset() is out of the question then..
> 
> --nab
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
