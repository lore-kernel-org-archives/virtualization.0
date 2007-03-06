From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 09:03:53 -0600
Message-ID: <45ED82D9.6050204@codemonkey.ws>
References: <45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
	<20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de>
	<20070306093436.GA30239@elte.hu> <45ED3F29.6000705@suse.de>
	<20070306102658.GA7478@elte.hu> <45ED4AD8.6020504@suse.de>
	<20070306115937.GA25313@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306115937.GA25313@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Gerd Hoffmann <kraxel@suse.de> wrote:
> =

>>>> So in the end you would still have two different hypervisor ABI's, =

>>>> the VMI ROM just hides that.
>>> oh, but that way i have cleverly pushed the problem out of Linux and =

>>> into the VMI-ROM's domain ;) Which is all i care about.
>> Fine, so lets move kvm paravirtualitzation into vmi too (proof of =

>> concept code by Anthony Liguori exists) and kill one more item on the =

>> (linux) QA test matrix?  (just following your arguments, not that I'm =

>> confident it would actually help reducing QA effort).
> =

> yes - although obviously a KVM Linux guest does not need such an =

> interface - but it's a nice proof of concept to integrate other guest =

> OSs into KVM.

I disagree that a KVM Linux guest does not benefit from VMI.  Right now, =

your KVM paravirt interface only covers CR3 target caching and apic =

enhancements (neither of which I believe have made it into 2.6.21). =

Inevitably, things like MMU batching will be added.

Using paravirt_ops, this is going to require new kernels for the guests. =

  Every new paravirtualization feature will require a new guest kernel. =

  With VMI, one can add these features to any 2.6.21+ guest by just =

modifying the ROM (assuming a newer host).  Some features will require =

new VMI entry points but quite a lot will fall under the current entry =

points.

Of all the hypervisors, KVM is the easiest to use VMI with.  QEMU =

already supports option ROM loading and Zach just made some changes to =

allow a native ROM to be implemented very easily.

If we're going to use VMI for anything other than VMware, it seems to be =

that KVM should be what we use it for.

Regards,

Anthony Liguori

> 	Ingo
