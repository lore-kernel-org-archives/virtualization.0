From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: RFC: vfio interface for platform devices (v2)
Date: Tue, 16 Jul 2013 15:25:38 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150364CF47@039-SN1MPN1-004.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E1503633DEF@039-SN1MPN1-004.039d.mgd.msft.net>
	<51D58A65.6060704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51D58A65.6060704@huawei.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mario Smarduch <mario.smarduch@huawei.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Bhushan Bharat-R65777 <R65777@freescale.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Mario Smarduch [mailto:mario.smarduch@huawei.com]
> Sent: Thursday, July 04, 2013 9:45 AM
> To: Yoder Stuart-B08248
> Cc: Alex Williamson; Alexander Graf; Wood Scott-B07421; kvm@vger.kernel.org list; Bhushan Bharat-R65777;
> kvm-ppc@vger.kernel.org; virtualization@lists.linux-foundation.org; Sethi Varun-B16395;
> kvmarm@lists.cs.columbia.edu
> Subject: Re: RFC: vfio interface for platform devices (v2)
> 
> 
> I'm having trouble understanding how this works where
> the Guest Device Model != Host. How do you inform the guest
> where the device is mapped in its physical address space,
> and handle GPA faults?

The vfio mechanisms just expose hardware to user space
and the user space app may or may not QEMU.  So there
may be no 'guest' at all.

The intent of this RFC is to provide enough info to user space so
an application can use the device, or in the case of QEMU expose
the device to a VM.  Platform devices are typically exposed via
the device tree and that is how I envision them being presented
to a guest.

Are there real cases you see where guest device model != host?
I don't envision ever presenting a platform device as a PCI device
or vise versa.

Stuart
