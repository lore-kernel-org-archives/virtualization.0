From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Mon, 30 Jun 2014 13:10:38 +0200
Message-ID: <874mz264b5.fsf__46815.6731724322$1404126658$gmane$org@blackfin.pond.sub.org>
References: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
	<53A00464.8090609@6wind.com> <53A00DEB.8030400@redhat.com>
	<20140618104849.GH14030@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140618104849.GH14030@stefanha-thinkpad.redhat.com> (Stefan
	Hajnoczi's message of "Wed, 18 Jun 2014 18:48:49 +0800")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, David Marchand <david.marchand@6wind.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Vincent JARDIN <vincent.jardin@6wind.com>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Jun 17, 2014 at 11:44:11AM +0200, Paolo Bonzini wrote:
>> Il 17/06/2014 11:03, David Marchand ha scritto:
>> >>Unless someone steps up and maintains ivshmem, I think it should be
>> >>deprecated and dropped from QEMU.
>> >
>> >Then I can maintain ivshmem for QEMU.
>> >If this is ok, I will send a patch for MAINTAINERS file.
>> 
>> Typically, adding yourself to maintainers is done only after having proved
>> your ability to be a maintainer. :)
>> 
>> So, let's stop talking and go back to code!  You can start doing what was
>> suggested elsewhere in the thread: get the server and uio driver merged into
>> the QEMU tree, document the protocol in docs/specs/ivshmem_device_spec.txt,
>> and start fixing bugs such as the ones that Markus reported.
>
> One more thing to add to the list:
>
> static void ivshmem_read(void *opaque, const uint8_t * buf, int flags)
>
> The "flags" argument should be "size".  Size should be checked before
> accessing buf.
>
> Please also see the bug fixes in the following unapplied patch:
> "[PATCH] ivshmem: fix potential OOB r/w access (#2)" by Sebastian Krahmer
> https://lists.gnu.org/archive/html/qemu-devel/2014-04/msg03538.html

Another one: most devices can be controlled via a dedicated
CONFIG_<DEVNAME>, but not ivshmem: it uses CONFIG_KVM and CONFIG_PCI.
Giving it its own CONFIG_IVSHMEM would be nice.
