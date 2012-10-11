From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Thu, 11 Oct 2012 11:13:25 +1030
Message-ID: <87ehl596tu.fsf__18238.6165172376$1349917866$gmane$org@rustcorp.com.au>
References: <87k3v1gfw1.fsf@codemonkey.ws> <507333F1.1060000@redhat.com>
	<874nm4u1in.fsf@codemonkey.ws> <87sj9o8qn7.fsf@rustcorp.com.au>
	<87sj9oh0pm.fsf@codemonkey.ws> <5073C52D.20802@redhat.com>
	<87wqyzll8r.fsf@codemonkey.ws> <507487F0.2050609@redhat.com>
	<87zk3v6npm.fsf@rustcorp.com.au> <87vceiih4j.fsf@codemonkey.ws>
	<20121010134157.GA7922@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121010134157.GA7922@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Wed, Oct 10, 2012 at 08:36:12AM -0500, Anthony Liguori wrote:
>> Rusty Russell <rusty@rustcorp.com.au> writes:
>> 
>> > Gerd Hoffmann <kraxel@redhat.com> writes:
>> >> So how about this:
>> >>
>> >> (1) Add a vendor specific pci capability for new-style virtio.
>> >>     Specifies the pci bar used for new-style virtio registers.
>> >>     Guests can use it to figure whenever new-style virtio is
>> >>     supported and to map the correct bar (which will probably
>> >>     be bar 1 in most cases).
>> >
>> > This was closer to the original proposal[1], which I really liked (you
>> > can layout bars however you want).  Anthony thought that vendor
>> > capabilities were a PCI-e feature, but it seems they're blessed in PCI
>> > 2.3.
>> 
>> 2.3 was standardized in 2002.  Are we confident that vendor extensions
>> play nice with pre-2.3 OSes like Win2k, WinXP, etc?

2.2 (1998) had the capability IDs linked list, indicated by bit 4 in the
status register, but reserved ids 7 and above.  ID 9 (vendor specific)
was added in 2.3; it should be ignored, but will require testing of
course, like any change.

2.1 didn't have the capability ID linked list at all; bit 4 in the
status register was reserved.

QEMU's pci.c has capability support, and sets the capabiliy status bit
and list pointer when the driver requests (eg. the eepro100).

> Pre 2.3 it was the case that *all* space outside
> the capability linked list, and any capability not
> recognized by space, was considered vendor specific.
> So there's no problem really.

Oh in theory, sure.  In practice, almost certainly.  But this needs to
be proved with actual testing.

Cheers,
Rusty.
