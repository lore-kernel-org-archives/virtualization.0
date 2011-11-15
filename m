From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC] kvm tools: Add support for virtio-mmio
Date: Tue, 15 Nov 2011 20:22:10 +0200
Message-ID: <1321381330.3200.12.camel@lappy>
References: <1321375667-17284-1-git-send-email-levinsasha928@gmail.com>
	<CAFEAcA-2QGk_Y1R_FPrVRVGiP7KyQOuv0zubORm77cOoU_K6gQ@mail.gmail.com>
	<1321379773.3200.9.camel@lappy>  <4EC2ABEC.1040007@redhat.com>
	<1321380834.3200.10.camel@lappy>  <4EC2AD09.2040000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4EC2AD09.2040000@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Pawel Moll <pawel.moll@arm.com>, kvm@vger.kernel.org, asias.hejun@gmail.com, virtualization@lists.linux-foundation.org, penberg@kernel.org, gorcunov@gmail.com, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-11-15 at 20:18 +0200, Avi Kivity wrote:
> On 11/15/2011 08:13 PM, Sasha Levin wrote:
> > > >  
> > > > Hmm... If thats the plan, it should probably be a virtio thing (not
> > > > virtio-mmio specific).
> > > >
> > > > Either way, it could also use some clarification in the spec.
> > > 
> > > The spec only covers virtio-pci; this virtio-mmio is completely
> > > unspec'ed.  IMO it's a timebomb waiting to explode.
> >
> > It is, look at Appendix X of the virtio-pci spec.
> >
> 
> Ah, okay, a pleasant surprise.  From a quick look, it seems okay, but I
> think endianness specification is missing.

Endianness is defined there simply as "The endianness of the registers
follows the native endianness of the Guest.", similarly to the
virtio-pci spec.

-- 

Sasha.
