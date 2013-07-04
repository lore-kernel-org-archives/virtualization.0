From: Alexander Graf <agraf@suse.de>
Subject: Re: RFC: vfio interface for platform devices (v2)
Date: Thu, 4 Jul 2013 16:47:24 +0200
Message-ID: <2D4FD48F-4336-4125-861F-A0A73B9D5C00__14416.3700439551$1372949260$gmane$org@suse.de>
References: <9F6FE96B71CF29479FF1CDC8046E1503633DEF@039-SN1MPN1-004.039d.mgd.msft.net>
	<51D58A65.6060704@huawei.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51D58A65.6060704@huawei.com>
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
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Yoder Stuart-B08248 <B08248@freescale.com>, Bhushan Bharat-R65777 <R65777@freescale.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org


On 04.07.2013, at 16:44, Mario Smarduch wrote:

> 
> I'm having trouble understanding how this works where
> the Guest Device Model != Host. How do you inform the guest
> where the device is mapped in its physical address space,
> and handle GPA faults?

The same way as you would for emulated devices.


Alex
