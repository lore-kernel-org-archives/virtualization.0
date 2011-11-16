From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC] kvm tools: Add support for virtio-mmio
Date: Wed, 16 Nov 2011 15:30:21 +0200
Message-ID: <1321450221.3221.13.camel__12736.5343076692$1321450359$gmane$org@lappy>
References: <1321375667-17284-1-git-send-email-levinsasha928@gmail.com>
	<CAFEAcA-2QGk_Y1R_FPrVRVGiP7KyQOuv0zubORm77cOoU_K6gQ@mail.gmail.com>
	<1321379773.3200.9.camel@lappy>
	<1321449718.3137.258.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321449718.3137.258.camel@hornet.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "asias.hejun@gmail.com" <asias.hejun@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "penberg@kernel.org" <penberg@kernel.org>, "gorcunov@gmail.com" <gorcunov@gmail.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-11-16 at 13:21 +0000, Pawel Moll wrote:
> On Tue, 2011-11-15 at 17:56 +0000, Sasha Levin wrote:
> > Hmm... If thats the plan, it should probably be a virtio thing (not
> > virtio-mmio specific).
> > =

> > Either way, it could also use some clarification in the spec.
> =

> Well, the spec (p. 2.1) says: "The Subsystem Vendor ID should reflect
> the PCI Vendor ID of the environment (it's currently only used for
> informational purposes by the guest).". The fact is that all the current
> virtio drivers simply ignore this field. So unless this changes I simply
> have no idea how to describe that register. "Put anything there, no one
> cares"? "Write zero now, may change in future"? Any ideas welcomed.
> =

> Cheers!
> =

> Pawe=B3
> =

> PS. Thanks for defending my honour in the delayed-explosive-device
> thread ;-)

We can add an appendix to the virtio spec with known virtio subsystem
vendors, patch QEMU & KVM tool to pass that, and possibly modify the
QEMU related workarounds in the kernel to only do the workaround thing
if QEMU is set as the vendor.

-- =


Sasha.
