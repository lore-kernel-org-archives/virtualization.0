From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Sun, 24 May 2009 14:14:14 +0300
Message-ID: <4A192C06.3070603__25766.5533492856$1243163824$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>	<200905211423.20843.paul@codesourcery.com>	<20090521134650.GI25309@redhat.com>	<200905211453.14691.paul@codesourcery.com>
	<20090521140711.GJ25309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090521140711.GJ25309@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> kvm needs data on MSI entries: that's the interface
> current kernel exposes for injecting these interrupts.
>
> I think we also need to support in-kernel devices which
> would inject MSI interrupt directly from kernel.
> For these, kvm would need to know when mask bit changes
> and give us info on pending bit.
>
> That's a fair amount of PCI specific code in kvm

My plan is to get rid of it.  The mask stuff need not be pci specific.

-- 
error compiling committee.c: too many arguments to function
