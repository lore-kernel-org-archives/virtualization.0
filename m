From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC] kvm tools: Add support for virtio-mmio
Date: Tue, 15 Nov 2011 20:14:04 +0200
Message-ID: <4EC2ABEC.1040007@redhat.com>
References: <1321375667-17284-1-git-send-email-levinsasha928@gmail.com>
	<CAFEAcA-2QGk_Y1R_FPrVRVGiP7KyQOuv0zubORm77cOoU_K6gQ@mail.gmail.com>
	<1321379773.3200.9.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321379773.3200.9.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Pawel Moll <pawel.moll@arm.com>, kvm@vger.kernel.org, asias.hejun@gmail.com, virtualization@lists.linux-foundation.org, penberg@kernel.org, gorcunov@gmail.com, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 11/15/2011 07:56 PM, Sasha Levin wrote:
> > 
> > This isn't a PCI device, so does it make sense to use a PCI vendor
> > ID here? The kernel doesn't check the vendor ID at the moment,
> > but presumably the idea of the field is to allow the kernel to
> > work around implementation bugs/blacklist/whatever if necessary.
> > If that's the theory then it would make more sense for QEMU and
> > kvm-tool to use IDs that say "this is the QEMU implementation"
> > and "this is the kvm-tool implementation".
> > 
> > (I picked 0x554D4551 for QEMU...)
> > 
> > -- PMM
>
> I just sheepishly filled in the only vendor ID I knew of in the virtio
> spec :)
>  
> Hmm... If thats the plan, it should probably be a virtio thing (not
> virtio-mmio specific).
>
> Either way, it could also use some clarification in the spec.

The spec only covers virtio-pci; this virtio-mmio is completely
unspec'ed.  IMO it's a timebomb waiting to explode.

-- 
error compiling committee.c: too many arguments to function
