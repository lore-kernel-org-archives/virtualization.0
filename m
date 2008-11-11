From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Tue, 11 Nov 2008 11:00:20 +0200
Message-ID: <491949A4.3060205@redhat.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<0199E0D51A61344794750DC57738F58E5E26F996C4@GVW1118EXC.americas.hpqcorp.net>
	<20081106180354.GA17429@kroah.com>
	<4916DB16.2040709@redhat.com> <20081109192505.GA3091@kroah.com>
	<49173BF0.5050506@redhat.com> <20081111060845.GB13025@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081111060845.GB13025@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "Chiang,
	Alexander" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:

  

>> arch/x86/kvm/vtd.c: iommu integration (allows assigning the device's memory 
>> resources)
>>     
>
> That file is not in 2.6.28-rc4 :(
>
>   

Sorry, was moved to virt/kvm/ for ia64's benefit.

>   
>> virt/kvm/irq*: interrupt redirection (allows assigning the device's 
>> interrupt resources)
>>     
>
> I only see virt/kvm/irq_comm.c in 2.6.28-rc4.
>
>   

kvm_main.c in that directory also has some related bits.

>> the rest (pci config space, pio redirection) are in userspace.
>>     
>
> So you don't need these pci core changes at all?
>
>   

Not beyond those required for SR-IOV and iommu support.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
