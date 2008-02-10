From: "ron minnich" <rminnich@gmail.com>
Subject: Re: [kvm-devel] [PATCH] virtio_ring: make structure defines packed
Date: Sat, 9 Feb 2008 22:32:08 -0800
Message-ID: <13426df10802092232w327a96f9ueca5370df826a674__40710.60563806$1202630642$gmane$org@mail.gmail.com>
References: <200802081401.21194.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200802081401.21194.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Feb 8, 2008 5:01 AM, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Currently the virtio_ring structure are not declared packed, but they
> describe an hardware like interface. We should not allow compilers to make
> alignments and optimizations that can be different between the guest and
> host compiler.
>
> I propose to declare all structures that are in shared memory as packed.
>
> Does anybody see a problem with packed?

yes, I see many problems with packed. We went through this discussion
already on another hypervisor several years ago.
They started out with packed and later dropped it. Packed doesn't
really solve any problems -- it just buries them somewhere.

The problem for me is that gcc packed is not compatible with the plan
9 C compiler. So, for a truly heterogeneous setup, you are going to
have
to have code to marshall the structures when transferring between
domains, and you are better off not trying to fake it with packed --
it can actually make the
marshalling less efficient.

Thanks

ron
