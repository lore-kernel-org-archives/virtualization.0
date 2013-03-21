From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 09:15:15 -0700
Message-ID: <514B3213.8070002@zytor.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-13-git-send-email-rusty@rustcorp.com.au>
	<20130321102814.GC30493@redhat.com>
	<514B188A.3030502@zytor.com> <20130321144330.GA1454@redhat.com>
	<514B1D25.9090206@zytor.com> <20130321151937.GB1454@redhat.com>
	<514B26BC.6010700@zytor.com> <20130321155810.GA1925@redhat.com>
	<514B2FA0.9000204@zytor.com> <20130321161143.GC1925@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130321161143.GC1925@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/21/2013 09:11 AM, Michael S. Tsirkin wrote:
>>
>> It is really, really, nasty, not to mention slow.
> 
> Almost everything we do is through DMA, except a single write
> to start transmit and a single read to clear interrupts. So all it means
> is we do 2 io writes or reads per packet instead of 1.  Seems harmless
> enough. A bit slower than native but should be good enough for
> BIOS.  Needs no resources at all.  Why nasty? What's not to like?
> 

Corner cases galore... including the statefulness and non-atomicity of
config space writes (MMCONFIG is obviously not an option here.)  It
requires a minimum of four operations to do it safely.

> 
> Thanks. Same place in latest 3.0:
> 	A PCI Express Endpoint must not depend on operating system allocation of
> 	I/O resources claimed through BAR(s).
> 	A PCI Express Endpoint must not generate I/O Requests.
> of course this only applies to express :)
> 

And it does... but it has implications for the OS resource manager that
if Linux violates, we need to fix it.  We should not fail a device in
generic code because an I/O BAR allocation fails.  The device driver may
opt to fail the allocation.

(Note that having an I/O BAR is not *generating* an I/O request.)

	-hpa
