From: Gregory Haskins <gregory.haskins.ml@gmail.com>
Subject: Re: Use of virtio device IDs
Date: Wed, 07 Nov 2007 15:38:58 -0500
Message-ID: <47322262.8000101__43079.0343940773$1194468107$gmane$org@gmail.com>
References: <4730A15A.6070001@us.ibm.com> <4730B753.2000901@us.ibm.com>
	<4731334A.6090405@gmail.com> <47314FBD.1070505@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47314FBD.1070505@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Gregory Haskins <gregory.haskins.ml@gmail.com>, Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> 
> I dislike strings.  They make it look as if you have a nice extensible
> interface, where in reality you have a poorly documented interface which
> leads to poor interoperability.

Its not really a full fledged interface, but rather just a simple id
mechanism.  A decentralized id mechanism with less administrative burden.

On the flip side, a centralized namespace has the advantage of
controlling collisions at the expense of administrative overhead.  After
designing systems both ways in the past, I prefer to reduce the admin
burden, but that is just me.


> PCI means that you can reuse all of the platform's infrastructure for
> irq allocation, discovery, device hotplug, and management.

Its tempting to use, yes.  However, most of that infrastructure is
completely inappropriate for a PV implementation, IMHO.  You are
probably better off designing something that is PV specific instead of
shoehorning it in to fit a different model (at least for the things I
have in mind).  Its not a heck of a lot of code to write a pv-centric
version of these facilities.

> You can write it for new guests but backporting it to older guests will be a
> huge task.
> 
> We will support non-pci for s390, but in order to support Windows and
> older Linux PCI is necessary.

I don't know if I would agree with "necessary".  "Easier" perhaps. ;) By
definition once you are PV you are hypervisor aware.  Now its just a
matter of plugging in the appropriate plumbing to bridge the hypervisor
to the guest-os.  Some might be easier than others, sure.  But all
should be extensible to a degree.

But I digress.  I haven't really had much of a chance to follow the
latest developments here as I have been lost in -rt land for a few
months now.  But I know Anthony and Rusty are top-notch, so I'm sure you
guys have it under control.  Hopefully, one day soon I will be able to
join you guys again (perhaps to the KVM team's dismay ;).

Regards,
-Greg
