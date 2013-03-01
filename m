From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] virtio-spec: Define virtio-mmio registers as LE
Date: Fri, 01 Mar 2013 13:16:52 +0000
Message-ID: <5130AA44.7030902@arm.com>
References: <87wqubkalj.fsf@rustcorp.com.au>
	<1360839247-9131-1-git-send-email-pawel.moll@arm.com>
	<513085EA.8070007@arm.com> <1362135005.3052.26.camel@hornet>
	<51308F22.7040303@arm.com> <1362141432.3052.28.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362141432.3052.28.camel@hornet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <Pawel.Moll@arm.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/03/13 12:37, Pawel Moll wrote:
> On Fri, 2013-03-01 at 11:21 +0000, Marc Zyngier wrote:
>>> Having said that, Rusty was contemplating enforcing LE config space in
>>> the new PCI layout...
>>
>> I wouldn't complain about that, and would like to see a similar thing on
>> MMIO.
> 
> Wherever PCI goes, MMIO follows :-)

Sweet. Makes my life easier ;-).

>> Well, it was unclear enough for me to get confused... ;-) It would make
>> sense to have a wording similar to the one in the PCI section.
> 
> How about this?
> 
> 8<---------
> From a80f01f15397395a8fc49ef424a2d47c8be0937a Mon Sep 17 00:00:00 2001
> From: Pawel Moll <pawel.moll@arm.com>
> Date: Fri, 1 Mar 2013 12:35:06 +0000
> Subject: [PATCH] virtio-spec: Clarify virtio-mmio configuration space organisation
> 
> To clarify potential confusion regarding the configuration
> space organisation (endianness in particular) the spec
> should clearly state that it follows the PCI device behaviour.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Looks good to me!

	M.
-- 
Jazz is not dead. It just smells funny...
