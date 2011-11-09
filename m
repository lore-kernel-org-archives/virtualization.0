From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH RFC] virtio-spec: flexible configuration layout
Date: Wed, 9 Nov 2011 14:36:43 +0200 (EET)
Message-ID: <alpine.LFD.2.02.1111091434230.4936__27765.3446457864$1321323151$gmane$org@tux.localdomain>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com>
	<1320828366.31056.16.camel@lappy> <20111109101318.GB20612@redhat.com>
	<alpine.LFD.2.02.1111091421570.4936@tux.localdomain>
	<1320841683.31056.41.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1320841683.31056.41.camel@lappy>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, penberg@cs.helsinki.fi, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 9 Nov 2011, Sasha Levin wrote:
> They don't exist in kernel code either, for same reason as above.
>
> Nothing will break if we remove it since no one really used it, we were
> probably the first and only implementation of the spec which considered
> them :)

As long as we are able to run older versions of the KVM tool with newer 
kernels and vice versa, I see no reason why we can't drop 64-bit features 
from the KVM tool.

 			Pekka
